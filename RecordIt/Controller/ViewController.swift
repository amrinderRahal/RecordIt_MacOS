//
//  ViewController.swift
//  RecordIt
//
//  Created by Amrinder on 12/10/23.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var lblCountdown: NSTextField!

    @IBOutlet weak var btnPlayPayse: NSButton!

    @IBOutlet weak var tblView: NSTableView!
    
    var isStarted = false {
        didSet {
            btnPlayPayse.title = isStarted ? "Stop" : "Start"
            btnPlayPayse.bezelColor = isStarted ? NSColor.systemRed : NSColor.systemGreen
        }
    }
    var appDelegate: AppDelegate?
    var arrRecords = [RecordsModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        defaultSetup()
        setupTableView()
    }

    func defaultSetup() {
        NotificationCenter.default.addObserver(self, selector: #selector(onTimerUpdate), name: Notification.Name("timerRecord"), object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(updateTimerStatus), name: Notification.Name("timerStatusUpdated"), object: nil)
        if let appDelegate = NSApplication.shared.delegate as? AppDelegate {
            self.appDelegate = appDelegate
            self.isStarted = appDelegate.isStarted
        }
    }

    func setupTableView() {
        self.tblView.delegate = self
        self.tblView.dataSource = self
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    @IBAction func btnStart(_ sender: Any) {
        self.appDelegate?.updateTimerStatuss()
    }
    @IBAction func btnClearAll(_ sender: Any) {
        let alert = NSAlert()
        alert.addButton(withTitle: "")
        let okSelected = dialogOKCancel(question: "Do you want to clear all records?", text: "This will clear all the records.")
        if okSelected {
            if isStarted == true {
                self.appDelegate?.updateTimerStatuss()
            }
            self.lblCountdown.stringValue = ""
            self.appDelegate?.totalTime = 0
            self.arrRecords.removeAll()
            self.tblView.reloadData()
        }
    }

    func dialogOKCancel(question: String, text: String) -> Bool {
        let alert = NSAlert()
        alert.messageText = question
        alert.informativeText = text
        alert.alertStyle = .warning
        alert.addButton(withTitle: "OK")
        alert.addButton(withTitle: "Cancel")
        return alert.runModal() == .alertFirstButtonReturn
    }

    @objc func updateTimerStatus() {
        if let appDelegate = self.appDelegate {
            let isStarted = appDelegate.isStarted
            self.isStarted = isStarted
        }
        if isStarted == false {
            saveRecord()
        }
    }

    @objc func onTimerUpdate(timer: Timer) {
        if let appDelegate = self.appDelegate {
            let time = appDelegate.totalTime
            lblCountdown.stringValue = "Total Worked: \(time.asString())"
        }
    }

    func saveRecord() {
        if let appDelegate = self.appDelegate {
            let record = RecordsModel(startTime: appDelegate.startTime!, endTime: Date())
            arrRecords.append(record)
        }
        self.tblView.reloadData()
    }

}

extension ViewController: NSTableViewDataSource {

    func numberOfRows(in tableView: NSTableView) -> Int {
        return self.arrRecords.count
    }

}

extension ViewController: NSTableViewDelegate {

    func tableView(_ tableView: NSTableView, viewFor tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellIdentifier = NSUserInterfaceItemIdentifier(rawValue: "TimeRecordCell")
        let record = self.arrRecords[row]
        guard let cellView = tableView.makeView(withIdentifier: cellIdentifier, owner: self) as? TimeRecordCell else { return nil }
        if tableColumn?.identifier == TableColumns.index {
            cellView.lblTitle.stringValue = "\(row + 1)"
        }
        if tableColumn?.identifier == TableColumns.startAt {
            cellView.lblTitle.stringValue = DateUtility.convertDateInString(record.startTime, dateFormat: "hh:mm:ss a")
        }
        if tableColumn?.identifier == TableColumns.endAt {
            cellView.lblTitle.stringValue = DateUtility.convertDateInString(record.endTime, dateFormat: "hh:mm:ss a")
        }
        if tableColumn?.identifier == TableColumns.duration {
            cellView.lblTitle.stringValue = DateUtility.calculateDateDifference(start: record.startTime, end: record.endTime) ?? ""
        }
        return cellView
    }

}
extension ViewController {
    private struct TableColumns {
        static let index = NSUserInterfaceItemIdentifier("AutomaticTableColumnIdentifier.0")
        static let startAt = NSUserInterfaceItemIdentifier("AutomaticTableColumnIdentifier.1")
        static let endAt = NSUserInterfaceItemIdentifier("AutomaticTableColumnIdentifier.2")
        static let duration = NSUserInterfaceItemIdentifier("AutomaticTableColumnIdentifier.3")
    }

}
