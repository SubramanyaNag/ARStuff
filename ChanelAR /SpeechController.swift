//
//  SpeechController.swift
//  ARKitExample
//
//  Created by Subramanya on 19/08/17.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit
import Speech

public class SpeechController: UIViewController, SFSpeechRecognizerDelegate, AVSpeechSynthesizerDelegate {
    // MARK: Properties
    
    private let speechRecognizer = SFSpeechRecognizer(locale: Locale(identifier: "en-US"))!
    
    private var recognitionRequest: SFSpeechAudioBufferRecognitionRequest?
    
    private var recognitionTask: SFSpeechRecognitionTask?
    
    private let audioEngine = AVAudioEngine()
    
    @IBOutlet var textView : UITextView!
    
    @IBOutlet var recordButton : UIButton!
    
    var speechSynthesizer = AVSpeechSynthesizer()
    
    var greetings = ["hi", "hello", "howdy", "what's up", "hey"]
    var imGood = ["i'm good", "i'm Fine", "i'm great. Thanks", "i'm Awesome. how are you?"]
    var howAreYou = "how are you"
    var salutations = ["by", "see you later", "bye for now", "bye"]
    //var sukhi = ["suki", "do you know suki", "sukhy"]
    //var sukhiAnswer = "I hate sukhi. I just hate him"
    var hindiPhrase = "जान है तो जहान है"
    var speakHindi = ["hindi", "speak hindi"]
    var whatTime = ["what is the time now", "tell me the time", "what time is it now"]
    var chanel = ["speak french"]
    var chanelAnswer = "La mode n’est pas quelque chose qui existe en robes seulement. La mode est dans le ciel, dans la rue. La mode peut avoir quelque chose avec les idées, la façon dont nous vivons, ce qui se passe. "
    var ssQ = ["what do you think about our team"]
    var ssA = "Oh! the sea stormers will obviously win this competition! they're so great and awesome!"
    var bagInfo = ["tell me about this bag", "tell me details about this bag", "tell the details about this product"]
    var bagInfoAnswer = "This is CHANEL 2.55 bag.\nFrom the 1920s, Gabrielle Chanel offers handbags to accompany her clients’ outfits. But it is in 1955 that she imagines the “2.55,” a quilted flap bag adorned with an adjustable chain that remains her most famous handbag. This handbag, an instant and enduring success, is henceforth considered to be an icon of the House of CHANEL. From 1983, the 2.55 and the “Timeless Classic,” similar to its original version, are regularly revisited by Karl Lagerfeld."
    var bagInfoFrench = ["tell me about this bag in french", "tell me the details about this bag in french", "tell me the details about this product in french"]
    var bagInfoAnswerFrench = "Dès les années 1920, Gabrielle Chanel propose des sacs afin d’accompagner les tenues de ses clientes. Mais c’est en 1955 qu’elle imagine, le « 2.55 », un sac matelassé orné d’une chaîne ajustable qui demeure son sac le plus célèbre. Ce sac, au succès immédiat et durable, est désormais considéré comme une icône de la Maison CHANEL. Depuis 1983, le 2.55 et le « Timeless Classic », proche de sa version originale, sont régulièrement revisités par Karl Lagerfeld."
    
    
    // MARK: UIViewController
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.black
        self.view.alpha = 0.8
        
        self.speechSynthesizer.delegate = self
        
