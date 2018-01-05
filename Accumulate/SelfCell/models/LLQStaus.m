//
//  LLQStaus.m
//  Accumulation
//
//  Created by sanjingrihua on 17/4/13.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQStaus.h"

@implementation LLQStaus
-(CGFloat)cellHeight
{
    if (_cellHeight == 0) {
        CGFloat space = 10;
        CGFloat headX = space;
        CGFloat headY = space;
        CGFloat headWH = 30;
        self.headFram = CGRectMake(headX, headY, headWH, headWH);
        
        
        NSString *nameStr = @"weljsdodsgogjdosgji";
        CGFloat nameX = CGRectGetMaxX(self.headFram)+space;
        CGFloat nameY = headY;
        NSDictionary *nameAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:16]};
        CGSize nameSize = [nameStr sizeWithAttributes:nameAtt];
        CGFloat nameW = nameSize.width;
        CGFloat nameH = nameSize.height;
        self.nameFram = CGRectMake(nameX, nameY, nameW, nameH);
        
        
        if (!self.vip) {
            self.vip = !self.vip;
            CGFloat vipX = CGRectGetMaxX(self.nameFram) + space;
            //    CGFloat vipWH = 14;
            //    CGFloat vipY = nameY +(nameH-vipWH)*0.5;
            //    self.vipImg.frame = CGRectMake(vipX, vipY, vipWH, vipWH);
            CGFloat vipY = nameY;
            CGFloat vipW =14;
            CGFloat vipH =nameH;
            self.vipFram = CGRectMake(vipX, vipY, vipW, vipH);
            
        }
        
        NSString *contentStr = @"weljsdodsgogjdosgjiweljsdodsgogjdosgjiweljsdodsgogjdosgjiweljsdodsgogjdosgji";
        CGFloat contentX = headX;
        CGFloat contentY = CGRectGetMaxX(self.headFram)+space;
        CGFloat contentW = [[UIScreen mainScreen] bounds].size.width-space*2;
        NSDictionary *contentAtt = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
        //    CGFloat contentH = [nameStr sizeWithAttributes:contentAtt].height;
        CGSize contentSize = CGSizeMake(contentW, MAXFLOAT);
        //    CGFloat contentH = [contentStr sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:contentSize].height;
        CGFloat contentH = [contentStr boundingRectWithSize:contentSize options:NSStringDrawingUsesLineFragmentOrigin attributes:contentAtt context:nil].size.height;
        self.contentFram = CGRectMake(contentX, contentY, contentW, contentH);
        if (self.picImg) {
            CGFloat picWH = 100;
            CGFloat picX = headX;
            CGFloat picY = CGRectGetMaxY(self.contentFram)+space;
            self.picFram = CGRectMake(picX, picY, picWH, picWH);
            _cellHeight = CGRectGetMaxY(self.picFram)+space;
        }
        else{
            _cellHeight = CGRectGetMaxY(self.contentFram)+space;
        }
    }
    return _cellHeight;
}
@end
