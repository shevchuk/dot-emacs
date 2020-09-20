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

;; git shows branch + changes
(defadvice vc-git-mode-line-string (after plus-minus (file) compile activate)
  (setq ad-return-value
    (concat ad-return-value
            (let ((plus-minus (vc-git--run-command-string
                               file "diff" "--numstat" "--")))
              (and plus-minus
                   (string-match "^\\([0-9]+\\)\t\\([0-9]+\\)\t" plus-minus)
                   (format " +%s-%s" (match-string 1 plus-minus) (match-string 2 plus-minus)))))))

(setq vc-svn-diff-switches "-x --ignore-eol-style")

(provide 'magit-tools)
