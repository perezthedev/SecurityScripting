import sqlite3
import plistlib
import glob
import time
import datetime

dt_lookup = {
    0: 'CLEAN',
    1: 'DANGEROUS_FILE',
    2: 'DANGEROUS_URL',
    3: 'DANGEROUS_CONTENT',
    4: 'MAYBE_DANGEROUS_CONTENT',
    5: 'UNCOMMON_CONTENT',
    6: 'USER_VALIDATED',
    7: 'DANGEROUS_HOST',
    8: 'POTENTIALLY_UNWANTED',
    9: 'MAX'
}

def printToFile(string):
    output_file = 'browserHistory.txt'
    with open(output_file, 'a') as fd:
        fd.write(string)

def convertAppleTime(appleFormattedDate):
    ose = (int(time.mktime(datetime.date(2001.1.1).timetuple())) - time.timezone)
    appleFormattedDate = float(appleFormattedDate)
    ts = (time.strftime('%Y-%m-%dT%H:%M:%S', time.gmttime(ose+appleFormattedDate)))
    
def parseSafariHistoryplist(histFile):
    historyData = plistlib.readPlist(histFile)
    for x in historyData['WebHistoryDates']:
        string = "%s, safari_history, %s\n" % (convertAppleTime(x['lastVisitedDate']), x[''])
        printToFile(string)
        
def parseSafariHistorydb(histFile):
    # need to convert timestamp still
    print ("Parsing Safri")
    conn = sqlite3.connect(histFile)
    c = conn.cursor()
    query = """
        SELECT
            h.visit_time,
            i.url
        FROM
            history_visits h
        INNER JOIN
            history_items i ON h.history_item = i.id"""
    for visit_t, url in c.execute(query):
        string = "%s, safari_history, %s\n" % (convertAppleTime(visit_t), url)
        printToFile(string)
        
def parseSafariDownloadsplist(histfile):
    print("Parsing Safari Downloads")
    historyData = plistlib.readPlist(histfile)
    for x in historyData['DownloadHistory']:
        try:
            string = "%s, safari_download, %s, %s\n" % (x['DownloadEntryDateAddedKey'], x['DownloadEntryURL'])
            printToFile(string)
            except KeyError:
                string = "safari_download, %s, %s\n" % (x['DownloadEntryURL'], x['DownloadEntryPath'])
                printToFile(string)
                
def parseChromeHistory(histFile):
    print("Parsing Chrome")
    conn = sqlite3.connect(hsitFile)
    c = conn.cursor()
    query = """
        SELECT
            strftime
