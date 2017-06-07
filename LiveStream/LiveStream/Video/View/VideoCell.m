//
//  VideoCell.m
//  LiveStream
//
//  Created by 赵博 on 17/4/19.
//  Copyright © 2017年 赵博. All rights reserved.
//

#import "VideoCell.h"
#import "VideoModel.h"

@interface VideoCell ()
{
    //头像
    __weak IBOutlet UIImageView *headImg;
    //昵称
    __weak IBOutlet UILabel *nameLabel;
    //定位
    __weak IBOutlet UILabel *loactionLabel;
    //人数
    __weak IBOutlet UILabel *peopleNum;
    //大图
    __weak IBOutlet UIImageView *bigImg;
}
@end

@implementation VideoCell
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (void)setReceiveModel:(VideoModel *)receiveModel{
    _receiveModel = receiveModel;
    [headImg sd_setImageWithURL:_receiveModel.smallpic placeholderImage:[UIImage imageNamed:@"placeholder_head"]];
    nameLabel.text =receiveModel.myname;
    // 如果没有地址, 给个默认的地址
    if (!receiveModel.gps.length) {
        receiveModel.gps = @"喵星";
    }
    loactionLabel.text = receiveModel.gps;
    [bigImg sd_setImageWithURL:[NSURL URLWithString:_receiveModel.bigpic] placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];

    peopleNum.text = [NSString stringWithFormat:@"%ld人在看", _receiveModel.allnum];

}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
