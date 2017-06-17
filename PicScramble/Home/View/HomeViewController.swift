//
// Created by Pratik Grover on 17/06/17.
// Copyright (c) 2017 Personal. All rights reserved.
//

import Foundation
import UIKit

class HomeViewController: UIViewController {

    var output: HomeViewOutput!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var imageUrls: [String] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        //setup theming here
        self.output.viewIsReady()
    }
    
    func refreshData(images: [String]) {
        self.imageUrls = images
        self.collectionView.reloadData()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: PicCollectionViewCell = self.collectionView.dequeueReusableCell(withReuseIdentifier: PicCollectionViewCell.getReusableIdentifier(), for: indexPath) as! PicCollectionViewCell
        cell.configure(imageUrl: )
        return cell
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 10, height: 10)
    }
}
