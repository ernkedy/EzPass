# ------------------------- [ Sub Project File | Coding: utf-8 ] -------------------------- #
# Project: EzPass                                                                           #
# File: backend.py	                                                                        #
# Python Version: 3.10.2 - Tested: 3.10.2 - All others are untested.                        #
# The libraries should get installed among the integrated libraries: Libraries			    #
# ----------------------------------------- [ ! ] ----------------------------------------- #
# This code doesn't have any errors. if you got an error, check syntax and python version.  #
# ----------------------------------------- [ ! ] ----------------------------------------- #
# Author: nihadenes - <nihadenesvideo@gmail.com>                                            #
# Links: <https://github.com/nihadenes>                                                     #
# Date: Date                                                                          		#
# License: License																			#
# --------------------------------------- [ Enjoy ] --------------------------------------- #

import numpy as np
import hashlib
import random
import string
import base64
import json
import time
from datetime import date
import sqlite3
import string
import random


from cryptography.hazmat.primitives.kdf.pbkdf2 import PBKDF2HMAC
from cryptography.hazmat.backends import default_backend
from cryptography.hazmat.primitives import hashes
from cryptography.fernet import Fernet
from PIL import Image

vt = sqlite3.connect("C:/Users/User/Desktop/sunucu.sqlite")
im = vt.cursor()

def savePassToDataBase(sifre):
    try:
        im.execute("create table if not exists sifreler (password text primary key)")
        im.execute(f"insert into sifreler(password) values('{sifre}')")
        vt.commit()
        print(f"{sifre} succesfully saved.")
        print(im.execute("select * from sifreler").arraysize)
        vt.close()
    except sqlite3.DatabaseError:
        print("An error occured in the database.")
# Functions for encrypting and hashing.

def encode64(encde):
    return base64.b64encode(encde.encode("utf-8")).decode("utf-8").strip("=")


def decode64(decde):
    try:
        return base64.b64decode(get64(decde).encode("utf-8")).decode("utf-8")
    except:
        return False


def isBase64(s):
    try:
        return base64.b64encode(base64.b64decode(s)).decode() == s
    except:
        return False


def get64(string):
    try:
        return string + "=" * [isBase64(string + x) for x in ["", "=", "=="]].index(True)
    except:
        return False


def hash_sha256(hash_string):
    sha_signature = \
        hashlib.sha256(hash_string.encode("utf-8")).hexdigest()
    return sha_signature


def fernetencrypt(key, string):
    try:
        return Fernet(key.encode("utf-8")).encrypt(string.encode("utf-8")).decode("utf-8")
    except:
        return False


def fernetdecrypt(key, string):
    try:
        return Fernet(key.encode("utf-8")).decrypt(string.encode("utf-8")).decode("utf-8")
    except:
        return False


def fernetgetkey(password, salt):
    return base64.urlsafe_b64encode(
        PBKDF2HMAC(algorithm=hashes.SHA256(), length=32, salt=hash_sha256(hash_sha256(salt)).encode("utf-8"), iterations=100000,
                   backend=default_backend()).derive(hash_sha256(hash_sha256(password)).encode())).decode("utf-8")


# EzPass functions.

def loadpass(filepath, password, salt):
    with open(filepath, "r", encoding="utf-8") as f:
        try:
            data = f.read()
            f.close()
            return json.loads(json.dumps(fernetdecrypt(fernetgetkey(password, salt), decode64(data)), indent=4))
        except:
            return False


def savepass(filepath, jsons, password, salt):
    with open(filepath, "w", encoding="utf-8") as f:
        try:
            f.write(encode64(fernetencrypt(fernetgetkey(password, salt), json.dumps(jsons, indent=4))))
            f.close()
            return True
        except:
            return False


def createpass(filepath, listname, password, salt):
    with open(filepath, "w", encoding="utf-8") as f:
        try:
            jsons = {"file_name": filepath.split("/")[-1], "list_name": listname, "created": f"{date.today()}", "passwords": []}
            f.write(encode64(fernetencrypt(fernetgetkey(password, salt), json.dumps(jsons, indent=4))))
            f.close()
            return True
        except:
            return False


def editpass(jsons=None, decision=None, data=None, id=None):
    jsons = json.loads(jsons)
    if decision == "add_password":
        jsons["passwords"].append(data)
    elif decision == "remove_password":
        del jsons["passwords"][id]
    elif decision == "edit_password":
        jsons["passwords"][id] = data
    return json.dumps(jsons, indent=4)


# Useful functions.

def randomlet(lentgth):
    return ''.join(random.choice(string.ascii_letters) for i in range(lentgth))


def paragraph(string, liner):
    return [string[i:i+liner] for i in range(0, len(list(string)), liner)]