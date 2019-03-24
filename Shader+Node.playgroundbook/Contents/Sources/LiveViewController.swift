//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  An auxiliary source file which is part of the book-level auxiliary sources.
//  Provides the implementation of the "always-on" live view.
//

import UIKit
import PlaygroundSupport

@objc(Book_Sources_LiveViewController)
public class LiveViewController: UINavigationController, PlaygroundLiveViewMessageHandler, PlaygroundLiveViewSafeAreaContainer
{

    let nodeEditorViewController : NodeEditorViewController = NodeEditorViewController()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override public func viewDidLoad() {
        super.viewDidLoad()
        setViewControllers([nodeEditorViewController], animated: true)
    }
    
    public func liveViewMessageConnectionOpened()
    {
        // Implement this method to be notified when the live view message connection is opened.
        // The connection will be opened when the process running Contents.swift starts running and listening for messages.
    }
    
    public func liveViewMessageConnectionClosed()
    {
        // Implement this method to be notified when the live view message connection is closed.
        // The connection will be closed when the process running Contents.swift exits and is no longer listening for messages.
        // This happens when the user's code naturally finishes running, if the user presses Stop, or if there is a crash.
    }
    
    public func receive(_ message: PlaygroundValue)
    {
        // Implement this method to receive messages sent from the process running Contents.swift.
        // This method is *required* by the PlaygroundLiveViewMessageHandler protocol.
        // Use this method to decode any messages sent as PlaygroundValue values and respond accordingly.
        
        guard case let .string(messageString) = message else { return }
        if messageString == "true"
        {
            self.nodeEditorViewController.nodeEditorData.removeAll()
            
            
            let uvNode : Vec2TexCoordNodeData = Vec2TexCoordNodeData()
            uvNode.frame  = CGRect.init(x: 16,
                                        y: 16,
                                        width: uvNode.frame.size.width,
                                        height: uvNode.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: uvNode)
            
            let uvOffsetNode : Vec2GeneratorNodeData = Vec2GeneratorNodeData()
            uvOffsetNode.xValue.value = 0.5
            uvOffsetNode.yValue.value = 0.5
            uvOffsetNode.frame  = CGRect.init(x: 16,
                                        y: 320,
                                        width: uvOffsetNode.frame.size.width,
                                        height: uvOffsetNode.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: uvOffsetNode)
            
            let uvOffsetMinusNode : Vec2MinusNodeData = Vec2MinusNodeData()
            uvOffsetMinusNode.frame  = CGRect.init(x: 226,
                                        y: 16,
                                        width: uvOffsetMinusNode.frame.size.width,
                                        height: uvOffsetMinusNode.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: uvOffsetMinusNode)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: uvNode.outPorts[0], inPort: uvOffsetMinusNode.inPorts[0])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: uvOffsetNode.outPorts[0], inPort: uvOffsetMinusNode.inPorts[1])
            
