Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2D131AF07;
	Mon, 12 Jan 2026 20:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768250050; cv=none; b=NYKD+MByCeQg5u3j+lfnMxQce4zEiB51AmMgkHp0HPs0CRhdUgz0K+7/HizeEkNT3dfwnJhGDxzcHLRWFUqMQw0Llru5zHZWChKVSX6ze+H3i+vttsPjEi2Lz0Elod69gBSd7aapMIjhjD264S1yDcKrc4oa7wG07BK/hadWPg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768250050; c=relaxed/simple;
	bh=Ctm/5UbhDslth0m/M9OWgPMLCAGwzniSRSfGUxzzFDg=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f7Im8OZCqntLZHAqbcGJWBle/BrBkuwi9XcILbaAwuTK66DkRaFBXSk7RULIy6s4T2K8uGAeEcHr5FZsat3lTOtA2VMMKKPxBY1qiQCfIQjUz52Mq+lmTX4VIE4f9wEJAD/uZTGnqSpa7BwjAZ8MDdARochmImgdu6dCqYFEpFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 290335D4A6;
	Mon, 12 Jan 2026 20:34:07 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id 7B75417;
	Mon, 12 Jan 2026 20:34:05 +0000 (UTC)
Date: Mon, 12 Jan 2026 15:34:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Aaron Tomlin <atomlin@atomlin.com>
Subject: [PATCH] tracing: Have show_event_trigger/filter format a bit more
 in columns
Message-ID: <20260112153408.18373e73@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 7B75417
X-Stat-Signature: scy8rph8hugkriafbzh5rb4zhhdkpddq
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX199k4TuyVDNbltNRNg3padwA1mUu2P8oF4=
X-HE-Tag: 1768250045-879900
X-HE-Meta: U2FsdGVkX1/pk2HpnEo+dAPzeahhb4s8v5gcefkGkyg3d26hdGv1jJu7uoubJjjJSao9r675m9x4xQnUsfubpZ/A3hhYyRXdOz9Hfxqp0jUPejh/3hNwbLZNYWgzVm6UAzMCfZwxxdZahWb2M5djTidDtcwEYgA/w8OD0Pny6Ffgq4kHjuWFFz1eZ85779DlWNEe9k5jRoRnWKIBakX25leW5MsQjyw8vFUlxCiLlG03Kgci+LE8MnRuJYgnQrabEPtnBm8seyAsmz3OXyzRm5wEb0npuE3mQeWc/XWxxs+xIqztFNTaqxUV4DO7AfEi6oWOZshoQDM8kH/r9Drvp4xvnhn0c/yDbDz++SWxJubvyAaOuzDaRnUClxtZRqiBqc1SzfdPWXpaF7u/RAMtHPxxRRAwJ1hhPvnllbGtUYkjM9+PQYUJHdiDYKm6bSBQh78P3T8qEJAhiUA35RYCFw==

From: Steven Rostedt <rostedt@goodmis.org>

By doing:

 # trace-cmd sqlhist -e -n futex_wait select TIMESTAMP_DELTA_USECS as lat from sys_enter_futex as start join sys_exit_futex as end on start.common_pid = end.common_pid

and

 # trace-cmd start -e futex_wait -f 'lat > 100' -e page_pool_state_release -f 'pfn == 1'

The output of the show_event_trigger and show_event_filter files are well
aligned because of the inconsistent 'tab' spacing:

 ~# cat /sys/kernel/tracing/show_event_triggers
syscalls:sys_exit_futex	hist:keys=common_pid:vals=hitcount:__lat_12046_2=common_timestamp.usecs-$__arg_12046_1:sort=hitcount:size=2048:clock=global:onmatch(syscalls.sys_enter_futex).trace(futex_wait,$__lat_12046_2) [active]
syscalls:sys_enter_futex	hist:keys=common_pid:vals=hitcount:__arg_12046_1=common_timestamp.usecs:sort=hitcount:size=2048:clock=global [active]

 ~# cat /sys/kernel/tracing/show_event_filters
synthetic:futex_wait	(lat > 100)
page_pool:page_pool_state_release	(pfn == 1)

This makes it not so easy to read. Instead, force the spacing to be at
least 32 bytes from the beginning (one space if the system:event is longer
than 30 bytes):

 ~# cat /sys/kernel/tracing/show_event_triggers
syscalls:sys_exit_futex          hist:keys=common_pid:vals=hitcount:__lat_8125_2=common_timestamp.usecs-$__arg_8125_1:sort=hitcount:size=2048:clock=global:onmatch(syscalls.sys_enter_futex).trace(futex_wait,$__lat_8125_2) [active]
syscalls:sys_enter_futex         hist:keys=common_pid:vals=hitcount:__arg_8125_1=common_timestamp.usecs:sort=hitcount:size=2048:clock=global [active]

 ~# cat /sys/kernel/tracing/show_event_filters
synthetic:futex_wait             (lat > 100)
page_pool:page_pool_state_release (pfn == 1)

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
[
  This is based on top of these patches:
    https://lore.kernel.org/linux-trace-kernel/20260105142939.2655342-1-atomlin@atomlin.com/
]
 kernel/trace/trace_events.c | 26 ++++++++++++++++++++++----
 1 file changed, 22 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 36936697fa2a..f372a6374164 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1662,6 +1662,18 @@ static void t_stop(struct seq_file *m, void *p)
 	mutex_unlock(&event_mutex);
 }
 
+static int get_call_len(struct trace_event_call *call)
+{
+	int len;
+
+	/* Get the length of "<system>:<event>" */
+	len = strlen(call->class->system) + 1;
+	len += strlen(trace_event_name(call));
+
+	/* Set the index to 32 bytes to separate event from data */
+	return len >= 32 ? 1 : 32 - len;
+}
+
 /**
  * t_show_filters - seq_file callback to display active event filters
  * @m: The seq_file interface for formatted output
@@ -1676,14 +1688,17 @@ static int t_show_filters(struct seq_file *m, void *v)
 	struct trace_event_file *file = v;
 	struct trace_event_call *call = file->event_call;
 	struct event_filter *filter;
+	int len;
 
 	guard(rcu)();
 	filter = rcu_dereference(file->filter);
 	if (!filter || !filter->filter_string)
 		return 0;
 
-	seq_printf(m, "%s:%s\t%s\n", call->class->system,
-		   trace_event_name(call), filter->filter_string);
+	len = get_call_len(call);
+
+	seq_printf(m, "%s:%s%*.s%s\n", call->class->system,
+		   trace_event_name(call), len, "", filter->filter_string);
 
 	return 0;
 }
@@ -1702,6 +1717,7 @@ static int t_show_triggers(struct seq_file *m, void *v)
 	struct trace_event_file *file = v;
 	struct trace_event_call *call = file->event_call;
 	struct event_trigger_data *data;
+	int len;
 
 	/*
 	 * The event_mutex is held by t_start(), protecting the
@@ -1710,9 +1726,11 @@ static int t_show_triggers(struct seq_file *m, void *v)
 	if (list_empty(&file->triggers))
 		return 0;
 
+	len = get_call_len(call);
+
 	list_for_each_entry_rcu(data, &file->triggers, list) {
-		seq_printf(m, "%s:%s\t", call->class->system,
-			   trace_event_name(call));
+		seq_printf(m, "%s:%s%*.s", call->class->system,
+			   trace_event_name(call), len, "");
 
 		data->cmd_ops->print(m, data);
 	}
-- 
2.51.0

