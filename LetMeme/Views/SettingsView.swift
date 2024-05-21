//
//  SettingsView.swift
//  LetMeme
//
//  Created by 蕭博文 on 2024/5/21.
//

import SwiftUI
import ColorfulX
import SafariServices

struct SettingsView: View {
    
    @Binding var colors: [Color]
    
    @StateObject var appSettings = AppSettings.shared
    
    
    private func ResetAppSettings(){
        appSettings.colorTimerInterval = 8
        appSettings.colorfulViewOpacity = 0.55
    }
    
    var body: some View {
        ZStack{
            ColorfulView(color: $colors)
                .opacity(appSettings.colorfulViewOpacity)
                .ignoresSafeArea()
            Form{
                Section("Version", content: {
                    Text("Version : \(appVersion!)")
                        .font(.body)
                })
                
                Section("Reddit", content: {
                    VStack {
                        Text("SubReddit")
                        HStack {
                            TextField("", text: appSettings.$subRedditName, prompt: Text("SubReddit name : ")
                            )
                            .autocapitalization(.none)
                            .autocorrectionDisabled()
                            .disabled(appSettings.subRedditNameIsLocked)
                        }
                    }
                    HStack{
                        Text(appSettings.subRedditNameIsLocked ? "Unlock SubReddit Edit Area" : "Lock SubReddit Edit Area")
                        Spacer()
                        Image(systemName: appSettings.subRedditNameIsLocked ? "lock" : "lock.open")
                    }
                    .foregroundColor(.accentColor)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        appSettings.subRedditNameIsLocked.toggle()
                    }
                })
                Section("ColorfulView", content: {
                    VStack {
                        Text("Timer Interval : \(Int(appSettings.colorTimerInterval))")
                        Slider(value: AppSettings.shared.$colorTimerInterval, in: 1...10, step: 1, label: {},
                               minimumValueLabel: { Text("1") },
                               maximumValueLabel: { Text("10") },
                               onEditingChanged: { _ in
                            print("$colorTimerInterval : \(AppSettings.shared.$colorTimerInterval.wrappedValue)")
                        })
                    }
                    VStack {
                        Text("ColorfulView Opacity : \(String(format: "%.2f", appSettings.colorfulViewOpacity))")
                        Slider(value: AppSettings.shared.$colorfulViewOpacity, in: 0...1, step: 0.05, label: {},
                               minimumValueLabel: { Text("0") },
                               maximumValueLabel: { Text("1") },
                               onEditingChanged: { _ in
                            print("$colorfulViewOpacity : \(AppSettings.shared.$colorfulViewOpacity.wrappedValue)")
                        })
                    }
                    Button(action: {
                        ResetAppSettings()
                    }, label: {
                        Text("Reset To Default Settings")
                    })
                })
                Section{
                    HStack {
                        Text("Source code")
                            .foregroundColor(.accentColor)
                        Spacer()
                        Image("GithubIcon")
                            .resizable()
                            .frame(width: 32.0, height: 32.0, alignment: .leading)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        let vc = SFSafariViewController(url: URL(string: "https://github.com/powenn/LetMeme-2")!)
                        UIApplication.shared.firstKeyWindow?.rootViewController?.present(vc, animated: true)
                    }
                }
                Section(footer: Text("Developed by @powenn 2024"), content: {})
            }.scrollContentBackground(.hidden)
        }
    }
}

#Preview {
    //    SettingsView()
    ContentView()
}
