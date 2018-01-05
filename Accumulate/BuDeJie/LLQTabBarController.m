//
//  LLQTabBarController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/2/27.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//
/*
 1.选中按钮的图片被渲染－－－－iOS7之后默认tabBar上图片都会被渲染。1.设置图片。2.通过代码：
 2.选中按钮的标题颜色：黑色   标题字体大－－对应子控制器Tabbar
 3.发布按钮显示不出来  分析：对比法，为什么其他图片可以显示，我的图片不能显示－－发布按钮太大，导致显示不出来。
   a.图片太大，系统帮你渲染－－－设置图片不渲染－－－能显示，位置不对－需要调整
 解决：不能修改图片尺寸，效果：让发布图片居中。
 
 tabBarItem:设置tabBar上按钮内容  tabBarButton
 UINavigationItem:设置导航条上内容（左，右，中）
 UIBarButtonItem:描述按钮具体的内容
 
 搭建基本结构－－－设置底部条－－－设置顶部条－－设置顶部条的标题字体
 设置导航条标题－－由UINavigationBar决定。  只要通过模型设置，都是通过富文本设置。
 */
#import "LLQTabBarController.h"

@interface LLQTabBarController ()

@end

@implementation LLQTabBarController
#pragma mark------只调用一次
+(void)load
{
//    appearance 只能在控件显示之前设置，才起作用。  大规模变化，会碰到。
//    ／哪些属性可以通过appearance 设置， 只要被UI_APPEARANCE_SELECTOR 宏修饰的属性，才可以设置
    //只要遵守UIAppearance协议，还要实现这个方法
    //获取整个应用程序下的 UITabBarItem
//    [UITabBarItem appearance]
    UITabBarItem *item = [UITabBarItem appearanceWhenContainedIn:self, nil];
    //选中标题颜色。
    NSMutableDictionary *attr=[NSMutableDictionary dictionaryWithCapacity:0];
    attr[NSForegroundColorAttributeName]=[UIColor blackColor];
    [item setTitleTextAttributes:attr forState:UIControlStateSelected];
    
    //设置字体，只有正常状态下，才会有效果
    NSMutableDictionary *attrNormal=[NSMutableDictionary dictionaryWithCapacity:0];
    attrNormal[NSFontAttributeName]=[UIFont systemFontOfSize:15];
    [item setTitleTextAttributes:attr forState:UIControlStateNormal];
}
#pragma mark------调用多次，需要加判断
+(void)initialize
{
    if (self==[LLQTabBarController class]) {
        
    }
}
- (void)viewDidLoad {
    [super viewDidLoad];
    UIImage *image=[UIImage imageNamed:@""];
    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
