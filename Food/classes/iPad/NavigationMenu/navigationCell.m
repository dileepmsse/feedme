//
//  navigationCell.m
//  ConfApp
//
//  Created by sesa249801 on 6/23/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "navigationCell.h"
#define kRectArmLength 24.0
@implementation navigationCell


- (void)awakeFromNib
{
    // Initialization code
    
    
    self.menuItemTitle.frame = CGRectMake(10,20, kRectArmLength, kRectArmLength);
    
    //set corner radius just half of the square arm length
    
    self.menuItemTitle.layer.cornerRadius= kRectArmLength/2;
    
    self.menuItemTitle.clipsToBounds=YES;
    
    
    self.menuItemTitle.backgroundColor = [UIColor redColor];
    
    //[self.view adsSubview: lblCircle];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
/*
- (void) drawStringAtContext:(CGContextRef) context string:(NSString*) text atAngle:(float) angle withRadius:(float) radius
{
    CGSize textSize = [text sizeWithFont:self.menuItemsFont];
    
    float perimeter = 2 * M_PI * radius;
    float textAngle = textSize.width / perimeter * 2 * M_PI;
    
    angle += textAngle / 2;
    
    for (int index = 0; index < [text length]; index++)
    {
        NSRange range = {index, 1};
        NSString* letter = [text substringWithRange:range];
        char* c = (char*)[letter cStringUsingEncoding:NSASCIIStringEncoding];
        CGSize charSize = [letter sizeWithFont:self.menuItemsFont];
        
        NSLog(@"Char %@ with size: %f x %f", letter, charSize.width, charSize.height);
        
        float x = radius * cos(angle);
        float y = radius * sin(angle);
        
        float letterAngle = (charSize.width / perimeter * -2 * M_PI);
        
        CGContextSaveGState(context);
        CGContextTranslateCTM(context, x, y);
        CGContextRotateCTM(context, (angle - 0.5 * M_PI));
        CGContextShowTextAtPoint(context, 0, 0, c, strlen(c));
        CGContextRestoreGState(context);
        
        angle += letterAngle;
    }
}

- (UIImage*) createMenuRingWithFrame:(CGRect)frame
{
    CGPoint centerPoint = CGPointMake(frame.size.width / 2, frame.size.height / 2);
    char* fontName = (char*)[self.menuItemsFont.fontName cStringUsingEncoding:NSASCIIStringEncoding];
    UIColor *ringColor = [UIColor whiteColor];
    UIColor *textColor = [UIColor yellowColor];
    float ringAlpha = 1.0f;
    float textAlpha = 1.0f;
    float ringWidth = 1.0f;
    CGFloat* ringColorComponents = (float*)CGColorGetComponents(ringColor.CGColor);
    CGFloat* textColorComponents = (float*)CGColorGetComponents(textColor.CGColor);
   
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(NULL, frame.size.width, frame.size.height, 8, 4 * frame.size.width, colorSpace, kCGImageAlphaPremultipliedFirst);
    
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    
    CGContextSelectFont(context, fontName, 18, kCGEncodingMacRoman);
    CGContextSetRGBStrokeColor(context, ringColorComponents[0], ringColorComponents[1], ringColorComponents[2], 1.0f);
    CGContextSetLineWidth(context, ringWidth);
    
    CGContextStrokeEllipseInRect(context, CGRectMake(ringWidth, ringWidth, frame.size.width - (ringWidth * 2), frame.size.height - (ringWidth * 2)));
    CGContextSetRGBFillColor(context, textColorComponents[0], textColorComponents[1], textColorComponents[2], textAlpha);
    
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, centerPoint.x, centerPoint.y);
    
    float angleStep = 2 * M_PI / [sections count];
    float angle = degreesToRadians(90);
    
    textRadius = textRadius - 12;
    
    for (NSString* text in sections)
    {
        [self drawStringAtContext:context string:text atAngle:angle withRadius:textRadius];
        angle -= angleStep;
    }
    
    CGContextRestoreGState(context);
    
    CGImageRef contextImage = CGBitmapContextCreateImage(context);
    
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    [self saveImage:[UIImage imageWithCGImage:contextImage] withName:@"test.png"];
    return [UIImage imageWithCGImage:contextImage];
    
}
*/
@end
