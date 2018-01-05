//
//  LLQSeeBigPicViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/24.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LLQSeeBigPicViewController.h"
#import <Photos/Photos.h>
@interface LLQSeeBigPicViewController ()<UIScrollViewDelegate>
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)PHAssetCollection *createdCollection;
-(PHFetchResult<PHAsset *> *)createdAssets;//返回保存到相机胶卷的图片
@end

@implementation LLQSeeBigPicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    UIScrollView *scView = [[UIScrollView alloc]init];
    scView.frame = CGRectMake(0, 0, ScreenW, ScreenH);
    [self.view insertSubview:scView atIndex:0];
    self.scrollView = scView;
    
    UIImageView *imgView = [[UIImageView alloc]init];
    imgView.frame = _scrollView.frame;
    [scView addSubview:imgView];
    self.imgView = imgView;
    
    CGFloat maxScale ;
    if (maxScale>1) {
        [scView setMaximumZoomScale:maxScale];
        scView.delegate = self;
    }
    
}
#pragma mark-----UIScrollViewDelegate
-(UIView*)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imgView;
}
-(void)save{
    PHAuthorizationStatus oldStatus = [PHPhotoLibrary authorizationStatus];
    __weak typeof(self) weakSelf = self;
    //请求／检查访问权限
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        dispatch_async(dispatch_get_main_queue(), ^{
            if (status == PHAuthorizationStatusDenied && oldStatus != PHAuthorizationStatusNotDetermined) {//拒绝
                NSLog(@"refuse");
            }else if (status==PHAuthorizationStatusAuthorized){//允许
                [weakSelf saveImageIntoAlbum];
            }else if (status==PHAuthorizationStatusRestricted){//无法访问
                
            }
        });
        
    }];
}
/*1.保存图片到 camera roll a.C语言 b.AssetsLibrary框架 c.Photos框架
 2.拥有一个自定义相册 a.AssetsLibrary框架(iOS9 disabled) b.Photos框架(iOS8 start)
 3.将刚才保存到camera roll中的图片引用到自定义相册 a.AssetsLibrary框架 b.Photos框架*/
-(void)saveImageIntoAlbum{
    UIImageWriteToSavedPhotosAlbum(self.imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    
    //获取相片
    PHFetchResult<PHAsset *> *createdAssets = self.createdAssets;
    if (createdAssets == nil) {
        NSLog(@"保存图片失败");
        return;
    }
    //获取相册
    PHAssetCollection *createCol = self.createdCollection;
    if (createCol == nil) {
        NSLog(@"创建相册失败");
        return;
    }
//添加图片到自定义相册
    NSError *error = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:self.createdCollection];
        [request insertAssets:createdAssets atIndexes:[NSIndexSet indexSetWithIndex:0]];
//        [request addAssets:@[placeholder]];
        
    } error:&error];
    if (error) {
        NSLog(@"保存图片失败");
    }else{
        NSLog(@"保存图片成功");
    }
}
-(PHFetchResult<PHAsset *> *)createdAssets
{
    NSError *error = nil;
    //    __block PHObjectPlaceholder *placeholder = nil;
    __block NSString *assetID = nil;
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        //        placeholder = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imgView.image].placeholderForCreatedAsset;
        assetID = [PHAssetChangeRequest creationRequestForAssetFromImage:self.imgView.image].placeholderForCreatedAsset.localIdentifier;
        
    } error:&error];
    
    if (error) {
        NSLog(@"error保存失败！");
        return nil;
    }
    
    return [PHAsset fetchAssetsWithLocalIdentifiers:@[assetID] options:nil];
}
#pragma mark------获取当前app对应的自定义相册
-(PHAssetCollection *)createdCollection
{
    //    异步执行修改操作
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
        [PHAssetChangeRequest creationRequestForAssetFromImage:self.imgView.image];
        
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error");
        }else{
            NSLog(@"success");
        }
    }];
    
    //同步执行修改操作
    NSString *title = [NSBundle mainBundle].infoDictionary[(NSString *)kCFBundleNameKey];
    
    PHFetchResult<PHAssetCollection *> *albumArr = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *col in albumArr) {
        if ([col.localizedTitle isEqualToString:title]) {
            return col;
        }
    }
    
        NSError *error = nil;
        __block NSString *ID;
        [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
            [PHAssetChangeRequest creationRequestForAssetFromImage:self.imgView.image];
            //创建自定义相册
            ID = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:title].placeholderForCreatedAssetCollection.localIdentifier;
        } error:&error];
    
        if (error) {
            NSLog(@"error");
        }else{
            NSLog(@"success");
        }
     return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[ID] options:nil].firstObject;
    
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    if (error) {
        NSLog(@"error");
    }else{
        NSLog(@"success");
    }
}
//-(void)done{
//    NSLog(@"%s",__func__);
//}
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
