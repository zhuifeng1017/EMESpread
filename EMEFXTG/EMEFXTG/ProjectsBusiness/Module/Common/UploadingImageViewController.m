//
//  UploadingImageViewController.m
//  EMESHT
//
//  Created by xuanhr on 15/3/2.
//  Copyright (c) 2015年 eme. All rights reserved.
//

#import "UploadingImageViewController.h"
#import "ImagePickAndUploader.h"
#import "UIImageView+WebCache.h"
#import "UIAlertViewO.h"
#import "MemberButton.h"

@interface UploadingImageViewController () <ImageUploaderDelegate>
@property (strong, nonatomic) ImagePickAndUploader *imagePickAndUploader;
@property (copy, nonatomic) ImageUploadCompleteBlock imageUploadCompleteBlock;
@end

@implementation UploadingImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!_imageInfoArry) {
        _imageInfoArry = [NSMutableArray array];
    }
    _checkButtonNumberArray = [NSMutableArray array];
    if (_itemCountInLine == 0 || _itemCountInLine == NSINTEGER_DEFINED) {
        _itemCountInLine = 3;
    }
    _imagePickAndUploader = [[ImagePickAndUploader alloc] init];
    _imagePickAndUploader.needCompress = YES;
    _imagePickAndUploader.aspectRatio = _aspectRatio;
    _imagePickAndUploader.keepingCropAspectRatio = YES;
    _imagePickAndUploader.delegate = self;
    [self insertTopContainerBar];
}

- (void)insertTopContainerBar {
    for (UIView *view in _scroll.subviews) {
        if (view != _addMemberButton) {
            [view removeFromSuperview];
        }
    }

    if (!_memberInfoArray) {
        for (int i = 0; i < _imageInfoArry.count; ++i) {
            [_memberInfoArray addObject:@{ @"isAdmin" : @0,
                                           @"name" : @"" }];
        }
    } else {
        assert(_imageInfoArry.count == _memberInfoArray.count);
    }

    for (int i = 0; i < _imageInfoArry.count; i++) {
        NSString *imageUrl = _imageInfoArry[i];
        BOOL isAdmin = ([[_memberInfoArray[i] objectForKey:@"isAdmin"] intValue] != 0);
        NSString *title = [_memberInfoArray[i] objectForKey:@"name"];
        UIButton *button = [self createMemberButton:imageUrl lableTitle:title isAdmin:isAdmin withTag:i];
        button.tag = i;

        button.left = (i % _itemCountInLine) * button.width;
        button.top = (i / _itemCountInLine) * 91;
        [_scroll addSubview:button];
    }

    [self updateSubviewPositions];
}

- (UIButton *)createMemberButton:(NSString *)imageUrl lableTitle:(NSString *)title isAdmin:(BOOL)isAdmin withTag:(NSInteger)tag {
    MemberButton *button = [[MemberButton alloc] initWithFrame:CGRectMake(5, 0, 310.0f / _itemCountInLine, 310.0f / _itemCountInLine)];
    button.backgroundColor = [UIColor clearColor];

    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 310.0f / _itemCountInLine - 20, 310.0f / _itemCountInLine - 20)];

    if ([imageUrl hasPrefix:@"http"]) {
        [imageView sd_setImageWithURL:[NSURL URLWithString:imageUrl]];
    }

    //    imageView.layer.masksToBounds = YES;
    //    imageView.layer.cornerRadius = imageView.width / 2;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [button addSubview:imageView];

    if (isAdmin) {
        UIImageView *adminImageView = [[UIImageView alloc] initWithFrame:(CGRect){0, 0, 11, 11}];
        [adminImageView setImage:[UIImage imageNamed:@"icon_manager"]];
        [button addSubview:adminImageView];
        adminImageView.center = CGPointMake(imageView.size.width - 8, imageView.size.height - 8);
    }

    UILabel *lbl = [[UILabel alloc] initWithFrame:(CGRect){0, imageView.frame.origin.y + imageView.frame.size.height, imageView.frame.size.width, 20}];
    [lbl setFont:[UIFont systemFontOfSize:13.0f]];
    [lbl setTextAlignment:NSTextAlignmentCenter];
    lbl.text = title;
    [button addSubview:lbl];

    // insert delete button
    button.deleteBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 15, 22)];
    button.deleteBtn.hidden = NO;
    switch (_type) {
    case MemberButtonTypeNormal:
        button.deleteBtn.hidden = YES;
        break;
    case MemberButtonTypeDelete:
        [button.deleteBtn setImage:[UIImage imageNamed:@"page_group_btn_del"] forState:UIControlStateNormal];
        break;
    case MemberButtonTypeCheck:
        [button.deleteBtn setImage:[UIImage imageNamed:@"checkbox_noselected"] forState:UIControlStateNormal];
        [button.deleteBtn setImage:[UIImage imageNamed:@"checkbox_selected"] forState:UIControlStateSelected];
        break;
    default:
        break;
    }
    [button.deleteBtn sizeToFit];
    button.deleteBtn.tag = tag;
    button.deleteBtn.right = 310.0f / _itemCountInLine - 5;
    button.deleteBtn.top = button.top + 5;
    if (![button.deleteBtn respondsToSelector:@selector(deleteGroupMember:)]) {
        [button.deleteBtn addTarget:self action:@selector(deleteGroupMember:) forControlEvents:UIControlEventTouchUpInside];
    }
    [button addSubview:button.deleteBtn];
    return button;
}

