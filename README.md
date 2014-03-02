RFRateMe
========

RFRateMe will help you promote your iPhone/iPad app without irritating your users. It's very simple to install, use and configure (If you need to change the default behavior).


![RFRateMe](http://i.imgur.com/FppICdE.png)

How To Get Started
==================

1.  Drag and drop RFRateMe Class into your project.
2.  Drag and drop UIAlertView+NSCookbook Class into your project.
3.  `#import "RFRateMe.h"`
4.  Call the class method whenever you want to show the alert:
  
     `[RFRateMe showRateAlert];`

or you can also show the alert after X times of using the app by simply calling the following method in your appDelegate didFinishLaunchingWithOptions:

+(void)showRateAlertAfterTimesOpened:(int)times

      [RFRateMe showRateAlertAfterTimesOpened:3];
     
Features
========

- If the user chooses "Rate now" or "Never ask me again" alert won't be shown again.
- If the user chooses "Remind me later" they will get the alert after 3 (Default) days.

Configuration
=============

`#define kNumberOfDaysUntilShowAgain 3`

`#define kAppStoreAddress @"https://itunes.apple.com/us/app/jobsy/id687059035"`

`#define kAppName @"MyApp"`

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

