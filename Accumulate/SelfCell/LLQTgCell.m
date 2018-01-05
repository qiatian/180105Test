//
//  LLQTgCell.m
//  Accumulation
//
//  Created by sanjingrihua on 17/4/12.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQTgCell.h"
#import "Masonry.h"
@interface LLQTgCell()
//图标
@property(nonatomic,weak)UIImageView *imgView;
@property(nonatomic,weak)UILabel *titleLab;
@property(nonatomic,weak)UILabel *priceLab;
@property(nonatomic,weak)UILabel *buyCountLab;
@end
@implementation LLQTgCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        CGFloat space = 10;
        UIImageView *iconImgView = [[UIImageView alloc]init];
        iconImgView.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:iconImgView];
        self.imgView = iconImgView;
        [iconImgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(space);
            make.left.equalTo(self.contentView).offset(space);
            make.bottom.equalTo(self.contentView).offset(-space);
            make.width.mas_equalTo(80);
        }];
        
        
        UILabel *titleLab = [[UILabel alloc]init];
        titleLab.backgroundColor = [UIColor blueColor];
        [self.contentView addSubview:titleLab];
        self.titleLab = titleLab;
        [titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.imgView.mas_right).offset(space);
            make.top.equalTo(self.contentView).offset(space);
            make.right.equalTo(self.contentView).offset(-space);
            make.height.mas_equalTo(20);
            
        }];
        
        
        UILabel *priceLab = [[UILabel alloc]init];
        [self.contentView addSubview:priceLab];
        priceLab.backgroundColor = [UIColor orangeColor];
        self.priceLab = priceLab;
        [priceLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(iconImgView.mas_right).offset(space);
            make.bottom.equalTo(iconImgView.mas_bottom);
//            make.width.mas_equalTo(100);
//            make.height.mas_equalTo(20);
            make.size.mas_equalTo(CGSizeMake(100, 20));
        }];
        
        UILabel *buyCountLab = [[UILabel alloc]init];
        buyCountLab.backgroundColor = [UIColor purpleColor];
        [self.contentView addSubview:buyCountLab];
        self.buyCountLab = buyCountLab;
        [buyCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-space);
            make.bottom.equalTo(iconImgView.mas_bottom);
            make.left.equalTo(priceLab.mas_right).offset(space);
            make.height.mas_equalTo(20);
        }];
        
        
        
    }
    return self;
}
//-(instancetype)initWithFrame:(CGRect)frame  不调用
//{
//    if (self = [super initWithFrame:frame]) {
//        NSLog(@"initWithFrame");
//    }
//    return self;
//}
//设置所有子控件的frame
/*
-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat space = 10;
    
    CGFloat imgX = space;
    CGFloat imgY = space;
    CGFloat imgW = 80;
    CGFloat imgH = self.contentView.frame.size.height-2*space;
    self.imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
   
    
//    CGFloat titleX = imgX + imgW + space;
    CGFloat titleX = CGRectGetMaxX(self.imgView.frame) + space;
    CGFloat titleY = imgY;
//    CGFloat titleW = self.contentView.frame.size.width - titleX -space;
    CGFloat titleW = CGRectGetWidth(self.contentView.frame) - titleX -space;
    CGFloat titleH = 20;
    self.titleLab.frame = CGRectMake(titleX, titleY, titleW, titleH);
    
    
    CGFloat priceX = titleX;
    CGFloat priceW = 100;
    CGFloat priceH = 20;
//    CGFloat priceY = imgY +imgH -priceH;
    CGFloat priceY = CGRectGetMaxX(self.imgView.frame) -priceH;
    self.priceLab.frame = CGRectMake(priceX, priceY, priceW, priceH);
  
    
    
    CGFloat buyW = 150;
    CGFloat buyH = 20;
    CGFloat buyX = self.contentView.frame.size.width - space -buyW;
//    CGFloat buyY = imgY +imgH -buyH;
    CGFloat buyY = CGRectGetMaxX(self.imgView.frame) -buyH;
    self.buyCountLab.frame = CGRectMake(buyX, buyY, buyW, buyH);
}
//
 */
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
