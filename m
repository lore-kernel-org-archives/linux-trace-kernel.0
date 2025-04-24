Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27CF521FF35;
	Thu, 24 Apr 2025 19:08:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745521707; cv=none; b=Vk1zCOmglhEtvcocjX1GylfZlCTZGX/sEwXOE8kFJ6cBRC1h4+rYwMbBje5+AmGpdp2pXU/kE9Vq8ECWi7E0hnw/mKj210XM2au70tRLoUKon/n3rsQmx/3iNxG3IdkOZfZdJLlddwTvDoOCsj93ZqsX0W1DT4Nm23wocq4L10U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745521707; c=relaxed/simple;
	bh=Yf9sXw/UlTUazDPxNOmboYkPQK21JXMvFxWantmoco8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=mTQbtiuZfWL2wY5HlsaRXdOMAs9sgeYEMnS66hDYhPEkUB9A7mmFoEER6pE20z7N+jbkihP8Hgu6bTcGt3uzRd3KC3Das0OQQZWBb+mJgMu8h3JGz0MTvFN+wVUButnQ/jBQb+aZaT1yHQrFVr7PInfWpBw8pKG11r4o/1Hl8gI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13BD8C4CEE3;
	Thu, 24 Apr 2025 19:08:25 +0000 (UTC)
Date: Thu, 24 Apr 2025 15:10:21 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing: Add a helper function to handle the dereference
 arg  in verifier
Message-ID: <20250424151021.44b68ba8@gandalf.local.home>
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
This was laying around in my git repo. I should post it so it doesn't get lost!

 kernel/trace/trace_events.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 069e92856bda..addbd2a3ff08 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -400,6 +400,20 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
 	return true;
 }
 
+static void handle_dereference_arg(const char *arg_str, int len, u64 string_flags,
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

