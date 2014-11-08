//
//  MyClassifiedsController.m
//  ClassifiedsApp
//
//  Created by Admin on 11/8/14.
//  Copyright (c) 2014 Telerik Academy. All rights reserved.
//

#import "MyClassifiedsController.h"
#import "CDHelper.h"
#import "MyClassifieds.h"

@interface MyClassifiedsController ()
@property (nonatomic, strong) CDHelper *cdHelper;
@end

@implementation MyClassifiedsController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    _cdHelper = [[CDHelper alloc] init];
    [_cdHelper setupCoreData];
    MyClassifieds* myClassifieds = [NSEntityDescription insertNewObjectForEntityForName:@"MyClassifieds" inManagedObjectContext:_cdHelper.context];

    
    //MyClassifieds* myClassifieds = [[MyClassifieds alloc] init];
    
    myClassifieds.address = @"vgfrasd...";
    [_cdHelper.context insertObject:myClassifieds];
    
    [self.cdHelper saveContext];

    
    //Fetching:
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"MyClassifieds"];
    
    NSArray *fetchedObjects = [_cdHelper.context executeFetchRequest:request error:nil];
    
    for (MyClassifieds *item in fetchedObjects){
        //[_cdHelper.context deleteObject:item];
        NSLog(@"Fetched Object = %@", item.name);
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 0;
}

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

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
