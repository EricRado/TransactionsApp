//
//  DebitView.swift
//  TransactionsApp
//
//  Created by Eric Rado on 8/8/21.
//

import UIKit

final class DebitView: UIView {

    private let amountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        return label
    }()
    
    private let noteTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.layer.borderWidth = 1.0
        textView.layer.borderColor = UIColor.lightGray.cgColor
        textView.layer.cornerRadius = 3
        return textView
    }()
    
    private lazy var saveButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .blue
        button.setTitle("SAVE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 4
        return button
    }()
    
    var viewModel: DebitViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            
            amountLabel.attributedText = viewModel.amount
            dateLabel.attributedText = viewModel.date
            noteTextView.text = viewModel.note
        }
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        let noteLabel = UILabel()
        noteLabel.translatesAutoresizingMaskIntoConstraints = false
        noteLabel.textAlignment = .left
        noteLabel.text = "Note :"
        noteLabel.font = UIFont.preferredFont(forTextStyle: .body)
        
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .center
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -24)
        ])
        
        stackView.addArrangedSubview(amountLabel)
        stackView.addArrangedSubview(dateLabel)
        stackView.addArrangedSubview(noteLabel)
        stackView.addArrangedSubview(noteTextView)
        stackView.addArrangedSubview(saveButton)
        
        for view in [amountLabel, dateLabel, noteLabel, noteTextView] {
            view.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        }
        
        NSLayoutConstraint.activate([
            saveButton.heightAnchor.constraint(equalToConstant: 50),
            saveButton.widthAnchor.constraint(equalTo: stackView.widthAnchor, multiplier: 0.80)
        ])
        
        stackView.setCustomSpacing(16, after: amountLabel)
        stackView.setCustomSpacing(16, after: dateLabel)
        stackView.setCustomSpacing(16, after: noteLabel)
        stackView.setCustomSpacing(24, after: noteTextView)
    }

}
