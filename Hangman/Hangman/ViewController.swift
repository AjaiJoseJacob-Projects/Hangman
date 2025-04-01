//
//  ViewController.swift
//  Hangman
//
//  Created by Vinuz on 2023-10-26.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var hangManImage: UIImageView!
    
    @IBOutlet weak var lossLb1: UILabel!
    
    @IBOutlet weak var score: UILabel!
    
    @IBOutlet weak var answerlabel: UILabel!
    
    @IBOutlet var keyButton: [UIButton]!

    var counter=0
    var due = 7
    
    var score2=0
    var str = ""
    var answer = ""
    var count = 0
    var i = 0
    var array = [String]()
    var sign : Bool = false
    
    var name : String = ""
    var loss = 0
    var savedScore : Int?
    var savedName : String?
    var countArray=7
    //array of words
    var all = ["ability","backing","cabinet","absence","balance","calibre","academy","banking","calling","account","barrier","capable","accused","battery","capital","achieve","bearing","captain","acquire","beating","caption","address","because","capture","advance","bedroom","careful","adverse","believe","carrier","advised","beneath","caution","adviser","benefit","ceiling","against","besides","central","airline","between","centric","airport","billion","century","alcohol","binding","certain","alleged","brother","chamber","already","brought","channel","analyst","burning","chapter","ancient","dealing","charity",
    "Another" ]
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        all.shuffle()
        answer = shuffleElements(all: all)
        
        array=["_","_","_","_","_","_","_"]
        i = 0
       
        while (countArray != 0){
            str += "_" + " " + " "
            countArray -= 1
            answerlabel.text=str
        }
        str = ""
    }
    //IBAction that connects all the keyboard buttons
    @IBAction func keyBindingFunction(_ sender: Any) {
        let letterClicked:String? = (sender as AnyObject).titleLabel?.text;
        if let optionalLetter = letterClicked {
            letterControl( sender as! UIButton, optionalLetter.lowercased())
            
        }
    }
    //function when the user guesses the word correctly
    func successFunc(){
        hangManImage.image=UIImage(named: "pic9")
        score2+=1
        score.text="Wins:\(score2)"
        let answerAlert = UIAlertController.init(title: "Woohoo!", message: "You saved me!,Would you like to play again?", preferredStyle: UIAlertController.Style.alert)
        let restartAction = UIAlertAction.init(title: "Yes", style: .destructive, handler: restartFunc)
        let cancelAction = UIAlertAction.init(title: "No", style: UIAlertAction.Style.cancel, handler: nil)
        answerAlert.addAction(restartAction)
        answerAlert.addAction(cancelAction)
        self.present(answerAlert, animated: true, completion: nil)
        disableButton()
        
    }
    //function when the user guesses the word wrongly
    func failFunc(){
        due -= 1
        if due >= 0{
            hangManImage.image=UIImage(named: "pic\(8-due)")
        }
        if due==0
        {
            loss+=1
            lossLb1.text="Loss:\(loss)"
            let answerAlert = UIAlertController.init(title: "Uh oh", message: "The correct word was \(answer)\n Would you like to try again", preferredStyle: UIAlertController.Style.alert)
            let restartAction = UIAlertAction.init(title: "Yes", style: .destructive, handler: restartFunc)
            let cancelAction = UIAlertAction.init(title: "No", style: UIAlertAction.Style.cancel, handler:nil)
            answerAlert.addAction(restartAction)
            answerAlert.addAction(cancelAction)
            self.present(answerAlert, animated: true, completion: nil)
            disableButton()
        }
    }
    //function to reset the game after win or loss
    func restartFunc(_ sender: Any) {
        // LOAD SCORE
            
        score.text="Wins:\(score2)"
        lossLb1.text="Loss:\(loss)"
        due = 7
        setdata()
        enableButton()
        hangManImage.image=UIImage(named: "pic1")
        
        countArray = 7
        while (countArray != 0){
            str += "_" + " " + " "
            countArray -= 1
        }
        
        answerlabel.text = str
        str = ""
       
    }
    //function to set to default
    func setdata(){
        str = ""
        answer = ""
        count = 0
        i = 0
        array = [String]()
        sign = false
        
        all.shuffle()
        answer = shuffleElements(all: all)
        i = answer.count
        while(i != 0){
            array.append("_")
            i -= 1
        }
    }

    //get random word from array
    func shuffleElements(all: [String]) -> String{
        let index=Int.random(in:0..<61 )
        answer=all[index]
       
    
        return answer
    }
    //function for button control
    func letterControl(_ btn: UIButton,_ char: String)
    {
        
        let word = [Character](self.answer)
        count = word.count
        i = 0
        while (count != 0){
            if (String(word[i]) == char){
                array[i] = char
                
                sign = true
                btn.backgroundColor=UIColor.green
                
            }
            else if (array[i] == " "){
                array[i] = "  "
            }
            i += 1
            count -= 1
        }
        for a in array{
            str += a + " " + " "
        }
        
        i = 0
        count = word.count
        if (sign == false){
            btn.backgroundColor=UIColor.red
            failFunc()
            
        }
        else{
            sign = false
        }
        answerlabel.text = str
        str = ""
        
        btn.isEnabled = false
        let convert = array.joined(separator: "")
        if (convert == answer){
            successFunc()
        }
    //Enable all buttons
    }
    func enableButton(){
        for button in keyButton{
            button.isEnabled = true
            button.backgroundColor=UIColor.gray
        }
    }
    //disable all button
    func disableButton(){
        for button in keyButton{
            button.isEnabled = false
        }
    }
    //reset
    func resetButton()
    {
        enableButton()
        for button in keyButton{
            button.backgroundColor=UIColor.blue
        }

    }
    
    
    
}
    
    
    

