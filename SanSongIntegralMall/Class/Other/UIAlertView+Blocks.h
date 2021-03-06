//
//  UIAlertView+Blocks.h
//  UIKitCategoryAdditions
//
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

typedef void (^DismissBlock)(int buttonIndex);
typedef void (^CancelBlock)(void);

@interface UIAlertView (Blocks) <UIAlertViewDelegate> 

+ (UIAlertView*) showAlertViewWithTitle:(NSString*) title                    
                                message:(NSString*) message 
                      cancelButtonTitle:(NSString*) cancelButtonTitle
                      otherButtonTitles:(NSArray*) otherButtons
                              onDismiss:(DismissBlock) dismissed                   
                               onCancel:(CancelBlock) cancelled;

@end