            let uvOffsetLengthNode : Vec2LengthNodeData = Vec2LengthNodeData()
            uvOffsetLengthNode.frame  = CGRect.init(x: 430,
                                                   y: 16,
                                                   width: uvOffsetLengthNode.frame.size.width,
                                                   height: uvOffsetLengthNode.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: uvOffsetLengthNode)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: uvOffsetMinusNode.outPorts[0], inPort: uvOffsetLengthNode.inPorts[0])
            
            let uvOffsetLengthByTwoNode : FloatMultiplyWithValueNodeData = FloatMultiplyWithValueNodeData()
            uvOffsetLengthByTwoNode.aValue.value = 2.0
            uvOffsetLengthByTwoNode.frame  = CGRect.init(x: 640,
                                                         y: 16,
                                                         width: uvOffsetLengthByTwoNode.frame.size.width,
                                                         height: uvOffsetLengthByTwoNode.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: uvOffsetLengthByTwoNode)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: uvOffsetLengthNode.outPorts[0], inPort: uvOffsetLengthByTwoNode.inPorts[0])
            
            let unpackOffsetNodeData : Vec2ChannelSplitNodeData = Vec2ChannelSplitNodeData()
            unpackOffsetNodeData.frame  = CGRect.init(x: 430,
                                                   y: 120,
                                                   width: unpackOffsetNodeData.frame.size.width,
                                                   height: unpackOffsetNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: unpackOffsetNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: uvOffsetMinusNode.outPorts[0], inPort: unpackOffsetNodeData.inPorts[0])
            
            let atanNodeData : FloatAtanNodeData = FloatAtanNodeData()
            atanNodeData.frame  = CGRect.init(x: 430,
                                                      y: 300,
                                                      width: atanNodeData.frame.size.width,
                                                      height: atanNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: atanNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: unpackOffsetNodeData.outPorts[0], inPort: atanNodeData.inPorts[1])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: unpackOffsetNodeData.outPorts[1], inPort: atanNodeData.inPorts[0])
            
            let diskRayNodeData : FloatRayDiscNodeData = FloatRayDiscNodeData()
            diskRayNodeData.frame  = CGRect.init(x: 1000,
                                                      y: 16,
                                                      width: diskRayNodeData.frame.size.width,
                                                      height: diskRayNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: diskRayNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: atanNodeData.outPorts[0], inPort: diskRayNodeData.inPorts[0])
            
            let soundDBBaselineNodeData : FloatGeneratorNodeData = FloatGeneratorNodeData()
            soundDBBaselineNodeData.frame  = CGRect.init(x: 226,
                                                 y: 460,
                                                 width: soundDBBaselineNodeData.frame.size.width,
                                                 height: soundDBBaselineNodeData.frame.size.height)
            soundDBBaselineNodeData.value.value = 0.7
            self.nodeEditorViewController.nodeEditorData.addNode(node: soundDBBaselineNodeData)
            
            let soundDBNodeData : FloatAudioDBNodeData = FloatAudioDBNodeData()
            soundDBNodeData.frame  = CGRect.init(x: 226,
                                              y: 580,
                                              width: soundDBNodeData.frame.size.width,
                                              height: soundDBNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: soundDBNodeData)
            
            let soundDBMinusNodeData : FloatMinusNodeData = FloatMinusNodeData()
            soundDBMinusNodeData.frame  = CGRect.init(x: 430,
                                              y: 500,
                                              width: soundDBMinusNodeData.frame.size.width,
                                              height: soundDBMinusNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: soundDBMinusNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: soundDBBaselineNodeData.outPorts[0], inPort: soundDBMinusNodeData.inPorts[0])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: soundDBNodeData.outPorts[0], inPort: soundDBMinusNodeData.inPorts[1])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: soundDBMinusNodeData.outPorts[0], inPort: diskRayNodeData.inPorts[1])
            
            let diskOneValueNodeData : FloatGeneratorNodeData = FloatGeneratorNodeData()
            diskOneValueNodeData.frame  = CGRect.init(x: 640,
                                                         y: 450,
                                                         width: diskOneValueNodeData.frame.size.width,
                                                         height: diskOneValueNodeData.frame.size.height)
            diskOneValueNodeData.value.value = 5.0
            self.nodeEditorViewController.nodeEditorData.addNode(node: diskOneValueNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: diskOneValueNodeData.outPorts[0], inPort: diskRayNodeData.inPorts[2])
            
            
            let diskTwoValueNodeData : FloatGeneratorNodeData = FloatGeneratorNodeData()
            diskTwoValueNodeData.frame  = CGRect.init(x: 640,
                                                      y: 550,
                                                      width: diskTwoValueNodeData.frame.size.width,
                                                      height: diskTwoValueNodeData.frame.size.height)
            diskTwoValueNodeData.value.value = 7.0
            self.nodeEditorViewController.nodeEditorData.addNode(node: diskTwoValueNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: diskTwoValueNodeData.outPorts[0], inPort: diskRayNodeData.inPorts[3])
            
            let diskOnePrecentageNodeData : FloatGeneratorNodeData = FloatGeneratorNodeData()
            diskOnePrecentageNodeData.frame  = CGRect.init(x: 640,
                                                      y: 650,
                                                      width: diskOnePrecentageNodeData.frame.size.width,
                                                      height: diskOnePrecentageNodeData.frame.size.height)
            diskOnePrecentageNodeData.value.value = 0.7
            self.nodeEditorViewController.nodeEditorData.addNode(node: diskOnePrecentageNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: diskOnePrecentageNodeData.outPorts[0], inPort: diskRayNodeData.inPorts[4])
            
            let diskTwoPrecentageNodeData : FloatGeneratorNodeData = FloatGeneratorNodeData()
            diskTwoPrecentageNodeData.frame  = CGRect.init(x: 640,
                                                           y: 750,
                                                           width: diskTwoPrecentageNodeData.frame.size.width,
                                                           height: diskTwoPrecentageNodeData.frame.size.height)
            diskTwoPrecentageNodeData.value.value = 1.0
            self.nodeEditorViewController.nodeEditorData.addNode(node: diskTwoPrecentageNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: diskTwoPrecentageNodeData.outPorts[0], inPort: diskRayNodeData.inPorts[5])
            
            let smoothStepPassOneNodeData : FloatSmoothStepWithRangeNodeData = FloatSmoothStepWithRangeNodeData()
            smoothStepPassOneNodeData.leftValue.value = 0.0
            smoothStepPassOneNodeData.rightValue.value = 2.0
            smoothStepPassOneNodeData.frame  = CGRect.init(x: 16,
                                                           y: 500,
                                                           width: smoothStepPassOneNodeData.frame.size.width,
                                                           height: smoothStepPassOneNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: smoothStepPassOneNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: diskRayNodeData.outPorts[0], inPort: smoothStepPassOneNodeData.inPorts[0])
            
            
            let radiusMinusNodeData : FloatAddWithValueNodeData = FloatAddWithValueNodeData()
            radiusMinusNodeData.aValue.value = -0.5
            radiusMinusNodeData.frame  = CGRect.init(x: 850,
                                                 y: 16,
                                                 width: radiusMinusNodeData.frame.size.width,
                                                 height: radiusMinusNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: radiusMinusNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: uvOffsetLengthByTwoNode.outPorts[0], inPort: radiusMinusNodeData.inPorts[0])
            
            let smoothStepPassTwoNodeData : FloatSmoothStepNodeData = FloatSmoothStepNodeData()
            smoothStepPassTwoNodeData.frame  = CGRect.init(x: 16,
                                                           y: 700,
                                                           width: smoothStepPassTwoNodeData.frame.size.width,
                                                           height: smoothStepPassTwoNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: smoothStepPassTwoNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: smoothStepPassOneNodeData.outPorts[0], inPort: smoothStepPassTwoNodeData.inPorts[0])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: smoothStepPassOneNodeData.outPorts[0], inPort: smoothStepPassTwoNodeData.inPorts[1])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: uvOffsetLengthByTwoNode.outPorts[0], inPort: smoothStepPassTwoNodeData.inPorts[2])
            
            let smoothStepPassThreeNodeData : FloatSmoothStepNodeData = FloatSmoothStepNodeData()
            smoothStepPassThreeNodeData.frame  = CGRect.init(x: 226,
                                                           y: 700,
                                                           width: smoothStepPassThreeNodeData.frame.size.width,
                                                           height: smoothStepPassThreeNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: smoothStepPassThreeNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: smoothStepPassOneNodeData.outPorts[0], inPort: smoothStepPassThreeNodeData.inPorts[0])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: smoothStepPassOneNodeData.outPorts[0], inPort: smoothStepPassThreeNodeData.inPorts[1])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: radiusMinusNodeData.outPorts[0], inPort: smoothStepPassThreeNodeData.inPorts[2])
            
            let smoothStepMinusNodeData : FloatMinusNodeData = FloatMinusNodeData()
            smoothStepMinusNodeData.frame  = CGRect.init(x: 700,
                                                             y: 950,
                                                             width: smoothStepMinusNodeData.frame.size.width,
                                                             height: smoothStepMinusNodeData.frame.size.height)
            self.nodeEditorViewController.nodeEditorData.addNode(node: smoothStepMinusNodeData)
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: smoothStepPassTwoNodeData.outPorts[0], inPort: smoothStepMinusNodeData.inPorts[0])
            self.nodeEditorViewController.nodeEditorData.connectNode(outPort: smoothStepPassThreeNodeData.outPorts[0], inPort: smoothStepMinusNodeData.inPorts[1])
            
            self.nodeEditorViewController.nodeEditorView.contentOffset = CGPoint(x: 600, y: 800)
            self.nodeEditorViewController.nodeEditorView.setZoomScale(0.6, animated: true)
            
            DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1), execute:
                {
                self.nodeEditorViewController.nodeEditorData.forceUpdate()
            })
        }
    }
    
}
