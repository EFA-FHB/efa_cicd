## gradle_xray_test

This action executes automated tests using gradle and uploads test result to JIRA.

## Inputs

### `app`
**Required** Name of application to test.

### `xray-send-reports-to-jira`
Whether to submit XRAY Test-Reports to JIRA

### `xray-ghp-token`
**Required** Token to fetch [xray-junit-extension](https://github.com/Xray-App/xray-junit-extensions) from Github

### `xray-api-username`
Value used as `username` when uploading test results to JIRA

### `xray-api-password`
Value used as `password` when uploading test results to JIRA

### `xray-testplan-key`
Value used for identifying the JIRA Testplan when uploading test results to JIRA

### `xray-project-key`
Value used for identifying the JIRA Project when uploading test results to JIRA

## Outputs
none

## Usage

Building image with additonal tags

<pre>
      - name: install_shared_actions
        uses: ./.github/actions/install_shared_actions
        with:
          token: ${{secrets.REPO_ACCESS_TOKEN}}
          
      - name: run tests
        id: run_tests
        uses: ./.github/actions/shared/gradle_xray_test
        with:
          app: vergabesystem-adapter
          xray-send-reports-to-jira: ${{ github.ref == 'refs/heads/main' }}
          xray-ghp-token: ${{ secrets.GHP_XRAY_TOKEN }}
          xray-api-username: ${{ secrets.XRAY_API_TESTREPORT_USERNAME }}
          xray-api-password: ${{ secrets.XRAY_API_TESTREPORT_PASSWORD }}
          xray-testplan-key: ${{ env.XRAY_TESTPLAN_KEY }}
          xray-project-key: ${{ env.XRAY_PROJECT_KEY }}
</pre>