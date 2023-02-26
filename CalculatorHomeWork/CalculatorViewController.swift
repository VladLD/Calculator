//
//  ViewController.swift
//  CalculatorHomeWork
//
//  Created by Vlad Lapchynskyi on 01.11.2022.
//

import UIKit

final class CalculatorViewController: UIViewController {
    
    // MARK: - Constants
    
    static let error = "Error"
    static let comma = ","
    static let dot = "."
    
    // MARK: - Outlets
    
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var acButton: UIButton!
    @IBOutlet private weak var signButton: UIButton!
    @IBOutlet private weak var percentButton: UIButton!
    @IBOutlet private weak var divisionButton: UIButton!
    @IBOutlet private weak var sevenButton: UIButton!
    @IBOutlet private weak var eightButton: UIButton!
    @IBOutlet private weak var nineButton: UIButton!
    @IBOutlet private weak var multiplyButton: UIButton!
    @IBOutlet private weak var fourButton: UIButton!
    @IBOutlet private weak var fiveButton: UIButton!
    @IBOutlet private weak var sixButton: UIButton!
    @IBOutlet private weak var minusButton: UIButton!
    @IBOutlet private weak var oneButton: UIButton!
    @IBOutlet private weak var twoButton: UIButton!
    @IBOutlet private weak var threeButton: UIButton!
    @IBOutlet private weak var plusButton: UIButton!
    @IBOutlet private weak var zeroButton: UIButton!
    @IBOutlet private weak var pointButton: UIButton!
    @IBOutlet private weak var equalToButton: UIButton!
    
    // MARK: - Properties
    
    private var isError = false
    private var currentResult = "0"
    private var currentCalculation: Calculation? = nil
    
    // MARK: - Computed properties
    
    private var allButtons: [UIButton] {
        [
            acButton,
            signButton,
            percentButton,
            divisionButton,
            sevenButton,
            eightButton,
            nineButton,
            multiplyButton,
            fourButton,
            fiveButton,
            sixButton,
            minusButton,
            oneButton,
            twoButton,
            threeButton,
            plusButton,
            zeroButton,
            pointButton,
            equalToButton
        ]
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        reset()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        updateCornerRadius()
    }
    
    // MARK: - Configurations
    
