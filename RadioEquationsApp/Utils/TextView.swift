//
//  TextView.swift
//  RadioEquationsApp
//
//  Created by Robert J. Sarvis Jr on 7/11/23.
//

import SwiftUI
import RichTextView

struct TextView : UIViewRepresentable {
    
    @Binding var string : String
    
    func makeUIView(context: Context) -> RichTextView {
        let richTextView = RichTextView(
            input: string,
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
            textColor: UIColor.black,
            frame: CGRect.zero,
            completion: nil
        )
        
        return richTextView
        
    }

   func updateUIView(_ uiView: RichTextView, context: Context) {
        uiView.update(
            input: string,
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: UIFont.systemFontSize),
            textColor: UIColor.black,
            completion: nil
        )
   }
}
