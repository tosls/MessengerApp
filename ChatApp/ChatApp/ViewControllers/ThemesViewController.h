//
//  ThemesViewController.h
//  ChatApp
//
//  Created by Антон Бобрышев on 10.10.2021.
//

#import <UIKit/UIKit.h>
#import "ThemesViewControllerDelegate.h"
#import "Themes.h"

NS_ASSUME_NONNULL_BEGIN

@interface ThemesViewController : UIViewController <ThemesViewControllerDelegate>
{
    
}
@property(retain, nonatomic) id<ThemesViewControllerDelegate> delegate;
@property(retain, nonatomic) UIColor *lightTheme;
@property(retain, nonatomic) UIColor *darkTheme;
@property(retain, nonatomic) UIColor *orangeTheme;

@property (retain, nonatomic) IBOutlet UIButton *lightThemeButton;
@property (retain, nonatomic) IBOutlet UIButton *darkThemeButton;
@property (retain, nonatomic) IBOutlet UIButton *customThemeBotton;


- (IBAction)lightThemeButtonTapped:(id)sender;
- (IBAction)darkThemeButtonTapped:(id)sender;
- (IBAction)customThemeButtonTapped:(id)sender;
- (IBAction)closeButtonTapped:(id)sender;



@end

NS_ASSUME_NONNULL_END
