//
//  MovieDetailsController.m
//  INGMovie
//
//  Created by Bahriye Begüm on 4.04.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import "MovieDetailsController.h"
#import "MovieDetailsCell.h"

@interface MovieDetailsController ()

@end

@implementation MovieDetailsController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareCollectionView];
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self navbar];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{    
    MovieDetailsCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MovieDetailsCell" forIndexPath:indexPath];
    
    NSString *imageUrl = [NSString stringWithFormat:@"%@%@",@"https://image.tmdb.org/t/p/w200",self.movieInfo.posterPath];
    NSURL *url = [NSURL URLWithString:imageUrl];
    NSData *data = [NSData dataWithContentsOfURL:url];
    UIImage *img = [[UIImage alloc] initWithData:data];
    cell.movieImage.image = img;
    
    cell.movieTitle.text = self.movieInfo.title;
    cell.voteCountLabel.text = [self.movieInfo.voteCount stringValue];
    cell.voteAvarageLabel.text = [self.movieInfo.voteAverage stringValue];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *date  = [dateFormatter dateFromString:self.movieInfo.releaseDate];
    [dateFormatter setDateFormat:@"dd.MM.yyyy"];
    NSString *newDate = [dateFormatter stringFromDate:date];
    
    cell.releaseDateLabel.text = newDate;
    [cell.languageLabel setText:[self.movieInfo.originalLanguage uppercaseString]];
    cell.overviewLabel.text = self.movieInfo.overview;

    return cell;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(self.collectionView.frame.size.width, 1000);
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}

-(void)prepareCollectionView{
    [self.collectionView registerNib:[UINib nibWithNibName:@"MovieDetailsCell" bundle:nil] forCellWithReuseIdentifier:@"MovieDetailsCell"];
    
    self.collectionView.delegate = self;
    [self.collectionView reloadData];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:0.0f];
    [layout setMinimumLineSpacing:0.0f];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:layout];
}

-(void)navbar{
    self.navigationItem.title = @"ING MOVIE";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15]}];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
                                   initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    backButton.tintColor = [UIColor whiteColor];
    self.navigationController.navigationBar.topItem.backBarButtonItem = backButton;

    
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithTitle:@"★" style:UIBarButtonItemStylePlain target:self action:@selector(rightButtonPressed:)];
    if(self.movieInfo.isFav == NO){
        rightButton.tintColor = [UIColor redColor];
    }else{
        rightButton.tintColor = [UIColor greenColor];
    }
    self.navigationItem.rightBarButtonItem = rightButton;
}

-(IBAction)rightButtonPressed:(id)sender{
    if(self.movieInfo.isFav == NO){
        self.movieInfo.isFav= YES;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor greenColor];
    }
    
    else{
        self.movieInfo.isFav= NO;
        self.navigationItem.rightBarButtonItem.tintColor = [UIColor redColor];
    }
}






@end
