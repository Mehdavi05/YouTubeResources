//
//  ViewController.swift
//  Multi Threading
//
//  Created by Tunde on 13/04/2021.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    private let contentImgVw: UIImageView = {
        let imgVw = UIImageView()
        imgVw.clipsToBounds = true
        imgVw.translatesAutoresizingMaskIntoConstraints = false
        imgVw.contentMode = .scaleAspectFill
        imgVw.backgroundColor = .systemGray4
        imgVw.layer.cornerRadius = 8
        return imgVw
    }()
    
    private let downloadBtn: UIButton = {
        let btn = UIButton()
        btn.addTarget(self, action: #selector(downloadDidTouch), for: .touchUpInside)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.layer.cornerRadius = 8
        btn.setTitle("Download", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        return btn
    }()
    
    private let contentContainerStackVw: UIStackView = {
        let stackVw = UIStackView()
        stackVw.spacing = 16
        stackVw.axis = .vertical
        stackVw.distribution = .fillProportionally
        stackVw.translatesAutoresizingMaskIntoConstraints = false
        return stackVw
    }()
    
    private let imgLink = "https://media.wired.com/photos/5f2d7c2191d87e6680b80936/16:9/w_2400,h_1350,c_limit/Science_climatedesk_453801484.jpg"
    private let imgDownloadViewModel = ImageDownloadViewModel()
    private var subscriptions: Set<AnyCancellable> = []
    
    override func loadView() {
        super.loadView()
        setup()
        setUpImageSubscription()
    }
    
    @objc
    func downloadDidTouch() {
        imgDownloadViewModel.download(url: imgLink)
    }
}

private extension ViewController {
    
    func setup() {
        
        contentContainerStackVw.addArrangedSubview(contentImgVw)
        contentContainerStackVw.addArrangedSubview(downloadBtn)
        
        view.addSubview(contentContainerStackVw)
        
        NSLayoutConstraint.activate([
            downloadBtn.heightAnchor.constraint(equalToConstant: 44),
            contentImgVw.heightAnchor.constraint(equalToConstant: 150),
            
            contentContainerStackVw.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            contentContainerStackVw.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            contentContainerStackVw.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                             constant: 16),
            contentContainerStackVw.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                              constant: -16)
        ])
    }
    
    func setUpImageSubscription() {
        imgDownloadViewModel
            .image
            .sink { [weak self] newImage in
                self?.contentImgVw.image = newImage
            }
            .store(in: &subscriptions)
    }
}
