runtime_requirements = [
    'flask'
]

minimum_python_version = (3, 5, 0)

from setuptools import find_packages, setup
from sys import version_info


if version_info[:3] < minimum_python_version:
    raise RuntimeError(
        'Unsupported python version {}. Please use {} or newer'.format(
            '.'.join(map(str, version_info[:3])),
            '.'.join(map(str, minimum_python_version)),
        )
    )


setup(
    install_requires=runtime_requirements,
    name='my_app',
    packages=find_packages(),
)
