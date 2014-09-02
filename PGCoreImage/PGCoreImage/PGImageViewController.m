//
//  PGImageViewController.m
//  PGCoreImage
//
//  Created by PC Nguyen on 8/29/14.
//  Copyright (c) 2014 PC Nguyen. All rights reserved.
//

#import "PGImageViewController.h"

@interface PGImageViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, strong) UIImageView *renderedImageView;

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
	self.navigationItem.leftBarButtonItem = [self loadImageButtonItem];
	self.navigationItem.rightBarButtonItem = [self filterButtonItem];
	
	[self.view addSubview:self.renderedImageView];
}

- (void)layoutViews
{
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
	static NSString *kCameraTitle = @"Camera";
	static NSString *kLibraryTitle = @"Photo Library";
	
	__weak PGImageViewController *selfPointer = self;
	
	OptionSelectedBlock selectionBlock = ^(UIActionSheet *actionSheet, NSInteger buttonIndex, NSString *buttonTitle){
		if ([buttonTitle isEqualToString:kCameraTitle]) {
			[selfPointer showCamera];
		} else if ([buttonTitle isEqualToString:kLibraryTitle]) {
			[selfPointer showPhotoLibrary];
		}
	};
	
	UIActionSheet *mediaActionSheet = [UIActionSheet ul_actionSheetWithTitle:nil cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@[kCameraTitle, kLibraryTitle] onCancel:NULL optionSelected:selectionBlock];
	[mediaActionSheet showInView:self.view];
}

#pragma mark - Media Handling

- (void)showCamera
{
	[self presentMediaPickerWithSourceType:UIImagePickerControllerSourceTypeCamera];
}

- (void)showPhotoLibrary
{
	[self presentMediaPickerWithSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)presentMediaPickerWithSourceType:(UIImagePickerControllerSourceType)sourceType
{
	UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
	imagePicker.delegate = self;
	NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
	NSArray *imageTypes = [mediaTypes filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(SELF contains %@)", @"image"]];
	imagePicker.mediaTypes = imageTypes;
	imagePicker.sourceType = sourceType;
	
	[self.navigationController presentViewController:imagePicker animated:YES completion:NULL];
}

@end
