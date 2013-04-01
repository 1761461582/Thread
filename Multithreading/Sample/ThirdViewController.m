//
//  ThirdViewController.m
//  Multithreading
//
//  Created by Juxue Chen on 13-3-29.
//
//

#import "ThirdViewController.h"

@interface ThirdViewController ()

@end

@implementation ThirdViewController

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
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createConsumer {
    self.label.text = [NSString stringWithFormat:@"消费者：得锁，i=%d",i];
    [codition lock];
    
    while (i == 0) {
         NSLog(@"等待生产者");
        [codition wait];
    }

    self.label.text = [self.label.text stringByAppendingFormat:@"\n消费者：等待结束，i=%d",i];

    self.label.text = [self.label.text stringByAppendingString:@"\n消费者：解锁"];
    [codition unlock];
}

- (void)createProducer {
    self.label.text = [self.label.text stringByAppendingFormat:@"\n生产者：得锁，i=%d",i];
    [codition lock];
    
    self.label.text = [self.label.text stringByAppendingFormat:@"\n生产者：生产需要2秒钟，i=%d",i];
    [NSThread sleepForTimeInterval:2.0];
    i++;
    self.label.text = [self.label.text stringByAppendingFormat:@"\n生产者：生产完毕，i=%d",i];
    
    self.label.text = [self.label.text stringByAppendingFormat:@"\n生产者：发signal，唤醒wait的消费者（线程），i=%d",i];
    [codition signal];
    
    self.label.text = [self.label.text stringByAppendingString:@"\n生产者：解锁"];
    [codition unlock];
}


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
//通过alloc 创建的线程，需要start才可以执行
//detachNewThreadSelector 方法可以自动执行
    
    [NSThread detachNewThreadSelector:@selector(createConsumer) toTarget:self withObject:nil];
    [NSThread detachNewThreadSelector:@selector(createProducer) toTarget:self withObject:nil];

}

@end
