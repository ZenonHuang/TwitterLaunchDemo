# HZLaunchView

两行代码完成类似推特启动页的效果

# 效果展示
![demoGif](http://7xiym9.com1.z0.glb.clouddn.com/HZLaunchView.gif)

# 使用

导入`HZLaunchView.h`

初始化

```

HZLaunchView *launchView=[[HZLaunchView alloc] initWithIconImage:[UIImage imageNamed:kTwitterImageName] backgroundColor:color];

```

启用动画

```

[self.launchView startAnimationWithDuration:3];

```


