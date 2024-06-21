from atlassian import Jira
from atlassian_tools.utilities import Issue
from config.secrets import JiraSecrets

epanda_jira = Jira(
    url=JiraSecrets.URL,
    username=JiraSecrets.USERNAME,
    password=JiraSecrets.PASSWORD,
    cloud=True,
)


issue: dict = epanda_jira.issue("EP-59")
for key, value in issue.items():
    print(f"{key}: {value}")
    if key == "fields":
        for field, field_value in value.items():
            print(f"\t{field}: {field_value}")
