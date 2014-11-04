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

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.tableView.separatorColor = [UIColor colorWithRed:100/255.0 green:100/255.0 blue:100/255.0 alpha:0.5];
    
    UIBarButtonItem *newBackButton = [[UIBarButtonItem alloc] initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    [[self navigationItem] setBackBarButtonItem:newBackButton];
    
    self.tableView.tableHeaderView = [[TableHeaderView alloc] initWithText:@"Classifieds"];
    
//    NSMutableArray *TITLE = [[NSMutableArray alloc ] init];
//    NSMutableArray *DESCRIPTION = [[NSMutableArray alloc ] init];
//    NSMutableArray *ADDRESS = [[NSMutableArray alloc ] init];
//    NSMutableArray *NAME = [[NSMutableArray alloc ] init];
//    NSMutableArray *PHONE = [[NSMutableArray alloc ] init];
//    NSMutableArray *PRICE = [[NSMutableArray alloc ] init];
    _ClassifiedsArr = [[NSMutableArray alloc] init];
    
    PFQuery *query = [PFQuery queryWithClassName:@"Classifieds"];
    [query findObjectsInBackgroundWithBlock:^(NSArray *objects, NSError *error) {
        if (!error) {
            [_ClassifiedsArr addObjectsFromArray:objects];
            NSLog(@"SUCCESS");
        } else {
            // Log details of the failure
            NSLog(@"Error: %@ %@", error, [error userInfo]);
        }
    }];

//    _Titles = @[@"Prodavam si chetkata za zabi",
//                @"Tarsq si kvartira",
//                @"Prodavam si letnite djanti."];
//    
//    _Descriptions = @[@"Mnogo zapzazena. Pochti ne e polzvana",
//                      @"Do 100 leva. Po vazmojnost tristaen",
//                      @"Jelezni djanti. Kupih gi tova lqto. :)"];
//    
    _Images = @[@"chetka.jpg",
                @"please.jpg",
                @"djanta.jpg",
                @"djanta.jpg",
                @"djanta.jpg"];
//
//    _Prices = @[@"1200",
//                @"122",
//                @"332"];
    
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
    return _ClassifiedsArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"TableCell";
    TableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    long row = [indexPath row];
    
    PFFile *userImageFile = _ClassifiedsArr[row][@"Picture"];
    [userImageFile getDataInBackgroundWithBlock:^(NSData *imageData, NSError *error) {
        if (!error) {
            cell.thumbImage.image = [UIImage imageWithData:imageData];
        }
    }];
    
    cell.lblTitle.text = _ClassifiedsArr[row][@"Title"];
    cell.lblDescription.text = _ClassifiedsArr[row][@"Description"];
   // cell.thumbImage.image = [UIImage imageNamed:_ClassifiedsArr[row][@"Picture"]];
    cell.price.text = _ClassifiedsArr[row][@"Price"];
    
    return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"ShowDetails"]) {
        DetailViewController *detailviewcontroller = [segue destinationViewController];
        NSIndexPath *myIndexPath = [self.tableView indexPathForSelectedRow];
        
        long row = [myIndexPath row];
        detailviewcontroller.detailModal = @[_ClassifiedsArr[row][@"Title"],_ClassifiedsArr[row][@"Description"],_ClassifiedsArr[row][@"Picture"]];
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
