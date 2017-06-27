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


//@property (nonatomic, strong) NSMutableArray *configArray;
@property (nonatomic, strong) NSArray *configArray;
@property (weak) IBOutlet NSButton *startBT;
@property (weak) IBOutlet NSButton *stopBT;
@property (weak) IBOutlet NSTextField *TextLabel;
@property (weak) IBOutlet NSTextField *recordNum;


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
    NSString *filePath = [NSString stringWithFormat:@"%@/con", [[NSBundle mainBundle] resourcePath]];
    
    
    NSArray *fileData;
    NSError *error;
    
    //读取file文件并把内容根据换行符分割后赋值给NSArray
    fileData = [[NSString stringWithContentsOfFile:filePath
                                          encoding:NSUTF16StringEncoding
                                             error:&error]
                componentsSeparatedByString:@"\n"];
    
    NSLog(@"%lu", (unsigned long)fileData.count);
    
    //获取NSArray类型对象的迭代器
    NSEnumerator *arrayEnumerator = [fileData objectEnumerator];
    NSString *tempStr;
    
    while (tempStr = [arrayEnumerator nextObject]) {
        NSLog(@"%@",tempStr);
    }
    recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey,
                                   [NSNumber numberWithInt:16],AVEncoderBitRateKey,
                                   [NSNumber numberWithInt:1],AVNumberOfChannelsKey,
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
    if (currentItemIndex >= [self configArray].count) {
        currentItemIndex --;
        return;
    } else {
        self.TextLabel.stringValue = self.configArray[currentItemIndex];
        NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/%@.wav", [[NSBundle mainBundle] resourcePath],self.configArray[currentItemIndex]]];
        
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




- (NSArray *)configArray {
    
    if(_configArray == nil) {
    self.recordNum.stringValue = @"80";
        _configArray = @[].mutableCopy;
        NSString *path = [[NSBundle mainBundle] pathForResource:@"config" ofType:@"txt"];
        NSString *configTxt  = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        _configArray = [configTxt componentsSeparatedByString:@"\r\n"];
    }
    
    return _configArray;
}

@end
