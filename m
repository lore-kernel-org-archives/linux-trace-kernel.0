Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7E753E317F;
	Fri, 28 Aug 2026 13:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787924470; cv=none; b=ElK8404zb35NzKgLwZLUKxQJarpSwT/yKGO06LuaIlUnY3wB6zib1wKsnepA+Eqo9DWsCgbG3hTGsQjuzXGSY/TcHol9q85GXOI/vLpLpA16LFmQ0ulqfLThEjS1gtD7cYbYhodBDu4qrqNBcJmI9yf5Vf6Wci7KMilVJZIBCTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787924470; c=relaxed/simple;
	bh=A06lwj8BeTQJQQ+R0oF03d4+JAUTRAt7lKWTKfZi3/A=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=uHEW8fP1QD6r5nupuGMBtWe+kMSwQTRqgRizCVAGypR9GxILYIdKkZHnIeeIXcJy7iysBPsG7JwxQzgYjHroCx6eJ31a20XlNh4K3kv208C44VmgSzamAHg+3fCkB7+hsg9mAcQdyCzBM38//Sa2Inh10gPZdnVn//L5NXoyQ0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=GoYT+p1y; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="GoYT+p1y"
Received: from omf16.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 17EAB1A03A1;
	Fri, 28 Aug 2026 13:41:06 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf16.hostedemail.com (Postfix) with ESMTPA id 55AC92001E;
	Fri, 28 Aug 2026 13:41:04 +0000 (UTC)
Date: Fri, 28 Aug 2026 09:41:53 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Farhad Alemi <farhad.alemi@berkeley.edu>,
 Aaron Tomlin <atomlin@atomlin.com>
Subject: [PATCH] tracing: Have show_event_filters/triggers files take trace
 array ref
Message-ID: <20260828094153.17b95037@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: sf44krtskppi9ji5jairowhpsnop1q7k
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 55AC92001E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Zf3RIM11QrwfdVL7G3HSmOibCVYpvl3U=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=F318D6WeJDA564ogVNOubYxbumWfDc9Kc5oP2CC0NEs=; b=GoYT+p1yGU0/bCs5eV1Gw0Zfvwz4dFo+leDcKwxYSm1JUmk47o/PQKCXEYDlq4LAPcFqCr68ubIOU1oVxnczTIArqqDNQYvfIk9vUTg7kBL3Y8mwjYJrXf9kt5X8I2MxVzV1C2NKAml/NX2S2g+sZTGz6HTzZANreAKo5o4eeME=
X-HE-Tag: 1787924464-643713
X-HE-Meta: U2FsdGVkX19ExrsKSZtm7lktnrZtlSPzXf7Cm3R0THkL/lBvBbJzI/Zf89dgLnwMRTb14uX8UURNZgIFCgTmumVbYK6nx6qfSLT7F2qxRVtqkHLMeUvWBZDeVYSgffFgGw2k//YuhNgleZvwOY2FdwA0PN4azmQy3kH0duxWgVQcL6Fh0fLN5etvnkFVToVMUs+nlGpHxtpPaILRIhSqjQOYSIhskfFDQS7NcX6J4HfTQAU8L3Vzr/rp7Y0EuepuB2M3aEQigcD5KPKLo0aRyVBLctv3vVgM9o5MIx8ghgfQTPPKmFszTZLhuvjM84T777IBKyDCe7hqeUyocypJnlkVQB6TYpo+evV3APG+kkxXZtJm0pLIUj30BUsME1lNGFHPwhu2dRpgpB8FhT9lQClnMa8r+UDNvTpUh6qJ2DU=

From: Steven Rostedt <rostedt@goodmis.org>

The newly added files show_event_filters and show_event_triggers that show
all filters or triggers that are set within the trace array do not take a
reference for the trace array it is showing. Without taking a reference,
the trace_array may be freed via "rmdir" while a task is reading one of
theses files. Those files iterate all the events within an instance
(trace_array) and nothing prevents that instance from being freed while
its data is being read. This causes a use-after-free crash.

Have the open of both those files take the trace_array reference via the
trace_array_get() that prevents the trace_array from being freed while the
files are opened.

Cc: stable@vger.kernel.org
Fixes: 729757b96a662 ("tracing: Add show_event_filters to expose active event filters")
Fixes: 6a80838814eea ("tracing: Add show_event_triggers to expose active event triggers")
Reported-by: Farhad Alemi <farhad.alemi@berkeley.edu>
Closes: https://lore.kernel.org/all/CA+0ovCjerKZJLwXScM9bF2ga2rLi4_XOpUfK41NDbENpeu98jA@mail.gmail.com/
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 28 ++++++++++++++++++++++++----
 1 file changed, 24 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1d39eaf6a0f7..9dbc2441763b 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -2736,14 +2736,14 @@ static const struct file_operations ftrace_show_event_filters_fops = {
 	.open = ftrace_event_show_filters_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_show_event_triggers_fops = {
 	.open = ftrace_event_show_triggers_open,
 	.read = seq_read,
 	.llseek = seq_lseek,
-	.release = seq_release,
+	.release = ftrace_event_release,
 };
 
 static const struct file_operations ftrace_set_event_pid_fops = {
@@ -2908,7 +2908,17 @@ ftrace_event_set_open(struct inode *inode, struct file *file)
 static int
 ftrace_event_show_filters_open(struct inode *inode, struct file *file)
 {
-	return ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = ftrace_event_open(inode, file, &show_show_event_filters_seq_ops);
+	if (ret < 0)
+		trace_array_put(tr);
+	return ret;
 }
 
 /**
@@ -2922,7 +2932,17 @@ ftrace_event_show_filters_open(struct inode *inode, struct file *file)
 static int
 ftrace_event_show_triggers_open(struct inode *inode, struct file *file)
 {
-	return ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
+	struct trace_array *tr = inode->i_private;
+	int ret;
+
+	ret = tracing_check_open_get_tr(tr);
+	if (ret)
+		return ret;
+
+	ret = ftrace_event_open(inode, file, &show_show_event_triggers_seq_ops);
+	if (ret < 0)
+		trace_array_put(tr);
+	return ret;
 }
 
 static int
-- 
2.53.0

