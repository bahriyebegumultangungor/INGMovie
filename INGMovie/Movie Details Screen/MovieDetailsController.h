//
//  MovieDetailsController.h
//  INGMovie
//
//  Created by Bahriye Begüm on 4.04.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieDetailsController : UIViewController<UICollectionViewDelegate, UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) Movie *movieInfo;

@end

NS_ASSUME_NONNULL_END
