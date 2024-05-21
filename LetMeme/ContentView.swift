//
//  ContentView.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/1/29.
//

import SwiftUI
import ColorfulX
import SafariServices

struct ContentView: View {
    @State var colors: [Color] = ColorfulPreset.allCases.randomElement()!.colors
    
    @State var postData:RedditPost? = nil
    @State var showWebView = false
    @State var hasAppeared:Bool = false
    
    @StateObject var appSettings = AppSettings.shared
                
    @State var timer = Timer.publish(every: AppSettings.shared.colorTimerInterval, on: .main, in: .common).autoconnect()
    
    func getMeme(){
        Task{
            postData = nil
            postData = try await fetchMeme(subRedditName: appSettings.subRedditName)
        }
    }
    
    var body: some View {
        TabView{
            ZStack {
                ColorfulView(color: $colors)
                    .opacity(appSettings.colorfulViewOpacity)
                    .ignoresSafeArea()
                VStack {
                    Spacer()
                    MemeImageVIew(postData: $postData)
                        .aspectRatio(0.9, contentMode: .fit)
                        .onTapGesture {
                            if (postData?.postLink != nil) {
                                let vc = SFSafariViewController(url: postData!.postLink)
                                UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                            }
                        }
                    Spacer()
                    Button("Get Meme", action: {
                        getMeme()
                    }).buttonStyle(GrowingButton())
                        .padding()
                }
                .padding()
            }.ignoresSafeArea()
            .onReceive(timer, perform: { _ in
                colors = ColorfulPreset.allCases.randomElement()!.colors
                timer = Timer.publish(every: appSettings.colorTimerInterval, on: .main, in: .common).autoconnect()
//                print("Set Random ColorfulPreset")
            })
            .onAppear(perform: {
                if !hasAppeared {
                    getMeme()
                    hasAppeared = true
                }
            })
            SettingsView(colors: $colors)
        }
        .tabViewStyle(PageTabViewStyle())
        .indexViewStyle(PageIndexViewStyle(backgroundDisplayMode: .never))
        .ignoresSafeArea(edges: .all)
        .persistentSystemOverlays(.hidden)
    }
}

#Preview {
    ContentView()
}
