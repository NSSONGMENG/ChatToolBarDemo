//
//  ChatToolBar.h
//  ChatToolBarDemo
//
//  Created by songmeng on 17/3/25.
//  Copyright © 2017年 songmeng. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ChatToolBar;
@class ChatTextView;

static  CGFloat ChatToolBarHeight = 45;

/**
    继承之后就可以通过ChatToolBarDelegate这一个代理实现它所继承的所有代理的方法
    代理是可以多继承的，即可以有多个父类
 */
@protocol ChatToolBarDelegate <UITextViewDelegate>



@end

/**
 聊天工具栏
 */
@interface ChatToolBar : UIView

@property (nonatomic, readonly) ChatTextView    * inputTextView;

@property (nonatomic, weak) id<ChatToolBarDelegate>delegate;

- (instancetype)initWithDelegate:(id<ChatToolBarDelegate>)delegate;

#pragma  mark  - text view 
- (void)textDidChanged;
- (void)resignKeyboard;

@end
