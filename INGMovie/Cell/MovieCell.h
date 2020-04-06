//
//  MovieCell.h
//  INGMovie
//
//  Created by Bahriye Begüm on 30.03.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Movie.h"

NS_ASSUME_NONNULL_BEGIN

@interface MovieCell : UICollectionViewCell

@property (nonatomic, strong) Movie *movie;
@property (weak, nonatomic) IBOutlet UILabel *movieTitle;
@property (weak, nonatomic) IBOutlet UIImageView *movieImage;
-(void)showMovie:(Movie *)movie;
@property (weak, nonatomic) IBOutlet UILabel *favLabel;

@end

NS_ASSUME_NONNULL_END
