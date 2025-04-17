-- weekly active users -- 
SELECT DATE_TRUNC('week', occurred_at) AS week_start,
       COUNT(DISTINCT user_id) AS weekly_active_users
FROM tutorial.yammer_events
WHERE event_type = 'engagement'
GROUP BY 1
ORDER BY 1


-- Querying List of Devices ---
SELECT DISTINCT device
FROM tutorial.yammer_events
/* Displaying Devices
dell inspiron desktop, amazon fire phone, nexus 10, macbook pro, asus chromebook, ipad mini, windows surface, samsumg galaxy tablet,
macbook air, lenovo thinkpad, mac mini, iphone 5, nexus 7, kindle fire, iphone 5s, acer aspire desktop, acer aspire notebook, nexus 5
dell inspiron notebook, htc one, iphone 4s, samsung galaxy note, nokia lumia 635, ipad air, hp pavilion desktop, samsung galaxy s4
*/


/*
Categorize different devices into buckets - Computer, Tablet and Phone.
Query and Plot user engagement by device 
**/
SELECT DATE_TRUNC('week', occurred_at) AS week,
       COUNT(DISTINCT user_id) AS weekly_users,
       COUNT(DISTINCT CASE WHEN device IN ('macbook pro', 'acer aspire notebook','acer aspire desktop','lenovo thinkpad', 'mac mini', 'dell inspiron desktop','dell inspiron notebook','windows surface','macbook air','asus chromebook','hp pavilion desktop') THEN user_id ELSE NULL END) AS computer,
       COUNT(DISTINCT CASE WHEN device IN ('iphone 5s','nokia lumia 635','amazon fire phone','iphone 4s','htc one','iphone 5','samsung galaxy s4') THEN user_id ELSE NULL END) AS phone,
       COUNT(DISTINCT CASE WHEN device IN ('kindle fire','samsung galaxy note','ipad mini','nexus 7','nexus 10','samsumg galaxy tablet','nexus 5','ipad air') THEN user_id ELSE NULL END) AS tablet
FROM tutorial.yammer_events
WHERE event_type = 'engagement'
GROUP BY 1
ORDER BY 1


/* User engagement - Mobile vs Web */
SELECT DATE_TRUNC('week', occurred_at) AS week,
       COUNT(DISTINCT CASE WHEN device IN ('macbook pro', 'acer aspire notebook','acer aspire desktop','lenovo thinkpad', 'mac mini', 'dell inspiron desktop','dell inspiron notebook','windows surface','macbook air','asus chromebook','hp pavilion desktop') THEN user_id ELSE NULL END) AS web,
       COUNT(DISTINCT CASE WHEN device IN ('iphone 5s','nokia lumia 635','amazon fire phone','iphone 4s','htc one','iphone 5','samsung galaxy s4', 'kindle fire','samsung galaxy note','ipad mini','nexus 7','nexus 10','samsumg galaxy tablet','nexus 5','ipad air') THEN user_id ELSE NULL END) AS mobile
FROM tutorial.yammer_events
WHERE event_type = 'engagement'
GROUP BY 1
ORDER BY 1


/* Displaying different events in engagement */
SELECT DISTINCT event_name
FROM tutorial.yammer_events 
WHERE event_type = 'engagement'
/* Ouput -
home_page like_message login search_autocomplete search_click_result_1 search_click_result_10 search_click_result_2
search_click_result_3 search_click_result_4 search_click_result_5 search_click_result_6 search_click_result_7 search_click_result_8
search_click_result_9 search_run send_message view_inbox
*/


/* Funnel Analysis - Engagement in different stages of User Flow */
SELECT DATE_TRUNC('week', occurred_at) AS week,
       COUNT(CASE WHEN event_name = 'home_page' THEN user_id ELSE NULL END) AS home_page,
       COUNT(CASE WHEN event_name = 'like_page' THEN user_id ELSE NULL END) AS like_page,
       COUNT(CASE WHEN event_name = 'login' THEN user_id ELSE NULL END) AS login,
       COUNT(CASE WHEN event_name = 'search_autocomplete' THEN user_id ELSE NULL END) AS search_autocomplete,
       COUNT(CASE WHEN event_name = 'search_run' THEN user_id ELSE NULL END) AS search_run,
       COUNT(CASE WHEN event_name = 'send_message' THEN user_id ELSE NULL END) AS send_message,
       COUNT(CASE WHEN event_name = 'view_inbox' THEN user_id ELSE NULL END) AS view_inbox,
       COUNT(CASE WHEN event_name LIKE 'search_click_result_%' THEN user_id ELSE NULL END) AS search_clicks
FROM tutorial.yammer_events 
WHERE event_type = 'engagement'
GROUP BY 1
ORDER BY 1 


/* Engagement in Login stage of User Flow */
SELECT DATE_TRUNC('week', occurred_at) AS week,
       COUNT(CASE WHEN event_name = 'login' THEN user_id ELSE NULL END) AS login
FROM tutorial.yammer_events 
WHERE event_type = 'engagement'
GROUP BY 1
ORDER BY 1 


/* Email Engagement by Event Type */
SELECT DATE_TRUNC('week', occurred_at) AS week,
       COUNT(CASE WHEN action = 'sent_weekly_digest' THEN user_id ELSE NULL END) AS weekly_emails,
       COUNT(CASE WHEN action = 'sent_reengagement_email' THEN user_id ELSE NULL END) AS reengagement_emails,
       COUNT(CASE WHEN action = 'email_open' THEN user_id ELSE NULL END) AS email_opens,
       COUNT(CASE WHEN action = 'email_clickthrough' THEN user_id ELSE NULL END) AS email_clickthroughs
FROM tutorial.yammer_emails
GROUP BY 1
ORDER BY 1


/* Event Types - Signup and Engagement */
SELECT DATE_TRUNC('week', occurred_at) AS week,
       COUNT(CASE WHEN event_type = 'engagement' THEN user_id ELSE NULL END) AS engagement,
       COUNT(CASE WHEN event_type = 'signup_flow' THEN user_id ELSE NULL END) AS signup
FROM tutorial.yammer_events
GROUP BY 1
ORDER BY 1