        // Disable the record buttons until authorization has been granted.
        recordButton.isEnabled = false
    }
    
    override public func viewDidAppear(_ animated: Bool) {
        speechRecognizer.delegate = self
        
        SFSpeechRecognizer.requestAuthorization { authStatus in
            /*
             The callback may not be called on the main thread. Add an
             operation to the main queue to update the record button's state.
             */
            OperationQueue.main.addOperation {
                switch authStatus {
                case .authorized:
                    self.recordButton.isEnabled = true
                    
                case .denied:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("User denied access to speech recognition", for: .disabled)
                    
                case .restricted:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition restricted on this device", for: .disabled)
                    
                case .notDetermined:
                    self.recordButton.isEnabled = false
                    self.recordButton.setTitle("Speech recognition not yet authorized", for: .disabled)
                }
            }
        }
    }
    
    private func startRecording() throws {
        
        // Cancel the previous task if it's running.
        if let recognitionTask = recognitionTask {
            recognitionTask.cancel()
            self.recognitionTask = nil
        }
        
        let audioSession = AVAudioSession.sharedInstance()
        try audioSession.setCategory(AVAudioSessionCategoryPlayAndRecord, mode: AVAudioSessionModeSpokenAudio, options: .duckOthers)
        //audioSession.outputVolume = 1.0
        //try audioSession.setMode(AVAudioSessionModeMeasurement)
        try audioSession.setActive(true, with: .notifyOthersOnDeactivation)
        
        recognitionRequest = SFSpeechAudioBufferRecognitionRequest()
        
        let inputNode1 = audioEngine.inputNode
        guard let recognitionRequest = recognitionRequest else { fatalError("Unable to created a SFSpeechAudioBufferRecognitionRequest object") }
        
        // Configure request so that results are returned before audio recording is finished
        recognitionRequest.shouldReportPartialResults = true
        
        // A recognition task represents a speech recognition session.
        // We keep a reference to the task so that it can be cancelled.
        recognitionTask = speechRecognizer.recognitionTask(with: recognitionRequest) { result, error in
            var isFinal = false
            
            if let result = result {
                //let node = self.audioEngine.inputNode
                self.textView.text = result.bestTranscription.formattedString
                print(result.bestTranscription.formattedString.lowercased())
                if self.greetings.contains(result.bestTranscription.formattedString.lowercased()) {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        let hour = Calendar.current.component(.hour, from: Date())
                        let minutes = Calendar.current.component(.minute, from: Date())
                        var timelyGreeting = ""
                        if 0..<12 ~= hour {
                            timelyGreeting = "Good morning"
                        } else if 12..<13 ~= hour {
                            timelyGreeting = "Good Afternoon"
                        }else if 13..<19 ~= hour {
                            timelyGreeting = "Good Evening"
                        } else {
                            timelyGreeting = "Good night"
                        }
                        self.speak("\(self.greetings[Int(arc4random_uniform(UInt32(self.greetings.count)))])  "+timelyGreeting)
                    }
                } else if self.salutations.contains(result.bestTranscription.formattedString.lowercased()) {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        
                        self.speak(self.salutations[Int(arc4random_uniform(UInt32(self.salutations.count)))])
                    }
                } else if self.chanel.contains(result.bestTranscription.formattedString.lowercased())  {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        self.speak(self.chanelAnswer)
                    }
                    
                    
                } else if self.bagInfo.contains(result.bestTranscription.formattedString.lowercased())  {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        self.speak(self.bagInfoAnswer)
                    }
                    
                    
                } else if self.bagInfoFrench.contains(result.bestTranscription.formattedString.lowercased())  {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        self.speak(self.bagInfoAnswerFrench)
                    }
                    
                    
                } else if self.ssQ.contains(result.bestTranscription.formattedString.lowercased())  {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        self.speak(self.ssA)
                    }
                    
                    
                } else if self.whatTime.contains(result.bestTranscription.formattedString.lowercased())  {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    let hour = Calendar.current.component(.hour, from: Date())
                    let minutes = Calendar.current.component(.minute, from: Date())
                    var timelyGreeting = ""
                    var AMPM = ""
                    if 0..<12 ~= hour {
                        timelyGreeting = "Good morning"
                        AMPM = "AM"
                    } else if 12..<13 ~= hour {
                        timelyGreeting = "Good Afternoon"
                        AMPM = "PM"
                    }else if 13..<19 ~= hour {
                        timelyGreeting = "Good Evening"
                        AMPM = "PM"
                    } else {
                        timelyGreeting = "Good night"
                        AMPM = "PM"
                    }
                    if result.isFinal {
                        self.speak("The current time is \(hour) \(minutes) \(AMPM). \(timelyGreeting)")
                    }
                    
                    
                } else if self.howAreYou.contains(result.bestTranscription.formattedString.lowercased())  {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        self.speak(self.imGood[Int(arc4random_uniform(UInt32(self.salutations.count)))])
                    }
                    
                    
                }else if self.speakHindi.contains(result.bestTranscription.formattedString.lowercased())  {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        self.speak(self.hindiPhrase)
                    }
                    
                    //                } else if self.tellAbtSukhi.contains(result.bestTranscription.formattedString.lowercased())  {
                    //                    //inputNode.removeTap(onBus: 0)
                    //                    //self.cancelRecording()
                    //                    if result.isFinal {
                    //                        self.speak(self.whatIsSukhi)
                    //                    }
                    //
                    //
                }else {
                    //inputNode.removeTap(onBus: 0)
                    //self.cancelRecording()
                    if result.isFinal {
                        self.speak("Sorry, I didn't recognize that.")
                    }
                }
                isFinal = result.isFinal
            }
            
            if error != nil || isFinal {
                self.audioEngine.stop()
                inputNode1.removeTap(onBus: 0)
                
                self.recognitionRequest = nil
                self.recognitionTask = nil
                
                self.recordButton.isEnabled = true
                self.recordButton.setTitle("Start Recording", for: [])
            }
        }
        
        let recordingFormat = inputNode1.outputFormat(forBus: 0)
        inputNode1.installTap(onBus: 0, bufferSize: 6144, format: recordingFormat) { (buffer: AVAudioPCMBuffer, when: AVAudioTime) in
            //self.recognitionRequest = nil
            //inputNode.removeTap(onBus: 0)
            self.recognitionRequest?.append(buffer)
        }
        
        audioEngine.prepare()
        
        try audioEngine.start()
        
        textView.text = "Hi there! Talk to me! I'm listening!😃"//"(Go ahead, I'm listening)"
    }
    
    func speak(_ speechString: String) {
        let speechUtterance = AVSpeechUtterance(string: speechString)
        speechUtterance.volume = 1.0
        speechUtterance.rate = 0.5
        speechUtterance.pitchMultiplier = 1.15
        speechUtterance.voice = tellMeTheLanguageAndVoice(of: speechString)
        self.textView.text = "BOT:  "+"\(speechString)"
        speechSynthesizer.speak(speechUtterance)
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            recordButton.setTitle("Stopping", for: .disabled)
        }
        self.recognitionTask = nil
    }
    
    // MARK: SFSpeechRecognizerDelegate
    
    public func speechRecognizer(_ speechRecognizer: SFSpeechRecognizer, availabilityDidChange available: Bool) {
        if available {
            recordButton.isEnabled = true
            recordButton.setTitle("Tap To Start Recording", for: [])
        } else {
            recordButton.isEnabled = false
            recordButton.setTitle("Recognition not available", for: .disabled)
        }
    }
    
    func tellMeTheLanguageAndVoice(of this: String) -> AVSpeechSynthesisVoice {
        let language = (AVSpeechSynthesisVoice(language: CFStringTokenizerCopyBestStringLanguage(this as CFString, CFRange(location: 0, length: this.characters.count)) as String?))
        print(language!)
        return language!
    }
    
    // MARK: Interface Builder actions
    
    @IBAction func recordButtonTapped() {
        if audioEngine.isRunning {
            audioEngine.stop()
            recognitionRequest?.endAudio()
            recordButton.isEnabled = false
            //speechSynthesizer.stopSpeaking(at: AVSpeechBoundary.immediate)
            recordButton.setTitle("Stopping", for: .disabled)
        } else {
            speechSynthesizer.stopSpeaking(at: .immediate)
            try! startRecording()
            recordButton.setTitle("Stop recording", for: [])
        }
    }
}


