## setup_jdk_17

Downloads and configures JDK 17 on the Github Actions runner.

##Inputs
none

##Outputs
none

##Usage

<pre>
      - name: install_shared_actions
        uses: ./.github/actions/install_shared_actions
        with:
          token: ${{secrets.REPO_ACCESS_TOKEN}}

      - name: Project setup
        uses: ./.github/actions/shared/setup_jdk_17
</pre>


