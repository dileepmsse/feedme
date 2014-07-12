//
//  PdfViewController.h
//  ConfApp
//
//  Created by Dileep Mettu on 5/22/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PdfViewController : UIViewController
{
    UIActivityIndicatorView *activityIndicator;
    
}
@property (strong, nonatomic) IBOutlet UILabel *pdfTitle;
- (IBAction)HandleCloseButtonAction:(UIButton *)sender;
@property (strong, nonatomic) IBOutlet UIWebView *pdfView;
@property(nonatomic, strong) NSURL *pdfURL;
@property (nonatomic, strong) NSString* titletext;

@end
