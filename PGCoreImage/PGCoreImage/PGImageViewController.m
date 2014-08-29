//
//  PGImageViewController.m
//  PGCoreImage
//
//  Created by PC Nguyen on 8/29/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGImageViewController.h"

@interface PGImageViewController ()

@property (nonatomic, strong) UIImageView *renderedImageView;
@property (nonatomic, strong) UIToolbar *actionToolBar;

@end

@implementation PGImageViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	[self configureViews];
	[self layoutViews];
}

- (void)configureViews
{
	[self.view addSubview:self.renderedImageView];
	[self.view addSubview:self.actionToolBar];
}

- (void)layoutViews
{
	NSMutableArray *sizeConstraints = [self.actionToolBar ul_fixedSize:CGSizeMake(0.0f, 60.0f)];
	for (NSLayoutConstraint *constraint in sizeConstraints) {
		constraint.priority = UILayoutPriorityDefaultHigh;
	}
	
	[self.view addConstraints:[self.actionToolBar ul_pinWithInset:UIEdgeInsetsMake(0.0f, 0.0f, kUIViewUnpinInset, 0.0f)]];
	[self.view addConstraints:[self.renderedImageView ul_pinWithInset:UIEdgeInsetsZero]];
}

#pragma mark - Image View

- (UIImageView *)renderedImageView
{
	if (!_renderedImageView) {
		_renderedImageView = [[UIImageView alloc] initWithImage:nil];
		_renderedImageView.contentMode = UIViewContentModeScaleAspectFit;
		[_renderedImageView ul_enableAutoLayout];
	}
	
	return _renderedImageView;
}

#pragma mark - Action Tool Bar

- (UIToolbar *)actionToolBar
{
	if (!_actionToolBar) {
		_actionToolBar = [[UIToolbar alloc] initWithFrame:CGRectZero];
		_actionToolBar.items = @[[self loadImageButtonItem],[self flexibleItem],[self filterButtonItem]];
		[_actionToolBar ul_enableAutoLayout];
	}
	
	return _actionToolBar;
}

- (UIBarButtonItem *)flexibleItem
{
	return [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
														 target:nil
														 action:NULL];
}

- (UIBarButtonItem *)filterButtonItem
{
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Filters"
																   style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(handleFilterButtonItemTapped:)];
	return buttonItem;
}

- (void)handleFilterButtonItemTapped:(id)sender
{

}

- (UIBarButtonItem *)loadImageButtonItem
{
	UIBarButtonItem *buttonItem = [[UIBarButtonItem alloc] initWithTitle:@"Load Image"
																   style:UIBarButtonItemStylePlain
																  target:self
																  action:@selector(handleLoadImageButtonItemTapped:)];
	return buttonItem;
}

- (void)handleLoadImageButtonItemTapped:(id)sender
{

}

@end
