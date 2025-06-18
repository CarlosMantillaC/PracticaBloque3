//
//  TableViewCell.swift
//  PracticaBloque3
//
//  Created by Gopenux on 17/06/25.
//

import UIKit

protocol Accions: AnyObject {
    
    func reproductiveButton(cell: TableViewCell)
}

class TableViewCell: UITableViewCell {
    
    weak var delegate: Accions?
    
    let label: UILabel = {
        
        let label = UILabel()
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
        
    }()
    
    private lazy var button: UIButton = {
        
        var configuration = UIButton.Configuration.plain()
        configuration.title = "boton"
        configuration.buttonSize = .medium
        
        let button = UIButton(type: .system, primaryAction: UIAction(handler: { _ in self.buttonTapped() } ))
        button.configuration = configuration
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        [label, button].forEach(contentView.addSubview)
        
        NSLayoutConstraint.activate([
            
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24),
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            
            button.trailingAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.trailingAnchor, constant: -24),
            button.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(model: ObjectCell) {
        label.text = model.title
        
    }
    
    func buttonTapped() {
        delegate?.reproductiveButton(cell: self)
    }
}
