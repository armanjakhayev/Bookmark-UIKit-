import UIKit
import SnapKit

class ListOfBookmarks: UITableViewCell {
    
    // create view
    private let customView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(red: 242/255, green: 242/255, blue: 238/255, alpha: 1)
        return view
    }()
    
    // create name of bookmark
    private let nameLabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    // create icon for cell
    private let iconLabel: UIImageView = {
        let icon = UIImageView()
        icon.image = UIImage(named: "image1")
        return icon
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: Bookmark) {
        self.nameLabel.text = model.title
    }

    func setUI() {
        
        // addition and settings for name of bookmark
        self.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.leading.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(24)
        }
        
        // addition and settings for name of bookmark
        self.contentView.addSubview(iconLabel)
        iconLabel.snp.makeConstraints { make in
            make.trailing.equalToSuperview().inset(16)
            make.top.equalToSuperview().inset(24)
        }
    }
}
