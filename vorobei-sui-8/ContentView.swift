//
//  ContentView.swift
//  vorobei-sui-8
//
//  Created by Alexey Voronov on 21.10.2023.
//

import SwiftUI

struct ContentView: View {
    @State var value = 1.0
    @State var stretchValue = 0.0
    @State var stretchDown = false
    
    let height: CGFloat = 180
    
    var body: some View {
        ZStack(alignment: .center)  {
            Image("gradient", bundle: nil)
            ZStack(alignment: .bottom) {
                Rectangle()
                    .background(.ultraThinMaterial)
                Color.white
                    .frame(height: (height + stretchValue * 20.0) * value)
            }
            .gesture(
                DragGesture()
                    .onChanged({ value in
                        self.value = min(1, max(0, height - value.location.y)/height)
                        
                        
                        let calc = (height - value.location.y)/height
                        
                        if calc < 0.0 {
                            stretchValue = sqrt(-calc)
                            stretchDown = true
                        }
                        
                        if calc > 1.0 {
                            stretchValue = sqrt(calc - 1.0)
                            stretchDown = false
                        }
                    })
                    .onEnded({ value in
                        withAnimation {
                            stretchValue = 0.0
                        }
                    })
            )
            .frame(width: 80 - stretchValue * 5.0, height: height + stretchValue * 20.0)
            .mask(RoundedRectangle(cornerRadius: 20))
            .offset(x: 0.0, y: stretchDown ? stretchValue * 20.0 : -stretchValue * 20.0)
        }
    }
}

#Preview {
    ContentView()
}
