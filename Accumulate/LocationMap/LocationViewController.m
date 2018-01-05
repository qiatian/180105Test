//
//  LocationViewController.m
//  Accumulation
//
//  Created by sanjingrihua on 17/7/17.
//  Copyright © 2017年 sanjingrihua. All rights reserved.
//

#import "LocationViewController.h"
#import <CoreLocation/CoreLocation.h>
@interface LocationViewController ()<CLLocationManagerDelegate>

@end

@implementation LocationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //开启地理定位
    CLLocationManager *locMan = [[CLLocationManager alloc] init];
    locMan.delegate = self;
    [locMan requestWhenInUseAuthorization];
    [locMan startUpdatingHeading];
}
#pragma mark-------定位代理
-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    NSLog(@"获取到位置");
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
