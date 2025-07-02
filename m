Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9DFF2EE60E;
	Wed,  2 Jul 2025 15:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751469560; cv=none; b=QIi/mkXw8VjZyonVGdHM6XgodQyMwL4hqbc9rLrkDcMHlfM5yeTO5GQcQKANEeiaAfTB5LtnqxlcsTrPpZqVaci8m9SH8s5NGJuIpuHj1s05P8YztqXAkmXmGX07aJoNhdXgCVlJodm3efR2/sSbKONkR78bUsZV3FBEfEA6CLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751469560; c=relaxed/simple;
	bh=Lu/ZAODxLaemEaV9l9QVx0JzgoCvcqQ5n7yacN5Y2v0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Bay+7VhVeTtE3NCEAd3GJjXN3i2quf4jULKFrPbutMN9mG+wFK3OazhByS6lm9Fs3zARsyZa34IMotCHZP0HhLc2GLUX4ghB/jxdeJhLokOkpYTosCRZs06wvVbfTCVr4cfMZ6dPD5x4kRvgoPQLglB2n89Y/Sh4pchPPnb6Les=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 10200802E3;
	Wed,  2 Jul 2025 15:19:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 50E2B20012;
	Wed,  2 Jul 2025 15:19:09 +0000 (UTC)
Date: Wed, 2 Jul 2025 11:19:08 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH RESEND] tracing: add kernel documentation for
 trace_array_set_clr_event, trace_set_clr_event and supporting functions
Message-ID: <20250702111908.03759998@batman.local.home>
In-Reply-To: <20250702104058.3cf9c1a3@batman.local.home>
References: <20250620085618.4489-1-gpaoloni@redhat.com>
	<20250701195939.3e297e20@gandalf.local.home>
	<CA+wEVJY2a_ERXemup7EefPPXHOv8DAfyauuP6Mn5vHYFkbbBcQ@mail.gmail.com>
	<20250702104058.3cf9c1a3@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 1g4uh95se6shgazt9w7shktus1jgmmy9
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 50E2B20012
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18qkscrzzLqEmbSf3UBv7pNNZnerq4LmjA=
X-HE-Tag: 1751469549-651443
X-HE-Meta: U2FsdGVkX1+O5OG2NHn2uTZBGAH810WURW+jWmysukVwqiMeVC33ecgVT8PpWYrMaPNko16N0jbDFfwJKvIXDEPeRlKAK5UQzNPwotn1GpqmRSi+++b+vlM2Qf2WNwuR8rOPlg3YdWk68qA0zIT88NkC9jTX7oFYwbhO88fj1+06ftC31v8QODqErLLAl8L4vlzyAAvGmJNVt0vuobwW8VE8YZ91yJFdG3jnvDX14aP6kz4lWRhtbxh3JQC1K7M/MsAvDmrvSdfCpY/WIx2mSMIw4Ur4P2ty2Ae23FP+WOWiuZv31LiQNVndBZqAD1MrLTpfFi6HwqQlBIg/qNqntVxHikUFLrs82uDDxD20AHFURQVYDjJ93Yfh8pQO4KR5

On Wed, 2 Jul 2025 10:40:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Now technically, the SOFT_MODE bit should only be set iff the ref count
> is greater than zero. But it's easier to test a flag than to always
> test a ref count.

So the reason for why we have both a SOFT_MODE flag and a ref count is
because the original code expected only one user of the SOFT_MODE case.
But in 2013, Masami found that if two users used soft mode the
accounting broke and added a ref count. This does make the SOFT_MODE
flag redundant.

I just tried to remove it and I think it can work. Instead of using a
SOFT_MODE flag in the file flags field, simply using the ref counter is
just as fine.

Also note, I'm not sure there's any reason the ref counter is an atomic
value. All updates to it are done under the event_mutex lock. But that
can be another clean up.

-- Steve

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
