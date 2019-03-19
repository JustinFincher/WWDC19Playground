Tell us about the features and technologies you used in your Swift playground.

About: 
Shader+Node Swift Playground is an audio visualization demo using node graph structure for shaders. The reason I created this is I love music, and graphics (obviously), and I want to make my own VJ with an easy to understand shader scripting system. 

Features:
* Visual scripting by providing a node based editor interface that is great to look at, and similar to other creative coding softwares like Max7 and Shader Forge
* Dynamic shader preview update, self-reload each time the canvas is modified
* Various input node including UITextField / Custom ruler view / Microphone sensor / Time and more
* Can export cg code for external use (current playground does not handle this feature, though the exposed data model is already designed for code export) 
* UI code be used for other node based tools, for example a dialog designer or a behavior tree designer
* Last but not least, this makes iPad a portable & programmable video jockey device!

Technologies: 
* SpriteKit for display pixel shader and handling uniforms
* AVFoundation for recording audio and calculate loudness 
* UIKit & UIKit Dynamics for most UI-related codes

Behind the scene 
* My current approach towards to a node graph tool is simple because SpriteKit and GPU handle the cg shader parsing and executing for me. So I don't have to write a parser or care about the executing result because I don't need to do readback for pixels. After that, all nodes can be treated as symbols and my system only handles code generation from the relations of nodes.
* My shader node editor can have one-to-more (channel split for example), more-to-one (combine channel), one-to-one (sin) and more-to-more (value compare) nodes so it's pretty flexible at this point, but for the nature of shader expression, each in-port can only have one connection (or we couldn't know which out-port variable to match). But the UI-level codebase still has the support for the "2 out-ports connected to a in-port" situation, so this system can be modified to be used as a visual dialog system as dialog systems don't care about the equation, they only care about progress and position.
* The audio input is used as an uniform, with loudness calculated in a NSTimer.
* Built with Swift Playgrounds Author Template for Xcode 10


Beyond WWDC19 (optional)
If you've shared or considered sharing your coding knowledge and enthusiasm for computer science with others, let us know.

My first app was a note app that was completely copied from the book 'Objective-C Programming' of Big Nerd Ranch. The only difference I made was I changed the name of the app to 'Zheng's Note App', as I think with my names on it makes this app special. Later on and now about 4 yrs later, I know that the thing that made the app special is not the changes in the name, but the feeling of crafting and owning a creation. My enthusiasm for computer science started here.   
In the next 4 yrs I have done many things that are software-related. I wrote some custom UI controls and published them on GitHub. I had several out-sourcing jobs in my college time and bought my mom an iPhone 6 when my first payment is delivered, to prove to my parents that I can make money on my own. I also worked as an indie app/game developer that published some  store-featured and product-hunt-listed apps/games. I had some internships and got a good offer from Tencent but later on I rejected them as I was in deferment of my college and not able to graduate until 2019.6. 
After all, I think what I do is basically creating value, some values are presented as cash, some are more abstract, and that's the fun part of being a CS student and indie developer. When I was implementing the idea, I took my aesthetic appreciation and my logic with me, to decide the UI, UX, user flow and feature sets. In short, I was taking my personality and bring them with my works. And this is the same thing as a photographer or a music composer.

500 words or less. Words left: 218

Apps on the App Store (optional)

All apps I made on App Store: https://itunes.apple.com/cn/developer/haotian-zheng/id981803173?mt=8

1. Contributions For GitHub:
https://itunes.apple.com/cn/app/contributions-for-github/id1153432612?mt=8
A small app for viewing your GitHub contributions graph in 2D / 3D perspective. Available on iOS and watchOS.

2. Epoch Core:
https://itunes.apple.com/cn/app/epoch-core/id1177530091?mt=8
Tech demo for showing off my noise shader and procedurally generated planet terrain. Can generate near 1 million different planets.

3. ArtWall:
https://itunes.apple.com/cn/app/artwall/id1178151992?mt=12
If you are a digital artist or just a person who likes digital art, ArtWall is here for you to save ArtStation images as your desktop wallpaper.

4. Golf GO:
https://itunes.apple.com/cn/app/golf-go-scholarship-edition/id1380656648?mt=8
WWDC 18 winner project.

5. JetCat sticker pack:
https://itunes.apple.com/cn/app/喷气猫贴纸包/id1421723208
Cute cats stickers made by my girlfriend, not by me but it's worth noting as it's cute.

Comments (optional)

I used to win a WWDC18 scholarship, but due to the visa application being reviewed for a month (administrative processing), I lost my chance to join. It's quite frustrating, and along with many bad things in 2018, like my deferment & extension on graduation date in school, they all made me stressful. 
For a time, I thought that the magic is gone: I used to be like a wizard, that I can make things happen with my wand, a Macbook, and I never failed. I used to won several hackathons and made several apps that were on listed on product hunt daily. I spelled colorful incantations with Xcode and the magic was there for me. But everything wouldn't come so easy, so finally I managed to live with the truth that I can't have the magic all the time. 
Talking about this would be a little bit weird in an application form as it's too personal and emotional, but when I looked back at my 2018 I am actually feeling appreciated, that all such things made me more peaceful now. And that's my comment here, it might not be related, but I treat it as a self-review that I valued, at the time of me doing WWDC scholarship submission again. Thanks for your time reading this.