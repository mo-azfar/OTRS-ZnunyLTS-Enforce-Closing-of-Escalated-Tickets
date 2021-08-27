# OTRS ZnunyLTS Enforce Closing of Escalated Tickets

[![paypal](https://www.paypalobjects.com/en_US/i/btn/btn_donateCC_LG.gif)](https://paypal.me/MohdAzfar?locale.x=en_US)    
  
- Force an agent (ticket owner) to close any escalated ticket first before can proceed to another ticket.
- Built for OTRS CE 6.0.x / Znuny LTS  
- Case Reference: https://community.znuny.org/viewtopic.php?f=62&t=42672  
    
1. Define first the involved queues at System Configuration > Frontend::NotifyModule###888-AgentEscalationCheckRedirect  
2. If agent has owned an escalated ticket in defined queues, he/she will be redirect to Escalation Screen.  
3. Access to the module Admin, ITSM, Reporting and FAQ are still allowed.

[![YOUTUBE VIDEO](https://img.youtube.com/vi/P-Kr9GNeqW8/0.jpg)](https://www.youtube.com/watch?v=P-Kr9GNeqW8)  
     
[![1.png](https://i.postimg.cc/yxPf7vBj/1.png)](https://postimg.cc/SYnLrLnY)  