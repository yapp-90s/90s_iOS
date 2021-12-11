//
//  LoginViewController.swift
//  90s
//
//  Created by woongs on 2021/10/02.
//

import UIKit
import RxSwift

class LoginViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, AppleLoginPresentable {
    
    // MARK: - Views
    
    fileprivate var introCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = .zero
        flowLayout.minimumInteritemSpacing = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    fileprivate lazy var pageControl: UIPageControl = {
        let pageControl = UIPageControl()
        pageControl.numberOfPages = self.introContents.count
        return pageControl
    }()
    
    fileprivate var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 14
        stackView.axis = .vertical
        return stackView
    }()
    
    fileprivate var kakaoLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("카카오톡으로 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .Medium_Text_Bold
        button.backgroundColor = UIColor(hexString: "FEE233")
        button.addTarget(self, action: #selector(kakaoLoginDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate var googleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("구글로 로그인", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .Medium_Text_Bold
        button.backgroundColor = .white
        button.addTarget(self, action: #selector(googleLoginDidTap(_:)), for: .touchUpInside)
        return button
    }()
    
    fileprivate var appleLoginButton: UIButton = {
        let button = UIButton()
        button.setTitle("Apple로 로그인", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .Medium_Text_Bold
        button.backgroundColor = .Cool_Gray
        button.addTarget(self, action: #selector(appleLoginDidTap), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Properties
    
    let introContents: [IntroCollectionViewCell.IntroContents] = [
        .init(title: "Z에게 보내는\n나의 오래된 사진첩, 오렌지",
              subTitle: "한 장 한 장 소중히 간직했던 그때 그\n감성으로 즐기는 나만의 사진첩",
              imageName: "img_onboarding01"),
        .init(title: "마음에 드는\n앨범 커버를 골라보세요",
              subTitle: "트렌디한 스타일부터\n내 취향 저격한 스타일까지",
              imageName: "img_onboarding02"),
        .init(title: "내 사진이 빛나는 순간,\n템플릿과 스티커로 꾸미기",
              subTitle: "소중한 내 사진을 더욱 돋보이게할\n템플릿을 선택하고 스티커로 화룡점정!",
              imageName: "img_onboarding03"),
        .init(title: "필름으로 만나는\n느림의 바이브",
              subTitle: "원하는 느낌의 필름으로 인화하고\n기다리던 그때의 경험을 즐겨보세요",
              imageName: "img_onboarding04")
    ]
    
    private let viewModel: LoginViewModel
    weak var appRootDelegate: AppRootDelegate?

    // MARK: - View Life Cycle
    
    init(viewModel: LoginViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        self.viewModel.setupAppleLoginPresentaion(self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupViews()
        self.setupCollectionView()
        self.bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    private func setupViews() {
        self.view.addSubview(self.buttonsStackView)
        self.view.addSubview(self.pageControl)
        self.view.addSubview(self.introCollectionView)
        
        let loginButtons = [self.kakaoLoginButton, self.googleLoginButton, self.appleLoginButton]
        let buttonLogos = ["kakao_logo", "google_logo", "apple_logo"].map { UIImage(named: $0) }
        
        self.buttonsStackView.snp.makeConstraints { maker in
            maker.leading.trailing.equalTo(self.view.safeAreaLayoutGuide).inset(18)
            maker.bottom.equalTo(self.view.safeAreaLayoutGuide).inset(75)
        }
        
        zip(loginButtons, buttonLogos).forEach { (button, logo) in
            self.buttonsStackView.addArrangedSubview(button)
            button.layer.cornerRadius = 8
            button.snp.makeConstraints { maker in
                maker.height.equalTo(57)
            }
            
            let logoImageView = UIImageView(image: logo)
            logoImageView.contentMode = .scaleAspectFit
            button.addSubview(logoImageView)
            logoImageView.snp.makeConstraints { maker in
                maker.leading.equalToSuperview().inset(18)
                maker.centerY.equalToSuperview()
                maker.width.height.equalTo(25)
            }
        }
        
        self.pageControl.snp.makeConstraints { maker in
            maker.bottom.equalTo(self.buttonsStackView.snp.top).offset(-55)
            maker.centerX.equalToSuperview()
        }
        
        self.introCollectionView.snp.makeConstraints { maker in
            maker.top.equalTo(self.view.safeAreaLayoutGuide).offset(43)
            maker.leading.trailing.equalToSuperview()
            maker.bottom.equalTo(self.pageControl.snp.top)
        }
        
    }
    
    private func setupCollectionView() {
        self.introCollectionView.dataSource = self
        self.introCollectionView.delegate = self
        
        self.introCollectionView.register(reusable: IntroCollectionViewCell.self)
    }
    
    private func bind() {
        self.viewModel.output.signUpNeeded
            .subscribe(onNext: { [weak self] phoneAuthenticationViewModel in
                self?.pushToPhoneAuthentication(viewModel: phoneAuthenticationViewModel)
            })
            .disposed(by: self.disposeBag)
        
        self.viewModel.output.loginSucceed
            .subscribe(onNext: { [weak self] in
                self?.appRootDelegate?.switchToMain()
            })
            .disposed(by: self.disposeBag)
    }
    
    private func pushToPhoneAuthentication(viewModel: PhoneAuthenticationViewModel) {
        let phoneAuthenticationViewController = PhoneAuthenticationViewController(viewModel: viewModel)
        self.navigationController?.pushViewController(phoneAuthenticationViewController, animated: true)
    }
    
    @objc
    private func kakaoLoginDidTap(_ sender: UIButton) {
        self.viewModel.input.requestLoginStream.onNext(.kakao)
    }
    
    @objc
    private func googleLoginDidTap(_ sender: UIButton) {
        
    }
    
    @objc
    private func appleLoginDidTap(_ sender: UIButton) {
        self.viewModel.input.requestLoginStream.onNext(.apple)
    }
    
    // MARK: - UICollectionView DataSource, UICollectionView Delegate
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let page = Int(targetContentOffset.pointee.x / self.view.frame.width)
        self.pageControl.currentPage = page
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.introContents.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(IntroCollectionViewCell.self, forIndexPath: indexPath)
        cell.configure(contents: self.introContents[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}
