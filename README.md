##TYPopView
一款简单的文本弹窗

###演示效果
![demoGif.gif](https://github.com/MarvinTian/TYPopView/blob/main/demoGif.gif)
###一.安装
`
pod install 'TYPopView'
`

###二.使用
TYPopView作为基础组件，用户基础业务组件继承TYPopView.
```
ExamplePopView *popView = [[ExamplePopView alloc]initWithTopic:[[NSAttributedString alloc]initWithString:@"标题" attributes:@{
        NSForegroundColorAttributeName:[UIColor blackColor],
        NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
    }] content:[[NSAttributedString alloc]initWithString:@"内容" attributes:@{
        NSForegroundColorAttributeName:[UIColor darkGrayColor],
        NSFontAttributeName:[UIFont systemFontOfSize:16]
    }] bottomTitles:@[[[NSAttributedString alloc]initWithString:@"取消" attributes:@{
        NSForegroundColorAttributeName:[UIColor lightGrayColor],
        NSFontAttributeName:[UIFont systemFontOfSize:16]
    }], [[NSAttributedString alloc]initWithString:@"确定" attributes:@{
        NSForegroundColorAttributeName:[UIColor blackColor],
        NSFontAttributeName:[UIFont systemFontOfSize:16]
    }]] delegate:self];
    
[popView show];
```
自定义样式，遵循代理TYPopViewDelegate，在基础业务组件中实现即可，不实现也会有默认值返回。
```
// 例如
// 无高度限制的弹窗
- (BOOL)ty_adjustContentHeight {
    return true;
}
```

