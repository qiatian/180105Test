//
//  SelectMorePhotosViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/5/25.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "SelectMorePhotosViewController.h"
#import "CTAssetsPickerController.h"
@interface SelectMorePhotosViewController ()<CTAssetsPickerControllerDelegate>

@end

@implementation SelectMorePhotosViewController
//if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
//ctPicker.modalPresentationStyle = UIModalPresentationFormSheet;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)selectPhoto:(id)sender {
    __weak typeof(self)  weakSelf = self ;
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized) {
            return;
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            CTAssetsPickerController *ctPicker = [[CTAssetsPickerController alloc]init];
            ctPicker.delegate = weakSelf;
            
            
            [self presentViewController:ctPicker animated:YES completion:nil];
        });
        
    }];
}
#pragma mark-----<CTAssetsPickerControllerDelegate>
-(void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray<PHAsset *> *)assets
{
    //关闭图片选择界面
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    //
    PHImageRequestOptions *options = [[PHImageRequestOptions alloc]init];
    options.resizeMode = PHImageRequestOptionsResizeModeExact;
    options.deliveryMode = PHImageRequestOptionsDeliveryModeFastFormat;
    
    for (int i=0; i<assets.count; i++) {
        PHAsset *asset = assets[i];
        CGFloat scale = [UIScreen mainScreen].scale;
        CGSize size = CGSizeMake(asset.pixelWidth/scale, asset.pixelHeight/scale);
        
        [[PHImageManager defaultManager] requestImageForAsset:assets[i] targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
            NSLog(@"result%@",result);
            UIImageView *imgView = [[UIImageView alloc]init];
            imgView.image = result;
            [self.view addSubview:imgView];
            imgView.frame = CGRectMake(i%3*(100+10), i/3 *(100+10), 100, 100);
        }];
        
        
    }
}
-(BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(PHAsset *)asset
{
    NSInteger max = 3;
    if (picker.selectedAssets.count<max) {
        return YES;
    }else{
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"注意" message:[NSString stringWithFormat:@"最多选%ld张",(long)max] preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSLog(@"ddd");
        }]];
        [alert presentedViewController];
    }
    
    return NO;

    
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
