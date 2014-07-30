//
//  AttachmentTableViewController.m
//  EmailAttachment
//
//  Created by Simon on 6/7/13.
//  Copyright (c) 2013 Appcoda. All rights reserved.
//

#import "AttachmentTableViewController.h"
#import "AttachmentTableViewCell.h"

#import <MessageUI/MessageUI.h>

@interface AttachmentTableViewController () <MFMessageComposeViewControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) NSArray *files;
@end

@implementation AttachmentTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _files = @[@"10 Great iPhone Tips.pdf", @"camera-photo-tips.html", @"foggy.jpg", @"Hello World.ppt", @"no more complaint.png", @"Why Appcoda.doc"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [_files count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    AttachmentTableViewCell *cell = (AttachmentTableViewCell*)[tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    // Configure the cell...
    cell.fileLabel.text = [_files objectAtIndex:indexPath.row];
    cell.thumbnail.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon%d.png", indexPath.row]];
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     */
    NSString *selectedFile = [_files objectAtIndex:indexPath.row];
    [self showSMS:selectedFile];
}


#pragma mark - iMessage
- (void)showSMS:(NSString*)file {
    if (![MFMessageComposeViewController canSendText]) {

        UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Your device not support SMS \nOr you hadn't login your iMessage" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alertV show];
        return;
    }
    MFMessageComposeViewController *mVC = [[MFMessageComposeViewController alloc] init];
    mVC.body = @"jjjj";
    mVC.messageComposeDelegate = self;
    if ([MFMessageComposeViewController canSendAttachments]) {
        NSLog(@"ok");
    }
    [mVC addAttachmentData: UIImageJPEGRepresentation([UIImage imageNamed:@"a.jpeg"], 1.0) typeIdentifier:@"public.data" filename:@"image.jpeg"];

    [self presentViewController:mVC animated:YES completion:nil];
    
}
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result
{
    switch (result) {
        case MessageComposeResultCancelled: {
            
            break;
        }
            
        case MessageComposeResultSent: {

            break;
        }

        case MessageComposeResultFailed: {
            UIAlertView *alertV = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Failed to send SMS" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
            [alertV show];
            break;
        }
            

        default:
            break;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
