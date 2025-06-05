import requests

def get_all_open_issues(user_or_org):
    repos = requests.get(f"https://api.github.com/users/{user_or_org}/repos").json()
    total_issues = 0
    for repo in repos:
        issues = requests.get(repo['issues_url'].replace("{/number}", "")).json()
        total_issues += len([i for i in issues if 'pull_request' not in i])
    return total_issues

def get_sorted_repos_by_update(user_or_org):
    repos = requests.get(f"https://api.github.com/users/{user_or_org}/repos").json()
    return sorted(repos, key=lambda r: r['updated_at'], reverse=True)

def get_repo_with_most_watchers(user_or_org):
    repos = requests.get(f"https://api.github.com/users/{user_or_org}/repos").json()
    return max(repos, key=lambda r: r['watchers_count'])
