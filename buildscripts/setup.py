from setuptools import setup, find_packages
import sys, os

version = '.1'

setup(name='Builder',
      version=version,
      description="This is a build script for the OpenGeo Suite",
      long_description="""\
""",
      classifiers=[], # Get strings from http://pypi.python.org/pypi?%3Aaction=list_classifiers
      keywords='OpenGeo, Outreach',
      author='Outreach team',
      author_email='iwillig@opengeo.org',
      url='http://opengeo.org',
      license='MIT',
      packages=find_packages(exclude=['ez_setup', 'examples', 'tests']),
      include_package_data=True,
      zip_safe=True,
      install_requires=[
          # -*- Extra requirements: -*-
        "JSTools>=0.1.2",
        "urlgrabber",
        "Sphinx",
	"Paver"
      ],
      entry_points="""
      # -*- Entry points: -*-
      """,
      )
