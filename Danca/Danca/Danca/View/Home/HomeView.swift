//
//  HomeView.swift
//  Danca
//
//  Created by Kim Yewon on 2022/11/05.
//

import SwiftUI

struct HomeView: View {
    
    var book: [Book] = Library().loadBooks()
    @State private var selectedBook: Int? = nil
    @State private var isSelected: Bool = false
    
    var body: some View {
        
        NavigationView {
            ScrollViewReader { proxy in
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 35) {
                        NavigationLink(isActive: $isSelected) {
                            BookView()
                        } label: {
                            EmptyView()
                        }//: NavigationLink
                        
                        ForEach(book.indices, id:\.self) { index in
                            book[index].coverImage
                                .resizable()
                                .frame(
                                    width: selectedBook == index ? 350 : 300,
                                    height: selectedBook == index ? 450 : 400
                                )
                                .cornerRadius(10)
                                .id(index)
                                .onTapGesture {
                                    if selectedBook != index {
                                        withAnimation {
                                            proxy.scrollTo(index, anchor: .center)
                                            selectedBook = index
                                        }
                                    } else {
                                        isSelected = true
                                    }
                                }
                        }//: ForEach
                    }//: HStack
                    
                }//: ScrollView
                .padding(.horizontal, 30)
            }//: ScrollViewReader
        }
        .navigationViewStyle(StackNavigationViewStyle())
        
        
    }
}

struct ProfileView: View {
    var body: some View {
        ZStack {
            
            HStack {
                Spacer()
                
                Image(systemName: "chevron.backward")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 24, height: 24)
            }
            
            VStack {
                Spacer()
            }
            
        }
        .padding(.horizontal, 100)
        .background (
            Image("inside_solo")
                .resizable()
                .frame(width: 500)
                .aspectRatio(contentMode: .fill)
        )
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
            .previewInterfaceOrientation(.landscapeRight)
    }
}
