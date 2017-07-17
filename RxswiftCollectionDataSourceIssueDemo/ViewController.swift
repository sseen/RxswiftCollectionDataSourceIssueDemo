//
//  ViewController.swift
//  RxswiftCollectionDataSourceIssueDemo
//
//  Created by sseen on 2017/7/17.
//  Copyright © 2017年 sseen. All rights reserved.
//

import UIKit

import RxSwift
import RxCocoa
import RxDataSources

typealias NumberSection = AnimatableSectionModel<String, Int>

class ViewController: UIViewController {
    
    var mainCollection:UICollectionView!
    var sections = Variable([NumberSection]())
    static let initialValue: [AnimatableSectionModel<String, Int>] = [
        NumberSection(model: "section 1", items: [1, 2, 3, 4, 5])
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let layout = RDHomeCollectionFlowLayout()
        layout.datas = ViewController.initialValue
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize(width: self.itemWidth(), height: RD.CommonUnit.bannerHeight / 2)
        layout.headerReferenceSize = CGSize(width: K.ViewSize.SCREEN_WIDTH, height:RD.CommonUnit.bannerHeight)
        mainCollection = UICollectionView(frame: CGRect(x: 0, y: RD.CommonUnit.navPlusStatus, width: K.ViewSize.SCREEN_WIDTH, height: K.ViewSize.SCREEN_HEIGHT), collectionViewLayout: layout)
        mainCollection.bounces = true
        mainCollection.alwaysBounceVertical = true
        mainCollection.backgroundColor = UIColor.white
        mainCollection.register(RDHomeCollectionViewCell.self, forCellWithReuseIdentifier: RD.CommonUnit.cellReuse)
        
        self.view.addSubview(mainCollection)
        
        // rx data
        self.sections.value = ViewController.initialValue
        let cvReloadDataSource = RxCollectionViewSectionedReloadDataSource<NumberSection>()
        // cell
        cvReloadDataSource.configureCell = { (_, cv, ip, i) in
            let cell = cv.dequeueReusableCell(withReuseIdentifier: RD.CommonUnit.cellReuse, for: ip) as! RDHomeCollectionViewCell
            cell.textLabel.text = "\(i)"
            cell.backgroundColor = UIColor.darkGray
            
            return cell
        }
        self.sections.asObservable()
            .asObservable().observeOn(MainScheduler.instance)
            .bind(to: mainCollection.rx.items(dataSource: cvReloadDataSource))
            .disposed(by: K.Rx.disposeBag)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func itemWidth() -> CGFloat {
        let items:CGFloat = 4
        let width = self.view.frame.width  / items
        return width
    }


}

