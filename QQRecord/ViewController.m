//
//  ViewController.m
//  QQRecord
//
//  Created by pencilCool on 2017/6/24.
//  Copyright © 2017年 pencilCool. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import <AVKit/AVKit.h>

@interface ViewController()
@property (weak) IBOutlet NSTextFieldCell *label;

@property (nonatomic, strong) AVAudioPlayer *audioPlay;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;


@property (nonatomic, strong) NSMutableArray *configArray;

@end


@implementation ViewController
{
    NSUInteger currentItemIndex;
    NSDictionary *recordSetting;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    currentItemIndex = -1;
    // Do any additional setup after loading the view.
    
    recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey,
                                   [NSNumber numberWithInt:16],AVEncoderBitRateKey,
                                   [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                                   [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                                   nil];
    
    NSLog(@"保存音频的目录是：%@",[[NSBundle mainBundle] resourcePath]);
    
}


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)start:(id)sender {
    
    
    if (self.audioRecorder.recording) return;
    currentItemIndex ++;
    if (currentItemIndex == [self configArray].count - 1) {
        return;
    } else {
        
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.caf", [[NSBundle mainBundle] resourcePath],self.configArray[currentItemIndex]]];
        
        NSError *error = nil;
        self.audioRecorder = [[ AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
        if (error != nil) {
            NSLog(@"Init audioRecorder error: %@",error);
        }else{
            if ([self.audioRecorder prepareToRecord]) {
                NSLog(@"Prepare successful");
            }
        }
    }
    
    
    NSLog(@"start-------");
    NSLog(@"The recording filename is = %@",self.configArray[currentItemIndex]);
    [self.audioRecorder record];
    
    
}


- (IBAction)stop:(id)sender {
    if (!self.audioRecorder) return;
    if (!self.audioRecorder.recording) return;

    NSLog(@"stop-------");
    NSLog(@"The recorded filename is = %@",self.configArray[currentItemIndex]);
    [self.audioRecorder stop];
    
}



// 在这里添加你们的配置选项，接下来会改成从外部导入文件的方法
- (NSMutableArray *)configArray {
    
    if(_configArray == nil) {
     _configArray = @[].mutableCopy;
    [_configArray addObject:@"叮咚1"];
    [_configArray addObject:@"叮咚2"];
    [_configArray addObject:@"叮咚3"];
    [_configArray addObject:@"叮咚4"];
    
    // .... 添加你的选项
    }
    
    return _configArray;
}


@end
