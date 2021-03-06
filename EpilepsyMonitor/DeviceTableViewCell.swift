//
//  DeviceTableViewCell.swift
//  EpilepsyMonitor
//
//  Created by chapnickc on 8/10/16.
//  Copyright © 2016 Chad. All rights reserved.
//

import UIKit
import CoreBluetooth

protocol DeviceCellDelegate: class {
    func connectPressed(_ peripheral: CBPeripheral)
}

class DeviceTableViewCell: UITableViewCell {
    
    @IBOutlet weak var deviceNameLabel: UILabel!
    @IBOutlet weak var deviceRssiLabel: UILabel!
    @IBOutlet weak var connectButton: ConnectButton!
    
    
    var delegate: DeviceCellDelegate?
    
    var displayPeripheral: DisplayPeripheral? {
        /*
         * The didSet function extracts relevant device data
         * when passed a DisplayPeripheral object.
         * It also updates the signal strength from each device while scanning.
         */
		didSet {
			if let deviceName = displayPeripheral!.peripheral?.name {
				deviceNameLabel.text = deviceName.isEmpty ? "No Device Name" : deviceName
            }
            else {
				deviceNameLabel.text = "No Device Name"
			}
            
            if let rssi = displayPeripheral!.lastRSSI {
                deviceRssiLabel.text = "\(rssi) dB"
            }
            
			connectButton.isHidden = !(displayPeripheral?.isConnectable!)!
        }
    }
    
    @IBAction func connectButtonPressed(_ sender: AnyObject) {
        
        delegate?.connectPressed((displayPeripheral?.peripheral)!)
        
        if (displayPeripheral?.peripheral?.state == .connecting) || (displayPeripheral?.peripheral?.state == .connected) {
            connectButton.buttonColorScheme(true)
        }
        else {
            connectButton.buttonColorScheme(false)
        }
    }
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

}
