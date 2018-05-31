//
//  BasisViewController.m
//  Accumulate
//
//  Created by sanjingrihua on 2018/3/21.
//  Copyright © 2018年 sanjingrihua. All rights reserved.
//

#import "BasisViewController.h"
#import "Video.h"
@interface BasisViewController ()<NSXMLParserDelegate>
@property(nonatomic,copy) NSString *name;
@property(nonatomic,strong) NSString *name1;

@property(nonatomic,strong) NSString *strongStr;
@property(nonatomic,weak) NSString *weakStr;

//XML解析需要的 可变数组，当前解析的节点 拼接字符串
@property(nonatomic,strong)NSMutableArray *videos;
@property(nonatomic,strong)Video *currentVideo;
@property(nonatomic,strong)NSMutableString *elementStr;
@end

@implementation BasisViewController
//懒加载
- (NSMutableArray *)videos{
    if (!_videos) {
        _videos = [NSMutableArray array];
    }
    return _videos;
}
- (NSMutableString *)elementStr{
    if (!_elementStr) {
        _elementStr = [[NSMutableString alloc]init];
    }
    return _elementStr;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSLog(@"%@",_name);
    
}
- (void)loadXMLData{
    NSURL *url = [NSURL URLWithString:@"http://127.0.0.1/videos.xml"];
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:1 timeoutInterval:10.0];
    [NSURLConnection sendAsynchronousRequest:request queue:[[NSOperationQueue alloc]init] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        //XML解析  耗时操作 放新创建队列
        NSXMLParser *parser = [[NSXMLParser alloc]initWithData:data];
        //设置代理 监听实现
        parser.delegate = self;
        //解析器解析
        [parser parse];
    }];
}
#pragma mark-------<XML解析代理方法>
//先设计模型对象
//1.打开文档  OS_ACTIVITY_MODE disable  解析为模型数据数组
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    NSLog(@"打开文档");
    //清空数组
    [self.videos removeAllObjects];
}
//2.开始节点
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    NSLog(@"开始节点%@  %@",elementName,attributeDict);
    //如果elementName是Video 新建模型对象
    if ([elementName isEqualToString:@"Video"]) {
        self.currentVideo = [[Video alloc]init];
        //设置videoID 属性
        self.currentVideo.videoid = @([attributeDict[@"videoid"] intValue]);
        
    }
}
//3.节点内容 一个节点内容，可能被读取很多次
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    
    //拼接字符串
    [self.elementStr appendString:string];
    NSLog(@"%@",string);
}
//4.结束节点  将步骤2中新建的模型对象的属性赋值，对象设置完属性后，放数组 用KVC键值编码技术
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    NSLog(@"结束节点%@ ",elementName);
    
    //如果是name。。。。
    if ([elementName isEqualToString:@"video"]) {
        //是对象节点，添加到数组
        [self.videos addObject:self.currentVideo];
    }else if (![elementName isEqualToString:@"videos"]){
//        self.currentVideo.name = self.elementStr;
        
        [self.currentVideo setValue:self.elementStr forKey:elementName];
    }
    //清空字符串
    [self.elementStr setString:@""];
}
//5.结束文档
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    NSLog(@"结束文档 %@",self.videos);
}
//6.出现错误 只要是网络开发，就需要处理错误
- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"发生错误%@",parseError);
}
- (void)studyProperty{
    NSMutableString *str = [[NSMutableString alloc] initWithString:@"test,what happend"];
    self.name = str;
    self.name1 = str;
    NSLog(@"name的%p----name1的%p-----str的%p",self.name,self.name1,str);
    
    self.strongStr = @"StringTest";
    self.weakStr = self.strongStr;
    self.strongStr = nil;
    NSLog(@"strongStr=%@,weakStr=%@,strongStr=%p,weakStr=%p",self.strongStr,self.weakStr,self.strongStr,self.weakStr);
}
- (void)test{
    int a = 10;
    __block int b = 20;
    NSString *str = @"123";
    __block NSString *blockStr = str;
    NSString *strongStr = @"456";
    __weak NSString *weakStr = @"789";
    
    //定义带参数的block
    void (^blockTest)(int) = ^(int c){
        int d = a + b +c;
        NSLog(@"d=%d,strongStr=%@,blockStr=%@,weakStr=%@",d,strongStr,blockStr,weakStr);
    };
    a = 20;
    b = 40;
    blockTest(30);
    
}
- (void)arcFoundationToCore{
    NSString *str = [[NSString alloc]init];
    //__bridge CFStringRef等同于MRC下直接转换，不会移交对象的内存管理权
//    CFStringRef strRef = (__bridge CFStringRef)str;
    //CFBridgingRetain==__bridge_retained CFStringRef,这种方式转换，会移交对象的内存管理权
    CFStringRef strRef = (__bridge_retained CFStringRef)str;
    NSLog(@"%@",strRef);
    CFRelease(strRef);
    
    
    CFStringRef strRef2 = CFStringCreateWithCString(CFAllocatorGetDefault(), "123", kCFStringEncodingUTF8);
    //__bridge NSString *等同于MRC下直接转换 不会移交对象的内存管理权
//    NSString *str2 = (__bridge NSString *)(strRef2);
    
    //CFBridgingRelease == __bridge_transfer NSString *这种方式转换，会移交对象的内存管理权
    NSString *str2 = (__bridge_transfer NSString *)(strRef2);
    CFRelease(strRef2);
    
}
- (void)mrcFoundationToCore{
    //MRC
//    NSString *str = [[NSString alloc]init];
//    //直接转换，不会移交对象的内存管理权
//    CFStringRef strRef = (CFStringRef)str;
//    NSLog(@"%@",strRef);
//    [str release];
    
    CFStringRef strRef2 = CFStringCreateWithCString(CFAllocatorGetDefault(), "123", kCFStringEncodingUTF8);
    NSString *str2 = (NSString *)CFBridgingRelease(strRef2);
    NSLog(@"%@",str2);
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
