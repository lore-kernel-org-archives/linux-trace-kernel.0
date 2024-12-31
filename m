Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F04126C1E;
	Tue, 31 Dec 2024 05:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735621538; cv=none; b=nWXeZSO8b1xd65t1gewkusrzsjLMHpjbuKowIXEbczdCxuYr6CPIDeMjUDDsWjczthHO7xF5Pix205V737Ji9VwN3RcEPS1Fz8pLFAvLg/+zn6ZowItEKRSnKvOl9/vcbnnbPZ/BlRmIxa5/8R2aMgR9kviEL5ZFsGdQfu5Lkfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735621538; c=relaxed/simple;
	bh=neNh6c1n3zyYAlnNmgvacgMHbNJf8iLseChrfpbwjlo=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=tx7mT/VvPG0psUAA9dQSrOJ2dbLmJzU6FMsKHSNElPg+Xq2FXe7gwt+cBdMf2ZmSvfjyUOz7kZEU8aYm8C/FhBB62aiCN5cvYRRcCHiT5wnauNTh4JIvS/2PksQgavotRkso9ZPCa64pyBXZ+o/vz09ANLUCYpvL9/sOrQ8kIBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6E31C4CECD;
	Tue, 31 Dec 2024 05:05:36 +0000 (UTC)
Date: Tue, 31 Dec 2024 00:06:46 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Genes Lists <lists@sapience.com>, Gene C
 <arch@sapience.com>
Subject: [PATCH] tracing: Have process_string() also allow arrays
Message-ID: <20241231000646.324fb5f7@gandalf.local.home>
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

In order to catch a common bug where a TRACE_EVENT() TP_fast_assign()
assigns an address of an allocated string to the ring buffer and then
references it in TP_printk(), which can be executed hours later when the
string is free, the function test_event_printk() runs on all events as
they are registered to make sure there's no unwanted dereferencing.

It calls process_string() to handle cases in TP_printk() format that has
"%s". It returns whether or not the string is safe. But it can have some
false positives.

For instance, xe_bo_move() has:

 TP_printk("move_lacks_source:%s, migrate object %p [size %zu] from %s to %s device_id:%s",
            __entry->move_lacks_source ? "yes" : "no", __entry->bo, __entry->size,
            xe_mem_type_to_name[__entry->old_placement],
            xe_mem_type_to_name[__entry->new_placement], __get_str(device_id))

Where the "%s" references into xe_mem_type_to_name[]. This is an array of
pointers that should be safe for the event to access. Instead of flagging
this as a bad reference, if a reference points to an array, where the
record field is the index, consider it safe.

Link: https://lore.kernel.org/all/9dee19b6185d325d0e6fa5f7cbba81d007d99166.camel@sapience.com/

Cc: stable@vger.kernel.org
Fixes: 65a25d9f7ac02 ("tracing: Add "%s" check in test_event_printk()")
Reported-by: Genes Lists <lists@sapience.com>
Tested-by: Gene C <arch@sapience.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1545cc8b49d0..770e7ed91716 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -364,6 +364,18 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
 		s = r + 1;
 	} while (s < e);
 
+	/*
+	 * Check for arrays. If the argument has: foo[REC->val]
+	 * then it is very likely that foo is an array of strings
+	 * that are safe to use.
+	 */
+	r = strstr(s, "[");
+	if (r && r < e) {
+		r = strstr(r, "REC->");
+		if (r && r < e)
+			return true;
+	}
+
 	/*
 	 * If there's any strings in the argument consider this arg OK as it
 	 * could be: REC->field ? "foo" : "bar" and we don't want to get into
-- 
2.45.2

