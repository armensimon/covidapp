import UIKit

class OnboardingInitialController: UIViewController {
    
    @IBOutlet weak var ivLogoTop: UIImageView!
    @IBOutlet weak var ivLogoMiddle: UIImageView!
    @IBOutlet weak var lblAppLanguage: UILabel!

    @IBOutlet weak var hrLanguageButton: LanguageButton!
    @IBOutlet weak var armLanguageButton: LanguageButton!
    @IBOutlet weak var btnContinue: UIButton!

    static func instantiate() -> OnboardingInitialController {
        let controller = UIUtil.controllerFromStoryboard(storyboard: .onboarding, controller: .onboardingInitialController) as! OnboardingInitialController
        return controller
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLanguage()
    }
    
    private func setupLanguage() {
        if Language.getDefaultLanguage().languageType == .armenian{
            hrLanguageButton.deselect()
            armLanguageButton.setSelected()
            ivLogoTop.image = UIImage(named: "Ministvarstvo-logo-ARM")
            ivLogoMiddle.image = UIImage(named: "Logo-ARM")
        } else {
            armLanguageButton.deselect()
            hrLanguageButton.setSelected()
            ivLogoTop.image = UIImage(named: "Ministvarstvo-logo-HR")
            ivLogoMiddle.image = UIImage(named: "Logo-HR")
        }
        lblAppLanguage.text = "OnboardingInitialController.AppLanguage".localized()
        hrLanguageButton.languageLabel.text = "OnboardingInitialController.Croatian".localized()
        armLanguageButton.languageLabel.text = "OnboardingInitialController.English".localized()
        btnContinue.setTitle("OnboardingInitialController.Continue".localized(), for: .normal)
    }
    
    @IBAction func selectCroatian() {
        Language.setDefaultLanguage(language: Language.findLanguageByType(languageType: .croatian))
        setupLanguage()
    }
    
    @IBAction func selectEnglish() {
        Language.setDefaultLanguage(language: Language.findLanguageByType(languageType: .armenian))
        setupLanguage()
    }
    
    @IBAction func start(_ sender: UIButton){
        LocalStorage.shared.onboardingPassed = true
        UIUtil.presentMainController()
    }
    
    private func languageTapped() {
        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString),
            UIApplication.shared.canOpenURL(settingsUrl) else {
                return
        }
        UIApplication.shared.open(settingsUrl)
    }
    
    deinit {
        print("DEINIT OnboardingInitialController")
    }
}
