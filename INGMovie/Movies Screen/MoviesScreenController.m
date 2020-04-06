//
//  MoviesScreenController.m
//  INGMovie
//
//  Created by Bahriye Begüm on 30.03.2020.
//  Copyright © 2020 INGMovie. All rights reserved.
//

#import "MoviesScreenController.h"
#import "MovieCell.h"
#import "Movie.h"

#import "MovieDetailsController.h"

@interface MoviesScreenController ()

@end

@implementation MoviesScreenController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.bigCellSize = NO;
    self.createCellSizeButton.image = [UIImage imageNamed:@"list"];
    currentPage = 1;
    [self getUrl];
    [self navBar];
    [self prepareCollectionView];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.collectionView reloadData];
}

-(void)getUrl{
    self.activityIndicator.hidden = NO;
    self.collectionView.alpha = 0.3;
    NSString *url = [NSString stringWithFormat:@"https://api.themoviedb.org/3/movie/popular?language=en-US&api_key=fd2b04342048fa2d5f728561866ad52a&page=%d",currentPage];
    [self getData:url];
}

-(void)getData:(NSString *)address{
    NSURL *url = [NSURL URLWithString:address];
    NSURLRequest *req = [[NSURLRequest alloc]initWithURL:url];
    NSURLConnection *con = [[NSURLConnection alloc] initWithRequest:req delegate:self];
}

-(void)prepareCollectionView{
    self.activityIndicator.hidden = NO;
    self.collectionView.alpha = 0.3;
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
    [self.collectionView registerNib:[UINib nibWithNibName:@"MovieCell" bundle:[NSBundle mainBundle]] forCellWithReuseIdentifier:@"MovieCell"];
    
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    [layout setMinimumInteritemSpacing:0.0f];
    [layout setMinimumLineSpacing:5.0f];
    [layout setScrollDirection:UICollectionViewScrollDirectionVertical];
    [self.collectionView setCollectionViewLayout:layout];
}

-(void)navBar{
    self.navigationItem.title = @"ING MOVIE";
    [self.navigationController.navigationBar setTitleTextAttributes:
     @{NSForegroundColorAttributeName:[UIColor whiteColor],
       NSFontAttributeName:[UIFont fontWithName:@"HelveticaNeue" size:15]}];
}

- (IBAction)createCellSizeClick:(id)sender {
    if (self.bigCellSize == NO) {
        self.bigCellSize = YES;
        self.createCellSizeButton.image = [UIImage imageNamed:@"grid"];
    }
    else{
        self.bigCellSize = NO;
        self.createCellSizeButton.image = [UIImage imageNamed:@"list"];
    }
    [self.collectionView reloadData];
}

# pragma urlconnection delegate
-(void)connectionDidFinishLoading:(NSURLConnection *)connection{
    self.activityIndicator.hidden =YES;
    self.collectionView.alpha = 1;
    
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:self.downloadData options:NSJSONReadingAllowFragments error:nil];
    NSArray *results = [dic valueForKey:@"results"];
    
    if(self.data == nil){
        self.data = [[NSMutableArray alloc] init];
        for(int i= 0; i<results.count; i++){
            NSDictionary *dic = [results objectAtIndex:i];
            Movie *movieModel = [[Movie alloc] init];
            movieModel.title = [dic valueForKey:@"title"];
            movieModel.releaseDate = [dic valueForKey:@"release_date"];
            movieModel.posterPath = [dic valueForKey:@"poster_path"];
            
            
            movieModel.voteCount = [dic valueForKey:@"vote_count"];
            movieModel.voteAverage = [dic valueForKey:@"vote_average"];
            movieModel.releaseDate = [dic valueForKey:@"release_date"];
            movieModel.originalLanguage = [dic valueForKey:@"original_language"];
            movieModel.overview = [dic valueForKey:@"overview"];
            
            [self.data addObject:movieModel];
        }
    }
    
    else{
        for(int i= 0; i<results.count; i++){
            NSDictionary *dic = [results objectAtIndex:i];
            Movie *movieModel = [[Movie alloc] init];
            movieModel.title = [dic valueForKey:@"title"];
            movieModel.releaseDate = [dic valueForKey:@"release_date"];
            movieModel.posterPath = [dic valueForKey:@"poster_path"];
            
            movieModel.voteCount = [dic valueForKey:@"vote_count"];
            movieModel.voteAverage = [dic valueForKey:@"vote_average"];
            movieModel.releaseDate = [dic valueForKey:@"release_date"];
            movieModel.originalLanguage = [dic valueForKey:@"original_language"];
            movieModel.overview = [dic valueForKey:@"overview"];
            
            [self.data addObject:movieModel];
        }
    }
    [self.collectionView reloadData];
}

-(void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)erro{
    NSLog(@"Failed with error");
}

-(void)connection:(NSURLConnection *)connection didReceiveData:(nonnull NSData *)sources{
    [self.downloadData appendData:sources];
    NSLog(@"Did receive data");
}

-(void)connection:(NSURLConnection *)connection didReceiveResponse:(nonnull NSURLResponse *)response{
    self.downloadData = [[NSMutableData alloc ] init];
    NSLog(@"Did receive response");
}

-(void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
}

#pragma collectionview delegate
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.data.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    MovieCell *movieCell = [self.collectionView dequeueReusableCellWithReuseIdentifier:@"MovieCell" forIndexPath:indexPath];
    
    if (indexPath.row == self.data.count - 1) {
        currentPage += 1;
        [self getUrl];
    }
    
    Movie *movie = [self.data objectAtIndex:indexPath.row];
    [movieCell showMovie:movie];
    return movieCell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    Movie *movie = [self.data objectAtIndex:indexPath.row];
    MovieDetailsController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"MovieDetailsController"];
    controller.movieInfo=movie;
    [self.navigationController pushViewController:controller animated:YES];
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    if(self.bigCellSize == NO){
        return CGSizeMake(self.collectionView.frame.size.width/2, self.collectionView.frame.size.height/2.5);
    }
    else{
        return CGSizeMake(self.collectionView.frame.size.width, self.collectionView.frame.size.height/2.5);
    }
}





@end
