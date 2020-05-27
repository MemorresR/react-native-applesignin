#import <React/RCTViewManager.h>
#import <React/RCTUtils.h>
#import "RNSignInWithAppleButton.h"
@import AuthenticationServices;


#pragma mark - White - SignUp
@interface RNSignInWithAppleButtonWhiteSignIn : RCTViewManager
@end


@implementation RNSignInWithAppleButtonWhiteSignIn
RCT_EXPORT_MODULE(RNSignInWithAppleButtonWhiteSignIn)
- (UIView *)view
{
    return [[RNSignInWithAppleButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhite];
}
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)
@end



#pragma mark - White - Continue
@interface RNSignInWithAppleButtonWhiteContinue : RCTViewManager
@end

@implementation RNSignInWithAppleButtonWhiteContinue
RCT_EXPORT_MODULE(RNSignInWithAppleButtonWhiteContinue)
- (UIView *)view
{
    return [[RNSignInWithAppleButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeContinue authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleWhite];
}
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)
@end



#pragma mark - Black - Signin
@interface RNSignInWithAppleButtonBlackSignin : RCTViewManager
@end

@implementation RNSignInWithAppleButtonBlackSignin
RCT_EXPORT_MODULE(RNSignInWithAppleButtonBlackSignin)
- (UIView *)view
{
    return [[RNSignInWithAppleButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeSignIn authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
}
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)
@end



#pragma mark - Black - Continue
@interface RNSignInWithAppleButtonBlackContinue : RCTViewManager
@end


@implementation RNSignInWithAppleButtonBlackContinue
RCT_EXPORT_MODULE(RNSignInWithAppleButtonBlackContinue)
- (UIView *)view
{
    return [[RNSignInWithAppleButton alloc] initWithAuthorizationButtonType:ASAuthorizationAppleIDButtonTypeContinue authorizationButtonStyle:ASAuthorizationAppleIDButtonStyleBlack];
}
RCT_EXPORT_VIEW_PROPERTY(onPress, RCTBubblingEventBlock)
@end
