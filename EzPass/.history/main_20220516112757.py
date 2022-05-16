# This Python file uses the following encoding: utf-8
import os
from pathlib import Path
import sys
import random
import datetime
from backend import *
import easygui

from PySide2.QtGui import QGuiApplication
from PySide2.QtQml import QQmlApplicationEngine
from PySide2.QtCore import QObject, Slot, Signal, QTimer

class MainWindow(QObject):
    def __init__(self):
        QObject.__init__(self)


    switchPageVar = Signal(str)
    openPasswordVar = Signal(str)
    receivePasswordVar = Signal(str)
    reloadPageVar = Signal(str)


    @Slot(str)
    def createPassword(self, name):
        filepath = randomlet(16)
        createpass(filepath, filepath, encpassword, encpassword)


    @Slot(str)
    def openPassword(self, password):

        filepath = easygui.fileopenbox()
        global passw2
        passw = json.dumps(json.loads(loadpass(filepath, encpassword, encpassword)))
        passw = editpass(jsons=passw, decision="add_password", data=json.dumps({"amogus":"sus"}))
        passw = json.dumps(passw)
        passw2 = passw
        print(passw)

        self.openPasswordVar.emit(" ")

    @Slot(str)
    def switchPage(self, page):
        print(f"got signal sp, {page}")
        self.switchPageVar.emit(page)

    @Slot(str)
    def reloadPage(self, reload):
        self.reloadPageVar.emit(" ")

    @Slot(str)
    def sendPassword(self, password):
        global encpassword
        encpassword = password
        

    @Slot(str)
    def receivePassword(self, password):
        self.receivePasswordVar.emit(".".join([randomlet(16) for i in range(2)]))
    
    
    @Slot(str)
    def addPassword(self, password):
        print("pasword is " + encpassword)
        passw = passw2
        passw = editpass(jsons=json.loads(passw), decision="add_password", data=json.dumps({"amogus":"sus"}))
        savepass(passw["file_name"], passw, encpassword, encpassword)

if __name__ == "__main__":
    app = QGuiApplication(sys.argv)
    engine = QQmlApplicationEngine()

    # Get Data
    main = MainWindow()
    engine.rootContext().setContextProperty("backend", main)


    engine.load(os.fspath(Path(__file__).resolve().parent / "qml/main.qml"))
    if not engine.rootObjects():
        sys.exit(-1)
    sys.exit(app.exec_())
