Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AFE7260E;
	Wed,  7 May 2025 23:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746659813; cv=none; b=AA8Q5oC9UVwMoH2qk2LtGg0e9u/UyQuLIDCg0Ig3d+dHF043Q1Rg/ssmhMsFBhrcCRQP5ZWXmjdTVn6r+UM+gqqattC9fDrXtW/gGMT6Sd7JJ4ggTPKQ7Ggr3oPE0JlGs24DFvqcrmpBtbRjzjcGSmQ/8CaNfV0FxGD2Txxke2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746659813; c=relaxed/simple;
	bh=KEJ5IX9gnIkoWzzGKeKugwgnHRS6mR6NHFzr1X4CnSY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RiskhOej+PRh1aWPt3ihBEkZrmJza1cBCd65I8s02QUIKGSf2CBsvhJvtDT7gSa+z3W9VC/fn6RA/+aCRnjjrdoFe3EPzrOwDRO2wXiB9T/KO6HunIH4+mmWkQ0cBfn8khOaxHqD4Rxe1SGFmwn1wTRpALF2JiP2vA67728wUyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B47CC4CEE2;
	Wed,  7 May 2025 23:16:52 +0000 (UTC)
Date: Wed, 7 May 2025 19:17:03 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH v2] tracing: Add a helper function to handle the dereference
 arg in verifier
Message-ID: <20250507191703.5dd8a61d@gandalf.local.home>
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

Add a helper function called handle_dereference_arg() to replace the logic
that is identical in two locations of test_event_printk().

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v1: https://lore.kernel.org/20250424151021.44b68ba8@gandalf.local.home

- Fixed order of parameters in handle_dereference_arg() as len and
  string_flags were reversed, causing it to fail on pretty much all events!
  I did post v1 because it was sitting in my repo and I needed to do more
  work on other things in that repo, but I obviously never tested it!

 kernel/trace/trace_events.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 069e92856bda..13cb899ba4fc 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -400,6 +400,20 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
 	return true;
 }
 
+static void handle_dereference_arg(const char *arg_str, u64 string_flags, int len,
+				   u64 *dereference_flags, int arg,
+				   struct trace_event_call *call)
+{
+	if (string_flags & (1ULL << arg)) {
+		if (process_string(arg_str, len, call))
+			*dereference_flags &= ~(1ULL << arg);
+	} else if (process_pointer(arg_str, len, call))
+		*dereference_flags &= ~(1ULL << arg);
+	else
+		pr_warn("TRACE EVENT ERROR: Bad dereference argument: '%.*s'\n",
+			len, arg_str);
+}
+
 /*
  * Examine the print fmt of the event looking for unsafe dereference
  * pointers using %p* that could be recorded in the trace event and
@@ -563,11 +577,9 @@ static void test_event_printk(struct trace_event_call *call)
 			}
 
 			if (dereference_flags & (1ULL << arg)) {
-				if (string_flags & (1ULL << arg)) {
-					if (process_string(fmt + start_arg, e - start_arg, call))
-						dereference_flags &= ~(1ULL << arg);
-				} else if (process_pointer(fmt + start_arg, e - start_arg, call))
-					dereference_flags &= ~(1ULL << arg);
+				handle_dereference_arg(fmt + start_arg, string_flags,
+						       e - start_arg,
+						       &dereference_flags, arg, call);
 			}
 
 			start_arg = i;
@@ -578,11 +590,9 @@ static void test_event_printk(struct trace_event_call *call)
 	}
 
 	if (dereference_flags & (1ULL << arg)) {
-		if (string_flags & (1ULL << arg)) {
-			if (process_string(fmt + start_arg, i - start_arg, call))
-				dereference_flags &= ~(1ULL << arg);
-		} else if (process_pointer(fmt + start_arg, i - start_arg, call))
-			dereference_flags &= ~(1ULL << arg);
+		handle_dereference_arg(fmt + start_arg, string_flags,
+				       i - start_arg,
+				       &dereference_flags, arg, call);
 	}
 
 	/*
-- 
2.47.2