    private func configure() {
        resultLabel.text = ""
        
        allButtons.forEach({
            $0.titleLabel?.numberOfLines = 1
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 0.5
        })
        
        // acButton
        acButton.addTarget(self, action: #selector(didTapAC), for: .touchUpInside)
        
        // signButton
        signButton.addTarget(self, action: #selector(didTapSign), for: .touchUpInside)
        
        // percentButton
        percentButton.addTarget(self, action: #selector(didTapPercent), for: .touchUpInside)
        
        // divisionButton
        divisionButton.addTarget(self, action: #selector(didTapDivision), for: .touchUpInside)
        
        // sevenButton
        sevenButton.addTarget(self, action: #selector(didTapSeven), for: .touchUpInside)
        
        // eightButton
        eightButton.addTarget(self, action: #selector(didTapEight), for: .touchUpInside)
        
        // nineButton
        nineButton.addTarget(self, action: #selector(didTapNine), for: .touchUpInside)
        
        // multiplyButton
        multiplyButton.addTarget(self, action: #selector(didTapMultiply), for: .touchUpInside)
        
        // fourButton
        fourButton.addTarget(self, action: #selector(didTapFour), for: .touchUpInside)
        
        // fiveButton
        fiveButton.addTarget(self, action: #selector(didTapFive), for: .touchUpInside)
        
        // sixButton
        sixButton.addTarget(self, action: #selector(didTapSix), for: .touchUpInside)
        
        // minusButton
        minusButton.addTarget(self, action: #selector(didTapMinus), for: .touchUpInside)
        
        // oneButton
        oneButton.addTarget(self, action: #selector(didTapOne), for: .touchUpInside)
        
        // twoButton
        twoButton.addTarget(self, action: #selector(didTapTwo), for: .touchUpInside)
        
        // threeButton
        threeButton.addTarget(self, action: #selector(didTapThree), for: .touchUpInside)
        
        // plusButton
        plusButton.addTarget(self, action: #selector(didTapPlus), for: .touchUpInside)
        
        // zeroButton
        zeroButton.addTarget(self, action: #selector(didTapZero), for: .touchUpInside)
        
        // pointButton
        pointButton.setTitle(CalculatorViewController.comma, for: .normal)
        pointButton.addTarget(self, action: #selector(didTapPoint), for: .touchUpInside)
        
        // equalToButton
        equalToButton.addTarget(self, action: #selector(didTapEqualTo), for: .touchUpInside)
    }
    
    private func updateCornerRadius() {
        allButtons.forEach({
            $0.layoutIfNeeded()
            $0.layer.cornerRadius = $0.frame.height / 2
        })
    }
    
    private func calculateCurrent(forceExecute: Bool = false) {
        if isError {
            resultLabel.text = CalculatorViewController.error
            return
        }
        guard (forceExecute || currentCalculation?.isExecuted == false),
              let currentCalculation,
              let lhs = double(fromString: currentResult),
              let rhs = double(fromString: currentCalculation.rhs)
        else {
            currentResult = resultLabel.text ?? "0"
            return
        }
        switch currentCalculation.operation {
        case .add:
            currentResult = string(fromDouble: lhs + rhs)
        case .subtract:
            currentResult = string(fromDouble: lhs - rhs)
        case .multiply:
            currentResult = string(fromDouble: lhs * rhs)
        case .division:
            if rhs == 0 {
                isError = true
                resultLabel.text = CalculatorViewController.error
                return
            }
            currentResult = string(fromDouble: lhs / rhs)
        }
        resultLabel.text = currentResult
    }
    
    // MARK: - Selectors (actions)
    
    @objc private func didTapZero(_ button: UIButton) {
        append(text: "0")
    }
    
    @objc private func didTapOne(_ button: UIButton) {
        append(text: "1")
    }
    
    @objc private func didTapTwo(_ button: UIButton) {
        append(text: "2")
    }
    
    @objc private func didTapThree(_ button: UIButton) {
        append(text: "3")
    }
    
    @objc private func didTapFour(_ button: UIButton) {
        append(text: "4")
    }
    
    @objc private func didTapFive(_ button: UIButton) {
        append(text: "5")
    }
    
    @objc private func didTapSix(_ button: UIButton) {
        append(text: "6")
    }
    
    @objc private func didTapSeven(_ button: UIButton) {
        append(text: "7")
    }
    
    @objc private func didTapEight(_ button: UIButton) {
        append(text: "8")
    }
    
    @objc private func didTapNine(_ button: UIButton) {
        append(text: "9")
    }
    
    @objc private func didTapAC(_ button: UIButton) {
        reset()
    }
    
    @objc private func didTapSign(_ button: UIButton) {
        guard let text = resultLabel.text, let value = double(fromString: text) else {
            return
        }
        currentResult = string(fromDouble: value * -1)
        resultLabel.text = currentResult
    }
    
    @objc private func didTapPercent(_ button: UIButton) {
        guard  resultLabel.text != CalculatorViewController.error else {
            return
        }
        
        let currentRhs = double(fromString: resultLabel.text ?? "0")!
        let rhs: Double
        
        if currentCalculation?.rhs == currentResult, let currentResult = double(fromString: currentResult) {
            rhs = currentResult * currentRhs / 100
        } else  {
            rhs = currentRhs / 100
        }
        
        resultLabel.text = ""
        currentCalculation?.resetRhs()
        
        append(text: string(fromDouble: rhs))
    }
    
    @objc private func didTapDivision(_ button: UIButton) {
        calculateCurrent()
        currentCalculation = .init(operation: .division)
    }
    
    @objc private func didTapMultiply(_ button: UIButton) {
        calculateCurrent()
        currentCalculation = .init(operation: .multiply)
    }
    
    @objc private func didTapMinus(_ button: UIButton) {
        calculateCurrent()
        currentCalculation = .init(operation: .subtract)
    }
    
    @objc private func didTapPlus(_ button: UIButton) {
        calculateCurrent()
        currentCalculation = .init(operation: .add)
    }
    
    @objc private func didTapPoint(_ button: UIButton) {
        append(text: CalculatorViewController.comma)
    }
    
    @objc private func didTapEqualTo(_ button: UIButton) {
        if currentCalculation?.rhs == "" {
            currentCalculation?.append(currentResult)
        }
        calculateCurrent(forceExecute: true)
        currentCalculation?.execute()
    }
}

// MARK: - Private methods

private extension CalculatorViewController {
    
    func reset() {
        isError = false
        currentCalculation = nil
        currentResult = "0"
        resultLabel.text = "0"
    }
    
    func string(fromDouble double: Double) -> String {
        let string = String(format: "%g", double)
        return string.replacingOccurrences(of: CalculatorViewController.dot, with: CalculatorViewController.comma)
    }
    
    func double(fromString string: String) -> Double? {
        guard !string.isEmpty else {
            return nil
        }
        
        var string = string.replacingOccurrences(of: CalculatorViewController.comma, with: CalculatorViewController.dot)
        
        let endIndex = string.index(before: string.endIndex)
        if string[endIndex].isPunctuation {
            string.insert(contentsOf: ".0", at: endIndex)
        }
        
        return Double(string)
    }
    
    func append(text: String) {
        if resultLabel.text == CalculatorViewController.error {
            resultLabel.text = ""
        }
        let text = {
            if text.first?.isPunctuation == true && (currentCalculation?.rhs == "0" || currentCalculation?.rhs == "") {
                return "0" + text
            }
            return text
        }()
        if resultLabel.text?.last?.isPunctuation == true, text.first?.isPunctuation == true {
            return
        }
        currentCalculation?.append(text)
        resultLabel.text = {
            if let rhs = currentCalculation?.rhs {
                return rhs
            }
            let result = resultLabel.text ?? ""
            return result == "0" ? text : (result + text)
        }()
    }
    
}

// MARK: - Calculation

extension CalculatorViewController {
    
    class Calculation {
        
        enum Operation {
            case add
            case subtract
            case multiply
            case division
        }
        
        let operation: Operation
        private(set) var rhs: String
        private(set) var isExecuted: Bool
        
        init(operation: Operation, rhs: String, isExecuted: Bool) {
            self.operation = operation
            self.rhs = rhs
            self.isExecuted = isExecuted
        }
        
        convenience init(operation: Operation) {
            self.init(operation: operation, rhs: "", isExecuted: false)
        }
        
        func resetRhs() {
            rhs = ""
        }
        
        func append(_ text: String) {
            rhs = rhs == "0" ? text : (rhs + text)
        }
        
        func execute() {
            isExecuted = true
        }
    }
    
}
