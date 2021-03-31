//
//  ViewController.swift
//  MyBrowser
//
//  Created by Abdulaziz Yesuf Asmare on 3/31/21.
//

import UIKit
import WebKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var urlField: UITextField!
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        urlField.delegate = self
        if let url = URL(string: "https://google.com") {
            webView.load(URLRequest(url: url))
        }
    }

    func sendToUrl() {
        if var text = urlField.text, !text.isEmpty
        {
            print(text)
            text = text.lowercased()
            if(text.hasPrefix("https://") || text.hasPrefix("http://")) {
                if let url = URL(string: text) {
                    webView.load(URLRequest(url: url))
                }
            } else if(text.hasSuffix(".com") || text.hasSuffix(".org") || text.hasSuffix(".co") || text.hasSuffix(".et") || text.hasSuffix(".tech") || text.hasSuffix(".me")) {
                text = "https://" + text
                if let url = URL(string: text) {
                    webView.load(URLRequest(url: url))
                }
            } else {
                if let url = URL(string: "https://google.com/search?q=\(text)") {
                    webView.load(URLRequest(url: url))
                }
            }
        } else {
            if let url = URL(string: "https://google.com") {
                webView.load(URLRequest(url: url))
            }
            
        }
    }

    @IBAction func goButtonClicked(_ sender: Any) {
        sendToUrl()
        urlField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendToUrl()
        urlField.resignFirstResponder()
        textField.text = ""
        return false
    }
    
    @IBAction func backButtonClicked(_ sender: Any) {
        webView.goBack()
    }
    
    @IBAction func nextButtonClicked(_ sender: Any) {
        webView.goForward()
    }
}

