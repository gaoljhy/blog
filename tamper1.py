#!/usr/bin/env python
import re
from urllib import quote
from lib.core.data import kb
from lib.core.enums import PRIORITY
__priority__ = PRIORITY.NORMAL
 
def dependencies():
    pass
def tamper(payload, **kwargs):
    retVal = payload
    retVal = quote(quote(retVal))   
    return retVal