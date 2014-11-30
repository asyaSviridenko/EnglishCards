//
//  UIImage+Icon.m
//  EnglishCards
//
//  Created by Anastasia Kononova on 11/30/14.
//  Copyright (c) 2014 asya. All rights reserved.
//

#import "UIImage+Icon.h"

@implementation UIImage (Icon)

- (UIImage *)roundedIcon
{
    CGFloat side = MIN(self.size.width/2, self.size.height/2);
    CGRect rect = CGRectMake(0.0f, 0.0f, side, side);
    UIGraphicsBeginImageContextWithOptions(rect.size, NO, [UIScreen mainScreen].scale);
    
    [[UIBezierPath bezierPathWithRoundedRect:rect
                                cornerRadius:rect.size.width/2] addClip];

    [self drawInRect:rect];
    UIImage *roundedImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return roundedImage;
}

- (NSData *)iconData
{
    return UIImageJPEGRepresentation(self, 1.0f);
}

@end
