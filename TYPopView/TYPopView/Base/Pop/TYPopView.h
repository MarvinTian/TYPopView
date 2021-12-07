//
//  TYPopView.h
//  TYPopView
//
//  Created by Marvin on 2021/12/6.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol TYPopViewDelegate <NSObject>

/// 弹窗最大高度
- (CGFloat)ty_maxHeight;

/// 弹窗左间距
- (CGFloat)ty_leftMargin;

/// 弹窗右间距
- (CGFloat)ty_rightMargin;

/// 遮罩层透明度
- (CGFloat)ty_maskAlpha;

/// 弹窗圆角
- (CGFloat)ty_radiusVal;

/// 标题上间距
- (CGFloat)ty_topicTopMargin;

/// 文本外间距
- (UIEdgeInsets)ty_contentEdgeInset;

/// 文本上间距
- (CGFloat)ty_contentTopMargin;

/// 底部按钮高度
- (CGFloat)ty_bottomButtonHeight;

/// 线条颜色
- (UIColor *)ty_lineColor;

/// 弹窗动画时长
- (CGFloat)ty_animateDurationTime;

/// 点击遮罩层是否消失
- (BOOL)ty_clickBackgroundDismiss;

/// 高度自适应，随文本高度变化，返回true 达到maxHeight失效
- (BOOL)ty_adjustContentHeight;

@end

@interface TYPopView : UIView

/// 初始化
/// @param topic 标题
/// @param content 内容
/// @param titles 底部按钮
/// @param delegate 代理配置项
- (instancetype)initWithTopic:(NSAttributedString *)topic
                      content:(NSAttributedString *)content
                 bottomTitles:(NSArray<NSAttributedString *>*)titles
                     delegate:(id<TYPopViewDelegate>)delegate;

/// 点击项，返回false则点击选项后弹窗不消失
@property (nonatomic, copy) BOOL(^clickAtIdxBlock)(NSInteger idx);

/// 代理
@property (nonatomic, weak) id<TYPopViewDelegate>popDelegate;

/// 显示（默认window上）
- (void)show;

/// 隐藏
- (void)dismiss;


@end


NS_ASSUME_NONNULL_END
