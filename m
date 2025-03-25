Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2912A190696;
	Tue, 25 Mar 2025 22:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742943336; cv=none; b=MlJlofzucUnlfj1H+5TDHh0Kkt3MgPJKLky767t3RYlbHhyprR324+NnZ4g6QuBv/homcWWyXN/vLT6hPLDCMGn6Nh0eh/5ySpQSbNjPmGtUEIxPhZhcZJoe2/qoV2Clw47cfxSNWnI3fXl0Ox9JHI+0AScK2shjKqoCtiFGS4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742943336; c=relaxed/simple;
	bh=2nQzsqOOrvKOqCo3drGiKKMEpjDeHpD3jFNBe8CNXk8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=dBpHdcGij29ZjINa1eFiTEt+XKhBUl71B6Fij/sPKWuqKfAv2ECa8pFvHOCHMNlDpGtSpbhaav8hySUxzxsZNKA2pAt4aCLePnfrriWFbhepKab4BCR1ZLJH7xgUnTpfFtpJN+6NiQIMlsRIxfiaRBpKZkqLd5w1QPSWImU1V5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3E12C4CEE9;
	Tue, 25 Mar 2025 22:55:34 +0000 (UTC)
Date: Tue, 25 Mar 2025 18:56:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Mark Rutland <mark.rutland@arm.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v3] tracing: Adjust addresses for printing out fields
Message-ID: <20250325185619.54b85587@gandalf.local.home>
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

Add adjustments to the values of the "fields" output if the buffer is a
persistent ring buffer to adjust the addresses to both the kernel core and
kernel modules if they match a module in the persistent memory and that
module is also loaded.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v2: https://lore.kernel.org/20250325213919.956212394@goodmis.org

- Fix 32 bit build when casting an unsigned long long to pointer,
  needs to be cast to (long) first. But this code isn't even run
  on 32 bit, but it is compiled on 32 bit.

 kernel/trace/trace_output.c | 38 ++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/kernel/trace/trace_output.c b/kernel/trace/trace_output.c
index ef6307a6ca5e..f88acc9257d5 100644
--- a/kernel/trace/trace_output.c
+++ b/kernel/trace/trace_output.c
@@ -858,6 +858,9 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
 			 struct list_head *head)
 {
 	struct ftrace_event_field *field;
+	struct trace_array *tr = iter->tr;
+	unsigned long long laddr;
+	unsigned long addr;
 	int offset;
 	int len;
 	int ret;
@@ -894,8 +897,8 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
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
@@ -904,8 +907,8 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
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
@@ -935,24 +938,25 @@ static void print_fields(struct trace_iterator *iter, struct trace_event_call *c
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
 					trace_seq_printf(&iter->seq, "%pS (%lld)",
-							 *(void **)pos,
-							 *(unsigned long long *)pos);
-				else
-					trace_seq_printf(&iter->seq, "0x%llx (%lld)",
-							 *(unsigned long long *)pos,
-							 *(unsigned long long *)pos);
+							 (void *)(long)laddr, laddr);
+				} else {
+					trace_seq_printf(&iter->seq, "0x%llx (%lld)", laddr, laddr);
+				}
 				break;
 			default:
 				trace_seq_puts(&iter->seq, "<INVALID-SIZE>");
-- 
2.47.2

