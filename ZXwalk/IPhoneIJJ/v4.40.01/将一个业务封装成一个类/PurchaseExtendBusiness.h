//
//  PurchaseExtendServer.h
//  IphoneIJiJin
//
//  Created by ttyy on 15/10/20.
//
//

#import <Foundation/Foundation.h>

@interface PurchaseExtendBusiness : NSObject

@property (nonatomic, strong)NSDictionary *showButtonRule;


//容器view的创建是在业务里面实现的
@property (nonatomic, strong)UICollectionView *chooseListView;


@end
