//
//  Movie.h
//  INGMovie
//
//  Created by Bahriye Begüm on 1.04.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Movie : NSObject


@property (nonatomic, assign) double popularity;
@property (nonatomic, assign) NSInteger identifier;
@property (nonatomic, assign) BOOL isVideo;

@property (nonatomic, strong) NSNumber *voteCount;
@property (nonatomic, strong) NSNumber *voteAverage;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *releaseDate;
@property (nonatomic, strong) NSString *originalLanguage;
@property (nonatomic, strong) NSString *originalTitle;
@property (nonatomic, strong) NSArray *genreIDS;
@property (nonatomic, strong) NSString *backdropPath;
@property (nonatomic, assign) BOOL isAdult;
@property (nonatomic, strong) NSString *overview;
@property (nonatomic, strong) NSString *posterPath;
@property (nonatomic, assign) BOOL isFav;



@end

NS_ASSUME_NONNULL_END
