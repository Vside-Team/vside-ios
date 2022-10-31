//
//  DetailViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/31.
//

import UIKit
import Then
import SnapKit
import WebKit

enum CoverState {
    case collapsed, expanded
}
final class DetailViewController: ParentViewController, Layout {
    
    private lazy var coverView = UIImageView().then {
        $0.contentMode = .scaleAspectFill
        $0.backgroundColor = Color.g200
    }
    private lazy var webView = WKWebView().then {
        $0.allowsBackForwardNavigationGestures = true
        $0.uiDelegate = self
        $0.navigationDelegate = self
        let gesture = UITapGestureRecognizer(target: self, action: #selector(viewTap))
        gesture.delegate = self
        $0.addGestureRecognizer(gesture)
        $0.addGestureRecognizer(scopeGesture)
    }
    private lazy var scopeGesture: UIPanGestureRecognizer = { [unowned self] in
        let gesture = UIPanGestureRecognizer(target: self, action: #selector(viewTap))
        gesture.delegate = self
        gesture.minimumNumberOfTouches = 1
        gesture.maximumNumberOfTouches = 2
        return gesture
    }()
    private var state: CoverState = .expanded
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    override func viewWillAppear(_ animated: Bool) {
        self.load()
    }
    func setViews() {
        self.view.addSubview(webView)
        self.view.addSubview(coverView)
    }
    func setConstraints() {
        coverView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(300)
        }
        webView.snp.makeConstraints {
            $0.top.equalTo(coverView.snp.bottom)
            $0.leading.trailing.equalTo(safeArea)
            $0.bottom.equalToSuperview()
        }
    }
    private func configure() {
        
    }
    private func load() {
        let url = URL(string: "https://www.naver.com")
        let request = URLRequest(url: url!)
        webView.load(request)
    }
    @objc
    private func viewTap() {
        print("view tap")
    }
}
extension DetailViewController: WKUIDelegate {
    
}

extension DetailViewController: WKNavigationDelegate {
    func webViewWebContentProcessDidTerminate(_ webView: WKWebView) {
        webView.reload()
    }
}
extension DetailViewController: UIGestureRecognizerDelegate {
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.webView.scrollView.contentOffset.y <= -self.webView.scrollView.contentInset.top
        print("제스쳐 \(shouldBegin) state \(self.state)")
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            print(velocity)
            switch self.state {
            case .expanded:
                self.state = .collapsed
                coverView.snp.updateConstraints {
                    $0.height.equalTo(0)
                }
                Utils.layoutAnimate(self)
                return velocity.y < 0
            case .collapsed:
                self.state = .expanded
                coverView.snp.updateConstraints {
                    $0.height.equalTo(300)
                }
                Utils.layoutAnimate(self)
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
}
