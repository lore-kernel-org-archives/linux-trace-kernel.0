Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48A2E4992;
	Wed,  2 Jul 2025 18:37:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751481425; cv=none; b=oBHieAtVy3/3dlAM7ifVpeC8kVRpv1VfyCv9uBXqKKWHlBwJdbODQdAvgdX3G1zYjYrjymeVhquJTDfn6nD2zX9ISZNaqEPZ6dJh9bSgWbvlhQ433e32hu4GEcIKXBTqy7nAsH3gFqlJBuLGoYgiT5Y6aT50AosgB/JPPkbd0/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751481425; c=relaxed/simple;
	bh=mDuuDEo7hJVCDmiNn9b+8+ybz+apZqRUyfPLZwxi2sI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=R3/SUSQEcU72BfmwfJB/TURz1V79+1VJeWt0BXOhsER9KbG8pzxqPdVa5P7tjIwV+ZZbzBeMRy0X7hCBoOzQ2mKdkIeFmpm8lRvDnOt6gGRxathDO2ggPb2IVX+UQcl6xAyhTxU3uYn/AXYXTL4zqqWSFORHKMxVnV9ZcfdxKio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id C682E10652D;
	Wed,  2 Jul 2025 18:37:01 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 15B6420011;
	Wed,  2 Jul 2025 18:36:58 +0000 (UTC)
Date: Wed, 2 Jul 2025 14:36:57 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Gabriele Paoloni <gpaoloni@redhat.com>
Subject: [PATCH] tracing: Remove EVENT_FILE_FL_SOFT_MODE flag
Message-ID: <20250702143657.18dd1882@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zoean7keiabjx1k5d1bz7phkybkdfp9d
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 15B6420011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/EnB+sZHxoyfhuA9GO4s6x+pfSn9COnK0=
X-HE-Tag: 1751481418-778989
X-HE-Meta: U2FsdGVkX1+8nu+gn7WrnX5rXzbbSRWGkevilAlr9elubWiAqZkiMWe/x5OEuyVbcAU+z+qojtWY8SDe/uiAcKcrOnu1dEtUV69PRaHeTSLjfvDsFqsYiBIwfe/6qV07+/tlz2wu6GzLLT2FejYSkAEXo1KY2d/0pDWVkYcydXxHm8YwXkawVsPyzmFwxKIoYuNy2ejNcl2IS6voRoK1+ZC8X9BbaSYyWw8arbOPgo5DymalCF15iBgG7J16M+CzAGf1DkNUkd/8rOpVPVUUH7Hb2AyUZJzkhtwRCMUVUm9XHD0jlz8XiqvgpX7q5Mz/vv6XiCEna+QInxwU0TAgLbz/rOy9rd8hbHjp8JPFbtip3rVjDyPHvJQBjCvrq+abtdmCsjwjHX2qymyFUWecTg==

From: Steven Rostedt <rostedt@goodmis.org>

When soft disabling of trace events was first created, it needed to have a
way to know if a file had a user that was using it with soft disabled (for
triggers that need to enable or disable events from a context that can not
really enable or disable the event, it would set SOFT_DISABLED to state it
is disabled). The flag SOFT_MODE was used to denote that an event had a
user that would enable or disable it via the SOFT_DISABLED flag.

