  # Load the layout
  i3-msg 'workspace 3; append_layout /home/orkung/.i3/workspace-2.json'
  
  # Swallow the programs into the containers
  urxvt &
  google-chrome
