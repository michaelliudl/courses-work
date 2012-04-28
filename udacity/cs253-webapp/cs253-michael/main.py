#!/usr/bin/env python
#
# Copyright 2007 Google Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
import webapp2
import logging
import re

demo_form='''
<form method="post">
  What is your birthday?
  <br>
  <label>
    Month
    <input type="text" name="month">
  </label>
  <label>
    Day 
    <input type="text" name="day">
  </label>
  <label>
    Year
    <input type="text" name="year">
  </label>
  <br>
  <input type="submit">
</form>'''

unit2_hw1_form='''
<form method="post">
  <label>
    Enter some text to ROT13:
    <textarea name="text">
      %(user_text)s
    </textarea>
  </label>
  <input type="submit">
</form>'''

unit2_hw2_form='''
<form method="post">
  <label>
    Signup
  </label>
  <br>
  <label>
    Username
    <input name="username" value="%(username)s">
    <div style="color:red">%(username_error)s</div>
  </label>
  <label>
    Password
    <input name="password" type="password" value="">
    <div style="color:red">%(password_error)s</div>
  </label>
  <label>
    Verify Password
    <input name="verify" type="password" value="">
    <div style="color:red">%(verify_error)s</div>
  </label>
  <label>
    Email (optional)
    <input name="email" value="%(email)s">
    <div style="color:red">%(email_error)s</div>
  </label>
  <input type="submit">
</form>'''

class RootHandler(webapp2.RequestHandler):
    def get(self):
        self.response.headers['Content-Type']='text/html'
        self.response.out.write("Hello Udacity")

class DemoHandler(webapp2.RequestHandler):
    def get(self):
        self.response.out.write(demo_form)
    def post(self):
        self.response.out.write(demo_form)

class Unit2Hw1Handler(webapp2.RequestHandler):
    def get(self):
        self.response.out.write(unit2_hw1_form % {"user_text":""})
    def post(self):
        input_text=self.request.get('text')
        result=""
        for i in range(len(input_text)):
            char=input_text[i]
            int_value=ord(char)
            if ord('a')<=int_value<=ord('z'):
                rotted=rot13(int_value,ord('a'))
                result=result+rotted
            elif ord('A')<=int_value<=ord('Z'):
                result=result+rot13(int_value,ord('A'))
            else:
                result=result+char
        self.response.out.write(unit2_hw1_form % {"user_text":result})

def rot13(int_value, int_of_first):
    r=(int_value+13-int_of_first)%26+int_of_first
    c=chr(r)
    return c

USERNAME_RE=re.compile(r"^[a-zA-Z0-9_-]{3,20}$")
PASSWORD_RE=re.compile(r"^.{3,20}$")
EMAIL_RE=re.compile(r"^[\S]+@[\S]+\.[\S]+$")

class Unit2Hw2Handler(webapp2.RequestHandler):
    def get(self):
        self.response.out.write(unit2_hw2_form % {'username':'',
            'email':'', 'username_error':'', 'password_error':'',
            'verify_error':'', 'email_error':''})
    def post(self):
        input_username=self.request.get('username')
        input_password=self.request.get('password')
        input_verify=self.request.get('verify')
        input_email=self.request.get('email')
        result={'username':'',
            'email':'', 'username_error':'', 'password_error':'',
            'verify_error':'', 'email_error':''}
        any_error=False
        result['username']=input_username
        result['email']=input_email
        if not verify(USERNAME_RE, input_username):
            result['username_error']="That's not a valid username."
            any_error=True
        if not verify(PASSWORD_RE, input_password):
            result['password_error']="That wasn't a valid password."
            any_error=True
        if input_password!=input_verify:
            result['verify_error']="Your passwords didn't match."
            any_error=True
        if input_email and not verify(EMAIL_RE, input_email):
            result['email_error']="That's not a valid email."
            any_error=True
        if any_error:
            self.response.out.write(unit2_hw2_form % result)
        else:
            self.redirect("/unit2/hw2/redirect?username="+input_username)

def verify(re,input):
    m=re.match(input)
    return m

class Unit2Hw2RedirectHandler(webapp2.RequestHandler):
    def get(self):
        input_username=self.request.get('username')
        self.response.out.write("Welcome, " + input_username + "!")

app = webapp2.WSGIApplication([('/', RootHandler),
    ('/demoform',DemoHandler),
    ('/unit2/hw1',Unit2Hw1Handler),
    ('/unit2/hw2',Unit2Hw2Handler),
    ('/unit2/hw2/redirect',Unit2Hw2RedirectHandler),
    ],
                              debug=True)
