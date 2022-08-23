//
//  DetailView.swift
//  DrinkApp
//
//  Created by Mehran on 5/28/1401 AP.
//

import SwiftUI

struct DetailView: View {
    
    var id : String = ""
    var isShowContent : Bool = false
    @ObservedObject var viewModel : DetailViewModel
    
    var body: some View {
        
        GeometryReader { geo in
            let geoSize = geo.size
            
            ZStack {
                Color(UIColor.lightDarkBackfround).edgesIgnoringSafeArea(.all)
                
                VStack {
                    if let url = URL(string: viewModel.data.safeImageURL()) {
                        HeaderView(geoSize: geoSize,
                                   url: url,
                                   name: viewModel.data.strDrink.orWhenNilOrEmpty(""))
                    }
                    Spacer()
                    ContentView(geoSize: geoSize, data: viewModel.data)
                }
                SpinnerViewHandler(geoSize: geoSize, isShowing: $viewModel.isShowActivity)
            }
            .hidden(isShowContent)
            .onAppear {
                viewModel.apply(.onAppear(id: id))
            }
        }
        .navigationBarTitle(viewModel.title)
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(id: "", isShowContent: true, viewModel:
                    DetailViewModel(useCase:
                                        DrinkDetail_Request()))
    }
}
