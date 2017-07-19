# RxswiftCollectionDataSourceIssueDemo
my issue waste much time 

custom collectionviewflowlayout got 

*** Assertion failure in -[UICollectionViewData validateLayoutInRect:], /BuildRoot/Library/Caches/com.apple.xbs/Sources/UIKit_Sim/UIKit-3600.7.47/UICollectionViewData.m:433
UICollectionView received layout attributes for a cell with an index path that does not exist: <NSIndexPath: 0x600000031760> {length = 2, path = 0 - 5}

updated:(solved)
解决了迄今最恼人的 rxswift 问题，由于 datasource 还没有绑定就去 reload collection，导致 crash，所以 collection flowlayout 需要放到 bind 之后才赋值。

Solve the most annoying rxswift problem so far, because the datasource has not bound to reload collection, resulting in crash, so collection flowlayout need to assign after binding.
