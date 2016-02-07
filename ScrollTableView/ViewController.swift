//
//  ViewController.swift
//  ScrollTableView
//
//  Created by 李玲 on 2/3/16.
//  Copyright © 2016 Jay. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate,UICollectionViewDataSource{
    
    @IBOutlet weak var myCollectionView: UICollectionView!
    @IBOutlet weak var flowOut: UICollectionViewFlowLayout!
    @IBOutlet weak var myScrollView: UIScrollView!
    var myView:DetailView!
    var photoGallery = [UIImage]()
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePhotoGallery()
        configureCollectionView()
        configureScrollView()
    }

    func configurePhotoGallery(){
        let image1 = UIImage(named: "1")
        let image2 = UIImage(named: "2")
        let image3 = UIImage(named: "3")
        photoGallery.append(image1!)
        photoGallery.append(image2!)
        photoGallery.append(image3!)
    }
    
    func configureScrollView(){
        myView = NSBundle.mainBundle().loadNibNamed("DetailView", owner: self, options: nil)[0] as! DetailView
        myView.frame = CGRect(x: 0, y: myCollectionView.frame.height, width: view.bounds.width, height: view.bounds.height+500)
        myScrollView!.addSubview(myView)
        myScrollView?.delegate = self
        myScrollView?.showsVerticalScrollIndicator = false
        myScrollView!.contentSize = myView!.frame.size
        self.view.bringSubviewToFront(myCollectionView)
    }
    
    func configureCollectionView(){
        myCollectionView.dataSource = self
        myCollectionView.registerNib(UINib(nibName: "PhotoCell", bundle: nil), forCellWithReuseIdentifier: "cell")
        flowOut.itemSize = CGSize(width: view.frame.width, height: CGFloat(200))
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        self.view.bringSubviewToFront(myScrollView)
        if myScrollView.contentOffset.y == 0 {
            self.view.bringSubviewToFront(myCollectionView)
        }
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photoGallery.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! PhotoCell
        let image = photoGallery[indexPath.row]
        cell.photo.image = image
        return cell
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

