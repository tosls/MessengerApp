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
    _lightThemeButton.layer.cornerRadius = 10;
    _darkThemeButton.layer.cornerRadius = 10;
    _customThemeBotton.layer.cornerRadius = 10;
}

- (UIColor *)lightTheme {
    return [UIColor whiteColor];
}
- (UIColor *)darkTheme {
    return [UIColor blackColor];
}
- (UIColor *)orangeTheme {
    return [UIColor orangeColor];
}

@synthesize delegate;


-(void) themesViewController: (ThemesViewController*) controller didSelectedTheme: (UIColor*) selectedTheme{
    NSLog(@"ThemeMethod");
    controller.view.backgroundColor = selectedTheme;
}

- (IBAction)closeButtonTapped:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

- (IBAction)customThemeButtonTapped:(id)sender {
    self.view.backgroundColor = self.orangeTheme;
    [self.delegate themesViewController:self didSelectedTheme:self.orangeTheme];
}

- (IBAction)darkThemeButtonTapped:(id)sender {
    self.view.backgroundColor = self.darkTheme;
    [self.delegate themesViewController:self didSelectedTheme:self.darkTheme];
}

- (IBAction)lightThemeButtonTapped:(id)sender {
    self.view.backgroundColor = self.lightTheme;
    [self.delegate themesViewController:self didSelectedTheme:self.lightTheme];
}

- (void)dealloc {
    [_lightThemeButton release];
    [_darkThemeButton release];
    [_customThemeBotton release];
    [super dealloc];
}
@end





