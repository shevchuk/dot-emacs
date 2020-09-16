;;On a gitflow-based branching model, (feature-)branches created by Bitbucket based on Jira issues (which are always in the form UPPERCASEALPHA-DIGITS), i use this to automatically insert the current issue number
(defun gh-jira-git-commit-setup ()
  (let ((ISSUEKEY "[[:upper:]]+-[[:digit:]]+"))
    (when (string-match-p ISSUEKEY (magit-get-current-branch))
      (insert
       (replace-regexp-in-string
        (concat ".*?\\(" ISSUEKEY "\\).*")
        "\\1 "
        (magit-get-current-branch))))))

(add-hook 'git-commit-setup-hook 'gh-jira-git-commit-setup)

(provide 'magit-tools)
