//
//  ViewController.m
//  JHGrayImage
//
//  Created by HaoCold on 2020/11/20.
//  Copyright © 2020 HaoCold. All rights reserved.
//

#import "ViewController.h"
#import "UIImage+AverageColor.h"
#import "UIImage+ImageWithColor.h"
#import "UIImage+InvertedImage.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupView];
}

- (void)setupView
{
    CGFloat x = 5;
    CGFloat y = 90;
    CGFloat w = (CGRectGetWidth(self.view.frame) - 5*5)*0.25;
    
    UIImage *image = [UIImage imageNamed:@"阿柴"];
//    UIImage *image = [UIImage imageNamed:@"rose"];
    
    for (NSInteger i = 0; i < 20; i++) {
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(x, y, w, w);
        [self.view addSubview:imageView];
        
        x = (i % 4) * (5 + w) + 5;
        y = (i / 4) * (5 + w) + 90;
        
        if (i < 18) {
            imageView.image = [self grayImage:image index:i];
        }else{
            switch (i) {
                case 18: imageView.image = [image invertedImage];
                case 19: imageView.backgroundColor = [image averageColor];
                default: break;
            }
        }
    }
}

- (UIImage *)grayImage:(UIImage *)image index:(NSInteger)index
{
    CGSize  size    = image.size;
    CGFloat width   = size.width;
    CGFloat height  = size.height;
    CGColorSpaceRef spaceRef = CGColorSpaceCreateDeviceGray();
    CGContextRef context = CGBitmapContextCreate(nil, width, height, 8, 0, spaceRef, [self bitmapInfo:index]);
    if (context == nil) {
        return image;
    }
    CGRect rect = CGRectMake(0, 0, size.width, size.height);
    CGContextDrawImage(context, rect, image.CGImage);
    UIImage *grayImage = [UIImage imageWithCGImage:CGBitmapContextCreateImage(context)];
    return grayImage;
}

- (uint32_t)bitmapInfo:(NSInteger)index
{
    switch (index) {
        case 0: return kCGImageAlphaPremultipliedLast;  // √
        case 1: return kCGImageAlphaNone;               // √
        case 2: return kCGImageAlphaPremultipliedLast;
        case 3: return kCGImageAlphaPremultipliedFirst;
        case 4: return kCGImageAlphaLast;
        case 5: return kCGImageAlphaFirst;              // √
        case 6: return kCGImageAlphaNoneSkipLast;
        case 7: return kCGImageAlphaNoneSkipFirst;      // gone
        case 8: return kCGImageAlphaOnly;
        case 9: return kCGBitmapAlphaInfoMask;
        case 10: return kCGBitmapFloatInfoMask;
        case 11: return kCGBitmapFloatComponents;
        case 12: return kCGBitmapByteOrderMask;         // √
        case 13: return kCGBitmapByteOrderDefault;
        case 14: return kCGBitmapByteOrder16Little;
        case 15: return kCGBitmapByteOrder32Little;
        case 16: return kCGBitmapByteOrder16Big;
        case 17: return kCGBitmapByteOrder32Big;
        default:
            break;
    }
    return kCGBitmapByteOrderDefault;
}

@end


