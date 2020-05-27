#import "Applesignin.h"
#import <React/RCTUtils.h>

@implementation Applesignin

-(dispatch_queue_t)methodQueue
{
    return dispatch_get_main_queue();
}

RCT_EXPORT_MODULE()

-(NSDictionary *)constantsToExport
{
    if (@available(iOS 13.0, *)) { // <=== add this
        NSDictionary* scopes = @{@"FULL_NAME": ASAuthorizationScopeFullName, @"EMAIL": ASAuthorizationScopeEmail};
        NSDictionary* operations = @{
            @"LOGIN": ASAuthorizationOperationLogin,
            @"REFRESH": ASAuthorizationOperationRefresh,
            @"LOGOUT": ASAuthorizationOperationLogout,
            @"IMPLICIT": ASAuthorizationOperationImplicit
        };
        NSDictionary* credentialStates = @{
            @"AUTHORIZED": @(ASAuthorizationAppleIDProviderCredentialAuthorized),
            @"REVOKED": @(ASAuthorizationAppleIDProviderCredentialRevoked),
            @"NOT_FOUND": @(ASAuthorizationAppleIDProviderCredentialNotFound),
        };
        NSDictionary* userDetectionStatuses = @{
            @"LIKELY_REAL": @(ASUserDetectionStatusLikelyReal),
            @"UNKNOWN": @(ASUserDetectionStatusUnknown),
            @"UNSUPPORTED": @(ASUserDetectionStatusUnsupported),
        };
        
        return @{
            @"Scope": scopes,
            @"Operation": operations,
            @"CredentialState": credentialStates,
            @"UserDetectionStatus": userDetectionStatuses
        };
    } else {// <== previous version
            // Fallback on earlier versions
        return @{};
    }
}


+ (BOOL)requiresMainQueueSetup
{
    return YES;
}


RCT_EXPORT_METHOD(requestAppleUser:(NSDictionary *)options
                  resolver:(RCTPromiseResolveBlock)resolve
                  rejecter:(RCTPromiseRejectBlock)reject)
{
    _promiseResolve = resolve;
    _promiseReject = reject;
    
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider* appleIDProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        ASAuthorizationAppleIDRequest* request = [appleIDProvider createRequest];
        request.requestedScopes = options[@"requestedScopes"];
        if (options[@"requestedOperation"]) {
            request.requestedOperation = options[@"requestedOperation"];
        }
        
        ASAuthorizationController* control = [[ASAuthorizationController alloc] initWithAuthorizationRequests:@[request]];
        control.presentationContextProvider = self;
        control.delegate = self;
        [control performRequests];
    }
    
}

RCT_EXPORT_METHOD(getCredentialStateForUser:
                  (NSString *) user
                  :(RCTPromiseResolveBlock) resolve
                  :(RCTPromiseRejectBlock) reject
                  ) {
    if (@available(iOS 13.0, *)) {
        ASAuthorizationAppleIDProvider *appleIdProvider = [[ASAuthorizationAppleIDProvider alloc] init];
        id completionBlock = ^(ASAuthorizationAppleIDProviderCredentialState credentialState, NSError *_Nullable error) {
            if (error) {
                return reject([@(error.code) stringValue], error.localizedDescription, error);
            } else {
                resolve(@(credentialState));
            }
        };
        [appleIdProvider getCredentialStateForUserID:user completion:completionBlock];
    }
    
}




-(ASPresentationAnchor)presentationAnchorForAuthorizationController:(ASAuthorizationController *)controller  API_AVAILABLE(ios(13.0)){
    return RCTKeyWindow();
}


- (void)authorizationController:(ASAuthorizationController *)controller
   didCompleteWithAuthorization:(ASAuthorization *)authorization  API_AVAILABLE(ios(13.0)){
    ASAuthorizationAppleIDCredential* credential = authorization.credential;
    NSString *identityToken;
    if ([credential valueForKey:@"identityToken"] != nil) {
        identityToken = [
                         [NSString alloc] initWithData:[credential valueForKey:@"identityToken"] encoding:NSUTF8StringEncoding
                         ];
    }
    
    NSString *authorizationCode;
    if ([credential valueForKey:@"authorizationCode"] != nil) {
        authorizationCode = [
                             [NSString alloc] initWithData:[credential valueForKey:@"authorizationCode"] encoding:NSUTF8StringEncoding
                             ];
    }
    
    NSMutableDictionary *fullName;
    if ([credential valueForKey:@"fullName"] != nil) {
        fullName = [[credential.fullName dictionaryWithValuesForKeys:@[
            @"namePrefix",
            @"givenName",
            @"middleName",
            @"familyName",
            @"nameSuffix",
            @"nickname",
        ]] mutableCopy];
        [fullName enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
            if (obj == nil) {
                fullName[key] = [NSNull null];
            }
        }];
    }
    NSDictionary* user = @{
        @"fullName": RCTNullIfNil(fullName),
        @"email": RCTNullIfNil(credential.email),
        @"user": credential.user,
        @"authorizedScopes": credential.authorizedScopes,
        @"realUserStatus": @(credential.realUserStatus),
        @"state": RCTNullIfNil(credential.state),
        @"authorizationCode": RCTNullIfNil(authorizationCode),
        @"identityToken": RCTNullIfNil(identityToken)
    };
    _promiseResolve(user);
}


-(void)authorizationController:(ASAuthorizationController *)controller
          didCompleteWithError:(NSError *)error  API_AVAILABLE(ios(13.0)){
    NSLog(@" Error code%@", error);
    _promiseReject(@"authorization", error.description, error);
}



@end

