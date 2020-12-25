//
//  ViewController.swift
//  EnglishDictionary
//
//

import UIKit
import AVFoundation



class ViewController: UIViewController, AVAudioPlayerDelegate {
    


    override func viewDidLoad() {
        super.viewDidLoad()
        Submit.frame = CGRect(x: 30, y: textField.frame.maxY + 30, width: 350, height: 60)
        label.frame = CGRect(x: 160 , y: 0, width: 250, height: 600)
        label2.frame = CGRect(x: 30, y: 270, width: view.frame.size.width - 100, height: 300)
        label3.frame = CGRect(x: 30, y: label2.frame.midY - 20 , width: view.frame.size.width - 50, height: 300)
        label4.frame = CGRect(x: 30, y: label3.frame.midY - 100, width: view.frame.size.width - 50, height: 400)
        label5.frame = CGRect(x: 30, y: label4.frame.midY - 110, width:  view.frame.size.width - 50, height: 400)
        label6.frame = CGRect(x: 30, y: label5.frame.midY - 120, width:  view.frame.size.width - 50, height: 400)
        label7.frame = CGRect(x: 30, y: label6.frame.midY - 120, width:  view.frame.size.width - 50, height: 400)

        view.addSubview(textField)
        view.addSubview(Submit)
        view.addSubview(label)
        view.addSubview(label2)
        view.addSubview(label3)
        view.addSubview(label4)
        view.addSubview(label5)
        view.addSubview(label6)
        view.addSubview(label7)
        view.addSubview(Sound)

        
    }
    
