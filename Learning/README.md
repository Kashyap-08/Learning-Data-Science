### Git and Github Tutorial

git init
git config --global user.name "Kashyap Kolhe"
git config --global user.email "kpkolhe198@gmail.com"


# Git and Github Tutorial

## Git Commands

#### **Working with New Repo**

* Step1: Initialize Git: `git init`
* Step2: Create files
* step3: add changes to staging area `git add README.md`
* Step4: Commit Change to git: `git commit -m "<YOUR COMMENT>"`
* Step5: git branch -M main
* step6: link remote repo: `git remote add origin https://github.com/Kashyap-08/temp.git`
* Push changes : `git push -u origin main`

#### **Working with Existing Repo**

* Step1: Clone a Repo using the following command: `git clone https://github.com/<GIT REPO NAME>`
* Step2: Repository code will be cloned in particular local folder. Change the code accordangly.
* Step3: Get into the particular repo using command: `cd <GIT REPO NAME>`
* Step4: i) If you want to commit in existing/main branch then fire the comand: `git checkout master` <br />
        ii) If you want to create new branch then fire the command: `git checkout -b <BRANCH_NAME>`
* Step5: add the changes to Staging area: `git add <FILE NAME>`, you can also commit all changes at once using `git add .` command.
* Step6: Check the number of files that you have commited in Staging area using comand: `git status`
* Step7: Commit the changes in staging area:  `git commit -m '<MESSAGE>'`
* Step8: Push the changes to the branch that you have selected in step4: `git push origin <BRANCH_NAME>`
