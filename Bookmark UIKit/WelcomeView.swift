import UIKit
import SnapKit

class WelcomeView: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inizialize()
    }
    
    private func inizialize(){
        lazy var backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = UIImage(named: "BG")
        backgroundImage.contentMode = .scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        backgroundImage.snp.makeConstraints { make in
            make.height.equalTo(614)
            make.bottom.equalToSuperview().inset(230)
        }
        
        lazy var label = UILabel()
        label.text = "Save all interesting links in one app"
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: 36, weight: .bold)
        label.textColor = .white
        view.addSubview(label)
        label.backgroundColor = .black
        label.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(620)
        }
        
        let button = UIButton(type: .system)
        button.backgroundColor = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1)
        button.setTitle("Let’s start collecting", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.contentEdgeInsets = UIEdgeInsets(top: 18, left: 24, bottom: 18, right: 24)
        button.layer.cornerRadius = 16
        view.addSubview(button)
        
        button.addTarget(self, action: #selector(pressButton), for: .touchUpInside)
        
        button.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(16)
            make.height.equalTo(58)
            make.bottom.equalToSuperview().inset(50)
        }
        
    }
    
    @objc func pressButton () {
        let vc = MainView()
        Storage.showOnboarding = false
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.present(vc, animated: true, completion: nil)
    }

}

