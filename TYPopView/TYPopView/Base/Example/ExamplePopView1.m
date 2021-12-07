//
//  ExamplePopView.m
//  TYPopView
//
//  Created by Marvin on 2021/12/7.
//

#import "ExamplePopView1.h"

@interface ExamplePopView1 () <TYPopViewDelegate>

@end

@implementation ExamplePopView1

- (instancetype)init {
    return [[ExamplePopView1 alloc]initWithTopic:[[NSAttributedString alloc]initWithString:@"标题" attributes:@{
        NSForegroundColorAttributeName:[UIColor blackColor],
        NSFontAttributeName:[UIFont boldSystemFontOfSize:18]
    }] content:[[NSAttributedString alloc]initWithString:@"总部位于美国，是一个基于维基技术的多语言百科全书式的协作计划，是用多种语言编写而成的网络百科全书。维基百科由非营利组织维基媒体基金会负责营运，维基百科接受捐赠。特点是自由内容、自由编辑。它是全球网络上最大且最受大众欢迎的参考工具书，名列全球十大最受欢迎的网站。Wikipedia是一个混成词，取自网站核心技术“wiki”和英文中百科全书之意的“encyclopedia”。\n\n\n维基百科各个版本的条目之和已经超过5300万条，支持各种语言 [2]  ，其中中文维基百科有超过113万个条目。" attributes:@{
        NSForegroundColorAttributeName:[UIColor darkGrayColor],
        NSFontAttributeName:[UIFont systemFontOfSize:16]
    }] bottomTitles:@[[[NSAttributedString alloc]initWithString:@"取消" attributes:@{
        NSForegroundColorAttributeName:[UIColor lightGrayColor],
        NSFontAttributeName:[UIFont systemFontOfSize:16]
    }], [[NSAttributedString alloc]initWithString:@"确定" attributes:@{
        NSForegroundColorAttributeName:[UIColor blackColor],
        NSFontAttributeName:[UIFont systemFontOfSize:16]
    }]] delegate:self];
}

- (CGFloat)ty_maxHeight {
    return [UIScreen mainScreen].bounds.size.height/4.0;
}



@end
