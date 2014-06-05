#import "MasterViewController.h"
#import "DetailViewController.h"
#import "Raid.h"
#import "Adventurer.h"

@implementation MasterViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"Adventurer"];
    request.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES]];
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:request managedObjectContext:self.managedObjectContext sectionNameKeyPath:@"species" cacheName:@"RaidCache"];
    [self.fetchedResultsController performFetch:nil];
    
    self.fetchedResultsController.delegate = self;
}

- (IBAction)onAddAdventurerName:(UITextField *)sender
{
    NSArray *species = @[@"Human", @"Elf", @"Dwarf", @"Student"];
    Adventurer *adventurer = [NSEntityDescription insertNewObjectForEntityForName:@"Adventurer" inManagedObjectContext:self.managedObjectContext];
    adventurer.name = sender.text;
    adventurer.species = species[arc4random_uniform(species.count)];
    [self.managedObjectContext save:nil];
    [sender resignFirstResponder];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    Adventurer *adventurer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];

    cell.textLabel.text = adventurer.name;
    cell.detailTextLabel.text = @(adventurer.raids.count).description;

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.fetchedResultsController.sections.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return [self.fetchedResultsController.sections[section] name];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath
{
    [self.tableView reloadData];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    Adventurer *adventurer = [self.fetchedResultsController objectAtIndexPath:self.tableView.indexPathForSelectedRow];
    DetailViewController *destinationVC = segue.destinationViewController;
    destinationVC.detailItem = adventurer;
    destinationVC.title = adventurer.name;
}

- (IBAction)unwindFromDetailViewController:(UIStoryboardSegue *)sender
{
    DetailViewController *sourceVC = sender.sourceViewController;
    Raid *raid = [NSEntityDescription insertNewObjectForEntityForName:@"Raid" inManagedObjectContext:self.managedObjectContext];
    Adventurer *adventurer = sourceVC.detailItem;
    
    raid.date = sourceVC.datePicker.date;
    [adventurer addRaidsObject:raid];
    [self.managedObjectContext save:nil];
}


@end