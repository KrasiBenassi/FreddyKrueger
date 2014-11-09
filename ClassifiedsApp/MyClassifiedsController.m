//
//  MyClassifiedsController.m
//  ClassifiedsApp
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "MyClassifiedsController.h"
#import "DetailViewController.h"
#import "TableCell.h"
#import "TableHeaderView.h"
#import <Parse/Parse.h>

#import "CDHelper.h"
#import "MyClassifieds.h"

@interface MyClassifiedsController ()
@property (nonatomic, strong) CDHelper *cdHelper;
@property (nonatomic, strong) NSMutableArray *classifiedDetails;
@end

@implementation MyClassifiedsController

NSString *const MCClassName = @"MyClassifieds";
//NSString *const TableCellIdentifier = @"TableCell";
NSString *const MCShowDetailsIdentifier = @"ShowDetails";
NSString *const MCTitle = @"title";
NSString *const MCDescription = @"description";
NSString *const MCPrice = @"price";
NSString *const MCName = @"name";
NSString *const MCCity = @"city";
NSString *const MCAddress = @"address";
NSString *const MCPhone = @"phone";
NSString *const MCPicture = @"picture";
NSString *const MCBackgroundPicture = @"Striped_Tranquil.jpg";
NSString *const CDTitle = @"Title";
NSString *const CDDescription = @"Description";
NSString *const CDPrice = @"Price";
NSString *const CDName = @"Name";
NSString *const CDCity = @"City";
NSString *const CDAddress = @"Address";
NSString *const CDPhone = @"Phone";
NSString *const CDPicture = @"Picture";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    //self.tableView.separatorColor = [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:0.5];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    self.tableView.tableHeaderView = [[TableHeaderView alloc] initWithText:MCClassName];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:MCBackgroundPicture]];
    
    _ClassifiedsInfo = [[NSMutableArray alloc] init];
    _classifiedDetails = [[NSMutableArray alloc] init];
    
    _cdHelper = [CDHelper instance];
    [_cdHelper setupCoreData];
        
    //Fetching:
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:MCClassName];
    
    _ClassifiedsArr = [_cdHelper.context executeFetchRequest:request error:nil];
    // _ClassifiedsArr = [NSMutableArray arrayWithArray:fetchedObjects];
    
    for (MyClassifieds *item in _ClassifiedsArr){
        //[_cdHelper.context deleteObject:item];
        [_ClassifiedsInfo addObject:item];
    }
    
    
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
    
    NSInteger clCount = _ClassifiedsInfo.count;
    
    //    PFQuery *query = [PFQuery queryWithClassName:MCClassName];
    //    long count = [query countObjects];
    //
    //    if(count != clCount && clCount != 0){
    //
    //        NSMutableArray *csArr = [[NSMutableArray alloc] init];
    //        PFQuery *query = [PFQuery queryWithClassName:MCClassName];
    //        [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
    //            if (!error) {
    //                [csArr addObjectsFromArray:objects];
    //                _ClassifiedsArr = csArr;
    //                //[self.tableView reloadData];
    //                NSLog(@"SUCCESS");
    //            } else {
    //                // Log details of the failure
    //                NSLog(@"Error: %@ %@", error, [error userInfo]);
    //            }
    //        }];
    //    }
    
    return clCount;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellIdentifier = @"TableCell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    long row = [indexPath row];
    if(![_ClassifiedsInfo[row] title]){
        return cell;
    }
    
    //NSData *dataImage;
    //for (MyClassifieds *item in _ClassifiedsArr) {
    //    NSLog(@"%@",[_ClassifiedsArr[row] picture]);
    //dataImage = item.picture;
    //};
    
    //PFFile *userImageFile = _ClassifiedsArr[row][MCPicture];
    
    
    //    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
    //        if (!error) {
    //            cell.thumbImage.image = [UIImage imageWithData:imageData];
    //        }
    //    }];
    cell.thumbImage.image = [UIImage imageWithData:[_ClassifiedsInfo[row] picture]];
    cell.lblTitle.text = [_ClassifiedsInfo[row] title];//_ClassifiedsArr[row][MCTitle];
    cell.lblDescription.text = [_ClassifiedsInfo[row] descriptionText];//_ClassifiedsArr[row][MCDescription];
    cell.lblPrice.text = [_ClassifiedsInfo[row] price];//_ClassifiedsArr[row][MCPrice];
    
    NSMutableDictionary *arr = [[NSMutableDictionary alloc] init];
    arr[CDTitle] = [_ClassifiedsInfo[row] title];//_ClassifiedsArr[row][MCTitle];
    arr[CDDescription] = [_ClassifiedsInfo[row] descriptionText];//_ClassifiedsArr[row][MCDescription];
    //arr[CDPhone] = _ClassifiedsInfo[row][MCPhone];//_ClassifiedsArr[row][MCPhone];
    arr[CDName] = [_ClassifiedsInfo[row] name];//_ClassifiedsArr[row][MCName];
    arr[CDAddress] = [_ClassifiedsInfo[row] address];//_ClassifiedsArr[row][MCAddress];
    arr[CDPicture] = [_ClassifiedsInfo[row]picture];
    arr[CDPhone] = [_ClassifiedsInfo[row] phone];
//    if([[_ClassifiedsInfo[row] allKeys] containsObject:@"price"])
//    {
        arr[CDPrice] = [_ClassifiedsInfo[row] price];
//    } else {
//        arr[CDPrice] = @"";
//    }
       [_classifiedDetails addObject: arr];
    
    return cell;
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailViewController *detailViewController = [segue destinationViewController];
    NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
    
    long row = [myIndexPath row];
    detailViewController.detailModal = [NSArray arrayWithObjects: _classifiedDetails[row], nil];
    
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