//
//  ViewController.swift
//  PROJECT1
//
//  Name: Guess the Car Price
//  Functionality: There is an array of cars and its data from carData.swift,
//                 consisting of information on the cars' NAME, MSRP from its
//                 release date, the model YEAR, and the MAKE and MODEL. The
//                 images of these cars are stored in Assets.xcassets. The
//                 user is prompted with an image, randomly selected, and they
//                 are able to guess the MSRP of that car in a textbox below
//                 the image. A score out of 1,000 points will be given to the
//                 user depending on how close they are to the guess. After 9
//                 rounds, a total score out of 9,000 points are given, and
//                 the user will be given a choice to play again.
//
//  This game is heavily inspired from The Auction Game on neal.fun by neal.
//  Link to The Auction Game by neal: https://neal.fun/auction-game/
//
//
//  Created by Kenny Tran
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Outlets
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var actualPrice: UILabel!
    @IBOutlet weak var carYear: UILabel!
    @IBOutlet weak var carMakeModel: UILabel!
    @IBOutlet weak var guessPriceText: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var scoreLabel: UILabel!
    @IBOutlet weak var playAgainButton: UIButton!
    @IBOutlet weak var roundLabel: UILabel!
    @IBOutlet weak var totalScoreLabel: UILabel!
    
    
    // MARK: - Properties
    var roundArray: [Int] = []    // This makes an array for how many rounds there will be.
    var currentCarIndex = 0       // This keeps track of what car indice the round is displaying.
    var currentRoundIndex = 1     // This keeps track of which round indice is being displayed.
    var totalScoreValue: Double = 0
    let totalRound: Int = 9       // Sets how many rounds there will be per game.
    
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        roundArray = Array(0..<carData.count)   // roundArray (keeps track of how many rounds) will take data from carData array.
        let randomIndex = Int(arc4random_uniform(UInt32(roundArray.count)))   // Randomizer for carData. (Round amount per game is not set yet)
        currentCarIndex = roundArray[randomIndex]
        roundArray.remove(at: randomIndex)  // Eliminates duplicates per game.
        
        displayCarInfo()
        setupUIElements()
    }
    
    
    // MARK: - UI Design
    private func setupUIElements() {
        /// setupUIElements will be the design for texts and interface elements. Buttons will have a corner radius, and text will be determined a certain
        /// font and weight. This function focuses on the usability of the application.
        nextButton.isHidden = true
        playAgainButton.isHidden = true
        
        guessPriceText.keyboardType = .phonePad    // Allows only numbers to be entered on iPhones.
        guessPriceText.delegate = self
        guessPriceText.layer.cornerRadius = 12
        guessPriceText.layer.borderWidth = 0.75
        
        enterButton.layer.cornerRadius = 12
        nextButton.layer.cornerRadius = 17
        playAgainButton.layer.cornerRadius = 25
        
        titleLabel.font = UIFont.systemFont(ofSize: 32, weight: .bold)
        carMakeModel.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        carYear.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        actualPrice.font = UIFont.systemFont(ofSize: actualPrice.font.pointSize, weight: .semibold)
        scoreLabel.font = UIFont.systemFont(ofSize: scoreLabel.font.pointSize, weight: .semibold)
        totalScoreLabel.font = UIFont.systemFont(ofSize: 24)
        
        self.hideKeyboardWhenTappedAround()
    }
    
    
    // MARK: - Main Display
    func displayCarInfo() {
        /// displayCarInfo will show what the user sees. This function will prompt the image, the textbox, and the enter button. This is the guessing
        /// phase for the user, also keeping track of the current car it's showing at the moment.
        let car = carData[currentCarIndex]
        
        imageView.image = UIImage(named: car.image)  // Image is taken from carData array.
        carYear.text = " "
        carMakeModel.text = " "
        actualPrice.text = ""
        guessPriceText.text = ""
        scoreLabel.text = " "
        
        nextButton.isHidden = true
        totalScoreLabel.isHidden = true
        roundLabel.isHidden = false
        
        guessPriceText.isUserInteractionEnabled = true  // Allows the user to enter in a number for the textbox.
        
        roundCount()    // Displays current round.
    }
    
    func roundCount() {
        /// roundCount will display how the current round out of the total rounds.
        roundLabel.text = "\(currentRoundIndex) / \(totalRound)"
    }
    
    func totalScore() {
        /// totalScore will display at the end of all rounds the sum scores from all rounds the user has played.
        totalScoreLabel.text = "\(Int(totalScoreValue)) Points"
    }
    
    
    // MARK: - Button Actions
    @IBAction func guessSubmitted(_ sender: Any) {
        /// guessSubmitted is a large function that performs upon user interaction. It is the enter button, available for the user to submit
        /// their guess after entering it in the textbox. This function will take the MSRP from the carData array and calculate the user's
        /// guess with the MSRP. The result of the calculation will be the score, and the score will be added to the total score. The 'next'
        /// button will display, allowing the user to move on from the completed round.
        guard let guessedPrice = Double(guessPriceText.text ?? "0") else { return }
        let car = carData[currentCarIndex]
        let actualCarPrice = car.price   // Sets the MSRP from carData to a variable.
        
        var score: Double
        
        // Score is calculated if the guess is overestimated and underestimated.
        // If the score is exact, 1000 points will be given.
        if guessedPrice < actualCarPrice {
            score = floor((guessedPrice / actualCarPrice) * 1000)   // Score will not include decimals, hence 'floor'.
        } else if actualCarPrice < guessedPrice {
            score = floor((actualCarPrice / guessedPrice) * 1000)
        } else if actualCarPrice == guessedPrice {
            score = 1000
        } else {
            score = 0
        }
        
        let scorePerRound = score   // scorePerRound will be displayed.
        totalScoreValue += scorePerRound    // Score is added to the global total score variable, used after the game is finished.
        
        scoreLabel.text = String(format: "%.0f Points", scorePerRound)
        // Setting the variable 'formatter' to be in currency notation.
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale.current
        // Formatting so after submission, the text field will be in currency notation.
        if let formattedActualPrice = formatter.string(from: NSNumber(value: actualCarPrice)) {
            actualPrice.text = formattedActualPrice
        }
        // Formatting so after submission, the MSRP will be in currency notation.
        if let formattedGuessedPrice = formatter.string(from: NSNumber(value: guessedPrice)) {
            guessPriceText.text = formattedGuessedPrice
        }
        
        carYear.text = "\(car.year)"            // Displays car year.
        carMakeModel.text = "\(car.makeModel)"  // Displays car make and model.
        
        nextButton.isHidden = false   // The "next" button will appear.
        view.endEditing(true)
        guessPriceText.isUserInteractionEnabled = false   // Prevents user from editing the textbox again.
    }
    
    @IBAction func nextCar(_ sender: Any) {
        /// nextCar is a function based on user interaction. This function will be the "NEXT" button after a round has been completed.
        moveNextCar()
    }
    
    @IBAction func playAgainButton(_ sender: Any) {
        /// playAgainButton is a function based on user interaction. This function will be the "PLAY AGAIN" button after the game has
        /// been completed.
        playAgain()
    }
    
    
    // MARK: - Functions: Post Input (Next Round)
    func moveNextCar() {
        /// moveNextCar will setup the next round or end the game if there has been enough rounds. If moveNextCar sets up the next
        /// round, it will take a random index from the carData array. If the rounds reach the total rounds set, it will prompt the "PLAY
        /// AGAIN" button and the total score recorded from all rounds.
        if currentRoundIndex >= totalRound {    // Conditions if the current round number is equal to however many rounds are set.
            totalScore()
            playAgainButton.isHidden = false
            totalScoreLabel.isHidden = false
            setElementsHiddenStatus(true)   // Hide everything.
            roundLabel.isHidden = true
            return
        } else {
            let randomIndex = Int(arc4random_uniform(UInt32(roundArray.count)))   // Randomizer for next car.
            currentCarIndex = roundArray[randomIndex]   // Next car will be recorded.
            roundArray.remove(at: randomIndex)   // Eliminates duplicate, so this car will never show up in this game again.
            currentRoundIndex += 1   // Add 1 to the round number. (If previous round was round 1, upcoming round will be round 2)
            displayCarInfo()
        }
    }

    // MARK: - Functions: Post Input (End Game)
    func playAgain() {
        /// playAgain will restart the entire game. All parameters changed or recorded will be set to 0 or their default value.
        currentRoundIndex = 0   // Resets current round number to 0.
        roundArray = Array(0..<carData.count)   // Takes indices from carData array again.
        
        playAgainButton.isHidden = true
        setElementsHiddenStatus(false)
        totalScoreReset()   // Resets the total score amount to 0.
        moveNextCar()   // Sets up next round.
    }
    
    func totalScoreReset() {
        /// totalScoreReset will reset the global variable, 'totalScoreValue', to 0. This variable sums up the score from each round.
        totalScoreValue = 0
    }
    
    
    // MARK: - Function: Hide or Show Elements
    func setElementsHiddenStatus(_ isHidden: Bool) {
        /// setElementsHiddenStatus will either hide elements from displayCarInfo and moveNextCar. A boolean variable is presented to
        /// do one of the following.
        imageView.isHidden = isHidden
        actualPrice.isHidden = isHidden
        carYear.isHidden = isHidden
        carMakeModel.isHidden = isHidden
        guessPriceText.isHidden = isHidden
        nextButton.isHidden = isHidden
        enterButton.isHidden = isHidden
        scoreLabel.isHidden = isHidden
    }
    
    
    // MARK: - Allows "Return" Key
    @objc func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        /// textFieldShouldReturn will allow the user to use the "return" key to submit their guess. This is primarily for users that are testing the
        /// application, allowing easier usability.
        if textField == guessPriceText {
            guessSubmitted(textField)
            return false
        }
        return true
    }
}

// MARK: - Keyboard Dismiss
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        /// hideKeyboardWhenTappedAround will hide the keyboard when a tap outside the keyboard area is recognized. This allows for a user
        /// friendly environment, make the application more usable. 
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
