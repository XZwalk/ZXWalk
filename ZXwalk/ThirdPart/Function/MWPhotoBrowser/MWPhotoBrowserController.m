//
//  Menu.m
//  MWPhotoBrowser
//
//  Created by Michael Waterfall on 21/10/2010.
//  Copyright 2010 d3i. All rights reserved.
//

#import <Photos/Photos.h>
#import "MWPhotoBrowserController.h"
#import "SDImageCache.h"
#import "MWCommon.h"

@implementation MWPhotoBrowserController

#pragma mark -
#pragma mark Initialization(初始化)

- (id)initWithCoder:(NSCoder *)aDecoder {
    
    //这里的代码不会走, 只有用xib或者StoryBoard的工程, 在初始化所拖的控件(view或controller)的时候才会从这里走
    return self;
}


- (void)segmentChange {
    
    //当分段选择器值改变的时候刷新数据
    [self.tableView reloadData];
}


#pragma mark - 互斥锁

- (void)synchronizedIntroduce {
    
    //@synchronized 的作用是创建一个互斥锁，保证此时没有其它线程对self对象进行修改。这个是objective-c的一个锁定令牌，防止self对象在同一时间内被其它线程访问，起到线程的保护作用。 一般在公用变量的时候使用，如单例模式或者操作类的static变量中使用。
    
    
    //指令@synchronized()通过对一段代码的使用进行加锁。其他试图执行该段代码的线程都会被阻塞，直到加锁线程退出执行该段被保护的代码段，也就是说@synchronized()代码块中的最后一条语句已经被执行完毕的时候。
    
    
    //指令@synchronized()需要一个参数。该参数可以使任何的Objective-C对象，包括self。这个对象就是互斥信号量。他能够让一个线程对一段代码进行保护，避免别的线程执行该段代码。针对程序中的不同的关键代码段，我们应该分别使用不同的信号量。只有在应用程序编程执行多线程之前就创建好所有需要的互斥信号量对象来避免线程间的竞争才是最安全的。
    
    
}









#pragma mark -
#pragma mark View

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"MWPhotoBrowser";
    
    // Clear cache for testing
    [[SDImageCache sharedImageCache] clearDisk];
    [[SDImageCache sharedImageCache] clearMemory];
    
    _segmentedControl = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Push", @"Modal", nil]];
    _segmentedControl.selectedSegmentIndex = 0;
    [_segmentedControl addTarget:self action:@selector(segmentChange) forControlEvents:UIControlEventValueChanged];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:_segmentedControl];
    self.navigationItem.rightBarButtonItem = item;
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [self loadAssets];

}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
//    self.navigationController.navigationBar.barTintColor = [UIColor greenColor];
//    self.navigationController.navigationBar.translucent = NO;
//    [self.navigationController setNavigationBarHidden:YES animated:YES];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
//    [self.navigationController setNavigationBarHidden:NO animated:YES];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (BOOL)prefersStatusBarHidden {
    return NO;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    return UIStatusBarAnimationNone;
}

