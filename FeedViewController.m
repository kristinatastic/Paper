//
//  FeedViewController.m
//  Paper
//
//  Created by Kristina Varshavskaya on 6/24/14.
//  Copyright (c) 2014 kristinatastic. All rights reserved.
//

#import "FeedViewController.h"

@interface FeedViewController ()

@property (weak, nonatomic) IBOutlet UIView *headlinesView;
@property (weak, nonatomic) IBOutlet UIImageView *headlinesImageView;
@property (weak, nonatomic) IBOutlet UIScrollView *headlinesScrollView;

- (void)onHeadlinePan:(UIPanGestureRecognizer *)panGestureRecognizer;
- (void)onTimer;

@end

NSTimer *timer;

@implementation FeedViewController

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
    
    UIPanGestureRecognizer *panGestureRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(onHeadlinePan:)];
    [self.headlinesScrollView addGestureRecognizer:panGestureRecognizer];
    
    UIScrollView *cardScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 315, 320, 253)];
    cardScrollView.contentSize = CGSizeMake(858, 253);
    [self.headlinesView addSubview:cardScrollView];
    cardScrollView.userInteractionEnabled = YES;
    cardScrollView.scrollEnabled = YES;
    cardScrollView.alwaysBounceHorizontal = YES;
    cardScrollView.showsHorizontalScrollIndicator = NO;
    
    UIImageView *cardImageView1 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card1"]];
    [cardScrollView addSubview:cardImageView1];
    cardImageView1.frame = CGRectMake(0, 0, cardImageView1.frame.size.width, cardImageView1.frame.size.height);
    
    UIImageView *cardImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card2"]];
    [cardScrollView addSubview:cardImageView2];
    cardImageView2.frame = CGRectMake(cardImageView2.frame.size.width, 0, cardImageView2.frame.size.width, cardImageView2.frame.size.height);
    
    UIImageView *cardImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card3"]];
    [cardScrollView addSubview:cardImageView3];
    cardImageView3.frame = CGRectMake(cardImageView3.frame.size.width * 2, 0, cardImageView3.frame.size.width, cardImageView3.frame.size.height);
    
    UIImageView *cardImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card4"]];
    [cardScrollView addSubview:cardImageView4];
    cardImageView4.frame = CGRectMake(cardImageView4.frame.size.width * 3, 0, cardImageView4.frame.size.width, cardImageView4.frame.size.height);
    
    UIImageView *cardImageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card5"]];
    [cardScrollView addSubview:cardImageView5];
    cardImageView5.frame = CGRectMake(cardImageView5.frame.size.width * 4, 0, cardImageView5.frame.size.width, cardImageView5.frame.size.height);
    
    UIImageView *cardImageView6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"card6"]];
    [cardScrollView addSubview:cardImageView6];
    cardImageView6.frame = CGRectMake(cardImageView6.frame.size.width * 5, 0, cardImageView6.frame.size.width, cardImageView6.frame.size.height);
    
    
    
    self.headlinesImageView.image = [UIImage imageNamed:@"mountain"];
    timer = [NSTimer scheduledTimerWithTimeInterval:2.8 target:self selector:@selector(onTimer) userInfo:nil repeats:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    if (timer != nil) {
        [timer invalidate];
    }
}

- (void)onTimer {
    int r = arc4random_uniform(4);
    
    if (r == 0) {
        [UIView animateWithDuration:0.3 animations:^ {
            
            self.headlinesImageView.image = [UIImage imageNamed:@"rocks"];
        }];
    } else if (r == 1) {
        [UIView animateWithDuration:0.3 animations:^ {
            self.headlinesImageView.image = [UIImage imageNamed:@"tree"];
        }];
    } else if (r == 2) {
        [UIView animateWithDuration:0.3 animations:^ {
            self.headlinesImageView.image = [UIImage imageNamed:@"green"];
        }];
    } else if (r == 3) {
        [UIView animateWithDuration:0.3 animations:^ {
            self.headlinesImageView.image = [UIImage imageNamed:@"mountain"];
        }];
    }
    
    
}

- (void)onHeadlinePan:(UIPanGestureRecognizer *)panGestureRecognizer {
    
    CGPoint viewCenter = self.headlinesScrollView.center;
    CGPoint translation = [panGestureRecognizer translationInView:self.headlinesScrollView.superview];
    CGPoint velocity = [panGestureRecognizer velocityInView:self.headlinesScrollView.superview];
    
    self.headlinesScrollView.center = CGPointMake(viewCenter.x, viewCenter.y + translation.y);
    [panGestureRecognizer setTranslation:CGPointZero inView:self.headlinesScrollView.superview];
    if (viewCenter.y < 568 && velocity.y < 0) {
        
        self.headlinesScrollView.center = CGPointMake(viewCenter.x, viewCenter.y + (translation.y / 10));
        [panGestureRecognizer setTranslation:CGPointZero inView:self.headlinesScrollView.superview];
    }
    
    if (panGestureRecognizer.state == UIGestureRecognizerStateEnded) {
        if (velocity.y > 0) {
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:0 animations:^ {
                self.headlinesScrollView.frame = CGRectMake(0, 500, self.headlinesScrollView.frame.size.width, self.headlinesScrollView.frame.size.height);
            }completion:nil];
        } else if (velocity.y < 0) {
            [UIView animateWithDuration:0.3 delay:0 usingSpringWithDamping:0.8 initialSpringVelocity:10 options:0 animations:^{
                self.headlinesScrollView.frame = CGRectMake(0, 0, self.headlinesScrollView.frame.size.width, self.headlinesScrollView.frame.size.height);
            }completion:nil];
        }
    }
}
@end






