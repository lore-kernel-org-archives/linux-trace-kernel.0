Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 974D04503B;
	Fri,  2 May 2025 02:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746153690; cv=none; b=LHbpaiP/u17g+jPPyPie0V9NA7mp7ex12LywL9M51oRFyII6FlPJXUf/CrgNe2bs5TKkFVMbM5knqn6wm9AP9eyj99iBb8QUT5G7yoDhoo4LFjPPq6HG5TlByVdHVlsKQuunsgDC+JJPaGq0PX2VcsLPd8Onon5IIT3KJfGzYGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746153690; c=relaxed/simple;
	bh=R6N13CcjaQ5R6swn2YwkSJbx4AQnYnjKfIOWz1tRGvE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=WFgM81Ts1819Klnrq5HPF0cKWZGZ/MeI3HfM+LsGzNDAO2AVdGx/jHwKtgLMQI540Nc2b7MV1IiFlFbsDxLLIiyzDV5VLi5vOWt6EujanQD2SKWYxMePkzrk3y9BSTJ1wqM11i5ZC2i1fkUqakHL2Vfemr13dZEoKaRfX8uxQOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76B1DC4CEE3;
	Fri,  2 May 2025 02:41:29 +0000 (UTC)
Date: Thu, 1 May 2025 22:41:28 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux trace kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>,
 syzbot+441582c1592938fccf09@syzkaller.appspotmail.com
Subject: [PATCH] tracing: Do not take trace_event_sem in
 print_event_fields()
Message-ID: <20250501224128.0b1f0571@batman.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

From: Steven Rostedt <rostedt@goodmis.org>

On some paths in print_event_fields() it takes the trace_event_sem for
read, even though it should always be held when the function is called.

Remove the taking of that mutex and add a lockdep_assert_held_read() to
make sure the trace_event_sem is held when print_event_fields() is called.

Cc: stable@vger.kernel.org
Fixes: 80a76994b2d88 ("tracing: Add "fields" option to show raw trace event fields")
Reported-by: syzbot+441582c1592938fccf09@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6813ff5e.050a0220.14dd7d.001b.GAE@google.com/
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index c5e8299d1842..aa0d3663f754 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -1056,11 +1056,12 @@ enum print_line_t print_event_fields(struct trace_iterator *iter,
 	struct trace_event_call *call;
 	struct list_head *head;
 
+	lockdep_assert_held_read(&trace_event_sem);
+
 	/* ftrace defined events have separate call structures */
 	if (event->type <= __TRACE_LAST_TYPE) {
 		bool found = false;
 
-		down_read(&trace_event_sem);
 		list_for_each_entry(call, &ftrace_events, list) {
 			if (call->event.type == event->type) {
 				found = true;
@@ -1070,7 +1071,6 @@ enum print_line_t print_event_fields(struct trace_iterator *iter,
 			if (call->event.type > __TRACE_LAST_TYPE)
 				break;
 		}
-		up_read(&trace_event_sem);
 		if (!found) {
 			trace_seq_printf(&iter->seq, "UNKNOWN TYPE %d\n", event->type);
 			goto out;
-- 
2.47.2

