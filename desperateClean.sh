#!/bin/bash

function oldVersions {
    echo "Performing oldVersions..."
    
    # Show free space
    df -Th | grep -v fs
        
    # Remove old versions of snap packages
    snap list --all | while read snapname ver rev trk pub notes; do
        if [[ $notes == *disabled* ]]; then
            snap remove "$snapname" --revision="$rev"
        fi
    done
    
    # Set snap versions retain settings
    if [[ $(snap get system refresh.retain) -ne 2 ]]; then
        snap set system refresh.retain=2
    fi
    rm -f /var/lib/snapd/cache/*
    
    # Remove old versions of Linux Kernel
    dpkg --list | grep 'linux-image' | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p' | xargs apt-get -y purge
    dpkg --list | grep 'linux-headers' | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p' | xargs apt-get -y purge
    
    # Rotate and delete old logs
    /etc/cron.daily/logrotate
    find /var/log -type f -iname '*.gz' -delete
    journalctl --rotate
    journalctl --vacuum-time=1s
    
    # Show free space again
    df -Th | grep -v fs
}

function desperate {
    echo "Performing Desperate Clean..."
    
    # Purge packages marked for removal
    sudo apt-get purge $(dpkg -l | awk '/^rc/{print $2}')
    
    # Remove dpkg backup files
    sudo find /etc -type f -name "*.dpkg-*" -exec rm {} \;
    
    # Remove compressed and rotated logs
    sudo find /var/log -type f -name "*.gz" -exec rm {} \;
    sudo find /var/log -type f -name "*.1" -exec rm {} \;
    
    # Clean Trash directories
    sudo rm -rf ~/.local/share/Trash/*
    
    # Remove backup files in ~/.config
    sudo rm -rf ~/.config/*.bak
    
    # Clean temporary files
    sudo rm -rf /tmp/*
    
    # Show free space again
    sudo df -Th | grep -v fs
}

while :
do
    echo "=========================="
    echo "1. Clear RAM"
    echo "2. Clear old apt packages"
    echo "3. Clear systemd journal logs"
    echo "4. Show old Linux kernel versions"
    echo "5. Old Versions Clean"
    echo "6. Desperate Clean"
    echo "0. Exit"
    
    read -p "Select an option: " option
    echo ""

    case $option in
        0)  exit 0;;
        1)  sync; echo 1 > /proc/sys/vm/drop_caches
            sync; echo 2 > /proc/sys/vm/drop_caches
            sync; echo 3 > /proc/sys/vm/drop_caches;;
        2)  sudo apt-get autoremove
            sudo apt-get autoclean
            sudo apt-get clean
            read -p "Remove /var/cache/apt? [y/n]: " userinput
            case $userinput in 
                [Yy]*) sudo apt-get clean;;
                [Nn]*) ;;
                *) echo "No available option.";;
            esac;;
        3)  journalctl --disk-usage
            read -p "Remove? [y/n]: " userinput
            case $userinput in 
                [Yy]*) sudo journalctl --vacuum-time=3d;;
                [Nn]*) ;;
                *) echo "No available option.";;
            esac;;
        4)  dpkg --get-selections | grep linux-image;;
        5)  myclean;;
        6)  desperate;;
        *)  echo "$option - No available option."
            read option;;
    esac
done