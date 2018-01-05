//
//  LLQTopCell.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/3.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQTopCell.h"

@implementation LLQTopCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //增加顶部控件
        
        //增加底部控件
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    //设置顶部和底部控件的frame
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 10;
    frame.origin.x += 10;
    frame.size.width -= 20;
    [super setFrame:frame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
