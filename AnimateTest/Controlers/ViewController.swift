//
//  ViewController.swift
//  AnimateTest
//
//  Created by Roman Efimov on 16/10/2019.
//  Copyright © 2019 Roman Efimov. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    class MyTapGestureRecognizer: UITapGestureRecognizer {
        var parametr: String?
    }
    
    @IBOutlet weak var titleAgu: UILabel!
    @IBOutlet weak var vs: UILabel!
    @IBOutlet weak var titleRival: UILabel!
    @IBOutlet weak var subtitleAgu: UILabel!
    
    var searchResponse: SearchResponse? = nil
    
    var vr = 0
    var lk = 0
    var lp = 0
    var l = 0
    var pp = 0
    var r = 0
    var pk = 0
    
    var selectedPlayer: [String] = []
    var photoURL: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        fetchPlayers()

        titleAgu.alpha = 0
        vs.alpha = 0
        titleRival.alpha = 0
        subtitleAgu.alpha = 0
        
        view.backgroundColor = UIColor(red: 235/255.0, green: 72/255.0, blue: 63/255.0, alpha: 1.0)
        moveField()
    }
    
    func fetchPlayers(){
        let networkPlayersFetcher = NetworkPlayersFetcher()
        networkPlayersFetcher.fetchPlayers { (searchResponse) in
            guard let searchResponse = searchResponse else { return }
            self.searchResponse = searchResponse
        }
    }
    
    
    func detectPlayers(){
        
        for player in searchResponse!.players{
            
            switch player.amplua{
            case "ВР":
                if player.osnovnoi == "1" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
                        self.vr += 1
                        let x: CGFloat = self.view.frame.width/2 - 50
                        let y: CGFloat = self.view.frame.height/2 - 160
                        self.drawPlayer(x: x, y: y + CGFloat(self.vr * 30), title: player.number + " - " + player.lastname, number: player.number)
                    }
                }
                
            case "ЛК":
                if player.osnovnoi == "1" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(800)) {
                        self.lk += 1
                        let x: CGFloat = 1
                        let y: CGFloat = self.view.frame.height/2 - 160
                        self.drawPlayer(x: x, y: y + CGFloat(self.lk * 30), title: player.number + " - " + player.lastname, number: player.number)
                    }
                }
            case "ПК":
                if player.osnovnoi == "1" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1200)) {
                        self.pk += 1
                        let x: CGFloat = self.view.frame.width - 101
                        let y: CGFloat = self.view.frame.height/2 - 160
                        self.drawPlayer(x: x, y: y + CGFloat(self.pk * 30), title: player.number + " - " + player.lastname, number: player.number)
                    }
                }
                
            case "ЛП":
                if player.osnovnoi == "1" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1500)) {
                        self.lp += 1
                        let x: CGFloat = 10
                        let y: CGFloat = self.view.frame.height/2 - 60
                        self.drawPlayer(x: x, y: y + CGFloat(self.lp * 30), title: player.number + " - " + player.lastname, number: player.number)
                    }
                }
                
            case "ПП":
                if player.osnovnoi == "1" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(1800)) {
                        self.pp += 1
                        let x: CGFloat = self.view.frame.width - 110
                        let y: CGFloat = self.view.frame.height/2 - 60
                        self.drawPlayer(x: x, y: y + CGFloat(self.pp * 30), title: player.number + " - " + player.lastname, number: player.number)
                    }
                }
                
            case "Л":
                if player.osnovnoi == "1" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2100)) {
                        self.l += 1
                        let x: CGFloat = self.view.frame.width/2 - 50
                        let y: CGFloat = self.view.frame.height/2 - 50
                        self.drawPlayer(x: x, y: y + CGFloat(self.l * 30), title: player.number + " - " + player.lastname, number: player.number)
                    }
                }
            
            case "Р":
               if player.osnovnoi == "1" {
                    DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2400)) {
                        self.r += 1
                        let x: CGFloat = self.view.frame.width/2 - 50
                        let y: CGFloat = self.view.frame.height/2 + 50
                        self.drawPlayer(x: x, y: y + CGFloat(self.r * 30), title: player.number + " - " + player.lastname, number: player.number)
                    }
                }
                
            default:
                print ("")
            }
        }
    }
    


    func prepareTitles(){
          DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            UIView.animate(withDuration: 1) {
                self.titleAgu.alpha = 1
                self.subtitleAgu.alpha = 1
                self.vs.alpha = 1
                self.titleRival.alpha = 1
                self.detectPlayers()
            }
        }
    }
    
    
    
    func drawPlayer(x: CGFloat, y: CGFloat, title: String, number: String){
        let player = UIImageView()
        player.restorationIdentifier = title
        let image = #imageLiteral(resourceName: "plashka")
        let imageWithText = self.textToImage(drawText: title, inImage: image, atPoint: CGPoint(x: 60.0, y: 50.0))
        player.image = imageWithText
        player.frame = CGRect(x: x, y: y, width: 100, height: 28)
        
        let gestureRecognizer = MyTapGestureRecognizer(target: self, action: #selector(handleTap(sender:)))
        gestureRecognizer.parametr = number
        player.isUserInteractionEnabled = true
        player.addGestureRecognizer(gestureRecognizer)
        self.view.addSubview(player)
    
        self.animateMarkers(x: x, y: y, player: player)
    }
    
    
    @objc func handleTap(sender: MyTapGestureRecognizer ){
        selectedPlayer.removeAll()
        for index in searchResponse!.players{
            if index.number == sender.parametr {
                selectedPlayer.append(index.name + " " + index.lastname)
                //selectedPlayer.append("Возраст: " + index.dayofbirth)
                selectedPlayer.append("Номер: " + index.number)
                selectedPlayer.append("Амплуа: " + index.amplua)
                selectedPlayer.append("Статус: " + index.status)
                photoURL = index.photo
            }
        }
       self.performSegue(withIdentifier: "showPlayerDetail", sender: self)
        
    }
    
    
    
    
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
       let textColor = UIColor.white
       let textFont = UIFont(name: "Helvetica Bold", size: 48)!

       let scale = UIScreen.main.scale
       UIGraphicsBeginImageContextWithOptions(image.size, false, scale)

       let textFontAttributes = [
        NSAttributedString.Key.font: textFont,
        NSAttributedString.Key.foregroundColor: textColor,
        ] as [NSAttributedString.Key : Any]
       image.draw(in: CGRect(origin: CGPoint.zero, size: image.size))

       let rect = CGRect(origin: point, size: image.size)
       text.draw(in: rect, withAttributes: textFontAttributes)

       let newImage = UIGraphicsGetImageFromCurrentImageContext()
       UIGraphicsEndImageContext()

       return newImage!
    }
    

    
    
    func animateMarkers(x: CGFloat, y: CGFloat, player: UIImageView){
        
        UIView.animate(withDuration: 0.4, animations: {
            player.frame = CGRect(x: x, y: y+70, width: 100, height: 18)
            
        }) { (finished: Bool) in
            UIView.animate(withDuration: 0.2) {
                player.frame = CGRect(x: x, y: y+50, width: 100, height: 28)
                sleep(UInt32(0.5))
            }
        }
        
    }
    

   
    func moveField(){
      let field = UIImageView()
        let fieldWidth = view.frame.width
        let fieldHeight = view.frame.height
        let fieldX: CGFloat = 0.0
        let fieldY: CGFloat = 0.0
        
        field.frame = CGRect(x: fieldX, y: fieldY, width: fieldWidth, height: fieldHeight)
        field.image = #imageLiteral(resourceName: "pole")
        view.addSubview(field)
        
        
        let logo1 = UIImageView()
        logo1.image = #imageLiteral(resourceName: "2")
        let logo1Width: CGFloat = 100.0
        let logo1Height: CGFloat = 100.0
        let logo1X = (view.frame.width/2)-(logo1Width/2)
        let logo1Y: CGFloat = 120
        logo1.alpha = 0
        logo1.frame = CGRect(x: logo1X, y: logo1Y, width: logo1Width, height: logo1Height)
        field.addSubview(logo1)
        
        let logo2 = UIImageView()
        logo2.image = #imageLiteral(resourceName: "1")
        let logo2Width: CGFloat = 100.0
        let logo2Height: CGFloat = 100.0
        let logo2X = (view.frame.width/2)-(logo2Width/2)
        let logo2Y: CGFloat = view.frame.height-logo2Height-120
        logo2.alpha = 0
        logo2.frame = CGRect(x: logo2X, y: logo2Y, width: logo2Width, height: logo2Height)
        field.addSubview(logo2)
        
        
        UIView.animate(withDuration: 1, animations: {
            logo1.alpha = 0.6
        }) { (finished: Bool) in
            
            UIView.animate(withDuration: 1) {
                logo2.alpha = 0.6
            }
        }
        
       
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(2000)){
            UIView.animate(withDuration: 2, animations: {
                field.frame = CGRect(x: fieldX, y: fieldY+(fieldHeight/2)-100, width: fieldWidth, height: fieldHeight)
            }) { (finished: Bool) in
                
                UIView.animate(withDuration: 1) {
                    logo1.alpha = 0
                    logo2.alpha = 0
                    self.prepareTitles()
                }
                
            }
        }
        
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPlayerDetail" {
            let destinationController = segue.destination  as! PlayerDetailTableViewController
              destinationController.playerInfo = selectedPlayer
            destinationController.photoURL = photoURL
           
        }
    }
    
    
}



