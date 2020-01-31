//
//  WebViewController.swift
//  GithubUsers
//
//  Created by Min Khant Lu on 1/30/20.
//  Copyright © 2020 minkhant. All rights reserved.
//

import UIKit
import WebKit
class WebViewController: UIViewController,WKNavigationDelegate{

    var githubUrl = String()
    @IBOutlet weak var progress: UIProgressView!
    @IBOutlet var webView: WKWebView!
    
    override func viewDidLoad() {
        setUpWebView()
        setUpProgress()
        load()
    }
    
    func setUpWebView() {
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = true
    }
    
    func setUpProgress(){
        webView.addObserver(self, forKeyPath: #keyPath(WKWebView.estimatedProgress), options: .new, context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            progress.progress = Float(webView.estimatedProgress)
        }
    }
    
    func load(){
        if let url = URL(string: githubUrl){
            webView.load(URLRequest(url: url))
            webView.allowsBackForwardNavigationGestures = true
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        progress.isHidden = true
    }
}
