//
//  LoginTransitionSever.h
//  IphoneIJiJin
//
//  Created by ttyy on 15/10/21.
//
//

#import <Foundation/Foundation.h>

@interface OpenAccountTransitionPrompt : NSObject


//记录基金代码
@property (nonatomic, copy, nullable) NSString *fundCode;



- (BOOL)checkIsLoginBefore;

- (void)show;

- (void)loginAction;



@end
