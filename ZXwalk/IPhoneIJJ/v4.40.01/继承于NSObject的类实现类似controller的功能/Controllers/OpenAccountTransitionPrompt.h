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


//不变的东西封装起来,变化的东西拿出去
- (BOOL)checkIsLoginBefore;

- (void)show;

- (void)loginAction;



@end
