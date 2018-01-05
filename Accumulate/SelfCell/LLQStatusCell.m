//
//  LLQStatusCell.m
//  Accumulation
//
//  Created by sanjingrihua on 17/4/13.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQStatusCell.h"
#import "LLQStaus.h"
@interface LLQStatusCell()
@property(nonatomic,weak)UIImageView *headImg;
@property(nonatomic,weak)UILabel *nameLab;
@property(nonatomic,weak)UIImageView *vipImg;
@property(nonatomic,weak)UILabel *contentLab;
@property(nonatomic,weak)UIImageView *picImg;
@end

@implementation LLQStatusCell
BOOL isPic,isVip;
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        UIImageView *imgView = [[UIImageView alloc]init];
        imgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:imgView];
        self.headImg = imgView;
        
        UILabel *nameLab = [[UILabel alloc]init];
        nameLab.font = [UIFont systemFontOfSize:16];
        nameLab.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:nameLab];
        self.nameLab = nameLab;
        
        UIImageView *vipImg = [[UIImageView alloc]init];
        vipImg.backgroundColor = [UIColor orangeColor];
        vipImg.contentMode = UIViewContentModeCenter;
        [self.contentView addSubview:vipImg];
        self.vipImg = vipImg;
        
        UILabel *contentLab = [[UILabel alloc]init];
        contentLab.font = [UIFont systemFontOfSize:15];
        contentLab.numberOfLines = 0;
        [self.contentView addSubview:contentLab];
        self.contentLab = contentLab;
        
        UIImageView *picImg = [[UIImageView alloc]init];
        picImg.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:picImg];
        self.picImg = picImg;
    }
    return self;
}
-(void)layoutSubviews
{
    [super layoutSubviews];
    
    self.headImg.frame = self.status.headFram;
    self.nameLab.frame = self.status.nameFram;
    self.vipImg.frame = self.status.vipFram;
    self.contentLab.frame = self.status.contentFram;
    self.picImg.frame = self.status.picFram;
    
    if (!isVip) {
        self.vipImg.hidden = NO;
    }
    else{
        self.vipImg.hidden = YES;
    }
    
    if (!isPic) {
        self.picImg.hidden = NO;
    }
    else{
        self.picImg.hidden = YES;
    }
    
    CGFloat space = 10;
    CGFloat headX = space;
    CGFloat headY = space;
    CGFloat headWH = 30;
    self.headImg.frame = CGRectMake(headX, headY, headWH, headWH);
    

    NSString *nameStr = @"weljsdodsgogjdosgji";
    CGFloat nameX = CGRectGetMaxX(self.headImg.frame)+space;
    CGFloat nameY = headY;
    NSDictionary *nameAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
    CGSize nameSize = [nameStr sizeWithAttributes:nameAtt];
    CGFloat nameW = nameSize.width;
    CGFloat nameH = nameSize.height;
    self.nameLab.frame = CGRectMake(nameX, nameY, nameW, nameH);
    self.nameLab.text =  nameStr;
    
    if (!isVip) {
        isVip = !isVip;
        CGFloat vipX = CGRectGetMaxX(self.nameLab.frame) + space;
        //    CGFloat vipWH = 14;
        //    CGFloat vipY = nameY +(nameH-vipWH)*0.5;
        //    self.vipImg.frame = CGRectMake(vipX, vipY, vipWH, vipWH);
        CGFloat vipY = nameY;
        CGFloat vipW =14;
        CGFloat vipH =nameH;
        self.vipImg.frame = CGRectMake(vipX, vipY, vipW, vipH);
    
    }
    
    NSString *contentStr = @"weljsdodsgogjdosgjiweljsdodsgogjdosgjiweljsdodsgogjdosgjiweljsdodsgogjdosgji";
    CGFloat contentX = headX;
    CGFloat contentY = CGRectGetMaxX(self.headImg.frame)+space;
    CGFloat contentW = self.contentView.frame.size.width-space*2;
    NSDictionary *contentAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
//    CGFloat contentH = [nameStr sizeWithAttributes:contentAtt].height;
    CGSize contentSize = CGSizeMake(contentW, MAXFLOAT);
//    CGFloat contentH = [contentStr sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:contentSize].height;
    CGFloat contentH = [contentStr boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAtt context:nil].size.height;
    self.contentLab.frame = CGRectMake(contentX, contentY, contentW, contentH);
    self.contentLab.text = contentStr;
    
    CGFloat cellH = 0;
    if (!isPic) {
        isPic = !isPic;
        CGFloat picWH = 100;
        CGFloat picX = headX;
        CGFloat picY = CGRectGetMaxY(self.contentLab.frame)+space;
        self.picImg.frame = CGRectMake(picX, picY, picWH, picWH);
        cellH = CGRectGetMaxY(self.picImg.frame)+space;

    }
    else{
        cellH = CGRectGetMaxY(self.contentLab.frame)+space;
    }
    
    
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
