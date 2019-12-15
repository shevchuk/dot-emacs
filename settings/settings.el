(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#272822" "#F92672" "#A6E22E" "#E6DB74" "#66D9EF" "#FD5FF0" "#A1EFE4" "#F8F8F2"])
 '(aw-dispatch-always t)
 '(coffee-tab-width 2)
 '(column-number-mode 1)
 '(comment-style (quote box-multi))
 '(compilation-message-face (quote default))
 '(css-indent-offset 2)
 '(custom-enabled-themes (quote (cyberpunk)))
 '(custom-safe-themes
   (quote
    ("3cd28471e80be3bd2657ca3f03fbb2884ab669662271794360866ab60b6cb6e6" "58c6711a3b568437bab07a30385d34aacf64156cc5137ea20e799984f4227265" "2925ed246fb757da0e8784ecf03b9523bccd8b7996464e587b081037e0e98001" "e0d42a58c84161a0744ceab595370cbe290949968ab62273aed6212df0ea94b4" "987b709680284a5858d5fe7e4e428463a20dfabe0a6f2a6146b3b8c7c529f08b" "1a1cdd9b407ceb299b73e4afd1b63d01bbf2e056ec47a9d95901f4198a0d2428" "a2afb83e8da1d92f83543967fb75a490674a755440d0ce405cf9d9ae008d0018" "980f0adf3421c25edf7b789a046d542e3b45d001735c87057bccb7a411712d09" "aaffceb9b0f539b6ad6becb8e96a04f2140c8faa1de8039a343a4f1e009174fb" "d9129a8d924c4254607b5ded46350d68cc00b6e38c39fc137c3cfb7506702c12" "66aea5b7326cf4117d63c6694822deeca10a03b98135aaaddb40af99430ea237" "5cd0afd0ca01648e1fff95a7a7f8abec925bd654915153fb39ee8e72a8b56a1f" "946e871c780b159c4bb9f580537e5d2f7dba1411143194447604ecbaf01bd90c" "c79c2eadd3721e92e42d2fefc756eef8c7d248f9edefd57c4887fbf68f0a17af" "c616e584f7268aa3b63d08045a912b50863a34e7ea83e35fcab8537b75741956" "228c0559991fb3af427a6fa4f3a3ad51f905e20f481c697c6ca978c5683ebf43" "158013ec40a6e2844dbda340dbabda6e179a53e0aea04a4d383d69c329fba6e6" "d21135150e22e58f8c656ec04530872831baebf5a1c3688030d119c114233c24" "9b1c580339183a8661a84f5864a6c363260c80136bd20ac9f00d7e1d662e936a" "de0b7245463d92cba3362ec9fe0142f54d2bf929f971a8cdf33c0bf995250bcf" "003a9aa9e4acb50001a006cfde61a6c3012d373c4763b48ceb9d523ceba66829" "e30f381d0e460e5b643118bcd10995e1ba3161a3d45411ef8dfe34879c9ae333" "5a7830712d709a4fc128a7998b7fa963f37e960fd2e8aa75c76f692b36e6cf3c" "4bf5c18667c48f2979ead0f0bdaaa12c2b52014a6abaa38558a207a65caeb8ad" "73ad471d5ae9355a7fa28675014ae45a0589c14492f52c32a4e9b393fcc333fd" "cf284fac2a56d242ace50b6d2c438fcc6b4090137f1631e32bedf19495124600" "af717ca36fe8b44909c984669ee0de8dd8c43df656be67a50a1cf89ee41bde9a" "962dacd99e5a99801ca7257f25be7be0cebc333ad07be97efd6ff59755e6148f" "da538070dddb68d64ef6743271a26efd47fbc17b52cc6526d932b9793f92b718" "251348dcb797a6ea63bbfe3be4951728e085ac08eee83def071e4d2e3211acc3" "6db9acac88c82f69296751e6c6d808736d6ff251dcb34a1381be86efc14fef54" "d6db7498e2615025c419364764d5e9b09438dfe25b044b44e1f336501acd4f5b" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" "b9e9ba5aeedcc5ba8be99f1cc9301f6679912910ff92fdf7980929c2fc83ab4d" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "84d2f9eeb3f82d619ca4bfffe5f157282f4779732f48a5ac1484d94d5ff5b279" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "5d5bc275d76f782fcb4ca2f3394031f4a491820fd648aed5c51efc15d472562e" "5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "9956eace4d6a1df9bd8c5875406c3dab0b98dd385d3bc99a83aaf730526a6056" "f81933744f47a010213537575f84085af3937b27748b4f5c9249c5e100856fc5" "75c0b9f9f90d95ac03f8647c75a91ec68437c12ff598e2abb22418cd4b255af0" "3fb38c0c32f0b8ea93170be4d33631c607c60c709a546cb6199659e6308aedf7" "51e228ffd6c4fff9b5168b31d5927c27734e82ec61f414970fc6bcce23bc140d" "03f28a4e25d3ce7e8826b0a67441826c744cbf47077fb5bc9ddb18afe115005f" "e8825f26af32403c5ad8bc983f8610a4a4786eb55e3a363fa9acb48e0677fe7e" "e9776d12e4ccb722a2a732c6e80423331bcb93f02e089ba2a4b02e85de1cf00e" "3d5ef3d7ed58c9ad321f05360ad8a6b24585b9c49abcee67bdcbb0fe583a6950" "46fd293ff6e2f6b74a5edf1063c32f2a758ec24a5f63d13b07a20255c074d399" "72a81c54c97b9e5efcc3ea214382615649ebb539cb4f2fe3a46cd12af72c7607" "3cc2385c39257fed66238921602d8104d8fd6266ad88a006d0a4325336f5ee02" "9b59e147dbbde5e638ea1cde5ec0a358d5f269d27bd2b893a0947c4a867e14c1" "76626efc044daee1c402e50f185bd633d1a688c332bc15c8fd5db4cdf2966b79" "d9046dcd38624dbe0eb84605e77d165e24fdfca3a40c3b13f504728bab0bf99d" "05c3bc4eb1219953a4f182e10de1f7466d28987f48d647c01f1f0037ff35ab9a" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "04dd0236a367865e591927a3810f178e8d33c372ad5bfef48b5ce90d4b476481" "7153b82e50b6f7452b4519097f880d968a6eaf6f6ef38cc45a144958e553fbc6" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" "d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "5d9351cd410bff7119978f8e69e4315fd1339aa7b3af6d398c5ca6fac7fd53c7" "45bd43da80a95b4f5157b1992350eb4207025bdeefb55c68548dcb34bf403124" default)))
 '(diredp-hide-details-initially-flag nil)
 '(ecb-options-version "2.50")
 '(elfeed-feeds
   (quote
    ("http://promodj.com/artdmitriev/podcast.xml"
     ("http://alkatrion.com/?feed=rss2" velo)
     ("http://nullprogram.com/feed/" emacs)
     ("http://habrahabr.ru/rss/company/kolibrios/blog/" kolibri)
     ("http://planet.emacsen.org/atom.xml" emacs)
     ("http://emacsredux.com/atom.xml" emacs)
     ("karl-voit.at/feeds/lazyblorg-all.atom_1.0.links-only.xml" emacs)
     ("http://sachachua.com/blog/category/geek/emacs/feed/" emacs))) t)
 '(fci-rule-color "#49483E")
 '(flycheck-javascript-eslint-executable "/usr/bin/eslint")
 '(highlight-changes-colors ("#FD5FF0" "#AE81FF"))
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#49483E" . 100))))
 '(jiralib-url "http://jira.ringcentral.com" t)
 '(js-indent-level 2)
 '(magit-diff-arguments (quote ("--no-ext-diff" "--stat")))
 '(magit-diff-section-arguments (quote ("--no-ext-diff" "-U1")))
 '(magit-diff-use-overlays nil)
 '(multi-eshell-name "*eshell*")
 '(multi-eshell-shell-function (quote (eshell)))
 '(org-capture-templates
   (quote
    (("w" "Work Todo" entry
      (file+headline "~/Documents/personal-notes/work.org" "Tasks")
      "* TODO %?
  %i
  %a")
     ("p" "Personal" entry
      (file+headline "~/Documents/personal-notes/personal.org" "Tasks")
      "* TODO %?
 %i
"))) t)
 '(org-ditaa-jar-path "/Users/mico/.emacs.d/contrib/ditaa/ditaa0_9.jar")
 '(org-refile-targets
   (quote
    (("~/Documents/personal-notes/today.org" :todo . "")
     ("~/Documents/personal-notes/this_week.org" :maxlevel . 9)
     ("~/Documents/personal-notes/later.org" :maxlevel . 9)
     ("~/Documents/personal-notes/test_automation.org" :maxlevel . 9))) t)
 '(org-yandex-weather-format "%C: %i %c, [%l,%h]%s %d%w")
 '(package-selected-packages
   (quote
    (vterm lsp-mode counsel-etags gherkin-mode flow-minor-mode mood-line add-node-modules-path espresso-theme kaolin-themes panda-theme edit-indirect ssass-mode vue-html-mode pretty-symbols lab-themes eruby-mode swap-regions jira-markup-mode rjsx-mode company company-tern tern-auto-complete tern js2-refactor dracula-theme easy-kill anti-zenburn-theme airline-themes annoying-arrows-mode mode-icons rainbow-mode unbound web-server jsx-mode multi-eshell super-save)))
 '(projectile-globally-ignored-directories
   (quote
    (".idea" ".eunit" ".git" ".hg" ".fslckout" ".bzr" "_darcs" ".tox" ".svn" ".stack-work" "./dist/" "./node_modules/" "./src/bower_components/")))
 '(projectile-globally-ignored-file-suffixes (quote (".jar" ".zip" ".exe" ".min.js")))
 '(select-enable-primary nil)
 '(sml/mode-width
   (if
       (eq
        (powerline-current-separator)
        (quote arrow))
       (quote right)
     (quote full)))
 '(sml/pos-id-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote powerline-active2))))
     (:propertize " " face powerline-active2))))
 '(sml/pos-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active1)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active1)
                   (quote sml/global))))
     (:propertize " " face sml/global))))
 '(sml/pre-id-separator
   (quote
    (""
     (:propertize " " face sml/global)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (car powerline-default-separator-dir)))
                   (quote sml/global)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-minor-modes-separator
   (quote
    (""
     (:propertize " " face powerline-active2)
     (:eval
      (propertize " "
                  (quote display)
                  (funcall
                   (intern
                    (format "powerline-%s-%s"
                            (powerline-current-separator)
                            (cdr powerline-default-separator-dir)))
                   (quote powerline-active2)
                   (quote powerline-active1))))
     (:propertize " " face powerline-active1))))
 '(sml/pre-modes-separator (propertize " " (quote face) (quote sml/modes)))
 '(sqlplus-command "/opt/oracle/instantclient/sqlplus")
 '(tool-bar-mode nil)
 '(typescript-indent-level 2)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#F92672")
     (40 . "#CF4F1F")
     (60 . "#C26C0F")
     (80 . "#E6DB74")
     (100 . "#AB8C00")
     (120 . "#A18F00")
     (140 . "#989200")
     (160 . "#8E9500")
     (180 . "#A6E22E")
     (200 . "#729A1E")
     (220 . "#609C3C")
     (240 . "#4E9D5B")
     (260 . "#3C9F79")
     (280 . "#A1EFE4")
     (300 . "#299BA6")
     (320 . "#2896B5")
     (340 . "#2790C3")
     (360 . "#66D9EF"))))
 '(vc-annotate-very-old-color nil)
 '(vue-html-extra-indent 2)
 '(web-mode-markup-indent-offset 2)
 '(weechat-color-list
   (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0")))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(mode-line ((((min-colors 16777216)) (:foreground nil :background "#44475a" :box "#44475a")) (t (:foreground nil :background "#44475a" :box "#44475a"))))
 '(whitespace-space ((t (:foreground "DarkOliveGreen")))))
