//
//  ViewController.swift
//  FileTest
//
//  Created by Kyle on 2016/6/14.
//  Copyright © 2016年 Alphacamp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var image1: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //homeDirectory write in
        let idolFile = NSHomeDirectory().stringByAppendingString("idol.txt")
        let array: NSArray = ["A1","B2","C3"]
        
        array.writeToFile(idolFile, atomically: true)
        
        
        //read Poem.txt
        let path = NSBundle.mainBundle().pathForResource("Poem", ofType: "txt")
        do {
            
            let contentString = try NSString(contentsOfFile: path!, encoding: NSUTF8StringEncoding)
            print(contentString)
            
        }catch{
            print(error)
        }
        
        print("\(NSHomeDirectory()) \n\n \(NSTemporaryDirectory())")
        
        
        //建立檔案url 路徑
        let fileManager = NSFileManager.defaultManager()
        let path2 = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)
        let url = path2.first?.URLByAppendingPathComponent("idol2.txt")
        
        do{
            try "super".writeToURL(url!, atomically: true, encoding: NSUTF8StringEncoding)
        }catch{
            print(error)
        }
        
        print("\n\nurl:\(url)")
        
        //建立檔案一般路徑
        let paths3 = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, false)
        let path3 = paths3.first
        print("\n\n\(path3)")
        
        //plist copy用法
        let bundlePlist = NSBundle.mainBundle().pathForResource("Appinit", ofType: "plist")
        let homePlist = NSHomeDirectory().stringByAppendingString("/Documents/Appinit.plist")
        
        let fileManager2 = NSFileManager.defaultManager()
        if !fileManager2.fileExistsAtPath(homePlist){
            do{
                try fileManager2.copyItemAtPath(bundlePlist!, toPath: homePlist)
            }catch{
                print(error)
            }
        }
        //plist read
        
        let homeDic = NSMutableDictionary(contentsOfFile: homePlist)
        let color = homeDic!["ThemColor"]
        
        print(color)
        
        //plist modify
        homeDic?.setValue("Blue", forKey: "ThemColor")
        homeDic?.setValue("09776545663", forKey: "PhoneNumber")
        
        
        
        //plist Write
        
        homeDic?.writeToFile(homePlist, atomically: true)
        
        print(homeDic!)
        
        //image write and read
        
        let image = UIImage(named: "0")
        let imageData:NSData = UIImageJPEGRepresentation(image!, 1)!
        let home = NSHomeDirectory().stringByAppendingString("Documents/writeImg.jpg")
        
        imageData.writeToFile(home, atomically: true)
        
        let picture = UIImage(data: imageData, scale: 1)
        
        image1.image = picture
        
        //NSUserDefaults
        let userDefault = NSUserDefaults.standardUserDefaults()
        userDefault.setInteger(10, forKey: "age")
        userDefault.synchronize()
        
        let age = userDefault.integerForKey("age")
        print(age)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}

