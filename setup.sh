#!/bin/bash

# Script for setting up a fresh install of eclipse in my way

# fix the tab sizes
GTK=$(cat <<EOF
style "compact-toolbar" \n
{\n
  GtkToolbar::internal-padding = 0\n
  xthickness = 1\n
  ythickness = 1\n
}\n
\n
style "compact-button"\n
{\n
  xthickness = 0\n
  ythickness = 0\n
}\n
\n
class "GtkToolbar"   				style "compact-toolbar" \n
widget_class "*<GtkToolbar>*<GtkButton>"	style "compact-button" \n
EOF
)

echo -e $GTK > ~/.gtkrc-2.0-eclipse

STARTUP=$(cat <<EOF
#!/bin/sh \n
export GTK2_RC_FILES=$HOME/.gtkrc-2.0-eclipse \n
exec /opt/eclipse/eclipse "\$@" \n
EOF
)

echo -e $STARTUP > /opt/eclipse/eclipse.sh
chmod +x /opt/eclipse/eclipse.sh

# copy in runtime settings
mkdir -p ~/workspace
cp -r .metadata ~/workspace/
#cp -r .settings ~/workspace/.metadata/.plugins/org.eclipse.core.runtime/

# update memory allowance
sed -i 's/Xmx512m/Xmx8000m/g' /opt/eclipse/eclipse.ini
