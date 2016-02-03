# 3DTouchDemo
较全的3DTouch功能实现，静态动态快捷启动，peek、pop以及action的使用

####外部标签启动部分（Home Screen Quick Actions）：

可以使用静态方法和动态方法：
	
1.使用静态的就是在工程的info.plist文件中添加字典数组																  

UIApplicationShortcutItems【{

UIApplicationShortcutItemIconFile：图标名，（如果使用系统图标key为UIApplicationShortcutItemIconType）

UIApplicationShortcutItemTitle：标签名称，（必须设置）

UIApplicationShortcutItemSubtitle：子标签名称，

UIApplicationShortcutItemType：标签的ID，（必须设置）

{UIApplicationShortcutItemUserInfo【{key:value}…】(用户附加信息)

}…】

2.使用动态方法添加（在application：didFinishLaunchingWithOptions：也就是程序	启动的时候添加）
	那就要使用一个类UIApplicationShortcutItem先创建好item然后放到				UIApplication的shortcutItems中即可，以下详情：初始化一个item-> 				[[UIApplicationShortcutItem alloc] initWithType:type localizedTitle:title 			localizedSubtitle:nil 	icon:nil userInfo:nil] 再放入Application即可 -> 				[[UIApplication sharedApplication] setShortcutItems:item]

3.使用混合方法：
	结合上面两中方法即可，注意点是必须设置的属性是 标签名称，标签的ID 且最多设															    
	置4个标签
	
####peek、pop和action的使用（结合Demo）
	
摘要：在设置了具有peek、pop的页面跟用户交互的时候主要有三个阶段：①轻按：提示用户这个有预览功能，被选中的空间会凸显出来周围变得模糊。②加大力度：进入peek预览模式，如果设置了该预览模式下的一些操作可以向上滑动显示actions。③更大力度：激活pop，该阶段一般是调到指定的控制器

#####前提

首先我们要将有peek、pop功能的控制器遵守UIViewControllerPreviewingDelegate协议

```objc
@interface BSTableViewController()<UIViewControllerPreviewingDelegate,BSDetailViewControllerDelegate>
```
// 重要
```objc
[self registerForPreviewingWithDelegate:self sourceView:self.view];
```
上面的这个代码相当于是对self.view添加了peek，pop功能

demo里面是以一个BSTableViewController实现该功能，并高亮被触摸的cell

#####轻按：提示预览功能

<img src = "https://raw.githubusercontent.com/ITBigSea/imageSource/master/3DTouch/3dtouch1.png" width = "160",height = "333">

#####peek预览功能：

BSTableViewController实现对应的代理方法：

```objc
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext viewControllerForLocation:(CGPoint)location {
    self.selectedCell = [self searchCellWithPoint:location];
    previewingContext.sourceRect = self.selectedCell.frame;
    
    BSDetailViewController *detailVC = [[BSDetailViewController alloc] init];
    detailVC.delegate = self;
    detailVC.navTitle = self.selectedCell.textLabel.text;
    return detailVC;
}
```
预览图：

<img src = "https://raw.githubusercontent.com/ITBigSea/imageSource/master/3DTouch/3dtouch2.png" width = "160",height = "333">

#####peek中的action：

action的方法是要放到这个预览的VC中，在demo中是放到BSDetailViewController中的
```objc
- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {
    //
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"删除" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([self.delegate respondsToSelector:@selector(detailViewController:DidSelectedDeleteItem:)]) {
            [self.delegate detailViewController:self DidSelectedDeleteItem:self.navTitle];
        }
    }];
    //
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"返回" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        if ([self.delegate respondsToSelector:@selector(detailViewControllerDidSelectedBackItem:)]) {
            [self.delegate detailViewControllerDidSelectedBackItem:self];
        }
    }];
    
    NSArray *actions = @[action1,action2];
    
    return actions;
}
```

这样peek状态下就会有一些action，而对这些action的操作利用了代理在回调中做些动作，附预览图：

<img src = "https://raw.githubusercontent.com/ITBigSea/imageSource/master/3DTouch/3dtouch3.png" width = "160",height = "333">

#####pop的实现：

demo里面pop代理实现的是选择了某个cell，代码如下：
```objc
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext commitViewController:(UIViewController *)viewControllerToCommit {
    [self tableView:self.tableView didSelectRowAtIndexPath:[self.tableView indexPathForCell:self.selectedCell]];
}
```