- (void)updateSubviewPositions {
    //隐藏内部的添加按钮
    _addMemberButton.hidden = YES;

    if (_addMemberButton && _imageInfoArry.count != 0) {
        _addMemberButton.left = (_imageInfoArry.count % _itemCountInLine) * (310.0f / _itemCountInLine);
        _addMemberButton.top = (_imageInfoArry.count / _itemCountInLine) * 91;
    }

    self.scroll.contentSize = CGSizeMake(0, 0);
    self.scroll.height = _addMemberButton.bottom + 3;
    self.view.height = self.scroll.height;
}

- (void)onImageUploadCompletion:(ImageUploader *)imageUploader success:(BOOL)success message:(NSString *)message {
    if (success) {
        [_imageInfoArry addObject:message];
        [_memberInfoArray addObject:@{ @"isAdmin" : @0,
                                       @"name" : @"" }];
        if (self.imageUploadCompleteBlock) {
            self.imageUploadCompleteBlock(_imageInfoArry);
        }
    }
}

- (void)uploadCompletionBlock:(ImageUploadCompleteBlock)block {
    self.imageUploadCompleteBlock = block;
}

- (void)addImage {
    [_imagePickAndUploader showPickDialog:self.parentViewController.parentViewController imageView:[_scroll viewWithTag:[_imageInfoArry count] - 1]];
}

- (IBAction)addImageClick:(id)sender {
    [_imagePickAndUploader showPickDialog:self imageView:[_scroll viewWithTag:[_imageInfoArry count] - 1]];
}

- (void)deleteGroupMember:(UIButton *)sender {
    WEAKSELF

    if (_type == MemberButtonTypeCheck) {
        MemberButton *memberButton = (MemberButton *)sender.superview;

        if ([memberButton isKindOfClass:[MemberButton class]]) {
            if (memberButton.deleteBtn.selected) {
                [_checkButtonNumberArray removeObject:@(memberButton.deleteBtn.tag)];
            } else {
                [_checkButtonNumberArray addObject:@(memberButton.deleteBtn.tag)];
            }

            memberButton.deleteBtn.selected = !memberButton.deleteBtn.selected;
        }
    } else {
        RIButtonItem *cancelItem = [RIButtonItem itemWithLabel:@"取消" action:nil];
        RIButtonItem *deleteItem = [RIButtonItem itemWithLabel:@"确定" action:^{
            [weakSelf.imageInfoArry removeObjectAtIndex:sender.tag];
            [weakSelf.memberInfoArray removeObjectAtIndex:sender.tag];
            [weakSelf insertTopContainerBar];
            if (weakSelf.imageUploadCompleteBlock) {
                weakSelf.imageUploadCompleteBlock(weakSelf.imageInfoArry);
            }
        }];

        NSString *alertString = @"确定删除吗？";

        UIAlertView *alertView = [[UIAlertViewO alloc] initWithTitle:@""
                                                            message:alertString
                                                   cancelButtonItem:cancelItem
                                                   otherButtonItems:deleteItem, nil];
        [alertView show];
        return;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
