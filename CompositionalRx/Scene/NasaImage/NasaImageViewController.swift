//
//  NasaImageViewController.swift
//  CompositionalRx
//
//  Created by sae hun chung on 2022/10/29.
//

import UIKit

import RxCocoa
import RxSwift

class NasaImageViewController: BaseViewController {

    let mainView = NasaView()
    
    let viewModel: NasaViewModel = NasaViewModelImpl()
    
    let disposeBag = DisposeBag()

    override func loadView() {
        view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchImage()
    }
    
    override func setBinding() {
        super.setBinding()
        
        viewModel.imageData
            .map { UIImage(data: $0) }
            .asDriver(onErrorJustReturn: UIImage(systemName: "star.fill"))
            .drive(mainView.mainImageView.rx.image)
            .disposed(by: disposeBag)

    }
    

}
