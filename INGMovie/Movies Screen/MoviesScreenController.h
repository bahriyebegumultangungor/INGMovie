//
//  MoviesScreenController.h
//  INGMovie
//
//  Created by Bahriye Begüm on 30.03.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface MoviesScreenController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>{
    int currentPage;
}

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *createCellSizeButton;
@property BOOL bigCellSize;

- (IBAction)createCellSizeClick:(id)sender;

@property (nonatomic,strong) NSMutableArray *data;
@property (nonatomic, strong) NSMutableData *downloadData;




@end

NS_ASSUME_NONNULL_END
