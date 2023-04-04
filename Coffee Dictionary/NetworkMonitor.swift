//
//  NetworkMonitor.swift
//  Coffee Dictionary
//
//  Created by Eyüp Mert on 3.04.2023.
//

import Foundation
import Network

final class NetworkMonitor {
    static let shared = NetworkMonitor();
    
    private let queue = DispatchQueue.global();
    private let monitor: NWPathMonitor;
    
    public private(set) var isConnected: Bool = false;
    
    public private(set) var connectionType: ConnectionType? = .unknown

    enum ConnectionType{
        case wifi
        case cellular
        case ethernet
        case unknown
    }
    
    private init(){
        monitor = NWPathMonitor();
        
    }
    
    public func startMonitoring(completionHandler:@escaping (Bool) -> ()) {
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { [weak self] path in
            self?.isConnected = path.status == .satisfied
            self?.getConnectionType(path)
            
            completionHandler(self?.isConnected ?? false)
        }
    }
    
    public func stopMonitoring(){
        monitor.cancel()
    }
    
    private func getConnectionType(_ path: NWPath){
        if path.usesInterfaceType(.wifi){
            connectionType = .wifi
        }else if path.usesInterfaceType(.cellular){
            connectionType = .cellular
        }else if path.usesInterfaceType(.wiredEthernet){
            connectionType = .ethernet
        }
        else {
            connectionType = .unknown
        }
        
    }
    
}
