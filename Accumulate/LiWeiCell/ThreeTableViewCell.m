//
//  ThreeTableViewCell.m
//  Farmers
//
//  Created by 览山晓 on 16/10/31.
//  Copyright © 2016年 Farmers. All rights reserved.
//

#import "ThreeTableViewCell.h"

@interface ThreeTableViewCell ()
/** 收货人 **/
@property (nonatomic, weak, nullable) UILabel *consigneeLabel;
/** 收货地址 **/
@property (nonatomic, weak, nullable) UILabel *addressLabel;
/** 支付方式 **/
@property (nonatomic, weak, nullable) UILabel *paymentLabel;
/** 下单时间 **/
@property (nonatomic, weak, nullable) UILabel *OrdertimeLabel;
@end


@implementation ThreeTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // 创建子控件
        [self setupChildControls];
    }
    return self;
}

// 创建子控件
- (void)setupChildControls {
    UILabel *consigneeLabel = [[UILabel alloc] init];
    [consigneeLabel sizeToFit];
    consigneeLabel.text = @"收货人: 你大爷";
    [consigneeLabel sizeToFit];
    consigneeLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:consigneeLabel];
    self.consigneeLabel = consigneeLabel;
    
    UILabel *addressLabel = [[UILabel alloc] init];
    [addressLabel sizeToFit];
    addressLabel.text = @"收货地址: 外太空火星街道 门户";
    [addressLabel sizeToFit];
    addressLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:addressLabel];
    self.addressLabel = addressLabel;
    
    
    UILabel *paymentLabel = [[UILabel alloc] init];
    [paymentLabel sizeToFit];
    paymentLabel.text = @"货到付款";
    [paymentLabel sizeToFit];
    paymentLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:paymentLabel];
    self.paymentLabel = paymentLabel;
    
    
    UILabel *OrdertimeLabel = [[UILabel alloc] init];
    [OrdertimeLabel sizeToFit];
    OrdertimeLabel.text = @"2016-12-28 19:20";
    [OrdertimeLabel sizeToFit];
    OrdertimeLabel.font = [UIFont systemFontOfSize:15];
    [self addSubview:OrdertimeLabel];
    self.OrdertimeLabel = OrdertimeLabel;
}

/** 布局子控件 **/
- (void)layoutSubviews {
    [super layoutSubviews];
    
    // Masnory
    int margin = 8;
    int rowMargin = 18;
    
//    [self.consigneeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.mas_left).offset (margin);
//        make.top.equalTo (self.mas_top).offset (rowMargin);
//    }];
//    
//    [self.addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.consigneeLabel.mas_left);
//        make.top.equalTo (self.consigneeLabel.mas_bottom).offset (margin);
//    }];
//    
//    [self.paymentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.consigneeLabel.mas_left);
//        make.top.equalTo (self.addressLabel.mas_bottom).offset (margin);
//    }];
//    
//    [self.OrdertimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo (self.consigneeLabel.mas_left);
//        make.top.equalTo (self.paymentLabel.mas_bottom).offset (margin);
//    }];
}
@end
