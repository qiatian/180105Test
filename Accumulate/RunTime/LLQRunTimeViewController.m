//
//  LLQRunTimeViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/2/23.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//
/*
 RunTime OC运行时机制  消息机制 
 任何方法的调用就是发送一个消息，用runtime发送消息。OC底层实现通过runtime实现。
 验证：方法调用，是否真的是转换为消息机制。
 
 Runtime (交换方法)：只要想修改系统的方法实现时候， 1.给系统的方法添加分类，2.自己实现一个带有扩展功能的方法。3.交换方法，交换一次。
 需求：让UIImage加载图片，告诉我是否加载成功
 方法：1.自定义UIImage a.每次使用，都需要导入 b.项目开发很久了，实现 麻烦 。
 2.UIImage添加分类
 
  Runtime (动态添加方法)：OC都是懒加载机制，只要一个方法实现了，就会马上添加到方法列表中。
 performSelector:什么时候使用？动态添加方法时候使用
 怎么动态添加方法？用Runtime
 为什么要动态添加方法？
 
 Runtime (动态添加属性)： 为什么要动态添加属性？ 给系统的类添加属性的时候
 本质：动态添加属性 ，让属性和对象产生关联。
 需求：让NSObject类，保存一个字符串
 runtime一般都是针对系统的类
 
 
 内存5大区
 1.栈 2.堆 3.静态区 4.常量区 5.方法区
 栈： 不需要手动管理内存，自动管理
 堆：需要手动管理内存，手动管理。
 
 开发中的使用场景
 什么时候需要用到runtime,消息机制
 1.装大牛，YYKit 2.不得不用，可以调用私有方法
 */
#import "LLQRunTimeViewController.h"
#import <objc/message.h>//导入头文件
#import "Person.h"
#import "LLQImage.h"
#import "UIImage+Image.h"
#import "NSObject+Property.h"
#import "NSDictionary+Property.h"
#import "NSObject+Model.h"
#import "Person+mult.h"
@interface LLQRunTimeViewController ()
@property(nonatomic,strong)Person *person;
@end

@implementation LLQRunTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //最终生成消息机制，编译器作的事情
    //最终代码，需要把当前代码重新编译，用Xcode编译器，clang
    //clang －rewrite－objc main.m 产看最终生成代码
//    id objc=[NSObject alloc];
//    objc=[objc init];
    
//    Person *p = [Person alloc];
//    Person *p =objc_msgSend(objc_getClass("Person"), sel_registerName("alloc"));
//    p = [p init];
//    objc_msgSend(p, sel_registerName("init"));
    
//    调用eat
//    [p eat];
//    objc_msgSend(p, @selector(eat));
    
//    objc_msgSend(p, @selector(run:),20);
    
    //方法调用流程  方法保存在什么地方：对象方法：保存在类对象，方法列表； 类方法：保存在元类中的方法列表中。 1.通过isa去寻找对应的类对象中查找 2.注册方法编号 3.根据方法编号去查找对应方法
    
    
    UIImage *image = [UIImage imageNamed:@"1.png"];
    if (image == nil) {
        NSLog(@"加载失败");
    }else{
        NSLog(@"加载成功");
    }
    
//    UIImage *image1 = [LLQImage imageNamed:@"2.png"];
//    
//    UIImage *img2 = [UIImage llq_imageNamed:@"3.png"];
    
//    [self performSelector:<#(SEL)#>]
    //执行某个方法
//    [p performSelector:@selector(play)];
    
//    [p performSelector:@selector(run:) withObject:@10];
    
    NSLog(@"%@",NSStringFromSelector(_cmd));//当前方法名字
    
    NSString *str = [NSString stringWithFormat:@"123"];
    Person *p1 = [[Person alloc]init];
    p1.name = str;
    
    NSObject *obje = [[NSObject alloc]init];
    obje.name = @"123";
    
    //自动生成属性代码
    [self dynamicCode];
}
-(void)dynamicCode
{
    //获取文件全路径
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"status.plist" ofType:nil];
    //文件全路径
    NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:filePath];
//    设计模型，创建属性代码 dict
    [dic createProperyCode];
//    字典转模型
    
}
-(void)test
{
    //Xcode6之前，苹果运行使用objc_msgSend。而且有参数提示
    //    id objc = [NSObject alloc];
    //    id：谁发送消息 SEL：发送什么消息
    //找到buile setting -> 搜索msg
//    id objc = objc_msgSend([NSObject class], @selector(alloc));
//    objc = objc_msgSend(objc, @selector(init));
}
//交互方法
//给分类添加实例
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//使用runtime来交换两个方法
- (void)exchangedMethod{
    //获取方法
    Method m1 = class_getInstanceMethod([self.person class], @selector(firstMethod));
    Method m2 = class_getInstanceMethod([self.person class], @selector(secondMethod));
    
    //交换
    method_exchangeImplementations(m1, m2);
}
//使用runtime动态添加方法
- (void)addMehtod{
    //"v@:@" v表示void, @表示id类型, ：表示SEL
    class_addMethod([self.person class], @selector(gohome:), (IMP)runMethod, "v@:@");
}
//id self,SEL _cmd是两个默认参数
void runMethod(id self,SEL _cmd, NSString *miles){
    
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
