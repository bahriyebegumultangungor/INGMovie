//
//  MovieCell.m
//  INGMovie
//
//  Created by Bahriye Begüm on 30.03.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import "MovieCell.h"

@implementation MovieCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(void)showMovie:(Movie *)movie{
    self.movie = movie;
    self.movieTitle.text=movie.title;
    
    if(self.movie.isFav == NO){
        self.favLabel.hidden = YES;
    }else{
        self.favLabel.hidden = NO;
    }
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",@"https://image.tmdb.org/t/p/w200",movie.posterPath];
    NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString: imageUrl]];
    self.movieImage.image = [UIImage imageWithData: imageData];
}






@end
