//
//  ThemesViewController.m
//  ChatApp
//
//  Created by Антон Бобрышев on 10.10.2021.
//

#import "ThemesViewController.h"

@interface ThemesViewController ()

@end

@implementation ThemesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"Hello, World!");
//    self.view.backgroundColor = [UIColor redColor];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)themesViewController: (ThemesViewController *)controller {
    
}

- (IBAction)orangeThemeButtonTapped:(id)sender {
    [self themesViewController];
    Themes *test = [[Themes alloc]init];
    test.lightTheme = [UIColor whiteColor];
    
    self.view.backgroundColor = test.lightTheme;
//    self.view.backgroundColor = [UIColor orangeColor];
}

- (IBAction)darkThemeButtonTapped:(id)sender {
    NSLog(@"Hello, World!");
    self.view.backgroundColor = [UIColor blackColor];
}

- (IBAction)lightThemeButtonTapped:(id)sender {
    NSLog(@"Hello, World!");
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)themesViewController { 
    NSLog(@"Hello, PE!");
}


@end
