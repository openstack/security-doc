#!/bin/bash -xe

#
# Licensed under the Apache License, Version 2.0 (the "License"); you may
# not use this file except in compliance with the License. You may obtain
# a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
# License for the specific language governing permissions and limitations
# under the License.

DOCNAME=$1

if [ -z "$DOCNAME" ] ; then
    echo "usage $0 DOCNAME"
    exit 1
fi

# We're not doing anything for this directory.
if [[ "$DOCNAME" = "common" ]] ; then
    exit 0
fi

rm -f $DOCNAME/source/locale/$DOCNAME.pot
sphinx-build -b gettext $DOCNAME/source/ $DOCNAME/source/locale/

# common is translated as part of openstack-manuals, do not
# include the file in the combined tree.
rm $DOCNAME/source/locale/common.pot

# Take care of deleting all temporary files so that git add
# doc/$DOCNAME/source/locale will only add the single pot file.
msgcat --sort-by-file $DOCNAME/source/locale/*.pot \
  > $DOCNAME/source/$DOCNAME.pot
rm  $DOCNAME/source/locale/*.pot
rm -rf $DOCNAME/source/locale/.doctrees/
mv $DOCNAME/source/$DOCNAME.pot $DOCNAME/source/locale/$DOCNAME.pot
