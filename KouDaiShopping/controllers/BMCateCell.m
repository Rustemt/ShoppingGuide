//
//  BMCateCell.m
//  KouDaiShopping
//
//  Created by admin on 14-6-2.
//  Copyright (c) 2014年 Sensoro. All rights reserved.
//

#import "BMCateCell.h"

@implementation BMCateCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selected = NO;
        self.highlighted = NO;
        _title = [[UILabel alloc]initWithFrame:CGRectMake(18, 0, 280, 42)];
        _title.font = [UIFont boldSystemFontOfSize:14];
        [self addSubview:_title];
        
        _side = [[UIView alloc]initWithFrame:CGRectMake(8, 14, 6, 15)];
        [self addSubview:_side];
        
        _bottom = [[UIView alloc]initWithFrame:CGRectMake(0, 43, 320, 1)];
        _bottom.backgroundColor = [UIColor colorWithWhite:0.667 alpha:1.000];
        [self addSubview:_bottom];
        
        _more = [[BMMyButton alloc]initWithFrame:CGRectMake(280, 0, 40, 44)];
        [_more setTitle:@"更多" Image:@"GLIP收藏导入箭头"];
        [_more setImageEdgeInsets:UIEdgeInsetsMake(0, 23, 0, 0)];
        [_more setTitleEdgeInsets:UIEdgeInsetsMake(0, -20, 0, 20)];
        _more.backgroundColor = [UIColor whiteColor];
        _more.hidden = YES;
        [self addSubview:_more];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{

    // Configure the view for the selected state
}
- (void)setModel:(BMCategory *)model
{
    _model = model;
    _title.text = model.title;
    _side.backgroundColor = model.color;
    _more.hidden = !model.isCollect;
}
@end
