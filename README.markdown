#iChoBase
This is an Objective-C Key-Value-Store around SQLite http://www.sqlite.org/
iChoBase is reference to FMDB https://github.com/ccgus/fmdb

#Usage

##Install
Copy all source and header files (*.h *.m) to your project.
And reference SQLite library (libsqlite3.dylib).

##Init
Before you access to iChoBase , you need to create iChoBase Instance.
It is Singleton object.
If it is the first time to create , table is auto generated.

	ChoBase* choBase = [ChoBase cb];

##Add string value with sey
You add values to iChoBase with the instance.

	//Set NSString. 
	[choBase setS:@"string value" key:@"string_key"];
	
	//Another 
	[[ChoBase cb] set:@"string value" key:@"string_key"];


##Get string value by key
	NSString *str = [choBase s:@"string_key"];

##Delete value by key
	BOOL result = [choBase del:@"key"];


##Check key is Exist?
	BOOL b = [choBase hasKey:@"string_key"];

##Any value types
	//int value
	[choBase setI:2012 key:"@int_key"];
	int i = [choBase i:@"int_key];

	//CGPoint Value
	[choBase setPoint:CGPointMake(10,20) key:"@point_key"];
	CGPoint point = [choBase point:@"point_key];

#Licence

##The MIT License (MIT)
Copyright (c) Takenori Hirao @ AncouApp

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
