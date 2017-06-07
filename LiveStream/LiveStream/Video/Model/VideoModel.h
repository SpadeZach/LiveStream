//
//  VideoModel.h
//  LiveStream
//
//  Created by 赵博 on 17/4/19.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject
//allnum = 11114;
//bigpic = "http://liveimg.9158.com/pic/avator/2017-03/25/23/20170325234722_66309265_640.png";
//curexp = 0;
//distance = 0;
//familyName = "";
//flv = "http://hdl.9158.com/live/865de6bfb4e4d753361e933d164b2d56.flv";
//gender = 0;
//gps = "\U4e5d\U6c5f\U5e02";
//grade = 0;
//isSign = 0;
//level = 0;
//myname = "\U6ef4\U601d\U9e45\U7834\U56e0\U633a\Ud83e\Udd15";
//nation = "";
//nationFlag = "";
//pos = 1;
//roomid = 66377878;
//serverid = 12;
//signatures = "\U4e0d\U9ad8\U5174";
//smallpic = "http://liveimg.9158.com/pic/avator/2017-03/25/23/20170325234722_66309265_250.png";
//starlevel = 2;
//userId = QQ26102777;
//useridx = 66309265;

@property(nonatomic, assign) NSUInteger allnum;
@property(nonatomic, retain) NSString *bigpic;
@property(nonatomic, retain) NSString *curexp;
@property(nonatomic, retain) NSString *distance;
@property(nonatomic, retain) NSString *familyName;
@property(nonatomic, retain) NSString *flv;
@property(nonatomic, retain) NSString *gender;
@property(nonatomic, retain) NSString *gps;
@property(nonatomic, retain) NSString *grade;
@property(nonatomic, retain) NSString *isSign;
@property(nonatomic, retain) NSString *level;
@property(nonatomic, retain) NSString *myname;
@property(nonatomic, retain) NSString *nation;
@property(nonatomic, retain) NSString *pos;
@property(nonatomic, retain) NSString *roomid;
@property(nonatomic, retain) NSString *serverid;
@property(nonatomic, retain) NSString *signatures;
@property(nonatomic, retain) NSURL *smallpic;
@property(nonatomic, retain) NSString *starlevel;
@property(nonatomic, retain) NSString *userId;
@property(nonatomic, retain) NSString *useridx;
@property(nonatomic, retain) NSString *nationFlag;
@property(nonatomic, retain) NSString *realuidx;
@property(nonatomic, retain) NSString *gameid;
- initWidthDictionary:(NSDictionary*)dic;
@end
