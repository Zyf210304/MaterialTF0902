//
//  ContentView.swift
//  MaterialTF0902
//
//  Created by 张亚飞 on 2021/9/2.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        
        NavigationView {
            
            Home()
                .navigationTitle("Material Design")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct Home : View {
    
    @StateObject var manager = TFManager()
    
    @State var isTapped = false
    
    var body: some View {
        
        VStack {
            
            VStack(alignment: .leading, spacing: 4) {
                
                HStack(spacing: 15) {
                    
                    TextField("", text: $manager.text) { (status) in
                        
                        //it will fire when textfield is clicked...
                        if status {
                            
                            withAnimation {
                                
                                //moving hint to top
                                isTapped = true
                            }
                        }
                    } onCommit: {
                        
                        //it will fire when return button is pressed..
                        //only if no text typed...
                        if manager.text == "" {
                            
                            withAnimation {
                                
                                isTapped = false
                            }
                        }
                    }
                    
                    //trailing icon or button...
                    Button {
                        
                    } label: {
                        
                        Image(systemName: "suit.heart")
                            .foregroundColor(.gray)
                    }

                    
                }
                .padding(.top, isTapped ?  15 : 0)
                //overlay will avoid clicking the textfiled...
                //so moving it below the textfield
                .background(
                
                    Text("UserName")
                        .scaleEffect(isTapped ? 0.8 : 1)
                        .offset(x: isTapped ?  -7 : 0, y: isTapped ? -15 : 0)
                        .foregroundColor(isTapped ? .accentColor : .gray)
                    
                    ,alignment: .leading
                )
                .padding(.horizontal)

                //Divider()
                Rectangle()
                    .fill(isTapped ? Color.accentColor : Color.gray)
                    .opacity(isTapped ? 1 : 0.5)
                    .frame(height: 1)
                    .padding(.top, 10)
                    
            }
            .padding(.top, 12)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(5)
            
            HStack {
                
                Spacer()
                
                Text("\(manager.text.count)/15")
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.trailing)
                    .padding(.top, 3)
            }
        }
        .padding()
    }
}


class TFManager: ObservableObject {
    
    @Published var  text = ""{
        
        //were going to use didSet founction before assigning the new value...
        //so that we can check the count...
        
        
        didSet {

            if text.count > 15 && oldValue.count <= 15 {

                text = oldValue

                //打印的值没有问题 不知道为什么上面长度还能增长
                print(text)
            }

            print(">>>>>" + text)
        }
    }
}
