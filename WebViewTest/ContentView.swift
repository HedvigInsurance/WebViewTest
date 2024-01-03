//
//  ContentView.swift
//  WebViewTest
//
//  Created by Robin Andeer on 2023-12-27.
//

import SwiftUI
import WebKit

let widgetURL = "https://dev.hedvigit.com/se/widget/avy-offer"

class Coordinator: NSObject, WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        if let url = navigationAction.request.url, url.pathExtension == "pdf" {
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url)
            }
        }

        decisionHandler(.allow)
    }
}

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator()
    }
}

struct ContentView: View {
    @State private var showWebView = false

    var body: some View {
        VStack {
            Button("Show Web View") {
                showWebView = true
            }
            .padding()
            .background(Color.blue)
            .foregroundColor(.white)
            .cornerRadius(10)
            .sheet(isPresented: $showWebView) {
                WebView(url: URL(string: widgetURL)!)
            }
            
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
