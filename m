Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 028C431B823;
	Tue, 30 Jun 2026 22:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782859721; cv=none; b=YPrNj9oKrC3a5c5m5SkDxBa0qfPcG4HFbxLr8tLkEMOBHU2cnMw210CwmUAxKKin+Fhh4tCz1miHFQNzn0NFveSfhpU1BUr/M7c/8cTAkln0S4XQO4dm4i9p7yDGJZM5lz/LHWltLjQqq8f3PGkE3tvjUXcKR7KVRsp/UfqOZaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782859721; c=relaxed/simple;
	bh=N7GQYOrkrSTg/gcpRmGcDLd2Ufr/tpiBtdWyE04VeY0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=GcP6zxKdzoYJjvUTuU/Ca5iRrUNkDBxmJq+Hs1OymNICk9UDJbszZj5UzAs8GK1cyNQfoEaKk78szdhDEWFc059Fhzf2/FRVo0PsXXjiPoyxI83XDIY/1M4VO7AckQHSUxAy5qTOjyvZYvU63pMkvgAZf7A1fEzdzzuXcYqMyqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id DB13C1C4A71;
	Tue, 30 Jun 2026 22:48:38 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 0ED4F2F;
	Tue, 30 Jun 2026 22:48:36 +0000 (UTC)
Date: Tue, 30 Jun 2026 18:48:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Martin Kaiser <martin@kaiser.cx>, Frank
 Li <Frank.Li@nxp.com>, Vinod Koul <vkoul@kernel.org>
Subject: [PATCH] tracing: Warn when an event dereferences a pointer in
 TP_printk()
Message-ID: <20260630184836.74d477b6@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 0ED4F2F
X-Stat-Signature: 7h1q56tfmngdcoc7psyugimoy3gx4n98
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/nXMMFi7/fn457MBqMXxLZzxcGyFVfkKo=
X-HE-Tag: 1782859716-356376
X-HE-Meta: U2FsdGVkX18LxOcWYBCT7e0Y0lCGmfK+iuta7pVTBeIoiueIubvTYNe2lkG/Kay4d8n3KD9Q/97Aa6d/shQJRvy8j2EnQdoEykZEuhnciVXbosuQvCYHTPGWM5T1KELgP1xrTL8K/SSsMfci85Q0DR7CM7zcQlXLwC9OLlfR/MM+CbIy+oZluENm+kNFazRmTPtMt7+w5UumYOrCBQF4RRqNriyhW4n0XRoil6KX5VKti4qU7Cvm8yTWdILj0AXYui4XSgWAUwG3FFrqXrtnPznjLCA/a05Mm7Upm4i4gjc8uu+JzhtJH7eVqxyCHgdwLVx2+e1CpcimotFVq6rfRAWHUifDvEMbDSoP877XHZfrhXfSqRkKfeOpXVeAUQWl6TNyN9p5kNPHgklYgsnmlA==

From: Steven Rostedt <rostedt@goodmis.org>

Currently on boot up and when modules are loaded, the trace event
infrastructure will examine the TP_printk's of every event looking to see
if it dereferences pointers on the ring buffer via printk formats like
"%pB" and such. What it doesn't do is check if the arguments themselves
do a dereference from a pointer.

This was brought with a fix[1] to the fsl_edma event that had in the
arguments of the TP_printk(): "__entry->edma->membase"

The __entry->edma is a pointer saved in the ring buffer. The dereference
from TP_printk() happens when the user reads the "trace" file which can be
seconds, minutes, hours, days, weeks, or even months later! There is no
guarantee that the __entry->edma pointer will still be pointing to what it
was when it was recorded, and could crash the kernel when a user reads the
event.

Add logic to the test_event_printk() that also checks for this case and
warn if the event dereferences a pointer from the ring buffer.

[1] https://lore.kernel.org/all/20260630200022.1826420-1-martin@kaiser.cx/

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index c46e623e7e0d..3b52bfd8b300 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -400,6 +400,31 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
 	return true;
 }
 
+static void test_double_dereference(const char *str, int len,
+				    struct trace_event_call *call)
+{
+	const char *ptr;
+	const char *end = str + len;
+
+	ptr = strstr(str, "REC->");
+
+	while (ptr && ptr < end) {
+
+		ptr += 5;
+		for (; ptr < end; ptr++) {
+			if (ptr[0] == '-' && ptr[1] == '>') {
+				WARN_ONCE(1, "Event %s has double dereference in TP_printk: %.*s\n",
+					  trace_event_name(call), len, str);
+				return;
+			}
+			if (!isalnum(*ptr) && *ptr != '_')
+				break;
+		}
+
+		ptr = strstr(ptr, "REC->");
+	}
+}
+
 static void handle_dereference_arg(const char *arg_str, u64 string_flags, int len,
 				   u64 *dereference_flags, int arg,
 				   struct trace_event_call *call)
@@ -459,12 +484,6 @@ static void test_event_printk(struct trace_event_call *call)
 				if (in_quote) {
 					arg = 0;
 					first = false;
-					/*
-					 * If there was no %p* uses
-					 * the fmt is OK.
-					 */
-					if (!dereference_flags)
-						return;
 				}
 			}
 			if (in_quote) {
@@ -576,6 +595,8 @@ static void test_event_printk(struct trace_event_call *call)
 				continue;
 			}
 
+			test_double_dereference(fmt + start_arg, e - start_arg, call);
+
 			if (dereference_flags & (1ULL << arg)) {
 				handle_dereference_arg(fmt + start_arg, string_flags,
 						       e - start_arg,
@@ -589,6 +610,8 @@ static void test_event_printk(struct trace_event_call *call)
 		}
 	}
 
+	test_double_dereference(fmt + start_arg, i - start_arg, call);
+
 	if (dereference_flags & (1ULL << arg)) {
 		handle_dereference_arg(fmt + start_arg, string_flags,
 				       i - start_arg,
-- 
2.53.0

