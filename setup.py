from setuptools import setup,find_packages

setup(
    name='rambler.web_console',
    version = '0.2',
    description='Management console for rambler apps',
    author='Scott Robertson',
    author_email='srobertson@codeit.com',
    #package_dir = {'': 'src'},
    packages = find_packages(),
    install_requires = ['rambler.net']
)
