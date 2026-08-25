Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A22C1D63E4;
	Tue, 25 Aug 2026 23:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787699409; cv=none; b=pfrhCFJm64LVwJCkCOC19cYUHvt4djQ+OwFittpCspf3NPckAIASljXrMH/X/JM2aA6GM6jEaOKs6GaeCoPlktRDMFCnK0gQYVXcfR70zqTjKf7y6WdsORRWErsfQ8uU49gb/W7TZIKfQ8IqSLPdKYPz4wTdPaF7yE99KRROekE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787699409; c=relaxed/simple;
	bh=bX4p42S0i9PqbEomc8acX+mDF5bQpmOTQHr5Vo2ByEw=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=f4HEIrENsiu6l3MKMR1tXenNtNhJt74brfcugRDUf8ofwKlpdfwcJ7L4vvaZ+WlOIVRWA6N4KexEp48MMhVgQu8RzrQeK2XLoXJ4hC6yPhBOTJTXhnfVh2/9XUNv50B4l/dskpQGHu5qpimnw/oGokhDfgCAmp3j/NtdZzhv+yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=eUOqVzPY; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="eUOqVzPY"
Received: from omf05.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id 7CF5FC01C3;
	Tue, 25 Aug 2026 23:09:59 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf05.hostedemail.com (Postfix) with ESMTPA id D3CCC20011;
	Tue, 25 Aug 2026 23:09:57 +0000 (UTC)
Date: Tue, 25 Aug 2026 19:10:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH] ftrace: Have stacktrace option work with func-args
Message-ID: <20260825191036.11b19036@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: owjd1gpryyqkx6rbaxkyqt9omq1jebtg
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: D3CCC20011
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/3/p6C3kalmWgFcceesFvvINIGAAxuNI8=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=rZuI269GnrkZUGqGLS8y2U/hXE/iTdz/IPtRXzeAPlA=; b=eUOqVzPYqZixMzKF0rLgUsHos8S7rRo+3HCTmAaFmwukI8PGtRnPfMGazn6YMFpu+7lC+2/wYsxhhFnK2Zf48P5mktYm5CsvAzNwSt3DmWEGcbmfJKr4BotFXv9Owb59USZkLHobNSIYXxeuaHg7FQmOh9xAIxuWPsNwOekzNwU=
X-HE-Tag: 1787699397-2062
X-HE-Meta: U2FsdGVkX1/2KIBp20xyYlQxd3hkL63Qdnr6uDClIlnA90S6bChXgJD1jQVG5918tgsLnef9b0+ny4t+SAdI1kXdthY0sD5YlPumMhigFBwVXRG/0EbNFcghhz2cQHKRcJf3VXZWVWd8hR+oVe6V9BFo8pIaiunBRkBJq2P6qwy5m/Gbi9mLMdnX1RGfONKIIogKg148UuvudXhP0TUBs6V8ot13qLox5s/4JsuCtht50/UVCC71ZhFJjceLxihiX69uQ9aWih5zsitjw4BYlb9kJgwbkgajX0jy0gl1a8y/krpOg1XOg/+lqNy9Urnmhh9I3VE8liq7iCXlVs9AZJZiRpkvVxhVs+VMT1Uao3rFWHwHL9eivCVcHCe+mtTz3Jg/qiWxs0vX4+flsme+eg==

From: Steven Rostedt <rostedt@goodmis.org>

When both the func_stack_trace option is enabled first, the func-args
option can not be enabled. Same if the func-args option is enabled first,
the func_stack_trace option can not be enabled.

Allow the two to work together. The stack trace is already slow and
testing the current tracer flags should be in the noise of overhead.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_functions.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_functions.c
index cd37f2013758..5604cf3ac78f 100644
--- a/kernel/trace/trace_functions.c
+++ b/kernel/trace/trace_functions.c
@@ -121,6 +121,7 @@ static ftrace_func_t select_trace_function(u32 flags_val)
 	case TRACE_FUNC_OPT_ARGS:
 		return function_args_trace_call;
 	case TRACE_FUNC_OPT_STACK:
+	case TRACE_FUNC_OPT_STACK | TRACE_FUNC_OPT_ARGS:
 		return function_stack_trace_call;
 	case TRACE_FUNC_OPT_NO_REPEATS:
 		return function_no_repeats_trace_call;
@@ -295,7 +296,9 @@ function_stack_trace_call(unsigned long ip, unsigned long parent_ip,
 
 	if (likely(disabled == 1)) {
 		trace_ctx = tracing_gen_ctx_flags(flags);
-		trace_function(tr, ip, parent_ip, trace_ctx, NULL);
+		if (!(tr->current_trace_flags->val & TRACE_FUNC_OPT_ARGS))
+			fregs = NULL;
+		trace_function(tr, ip, parent_ip, trace_ctx, fregs);
 #ifdef CONFIG_UNWINDER_FRAME_POINTER
 		if (ftrace_pids_enabled(op))
 			skip++;
-- 
2.53.0

