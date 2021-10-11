# Import Statements
from genericpath import exists
import os
from shutil import rmtree
import subprocess
import sys
import argparse
import time
import zipfile
from getpass import getpass
    
try:
    from artifactory import ArtifactoryPath
except ImportError:
    print("Cannot import artifactory module. Please supply your netid and password for Aptiv's Proxy to download via pip")
    user = input("Enter your netID: ")
    password = getpass()
    proxyUrl = '--proxy=http://' + user + ':' + password + '@autoproxy-amer.delphiauto.net:8080'
    subprocess.check_call([sys.executable, "-m", "pip", "install", 'dohq-artifactory', proxyUrl])
finally:
    from artifactory import ArtifactoryPath
    from requests.exceptions import HTTPError

# Function Definitions gen7-aptiv-advradar-3rd_party-generic-local/AWR294x/ti-clang/0.1/ti-clang-0.1.zip
class toolsInit:
    def __init__(self, user, password):
        self.repoRootPath = './../../' # This is the relative path from the pwd to the repository root
        self.artifactoryUrl = 'https://jfrog.asux.aptiv.com/artifactory/gen7-aptiv-advradar-3rd_party-generic-local/'
        self.tiClangDownloadUrl = self.artifactoryUrl + 'AWR294x/ti-clang/0.1/ti-clang-0.1.zip'
        self.tempTiClangZipFilename = 'ti-clang.zip'
        self.pathToToolsDir = self.repoRootPath + 'tools/'
        self.pathToTiClangZip = self.pathToToolsDir + self.tempTiClangZipFilename
        self.tiClangInstallDir = "C:/ti/compiler/"

        self.bswDownloadUrl =  self.artifactoryUrl + 'RRU2/bsw/1.0/bsw-1.0.zip'
        self.tempBswFilename = 'BSW.zip'
        self.pathToBswZip = self.pathToToolsDir + self.tempBswFilename
        self.pathToBswDir = self.repoRootPath + 'BSW/'
        self.user = user
        self.password = password

        self.__checkAuthentication()

    def updatePathToRepoRoot(self, pathToRepoRoot):
        """
        When the class is initialized, it assumes the class is run from the location
        that the script is stored. If the class is being exectued from another directory,
        the path to the repository root needs to be updated.

        The path can either be a relative path from the pwd to the repository root or it
        can be an absolute path to the repository root.
        """
        self.repoRootPath = pathToRepoRoot

    # download and use custom print function
    def __print_download_status(self, bytes_now, total):
        """
        Custom function that accepts first two arguments as [int, int] in its signature
        """
        # print("Downloaded ", bytes_now / 1024, " / ", round(total / 1024, 1), " KB", end='\r')
        print("Downloaded ", bytes_now, " / ",total, " Bytes", end='\r')

    def downloadFile(self, downloadUrl, downloadPath, user, password):
        """
        Function to download a file from the web using curl
        """
        path = ArtifactoryPath(downloadUrl, auth=(user, password))
        path.writeto(
            out=downloadPath,
            chunk_size=1048576 * 10, # Download 10Mb at at time
            progress_func=lambda x, y: self.__print_download_status(x, y),
        )

    def unzipZipFile(self, zipLocation, unzipPath):
        """
        Function to unzip a file into a provided location
        """
        with zipfile.ZipFile(zipLocation, 'r') as zip_ref:
            zip_ref.extractall(unzipPath)

    def __checkAuthentication(self):
        """
        Function to check that a username and password can log in to JFrog
        """
        authAttempt = 1
        authSuccessful = False

        print("\nNetID and Password are needed to log in to JFrog in order to download binary files.")
        print("This information is not stored once the script exits.")
        if self.user is None:
            self.user = input("Please Enter your netID: ")

        if self.password is None:
            self.password = getpass()
        
        while not authSuccessful:
            try:
                path = ArtifactoryPath(self.artifactoryUrl, auth=(self.user, self.password))
                path.touch()
                authSuccessful = True
            except HTTPError:
                if authAttempt >= 5:
                    raise ValueError("Authentication not successful after 5 attempts!")
                print("Authentication not successful! Please re-enter your credentials.")
                self.user = input("Enter your netID: ")
                self.password = getpass()
                authAttempt = authAttempt + 1

    def initTiClang(self):
        tiClangStartTime = time.time()

        # Remove old ti-clang.zip, if exists
        if os.path.isfile(self.pathToTiClangZip):
            print("Removing old temporary Ti Clang zipfile...")
            os.remove(self.pathToTiClangZip)

        # Download the TI Clang Compiler package from Artifactory
        print("Downloading Ti Clang Compiler from Artifactory")
        print("This make take a few minutes, depending on your network speed.")
        self.downloadFile(self.tiClangDownloadUrl, self.pathToTiClangZip, self.user, self.password)
        downloadEndTime = time.time()
        print("\n\nDownload took ", downloadEndTime - tiClangStartTime, " seconds\n")

        # Get folder name from the zip file
        with zipfile.ZipFile(self.pathToTiClangZip, 'r') as zip_ref:
            dirName = zip_ref.namelist()[0]

        # Remove the old Ti Clang folder, if it exists
        tiClangDir = self.tiClangInstallDir + dirName
        if os.path.isdir(tiClangDir):
            print("Removing old TI Clang Compiler directory...")
            rmtree(tiClangDir)

        # Unzip the package into the correct folder
        print("Unzipping Ti Clang Compiler into the desired directory...")
        self.unzipZipFile(self.pathToTiClangZip, self.tiClangInstallDir)

        # Remove the temporary zip file
        print("Removing the temporary Ti Clang Compiler zipfile...")
        os.remove(self.pathToTiClangZip)

        end_time = time.time()
        print("Ti Clang Compiler init took ", round(end_time - tiClangStartTime, 2), "seconds\n")

    def initBsw(self):
        bswStartTime = time.time()
        # Remove old BSW.zip, if exists
        if os.path.isfile(self.pathToBswZip):
            print("Removing old temporary BSW zipfile...")
            os.remove(self.pathToBswZip)

        # Download the BSW package from Artifactory
        print("Downloading BSW from Artifactory")
        print("This make take a few minutes, depending on your network speed.")
        self.downloadFile(self.bswDownloadUrl, self.pathToBswZip, self.user, self.password)
        downloadEndTime = time.time()
        print("\n\nDownload took ", downloadEndTime - bswStartTime, " seconds\n")

        # Get names of directories in the Zip file
        print("Removing old BSW directories & Files...")
        pathsList = []
        with zipfile.ZipFile(self.pathToBswZip, 'r') as zipObj:
            zipfilePath = zipfile.Path(zipObj)
            for child in zipfilePath.iterdir():
                pathToChildInBswDir = self.pathToBswDir + child.name
                pathsList.append(pathToChildInBswDir)
                if os.path.isdir(pathToChildInBswDir):
                    rmtree(pathToChildInBswDir)
                    print("Removed directory " + pathToChildInBswDir)
                elif os.path.isfile(pathToChildInBswDir):
                    os.remove(pathToChildInBswDir)
                    print("Removed file " + pathToChildInBswDir)
                else:
                    print("Path not found. No action taken at " + pathToChildInBswDir)
        # Add any files in the zip to the .gitignore list
        print ("\nAdding paths to .gitignore")
        print ("This file should be commited to the repository if it is changed.\n")
        self.addPathsToGitignore(pathsList)

        # Unzip the package into the correct folder
        print("\nUnzipping zip into the BSW directory...")
        self.unzipZipFile(self.pathToBswZip, self.pathToBswDir)

        # Remove the temporary zip file
        print("Removing the temporary BSW zipfile...")
        os.remove(self.pathToBswZip)

        end_time = time.time()
        print("\nBSW init took ", round(end_time - bswStartTime, 2), "seconds\n")

    def addPathsToGitignore(self, pathsList):
        # Read current .gitignore paths
        with open(self.repoRootPath + ".gitignore") as fi:
            gitignoreLines = fi.readlines()
            gitignoreLines = [line.rstrip() for line in gitignoreLines]

        with open(self.repoRootPath + ".gitignore", "a") as fi:
            for path in pathsList:
                # Remove relative path to the repository root
                if path.startswith(self.repoRootPath):
                    path = path[len(self.repoRootPath):]
                if path not in gitignoreLines:
                    # Write each new path on a new line
                    fi.write("\n" + path)
                    print(path + " added to .gitignore")

# Current implemenatation relies on relative paths.
# Future improvement could be to set up a path manager and use
# absolute paths which could prevent the need to switch directories.
origPwd = os.getcwd()
os.chdir(os.path.dirname(__file__))

parser = argparse.ArgumentParser(description='Provide inputs to they Python script on which to. \n \
    If no tool is provided, all tools in the script will be initialized.')
parser.add_argument('--ti', action='store_true',
                    help='Tells the script to initialize the Ti Clang Compiler')
parser.add_argument('--bsw', action='store_true',
                    help='Tells the script to initialize the bsw tools')
parser.add_argument('--user', dest='user', action='store',
                    default=None,
                    help='Provide your netID for logging into the download Artifactory')
parser.add_argument('--pass', dest='password', action='store',
                    default=None,
                    help='Provide your password for logging into the download Artifactory')

args = parser.parse_args()

# If no specific tool is provided, download both tools.
if not args.ti and not args.bsw:
    args.ti = True
    args.bsw = True

toolsInitObj =toolsInit(args.user, args.password)

if args.ti:
    toolsInitObj.initTiClang()

if args.bsw:
    toolsInitObj.initBsw()

os.chdir(origPwd)
