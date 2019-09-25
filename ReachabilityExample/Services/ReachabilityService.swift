//
//  ReachabilityService.swift
//  ReachabilityExample
//
//  Created by Станислав Шияновский on 9/25/19.
//  Copyright © 2019 Станислав Шияновский. All rights reserved.
//

import Foundation
import Reachability

public enum FetchTask {
    case getUser(completion: (UserResponse?) -> ())
}

public protocol ReachabilityProtocol: class {
    func addTask(task: FetchTask)
    func processTask()
}

public class ReachabilityService: ReachabilityProtocol {
    
    private var tasks: [FetchTask]
    private var isInProcess: Bool
    private var tasksTimer: Timer?

    private let fetcher = NetworkDataFetcher()
    private let reachability = Reachability()!
    
    public init() {
        self.tasks = []
        self.isInProcess = false
        
        NotificationCenter.default.addObserver(self, selector: #selector(networkStatusChanged(_:)), name: .reachabilityChanged, object: reachability)
        
        do {
            try reachability.startNotifier()
        } catch {
            print("Unable to start notifier")
        }
    }
    
    public func addTask(task: FetchTask) {
        tasks.append(task)
        
        guard tasksTimer == nil else { return }
        prepareTasksTimer()
    }
    
    public func processTask() {
        guard !tasks.isEmpty else { return }
        let task = tasks.first!
        isInProcess = true
        switch task {
        case .getUser(let completion): fetcher.getUser { (user) in
                self.isInProcess = false
                return completion(user)
            }
        }
        tasks.remove(at: 0)
    }
    
    @objc private func networkStatusChanged(_ notification: Notification) {
        let reachability = notification.object as! Reachability
        switch reachability.connection {
        case .wifi:
            print("Reachable via WiFi")
            iterateTasks()
        case .cellular:
            print("Reachable via Cellular")
            iterateTasks()
        case .none:
            print("Network not reachable")
        }
    }
    
    @objc private func iterateTasks() {
        guard reachability.connection != .none else { return }
        guard !tasks.isEmpty, isInProcess == false else {
            tasksTimer?.invalidate()
            return
        }
        processTask()
    }
    
    private func prepareTasksTimer() {
        tasksTimer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(iterateTasks), userInfo: nil, repeats: true)
        tasksTimer?.fire()
    }
}
