Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B5B2E1F0E;
	Fri, 17 Jul 2026 02:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784256714; cv=none; b=FnwiM9CfgR6iV0xwUGkEJFGwFCiU0CfrwyqPVMvn9xEXOzIXD6PMiMfkBEgtfH/TrSTSt3Bto/V8XFnqliDuUaJlLohNCtclPjPb5ukslcfYejKdc/7u03bi1ykv5jPitDOTNAXH6lFD/TcpTw3J2gmY6cHjmXRSrWVRdJU2dK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784256714; c=relaxed/simple;
	bh=AZBuvF/JiGjkI0GY0nfg66hanlHMnZt2sIkfpTYT5l4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exypU+vLK+QZe5DGYrvdVophFaRDgOR+Sz6b6x6gVo5IEWAD6DcRaeAnE8Ddlj4uFW1oL32vThBmNfGIOG6PX2mT67jcXH0gYdnmRT7hfIURFfcvx9Tm1EbUJ+NSydBwMv+2RMMo9W32KjGRqsIm8+lwjaFWhqtc4xXALNdxo4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Urn2tF3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Urn2tF3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE08A1F000E9;
	Fri, 17 Jul 2026 02:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784256713;
	bh=2j41jQ4VyMjbKw1CgFx/F2O11DFMdBFFOuvz8Gmn3LY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Urn2tF3+nhkffIWVJZNbXANtVvNGcVaywC2BnoRD++wwGfziU9jcDbgyCR4j6G6C9
	 +jNjAv5J7lo6kP3JDvhPHpW90+g5WYwpdavJHwlHCqBa+J3gDvd9B66Ll1U6ufGbP1
	 Ukpy2nd18ZCT/wh0N8CaBEfEcooXprfAqhYhQatQXrV5NKZdXNko/TeCLOCxQ3hOmy
	 IARnb6j1C486EFsQyqbqZ6hRmwgzebfiwvDznl4VukodrcEC2vpW7MZqJYkUWZdq9u
	 x0gv6unUkQhDp7OaUc9Z9YpDJ4tASwEp1vC1T2OBzOb2cJzxKbMc0pB2ZwoY3uY/2/
	 zM/AyQIDY8Y8w==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH 1/2] tracing: Fix union collision of module and refcnt for dynamic events
Date: Fri, 17 Jul 2026 11:51:49 +0900
Message-ID: <178425670947.84440.11344393611899824907.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178425669965.84440.3214667180548169854.stgit@devnote2>
References: <178425669965.84440.3214667180548169854.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In 'struct trace_event_call', the 'module' pointer and the 'refcnt'
atomic variable share the same memory space in a union. For dynamic
events, the union member is 'refcnt', which acts as an active
reference counter.

When a dynamic event (such as kprobe, uprobe, fprobe, eprobe, or
wprobe) has a non-zero reference count (e.g. due to active event
triggers or perf attachments), its 'call->module' evaluates to a
small non-zero integer instead of NULL.

When filtering or setting events for a specific module (e.g., writing
':mod:<module>' to 'set_event'), the code in
'__ftrace_set_clr_event_nolock()' and 'update_event_fields()' reads
'call->module' directly without checking whether the event is dynamic.
This causes the kernel to treat the small integer (refcnt) as a
'struct module' pointer, leading to a NULL/invalid pointer dereference
(Oops) when dereferencing the module name.

Fix this by ensuring that the 'TRACE_EVENT_FL_DYNAMIC' flag is checked
before treating 'call->module' as a valid pointer in these code paths.

Fixes: 4c86bc531e60 ("tracing: Add :mod: command to enabled module events")
Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_events.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..956692856fa8 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1350,7 +1350,9 @@ __ftrace_set_clr_event_nolock(struct trace_array *tr, const char *match,
 		call = file->event_call;
 
 		/* If a module is specified, skip events that are not that module */
-		if (module && (!call->module || strcmp(module_name(call->module), module)))
+		if (module &&
+		    ((call->flags & TRACE_EVENT_FL_DYNAMIC) ||
+		     !call->module || strcmp(module_name(call->module), module)))
 			continue;
 
 		name = trace_event_name(call);

