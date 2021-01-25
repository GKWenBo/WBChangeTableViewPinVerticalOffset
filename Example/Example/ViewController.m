//
//  ViewController.m
//  Example
//
//  Created by wenbo on 2021/1/25.
//

#import "ViewController.h"
#import "UITableView+WBPinVerticalOffset.h"

#define KM_RANDOMCOLOR [UIColor colorWithRed:arc4random() % 255 /255.0f green:arc4random() % 255 / 255.0f blue:arc4random() % 255 / 255.0f alpha:1.0f]

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 200)];
    header.backgroundColor = KM_RANDOMCOLOR;
    self.tableView.tableHeaderView = header;
    
    self.tableView.wb_pinSectionHeaderVerticalOffset = 88;
}

// MARK: - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 50;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *identifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.contentView.backgroundColor = KM_RANDOMCOLOR;
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    static NSString *identifier = @"header";
    UITableViewHeaderFooterView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:identifier];
    if (headerView) {
        headerView = [[UITableViewHeaderFooterView alloc] initWithReuseIdentifier:identifier];
    }
    headerView.contentView.backgroundColor = KM_RANDOMCOLOR;
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 100;
}

// MARK: - UIScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    NSLog(@"offset.y = %f", scrollView.contentOffset.y);
    
    [self.tableView wb_handlePinVerticalOffset:self];
}

@end
