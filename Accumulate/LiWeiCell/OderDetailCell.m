//
//  OderDetailCell.m
//  Farmers
//
//  Created by 览山晓 on 16/10/31.
//  Copyright © 2016年 Farmers. All rights reserved.
//

#import "OderDetailCell.h"

@interface OderDetailCell ()
/**
 * 图片
 */
@property (nonatomic, weak, nullable) UIImageView *iconView;
/**
 *  名称
 */
@property (nonatomic, weak, nullable) UILabel *nameLabel;
/**
 *  促销
 */
@property (nonatomic, weak, nullable) UILabel *promoteLabel;
/**
 *  规格
 */
@property (nonatomic, weak, nullable) UILabel *normsLabel;
/**
 *  规格价钱
 */
@property (nonatomic, weak, nullable) UILabel *normsPriceLabel;
/**
 *  总数量
 */
@property (nonatomic, weak, nullable) UILabel *numberLabel;
@end

@implementation OderDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        //创建子控件
        [self setupChildControls];
    }
    return self;
}

- (void)setupChildControls {
    UIImageView *image = [[UIImageView alloc] init];
    image.image = [UIImage imageNamed:@"login_image"];
    [self addSubview:image];
    self.iconView = image;
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel sizeToFit];
    nameLabel.text = @"大白菜(24k纯金)";
    [nameLabel sizeToFit];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *promoteLabel = [[UILabel alloc] init];
    promoteLabel.font = [UIFont systemFontOfSize:13];
    promoteLabel.textColor = [UIColor whiteColor];
//    promoteLabel.backgroundColor = MainColor;
    promoteLabel.layer.masksToBounds = YES;
    promoteLabel.layer.cornerRadius = 4;
    promoteLabel.text = @"促";
    promoteLabel.textAlignment = NSTextAlignmentCenter;
    [promoteLabel sizeToFit];
    [self addSubview:promoteLabel];
    self.promoteLabel = promoteLabel;
    
    
    UILabel *normsLabel = [[UILabel alloc] init];
    [normsLabel sizeToFit];
    normsLabel.font = [UIFont systemFontOfSize:15];
//    normsLabel.textColor = MainColor;
    normsLabel.text = @"10/袋(10斤)";
    [self addSubview:normsLabel];
    self.normsLabel = normsLabel;
    
    UILabel *normsPriceLabel = [[UILabel alloc] init];
    normsPriceLabel.textColor = [UIColor darkGrayColor];
    normsPriceLabel.font = [UIFont systemFontOfSize:13];
    [normsPriceLabel sizeToFit];
    normsPriceLabel.text = @"每斤10.0元";
    [self addSubview:normsPriceLabel];
    self.normsPriceLabel = normsPriceLabel;
    
    UILabel *numberLabel = [[UILabel alloc] init];
    [numberLabel sizeToFit];
    numberLabel.font = [UIFont systemFontOfSize:15];
//    numberLabel.textColor = MainColor;
    numberLabel.text = @"x1";
    [self addSubview:numberLabel];
    self.numberLabel = numberLabel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    // masnory
    CGFloat margin = 10;
    
//    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.mas_left).offset (margin);
//        make.width.equalTo (@90);
//        make.height.equalTo (@90);
//        make.top.equalTo (self.mas_top).offset(margin);
//    }];
//    
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.iconView.mas_right).offset(margin);
//        make.top.equalTo (self.iconView.mas_top).offset (4);
//    }];
//    
//    [self.promoteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.nameLabel.mas_right).offset (2);
//        make.top.equalTo (self.nameLabel.mas_top).offset (0);
//    }];
//    
//    
//    [self.normsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.nameLabel.mas_left);
//        make.top.equalTo (self.nameLabel.mas_bottom).offset (14);
//    }];
//    
//    [self.normsPriceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.normsLabel.mas_left);
//        make.top.equalTo (self.normsLabel.mas_bottom).offset (14);
//    }];
//    
//    
//    [self.numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo (self.mas_right).offset (-margin);
//        make.top.equalTo (self.normsPriceLabel.mas_top);
//    }];
}

@end
