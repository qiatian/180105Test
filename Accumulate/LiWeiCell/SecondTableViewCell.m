//
//  SecondTableViewCell.m
//  Farmers
//
//  Created by 览山晓 on 16/10/31.
//  Copyright © 2016年 Farmers. All rights reserved.
//

#import "SecondTableViewCell.h"



@interface SecondTableViewCell ()
/** 下单商品总额 **/
@property (nonatomic, weak, nullable) UILabel *nameLabel;
/** 下单商品总额价钱 **/
@property (nonatomic, weak, nullable) UILabel *namePrice;
/** 优惠减免 **/
@property (nonatomic, weak, nullable) UILabel *preferentialLabel;
/** 优惠减免价钱 **/
@property (nonatomic, weak, nullable) UILabel *preferentialPrice;
/** 溢出费用 **/
@property (nonatomic, weak, nullable) UILabel *overflowLabel;
/** 溢出费用价钱 **/
@property (nonatomic, weak, nullable) UILabel *overflowPrice;
/** 分割线 **/
@property (nonatomic, weak, nullable) UILabel *lineLabel;
/** 订单金额 **/
@property (nonatomic, weak, nullable) UILabel *orderLabel;
/** 订单金额价钱 **/
@property (nonatomic, weak, nullable) UILabel *orderPrice;
/** 备注 **/
@property (nonatomic, weak, nullable) UILabel *noteLabel;
@end

@implementation SecondTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        // 创建子控件
        [self setupChildControls];
    }
    return self;
}

// 创建子控件
- (void)setupChildControls {
    UILabel *nameLabel = [[UILabel alloc] init];
//    nameLabel.textColor = RGBColorA(85, 85, 85, 1);
    [nameLabel sizeToFit];
    nameLabel.text = @"下单商品总额:";
    [nameLabel sizeToFit];
    nameLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:nameLabel];
    self.nameLabel = nameLabel;
    
    UILabel *namePrice = [[UILabel alloc] init];
//    namePrice.textColor = RGBColorA(85, 85, 85, 1);
    [namePrice sizeToFit];
    namePrice.text = @"¥58.66";
    [namePrice sizeToFit];
    namePrice.font = [UIFont systemFontOfSize:15];
    [self addSubview:namePrice];
    self.namePrice = namePrice;

    
    UILabel *preferentialLabel = [[UILabel alloc] init];
//    preferentialLabel.textColor = RGBColorA(85, 85, 85, 1);
    [preferentialLabel sizeToFit];
    preferentialLabel.text = @"优惠减免:";
    [preferentialLabel sizeToFit];
    preferentialLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:preferentialLabel];
    self.preferentialLabel = preferentialLabel;

    
    UILabel *preferentialPrice = [[UILabel alloc] init];
//    preferentialPrice.textColor = RGBColorA(85, 85, 85, 1);
    [preferentialPrice sizeToFit];
    preferentialPrice.text = @"-¥0.00";
    [preferentialPrice sizeToFit];
    preferentialPrice.font = [UIFont systemFontOfSize:15];
    [self addSubview:preferentialPrice];
    self.preferentialPrice = preferentialPrice;

    
    UILabel *overflowLabel = [[UILabel alloc] init];
//    overflowLabel.textColor = RGBColorA(85, 85, 85, 1);
    [overflowLabel sizeToFit];
    overflowLabel.text = @"溢出费用:";
    [overflowLabel sizeToFit];
    overflowLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:overflowLabel];
    self.overflowLabel = overflowLabel;

    
    UILabel *overflowPrice = [[UILabel alloc] init];
//    overflowPrice.textColor = RGBColorA(85, 85, 85, 1);
    [overflowPrice sizeToFit];
    overflowPrice.text = @"113.55 (20%)";
    [overflowPrice sizeToFit];
    overflowPrice.font = [UIFont systemFontOfSize:15];
    [self addSubview:overflowPrice];
    self.overflowPrice = overflowPrice;

    
    UILabel *lineLabel = [[UILabel alloc] init];
//    lineLabel.backgroundColor = RGBColorA(167, 167, 167, 1);
    [self addSubview:lineLabel];
    self.lineLabel = lineLabel;

    
    UILabel *orderLabel = [[UILabel alloc] init];
//    orderLabel.textColor = RGBColorA(85, 85, 85, 1);
    [orderLabel sizeToFit];
    orderLabel.text = @"订单金额:";
    orderLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:orderLabel];
    self.orderLabel = orderLabel;

    
    UILabel *orderPrice = [[UILabel alloc] init];
//    orderPrice.textColor = RGBColorA(85, 85, 85, 1);
    [orderPrice sizeToFit];
    orderPrice.text = @"¥58.66";
    orderPrice.font = [UIFont systemFontOfSize:15];
    [self addSubview:orderPrice];
    self.orderPrice = orderPrice;
    
    
    UILabel *noteLabel = [[UILabel alloc] init];
//    noteLabel.textColor = RGBColorA(167, 167, 167, 1);
    [noteLabel sizeToFit];
    noteLabel.text = @"注: 超出20%的溢出不另外收费";
    [noteLabel sizeToFit];
    noteLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:noteLabel];
    self.noteLabel = noteLabel;
}

/** 布局子控件 **/
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Masnory
    int margin = 8;
    int rowMargin = 18;
    
//    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.mas_left).offset (margin);
//        make.top.equalTo (self.mas_top).offset (rowMargin);
//    }];
//    
//    [self.namePrice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo (self.mas_right).offset (-margin);
//        make.top.equalTo (self.nameLabel.mas_top);
//    }];
    
//    [self.preferentialLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.mas_left).offset (margin);
//        make.top.equalTo (self.nameLabel.mas_bottom).offset (margin);
//    }];
//    
//    [self.preferentialPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo (self.namePrice.mas_bottom).offset (margin);
//        make.right.equalTo (self.mas_right).offset (-margin);
//    }];
//    
//    [self.overflowLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.preferentialLabel.mas_left);
//        make.top.equalTo (self.preferentialLabel.mas_bottom).offset (margin);
//    }];
//    
//    [self.overflowPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo (self.mas_right).offset (-margin);
//        make.top.equalTo (self.preferentialPrice.mas_bottom).offset (margin);
//    }];
//    
//    // 分割线
//    [self.lineLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.mas_left).offset (margin);
//        make.right.equalTo (self.mas_right).offset (-margin);
//        make.height.equalTo (@1);
//        make.top.equalTo (self.overflowLabel.mas_bottom).offset (margin);
//    }];
//    
//    [self.orderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.lineLabel.mas_left);
//        make.top.equalTo (self.lineLabel.mas_bottom).offset (margin);
//    }];
//    
//    [self.orderPrice mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.equalTo (self.mas_right).offset (-margin);
//        make.top.equalTo (self.lineLabel.mas_bottom).offset (margin);
//    }];
//    
//    [self.noteLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.orderLabel.mas_left);
//        make.top.equalTo (self.orderLabel.mas_bottom).offset (margin);
//    }];
}
@end
