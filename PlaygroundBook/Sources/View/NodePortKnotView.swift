//
//  NodePortKnotView.swift
//  ShaderNodeEditor
//
//  Created by Justin Fincher on 15/3/2019.
//  Copyright © 2019 ZHENG HAOTIAN. All rights reserved.
//

import UIKit

public class NodePortKnotView: UIView
{
    public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView?
    {
        return CGRect.init(x: 4, y: 4, width: self.frame.size.width - 8, height: self.frame.size.height - 8).contains(point) ? self : nil
    }

}
