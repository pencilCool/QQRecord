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
@property (weak) IBOutlet NSScrollView *persentationView;
@property (nonatomic, strong) AVAudioPlayer *audioPlay;
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@end



@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
    
    NSDictionary *recordSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                   [NSNumber numberWithInt:AVAudioQualityLow],AVEncoderAudioQualityKey,
                                   [NSNumber numberWithInt:16],AVEncoderBitRateKey,
                                   [NSNumber numberWithInt:2],AVNumberOfChannelsKey,
                                   [NSNumber numberWithFloat:44100.0],AVSampleRateKey,
                                   nil];
   // NSURL *url =  NSFileManager.defaultManager.homeDirectoryForCurrentUser;
    NSURL *url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/record.caf", [[NSBundle mainBundle] resourcePath]]];
    
    // url 打个断点看看路劲 比如：file:///Users/pencilcool/Library/Developer/Xcode/DerivedData/QQRecord-etwkrufqwxhhbubptygagennpfnq/Build/Products/Debug/QQRecord.app/Contents/Resources/record
    
    
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


- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}
- (IBAction)start:(id)sender {
    if (!self.audioRecorder.recording) {
        NSLog(@"start-------");
        [self.audioRecorder record];
    }
    
}


- (IBAction)stop:(id)sender {
    if (self.audioRecorder.recording) {
        NSLog(@"stop-------");
        [self.audioRecorder stop];
    }
}

- (void)updateWith:(NSString *) str {
    
}



@end
