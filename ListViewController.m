//
//  ListViewController.m
//  
//
//  Created by Rafael Auriemo on 1/1/16.
//
//

#import "ListViewController.h"
#import "DetailViewController.h"

@interface ListViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property NSMutableArray *titlesArray;

@property NSMutableArray *descriptionArray;

@end

@implementation ListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.titlesArray = [NSMutableArray new];
    self.descriptionArray = [NSMutableArray new];
    self.editing = false;
}

-(void) presentDreamEntry {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Enter new Dream" message:nil preferredStyle:UIAlertControllerStyleAlert];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField){
        textField.placeholder = @"Dream Title";
    }];
    
    [alertController addTextFieldWithConfigurationHandler:^(UITextField *textField) {
        textField.placeholder = @"Dream Description";
    }];
    
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
    
    UIAlertAction *saveAction = [UIAlertAction actionWithTitle:@"Save" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        UITextField *title = alertController.textFields[0];
        UITextField *description = alertController.textFields[1];
        [self.titlesArray addObject:title.text];
        [self.descriptionArray addObject:description.text];
        [self.tableView reloadData];
    }];
                                 
    [alertController addAction:cancelAction];
    [alertController addAction:saveAction];
    
    [self presentViewController:alertController animated:true completion:nil];
}

- (IBAction)onAddButtunTapped:(UIBarButtonItem *)sender {
    [self presentDreamEntry];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath{
    
    NSString *titleMoved = [self.titlesArray objectAtIndex:sourceIndexPath.row];
    NSString *descMoved = [self.descriptionArray objectAtIndex:sourceIndexPath.row];
    
    [self.titlesArray removeObject:titleMoved];
    [self.descriptionArray removeObject:descMoved];
    
    [self.titlesArray insertObject:titleMoved atIndex:destinationIndexPath.row];
    [self.descriptionArray insertObject:descMoved atIndex:destinationIndexPath.row];
    
}

- (IBAction)onEditButtonTapped:(UIBarButtonItem *)sender {
    if(self.editing){
        self.editing = false;
        [self.tableView setEditing:false animated:true];
        sender.style = UIBarButtonItemStylePlain;
        sender.title = @"Edit";
    }else {
        self.editing = true;
        [self.tableView setEditing:true animated:true];
        sender.style = UIBarButtonItemStyleDone;
        sender.title = @"Done";
    }
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titlesArray.count;
};

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.textLabel.text = [self.titlesArray objectAtIndex:indexPath.row];
    return cell;
};

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    DetailViewController *detailVC = segue.destinationViewController;
    detailVC.dreamTitle = [self.titlesArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    detailVC.dreamDesc = [self.descriptionArray objectAtIndex:self.tableView.indexPathForSelectedRow.row];
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.titlesArray removeObjectAtIndex:indexPath.row];
    [self.descriptionArray removeObjectAtIndex:indexPath.row];
    [self.tableView reloadData];
}
@end
