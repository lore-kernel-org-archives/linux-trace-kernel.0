Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97BE1A2550;
	Tue, 21 Jan 2025 20:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737490413; cv=none; b=khiSQ/h/pr7pCn/zDKwePPbjJo8/9THc1zNWmUG2Czu7RGUPPf2MU9e6wKlswEoVzWF6r6RnTwLkK6CQFL8aKlAv6PNuKUFoCvYTqyqQN+Iv0wEvZoFWouKE2kfh++NZv9JAe57nfkZA/DKFxcwvIGqZa2Gdn7IJ5Fon6OmBmw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737490413; c=relaxed/simple;
	bh=tUYwUbLustRlZhF1ah004WlmBk0ECj93b4lADl0TbzM=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tIUCYekVxDhKKZTxNGLNKlMv0TvtsZJkIvGl3gSm69i2erd7e5FjsrZ7kP//L+LfTF4QoSa3p1wXZO4FrCJ9Yibx5zfIwc3E1aAw+nNAL/8mgoJy1EvCZRm11BfXADg4rDhOsRIyQ836++nYAe22Dyu7W5orqaMX/irgGQeY088=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94ABC4CEE1;
	Tue, 21 Jan 2025 20:13:32 +0000 (UTC)
Date: Tue, 21 Jan 2025 15:13:36 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Fix output of set_event for some cached module
 events
Message-ID: <20250121151336.6c491844@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

The following works fine:

 ~# echo ':mod:trace_events_sample' > /sys/kernel/tracing/set_event
 ~# cat /sys/kernel/tracing/set_event
 *:*:mod:trace_events_sample
 ~#

But if a name is given without a ':' where it can match an event name or
system name, the output of the cached events does not include a new line:

 ~# echo 'foo_bar:mod:trace_events_sample' > /sys/kernel/tracing/set_event
 ~# cat /sys/kernel/tracing/set_event
 foo_bar:mod:trace_events_sample~#

Add the '\n' to that as well.

Fixes: b355247df104e ("tracing: Cache ":mod:" events for modules not loaded yet")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 5217dcddcb4c..a9d7d02bbb20 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1634,7 +1634,7 @@ static int s_show(struct seq_file *m, void *v)
 
 	/* When match is set, system and event are not */
 	if (iter->event_mod->match) {
-		seq_printf(m, "%s:mod:%s", iter->event_mod->match,
+		seq_printf(m, "%s:mod:%s\n", iter->event_mod->match,
 			   iter->event_mod->module);
 		return 0;
 	}
-- 
2.45.2

