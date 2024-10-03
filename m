Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6016126C13;
	Thu,  3 Oct 2024 14:48:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727966913; cv=none; b=ng9zOvSiI/A+N1a0wMsFXIdBGACl5X3TGirBz6tF9QyqgNZEC+6RYp19vhQR58keXsSMQvo2UPl3x+8Dg8g9cubuoKXaQrD78KYQ0rl6xrur0labCbaUCo+eKR0XyVpChDrju98565rkiXmcDXaErmn9qeLot9N4pJR++/GNbco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727966913; c=relaxed/simple;
	bh=9H1UCUJdO03zoRskdQul88BnU5jqtiSwZBcVv5KNzmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=RyeE378f4DqEJoOgvT1dIajrlp8NXfly5f76dJ2sdxntFpHGpEkwci0fGqcpGXMifBMVnvMviOsXZYAmG7cX00pFT+T12aQki/nq/kxBfngGug2VlbOxaxBgYwAmLeFhON3z80jDqcfP8UoHVfMvtgUrOHQgb5yKLjd0LIE4kqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B195FC4CEC5;
	Thu,  3 Oct 2024 14:48:31 +0000 (UTC)
Date: Thu, 3 Oct 2024 10:49:25 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Alison Schofield
 <alison.schofield@intel.com>
Subject: [PATCH] tracing: Fix trace_check_vprintf() when tp_printk is used
Message-ID: <20241003104925.4e1b1fd9@gandalf.local.home>
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

When the tp_printk kernel command line is used, the trace events go
directly to printk(). It is still checked via the trace_check_vprintf()
function to make sure the pointers of the trace event are legit.

The addition of reading buffers from previous boots required adding a
delta between the addresses of the previous boot and the current boot so
that the pointers in the old buffer can still be used. But this required
adding a trace_array pointer to acquire the delta offsets.

The tp_printk code does not provide a trace_array (tr) pointer, so when
the offsets were examined, a NULL pointer dereference happened and the
kernel crashed.

If the trace_array does not exist, just default the delta offsets to zero,
as that also means the trace event is not being read from a previous boot.

Link: https://lore.kernel.org/all/Zv3z5UsG_jsO9_Tb@aschofie-mobl2.lan/

Reported-by: Alison Schofield <alison.schofield@intel.com>
Fixes: 07714b4bb3f98 ("tracing: Handle old buffer mappings for event strings and functions")
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index c01375adc471..1c69ca1f1088 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3697,8 +3697,8 @@ static void test_can_verify(void)
 void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 			 va_list ap)
 {
-	long text_delta = iter->tr->text_delta;
-	long data_delta = iter->tr->data_delta;
+	long text_delta = 0;
+	long data_delta = 0;
 	const char *p = fmt;
 	const char *str;
 	bool good;
@@ -3710,6 +3710,17 @@ void trace_check_vprintf(struct trace_iterator *iter, const char *fmt,
 	if (static_branch_unlikely(&trace_no_verify))
 		goto print;
 
+	/*
+	 * When the kernel is booted with the tp_printk command line
+	 * parameter, trace events go directly through to printk().
+	 * It also is checked by this function, but it does not
+	 * have an associated trace_array (tr) for it.
+	 */
+	if (iter->tr) {
+		text_delta = iter->tr->text_delta;
+		data_delta = iter->tr->data_delta;
+	}
+
 	/* Don't bother checking when doing a ftrace_dump() */
 	if (iter->fmt == static_fmt_buf)
 		goto print;
-- 
2.45.2

