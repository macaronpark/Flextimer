////
////  OpensourceView.swift
////  Flextimer
////
////  Created by Suzy Park on 2019/11/11.
////  Copyright © 2019 Suzy Mararon Park. All rights reserved.
////
//
//import SwiftUI
//import WebKit
//
//struct ActivityIndicator: UIViewRepresentable {
//
//    typealias UIViewType = UIActivityIndicatorView
//
//    let style: UIActivityIndicatorView.Style
//
//    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> ActivityIndicator.UIViewType {
//        return UIActivityIndicatorView(style: style)
//    }
//
//    func updateUIView(_ uiView: ActivityIndicator.UIViewType, context: UIViewRepresentableContext<ActivityIndicator>) {
//        uiView.startAnimating()
//    }
//}
//
//struct ActivityIndicatorView<Content>: View where Content: View {
//    @Binding var isShowing: Bool
//    var content: () -> Content
//
//    var body: some View {
//        ZStack(alignment: .center) {
//            self.content()
//                .blur(radius: self.isShowing ? 3 : 0)
//
//            if (self.isShowing) {
//                ActivityIndicator(style: .medium)
////                    .frame(width: ScreenSize.width / 2.0, height: ScreenSize.height)
//            }
//        }
//    }
//}
//
//struct WebView: UIViewRepresentable {
//    @Binding var isFinish: Bool
//
//    let request: URLRequest = URLRequest(url: URL(string: "https://www.notion.so/Opensources-5f23792b38334a17b6795a00dc20de7b")!)
//
//    func makeUIView(context: Context) -> WKWebView {
//        let webView = WKWebView()
//        webView.navigationDelegate = context.coordinator
//        return webView
//    }
//
//    func updateUIView(_ uiView: WKWebView, context: Context) {
//        uiView.load(request)
//    }
//
//    func makeCoordinator() -> WebView.Coordinator {
//        Coordinator(self)
//    }
//
//    class Coordinator: NSObject, WKNavigationDelegate {
//        var _webView: WebView!
//
//        override init() {
//            super.init()
//        }
//
//        convenience init(_ webView: WebView) {
//            self.init()
//            self._webView = webView
//        }
//
//        func webView(_ webView: WKWebView, didCommit navigation: WKNavigation!) {
//            print(webView.isLoading)
//        }
//
//        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
//            _webView.isFinish = true
//        }
//    }
//}
//
//struct OpensourceView: View {
//
//    @State var isUnload = true
//
//    var body: some View {
//        ActivityIndicatorView(isShowing: $isUnload) {
//            WebView(isFinish: .init(get: {
//                return !self.isUnload
//            }, set: { value in
//                    self.isUnload = !value
//            }))
//        }
//        .navigationBarTitle("Opensources", displayMode: .inline)
//    }
//}
//
//#if DEBUG
//    struct WebView_Previews: PreviewProvider {
//        static var previews: some View {
//            OpensourceView()
//        }
//    }
//#endif
