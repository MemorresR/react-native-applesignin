#import "RNSignInWithAppleButton.h"

@implementation RNSignInWithAppleButton

-(instancetype)initWithAuthorizationButtonType:(ASAuthorizationAppleIDButtonType)type authorizationButtonStyle:(ASAuthorizationAppleIDButtonStyle)style  API_AVAILABLE(ios(13.0)){
    RNSignInWithAppleButton* button;
    if (@available(iOS 13.0, *)) {
        button = [super initWithAuthorizationButtonType:type authorizationButtonStyle:style];
        [button addTarget:self
                action:@selector(onDidPress)
      forControlEvents:UIControlEventTouchUpInside];
       
    }
     return button;
}

-(void)onDidPress {
  _onPress(nil);
}
@end
