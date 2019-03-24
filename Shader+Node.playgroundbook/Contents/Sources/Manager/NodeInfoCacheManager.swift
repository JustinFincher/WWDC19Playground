//
//  NodeInfoCacheManager.swift
//  ShaderNodeEditor
//
//  Created by Justin Fincher on 17/3/2019.
//  Copyright © 2019 ZHENG HAOTIAN. All rights reserved.
//

import UIKit

class NodeInfoCacheManager: NSObject
{
    static let shared = NodeInfoCacheManager()
    
    private var nodeClasses : Array<AnyClass> = []
    
    override init()
    {
        super.init()
        nodeClasses = NodeData.directSubclasses()
    }
    
    func getNodeClasses() -> Array<AnyClass>
    {
        return nodeClasses
    }
    
    func warmUp() -> Void
    {
        
    }
}
