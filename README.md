# react-native-applesignin
`react-native-applesignin`  npm module is used for authentication using Apple id in React Native apps. Apple sign-in only works with `IOS` platform .
## Getting started
To install the module, run the following command in your project directory:
`npm install @memorres/react-native-applesignin --save`
or
`yarn add @memorres/react-native-applesignin`
### Mostly automatic installation
`react-native link @memorres/react-native-applesignin`
### Manual installation
#### iOS
### Pods
1. Add the line below to your `Podfile`.
    ```pod
    pod 'react-native-applesignin', :path => '../node_modules/@memorres/react-native-applesignin'`
    ```
2. Run `pod install` in your iOS project directory.
### Manually
1. In XCode's project navigator, right click `Libraries` ➜ `Add Files to [your project's name]`
2. Go to `node_modules` ➜ `memorres`➜ `react-native-applesignin and select `Applesignin.xcodeproj`
4. Run your project (`Cmd+R`)
### Configure Project
1: Sign in with Apple is supportable from XCode 11 and iOS 13.
2: Add the Sign In with Apple capability in your project. This will add an entitlement that lets your app use Sign In with Apple.
3: Enable Sign in with Apple in your developer account. Go to “Certificates, Identifiers & Profile” section and then click on the “Keys” option. Click on “Create a key” option. Enter the name of the key and enable the “Sign in with Apple” option.
## Usage
```javascript
1. Button style and login process
import Applesignin, {
  AppleButtonBlackContinue,
  AppleButtonBlackSignin,
  AppleButtonWhiteContinue,
  AppleButtonWhiteSignin,
  DecodeToken,
} from 'react-native-applesignin';
export default class App extends React.Component{
  appleSignIn = (response) => {
    console.log(response);
  };
  render(){
    return(
    <View style = {styles.container}>
     {AppleButtonBlackContinue(styles.appleBtn,this.appleSignIn)}
    </View>)
  }
}
const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center'
  },
  appleBtn: { height: 44, width: 200 }
});
2: Create custom button
import Applesignin from 'react-native-applesignin';
   Applesignin.requestAppleUser({
    requestedScopes: [Applesignin.Scope.FULL_NAME, Applesignin.Scope.EMAIL],
    }).then((response) => {
        console.log(response) //Log response
    }, (error) => {
        console.log(error) //Log error
    });
3: Decode token
import Applesignin,{DecodeToken} from 'react-native-applesignin';
const decoded = DecodeToken(result.identityToken);
4: logout process
import Applesignin from 'react-native-applesignin';
try {
    const response = await Applesignin.requestAppleUser({
        requestedScopes: [Applesignin.Operation.LOGOUT
    });
    const credentialState = await Applesignin.getCredentialStateForUser(response.user);
}catch(error){
    console.log(error) //Log error
}
```
## FAQs
###### Why does full name and email return null?
------
Apple only returns the full name and email on the first login, it will return null on the succeeding login so you need to save those data.
For testing purposes, to be receive these again, go to your device settings; Settings > Apple ID, iCloud, iTunes & App Store > Password & Security > Apps Using Your Apple ID, tap on your app and tap Stop Using Apple ID. You can now sign-in again and you'll receive the full name and `email.