//
//  NoticeView.swift
//  SchoolNewsLetter
//
//  Created by Jay Lee on 2020/04/23.
//  Copyright © 2020 Jay Lee. All rights reserved.
//

import SwiftUI

// 1. NavigationView 알아오기
// 2. rawDate를 "2020년 4월 18일" + row customizing
// 3. Project Euler 1번 문제 Swift로
struct NoticeView: View {
    @ObservedObject var viewModel: NoticeViewModel
    
    var body: some View {
        NavigationView {
            List(viewModel.events, id: \.self) { event in
                HStack {
                    Text(event.dateRepresentation ?? "")
                    Spacer()
                    Text(event.title)
                }
            }
            .navigationBarTitle("School Events")
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear { self.viewModel.getSchedule() }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static let viewModel = StubNoticeViewModel()
    static var previews: some View {
        Group {
            NoticeView(viewModel: viewModel)
                .colorScheme(.light)
            NoticeView(viewModel: viewModel)
                .colorScheme(.dark)
                .previewDevice(PreviewDevice(rawValue: "iPad Pro (11-inch) (2nd generation)"))
        }
    }
}
