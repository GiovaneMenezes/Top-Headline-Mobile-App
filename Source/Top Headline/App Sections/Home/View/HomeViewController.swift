//
//  HomeViewController.swift
//  Top Headline
//
//  Created by Giovane Silva de Menezes Cavalcante on 30/03/19.
//  Copyright © 2019 GSMenezes. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    var viewModel: HomeViewModel!

    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupObservables()
        viewModel.fetchArcticle()
        collectionView.alpha = 0
    }
    
    func setupObservables() {
        viewModel.newsCellModels.didChange = { [weak self] _ in
            self?.collectionView.reloadData()
        }
        viewModel.isLoading.didChange = { [weak self] state in
            DispatchQueue.main.async {
                self?.changeLoadingState(state)
            }
        }
        viewModel.isErrored.didChange = { value in
            if let value = value {
                print(value)
            }
        }
    }
    
    func changeLoadingState(_ isLoading: Bool) {
        UIView.animate(withDuration: 0.3) {
            self.collectionView.alpha = isLoading ? 0 : 1
        }
    }
    
    func registerCells() {
        collectionView.register(UINib(nibName: NewsCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: NewsCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: LoadingCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: LoadingCollectionViewCell.identifier)
        collectionView.register(UINib(nibName: LastCollectionViewCell.identifier, bundle: nil),
                                forCellWithReuseIdentifier: LastCollectionViewCell.identifier)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0 {
            return CGSize(width: view.bounds.width * 0.95, height: 310.0)
        } else if indexPath.section == 1 {
            return CGSize(width: view.bounds.width, height: 45)
        } else {
            return .zero
        }
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            viewModel.onArticleDidSelected(index: indexPath.row)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if section == 0 {
            return viewModel.newsCellModels.value.count
        } else if section == 1 {
            return 1
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0 {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: NewsCollectionViewCell.identifier, for: indexPath) as? NewsCollectionViewCell else { return UICollectionViewCell() }
            cell.fill(with: viewModel.newsCellModels.value[indexPath.row])
            return cell
        } else if indexPath.section == 1 && viewModel.nextPageAvailable {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LoadingCollectionViewCell.identifier, for: indexPath) as? LoadingCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else if indexPath.section == 1 && !viewModel.nextPageAvailable {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: LastCollectionViewCell.identifier, for: indexPath) as? LastCollectionViewCell else { return UICollectionViewCell() }
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if offsetY > contentHeight - scrollView.frame.height * 1 {
            if !viewModel.isFetching && viewModel.nextPageAvailable {
                viewModel.fetchArcticle()
                collectionView.reloadSections(IndexSet(integer: 1))
            }
        }
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
}
