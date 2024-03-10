//
//  DataModelTest.swift
//  ChatView
//
//  Created by 鈴木航太 on 2024/03/05.
//

import SwiftUI

struct DataModelTest: View {
    let user: User = User(id: "1", name: "kota", image: "user01")
    var body: some View {
        VStack {
            Text(user.id)
            
            Text(user.name)
            
            
            Image(user.image)
                .resizable()
                .scaledToFit()
    
        }
    }
}

struct DataModelTest_Previews: PreviewProvider {
    static var previews: some View {
        DataModelTest()
    }
}
