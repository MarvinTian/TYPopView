//
//  TYPopView.m
//  TYPopView
//
//  Created by Marvin on 2021/12/6.
//

#import "TYPopView.h"

@interface TYPopView ()

/// 遮罩层
@property (nonatomic, strong) UIButton *maskBGView;

/// 主视图
@property (nonatomic, strong) UIView *mainView;

/// 标题
@property (nonatomic, strong) UILabel *topicLb;

/// 文本
@property (nonatomic, strong) UILabel *contentLb;

/// 标题
@property (nonatomic, copy) NSAttributedString *topicStr;

/// 内容
@property (nonatomic, copy) NSAttributedString *contentStr;

/// 底部按钮
@property (nonatomic, strong) NSArray<NSAttributedString *>* bottomTitles;

@end

#define windowH [UIScreen mainScreen].bounds.size.height
#define windowW [UIScreen mainScreen].bounds.size.width
#define tyResponse(function) [self.popDelegate respondsToSelector:@selector(function)]
#define tyRGB(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]

// 文本外间距
#define contentEdgeInsets (self.popDelegate ? (tyResponse(ty_contentEdgeInset) ? [self.popDelegate ty_contentEdgeInset] : UIEdgeInsetsMake(0, 20, 20, 20)) : UIEdgeInsetsMake(0, 20, 20, 20))
// 默认线条颜色
#define lineColor (self.popDelegate ? (tyResponse(ty_lineColor) ? [self.popDelegate ty_lineColor] : tyRGB(230, 230, 230)) : tyRGB(230, 230, 230))
// 默认弹窗最大高度
#define main_maxH (self.popDelegate ? (tyResponse(ty_maxHeight) ? [self.popDelegate ty_maxHeight] : windowH) : windowH)

// 默认弹窗左间距
#define main_leftMargin (self.popDelegate ? (tyResponse(ty_leftMargin) ? [self.popDelegate ty_leftMargin] : 30) : 30)
// 默认弹窗右间距
#define main_rightMargin (self.popDelegate ? (tyResponse(ty_rightMargin) ? [self.popDelegate ty_rightMargin] : 30) : 30)
// 默认标题顶部间距
#define topic_topMargin (self.popDelegate ? (tyResponse(ty_topicTopMargin) ? [self.popDelegate ty_topicTopMargin] : 15) : 15)
// 默认文本顶部间距
#define content_topMargin (self.popDelegate ? (tyResponse(ty_contentTopMargin) ? [self.popDelegate ty_contentTopMargin] : 15) : 15)
// 底部按钮默认高度
#define bottomBtn_H (self.popDelegate ? (tyResponse(ty_bottomButtonHeight) ? [self.popDelegate ty_bottomButtonHeight] : 45) : 45)
// 动画默认时长
#define animateDuration (self.popDelegate ? (tyResponse(ty_animateDurationTime) ? [self.popDelegate ty_animateDurationTime] : 0.3) : 0.3)
// mask默认背景透明度
#define maskAlpha (self.popDelegate ? (tyResponse(ty_maskAlpha) ? [self.popDelegate ty_maskAlpha] : 0.4) : 0.4)
// 默认圆角
#define main_radius (self.popDelegate ? (tyResponse(ty_radiusVal) ? [self.popDelegate ty_radiusVal] : 4) : 4)


@implementation TYPopView

