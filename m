Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B08269832;
	Tue, 25 Mar 2025 21:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742938715; cv=none; b=Fogs8/7D0nTcpogb0QnZHzkcTDk2H1S5Lw9GeMUefTPF6543W6Mm6Pik4Js7MsK9FF/kr4ks2VIvdmYFBGUU73kNjuWz3qxMvcfSaxd0rj8ADbfjV4vPQnTMKp0ONYkcdbjQ6NMixHh1j6942fZyCKhp3lnAZWgyb6MbIQHXKZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742938715; c=relaxed/simple;
	bh=DCqrSTfmI5vswBtdCaqaQlsdbtXpfTz+Aj7iIMYUWNU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=JPKHGK2b+PbmGPX3YRl/JoVKvzxLMwpqbu7vnmCVYZCye4KtEg75jgV7YWsvmIn8hBJR2WDscH7rliJi6Qs0MaEsqdDyVg9tn2Q7WYZrHijf8VOJJjNPHVj4EaV5BtZY1X4wotBQpMY8Mjt3mG9tlCJ9b+Lg6NPaT0PKw6VCnrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 082BCC4CEEF;
	Tue, 25 Mar 2025 21:38:35 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.98)
	(envelope-from <rostedt@goodmis.org>)
	id 1txBzU-00000002Vg4-0S6s;
	Tue, 25 Mar 2025 17:39:20 -0400
Message-ID: <20250325213919.956212394@goodmis.org>
User-Agent: quilt/0.68
Date: Tue, 25 Mar 2025 17:38:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH v2 4/4] tracing: Adjust addresses for printing out fields
References: <20250325213845.844200633@goodmis.org>
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
index ef6307a6ca5e..f4bae713a99a 100644
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
+							 (void *)laddr, laddr);
+				} else {
+					trace_seq_printf(&iter->seq, "0x%llx (%lld)", laddr, laddr);
+				}
 				break;
 			default:
 				trace_seq_puts(&iter->seq, "<INVALID-SIZE>");
-- 
2.47.2


