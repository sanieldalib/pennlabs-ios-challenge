//
//  WebViewController.swift
//  pennlabs-ios-challenge
//
//  Created by Daniel Salib on 9/22/18.
//  Copyright © 2018 dsalib. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController, WKNavigationDelegate{

    var webView: WKWebView!
    var diningURL: URL?
    var progressBar: UIProgressView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView = WKWebView()
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        
        //webview autolayout constraints
        if #available(iOS 11.0, *) {
            let guide = self.view.safeAreaLayoutGuide
            webView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            webView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            webView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            webView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            NSLayoutConstraint(item: webView,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: view, attribute: .top,
                               multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: webView,
                               attribute: .bottom,
                               relatedBy: .equal,
                               toItem: view, attribute: .bottom,
                               multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: webView,
                               attribute: .leading,
                               relatedBy: .equal, toItem: view,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0).isActive = true
            NSLayoutConstraint(item: webView, attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0).isActive = true
        }
        
        progressBar = UIProgressView(progressViewStyle: .default)
        view.addSubview(progressBar)
        
        // constraints for progressBar
        progressBar.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11.0, *) {
            let guide = self.view.safeAreaLayoutGuide
            progressBar.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            progressBar.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            progressBar.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        } else {
            NSLayoutConstraint(item: progressBar,
                               attribute: .top,
                               relatedBy: .equal,
                               toItem: view, attribute: .top,
                               multiplier: 1.0, constant: 0).isActive = true
            NSLayoutConstraint(item: progressBar,
                               attribute: .leading,
                               relatedBy: .equal, toItem: view,
                               attribute: .leading,
                               multiplier: 1.0,
                               constant: 0).isActive = true
            NSLayoutConstraint(item: progressBar, attribute: .trailing,
                               relatedBy: .equal,
                               toItem: view,
                               attribute: .trailing,
                               multiplier: 1.0,
                               constant: 0).isActive = true
        }
        
        progressBar.progress = 0.0
        webView.navigationDelegate = self
        webView.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        webView.load(URLRequest(url: diningURL!))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if (keyPath == "estimatedProgress") {
            progressBar.isHidden = webView.estimatedProgress == 1
            progressBar.setProgress(Float(webView.estimatedProgress), animated: true)
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        title = webView.title
    }


}
