//
//  LLQDrawViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 16/11/29.
//  Copyright © 2016年 sanjingrihua. All rights reserved.
//

#import "LLQDrawViewController.h"
#import "LLQDrawView.h"
#import "LLQHandleImageView.h"
@interface LLQDrawViewController ()<UINavigationControllerDelegate,UIImagePickerControllerDelegate,llqhandleImageViewDelegate>
@property (weak, nonatomic) IBOutlet LLQDrawView *drawView;

@end

@implementation LLQDrawViewController
- (IBAction)clear:(id)sender {//清屏
    [self.drawView clear];
}
- (IBAction)undo:(id)sender {//撤销
    [self.drawView undo];
}
- (IBAction)erase:(id)sender {//橡皮擦
    [self.drawView erase];
}
- (IBAction)photo:(id)sender {//照片
    //从系统相册当中选择一张图片
    //1.弹出系统相册
    UIImagePickerController *pickerVC = [[UIImagePickerController alloc] init];
    
    //设置照片的来源
    pickerVC.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    pickerVC.delegate = self;
    //modal出系统相册
    [self presentViewController:pickerVC animated:YES completion:nil];
}
- (IBAction)save:(id)sender {//保存
    //把绘制的东西保存到系统相册当中
    
    //1.开启一个位图上下文
    UIGraphicsBeginImageContextWithOptions(self.drawView.bounds.size, NO, 0);
    
    
    //2.把画板上的内容渲染到上下文当中
    CGContextRef ctx =  UIGraphicsGetCurrentContext();
    [self.drawView.layer renderInContext:ctx];
    
    //3.从上下文当中取出一张图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    
    //4.关闭上下文
    UIGraphicsEndImageContext();
    
    //5.把图片保存到系统相册当中
    //注意:@selector里面的方法不能够瞎写,必须得是image:didFinishSavingWithError:contextInfo:
    UIImageWriteToSavedPhotosAlbum(newImage, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
//保存完毕时调用
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo {
    NSLog(@"success");
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
#pragma mark--------隐藏状态栏
-(BOOL)prefersStatusBarHidden
{
    return YES;
}
//当选择某一个照片时,会调用这个方法
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info {
    
    NSLog(@"%@",info);
    UIImage *image  = info[UIImagePickerControllerOriginalImage];
    
    //NSData *data = UIImageJPEGRepresentation(image, 1);
    NSData *data = UIImagePNGRepresentation(image);
    //[data writeToFile:@"/Users/xiaomage/Desktop/photo.jpg" atomically:YES];
    [data writeToFile:@"/Users/xiaomage/Desktop/photo.png" atomically:YES];
    
    LLQHandleImageView *handleV = [[LLQHandleImageView alloc] init];
    handleV.backgroundColor = [UIColor clearColor];
    handleV.frame = self.drawView.frame;
    handleV.image = image;
    handleV.delegate = self;
    [self.drawView addSubview:handleV];
    
    
    
    
    self.drawView.img = image;
    //取消弹出的系统相册
    [self dismissViewControllerAnimated:YES completion:nil];
    
    
}
-(void)handleImageView:(LLQDrawViewController *)handleImageView newImage:(UIImage *)newImage {
    
    self.drawView.img = newImage;
    
}



- (void)pan:(UIPanGestureRecognizer *)pan {
    
    CGPoint transP = [pan translationInView:pan.view];
    pan.view.transform = CGAffineTransformTranslate(pan.view.transform, transP.x, transP.y);
    
    //复位
    [pan setTranslation:CGPointZero inView:pan.view];
    
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

- (IBAction)setLinewidth:(UISlider*)sender {
    [self.drawView setLineWith:sender.value*3];
}

- (IBAction)setLineColor:(UIButton*)sender {
    [self.drawView setLineColor:sender.backgroundColor];
}
@end
