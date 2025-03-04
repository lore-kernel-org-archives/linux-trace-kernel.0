Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6269927933B;
	Tue,  4 Mar 2025 23:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741130123; cv=none; b=UTLuG4cYowytoR/lFBHFDU/RJoLE4r/ZzGuk75r5DrjbAXlZUHGLw/gGvW28uMp30oo9eoUKfIrVIJKNYBpbluLSxmKBucpCFdoOS4FLejHrqTqfZyQLIQTHYOcCVCBJmYHso11DGSVWK2tpnf7fyTSSUL5VKKi79BzoEpXYi9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741130123; c=relaxed/simple;
	bh=+QANBucFIezUoXX7P8kYb2sbC27r0CAnf9rNssJhRm8=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=glULuwBFJfNPGixmY2d6hRY0Uv49nMVJY0Z05Pk4x44/QrI5Y9frbAtURH362JCoW+vSHErgPONV/DbPDL+zLD8F8QlZpvvXi9RIYvJR6pHQufOliHAp7qxmSikE8eg9b2eYu/0BsNl1IVhOr0MFay9DyzytPkDDZuozkLTNAFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5F07C4CEE8;
	Tue,  4 Mar 2025 23:15:22 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1tpbUo-0000000CSau-39dy;
	Tue, 04 Mar 2025 18:16:18 -0500
Message-ID: <20250304231618.602571527@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 04 Mar 2025 18:15:49 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4/4] tracing: Adjust addresses for printing out fields
References: <20250304231545.708806702@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

Add adjustments to the values of the "fields" output if the buffer is a
persistent ring buffer to adjust the addresses to both the kernel core and
kernel modules if they match a module in the persistent memory and that
module is also loaded.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_output.c | 38 ++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index 3a43128e604a..aa716cf69caa 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -857,6 +857,9 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 			 struct list_head *head)
 {
 	struct ftrace_event_field *field;
+	struct trace_array *tr = iter->tr;
+	unsigned long long laddr;
+	unsigned long addr;
 	int offset;
 	int len;
 	int ret;
@@ -893,8 +896,8 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 		case FILTER_PTR_STRING:
 			if (!iter->fmt_size)
 				trace_iter_expand_format(iter);
-			pos = *(void **)pos;
-			ret = strncpy_from_kernel_nofault(iter->fmt, pos,
+			addr = trace_adjust_address(tr, *(unsigned long *)pos);
+			ret = strncpy_from_kernel_nofault(iter->fmt, (void *)addr,
 							  iter->fmt_size);
 			if (ret < 0)
 				trace_seq_printf(&iter->seq, "(0x%px)", pos);
@@ -903,8 +906,8 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 						 pos, iter->fmt);
 			break;
 		case FILTER_TRACE_FN:
-			pos = *(void **)pos;
-			trace_seq_printf(&iter->seq, "%pS", pos);
+			addr = trace_adjust_address(tr, *(unsigned long *)pos);
+			trace_seq_printf(&iter->seq, "%pS", (void *)addr);
 			break;
 		case FILTER_CPU:
 		case FILTER_OTHER:
@@ -934,24 +937,25 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 					break;
 				}
 
-				if (sizeof(long) == 4)
+				addr = *(unsigned int *)pos;
+				if (sizeof(long) == 4) {
+					addr = trace_adjust_address(tr, addr);
 					trace_seq_printf(&iter->seq, "%pS (%d)",
-							 *(void **)pos,
-							 *(unsigned int *)pos);
-				else
+							 (void *)addr, (int)addr);
+				} else {
 					trace_seq_printf(&iter->seq, "0x%x (%d)",
-							 *(unsigned int *)pos,
-							 *(unsigned int *)pos);
+							 (unsigned int)addr, (int)addr);
+				}
 				break;
 			case 8:
-				if (sizeof(long) == 8)
+				laddr = *(unsigned long long *)pos;
+				if (sizeof(long) == 8) {
+					laddr = trace_adjust_address(tr, (unsigned long)laddr);
 					trace_seq_printf(&iter->seq, "%pS (%d)",
-							 *(void **)pos,
-							 *(unsigned long long *)pos);
-				else
-					trace_seq_printf(&iter->seq, "0x%llx (%lld)",
-							 *(unsigned long long *)pos,
-							 *(unsigned long long *)pos);
+							 (void *)laddr, laddr);
+				} else {
+					trace_seq_printf(&iter->seq, "0x%llx (%lld)", laddr, laddr);
+				}
 				break;
 			default:
 				trace_seq_puts(&iter->seq, "<INVALID-SIZE>");
-- 
2.47.2


