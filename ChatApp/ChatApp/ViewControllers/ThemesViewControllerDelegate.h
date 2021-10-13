//
//  ThemesViewControllerDelegate.h
//  ChatApp
//
//  Created by Антон Бобрышев on 10.10.2021.
//

#import <Foundation/Foundation.h>
#import "ThemesViewController.h"



NS_ASSUME_NONNULL_BEGIN
@class ThemesViewController;
@protocol ThemesViewControllerDelegate <NSObject>

-(void) themesViewController: (ThemesViewController*) controller didSelectedTheme: (UIColor*) selectedTheme;


@end

NS_ASSUME_NONNULL_END


//- (void)themesViewController: (ThemesViewController *)controller didSelectTheme:(UIColor *)selectedTheme;
