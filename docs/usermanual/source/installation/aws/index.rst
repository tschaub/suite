.. _installation.aws:

Installing the OpenGeo Suite for Amazon EC2
===========================================

The OpenGeo Suite is available as a AMI for use with Amazon's EC2 service.  The OpenGeo Suite is available in five tiers:

* Dev Small, $0.13/hr, no setup fee.
* Dev Large, $0.45/hr, no setup fee.
* Production 1 Small, $600/month, $500 setup fee.
* Production 2 Medium, $800/month, $750 setup fee.
* Production 3 Large, $1,150/month, $1000 setup fee.

The process for signing up for any of these tiers is exactly the same.  Only the features and pricing differ.

Signing up
----------

In order to use the OpenGeo Suite Cloud Edition for Amazon Web Services, you need to have an **Amazon Web Services** (AWS) account which has EC2 access enabled.

.. note:: Amazon has detailed instructions on how to sign up for AWS/EC2 at http://aws.amazon.com/documentation/ec2/.

#. Navigate to the OpenGeo Suite Cloud page at http://opengeo.org/products/suite/cloud/. On the Amazon Web Services column, select the tier you wish to purchase by clicking the appropriate link.

   IMAGE

#. You will be redirected to Amazon's site, and asked to log in to AWS.  Enter your AWS account name and password and click :guilabel:`Sign in using our secure server`.

   .. note:: Amazon has detailed instructions on how to sign up for EC2 at http://aws.amazon.com/documentation/ec2/.

   .. figure:: img/signin.png
      :align: center

      *Signing in to AWS*

#. You will see a description of the product, including all initial and recurring charges.  Please review the information, and then click :guilabel:`Place your order`.

   .. warning:: By clicking :guilabel:`Place your order`, you are committing to any charges associated with your purchase.

   .. figure:: img/placeyourorder.png
      :align: center

      *Reviewing order*

#. Once the sale is completed you will be redirected to an OpenGeo registration page.  Fill out the form to sign up for the OpenGeo support included as part of your purchase.  When done, click :guilabel:`Submit`.

   .. note:: This step is necessary in order to receive support from OpenGeo.

   IMAGE

#. You will soon receive an email from OpenGeo containing helpful information, links, and other details about your purchase.  YES, WE STILL NEED TO WRITE THIS.

Logging in
----------

The next step is to launch your new OpenGeo Suite Cloud instance.  This is done through Amazon's AWS console.

#. Navigate to http://aws.amazon.com.  Click on the link on the top that says :guilabel:`Sign in to the AWS Management Console`.  To log in, use the same credentials you used when purchasing the OpenGeo Suite.

#. You will be redirected to your main AWS console.

   .. figure:: img/firstsignins3.png
      :align: center

      *Viewing the default AWS console*

#. Click on the EC2 tab.

   .. figure:: img/firstsigninec2.png
      :align: center

      *AWS EC2 console*

#. Click on :guilabel:`AMIs` to see the list of products in your account.  You should see an OpenGeo Suite instance in the list.  Select the instance and then click the :guilabel:`Launch` button.

   IMAGE

#. A dialog box will display asking for details.  Make sure that :guilabel:`Launch Instances` is selected, but you should not need to change any settings here.  Click :guilabel:`Continue`.

   .. figure:: img/requestinstance-instancetype.png
      :align: center

      *Launching an instance*

#. On the next page (Advanced Instance options), leave the default settings blank, and click :guilabel:`Continue`.

   .. figure:: img/requestinstance-advanced.png
      :align: center

      *Advanced instance details*

#. The next page allows for the creation of a tag for organization.  This step is optional.  Click :guilabel:`Continue`.

   .. figure:: img/requestinstance-tags.png
      :align: center

      *Tag creation page*

#. You will be asked to create a key pair.  This is used to be able to securely connect to the instance after it launches.  Enter a name for your key pair, then download it to your local machine, keeping it in a safe place.  When done, click :guilabel:`Continue`.

   .. figure:: img/requestinstance-keypair.png
      :align: center

      *Creating a keypair*

#. In order to open the proper ports for accessing the OpenGeo Suite, it is necessary to create a security group.  From this page, click on :guilabel:`Create a New Security Group`.

   .. figure:: img/requestinstance-security.png
      :align: center

      *Security Group page*

   .. figure:: img/requestinstance-newsecgroup.png
      :align: center

      *New Security Group page*

#. On the New Security Group page, enter a :guilabel:`Group Name` and `Group Description` ("Ports" for both is fine).  Create two new rules, both :guilabel:`Custom TCP rules`.  the first rule should have a :guilabel:`Port range` of "80" and :guilabel:`Source` of "0.0.0.0/0".  The second rule should have a :guilabel:`Port range` of "8080" and :guilabel:`Source` of "0.0.0.0/0".  Add the two rules then click :guilabel:`Continue`.

   .. figure:: img/requestinstance-newsecgroupfinal.png
      :align: center

      *Creating a new Security Group*




#. Verify that the setting are correct, then click :guilabel:`Launch`.

   .. figure:: img/requestinstance-review.png
      :align: center

      *Reviewing settings*

#. Now close out of the dialog box and click on the :guilabel:`Instances` link on the left hand column.  You should see your instance in the process of being generated.

   .. figure:: img/instancepending.png
      :align: center

      *New instance pending*

#. When the instance is fully generated, click on it to see the instance details.  

   .. figure:: img/instancedetails.png
      :align: center

      *New instance pending*

#.  Note the Public DNS entry.  Use this to connect to the OpenGeo Suite Dashboard and begin using the OpenGeo Suite.  In a new browser window, type the following URL::

       http://<Public DNS ENTRY>:8080/dashboard/

    For example::

       http://ec2-174-129-64-92.compute-1.amazonaws.com:8080/dashboard/

   This will launch the Dashboard.

   .. figure:: img/instancedetails.png
      :align: center

      *OpenGeo Suite Dashboard, showing a successful installation*

You are now set up and ready to go!

For More Information
--------------------

Please contact inquiry@opengeo.org for more information.