- (instancetype)initWithTopic:(NSAttributedString *)topic
                      content:(NSAttributedString *)content
                 bottomTitles:(NSArray<NSAttributedString *>*)titles
                     delegate:(id<TYPopViewDelegate>)delegate{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        
        self.topicStr = topic ? topic : [[NSAttributedString alloc]initWithString:@""];
        self.contentStr = content ? content : [[NSAttributedString alloc]initWithString:@""];
        self.bottomTitles = titles;
        self.popDelegate = delegate;    
        
        UIButton *maskBGView = [[UIButton alloc]initWithFrame:[UIScreen mainScreen].bounds];
        [self addSubview:maskBGView];
        maskBGView.backgroundColor = [UIColor blackColor];
        maskBGView.alpha = 0;
        self.maskBGView = maskBGView;
        if (tyResponse(ty_clickBackgroundDismiss)) {
            if ([self.popDelegate ty_clickBackgroundDismiss] == true) {
                [maskBGView addTarget:self action:@selector(dismiss) forControlEvents:UIControlEventTouchUpInside];
            }
        }

        CGFloat container_w = windowW -main_leftMargin -main_rightMargin;
        
        // 文本实际宽度
        CGFloat content_w = windowW -main_leftMargin -main_rightMargin -contentEdgeInsets.left -contentEdgeInsets.right;
        // 文本实际高度
        CGFloat autoH = [self.contentStr boundingRectWithSize:CGSizeMake(content_w, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin context:nil].size.height;
        // 弹窗实际高度
        CGFloat totalH = ([self.popDelegate respondsToSelector:@selector(ty_adjustContentHeight)] ? ([self.popDelegate ty_adjustContentHeight] == true ? autoH + topic_topMargin + self.topicStr.size.height + content_topMargin + bottomBtn_H + contentEdgeInsets.top + contentEdgeInsets.bottom : main_maxH): main_maxH);
        if (totalH > main_maxH) {
            totalH = main_maxH;
        }
        
        UIView *mainView = [[UIView alloc]initWithFrame:CGRectMake(main_leftMargin, windowH/2. -totalH/2.0, container_w, totalH)];
        [self addSubview:mainView];
        self.mainView = mainView;
        mainView.layer.cornerRadius = main_radius;
        mainView.backgroundColor = [UIColor whiteColor];
        
        // 标题
        self.topicLb = [[UILabel alloc]initWithFrame:CGRectMake(0, topic_topMargin, container_w, self.topicStr.size.height)];
        self.topicLb.textAlignment = NSTextAlignmentCenter;
        self.topicLb.attributedText = self.topicStr;
        [mainView addSubview:self.topicLb];
        
        // 底部按钮
        for (int i = 0; i < self.bottomTitles.count; i ++) {
            CGFloat w = container_w/self.bottomTitles.count;
            CGFloat x = w *i;
            CGFloat y = totalH -bottomBtn_H;
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(x, y, w, bottomBtn_H)];
            [btn setAttributedTitle:self.bottomTitles[i] forState:UIControlStateNormal];
            [mainView addSubview:btn];
            btn.tag = 10 + i;
            [btn addTarget:self action:@selector(clickBottomBtn:) forControlEvents:UIControlEventTouchUpInside];
            
            if (i != self.bottomTitles.count - 1) {
                UIView *verline = [[UIView alloc]initWithFrame:CGRectMake(x + w -1/[UIScreen mainScreen].scale, y, 1/[UIScreen mainScreen].scale, bottomBtn_H)];
                verline.backgroundColor = lineColor;
                [mainView addSubview:verline];
            }
            if (i == 0) {
                UIView *hozLine = [[UIView alloc]initWithFrame:CGRectMake(0, y, container_w, 1/[UIScreen mainScreen].scale)];
                hozLine.backgroundColor = lineColor;
                [mainView addSubview:hozLine];
            }
        }
        
        // 文本容器
        UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(self.topicLb.frame) +content_topMargin, container_w, totalH -self.topicStr.size.height -topic_topMargin -bottomBtn_H -content_topMargin)];
        [mainView addSubview:scrollView];
        scrollView.backgroundColor = [UIColor whiteColor];
            
        // 文本
        self.contentLb = [[UILabel alloc]initWithFrame:CGRectMake(contentEdgeInsets.left, contentEdgeInsets.top, content_w, autoH)];
        self.contentLb.attributedText = self.contentStr;
        self.contentLb.numberOfLines = 0;
        [scrollView addSubview:self.contentLb];
        [scrollView setContentSize:CGSizeMake(0, autoH + contentEdgeInsets.bottom + contentEdgeInsets.top)];
    }
    return self;
}

- (void)clickBottomBtn:(UIButton *)btn {
    if (self.clickAtIdxBlock) {
        BOOL show = self.clickAtIdxBlock(btn.tag - 10);
        if (!show) [self dismiss];
        return;
    }
    [self dismiss];
}

- (void)show {
    [[UIApplication sharedApplication].keyWindow addSubview:self];
    self.mainView.transform = CGAffineTransformScale(self.mainView.transform, 0.1, 0.1);

    // damping = 1 即为线性 SpringVelocity终点速度
    [UIView animateWithDuration:animateDuration delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:0.5 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainView.transform = CGAffineTransformScale(self.mainView.transform, 10, 10);
        self.maskBGView.alpha = maskAlpha;
    } completion:^(BOOL finished) {
        
    }];
}

- (void)dismiss {
    [UIView animateWithDuration:animateDuration delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainView.transform = CGAffineTransformScale(self.mainView.transform, 0.1, 0.1);
        self.maskBGView.alpha = 0;
    } completion:^(BOOL finished) {
        if (finished) {
            [self.mainView removeFromSuperview];
            self.mainView = nil;
            [self.maskBGView removeFromSuperview];
            self.maskBGView = nil;
            [self removeFromSuperview];
        }
    }];
}
@end
