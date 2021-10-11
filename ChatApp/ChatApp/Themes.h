//
//  Themes.h
//  ChatApp
//
//  Created by Антон Бобрышев on 10.10.2021.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Themes : NSObject
{
    UIColor* lightTheme;
    UIColor* darkTheme;
    UIColor* orangeTheme;
}

@property (retain) UIColor* lightTheme;
@property (retain) UIColor* darkTheme;
@property (retain) UIColor* orangeTheme;

@end

NS_ASSUME_NONNULL_END
