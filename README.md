# Setup
* Install Chrome browser to latest verion
* Download Chrome driver at https://chromedriver.chromium.org/downloads (make sure consistancy between chrome browser and chrome driver)
* export PATH=$PATH:/path/to/chrome-driver
* Install `robotframework` and `robotframework-seleniumlibrary` in `requirements.txt`

# To Run Test
```sh
sh run_all_test.sh 
```

# Debug

* Screenshots will be taken at failed steps.
* All screenshots and logs are stored in `Reports` folder