//
//  NukeImage.swift
//  RickMortyTCA
//
//  Created by Bogdan Zykov on 05.02.2024.
//

import SwiftUI
import NukeUI
import Nuke

struct NukeImage: View {
    
    private var url: URL?
    var strUrl: String?
    var resizeSize: CGSize
    var contentMode: ImageProcessingOptions.ContentMode
    var loadPriority: ImageRequest.Priority = .normal
    var upscale: Bool
    var crop: Bool
    private let imagePipeline = ImagePipeline(configuration: .withDataCache)
    
    init(strUrl: String?,
         resizeSize: CGSize = .init(width: 200, height: 200),
         contentMode: ImageProcessingOptions.ContentMode = .aspectFill,
         loadPriority: ImageRequest.Priority = .normal,
         upscale: Bool = false,
         crop: Bool = true) {
        self.strUrl = strUrl
        self.resizeSize = resizeSize
        self.contentMode = contentMode
        self.loadPriority = loadPriority
        if let strUrl = strUrl {
            self.url = URL(string: strUrl)
        }
        self.crop = crop
        self.upscale = upscale
       
    }
    var body: some View {
        Group {
            if let url = url {
                LazyImage(url: url, transaction: .init(animation: .easeInOut)){ state in
                    if let image = state.image {
                        image
                            .aspectRatio(contentMode: contentMode == .aspectFill ? .fill : .fit)
                    } else if state.isLoading {
                        Color.secondary
                    } else if state.error != nil {
                        Color.gray
                    }
                }
                .processors([ImageProcessors.Resize.resize(size: resizeSize,
                                                           unit: .pixels,
                                                           contentMode: contentMode,
                                                           crop: crop,
                                                           upscale: upscale)])
                .priority(loadPriority)
                .pipeline(imagePipeline)
            } else {
                ZStack {
                    Color.red
                        Image(systemName: "exclamationmark.octagon")
                        .font(.title)
                        .foregroundColor(.white)
                }
            }
        }
    }
}
