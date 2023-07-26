# Git and Github Tutorial

### **Working with New Repo**

* Step1: Initialize Git: `git init`
* Step2: Link vscode env to git repo using the 2 commands:
(i) git config --global user.name "Kashyap Kolhe"
(ii) git config --global user.email "kpkolhe198@gmail.com"
* Step3: Create files
* step4: add changes to staging area `git add README.md`
* Step5: Commit Change to git: `git commit -m "<YOUR COMMENT>"`
* Step6: git branch -M main
* step7: link remote repo: `git remote add origin https://github.com/Kashyap-08/temp.git`
* Step8: Push changes : `git push origin main`

#### Important Commands
* If you want to full new changes form repo Hit the command: `git pull origin main`
* Switch between the branches: `git checkout <BRANCH_NAME>`
* Delete branch: `git branch -d <BRANCH_NAME>`