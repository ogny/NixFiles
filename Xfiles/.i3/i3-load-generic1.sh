  # Load the layout
  i3-msg 'workspace 1; append_layout /home/orkung/.i3/workspace-1.json'
  
  # Swallow the programs into the containers
  urxvt &
  google-chrome
