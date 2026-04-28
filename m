Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFD49328B77;
	Tue, 28 Apr 2026 16:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777393370; cv=none; b=RqJqcBCn8B6bKWnaBfyiGX+0FOtisoDGqC5GuCqYW1bJl2o/964SI/LNpfZaUdOq2MAvfHBPypslz3N6SKHwMVLfb3QBAyWmpD18EJcMVd9AO4mUUwGvcO+wIFoMt9JYESa6DsWeghvhmshwhF6iUndzNgw0V0nSnqcH3pgepDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777393370; c=relaxed/simple;
	bh=qeeT2TjKCQF7xHWRLdW1EzTPAdOfSLgRCwcy+uVCJaU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type; b=Dv6y7AeWshsGHTn2MzTV6NAWQEOYwkH/JIzYZTcAgzUXBp5nIhWFwM+1qOpUcw+aDY7VLjEun0J08OC11RpxcxMUnUnh0uDSAhWU6bd5dkDDX0wryj0i3kP6W23Ysjv3yXAvWiuVnbN+9aN1K497+hEB7bzwHfVCqo/zPsa/a28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fL0t97xo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fL0t97xo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBE36C2BCAF;
	Tue, 28 Apr 2026 16:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777393370;
	bh=qeeT2TjKCQF7xHWRLdW1EzTPAdOfSLgRCwcy+uVCJaU=;
	h=Date:From:To:Cc:Subject:From;
	b=fL0t97xoVve3R+N/l1gypwfNS+tNcIijD3W4sYOwqG12Dk9kYxsnpKjs9+uhJD/Iy
	 4PV4Q0GFQ/A3Wl/hSjD2Oe0WW4uw1Cvi0lNom2bG1XHT+hUPQlCzHCW89xsztLR9L6
	 YtouYPrVtnYVQWvUjYa7ILe9eUfeNbgF7/VV3I/e98gDGcmVLqmEhCn7+Rs7LNWPiU
	 L8zujMzniRLWcYLgQ+krct708dkLl1PWhZLjG5oYsglaPtWwQqNTHkaGimvneaNdOe
	 hzWiorEOfwzuVB7OyP0D1DA/+STFirmc4XkA3YQO6yJhTKBYB7YeqY73ecaWYwidVb
	 4S1blGCHlhuOQ==
Date: Tue, 28 Apr 2026 12:23:02 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>
Subject: [PATCH] tracing/probes: Limit size of event probe to 3K
Message-ID: <20260428122302.706610ba@gandalf.local.home>
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

There currently isn't a max limit an event probe can be. One could make an
event greater than PAGE_SIZE, which makes the event useless because if
it's bigger than the max event that can be recorded into the ring buffer,
then it will never be recorded.

A event probe should never need to be greater than 3K, so make that the
max size. As long as the max is less than the max that can be recorded
onto the ring buffer, it should be fine.

Cc: stable@vger.kernel.org
Fixes: 93ccae7a22274 ("tracing/kprobes: Support basic types on dynamic events")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_probe.c | 6 ++++++
 kernel/trace/trace_probe.h | 4 +++-
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e1c73065dae5..e0d3a0da26af 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1523,6 +1523,12 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	parg->offset = *size;
 	*size += parg->type->size * (parg->count ?: 1);
 
+	if (*size > MAX_PROBE_EVENT_SIZE) {
+		ret = -E2BIG;
+		trace_probe_log_err(ctx->offset, EVENT_TOO_BIG);
+		goto fail;
+	}
+
 	if (parg->count) {
 		len = strlen(parg->type->fmttype) + 6;
 		parg->fmt = kmalloc(len, GFP_KERNEL);
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 9fc56c937130..262d8707a3df 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -38,6 +38,7 @@
 #define MAX_BTF_ARGS_LEN	128
 #define MAX_DENTRY_ARGS_LEN	256
 #define MAX_STRING_SIZE		PATH_MAX
+#define MAX_PROBE_EVENT_SIZE	3072
 
 /* Reserved field names */
 #define FIELD_STRING_IP		"__probe_ip"
@@ -561,7 +562,8 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_TYPE4STR,		"This type does not fit for string."),\
 	C(NEED_STRING_TYPE,	"$comm and immediate-string only accepts string type"),\
 	C(TOO_MANY_ARGS,	"Too many arguments are specified"),	\
-	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),
+	C(TOO_MANY_EARGS,	"Too many entry arguments specified"),	\
+	C(EVENT_TOO_BIG,	"Event too big (too many fields?)"),
 
 #undef C
 #define C(a, b)		TP_ERR_##a
-- 
2.53.0

