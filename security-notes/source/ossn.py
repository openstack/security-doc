# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or
# implied.
# See the License for the specific language governing permissions and
# limitations under the License.

import glob
import os
import re

from jinja2 import FileSystemLoader
from jinja2.environment import Environment
import yaml

from sphinx.util import logging

LOG = logging.getLogger(__name__)


def to_snake_case(d):
    for k in dict(d):
        v = d[k]
        del d[k]
        d[k.replace('-', '_')] = v
        if type(k) == dict:
            to_snake_case(d)


def format_code_blocks(value):
    """Convert ---- begin/end example markers to RST literal code blocks."""
    if not value:
        return value

    def replace_block(match):
        content = match.group(1).strip()
        indented = '\n'.join(
            '  ' + line if line.strip() else ''
            for line in content.split('\n')
        )
        return '::\n\n' + indented + '\n'

    result = re.sub(
        r'[-\u2014]{2,}\s*begin[^-\u2014]*[-\u2014]{2,}\s*\n(.*?)[-\u2014]{2,}\s*end[^-\u2014]*[-\u2014]{2,}',
        replace_block,
        value,
        flags=re.DOTALL | re.IGNORECASE
    )
    return result


def render_template(template, data, **kwargs):
    template_dir = kwargs.get('template_dir', os.getcwd())
    loader = FileSystemLoader(template_dir)
    env = Environment(trim_blocks=True, loader=loader)
    env.filters["format_code_blocks"] = format_code_blocks
    template = env.get_template(template)
    return template.render(**data)


def render(source, template, **kwargs):
    vals = yaml.safe_load(open(source).read())
    to_snake_case(vals)
    return render_template(template, vals, **kwargs)


def build_notes(app):
    template_name = "ossn.jinja"
    template_files = os.path.join(".", "security-notes", "source")
    yaml_files = os.path.join(".", "security-notes")
    input_files = sorted(
        glob.glob(os.path.join(yaml_files, "OSSN-*.yaml")),
        reverse=True
    )
    output_files = [
        x.replace(yaml_files, os.path.join(".", "security-notes", "source"))
        .replace(".yaml", ".rst")
        for x in input_files
    ]
    for old, new in zip(input_files, output_files):
        with open(new, "w") as out:
            out.write(render(old, template_name, template_dir=template_files))

    # Write index.rst with reverse-sorted entries
    index_path = os.path.join(".", "security-notes", "source", "index.rst")
    ossn_names = [
        os.path.basename(f).replace(".yaml", "")
        for f in input_files
    ]
    with open(index_path, "w") as idx:
        idx.write(render_template("index.jinja",
                                  {"ossn_names": ossn_names},
                                  template_dir=template_files))

def setup(app):
    LOG.info('Loading the ossn extension')
    app.connect('builder-inited', build_notes)
