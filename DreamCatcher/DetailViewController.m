//
//  DetailViewController.m
//  
//
//  Created by Rafael Auriemo on 1/4/16.
//
//

#import "DetailViewController.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.dreamTitle;
    self.textView.text = self.dreamDesc;
}


@end
