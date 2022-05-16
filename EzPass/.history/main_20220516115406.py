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
        global paswlist
        paswlist = []
        createpass(filepath, filepath, encpassword, encpassword)


    @Slot(str)
    def openPassword(self, password):

        filepath = easygui.fileopenbox()

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
        self.receivePasswordVar.emit(".".join([  f" password_-email_{i[]} "   for i in paswlist]))

    @Slot(str)
    def addPassword(self, password):
        paswlist.append({"password": password.split("_")[0], "email": password.split("_")[1]})
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
