//
//  TableViewController.m
//  ClassifiedsApp
//
//  Created by Admin on 10/30/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "TableViewController.h"
#import "TableCell.h"
#import "DetailViewController.h"
#import "TableHeaderView.h"
#import <Parse/Parse.h>

@interface TableViewController ()

@end

@implementation TableViewController

NSString *const TVClassName = @"Classifieds";
//NSString *const TableCellIdentifier = @"TableCell";
NSString *const ShowDetailsIdentifier = @"ShowDetails";
NSString *const TVTitle = @"Title";
NSString *const TVDescription = @"Description";
NSString *const TVPrice = @"Price";
NSString *const TVName = @"Name";
NSString *const TVCity = @"City";
NSString *const TVAddress = @"Address";
NSString *const TVPhone = @"Phone";
NSString *const TVPicture = @"Picture";
NSString *const TVBackgroundPicture = @"Striped_Tranquil.jpg";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    self.tableView.tableHeaderView = [[TableHeaderView alloc] initWithText:TVClassName];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:TVBackgroundPicture]];
    
    _ClassifiedsArr = [[NSMutableArray alloc] init];
    _ClassifiedsInfo = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:TVClassName];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [_ClassifiedsArr addObjectsFromArray:objects];
            [self.tableView reloadData];
            NSLog(@"SUCCESS");
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    
    NSInteger clCount = _ClassifiedsArr.count;
    
    PFQuery *query = [PFQuery queryWithClassName:TVClassName];
    long count = [query countObjects];
    
    if(count != clCount && clCount != 0){
        
        NSMutableArray *csArr = [[NSMutableArray alloc] init];
        PFQuery *query = [PFQuery queryWithClassName:TVClassName];
        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
            if (!error) {
                [csArr addObjectsFromArray:objects];
                _ClassifiedsArr = csArr;
                [self.tableView reloadData];
                NSLog(@"SUCCESS");
            } else {
                // Log details of the failure
                NSLog(@"Error: %@ %@", error, [error userInfo]);
            }
        }];
    }
    
    return clCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"TableCell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    long row = [indexPath row];
    
    PFFile *userImageFile = _ClassifiedsArr[row][TVPicture];
    
    NSData *dataImage = [userImageFile getData];
    
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.thumbImage.image = [UIImage imageWithData:imageData];
        }
    }];
    
    cell.lblTitle.text = _ClassifiedsArr[row][TVTitle];
    cell.lblDescription.text = _ClassifiedsArr[row][TVDescription];
    cell.lblPrice.text = _ClassifiedsArr[row][TVPrice];
    
    NSMutableDictionary *arr = [[NSMutableDictionary alloc] init];
    arr[TVTitle] = _ClassifiedsArr[row][TVTitle];
    arr[TVDescription] = _ClassifiedsArr[row][TVDescription];
    arr[TVPhone] = _ClassifiedsArr[row][TVPhone];
    arr[TVName] = _ClassifiedsArr[row][TVName];
    arr[TVAddress] = _ClassifiedsArr[row][TVAddress];
    arr[TVPicture] = dataImage;
    
    if([[_ClassifiedsArr[row] allKeys] containsObject:TVPrice])
    {
        arr[TVPrice] = _ClassifiedsArr[row][TVPrice];
    } else {
        arr[TVPrice] = @"";
    }
    [_ClassifiedsInfo addObject: arr];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:ShowDetailsIdentifier]) {
        DetailViewController *detailViewController = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath row];
        detailViewController.detailModal = [NSArray arrayWithObjects: _ClassifiedsInfo[row], nil];
    }
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 } else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
