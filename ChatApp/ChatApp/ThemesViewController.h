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
    Themes *model;
}


- (IBAction)lightThemeButtonTapped:(id)sender;
- (IBAction)darkThemeButtonTapped:(id)sender;
- (IBAction)orangeThemeButtonTapped:(id)sender;


@end

NS_ASSUME_NONNULL_END
