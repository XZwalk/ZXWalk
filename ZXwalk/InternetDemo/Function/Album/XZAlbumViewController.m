//
//  XZAlbumViewController.m
//  ZXwalk
//
//  Created by 张祥 on 15/8/8.
//  Copyright (c) 2015年 张祥. All rights reserved.
//

#import "XZAlbumViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"


@interface XZAlbumViewController ()
@property (nonatomic, strong) UIImage *image;

@end

@implementation XZAlbumViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    //jpg不要忘加后缀名
    self.image = [UIImage imageNamed:@"caoyuan.jpg"];
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake((kScreenWidth - 300) / 2, 70, 300, 150)];
    imageView.image = self.image;
    [self.view addSubview:imageView];
    
    UIButton *button = [[UIButton alloc] init];
    button.frame = CGRectMake( 100, 300, kScreenWidth - 200, 40);
    [button addTarget:self action:@selector(actionClick:) forControlEvents:UIControlEventTouchUpInside];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor orangeColor]];
    [button setTitle:@"SavePhoto" forState:UIControlStateNormal];
    [self.view addSubview:button];
    
    UIButton *buttonSaveAlbum = [[UIButton alloc] init];
    buttonSaveAlbum.frame = CGRectMake( 100, 360, kScreenWidth - 200, 40);
    [buttonSaveAlbum addTarget:self action:@selector(createAlbum:) forControlEvents:UIControlEventTouchUpInside];
    [buttonSaveAlbum setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [buttonSaveAlbum setBackgroundColor:[UIColor orangeColor]];
    [buttonSaveAlbum setTitle:@"CreateAlbum" forState:UIControlStateNormal];
    [self.view addSubview:buttonSaveAlbum];
}


//保存到本地相册
- (void)actionClick:(UIButton *)button
{
    //将图片保存到系统相册
    UIImageWriteToSavedPhotosAlbum(self.image, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"图片保存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
    
    [alertView show];

    
}


//保存到指定相册
- (void)createAlbum:(UIButton *)button
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    
    //将图片保存到指定的相册内
    [library saveImage:self.image toAlbum:@"xiangzi" completion:^(NSURL *assetURL, NSError *error) {
        
        //如果有需要可以在这里写方法, 防止图片重复保存
        
        
        if (!error) {
            
        }
    } failure:^(NSError *error) {
        if (error) {
            
        }
    }];
    
  
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        [self createAlbum];
        
    });
}

#pragma mark - 创建相册
- (void)createAlbum
{
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    NSMutableArray *groups=[[NSMutableArray alloc] init];
    ALAssetsLibraryGroupsEnumerationResultsBlock listGroupBlock = ^(ALAssetsGroup *group, BOOL *stop)
    {
        if (group)
        {
            [groups addObject:group];
        } else {
            
            BOOL haveHDRGroup = NO;
            
            for (ALAssetsGroup *gp in groups)
            {
                NSString *name =[gp valueForProperty:ALAssetsGroupPropertyName];
                
                if ([name isEqualToString:@"xiangzi"])
                {
                    haveHDRGroup = YES;
                }
            }
            
            
            if (!haveHDRGroup)
            {
                //do add a group named "XXXX"
                [assetsLibrary addAssetsGroupAlbumWithName:@"xiangzi"
                                               resultBlock:^(ALAssetsGroup *group)
                 {
                     //第一次保存成功之后进入到系统相册, 删除相册, 然后在创建会崩溃, 除非把相册名字改了
                         [groups addObject:group];
                 }
                                              failureBlock:nil];
                haveHDRGroup = YES;
            }
        }
        
    };
    
    
    
    
    //创建相簿
    [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:listGroupBlock failureBlock:nil];
    
    [self saveToAlbumWithMetadata:nil imageData:UIImagePNGRepresentation(self.image) customAlbumName:@"xiangzi" completionBlock:^
     {
         //这里可以创建添加成功的方法
         //因为我这里创建相册什么的都是在子线程, 所以alertView的显示要在主线程, 因为它是UI层面的, 刷新和显示UI要在主线程
         dispatch_async(dispatch_get_main_queue(), ^{
             
             //在主线程弹窗提示
             UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"图片保存成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
             
             [alertView show];
             
         });
         
     }
                     failureBlock:^(NSError *error)
     {
         //处理添加失败的方法显示alert让它回到主线程执行，不然那个框框死活不肯弹出来
         dispatch_async(dispatch_get_main_queue(), ^{
             
             //添加失败一般是由用户不允许应用访问相册造成的，这边可以取出这种情况加以判断一下
             if([error.localizedDescription rangeOfString:@"User denied access"].location != NSNotFound ||[error.localizedDescription rangeOfString:@"用户拒绝访问"].location!=NSNotFound){
                 UIAlertView *alert=[[UIAlertView alloc]initWithTitle:error.localizedDescription message:error.localizedFailureReason delegate:nil cancelButtonTitle:NSLocalizedString(@"ok", nil) otherButtonTitles: nil];
                 
                 [alert show];
             }
         });
     }];
}

- (void)saveToAlbumWithMetadata:(NSDictionary *)metadata
                      imageData:(NSData *)imageData
                customAlbumName:(NSString *)customAlbumName
                completionBlock:(void (^)(void))completionBlock
                   failureBlock:(void (^)(NSError *error))failureBlock
{
    
    ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
    __weak ALAssetsLibrary *weakSelf = assetsLibrary;
    void (^AddAsset)(ALAssetsLibrary *, NSURL *) = ^(ALAssetsLibrary *assetsLibrary, NSURL *assetURL) {
        [assetsLibrary assetForURL:assetURL resultBlock:^(ALAsset *asset) {
            [assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
                
                if ([[group valueForProperty:ALAssetsGroupPropertyName] isEqualToString:customAlbumName]) {
                    [group addAsset:asset];
                    if (completionBlock) {
                        completionBlock();
                    }
                }
            } failureBlock:^(NSError *error) {
                if (failureBlock) {
                    failureBlock(error);
                }
            }];
        } failureBlock:^(NSError *error) {
            if (failureBlock) {
                failureBlock(error);
            }
        }];
    };
    [assetsLibrary writeImageDataToSavedPhotosAlbum:imageData metadata:metadata completionBlock:^(NSURL *assetURL, NSError *error) {
        if (customAlbumName) {
            [assetsLibrary addAssetsGroupAlbumWithName:customAlbumName resultBlock:^(ALAssetsGroup *group) {
                if (group) {
                    [weakSelf assetForURL:assetURL resultBlock:^(ALAsset *asset) {
                        [group addAsset:asset];
                        if (completionBlock) {
                            completionBlock();
                        }
                    } failureBlock:^(NSError *error) {
                        if (failureBlock) {
                            failureBlock(error);
                        }
                    }];
                } else {
                    AddAsset(weakSelf, assetURL);
                }
            } failureBlock:^(NSError *error) {
                AddAsset(weakSelf, assetURL);
            }];
        } else {
            if (completionBlock) {
                completionBlock();
            }
        }
    }];
}





// 指定回调方法
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    
    
    
    if(!error){
        NSLog(@"save success");
    }else{
        NSLog(@"save failed");
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
