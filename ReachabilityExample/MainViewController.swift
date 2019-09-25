//
//  MainViewController.swift
//  ReachabilityExample
//
//  Created by Станислав Шияновский on 9/25/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import UIKit

public class MainViewController: UIViewController {
    
    private var networking: Networking!
    private var fetcher: DataFetcher!
    private let reachability = ReachabilityService()
    
    public override func loadView() {
        super.loadView()
        
        view.backgroundColor = .yellow
    }

    public override func viewDidLoad() {
        super.viewDidLoad()
        
        networking = NetworkService()
        fetcher = NetworkDataFetcher(networking: networking)
        makeRequest()
    }
    
    private func makeRequest() {
//        fetcher.getUser { (user) in
//            DispatchQueue.main.async { [weak self] in
//                guard let `self` = self else { return }
//                self.view.backgroundColor = .red
//            }
//        }
        
        reachability.addTask(task: .getUser(completion: { (user) in
            DispatchQueue.main.async { [weak self] in
                guard let `self` = self else { return }
                self.view.backgroundColor = .red
            }
        }))
    }
}

