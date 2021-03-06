//
//  AIDownloadButtonViewController.m
//  AIAnimationDemo
//
//  Created by 艾泽鑫 on 2017/5/8.
//  Copyright © 2017年 艾泽鑫. All rights reserved.
//

#import "AIDownloadButtonViewController.h"
#import "AIDownloadButton.h"
#import "AFNetHelper.h"
@interface AIDownloadButtonViewController ()
@property (weak, nonatomic) IBOutlet AIDownloadButton *downLoadButton;
/** 进程*/
@property(nonatomic,strong)NSURLSessionTask *task;
@end

@implementation AIDownloadButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.downLoadButton setBlock:^{
        AILog(@"2222");
        AIWeakSelf
       self.task = [AFNetHelper downloadWithURL:@"http://wvideo.spriteapp.cn/video/2016/0116/569a048739c11_wpc.mp4" fileDir:@"xx" progress:^(NSProgress *progress) {
            weakSelf.downLoadButton.progress    = progress.fractionCompleted;
            weakSelf.downLoadButton.text        = [self transitionUnit:progress.completedUnitCount];;
        } success:^(NSString *filePath) {
            weakSelf.downLoadButton.progress    = 1.;
        } failure:^(NSError *err) {
            
        }];
    }];
    
}
- (IBAction)resume:(id)sender {
    [self.task  cancel];
    [self.downLoadButton resume];
}

/**
 转换单位

 @param b 进来的时候是b
 @return 返回单位 最大T
 */
- (NSString *)transitionUnit:(NSInteger)b {
    NSArray *unit       = @[@"b",@"kb",@"mb",@"GB",@"T"];
    CGFloat remainder   = 0.;
    NSInteger i         = 0;
    do {
        remainder       = b / 1024.;
        b               = remainder;
        if (i < 5) {
            i ++;
        }
    } while (remainder >= 1024);
    return [NSString stringWithFormat:@"%.1lf%@",remainder,unit[i]];
}



@end
