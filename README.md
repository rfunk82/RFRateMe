RFRateMe
========

RFRateMe will help you promote your iPhone/iPad app without irritating your users. It's very simple to install, use and configure (If you need to change the default behavior).


![RFRateMe](http://i.imgur.com/FppICdE.png)

How To Get Started
==================

1.  `#import "RFRateMe.h"`
2.  Call the class method whenever you want to show the alert:
  
     `[RFRateMe showRateAlert];`

or you can also show the alert after X times of using the app by simply calling the following method in your appDelegate didFinishLaunchingWithOptions:

+(void)showRateAlertAfterTimesOpened:(int)times

      [RFRateMe showRateAlertAfterTimesOpened:3];
      
or you can also show the alert after X days of using the app by simply calling the following method in your appDelegate didFinishLaunchingWithOptions:

+(void)showRateAlertAfterDays:(int)days;

      [RFRateMe showRateAlertAfterDays:7];
      
     
Features
========

- If the user chooses "Rate now" or "Never ask me again" alert won't be shown again.
- If the user chooses "Remind me later" they will get the alert after 3 (Default) days.

Configuration
=============

You should add the following lines into your application `*.plist` file:

```
<key>RFRateAlertSettings</key>
<dict>
    <key>RFRateAlertButtons</key>
    <dict>
        <key>RFCancelButtonTitle</key>
        <string>No, thanks</string>
        
        <key>RFLaterButtonTitle</key>
        <string>Remind me later</string>
        
        <key>RFRateButtonTitle</key>
        <string>Rate now</string>
    </dict>
    
    <key>RFNumberOfDaysUntilShowing</key>
    <integer>3</integer>
    
    <key>RFAppStoreApplicationURL</key>
    <string>https://your.app.url</string>
    
    <key>RFRateAlertMessage</key>
    <string>If you like $(PRODUCT_NAME), please rate it</string>
    
    <key>RFRateAlertTitle</key>
    <string>$(PRODUCT_NAME)</string>
</dict>
```

![Info.plist](https://i.imgur.com/FsrMjHa.png)

Podfile
=======

```
pod 'RFRateMe'
```

Created By
==========

Ricardo Funk ([@rfunk82](http://www.twitter.com/rfunk82))

UIAlertView+NSCookbook Provided by NSCookbook

License
=======

> This is licensed under an MIT License:

> Copyright (c) 2013 Ricardo Funk

> Permission is hereby granted, free of charge, to any person obtaining a
copy of this software and associated documentation files (the "Software"),
to deal in the Software without restriction, including without limitation
the rights to use, copy, modify, merge, publish, distribute, sublicense,
and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

> The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

> THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
DEALINGS IN THE SOFTWARE.

