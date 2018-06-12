require './rally_deploy.rb'
require './deployment.rb'
require './deployment_log.rb'


#######################
# Get the path to the repository from environment variable
rally_repo_path = ENV['rally_repo_path']

# Execute a shell command to read the git repository log
# this command outputs a log with each commit, commit hash, commit date, and files changed
# clearly marked with special delimiters. (ex. COMMIT HASH:xxx DATE:xxxx FILES:xxxxx)
git_log = `cd #{rally_repo_path};  git log --name-only --pretty=tformat:'COMMIT HASH:%H DATE:%cd FILES:'/`

# parse the log into an array of commit objects
commits = RallyDeploy::parse_log(git_log)

# get the deployment log.  This is a log file generated by this script which tracks
# a history of what has been deployed.  Using this log we can determine what changes
# in the repo have not yet been deployed.
deployment_log = RallyDeploy::get_deployment_log()

# Determine which commits are new and contain changes that need to be deployed
commits_deploying = RallyDeploy::determine_commits_to_deploy(deployment_log, commits)

if commits_to_deploy
  # load the presets for those commits
  presets_to_deploy = RallyDeploy::load_presets_for_commits(commits_deploying, rally_repo_path)

  # Create a deployment.  This prepares and manages the deployment process.
  deployment = Deployment.new(presets_to_deploy)

  # Deploy the files to the specified rally environment
  deployment.deploy()

  # Save the latest commit hash to the log
  deployment_log.add_deployment_to_log(commits_deploying, deployment.get_results)

  RallyDeploy::update_deploy_log(deployment_log)
end
