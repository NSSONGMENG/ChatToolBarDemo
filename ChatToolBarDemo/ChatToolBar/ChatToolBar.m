//
//  ChatToolBar.m
//  ChatToolBarDemo
//
//  Created by songmeng on 17/3/25.
//  Copyright © 2017年 songmeng. All rights reserved.
//

#import "ChatToolBar.h"
#import "ChatTextView.h"

#define imageNamed(name) [UIImage imageNamed:name]

@interface ChatToolBar ()

@property (nonatomic, strong) UIButton      * recordViewBtn;    //调出／隐藏录音视图
@property (nonatomic, strong) ChatTextView  * inputTextView;    //输入框
@property (nonatomic, strong) UIButton      * emojiViewBtn; //调出／隐藏表情键盘
@property (nonatomic, strong) UIButton      * moreViewBtn;  //调出／隐藏更多选项视图

@end


@implementation ChatToolBar

- (instancetype)initWithDelegate:(id<ChatToolBarDelegate>)delegate{
    if (self = [super init]) {
        [self createSubview];
        self.delegate = delegate;
    }
    return self;
}

- (instancetype)init{
    if (self = [super init]) {
        [self createSubview];
    }
    return self;
}

- (void)createSubview{
    [self addSubview:self.recordViewBtn];
    [self addSubview:self.inputTextView];
    [self addSubview:self.emojiViewBtn];
    [self addSubview:self.moreViewBtn];
    
    [self.recordViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.bottom.equalTo(self);
        make.width.height.mas_equalTo(ChatToolBarHeight);
    }];
    [self.inputTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.recordViewBtn.mas_right);
        make.top.equalTo(self).offset(5);
        make.bottom.equalTo(self).offset(-5);
    }];
    [self.emojiViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.inputTextView.mas_right);
        make.centerY.height.equalTo(self.recordViewBtn);
        make.width.mas_equalTo(ChatToolBarHeight-2);
    }];
    [self.moreViewBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.emojiViewBtn.mas_right);
        make.centerY.width.height.equalTo(self.emojiViewBtn);
        make.right.equalTo(self);
    }];
}

#pragma  mark  - button action
- (void)recordViewBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)emojiViewBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)moreViewBtnAction:(UIButton *)btn{
    btn.selected = !btn.selected;
}

- (void)refreshBtnStatusWith:(UIButton *)btn{
    for (UIButton * b in @[_moreViewBtn,_emojiViewBtn,_recordViewBtn]) {
        if (btn == b) {
            btn.selected = !btn.selected;
        }
        else{
            btn.selected = NO;
        }
    }
    
}

#pragma  mark  - text view method
- (void)textDidChanged{
    [_inputTextView textDidChanged];
}

- (void)resignKeyboard{
    [_inputTextView resignFirstResponder];
}

#pragma  mark  - setter
- (void)setDelegate:(id<ChatToolBarDelegate>)delegate{
    _delegate = delegate;
    _inputTextView.delegate = delegate;
}

#pragma  mark  - getter
- (ChatTextView *)inputTextView{
    if (!_inputTextView) {
        _inputTextView = [ChatTextView new];
        _inputTextView.delegate = self.delegate;
        _inputTextView.maxHeight = 100;
        _inputTextView.placeHolder = @"请输入";
        _inputTextView.font = [UIFont systemFontOfSize:16];
        _inputTextView.backgroundColor = [UIColor whiteColor];
        _inputTextView.layer.cornerRadius = 4.f;
        _inputTextView.layer.borderColor = [UIColor lightGrayColor].CGColor;
        _inputTextView.layer.borderWidth = 1.f;
        _inputTextView.clipsToBounds = YES;
    }
    return _inputTextView;
}

- (UIButton *)recordViewBtn{
    if (!_recordViewBtn) {
        _recordViewBtn = [UIButton new];
        [_recordViewBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
        [_recordViewBtn setImage:imageNamed(@"IconChatAudio") forState:UIControlStateNormal];
        [_recordViewBtn setImage:imageNamed(@"IconChatAudioSeleted") forState:UIControlStateHighlighted];
        [_recordViewBtn setImage:imageNamed(@"IconKeyboard") forState:UIControlStateSelected];
        [_recordViewBtn addTarget:self action:@selector(recordViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _recordViewBtn;
}

- (UIButton *)emojiViewBtn{
    if (!_emojiViewBtn) {
        _emojiViewBtn = [UIButton new];
        [_emojiViewBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 5, 5, 2)];
        [_emojiViewBtn setImage:imageNamed(@"IconChatEmoji") forState:UIControlStateNormal];
        [_emojiViewBtn setImage:imageNamed(@"IconChatEmojiSeleted") forState:UIControlStateHighlighted];
        [_emojiViewBtn setImage:imageNamed(@"IconKeyboard") forState:UIControlStateSelected];
        [_emojiViewBtn addTarget:self action:@selector(emojiViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _emojiViewBtn;
}

- (UIButton *)moreViewBtn{
    if (!_moreViewBtn) {
        _moreViewBtn = [UIButton new];
        [_moreViewBtn setImageEdgeInsets:UIEdgeInsetsMake(5, 2, 5, 5)];
        [_moreViewBtn setImage:imageNamed(@"IconChatMore") forState:UIControlStateNormal];
        [_moreViewBtn setImage:imageNamed(@"IconChatMoreSeleted") forState:UIControlStateSelected];
        [_moreViewBtn setImage:imageNamed(@"IconKeyboard") forState:UIControlStateSelected];
        [_moreViewBtn addTarget:self action:@selector(moreViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _moreViewBtn;
}

@end
