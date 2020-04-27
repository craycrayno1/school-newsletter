//
//  NoticeView.swift
//  SchoolNewsLetter
//
//  Created by Jay Lee on 2020/04/23.
//  Copyright © 2020 Jay Lee. All rights reserved.
//

import SwiftUI

struct NoticeView: View {
    let viewModel: NoticeViewModel

    var body: some View {
        Text("Hello, World!")
            .onAppear { self.viewModel.getSchedule() }
    }
}

struct NoticeView_Previews: PreviewProvider {
    static var previews: some View {
        NoticeView(viewModel: NoticeViewModel())
    }
}
