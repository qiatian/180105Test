//
//  Block1ViewController.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/4/10.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "Block1ViewController.h"

@interface Block1ViewController ()

@end

@implementation Block1ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    exampleA();
    exampleB();
    exampleC();
    exampleD();
    exampleE();
    
    NSLog(@"%@",[self convertHexStrToData:@"ff"]);
    
    [self test1];
    
 
    [self HexToTen];
}
- (void)test1{
    NSLog(@"%@",NSStringFromClass([self class]));
    NSLog(@"%@",NSStringFromClass([super class]));
    NSLog(@"%@",NSStringFromClass([super superclass]));
    
//    NSLog(@"1");
//    dispatch_sync(dispatch_get_main_queue(), ^{
//        NSLog(@"2");
//    });
//    NSLog(@"3");
    
    NSString *str = @"abcdefghabc";
    NSUInteger length = str.length;
    NSLog(@"str_length %lu",(unsigned long)length);
    for (int i=0; i<length; i++) {
        
    }
    
    int a[5] = {1,2,3,4,5};
    int *ptr = (int *)(&a+1);
    printf("%d,%d",*(a+1),*(ptr - 1));
}
- (void)HexToTen{
    NSString *str = @"ff";
    NSInteger num = 0;
    for (int i=0; i<str.length; i++) {
        NSRange range = NSMakeRange(i, 1);
        NSString *hexCharStr = [str substringWithRange:range];
        if ([hexCharStr isEqualToString:@"f"]) {
            NSInteger currentNum = 15;
            for (NSInteger j=str.length-1; j>i; j--) {
                currentNum = currentNum*16;
            }
            num = num+currentNum;
            
        }
    }
    NSLog(@"%ld",(long)num);
}
- (NSData *)convertHexStrToData:(NSString *)str {
    if (!str || [str length] == 0) {
        return nil;
    }
    
    NSMutableData *hexData = [[NSMutableData alloc] initWithCapacity:8];
    NSRange range;
    if ([str length] % 2 == 0) {
        range = NSMakeRange(0, 2);
    } else {
        range = NSMakeRange(0, 1);
    }
    for (NSInteger i = range.location; i < [str length]; i += 2) {
        unsigned int anInt;
        NSString *hexCharStr = [str substringWithRange:range];
        NSScanner *scanner = [[NSScanner alloc] initWithString:hexCharStr];
        
        [scanner scanHexInt:&anInt];
        NSData *entity = [[NSData alloc] initWithBytes:&anInt length:1];
        [hexData appendData:entity];
        
        range.location += range.length;
        range.length = 2;
    }
    return hexData;
}
void exampleA() {
    char a = 'A';
    ^{
        printf("%c\n", a);
    }();
}
void exampleB_addBlockToArray(NSMutableArray *array) {
    char b = 'B';
    [array addObject:^{
        printf("%c\n", b);
    }];
}
void exampleB() {
    NSMutableArray *array = [NSMutableArray array];
    exampleB_addBlockToArray(array);
    void (^block)(void) = [array objectAtIndex:0];
    block();
}

void exampleC_addBlockToArray(NSMutableArray *array) {
    [array addObject:^{
        printf("C\n");
    }];
}
void exampleC() {
    NSMutableArray *array = [NSMutableArray array];
    exampleC_addBlockToArray(array);
    void (^block)(void) = [array objectAtIndex:0];
    block();
}

typedef void (^dBlock)(void);
dBlock exampleD_getBlock() {
    char d = 'D';
    return ^{
        printf("%c\n", d);
    };
}
void exampleD() {
    exampleD_getBlock()();
}

typedef void (^eBlock)(void);
eBlock exampleE_getBlock() {
    char e = 'E';
    void (^block)(void) = ^{
        printf("%c\n", e);
    };
    return block;
}
void exampleE() {
    eBlock block = exampleE_getBlock();
    block();
}
- (void)blockTestStr{
    //__block
    NSString *str1 = @"llq";
    NSLog(@"str1对象的内存地址：%p\nstr1指针的内存地址：%x",str1,&str1);
    void (^blockStr)(void) = ^{
        //        str1 = @"jly";
        NSLog(@"%@",str1);
        NSLog(@"str1对象的内存地址：%p\nstr1指针的内存地址：%x",str1,&str1);
    };
    NSLog(@"str1对象的内存地址：%p\nstr1指针的内存地址：%x",str1,&str1);
    //被__block修饰过的变量 在 block 内部的会被copy到堆区
    //不被任何修饰的变量
    blockStr();
}
- (void)blockTest{
    //    NSProxy
    int a = 10;
    NSLog(@"-------a:%p",&a);
    void (^block)(void) = ^{
        NSLog(@"%d",a);
        NSLog(@"-------中a:%p",&a);
        NSLog(@"block");
    };
    //block分类 NSGlobalBlock NSMallocBlock NSStackBlock
    block();
    NSLog(@"----%@",block);
    NSLog(@"+++%@",^{NSLog(@"%d",a);});
    //    __block修饰后，在block中能把观察到的变量由栈区copy到堆区
    __block int b = 10;
    NSLog(@"前%p",&b);
    void (^blockb)(void) = ^{
        NSLog(@"中%p",&b);
        NSLog(@"block");
    };
    blockb();
    NSLog(@"后%p",&b);
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
