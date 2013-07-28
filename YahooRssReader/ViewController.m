//
//  ViewController.m
//  YahooRssReader
//
//  Created by aybek can kaya on 7/28/13.
//  Copyright (c) 2013 aybek can kaya. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    CHUD=[[MBProgressHUD alloc]initWithView:self.view];
    [self.view addSubview:CHUD];
    CHUD.delegate=self;
    [CHUD show:YES];
    
    currentSelection=-1;
    
    RssItems=[[NSMutableArray alloc]init];
    XmlParser =[Parser SharedParser];
    XmlParser.delegate=self;
    [XmlParser ParseXmlAtURL:@"http://news.yahoo.com/rss/"];
    
    
}


#pragma mark ParserDelegate


-(void)ParserDidFetchRssItems:(NSArray *)RssArr
{
    [XmlParser CreateEntriesFromRssItems:0]; // init call
}


-(void)ParserDidEndCreatingEntryObjects:(NSMutableArray *)EntryObjects
{
    [RssItems addObjectsFromArray:EntryObjects];
    
    [CHUD hide:YES];
}

#pragma mark ParserDelegate END



#pragma mark TableViewDelegates

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    [RssItems count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    const NSInteger TABLECELLTAG=1000;
    
    static NSString *reuseIdentifier = @"Cell";
    
    RssCellCL *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    if(cell == nil)
    {
        NSArray* views = [[NSBundle mainBundle] loadNibNamed:@"RssCell" owner:nil options:nil];
        
        cell =(RssCellCL *)[views objectAtIndex:0];
        cell.delegate=self;
        //asda
        
    }
    else
    {
        // cell has created Before
    }
    
    Entry *theEntry=[RssItems objectAtIndex:indexPath.row];
    [cell SetNewsLblText:[theEntry description]];
    [cell SetHeaderLblText:[theEntry title]];
    [cell SetEntryImageStr:[theEntry imageStr]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark TableViewDelegates END





- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
