//
//  FilterViewController.swift
//  viside-ios
//
//  Created by ✨EUGENE✨ on 2022/10/02.
//

import UIKit
import Then
import SnapKit

protocol FilterViewControllerDelegate {
    func showFilter()
    func hideFilter()
}
final class FilterViewController: UIViewController, Layout {
    
    private lazy var handle = UIView().then {
        $0.backgroundColor = Color.g25
        $0.layer.cornerRadius = 16
        $0.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        $0.addShadow(color: Color.g500,
                     opacity: 0.1,
                     offset: CGSize(width: 1, height: -3),
                     radius: 10)
        let up = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        up.direction = .up
        $0.addGestureRecognizer(up)
        let down = UISwipeGestureRecognizer(target: self, action: #selector(panGesture))
        down.direction = .down
        $0.addGestureRecognizer(down)
        $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tapGesture)))
    }
    private lazy var mainView = UIView().then {
        $0.backgroundColor = .systemMint
    }
    private var state: State = .collapsed
    
    private lazy var safeArea = self.view.safeAreaLayoutGuide
    
    var delegate: FilterViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setViews()
        self.setConstraints()
        self.configure()
    }
    func setViews() {
        self.view.addSubview(handle)
        self.view.addSubview(mainView)
    }
    
    func setConstraints() {
        handle.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(safeArea)
            $0.height.equalTo(52)
        }
        mainView.snp.makeConstraints {
            $0.top.equalTo(handle.snp.bottom)
            $0.leading.trailing.bottom.equalTo(safeArea)
        }
    }
    private func configure() {
        self.view.backgroundColor = .clear
    }
    private func expand() {
        self.delegate?.showFilter()
        self.state = .expanded
    }
    private func collapse() {
        self.delegate?.hideFilter()
        self.state = .collapsed
    }
    @objc
    private func tapGesture() {
        self.state == .expanded ? self.collapse() : self.expand()
    }
    @objc
    private func panGesture(_ recognizer: UISwipeGestureRecognizer) {
        if recognizer.state == .ended {
            switch recognizer.direction {
            case .up:
                self.expand()
            case .down:
                self.collapse()
            default:
                break
            }
        }
    }
}
extension FilterViewController {
    enum State {
        case collapsed, expanded
    }
}
