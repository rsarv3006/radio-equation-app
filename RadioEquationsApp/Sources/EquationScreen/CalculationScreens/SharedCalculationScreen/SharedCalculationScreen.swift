import Combine
import RadioEquationsData
import RichTextView
import UIKit

class SharedCalculationScreen: UIViewController {
    private var subscriptions = Set<AnyCancellable>()

    var viewModel: SharedCalculationViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }

            viewModel.calculatedValue.sink { calculatedValueObj in
                switch calculatedValueObj.fieldTag {
                case .fieldOne:
                    self.fieldOneStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .fieldTwo:
                    self.fieldTwoStack.inputField.text = String(calculatedValueObj.calculatedValue)
                case .fieldThree:
                    self.fieldThreeStack.inputField.text = String(calculatedValueObj.calculatedValue)
                }
            }.store(in: &subscriptions)

            for (index, title) in viewModel.pickerOptions.enumerated() {
                calculateForSegmentedControl.insertSegment(withTitle: title, at: index, animated: false)
            }

            switch viewModel.selectedCalculateFor {
            case .fieldOne:
                calculateForSegmentedControl.selectedSegmentIndex = 0
                makeFieldOneAnswerField()
            case .fieldTwo:
                calculateForSegmentedControl.selectedSegmentIndex = 1
                makeFieldTwoAnswerField()
            case .fieldThree:
                calculateForSegmentedControl.selectedSegmentIndex = 2
                makeFieldThreeAnswerField()
            }

            equationLabel.update(input: viewModel.equationTitle)

            fieldOneStack.fieldLabel.text = "\(viewModel.pickerOptions[0]):"
            fieldTwoStack.fieldLabel.text = "\(viewModel.pickerOptions[1]):"
            fieldThreeStack.fieldLabel.text = "\(viewModel.pickerOptions[2]):"
        }
    }

    private lazy var equationLabel: RichTextView = {
        let richTextView = RichTextView(
            input: "",
            latexParser: LatexParser(),
            font: UIFont.systemFont(ofSize: 18),
            textColor: UIColor.Theme.textColor,
            frame: CGRect.zero,
            completion: nil
        )
        return richTextView
    }()

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Calculate for:"
        label.textColor = .Theme.textColor
        return label
    }()

    private lazy var calculateForSegmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: [])
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(didCalculateForSegmentedControlChange), for: .valueChanged)
        return control
    }()

    private lazy var fieldOneStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: SharedCalculationFieldTag.fieldOne.rawValue, fieldLabelText: "")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()

    private lazy var fieldTwoStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: SharedCalculationFieldTag.fieldTwo.rawValue, fieldLabelText: "")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()

    private lazy var fieldThreeStack: CalculationFieldStackView = {
        let stackView = CalculationFieldStackView(fieldTag: SharedCalculationFieldTag.fieldThree.rawValue, fieldLabelText: "")
        stackView.inputField.addTarget(self, action: #selector(didFieldUpdate), for: .editingChanged)
        return stackView
    }()

    override func viewDidLoad() {
        view.backgroundColor = .Theme.backgroundColor
        configureView()
    }

    private func configureView() {
        view.addSubview(equationLabel)

        equationLabel.centerX(inView: view, topAnchor: view.safeAreaLayoutGuide.topAnchor, paddingTop: 12)

        view.addSubview(titleLabel)
        view.addSubview(calculateForSegmentedControl)

        titleLabel.centerX(inView: view, topAnchor: equationLabel.bottomAnchor, paddingTop: 12)

        calculateForSegmentedControl.anchor(top: titleLabel.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)

        view.addSubview(fieldOneStack)

        fieldOneStack.anchor(top: calculateForSegmentedControl.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)

        view.addSubview(fieldTwoStack)

        fieldTwoStack.anchor(top: fieldOneStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)

        view.addSubview(fieldThreeStack)

        fieldThreeStack.anchor(top: fieldTwoStack.bottomAnchor, left: view.safeAreaLayoutGuide.leftAnchor, right: view.safeAreaLayoutGuide.rightAnchor, paddingTop: 12, paddingLeft: 12, paddingRight: 12)
    }
}

extension SharedCalculationScreen {
    @objc func didFieldUpdate(_ textField: UITextField) {
        guard let fieldTag = findFieldTagFromInt(fieldTag: textField.tag), let fieldText = textField.text else { return }
        viewModel?.onUpdateValue(fieldTag: fieldTag, updatedValue: fieldText)
    }

    @objc func didCalculateForSegmentedControlChange(_ segmentedControl: UISegmentedControl) {
        guard let fieldTag = findFieldTagFromInt(fieldTag: segmentedControl.selectedSegmentIndex) else { return }
        viewModel?.onUpdatedCalculateFor(selectedIndex: segmentedControl.selectedSegmentIndex)
        makeTextFieldAnswerBox(fieldTag: fieldTag)
    }

    private func findFieldTagFromInt(fieldTag: Int) -> SharedCalculationFieldTag? {
        switch fieldTag {
        case 0:
            return .fieldOne
        case 1:
            return .fieldTwo
        case 2:
            return .fieldThree
        default:
            return nil
        }
    }

    private func makeTextFieldAnswerBox(fieldTag: SharedCalculationFieldTag) {
        switch fieldTag {
        case .fieldOne:
            makeFieldOneAnswerField()
        case .fieldTwo:
            makeFieldTwoAnswerField()
        case .fieldThree:
            makeFieldThreeAnswerField()
        }
    }

    private func makeFieldOneAnswerField() {
        fieldOneStack.inputField.isAnswerField = true
        fieldTwoStack.inputField.isAnswerField = false
        fieldThreeStack.inputField.isAnswerField = false
    }

    private func makeFieldTwoAnswerField() {
        fieldOneStack.inputField.isAnswerField = false
        fieldTwoStack.inputField.isAnswerField = true
        fieldThreeStack.inputField.isAnswerField = false
    }

    private func makeFieldThreeAnswerField() {
        fieldOneStack.inputField.isAnswerField = false
        fieldTwoStack.inputField.isAnswerField = false
        fieldThreeStack.inputField.isAnswerField = true
    }
}
