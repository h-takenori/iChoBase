#iChoBase
iChoBaseはObjective-c言語向けのキーバリューストアです。
SQLiteのO/Rマッパーで、簡単に値の読取り、保存が出来ます。

This is an Objective-C Key-Value-Store around SQLite http://www.sqlite.org/

iChobaseはFMDBを利用しています。
iChoBase is reference to FMDB https://github.com/ccgus/fmdb

#Usage

##Install
全てのソースファイルとヘッダファイルをコピーして下さい。
プロジェクトにSQLiteを参照して下さい。(libsqlite3.dylib).

Copy all source and header files (*.h *.m) to your project.
And reference SQLite library (libsqlite3.dylib).

##Init
使用するソースからchobase.hをincludeして下さい。
その後、アクセス用のインスタンスを生成します。
初回起動時、データベースを自動的に作成します。
また、シングルトン生成されますので、コネクションやインスタンス数を気にする必要はありません。

	ChoBase* choBase = [ChoBase cb];


Before you access to iChoBase , you need to create iChoBase Instance.
It is Singleton object.
If it is the first time to create , table is auto generated.

	ChoBase* choBase = [ChoBase cb];



##Add string value with sey
値をセットする場合、以下のようにメソッドを読んで下さい。
You add values to iChoBase with the instance.

	//Set NSString. 
	//NSString型の値を設定する。
	[choBase setS:@"string value" key:@"string_key"];
	
	//Another 
	//以下のように記載することも出来ます。
	[[ChoBase cb] set:@"string value" key:@"string_key"];


##Get string value by key
	//値を取得します。
	NSString *str = [choBase s:@"string_key"];

##Delete value by key
	//キーから、値を削除します。
	BOOL result = [choBase del:@"key"];


##Check key is Exist?
	//キーの有無をチェックします。
	BOOL b = [choBase hasKey:@"string_key"];

##Any value types
	//int value
	//int型の値の設定・取得も可能です。
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
