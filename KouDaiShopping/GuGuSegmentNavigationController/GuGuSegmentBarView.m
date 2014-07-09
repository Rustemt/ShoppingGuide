//
//  GuGuSegmentBarView.m
//
//  Created by gugupluto on 14-2-21.
//  http://www.cnblogs.com/gugupluto/
//  Copyright (c) 2014年 gugupluto. All rights reserved.
//

#import "GuGuSegmentBarView.h"
#import "BMMyButton.h"

#define kButtonTagStart 100
#define kLineView 20
@interface GuGuSegmentBarView ()
{
    UIView *lineView;
    UIView *backView;
    NSMutableArray *buttonArray;
    NSInteger selectItem;
}
@end

@implementation GuGuSegmentBarView
@synthesize selectedIndex;
@synthesize clickDelegate;
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
    }
    return self;
}

-(id)initWithFrame:(CGRect)frame andItems:(NSArray*)titleArray
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        CGRect rc  = [self viewWithTag:selectedIndex+kButtonTagStart].frame;
        lineView = [[UIView alloc]initWithFrame:CGRectMake(rc.origin.x - 50, self.frame.size.height - kLineView - 3, rc.size.width, kLineView)];
        lineView.backgroundColor = [UIColor orangeColor];
        lineView.layer.cornerRadius = 8.0;
        [self addSubview:lineView];
        
        selectedIndex = 0;
        int width = 0;
        buttonArray = [[NSMutableArray alloc]init];
        for (int i = 0 ; i < titleArray.count; i++)
        {
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.backgroundColor = [UIColor clearColor];
            button.titleLabel.font = [UIFont systemFontOfSize:15];
            [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
             NSString *title = [titleArray objectAtIndex:i];
            [button setTitle:title forState:UIControlStateNormal];
            button.tag = kButtonTagStart+i;
            CGSize size = [title sizeWithFont:[UIFont systemFontOfSize:15] constrainedToSize:CGSizeMake(MAXFLOAT, 25) lineBreakMode:NSLineBreakByWordWrapping];
            button.frame = CGRectMake(75*i + 8, 0, 70, 30);
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [self addSubview:button];
            [buttonArray addObject:button];
            width += size.width+20;
//            UIImage *back = [UIImage imageNamed:@"GLIP点击查看更多宝贝图片-默认"];
            if (i == 0) {
//                [button setBackgroundColor:[UIColor orangeColor]];
//                button.layer.cornerRadius = 10.0;

            }
            
        }
        self.contentSize = CGSizeMake(width, 25);
        self.showsHorizontalScrollIndicator = NO;
        selectItem = 0;
//        [self selectIndex:0];
        [self setLineOffsetWithPage:0 andRatio:-0.003];
    }
    return self;

    
}
-(void)onClick:(id)sender
{
    UIButton *btn = (UIButton*)sender;
    if (selectedIndex != btn.tag - kButtonTagStart)
    {
        [self selectIndex:(int)(btn.tag - kButtonTagStart)];
    }

}

-(void)selectIndex:(int)index
{
//    
//    for (int i = 0; i < buttonArray.count; i ++) {
//        UIButton *obj = buttonArray[i];
//        if (index != i) {
//            obj.backgroundColor = [UIColor clearColor];
//            continue;
//        }
////        [UIView animateWithDuration:0.1f animations:^{
//            [obj setBackgroundColor:[UIColor orangeColor]];
//            obj.layer.cornerRadius = 10.0;
////        }];
//
//    }
    
   if (selectedIndex != index)
    {
        selectedIndex =  index;
        [UIView beginAnimations:@"" context:nil];
        [UIView setAnimationDuration:0.2];
        CGRect lineRC  = [self viewWithTag:selectedIndex+kButtonTagStart].frame;
        lineView.frame = CGRectMake(lineRC.origin.x, self.frame.size.height - kLineView -3, lineRC.size.width, kLineView);
        [UIView commitAnimations];
        
        if (clickDelegate != nil && [clickDelegate respondsToSelector:@selector(barSelectedIndexChanged:)])
        {
            [clickDelegate barSelectedIndexChanged:selectedIndex];
        }
        
        
        if (lineRC.origin.x - self.contentOffset.x > 320 * 2  / 3)
        {
            int index = selectedIndex;
            if (selectedIndex + 2 < buttonArray.count)
            {
                index = selectedIndex + 2;
            }
            else if (selectedIndex + 1 < buttonArray.count)
            {
                index = selectedIndex + 1;
            }
            CGRect rc = [self viewWithTag:index +kButtonTagStart].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
        else if ( lineRC.origin.x - self.contentOffset.x < 320 / 3)
        {
            int index = selectedIndex;
            if (selectedIndex - 2 >= 0)
            {
                index = selectedIndex - 2;
            }
            else if (selectedIndex - 1 >= 0)
            {
                index = selectedIndex - 1;
            }
            CGRect rc = [self viewWithTag:index +kButtonTagStart].frame;
            [self scrollRectToVisible:rc animated:YES];
        }
        
        
    }

}

-(void)setLineOffsetWithPage:(float)page andRatio:(float)ratio
{
    
 
    CGRect lineRC  = [self viewWithTag:page+kButtonTagStart].frame;
    
    CGRect lineRC2  = [self viewWithTag:page+1+kButtonTagStart].frame;
    
    float width = lineRC2.size.width;
    if (lineRC2.size.width < lineRC.size.width)
    {
        width =  lineRC.size.width - (lineRC.size.width-lineRC2.size.width)*ratio;
        
    }
    else if(lineRC2.size.width > lineRC.size.width)
    {
        width =  lineRC.size.width + (lineRC2.size.width-lineRC.size.width)*ratio;
    }
    float x = lineRC.origin.x + (lineRC2.origin.x - lineRC.origin.x)*ratio;
    
    
    lineView.frame = CGRectMake(x,  self.frame.size.height - kLineView - 3,width, kLineView);
    
    
    
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
