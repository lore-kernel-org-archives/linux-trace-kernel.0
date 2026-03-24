Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F9571FC7C5;
	Tue, 24 Mar 2026 00:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774311701; cv=none; b=To70o8Obon1yfP6vSLfTBfJFyjyqfNP2RhjGz5xthRUkRZxjeItENZu2r4Geu49AlJ153FKubpru+nTTzYwGjxNQ+ZZSla8Ni5z3LYNy5F27Z1JZVYDPBuWlJt4XCvTcSQU3BV5vObpT+dBDjIF+ePvBLs1nrDlDQ2r7Qeb2Ccg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774311701; c=relaxed/simple;
	bh=kXXoDMyLxVdgrrKH5qCQomP/ptGtPZoUwdQNCdFMkuc=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=rDi7+WqVnCGw3uK8tM6V8T3uWBV/9GmoYp/M9IJNVKuye9vvNv0Tx2wSSjomh3QMq3coKWjqx7gxNcDKlUIc7PLB6YeYpwk0nUWCZqvX3SeJi9srYN9Qx858lCXjfGPZn2XchuTy3IgCTtcLu/JZNhqeinXkt/bIfswKwVks2RM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id D7D511A0D45;
	Tue, 24 Mar 2026 00:21:33 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 3D53140;
	Tue, 24 Mar 2026 00:21:32 +0000 (UTC)
Date: Mon, 23 Mar 2026 20:22:12 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] ring-buffer: Show what clock function is used on timestamp
 errors
Message-ID: <20260323202212.479bb288@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 3D53140
X-Rspamd-Server: rspamout06
X-Stat-Signature: 1g7yo7zbrh7rrtteaqe1prpu8dn76zmw
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ps0LczAkQx1nMIbSrVmZB83k3OXf0WLE=
X-HE-Tag: 1774311692-478615
X-HE-Meta: U2FsdGVkX1/6guAhYVQbShVpsJukE4Ig0ANddwQ7tIEFB6BBYjgDxXo/kN9rfas0Jjc5zpJEVE6TaDAemGXwKsdYLVb8kpwIl/qjHSGVbcm5FvWwM1PUjDIbQxcbPZzgiT9UXTWUuy5F6nAeR96l5+P7EuilPnWPhE+dYWIRXXdk2/17mBxKaek6lyVOuwiRnk9kS2Jof+RpR0h9RvQjno7tvNNZYspYdCcbgT/KAvXBuHItJaX3fObq1jloGLpKi9tjbffrF+I1lhCOmMQYiku4QlA8dEmsdzq/W4LQK80gr1gvjf5/YN9Qa2BmO6bAr6LyapRJjMyUXwcnhTHEbMmZtS2bBXEyTm+lesqtxcFhr4ZtlpAW2XDwQ5W6zTaM

From: Steven Rostedt <rostedt@goodmis.org>

The testing for tracing was triggering a timestamp count issue that was
always off by one. This has been happening for some time but has never
been reported by anyone else. It was finally discovered to be an issue
with the "uptime" (jiffies) clock that happened to be traced and the
internal recursion caused the discrepancy. This would have been much
easier to solve if the clock function being used was displayed when the
error was detected.

Add the clock function to the error output.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ring_buffer.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 170170bd83bd..a99d1c7d180b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -4435,18 +4435,20 @@ static void check_buffer(struct ring_buffer_per_cpu *cpu_buffer,
 	ret = rb_read_data_buffer(bpage, tail, cpu_buffer->cpu, &ts, &delta);
 	if (ret < 0) {
 		if (delta < ts) {
-			buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld\n",
-					   cpu_buffer->cpu, ts, delta);
+			buffer_warn_return("[CPU: %d]ABSOLUTE TIME WENT BACKWARDS: last ts: %lld absolute ts: %lld clock:%pS\n",
+					   cpu_buffer->cpu, ts, delta,
+					   cpu_buffer->buffer->clock);
 			goto out;
 		}
 	}
 	if ((full && ts > info->ts) ||
 	    (!full && ts + info->delta != info->ts)) {
-		buffer_warn_return("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s context:%s\n",
+		buffer_warn_return("[CPU: %d]TIME DOES NOT MATCH expected:%lld actual:%lld delta:%lld before:%lld after:%lld%s context:%s\ntrace clock:%pS",
 				   cpu_buffer->cpu,
 				   ts + info->delta, info->ts, info->delta,
 				   info->before, info->after,
-				   full ? " (full)" : "", show_interrupt_level());
+				   full ? " (full)" : "", show_interrupt_level(),
+				   cpu_buffer->buffer->clock);
 	}
 out:
 	atomic_dec(this_cpu_ptr(&checking));
-- 
2.51.0

