# VSee Web Testing Framework

Automated end-to-end tests for VSee's video call and chat features using Robot Framework and Selenium. Supports running tests locally, with Selenium Grid (multi-machine), and includes a GitHub API test suite.

---

## 1. Prerequisites

- **Python 3.8+**
- **pip** (Python package manager)
- **Google Chrome** (or compatible browser)
- **ChromeDriver** (matching your Chrome version, add to PATH)
- **Docker** (for Selenium Grid)
- **Java** (for Selenium Standalone Server)

---

## Project Structure

The repository is organized as follows:

```
├── locator/                    # Element locators for Robot Framework tests
│   ├── patient_page.robot
│   ├── provider_page.robot
│   └── video_call_page.robot
├── pages/                      # Page object files for Robot Framework
│   ├── browser.robot
│   ├── patient_page.robot
│   ├── provider_page.robot
│   └── video_call_page.robot
├── steps/                      # Step definitions for test cases
│   └── chat_call_steps.robot
├── tests/                      # Test suites
│   ├── chat_call_flow.robot
│   └── github_api_test.robot
├── variables/                  # Variable files for configuration
│   └── env_variables.robot

```
---

## 2. Installation

1. **Clone this repository**  
   ```bash
   git clone <your-repo-url>
   cd vsee
   ```

2. **Install Python dependencies**  
   ```bash
   pip install -r requirements.txt
   ```

3. **(Optional) Download Selenium Standalone Server**  
   Already included: `selenium-server-4.33.0.jar`

---

## 3. Configuration

Edit `variables/env_variables.robot` and set:
- `${ROOM_URL}`: The meeting room URL
- `${PROVIDER_USERNAME}` / `${PROVIDER_PASSWORD}`: Provider credentials
- `${GITHUB_ORG}`: GitHub organization to analyze (e.g., `SeleniumHQ`)

---

## 4. Test Cases

### A. Local Test (Single Machine)

Simulates a call between userA (patient) and userB (provider) in two browser windows.

**Run:**
```bash
robot --test "User Chat Call Flow In Local" tests/chat_call_flow.robot
```

**What it does:**
- Opens `${ROOM_URL}` as userA (patient) and enters waiting room.
- Opens `${ROOM_URL}` as userB (provider), logs in, and calls userA.
- userB sends a chat message; verifies userA receives it.
- userB ends the call, then userA ends the call.

---

### B. Selenium Grid Test (Distributed / Multi-Machine)

You can run tests across multiple machines or containers using Selenium Grid. There are two main options:

#### B1. Local Grid (Manual/Standalone)

Start the Selenium Grid manually (e.g., with `run-grid.sh`), then run the test case for local grid:

```bash
robot --test "User Chat Call Flow With Local Grid (Different Machine)" tests/chat_call_flow.robot
```

#### B2. Docker Grid

Start the Selenium Grid using Docker Compose, then run the test case for Docker grid:

```bash
docker-compose -f docker-compose.yml pull
robot --test "User Chat Call Flow With Docker Grid (Different Machine)" tests/chat_call_flow.robot
```

**Note:**  
- Ensure Docker is installed and running on your machine.  
- If you have issues pulling images, adjust `platform: linux/amd64` in `docker-compose.yml` to match your system.  
- You can customize grid nodes in the `grid_config/` folder.  
- For multi-machine setups, make sure all nodes can reach the hub and access the test files.

---

### C. GitHub API Test

Retrieves and analyzes repository data from a GitHub organization (e.g., SeleniumHQ).

**Run:**
```bash
robot tests/github_api_test.robot
```

**What it does:**
- Counts total open issues across all repos.
- Sorts repos by last updated (descending).
- Finds the repo with the most watchers.

**Config:**  
- Organization is set via `${GITHUB_ORG}` in `variables/env_variables.robot`.
- No authentication needed for public orgs, but you can add a GitHub token for higher rate limits.

---

## 5. Custom Keywords & Locators

- Custom Python keywords: `custom_libs/JsClickKeyword.py`
- Page objects & locators: `pages/`, `locator/`

---

## 6. Troubleshooting

- **ChromeDriver not found:**  
  Download from https://chromedriver.chromium.org/downloads and add to your PATH.
- **Docker issues:**  
  Ensure Docker is running and ports are not blocked.
- **Variable errors:**  
  Double-check `variables/env_variables.robot` for correct URLs and credentials.

---

## 7. References

- [Robot Framework User Guide](https://robotframework.org/robotframework/latest/RobotFrameworkUserGuide.html)
- [Selenium Grid Docs](https://www.selenium.dev/documentation/grid/)
- [GitHub REST API](https://docs.github.com/en/rest)

---

## 8. Contact

This submission was completed by Phuc Vo.
If you have any questions or issues, please contact me at nhuphuc1602@gmail.com.

You may find the code on GitHub or request a zip file if needed.
