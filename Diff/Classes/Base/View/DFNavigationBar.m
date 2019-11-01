//
//  CANavigationBar.m
//  Chasing Alpha
//
//  Created by fengj on 2018/8/21.
//  Copyright © 2018年 gelonghui. All rights reserved.
//

#import "DFNavigationBar.h"

@interface NSMethodSignature (QMUI)
@end

@implementation NSMethodSignature (QMUI)

+ (NSMethodSignature *)qmui_avoidExceptionSignature {
    // https://github.com/facebookarchive/AsyncDisplayKit/pull/1562
    // Unfortunately, in order to get this object to work properly, the use of a method which creates an NSMethodSignature
    // from a C string. -methodSignatureForSelector is called when a compiled definition for the selector cannot be found.
    // This is the place where we have to create our own dud NSMethodSignature. This is necessary because if this method
    // returns nil, a selector not found exception is raised. The string argument to -signatureWithObjCTypes: outlines
    // the return type and arguments to the message. To return a dud NSMethodSignature, pretty much any signature will
    // suffice. Since the -forwardInvocation call will do nothing if the delegate does not respond to the selector,
    // the dud NSMethodSignature simply gets us around the exception.
    return [NSMethodSignature signatureWithObjCTypes:"@^v^c"];
}

- (NSString *)qmui_typeString {
    NSString *typeString = [self performSelector:NSSelectorFromString([NSString stringWithFormat:@"_%@String", @"type"])];
    return typeString;
}

- (const char *)qmui_typeEncoding {
    return self.qmui_typeString.UTF8String;
}
@end

@implementation DFNavigationBar

+ (void)load {
    if (@available(iOS 11, *)) {
        
        NSString *barContentViewString = [NSString stringWithFormat:@"_%@Content%@", @"UINavigationBar", @"View"];
        
        OverrideImplementation(NSClassFromString(barContentViewString), @selector(directionalLayoutMargins), ^id(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void)) {
            return ^NSDirectionalEdgeInsets(UIView *selfObject) {
                
                // call super
                NSDirectionalEdgeInsets (*originSelectorIMP)(id, SEL);
                originSelectorIMP = (NSDirectionalEdgeInsets (*)(id, SEL))originalIMPProvider();
                NSDirectionalEdgeInsets originResult = originSelectorIMP(selfObject, originCMD);
                
                // get navbar
                UINavigationBar *navBar = nil;
                if ([NSStringFromClass([selfObject class]) isEqualToString:barContentViewString] &&
                    [selfObject.superview isKindOfClass:[UINavigationBar class]]) {
                    navBar = (UINavigationBar *)selfObject.superview;
                }
                
                // change insets
                if (navBar) {
                    NSDirectionalEdgeInsets value = originResult;
                    //value.leading = value.trailing - (navBar.qmui_customizingBackBarButtonItem ? 8 : 0);
                    return NSDirectionalEdgeInsetsMake(0, 0, 0, 0);
                }
                
                return originResult;
            };
        });
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    //iOS13后 不能修改私有属性
//    if (@available(iOS 11, *)) {
//        self.layoutMargins = UIEdgeInsetsZero;
//
//        for (UIView *subview in self.subviews) {
//            if ([NSStringFromClass([subview class]) containsString:@"ContentView"]) {
//                subview.layoutMargins = UIEdgeInsetsZero;
//            }
//        }
//    }
     
}

#pragma mark - utils

/**
 *  用 block 重写某个 class 的指定方法
 *  @param targetClass 要重写的 class
 *  @param targetSelector 要重写的 class 里的实例方法，注意如果该方法不存在于 targetClass 里，则什么都不做
 *  @param implementationBlock 该 block 必须返回一个 block，返回的 block 将被当成 targetSelector 的新实现，所以要在内部自己处理对 super 的调用，以及对当前调用方法的 self 的 class 的保护判断（因为如果 targetClass 的 targetSelector 是继承自父类的，targetClass 内部并没有重写这个方法，则我们这个函数最终重写的其实是父类的 targetSelector，所以会产生预期之外的 class 的影响，例如 targetClass 传进来  UIButton.class，则最终可能会影响到 UIView.class），implementationBlock 的参数里第一个为你要修改的 class，也即等同于 targetClass，第二个参数为你要修改的 selector，也即等同于 targetSelector，第三个参数是一个 block，用于获取 targetSelector 原本的实现，由于 IMP 可以直接当成 C 函数调用，所以可利用它来实现“调用 super”的效果，但由于 targetSelector 的参数个数、参数类型、返回值类型，都会影响 IMP 的调用写法，所以这个调用只能由业务自己写。
 */
CG_INLINE BOOL
OverrideImplementation(Class targetClass, SEL targetSelector, id (^implementationBlock)(__unsafe_unretained Class originClass, SEL originCMD, IMP (^originalIMPProvider)(void))) {
    Method originMethod = class_getInstanceMethod(targetClass, targetSelector);
    IMP imp = method_getImplementation(originMethod);
    BOOL hasOverride = HasOverrideSuperclassMethod(targetClass, targetSelector);
    
    // 以 block 的方式达到实时获取初始方法的 IMP 的目的，从而避免先 swizzle 了 subclass 的方法，再 swizzle superclass 的方法，会发现前者的方法调用不会触发后者 swizzle 后的版本的 bug。
    IMP (^originalIMPProvider)(void) = ^IMP(void) {
        IMP result = NULL;
        // 如果原本 class 就没人实现那个方法，则返回一个空 block，空 block 虽然没有参数列表，但在业务那边被转换成 IMP 后就算传多个参数进来也不会 crash
        if (!imp) {
            result = imp_implementationWithBlock(^(id selfObject){
            });
        } else {
            if (hasOverride) {
                result = imp;
            } else {
                Class superclass = class_getSuperclass(targetClass);
                result = class_getMethodImplementation(superclass, targetSelector);
            }
        }
        
        return result;
    };
    
    if (hasOverride) {
        method_setImplementation(originMethod, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originalIMPProvider)));
    } else {
        const char *typeEncoding = method_getTypeEncoding(originMethod) ?: [targetClass instanceMethodSignatureForSelector:targetSelector].qmui_typeEncoding;
        class_addMethod(targetClass, targetSelector, imp_implementationWithBlock(implementationBlock(targetClass, targetSelector, originalIMPProvider)), typeEncoding);
    }
    
    return YES;
}

CG_INLINE BOOL
HasOverrideSuperclassMethod(Class targetClass, SEL targetSelector) {
    Method method = class_getInstanceMethod(targetClass, targetSelector);
    if (!method) return NO;
    
    Method methodOfSuperclass = class_getInstanceMethod(class_getSuperclass(targetClass), targetSelector);
    if (!methodOfSuperclass) return YES;
    
    return method != methodOfSuperclass;
}

@end
