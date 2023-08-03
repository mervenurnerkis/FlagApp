//
//  QuizEkraniViewController.swift
//  FlagApp
//
//  Created by Merve Nur Nerkis on 3.08.2023.
//

import UIKit

class QuizEkraniViewController: UIViewController {

    @IBOutlet weak var labelDogru: UILabel!
    @IBOutlet weak var labelYanlis: UILabel!
    
    @IBOutlet weak var labelSoruSayisi: UILabel!
    @IBOutlet weak var imageViewBayrak: UIImageView!
    @IBOutlet weak var buttonA: UIButton!
    @IBOutlet weak var buttonB: UIButton!
    @IBOutlet weak var buttonC: UIButton!
    @IBOutlet weak var buttonD: UIButton!
    
    var sorular = [Bayraklar]()
    var yanlisSecenekler = [Bayraklar]()
    
    var dogruSoru = Bayraklar()
    
    var soruSayac = 0
    var dogruSAyac = 0
    var yanlısSayac = 0
    
    var secenekler = [Bayraklar]()
    var seceneklerKaristirmaListesi = Set <Bayraklar>()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        sorular = Bayraklardao().rastgele5Getir()
        
        for s in sorular {
            print(s.bayrak_ad!)
        }
        
        soruYukle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let gidilecekVC = segue.destination as! SonucEkraniViewController
        gidilecekVC.dogruSayisi = dogruSAyac
    }
    
    func soruYukle(){
        labelSoruSayisi.text = "\(soruSayac+1). SORU"
        labelDogru.text = "Doğru: \(dogruSAyac)"
        labelYanlis.text = "Yanlış: \(yanlısSayac)"
        
        dogruSoru = sorular[soruSayac]
        imageViewBayrak.image = UIImage(named: dogruSoru.bayrak_resim!)
        
        yanlisSecenekler = Bayraklardao().rastgele3YanlisSecenekGetir(bayrak_id: dogruSoru.bayrak_id!)
            
        seceneklerKaristirmaListesi.removeAll()
        seceneklerKaristirmaListesi.insert(dogruSoru)
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[0])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[1])
        seceneklerKaristirmaListesi.insert(yanlisSecenekler[2])
        
        secenekler.removeAll()
        
        for s in seceneklerKaristirmaListesi {
            secenekler.append(s)
        }
        
        buttonA.setTitle(secenekler[0].bayrak_ad, for: .normal)
        buttonB.setTitle(secenekler[1].bayrak_ad, for: .normal)
        buttonC.setTitle(secenekler[2].bayrak_ad, for: .normal)
        buttonD.setTitle(secenekler[3].bayrak_ad, for: .normal)
        
    }
    
    func dogruKontrol(button:UIButton) {
        let buttonYazi = button.titleLabel?.text
        let dogruCevap = dogruSoru.bayrak_ad
        
        print("Button Yazi: \(buttonYazi)")
        print("Dogru Cevap: \(dogruCevap)")
        
        if dogruCevap == buttonYazi {
            dogruSAyac += 1
        }else {
            yanlısSayac += 1
        }
        
        labelDogru.text = "Doğru: \(dogruSAyac)"
        labelYanlis.text = "Yanlis: \(yanlısSayac)"
    }
    
    func soruSayacKontrol() {
        soruSayac += 1
        
        if soruSayac != 5 {
            soruYukle()
        }else {
            performSegue(withIdentifier: "toSonucEkrani", sender: nil)
        }
    }

    @IBAction func buttonAAct(_ sender: Any) {
        dogruKontrol(button: buttonA)
        soruSayacKontrol()
    }
    
    @IBAction func buttonBAct(_ sender: Any) {
        dogruKontrol(button: buttonB)
        soruSayacKontrol()
    }
    
    @IBAction func buttonCAct(_ sender: Any) {
        dogruKontrol(button: buttonC)
        soruSayacKontrol()
    }
    
    @IBAction func buttonDAct(_ sender: Any) {
        dogruKontrol(button: buttonD)
        soruSayacKontrol()
    }
    
}