#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger rows = 9;
    @synchronized(_assets) {
        if (_assets.count) rows++;
    }
    return rows;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
	// Create
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    cell.accessoryType = _segmentedControl.selectedSegmentIndex == 0 ? UITableViewCellAccessoryDisclosureIndicator : UITableViewCellAccessoryNone;

    // Configure
	switch (indexPath.row) {
		case 0: {
            cell.textLabel.text = @"Single photo";
            cell.detailTextLabel.text = @"with caption, no grid button";
            break;
        }
		case 1: {
            cell.textLabel.text = @"Multiple photos and video";
            cell.detailTextLabel.text = @"with captions";
            break;
        }
		case 2: {
            cell.textLabel.text = @"Multiple photo grid";
            cell.detailTextLabel.text = @"showing grid first, nav arrows enabled";
            break;
        }
		case 3: {
            cell.textLabel.text = @"Photo selections";
            cell.detailTextLabel.text = @"selection enabled";
            break;
        }
		case 4: {
            cell.textLabel.text = @"Photo selection grid";
            cell.detailTextLabel.text = @"selection enabled, start at grid";
            break;
        }
		case 5: {
            cell.textLabel.text = @"Web photos";
            cell.detailTextLabel.text = @"photos from web";
            break;
        }
        case 6: {
            cell.textLabel.text = @"Web photo grid";
            cell.detailTextLabel.text = @"showing grid first";
            break;
        }
        case 7: {
            cell.textLabel.text = @"Single video";
            cell.detailTextLabel.text = @"with auto-play";
            break;
        }
        case 8: {
            cell.textLabel.text = @"Web videos";
            cell.detailTextLabel.text = @"showing grid first";
            break;
        }
		case 9: {
            cell.textLabel.text = @"Library photos and videos";
            cell.detailTextLabel.text = @"media from device library";
            break;
        }
		default: break;
	}
    return cell;
	
}

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	// Browser
	NSMutableArray *photos = [[NSMutableArray alloc] init];
	NSMutableArray *thumbs = [[NSMutableArray alloc] init];
    MWPhoto *photo, *thumb;
    BOOL displayActionButton = YES;
    BOOL displaySelectionButtons = NO;
    BOOL displayNavArrows = NO;
    BOOL enableGrid = YES;
    BOOL startOnGrid = NO;
    BOOL autoPlayOnAppear = NO;
	switch (indexPath.row) {
		case 0:
            // Photos
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]]];
            photo.caption = @"The London Eye is a giant Ferris wheel situated on the banks of the River Thames, in London, England.";
			[photos addObject:photo];
            // Options
            enableGrid = NO;
			break;
		case 1: {
            // Local Photos and Videos
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo5" ofType:@"jpg"]]];
            photo.caption = @"Fireworks";
			[photos addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]]];
            photo.caption = @"The London Eye is a giant Ferris wheel situated on the banks of the River Thames, in London, England.";
			[photos addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
            photo.caption = @"York Floods";
            [photos addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video_thumb" ofType:@"jpg"]]];
            photo.videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
            photo.caption = @"Big Buck Bunny";
            [photos addObject:photo];
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo4" ofType:@"jpg"]]];
            photo.caption = @"Campervan";
			[photos addObject:photo];
            // Options
            enableGrid = NO;
			break;
        }
		case 2: {
            // Photos
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo5" ofType:@"jpg"]]];
            photo.caption = @"White Tower";
			[photos addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]]];
            photo.caption = @"The London Eye is a giant Ferris wheel situated on the banks of the River Thames, in London, England.";
			[photos addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
            photo.caption = @"York Floods";
			[photos addObject:photo];
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo4" ofType:@"jpg"]]];
            photo.caption = @"Campervan";
			[photos addObject:photo];
            // Thumbs
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo5t" ofType:@"jpg"]]];
			[thumbs addObject:photo];
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo2t" ofType:@"jpg"]]];
			[thumbs addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3t" ofType:@"jpg"]]];
			[thumbs addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo4t" ofType:@"jpg"]]];
			[thumbs addObject:photo];
            // Options
            startOnGrid = YES;
            displayNavArrows = YES;
			break;
        }
		case 3:
		case 4: {
            // Photos
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo4" ofType:@"jpg"]]];
			[photos addObject:photo];
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo1" ofType:@"jpg"]]];
			[photos addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2" ofType:@"jpg"]]];
			[photos addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
			[photos addObject:photo];
            // Thumbs
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo4t" ofType:@"jpg"]]];
			[thumbs addObject:photo];
            photo = [MWPhoto photoWithImage:[UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"photo1t" ofType:@"jpg"]]];
			[thumbs addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo2t" ofType:@"jpg"]]];
			[thumbs addObject:photo];
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"photo3t" ofType:@"jpg"]]];
			[thumbs addObject:photo];
            // Options
            displayActionButton = NO;
            displaySelectionButtons = YES;
            startOnGrid = indexPath.row == 4;
            enableGrid = NO;
			break;
        }
		case 5:
            // Photos
			[photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_b.jpg"]]];
			[photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_b.jpg"]]];
			[photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_b.jpg"]]];
			[photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_b.jpg"]]];
			[photos addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_b.jpg"]]];
            // Thumbs
			[thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3567/3523321514_371d9ac42f_q.jpg"]]];
			[thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3629/3339128908_7aecabc34b_q.jpg"]]];
			[thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3364/3338617424_7ff836d55f_q.jpg"]]];
			[thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm4.static.flickr.com/3590/3329114220_5fbc5bc92b_q.jpg"]]];
			[thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://farm3.static.flickr.com/2449/4052876281_6e068ac860_q.jpg"]]];
            // Options
			break;
		case 6:
            // Photos & thumbs
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/baike/pic/item/962bd40735fae6cd7c9f47060cb30f2442a70fa9.jpg"]];
            photo.caption = @"Mannequin Half Light";
            [photos addObject:photo];
            [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/baike/pic/item/962bd40735fae6cd7c9f47060cb30f2442a70fa9.jpg"]]];
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/forum/w%3D580/sign=ad257838344e251fe2f7e4f09786c9c2/19ad256d55fbb2fbaf0782104b4a20a44623dc4c.jpg"]];
            photo.caption = @"Mannequin Side Light";
            [photos addObject:photo];
            [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://imgsrc.baidu.com/forum/w%3D580/sign=ad257838344e251fe2f7e4f09786c9c2/19ad256d55fbb2fbaf0782104b4a20a44623dc4c.jpg"]]];
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://www.iqingdao.com/uploadfile/2015/0127/20150127035708691.jpg"]];
            photo.caption = @"Mannequin";
            [photos addObject:photo];
            [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://www.iqingdao.com/uploadfile/2015/0127/20150127035708691.jpg"]]];
            photo = [MWPhoto photoWithURL:[NSURL URLWithString:@"http://ww2.sinaimg.cn/bmiddle/4c139ad1jw1ef2v10fjojj20dc0hsdhs.jpg"]];
            photo.caption = @"Mannequin DoF";
            [photos addObject:photo];
            [thumbs addObject:[MWPhoto photoWithURL:[NSURL URLWithString:@"http://ww2.sinaimg.cn/bmiddle/4c139ad1jw1ef2v10fjojj20dc0hsdhs.jpg"]]];
            // Options
            startOnGrid = YES;
			break;
        case 7: {
            
            // Single video
            photo = [MWPhoto photoWithURL:[NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video_thumb" ofType:@"jpg"]]];
            photo.videoURL = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"video" ofType:@"mp4"]];
            [photos addObject:photo];
            enableGrid = NO;
            autoPlayOnAppear = YES;
            break;
            
        }
		case 8: {
            
            // Videos
            
            photo = [MWPhoto photoWithURL:[[NSURL alloc] initWithString:@"http://121.41.88.127:8080/zhangchu/HandheldKitchen/android_a/20130326193119230.jpg"]];
            photo.videoURL = [[NSURL alloc] initWithString:@"http://121.40.54.242:280/zhangchu/video/mp4/paocaichaoniangaoA.mp4"];
            [photos addObject:photo];
            thumb = [MWPhoto photoWithURL:[[NSURL alloc] initWithString:@"http://121.41.88.127:8080/zhangchu/HandheldKitchen/ipad_t/20130326193119230.jpg"]];
            thumb.isVideo = YES;
            [thumbs addObject:thumb];
            
            // Test video with no poster frame
//            photo = [MWPhoto videoWithURL:[[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xfa1/t50.2886-16/11237510_945154435524423_2137519922_n.mp4"]];
//            [photos addObject:photo];
//            thumb = [MWPhoto new];
//            thumb.isVideo = YES;
//            [thumbs addObject:thumb];
            
            photo = [MWPhoto photoWithURL:[[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/e15/11240463_963135443745570_1519872157_n.jpg"]];
            photo.videoURL = [[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xfa1/t50.2886-16/11237510_945154435524423_2137519922_n.mp4"];
            [photos addObject:photo];
            thumb = [MWPhoto photoWithURL:[[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/s150x150/e15/11240463_963135443745570_1519872157_n.jpg"]];
            thumb.isVideo = YES;
            [thumbs addObject:thumb];
            
            photo = [MWPhoto photoWithURL:[[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/e15/11313531_1625089227727682_169403963_n.jpg"]];
            photo.videoURL = [[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xfa1/t50.2886-16/11336249_1783839318509644_116225363_n.mp4"];
            [photos addObject:photo];
            thumb = [MWPhoto photoWithURL:[[NSURL alloc] initWithString:@"https://scontent.cdninstagram.com/hphotos-xaf1/t51.2885-15/s150x150/e15/11313531_1625089227727682_169403963_n.jpg"]];
            thumb.isVideo = YES;
            [thumbs addObject:thumb];
            
            // Options
            startOnGrid = YES;
            break;
        }
		case 9: {
            @synchronized(_assets) {
                NSMutableArray *copy = [_assets copy];
                if (NSClassFromString(@"PHAsset")) {
                    // Photos library
                    UIScreen *screen = [UIScreen mainScreen];
                    CGFloat scale = screen.scale;
                    // Sizing is very rough... more thought required in a real implementation
                    CGFloat imageSize = MAX(screen.bounds.size.width, screen.bounds.size.height) * 1.5;
                    CGSize imageTargetSize = CGSizeMake(imageSize * scale, imageSize * scale);
                    CGSize thumbTargetSize = CGSizeMake(imageSize / 3.0 * scale, imageSize / 3.0 * scale);
                    for (PHAsset *asset in copy) {
                        [photos addObject:[MWPhoto photoWithAsset:asset targetSize:imageTargetSize]];
                        [thumbs addObject:[MWPhoto photoWithAsset:asset targetSize:thumbTargetSize]];
                    }
                } else {
                    // Assets library
                    for (ALAsset *asset in copy) {
                        MWPhoto *photo = [MWPhoto photoWithURL:asset.defaultRepresentation.url];
                        [photos addObject:photo];
                        MWPhoto *thumb = [MWPhoto photoWithImage:[UIImage imageWithCGImage:asset.thumbnail]];
                        [thumbs addObject:thumb];
                        if ([asset valueForProperty:ALAssetPropertyType] == ALAssetTypeVideo) {
                            photo.videoURL = asset.defaultRepresentation.url;
                            thumb.isVideo = true;
                        }
                    }
                }
            }
			break;
        }
		default: break;
	}
    self.photos = photos;
    self.thumbs = thumbs;
	
	// Create browser
	MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = displayActionButton;
    browser.displayNavArrows = displayNavArrows;
    browser.displaySelectionButtons = displaySelectionButtons;
    browser.alwaysShowControls = displaySelectionButtons;
    browser.zoomPhotosToFill = YES;
    browser.enableGrid = enableGrid;
    browser.startOnGrid = startOnGrid;
    browser.enableSwipeToDismiss = NO;
    browser.autoPlayOnAppear = autoPlayOnAppear;
    [browser setCurrentPhotoIndex:0];
    
    // Test custom selection images
//    browser.customImageSelectedIconName = @"ImageSelected.png";
//    browser.customImageSelectedSmallIconName = @"ImageSelectedSmall.png";
    
    // Reset selections
    if (displaySelectionButtons) {
        _selections = [NSMutableArray new];
        for (int i = 0; i < photos.count; i++) {
            [_selections addObject:[NSNumber numberWithBool:NO]];
        }
    }
    
    // Show
    if (_segmentedControl.selectedSegmentIndex == 0) {
        // Push
        [self.navigationController pushViewController:browser animated:YES];
    } else {
        // Modal
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:browser];
        nc.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:nc animated:YES completion:nil];
    }
    
    // Release
	
	// Deselect
	[self.tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    // Test reloading of data after delay
    double delayInSeconds = 3;
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    
//        // Test removing an object
//        [_photos removeLastObject];
//        [browser reloadData];
//    
//        // Test all new
//        [_photos removeAllObjects];
//        [_photos addObject:[MWPhoto photoWithFilePath:[[NSBundle mainBundle] pathForResource:@"photo3" ofType:@"jpg"]]];
//        [browser reloadData];
//    
//        // Test changing photo index
//        [browser setCurrentPhotoIndex:9];
    
//        // Test updating selections
//        _selections = [NSMutableArray new];
//        for (int i = 0; i < [self numberOfPhotosInPhotoBrowser:browser]; i++) {
//            [_selections addObject:[NSNumber numberWithBool:YES]];
//        }
//        [browser reloadData];
        
    });

}

#pragma mark - MWPhotoBrowserDelegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return _photos.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    if (index < _photos.count)
        return [_photos objectAtIndex:index];
    return nil;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser thumbPhotoAtIndex:(NSUInteger)index {
    if (index < _thumbs.count)
        return [_thumbs objectAtIndex:index];
    return nil;
}

//- (MWCaptionView *)photoBrowser:(MWPhotoBrowser *)photoBrowser captionViewForPhotoAtIndex:(NSUInteger)index {
//    MWPhoto *photo = [self.photos objectAtIndex:index];
//    MWCaptionView *captionView = [[MWCaptionView alloc] initWithPhoto:photo];
//    return [captionView autorelease];
//}

//- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser actionButtonPressedForPhotoAtIndex:(NSUInteger)index {
//    NSLog(@"ACTION!");
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser didDisplayPhotoAtIndex:(NSUInteger)index {
    NSLog(@"Did start viewing photo at index %lu", (unsigned long)index);
}

- (BOOL)photoBrowser:(MWPhotoBrowser *)photoBrowser isPhotoSelectedAtIndex:(NSUInteger)index {
    return [[_selections objectAtIndex:index] boolValue];
}

//- (NSString *)photoBrowser:(MWPhotoBrowser *)photoBrowser titleForPhotoAtIndex:(NSUInteger)index {
//    return [NSString stringWithFormat:@"Photo %lu", (unsigned long)index+1];
//}

- (void)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index selectedChanged:(BOOL)selected {
    [_selections replaceObjectAtIndex:index withObject:[NSNumber numberWithBool:selected]];
    NSLog(@"Photo at index %lu selected %@", (unsigned long)index, selected ? @"YES" : @"NO");
}

- (void)photoBrowserDidFinishModalPresentation:(MWPhotoBrowser *)photoBrowser {
    // If we subscribe to this method we must dismiss the view controller ourselves
    NSLog(@"Did finish modal presentation");
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Load Assets

- (void)loadAssets {
    if (NSClassFromString(@"PHAsset")) {
        
        // Check library permissions
        PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
        if (status == PHAuthorizationStatusNotDetermined) {
            [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
                if (status == PHAuthorizationStatusAuthorized) {
                    [self performLoadAssets];
                }
            }];
        } else if (status == PHAuthorizationStatusAuthorized) {
            [self performLoadAssets];
        }
        
    } else {
        
        // Assets library
        [self performLoadAssets];
        
    }
}

- (void)performLoadAssets {
    
    // Initialise
    _assets = [NSMutableArray new];
    
    // Load
    if (NSClassFromString(@"PHAsset")) {
        
        // Photos library iOS >= 8
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            PHFetchOptions *options = [PHFetchOptions new];
            options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:NO]];
            PHFetchResult *fetchResults = [PHAsset fetchAssetsWithOptions:options];
            [fetchResults enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                [_assets addObject:obj];
            }];
            if (fetchResults.count > 0) {
                [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
            }
        });
        
    } else {
        
        // Assets Library iOS < 8
        _ALAssetsLibrary = [[ALAssetsLibrary alloc] init];
        
        // Run in the background as it takes a while to get all assets from the library
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            NSMutableArray *assetGroups = [[NSMutableArray alloc] init];
            NSMutableArray *assetURLDictionaries = [[NSMutableArray alloc] init];
            
            // Process assets
            void (^assetEnumerator)(ALAsset *, NSUInteger, BOOL *) = ^(ALAsset *result, NSUInteger index, BOOL *stop) {
                if (result != nil) {
                    NSString *assetType = [result valueForProperty:ALAssetPropertyType];
                    if ([assetType isEqualToString:ALAssetTypePhoto] || [assetType isEqualToString:ALAssetTypeVideo]) {
                        [assetURLDictionaries addObject:[result valueForProperty:ALAssetPropertyURLs]];
                        NSURL *url = result.defaultRepresentation.url;
                        [_ALAssetsLibrary assetForURL:url
                                          resultBlock:^(ALAsset *asset) {
                                              if (asset) {
                                                  @synchronized(_assets) {
                                                      [_assets addObject:asset];
                                                      if (_assets.count == 1) {
                                                          // Added first asset so reload data
                                                          [self.tableView performSelectorOnMainThread:@selector(reloadData) withObject:nil waitUntilDone:NO];
                                                      }
                                                  }
                                              }
                                          }
                                         failureBlock:^(NSError *error){
                                             NSLog(@"operation was not successfull!");
                                         }];
                        
                    }
                }
            };
            
            // Process groups
            void (^ assetGroupEnumerator) (ALAssetsGroup *, BOOL *) = ^(ALAssetsGroup *group, BOOL *stop) {
                if (group != nil) {
                    [group enumerateAssetsWithOptions:NSEnumerationReverse usingBlock:assetEnumerator];
                    [assetGroups addObject:group];
                }
            };
            
            // Process!
            [_ALAssetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll
                                            usingBlock:assetGroupEnumerator
                                          failureBlock:^(NSError *error) {
                                              NSLog(@"There is an error");
                                          }];
            
        });
        
    }
    
}

@end

