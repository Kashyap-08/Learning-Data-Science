# Git and Github Tutorial

### **Working with Existing Repo**

* Step1: Clone a Repo using the following command: `git clone https://github.com/<GIT REPO NAME>`
* Step2: Repository code will be cloned in particular local folder. Change the code accordangly.
* Step3:
i) If you want to commit in existing/main branch then fire the comand: `git checkout master` <br />
ii) If you want to create new branch then fire the command: `git checkout -b <BRANCH_NAME>`
* Step4: add the changes to Staging area: `git add <FILE NAME>`, you can also commit all changes at once using `git add .` command.
* Step5: Check the number of files that you have commited in Staging area using comand: `git status`
* Step6: Commit the changes in staging area:  `git commit -m '<MESSAGE>'`
* Step7: Push the changes to the branch that you have selected in step4: `git push origin <BRANCH_NAME>`


#### Important Commands
* If you want to full new changes form repo Hit the command: `git pull origin main`
* Switch between the branches: `git checkout <BRANCH_NAME>`
* Delete branch: `git branch -d <BRANCH_NAME>`