#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface Controll : NSObject

+(UIButton *)creatButtonFrame:(CGRect)frame buttonTitle:(NSString *)title buttonTitleColor:(UIColor *)color;

+(UITextField *)creatTextFiledFrame:(CGRect)frame textFieldPlacehoder:(NSString *)placeholder;

@end
