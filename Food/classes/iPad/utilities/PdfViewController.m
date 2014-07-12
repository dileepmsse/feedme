//
//  PdfViewController.m
//  ConfApp
//
//  Created by Dileep Mettu on 5/22/14.
//  Copyright (c) 2014 Dileep Mettu. All rights reserved.
//

#import "PdfViewController.h"

@interface PdfViewController ()

@end

@implementation PdfViewController

@synthesize title,titletext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _pdfTitle.text=titletext;
    _pdfTitle.textAlignment = NSTextAlignmentCenter;
   	[_pdfView setBackgroundColor:[UIColor clearColor]];
	[_pdfView setOpaque:NO];
	[_pdfView loadRequest:[NSURLRequest requestWithURL:_pdfURL]];
    activityIndicator =  [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    activityIndicator.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:activityIndicator];
    [activityIndicator startAnimating];
    // Do any additional setup after loading the view from its nib.
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    activityIndicator.hidden = TRUE;
    [activityIndicator startAnimating];

}

-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType {
    return YES;
  }


- (void)webViewDidStartLoad:(UIWebView *)webView
{
   
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    activityIndicator.hidden = TRUE;
    [activityIndicator stopAnimating];
}

-(void) viewWillAppear:(BOOL)animated
{
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)HandleCloseButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:Nil];

}
@end
