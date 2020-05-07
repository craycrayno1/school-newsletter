//
//  ContentView.swift
//  SchoolNewsLetter
//
//  Created by Jay Lee on 2020/04/23.
//  Copyright © 2020 Jay Lee. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NoticeView(viewModel: NetworkNoticeViewModel())
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
