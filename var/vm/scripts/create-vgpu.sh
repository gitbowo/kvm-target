#!/bin/bash
envconfig="/var/vm/scripts/env.sh"
if [[ $EUID -ne 0 ]]; then
        echo "This script must be run by superuser."
        exit 1
fi

if [ -f $envconfig ]; then
        source $envconfig
else
        echo "Could not find necessary environment setting."
        exit 1
fi
# Setting VGPU mask
/bin/sh -c "echo $MASK > /sys/class/drm/card0/gvt_disp_ports_mask"
# iterate through vgpu uuid and create uuid
for uuid in $VGPUS
do
        /bin/sh -c "echo $uuid > ${BASEVGPU}/mdev_supported_types/${VGPU_TYPE}/create"
done

