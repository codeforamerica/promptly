#How to Promptly
Promptly is an open source text message notification system. My team built Promptly in collaboration with the San Francisco Human Service Agency (SF HSA) in 2013. We used it to reduce churn by notifying CalFresh clients of upcoming discontinuations. As of this writing, SF HSA has over 3,000 CalFresh clients enrolled. This guide explains exactly how your human service agency can do the same thing. It’s targeted primarily to HSA program directors and program managers, but should be useful for anyone involved in the project. We also specifically focus on CalWin integration, but all of the same general points apply to C-IV, LEADER, or any other case management data system. Here’s the agenda:

- [Why this is important](#why-this-is-important)
- [Step 0: Get your team, get your resources](#step-0-get-your-team-get-your-resources)
- [Step 1: Decide what to text, when to text, and who to text](#step-1-decide-what-to-text-when-to-text-and-who-to-text- )
- [Step 2: Figure out client privacy and the opt-in process](#step-2-figure-out-client-privacy-and-the-opt-in-process)
- [Step 3: Figure out how to store client cell phone numbers and opt-ins in CalWin](#step-3-figure-out-how-to-store-- client-cell-phone-numbers-and-opt-ins-in-calwin)
- [Step 4: Install Promptly on your agency’s servers](#step-4-install-promptly-on-your-agencys-servers)
- [Step 5: Setup call forwarding and auto response](#step-5-setup-call-forwarding-and-auto-response)
- [Step 6: Integrate CalWin data into Promptly](#step-6-integrate-calwin-data-into-promptly)
- [Step 7: Launch, monitor, repeat](#step-7-launch-monitor-repeat)
- [Questions?](#questions)

If you get to the end and still have questions, don’t hesitate to reach out and we’ll update this guide accordingly. But before we dive in, let’s remember why it’s worth doing.

##Why this is important
In 2010, California had the lowest SNAP participation rate of any state in the country. National participation was about 75%. California’s was 43%. In other words, the majority of Californians who were eligible for CalFresh weren’t getting it<a name="1-back"></a><sup>[1](#1)</sup>.

One cause of low participation is churn; when clients needlessly lose benefits only to re-enroll soon after. Churn is lose-lose. It’s a negative shock for clients and waste of time for agency. Here are the stats on churn for October - December 2012<a name="2-back"></a><sup>[2](#2)</sup>:

Measure | California | San Francisco
------------------------------------|------------|--------
Churn rate (30 day)<a name="3-back"></a><sup>[3](#3)</sup>                 | 18.2%     | 18.5%
Churn rate (90 day)<a name="3-back"></a><sup>[3](#3)</sup>                 | 37.6%     | 40.4%
Recertification churn rate (30 day)<a name="4-back"></a><sup>[4](#4)</sup> | 10.2%     | 9.0%
Recertification churn rate (90 day)<a name="4-back"></a><sup>[4](#4)</sup> | 12.9%     | 14.9%

This means that about 40% of incoming applications came from clients who had received CalFresh benefits in the prior 3 months, suggesting many of these families experienced a unnecessary break in benefits.

More importantly, churn is a bad experience for clients. Imagine trying to check out in the grocery store but your EBT card won’t work. The cashier tells you it’s empty. You don’t have enough cash, so you leave the store without food. When you call the agency, they tell you that they stopped your benefits because you didn’t turn in some paperwork. Apparently they sent you a letter. You dig through your mail and find this:
![Notice of Action - Termination](http://codeforamerica.github.io/promptly/how-to-promptly/noa.jpg)

Indeed, you remember seeing it weeks ago but setting it aside because it was confusing and you were busy. So now you’re without groceries and trying to restore your benefits. Sometimes this involves a phone call. Other times it involves starting your CalFresh application from scratch. For some clients this is an inconvenience. For others it’s a crisis.

This is the motivation for Promptly: Churn is lose-lose and confusion drives churn. So let’s reduce confusion and meet clients where they are with critical information in plain english:
![Promptly text message](http://codeforamerica.github.io/promptly/how-to-promptly/msg.jpg)

Alright, let’s dive in!

##Step 0: Get your team, get your resources
Like all new technologies, using Promptly effectively requires some change. This is probably the first time your agency has (officially) sent text messages to clients, so this change can be tricky. Before you get started, make sure you have the right team and the right resources available.

You will need four distinct roles to get Promptly up and running effectively:

Role | Responsibility | ~Time commitment
-----|----------------|-------------------
The **Executive Sponsor** is a high level executive (ideally the Program Director) who supports the project and can remove bureaucratic and policy barriers.|- Manage communication with other executives.<br>- Make final decision on the opt-in process and client privacy. <br>- Support the Program Specialist and IT Developer as necessary.|Minimal - Likely just a few meetings upfront and then as needed to address barriers as identified by the Program Specialist.
The **Program Specialist** is the day-to-day Project Manager whose job is to get things done. It is important that they know how the program works and what the clients need. | - Figure out the opt-in process.<br>- Train eligibility workers.<br>- Write and translate the content of the text messages.<br>- Schedule and send the text messages.<br>- Monitor incoming text messages from clients. | Approximately ½ time for one month or ¼ time for two months and 1 hour per month indefinitely going forward.
The **IT Developer** knows how to install and maintain web applications. | - Install Promptly.<br>- Connect Promptly to necessary data sources.<br>- Manage user accounts.<br>- Monitor and maintain the system. | Approximately ½ time for two weeks or ¼ time for one month.
The **CalWin Specialist** will support the IT Developer on data integration. | - Create a new special indicator to capture client opt-ins or help figure out an alternative process.<br>- Support the IT Developer to write and validate CalWin queries. | Minimal - Varies depending on IT Developer’s comfort with the data sources.

The Program Specialist and IT Developer will do the bulk of the work, while the Executive Sponsor and CalWin Specialist will support them.

Other than the team, you’ll need:
- A Twilio account<a name="5-back"></a><sup>[5](#5)</sup> with some Twilio credit ($). In short, Twilio charges 3/4c per message and 3c per minute for incoming phone calls. See How much does Promptly cost for details.
- Access to translation services if you’re writing new text messages.

OKAY! Every team member should read this guide before the kickoff meeting to get everyone on the same page. Now that we have our team, we can get started. I’ve broken things down into six steps for clarity, but there’s no need to do these in order. Just think of these as discrete things to get done.

##Step 1: Decide what to text, when to text, and who to text
The first step is to figure out exactly what you want to say, when to say it, and who to say it to. Don’t underestimate this work.

###What to text
Here’s what we told CalFresh clients in San Francisco who were about to be discontinued:
![Promptly text message](http://codeforamerica.github.io/promptly/how-to-promptly/msg.jpg)

A few things to note:
- Always identify yourself.
- State the facts in plain language.
- Tell clients where to go if they need help.
- Keep it under 160 characters.

We translated this message into San Francisco’s six primary languages. You can see all of our translations in the Promptly Github repository. As you develop your messages, take a look at these best practices for government text messaging.

###When to text
We send these messages at 10am about three business days before the end of each month. We chose 10am because we didn’t want to disturb clients too early but also wanted to make sure the CalFresh call center would be open when they called. We chose 3 business days before the end of the month to give clients enough time to respond and correct mistakes without unnecessarily worrying clients who had submitted paperwork that was still being processed. You can pick a new date and time every time you schedule a new set of notifications.

###Who to text
In short, we send these messages to CalFresh clients who are going to be discontinued at the end of the month. Sounds simple. But there are some gory details:
- We only include CalFresh cases that failed the most recent eligibility test in CalWIn
- We only include cases that have opted in to text message notifications, as captured by a CalWin special indicator.
- We exclude CalWORKS cases because those clients should not use the CalFresh call center.
- We exclude certain Medi-Cal that involved minors.
- We exclude certain expedited CalFresh cases.

Here is the SQL query we used to identify these cases in CalWin. These details will change depending on your internal business process and program structure. The Program Specialist will work with the IT Developer and CalWin Specialist to define the appropriate client population given the constraints of your data systems.

##Step 2: Figure out client privacy and the opt-in process
Text messages are not secure. They can’t be encrypted or password protected, so service providers like Verizon and AT&T can access these messages. Similarly, anyone with physical access to the client’s cell phone can probably read their text messages without a password. For these reasons, all text messaging services for human service clients should be opt-in. As a general rule, no client should ever be sent a text messages unless they explicitly request it.

So, how should clients opt-in? In general, you should integrate the opt-in process into existing application/recertification flow for clients and workers. At the very least, clients should understand:
- That text messages are optional and will not replace any other paperwork or notifications.
- The type of text messages they will receive.
- That text messages are not secure.
- That text messages might cost a few cents, depending on their phone plan.
- How to opt-out if they don’t want anymore messages.

And workers should know:
- When and how to offer text messaging to clients
- Where and how to store this information in the data system (see Step 3 below)
- When and how to verify cell phone numbers

Here’s how we did it in San Francisco:
- We used this Text and Email Consent Form to collect opt-ins, cell phone numbers, and email addresses. We developed this form in partnership with the SF City Attorney’s office and HSA management.
- We added this form to CalFresh application and recertification packets, giving every client two opportunities per year to opt in to text messaging.
- We worked with CalFresh management to teach every worker how to collect this new information and address any questions/concerns.

The Program Specialist should collaborate with eligibility workers to figure out an opt-in process that doesn’t unnecessarily burden clients or workers, and then review this process in detail with your agency’s Privacy Officer. You may need to involve the Executive Sponsor in these meetings because sending text messages invariably exposes the agency to new risks. As of this writing, the California Department of Social Services is aware of our setup in San Francisco but has not yet released formal guidance for text messaging.

##Step 3: Figure out how to store client cell phone numbers and opt-ins in CalWin
Once you’ve figured out the opt-in process, you’ll need to decide exactly how and where you will store (1) the binary opt-in data and (2) client cell phone numbers.

Here’s how we did it in San Francisco:
- We stored the opt-in as a Case Special Indicator, labeled ‘Text messages OK.’ When this indicator was present, it meant that the client had signed the opt-in form.
- We stored client cell phone numbers in the ‘message phone’ field of the Case Summary window.

To get this setup from scratch, Program Specialist will need to:

1. Work with the CalWin Specialist to create a new ‘Text messages OK’ special indicator.
2. Work with section managers and workers to confirm that the ‘message phone’ field is available and not already part of an important business process.
3. Communicate to eligibility workers exactly how to store this information and answer any questions. How you communicate this will depend on the organization structure of your program.

##Step 4: Install Promptly on your agency’s servers
At this point we have everything we need to start sending effective text messages: We know what we want to say, we have a thoughtfully considered opt-in process, and we’re reliably storing opt-ins and cell phone numbers in CalWin. The next step is to get the Promptly application up and running. The bulk of this work will be done by the Application Developer.

Promptly is a Ruby on Rails application that uses PostgreSQL as its database and Twilio to send and receive text messages. Promptly can happily run behind your firewall as long as it can connect to Twilio’s servers. The application code is open source, free to use, and publicly hosted on Github. As of this writing, the code is actively maintained and updated by Postcode, a private company that provides technology applications and services to local governments.

See the Promptly Readme on GitHub for detailed requirements and installation instructions. If you have technical questions, take a look at the existing Github issues and feel free to open a new one if you’re still stuck.

##Step 5: Setup call forwarding and auto response
When we text clients from our new Promptly phone number, some will call back and others will text back. So we need to handle both of those cases gracefully. In our experience so far sending CalFresh discontinuation notifications in San Francisco, between 25% and 50% of clients will call that number back, if prompted in the message. Very few clients will reply with a text message without being prompted. For incoming calls, we’ll setup call forwarding. For incoming text messages, we’ll setup a generic text message that gets sent back automatically in response. This will be done by the Application Developer in collaboration with the Program Specialist.

###Call Forwarding
For incoming calls, the simplest solution is to automatically forward them to some other phone number that will connect them to a human who can help. For example, in San Francisco, we forward all incoming calls directly to the CalFresh call center. Check out Twilio’s instructions for setting up call forwarding. In short, set the voice request URL for your Twilio number to http://twimlets.com/forward?PhoneNumber=XXX-XXX-XXXX, like this:
![Twilio voice config](http://codeforamerica.github.io/promptly/how-to-promptly/twilio-voice.jpg)

If you need more complex forwarding scheme that, for example, asks clients to choose their language or allocates incoming calls to different phone numbers, you will have to do this work yourself. You can build a simple IVR and routing system using Twilio - see this Twilio docs to get started.

###Auto-Response Text Message
Probably very few clients will respond with a text message, but if they do, we shouldn’t leave them in silence. The simplest solution is to automatically reply with a generic yet helpful message. For example, when clients replied to our text notification in San Francisco, we sent them this:
> We can't reply back by text right now. If you need help, give us a call at (415) 944-4301. If you don't want these messages, reply with STOP.

You can set this up using Twilio’s echo Twimlet:

1. Figure out exactly what you want to say in 160 characters or less. You should at least remind people they can ‘reply with STOP,’ but the rest is up to you. Remember, every client will get this message regardless of language, program, etc. I recognize this is not ideal and encourage you to build a better solution and contribute it!
2. URL encode your 160 character message (here’s a free URL encoder).
3. Insert your URL encoded message into this string:
http://twimlets.com/echo?Twiml=%3CResponse%3E%3CSms%3E[REPLACE THIS WITH YOUR URL ENCODED MESSAGE]%3C%2FSms%3E%3C%2FResponse%3E
4. Set the mssage request URL for your Twilio number to this full string, like this:
![Twilio SMS config](http://codeforamerica.github.io/promptly/how-to-promptly/twilio-sms.jpg)

###A note on opting out
In the U.S., telephony service providers have agreed to a few standards to prevent unwanted text message spam. Three of these are relevant for our clients:
- Help: When a client replies ‘Help’, they will receive this message: ‘Reply STOP to unsubscribe. Msg&Data Rates May Apply.’
- Stop: When a client replies ‘Stop’, they will stop receiving all messages from Promptly and will receive this message: ‘You have successfully been unsubscribed. You will not receive any more messages from this number. Reply START to resubscribe.’
- Start: When a client replies ‘Start’, they will once again start receiving messages from Promptly and receive this message: ‘You have successfully been re-subscribed to messages from this number. Reply HELP for help. Reply STOP to unsubscribe. Msg&Data Rates May Apply.’

This is called SMS stop filtering and you can read more about it here.

##Step 6: Integrate CalWin data into Promptly
At this point you can use Promptly to send text messages to clients. If you already have a list of clients and their phone numbers who you want to message, then you’re ready to go. But if you want to send messages to groups of clients generated from CalWin data, then we have one more step.

Now that Promptly is up and running, we just need to connect Promptly CalWin data. This work will be done by the Application Developer with support from the CalWin specialist.

The goal is to automatically import specific groups of clients into Promptly on a routine basis. There are many ways to do this that will depend on your internal IT infrastructure and business processes, so your Application Developer or someone else in IT should lead this process. In general, you can import data into Promptly by:

1. Running a query that outputs one table per Promptly Group
2. Push these tables to the Promptly database
3. Run the Promptly import command
4. Automate these tasks with a cron job or another equivalent.

See the Importing Group section of the Promptly wiki for a detailed description of this import process.

##Step 7: Launch, monitor, repeat
We’re finally ready to go! It’s time for the Program Specialist to schedule the reminders:

1. Login to Promptly
2. Schedule some test reminders. Setup a test Group in Promptly and add yourself, your coworkers, and your friends. 3. Make sure you test every message you intend to send to clients in every language. Make sure the message looks right, and gets delivered at the right time. If it doesn’t work for you, it won’t work for your clients.
Schedule the real reminders. Pick a time when your call center is open. Give your clients about 3 business days notice.
4. Login to Promptly at least once per day for the next week or so to monitor undelivered outgoing messages, incoming messages, and incoming phone calls from clients.
5. Reach out to at least a few eligibility workers to make sure everything is A-ok. Do clients understand why they’re receiving text messages and what they mean? Do they know how to opt-out? Are the eligibility workers able to help them? If not, why?

Learn, improve, and repeat each month. And that is How to Promptly!

##Questions?
- If you have general questions, don’t hesitate to reach out to me at jacob@codeforamerica.org.
- If you have technical questions about installing or using Promptly, open an issue in our Github repository.
- If you want hands on support, training, installation, or maintenance, I suggest you email info@postcode.io. Postcode is the organization that maintains the Promptly codebase and provides other technology services to local governments. Andy Hull, the founder and CEO of Postcode was the lead develop on Promptly, so he knows what he’s doing.

##Footnotes
1. <a name="1"></a>http://www.fns.usda.gov/sites/default/files/Reaching2010.pdf [[back]](#1-back)
2. <a name="2"></a>http://www.cdsscounties.ca.gov/foodstamps/res/docs/ChurnData.xlsx [[back]](#2-back)
3. <a name="3"></a>Churn rate: Percentage of CalFresh applications that received benefits in the previous 30/90 days [[back]](#3-back)
4. <a name="4"></a>Recertification churn rate: Percentage of CalFresh cases who had recertifications due that reapplied within 30/90 days [[back]](#4-back)
5. <a name="5"></a>Twilio is not strictly required, but changing SMS providers requires changes to the Promptly codebase. If you want to learn more about this, feel free to open an issue in our GitHub repository. [[back]](#5-back)
