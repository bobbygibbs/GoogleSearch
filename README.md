# GoogleSearch  
Project and test environment to run acceptance framework for REST service that grabs the top result of a web search on [Google](https://www.google.com/).
## Requirements
* [**Ruby**](https://www.ruby-lang.org/en/downloads/)
  * [DevKit](http://rubyinstaller.org/downloads/)
  * [Sinatra](http://www.sinatrarb.com/)
  * [Cucumber](https://cucumber.io/)
* [**IIS Express**](http://www.iis.net/)
* [**Git**](https://git-scm.com/downloads/)  
* [**MSBuild**](https://github.com/microsoft/msbuild/)  

## Leeroy Jenkins  
### Job Description
To integrate with Jenkins, create a job that hosts **AcceptanceTesting\TestEnvironment** from IIS Express, and runs Ruby on the **AcceptanceTesting\mock.rb**. Then bundler may be used to execute the cucumber tests. There should be a post-build task to kill the two hosting processes which should be the only **iisexpress.exe** and **ruby.exe** processes remaining; if not, you will need to track their PIDs.
#### GitHub SCM Setup  
The following steps will allow our Jenkins job to grab the latest files committed to the GitHub project. The first one is necessary, but steps 2. and 3. are only required if you would like Jenkins to automatically build the project whenever a change is pushed to GitHub.  

1. Link the GitHub project to the job  
  a. Click on your job  
  b. Click on "Configure"  
  c. Copy the Github project URL into "GitHub project"  
  d. Under "Source Code Management," select Git and paste the URL into "Repository URL"  

2. Set up webhook  
  a. Natigate to GitHub project and click "Settings"  
  b. Under "Webhooks & Services," click "Add Service"  
  c. Select "Jenkins (GitHub plugin)" from the dropdown menu  
  d. In "Jenkins hook url" should be the url of the Jenkins server, appended with "**/github-webhook/**"  
  e. Ensure "Active" is checked  

3. Enable Build Trigger  
  a. Click on your job  
  b. Click on "Configure"  
  c. Under "Build Triggers," check "Build when a change is pushed to GitHub"  

#### GitHub Pull Request Builder Plugin Setup  
The following steps will allow our Jenkins job to automatically build any potential merges from a pull request and return either a 'passed' or 'failed' message.  

1. Install Jenkins Plugin  
		a. Click "Manage Jenkins"  
		b. Click "Manage Plugins"  
		c. Search for "**GitHub Pull Request Builder**" under the "Available" tab and click corresponding checkbox  
		d. Click "Install without restart"  

2. Set up webhook  
		a. Navigate to GitHub project and click "Settings"  
		b. Under "Webhooks & Services," click "Add webhook"  
		c. Fill out the fields as follows:
  * "Payload URL" should contain the url of the Jenkins server, appended with "**/ghprbhook/**" (had issue using https)  
  * "Content type" should be "**application/x-www-form-urlencoded**"  
  * Select "Let me select individual events" and choose "**Pull Request**" and "**Issue comment**"  
  * Ensure "Active" is checked  

3. Ensure Job settings are correct  
		a. Click on your job  
		b. Click on "Configure"  
		c. Under "Source Code Management," you should have Git selected with the appropriate Repository URL and credentials (not needed for public repositories).  
		d. Under the "Credentials" field, click on "Advanced" to reveal "Name" and "Refspec" which should be filled out with the correct alias of the remote repository (e.g. origin), and **+refs/pull\*:refs/remotes/origin/pr/\*** respectively.  
		e. Under "Build Triggers" section, check "Build when a change is pushed to GitHub" and "GitHub Pull Request Builder"  
		f. Ensure that "Use github hooks for build triggering" is checked, and that the proper admin account is listed in "Admin list"  

4. Add post-build action "Set build status on GitHub commit"  