    private var textField: UITextField = {
        var field = UITextField()
        field.frame = CGRect(x: 30, y: 100, width: 350, height: 60)
        field.layer.cornerRadius = 12
        if #available(iOS 13.0, *) {
            field.backgroundColor = .secondarySystemBackground
        } else {
            field.backgroundColor = .lightText
        }
        field.returnKeyType = .continue
        field.placeholder = "Your Word Here"
        field.autocapitalizationType = .sentences
        field.autocorrectionType = .yes
        field.returnKeyType = .continue
        field.layer.borderWidth = 1
        field.layer.borderColor = UIColor.lightGray.cgColor
        field.leftViewMode = .always
        field.setLeftPaddingPoints(10)
        field.setRightPaddingPoints(10)
        return field
    }()
   
    private var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont(name: "ArialMT", size: 30)
        label.numberOfLines = 0
        return label
    }()
    
    private var label2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.cornerRadius = 12
        label.font = UIFont(name: "ArialMT", size: 14.5)
        label.numberOfLines = 0


        return label
    }()
    
    private var label3: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.cornerRadius = 12
        label.font = UIFont(name: "ArialMT", size: 14.5)
        label.numberOfLines = 0


        return label
    }()
    private var label4: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.cornerRadius = 12
        label.font = UIFont(name: "ArialMT", size: 14.5)
        label.numberOfLines = 0

        return label
    }()
    
    private var label5: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.cornerRadius = 12
        label.font = UIFont(name: "ArialMT", size: 14.5)
        label.numberOfLines = 0

        return label
    }()

    private var label6: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.cornerRadius = 12
        label.font = UIFont(name: "ArialMT", size: 14.5)
        label.numberOfLines = 0

        return label
    }()
    private var label7: UILabel = {
        let label = UILabel()
        label.text = ""
        label.layer.cornerRadius = 12
        label.font = UIFont(name: "ArialMT", size: 14.5)
        label.numberOfLines = 0

        return label
    }()
    
    private var Submit: UIButton = {
        let button = UIButton()
        button.setTitle("Submit", for: .normal)
        button.backgroundColor = .link
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(updateData), for: .touchUpInside)
        return button
    }()
    
    private var Sound: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.setBackgroundImage(UIImage(named: "Play"), for: .normal)
        button.layer.cornerRadius = 50
        button.frame = CGRect(x: 270, y: 280, width: 40, height: 40)
        button.isHidden = true
        button.addTarget(self, action: #selector(getSound), for: .touchUpInside)
        return button
    }()
    
    
  
    
    @objc func updateData() {
        Sound.isHidden = false
        textField.resignFirstResponder()
        let url = URL(string: "https://api.dictionaryapi.dev/api/v2/entries/en/\(textField.text ?? "Never")")!
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                self.label.text = self.textField.text
            }
        
                 do{
                     
                     
                     let jsonResponse = try JSONSerialization.jsonObject(with: data!, options: [])
                    
                    guard let newValue = jsonResponse as? Array<Any> else {
                          print("invalid format")
                          return
                     }
                    print(url)
                    
                    let audiolayer1 = newValue[0] as? [String:Any]
                    let audiolayer2 = audiolayer1?["phonetics"] as? Array<Any>
                    let audiolayer3 = audiolayer2?[0] as? [String:Any]
                    var audios = audiolayer3?["audio"] ?? ""
                    print(audios)
                    
                    
                    let meaningslayer1 = newValue[0] as? [String:Any]
                    let meaningslayer2 = meaningslayer1?["meanings"] as? Array<Any>
                    let meaningslayer3 = meaningslayer2?[0] as? [String:Any]
                
                    let partOfSpeech = meaningslayer3?["partOfSpeech"]
                   
                    let definition = meaningslayer3?["definitions"] as? Array<Any>
                    let definitionInside = definition?[0] as?  [String:Any]
                    let def = definitionInside?["definition"]
                    let example = definitionInside?["example"]
                    DispatchQueue.main.async {
                        self.label2.text = "(\(partOfSpeech ?? "")), \(def ?? "")\nExample: \(example ?? "")"

                    }
                    

                    
                    
                    if let synonyms = definitionInside?["synonyms"] as? NSArray {
                        DispatchQueue.main.async {
                            let synonyms2 = synonyms.componentsJoined(by: ", ")

                            self.label2.text = "(\(partOfSpeech ?? "")), \(def ?? "")\nExample: \(example ?? "")\nSynonyms: \(synonyms2) "
                        }
                       

                    }
                   
                    

                    if (meaningslayer2?[exist: 1]) != nil {

                        if let layer = meaningslayer2?[exist: 1] as? [String:Any] {
                            let partOfSpeech = layer["partOfSpeech"]
                        let definition = layer["definitions"] as? Array<Any>
                        let definitionInside = definition?[0] as?  [String:Any]
                            let def = definitionInside?["definition"]
                        let example = definitionInside?["example"]
                            DispatchQueue.main.async {
                                self.label3.text = "(\(partOfSpeech ?? "")), \(def ?? "")\nExample:\(example ?? "")"
                            }
                    
                            if let synonyms = definitionInside?["synonyms"] as? NSArray   {
                            DispatchQueue.main.async {
                                let synonyms2 = synonyms.componentsJoined(by: ", ")
                                self.label3.text = "(\(partOfSpeech ?? "")), \(def ?? "")\nExample:\(example ?? "")\nSynonyms:\(synonyms2)\n"
                            }
                            
                        }
                        }
                    }



                    if (meaningslayer2?[exist: 2]) != nil {

                        if let layer = meaningslayer2?[exist: 2] as? [String:Any] {
                        let partOfSpeech = layer["partOfSpeech"]
                        let definition = layer["definitions"] as? Array<Any>
                        let definitionInside = definition?[0] as?  [String:Any]
                        let def = definitionInside?["definition"]
                        let example = definitionInside?["example"]
                            DispatchQueue.main.async {
                                self.label4.text = "(\(partOfSpeech ?? "")),  \(def ?? "")\nExample: \(example ?? "")"

                            }
                    
                        if let synonyms = definitionInside?["synonyms"] as? NSArray {
                            DispatchQueue.main.async {
                                let synonyms2 = synonyms.componentsJoined(by: ", ")
                                self.label4.text = "(\(partOfSpeech ?? ""), \(def ?? "")\nExample: \(example ?? "")\nSynonyms: \(synonyms2)\n"
                            }
                        }
                        }
                    }


               

//MARK: Meanings2

                    
                    if newValue[exist: 1] != nil  {
                        let meaningslayer12 = newValue[1] as? [String:Any]
                        let meaningslayer22 = meaningslayer12?["meanings"] as? Array<Any>
                    

                    if (meaningslayer22?[exist: 0] != nil){
                        let meaningslayer12 = newValue[1] as? [String:Any]
                        let meaningslayer22 = meaningslayer12?["meanings"] as? Array<Any>
                        let layer = meaningslayer22?[0] as? [String:Any]
                        _ = layer?["partOfSpeech"]
                        let definition = layer?["definitions"] as? Array<Any>
                        let definitionInside = definition?[0] as?  [String:Any]
                        let def = definitionInside?["definition"]
                        let example = definitionInside?["example"]
                        let idk = meaningslayer22?[0] as? [String:Any]
                        DispatchQueue.main.async {
                            self.label5.text = "\(idk?["partOfSpeech"] ?? ""), \(def ?? "")\nExample:\(example ?? "")"
                        }
                        if let synonyms = definitionInside?["synonyms"] as? NSArray {
                            DispatchQueue.main.async {
                                let synonyms2 = synonyms.componentsJoined(by: ", ")
                                self.label5.text = "\(idk?["partOfSpeech"] ?? ""), \(def ?? "")\nExample:\(example ?? "")\nSynonyms:\(synonyms2)"
                            }
                            }
                    
                        }





                    if (meaningslayer2?[exist: 1]) != nil {

                        if let layer = meaningslayer22?[exist: 1] as? [String:Any] {
                            let partOfSpeech = layer["partOfSpeech"]
                            let definition = layer["definitions"] as? Array<Any>
                        let definitionInside = definition?[0] as?  [String:Any]
                        let def = definitionInside?["definition"]
                        let example = definitionInside?["example"]
                            DispatchQueue.main.async {
                                self.label6.text = "(\(partOfSpeech ?? "")), \(def ?? "")\nExample:\(example ?? "")"
                            }
                    
                        if let synonyms = definitionInside?["synonyms"] as? NSArray {
                            DispatchQueue.main.async {
                                let synonyms2 = synonyms.componentsJoined(by: ", ")
                                self.label6.text = "(\(partOfSpeech ?? "")), \(def ?? "")\nExample:\(example ?? "")\nSynonyms:\(synonyms2)"
                            }
                        }
                    }
                    }



                    if (meaningslayer2?[exist: 2]) != nil {

                        if let layer = meaningslayer22?[exist: 2] as? [String:Any] {
                            let partOfSpeech = layer["partOfSpeech"]
                            let definition = layer["definitions"] as? Array<Any>
                        let definitionInside = definition?[0] as?  [String:Any]
                        let def = definitionInside?["definition"]
                        let example = definitionInside?["example"]
                            DispatchQueue.main.async {
                                self.label7.text = "\(partOfSpeech ?? ""), \(def ?? "")\nExample:\(example ?? "")"
                            }
                    
                        if let synonyms = definitionInside?["synonyms"] as? NSArray{
                            DispatchQueue.main.async {
                                let synonyms2 = synonyms.componentsJoined(by: ", ")
                                self.label7.text = "\(partOfSpeech ?? ""), \(def ?? "")\nExample:\(example ?? "")\nSynonyms:\(synonyms2 )\n"
                            }
                        }
                    }
                    }



                 



         




                   
                    }
                    
                  } catch let parsingError {
                     print("Error", parsingError)
                }
             }
             task.resume()
            }
    var player: AVPlayer!
   @objc func getSound() {
    
    DispatchQueue.main.asyncAfter(deadline: .now()) {
        self.Sound.setBackgroundImage(UIImage(named: "Pause"), for: .normal)
    }
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        self.Sound.setBackgroundImage(UIImage(named: "Play"), for: .normal)
    }
    let url = URL(string: "https://lex-audio.useremarkable.com/mp3/\(textField.text?.lowercased() ?? "goodbye")_us_1.mp3")!
    print(url)
    
    do {
                
               try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.ambient)
               try AVAudioSession.sharedInstance().setActive(true)
                player = AVPlayer(url: url as URL)
                player.play()
            } catch {
                print("audio file error")
            }
}
    
}

extension Collection where Indices.Iterator.Element == Index {
    subscript (exist index: Index) -> Iterator.Element? {
        return indices.contains(index) ? self[index] : nil
    }
}

extension UITextField {
    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
    func setRightPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.rightView = paddingView
        self.rightViewMode = .always
    }
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == textField {
            updateData()
        }
    
        return true
    }}
