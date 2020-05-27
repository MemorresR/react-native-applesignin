import { NativeModules,requireNativeComponent ,Platform } from 'react-native';
import React, {Component} from 'react';
const { Applesignin } = NativeModules;
const jwtDecodeToken = require('jwt-decode');
export const SignInWithAppleButtonBlackContinue = requireNativeComponent('RNSignInWithAppleButtonBlackContinue');
export const SignInWithAppleButtonBlackSignin = requireNativeComponent('RNSignInWithAppleButtonBlackSignin');
export const SignInWithAppleButtonWhiteContinue = requireNativeComponent('RNSignInWithAppleButtonWhiteContinue');
export const SignInWithAppleButtonWhiteSignIn = requireNativeComponent('RNSignInWithAppleButtonWhiteSignIn');


export const AppleButtonBlackContinue = (buttonStyle, callBack) => {
  if(Platform.OS === 'ios'){
    return <SignInWithAppleButtonBlackContinue style={buttonStyle} onPress={async () => {
    
        await Applesignin.requestAppleUser({
          requestedScopes: [Applesignin.Scope.FULL_NAME, Applesignin.Scope.EMAIL],
        }).then((response) => {
          callBack(response) //Display response
          }, (error) => {
            callBack(error) //Display error
           
        });

  }} />
  }
}
export const AppleButtonBlackSignin = (buttonStyle, callBack) => {
  if(Platform.OS === 'ios'){
    return <SignInWithAppleButtonBlackSignin style={buttonStyle} onPress={async () => {
    
        await Applesignin.requestAppleUser({
          requestedScopes: [Applesignin.Scope.FULL_NAME, Applesignin.Scope.EMAIL],
        }).then((response) => {
          callBack(response) //Display response
          }, (error) => {
            callBack(error) //Display error
           
        });

  }} />
  }
}

export const AppleButtonWhiteContinue = (buttonStyle, callBack) => {
  if(Platform.OS === 'ios'){
    return <SignInWithAppleButtonWhiteContinue style={buttonStyle} onPress={async () => {
    
        await Applesignin.requestAppleUser({
          requestedScopes: [Applesignin.Scope.FULL_NAME, Applesignin.Scope.EMAIL],
        }).then((response) => {
          callBack(response) //Display response
          }, (error) => {
            callBack(error) //Display error
           
        });

  }} />
  }
}

export const AppleButtonWhiteSignin = (buttonStyle, callBack) => {
  if(Platform.OS === 'ios'){
    return <SignInWithAppleButtonWhiteSignIn style={buttonStyle} onPress={async () => {
    
        await Applesignin.requestAppleUser({
          requestedScopes: [Applesignin.Scope.FULL_NAME, Applesignin.Scope.EMAIL],
        }).then((response) => {
          callBack(response) //Display response
          }, (error) => {
            callBack(error) //Display error
           
        });

  }} />
  }
}

  export const DecodeToken = (token) => {

   return jwtDecodeToken(token)
     
  }


export default Applesignin;