Commit 1cf4c0732db3c ("tracing: Modify soft-mode only if there's no other
referrer") fixed a bug where if two users were using the SOFT_DISABLED
flag the accounting would get messed up as the SOFT_MODE flag could only
handle one user. That commit added the sm_ref counter which kept track of
how many users were using the event in "soft mode". This made the
SOFT_MODE flag redundant as it should only be set if the sm_ref counter is
non zero.

Remove the SOFT_MODE flag and just use the sm_ref counter to know the
event is in soft mode or not. This makes the code a bit simpler.

Link: https://lore.kernel.org/all/20250702111908.03759998@batman.local.home/

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h |  3 ---
 kernel/trace/trace_events.c  | 24 ++++++++++++------------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index fa9cf4292dff..04307a19cde3 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -480,7 +480,6 @@ enum {
 	EVENT_FILE_FL_RECORDED_TGID_BIT,
 	EVENT_FILE_FL_FILTERED_BIT,
 	EVENT_FILE_FL_NO_SET_FILTER_BIT,
-	EVENT_FILE_FL_SOFT_MODE_BIT,
 	EVENT_FILE_FL_SOFT_DISABLED_BIT,
 	EVENT_FILE_FL_TRIGGER_MODE_BIT,
 	EVENT_FILE_FL_TRIGGER_COND_BIT,
@@ -618,7 +617,6 @@ extern int __kprobe_event_add_fields(struct dynevent_cmd *cmd, ...);
  *  RECORDED_TGID - The tgids should be recorded at sched_switch
  *  FILTERED	  - The event has a filter attached
  *  NO_SET_FILTER - Set when filter has error and is to be ignored
- *  SOFT_MODE     - The event is enabled/disabled by SOFT_DISABLED
  *  SOFT_DISABLED - When set, do not trace the event (even though its
  *                   tracepoint may be enabled)
  *  TRIGGER_MODE  - When set, invoke the triggers associated with the event
@@ -633,7 +631,6 @@ enum {
 	EVENT_FILE_FL_RECORDED_TGID	= (1 << EVENT_FILE_FL_RECORDED_TGID_BIT),
 	EVENT_FILE_FL_FILTERED		= (1 << EVENT_FILE_FL_FILTERED_BIT),
 	EVENT_FILE_FL_NO_SET_FILTER	= (1 << EVENT_FILE_FL_NO_SET_FILTER_BIT),
-	EVENT_FILE_FL_SOFT_MODE		= (1 << EVENT_FILE_FL_SOFT_MODE_BIT),
 	EVENT_FILE_FL_SOFT_DISABLED	= (1 << EVENT_FILE_FL_SOFT_DISABLED_BIT),
 	EVENT_FILE_FL_TRIGGER_MODE	= (1 << EVENT_FILE_FL_TRIGGER_MODE_BIT),
 	EVENT_FILE_FL_TRIGGER_COND	= (1 << EVENT_FILE_FL_TRIGGER_COND_BIT),
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 120531268abf..0980f4def360 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -768,6 +768,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 {
 	struct trace_event_call *call = file->event_call;
 	struct trace_array *tr = file->tr;
+	bool soft_mode = atomic_read(&file->sm_ref) != 0;
 	int ret = 0;
 	int disable;
 
@@ -782,7 +783,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		 * is set we do not want the event to be enabled before we
 		 * clear the bit.
 		 *
-		 * When soft_disable is not set but the SOFT_MODE flag is,
+		 * When soft_disable is not set but the soft_mode is,
 		 * we do nothing. Do not disable the tracepoint, otherwise
 		 * "soft enable"s (clearing the SOFT_DISABLED bit) wont work.
 		 */
@@ -790,11 +791,11 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 			if (atomic_dec_return(&file->sm_ref) > 0)
 				break;
 			disable = file->flags & EVENT_FILE_FL_SOFT_DISABLED;
-			clear_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			soft_mode = false;
 			/* Disable use of trace_buffered_event */
 			trace_buffered_event_disable();
 		} else
-			disable = !(file->flags & EVENT_FILE_FL_SOFT_MODE);
+			disable = !soft_mode;
 
 		if (disable && (file->flags & EVENT_FILE_FL_ENABLED)) {
 			clear_bit(EVENT_FILE_FL_ENABLED_BIT, &file->flags);
@@ -812,8 +813,8 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 
 			WARN_ON_ONCE(ret);
 		}
-		/* If in SOFT_MODE, just set the SOFT_DISABLE_BIT, else clear it */
-		if (file->flags & EVENT_FILE_FL_SOFT_MODE)
+		/* If in soft mode, just set the SOFT_DISABLE_BIT, else clear it */
+		if (soft_mode)
 			set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
 		else
 			clear_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
@@ -823,7 +824,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		 * When soft_disable is set and enable is set, we want to
 		 * register the tracepoint for the event, but leave the event
 		 * as is. That means, if the event was already enabled, we do
-		 * nothing (but set SOFT_MODE). If the event is disabled, we
+		 * nothing (but set soft_mode). If the event is disabled, we
 		 * set SOFT_DISABLED before enabling the event tracepoint, so
 		 * it still seems to be disabled.
 		 */
@@ -832,7 +833,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		else {
 			if (atomic_inc_return(&file->sm_ref) > 1)
 				break;
-			set_bit(EVENT_FILE_FL_SOFT_MODE_BIT, &file->flags);
+			soft_mode = true;
 			/* Enable use of trace_buffered_event */
 			trace_buffered_event_enable();
 		}
@@ -840,7 +841,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		if (!(file->flags & EVENT_FILE_FL_ENABLED)) {
 			bool cmd = false, tgid = false;
 
-			/* Keep the event disabled, when going to SOFT_MODE. */
+			/* Keep the event disabled, when going to soft mode. */
 			if (soft_disable)
 				set_bit(EVENT_FILE_FL_SOFT_DISABLED_BIT, &file->flags);
 
@@ -1792,8 +1793,7 @@ event_enable_read(struct file *filp, char __user *ubuf, size_t cnt,
 	    !(flags & EVENT_FILE_FL_SOFT_DISABLED))
 		strcpy(buf, "1");
 
-	if (flags & EVENT_FILE_FL_SOFT_DISABLED ||
-	    flags & EVENT_FILE_FL_SOFT_MODE)
+	if (atomic_read(&file->sm_ref) != 0)
 		strcat(buf, "*");
 
 	strcat(buf, "\n");
@@ -3584,7 +3584,7 @@ static int probe_remove_event_call(struct trace_event_call *call)
 			continue;
 		/*
 		 * We can't rely on ftrace_event_enable_disable(enable => 0)
-		 * we are going to do, EVENT_FILE_FL_SOFT_MODE can suppress
+		 * we are going to do, soft mode can suppress
 		 * TRACE_REG_UNREGISTER.
 		 */
 		if (file->flags & EVENT_FILE_FL_ENABLED)
@@ -3997,7 +3997,7 @@ static int free_probe_data(void *data)
 
 	edata->ref--;
 	if (!edata->ref) {
-		/* Remove the SOFT_MODE flag */
+		/* Remove soft mode */
 		__ftrace_event_enable_disable(edata->file, 0, 1);
 		trace_event_put_ref(edata->file->event_call);
 		kfree(edata);
-- 
2.47.2

