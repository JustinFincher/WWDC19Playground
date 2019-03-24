//#-hidden-code
//
//  See LICENSE folder for this template’s licensing information.
//
//  Abstract:
//  The Swift file containing the source code edited by the user of this playground book.
//
//#-end-hidden-code

/*:
 # Music x Node Shader Editor
 > Write amazing shaders with your creativity and ingenuity (and without any coding skill because drag'n'drop saves the day.🤔)
 
 Hi, are you interested in graphic related stuff, like visual effects in hollywood, AAA game development and video jockey? If so, then you must be wondering how do people achieve these great effects! The answer is shader, which is a type of computer program that can do literally everything now, from simple graphic to powering autonomous driving. **Today we are going to use the iPad to build a music visualization shader using my shader node editor, which is a visual scripting system I wrote in Swift**.

 ---
 
 Let's do it step by step:
 
 1. Grant the micphone permission (needed for the audio db input)
 2. Play a music using other devices (or just clap your hands when needed)
 3. On the right panel
    1. Long press and pick the node called [`Audio DB (float u_audiodb)`] in `Generator` section
    2. Add a [`Float Circle`] node in `Consumer` section
    3. Connect the two by dragging (`DB`) knot on the audio node to the (`Radius`) knot on the circle node
    4. Add a [`UV (vec2 v_tex_coord)`] node in `Generator` section, then connect the (`UV`) knot on the UV node with the corresponding (`UV`) knot on the circle node
    5. Get along with the music or clap your hands! You can see the circle pops out when you drop a beat
 4. If you want to see a cooler & more detailed example, just change the expression below to true and press the button to run.
 */

// Change isPowerUpEnabled to true and press run code button, remember to wait for a while after pressing the button, as the node graph will create nodes and update itself.
var isPowerUpEnabled = /*#-editable-code*/<#T##click to enable##Bool#>/*#-end-editable-code*/

//#-hidden-code
import Foundation
import PlaygroundSupport

//let page = PlaygroundPage.current
//page.needsIndefiniteExecution = true

if (isPowerUpEnabled)
{
    guard let remoteView = PlaygroundPage.current.liveView as? PlaygroundLiveViewMessageHandler else {
        fatalError("Always-on live view not configured in this page's LiveView.swift.")
    }
    remoteView.send(.string("true"))
}

//#-end-hidden-code

/*:
 The node graph, which should have been updated after changing the power up expression to true, is now more complex (and fun). You can see multiply lines connection various nodes like 'smoothstep' and 'atan', they are all common functions in the shader world. The node graph now is a visual representation of the shader code below:
 
 ````
 #ifdef GL_ES
 precision mediump float;
 #endif
 
 uniform vec2 u_resolution;
 uniform float u_time;
 uniform float u_audiodb;
 
 void main()
 {
     vec2 st = gl_FragCoord.xy/u_resolution.xy;
     vec2 pos = vec2(0.5)-st;
     float r = length(pos)*2.0;
     float a = atan(pos.y,pos.x);
 
     float f = smoothstep(10.0 * (1.0 - u_audiodb)),0.5,sin(a * 5.0 + u_time) * 0.7 + cos(a * 7.0) * 1.0);
     float s = smoothstep(0.0,2.0,f);
     vec3 colorIn = vec3(1.0- smoothstep(s,s,r - 0.5));
     vec3 colorOut = vec3(1.0- smoothstep(s,s,r - 0.2));
     gl_FragColor = vec4(colorIn - colorOut, 1.0);
 }
 ````
 
 And you can change parameters by editing some float generator nodes and giving it a new value, the node graph will update the shader to reflect your changes. Try it out!

 # About
 Shader+Node Swift Playground is a shader node editor demo made by ZHENG HAOTIAN (郑昊天).
 
 ## Features
 * Visual scripting by providing a node based editor interface that is great to look at, and similar to other creative coding softwares like Max7 and Shader Forge
 * Dynamic shader preview update, self-reload each time the canvas is modified
 * Various input node including UITextField / Custom ruler view / Microphone sensor / Time and more
 * Can export cg code for external use (current playground does not handle this feature, though the exposed data model is already designed for code export)
 * UI code be used for other node based tools, for example a dialog designer or a behavior tree designer
 * At last, this makes iPad a portable & programmable video jockey device!
 
 ## Technologies
 * **SpriteKit** for display pixel shader and handling uniforms
 * **AVFoundation** for recording audio and calculate loudness
 * **UIKit & UIKit Dynamics** for most UI-related codes
 
 ## Behind the scene
 * My current approach towards to a node graph tool is simple because SpriteKit and GPU handle the cg shader parsing and executing for me. So I don't have to write a parser or care about the executing result because I don't need to do readback for pixels. After that, all nodes can be treated as symbols and my system only handles code generation from the relations of nodes.
 * Each node with no connection from out-ports is stored in GraphNodeData and being treated as the first node when searching the graph. Then we search the next node in a reversed direction (last node -> first node), assigning each node a unqiue id, until there is no node to search, and that's pass #1. In pass #2 we still make searches in a reversed direction, but this time we have a map<id,array> with us to collect each node's expression rule. If we encountered an already included rule when searching, we move this rule to the front in the array because the variable this rule declared is referenced again in a more recent time. After pass #2 we combine each string in the array to have the final shader expression for the node of an id.
 * My shader node editor can have one-to-more (channel split for example), more-to-one (combine channel), one-to-one (sin) and more-to-more (value compare) nodes so it's pretty flexible at this point, but for the nature of shader expression, each in-port can only have one connection (or we couldn't know which out-port variable to match). But the UI-level codebase still has the support for the "2 out-ports connected to a in-port" situation, so this system can be modified to be used as a visual dialog system as dialog systems don't care about the equation, they only care about progress and position.
 * The audio input is used as an uniform, with loudness calculated in a NSTimer.
 
 ---
 
 # Author
 ZHENG HAOTIAN (郑昊天), a.k.a Justin Fincher.
 Born in 97, near graduation (deferment in 2018) at CSU, indie app / games developer.
 Visit [https://fincher.im](https://fincher.im) for blog posts, portfolio and resume.
 
 */

