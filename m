Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC96541A77C;
	Fri, 21 Aug 2026 23:30:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787355016; cv=none; b=e98EX/nx6dcB0PVFB4jELxhCiNPusBeDx1OFTEf0z9Fucydb+y2/LuU4FBZ25kVBJ/xoNjjFHu7kXAsOTlSZyalKNp2xBqys88EXQsOhQTdnXevoPC4ZzC9XIJkJw/Dpd3Ku7BRcM1E/lgbM50jjOIRMfRWWyP0bhK48PO3z3Qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787355016; c=relaxed/simple;
	bh=ezlIhANHrjnxFDnlU+9qpNt99P8bYmW7/9exs/RavcU=;
	h=Message-ID:Date:From:To:Cc:Subject:References:MIME-Version:
	 Content-Type; b=ZkTGJd13u91f8Ldmykc1CnG+d2Rn9UuESbnuLJCQJZcVOYDbMU+WrQU5vGN2gxTPXMY/fL9O+ltpxPDaVQ3ekLbbp7Xt0MCTLm/ZkD5FYulD5A3uvvvzEJGXV8zf7+TwkO8KEmDMYvtufWuxwT4JAa6VsXQSH7CyVIFQoZ1hkCY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dj6VPDLu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dj6VPDLu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D4B91F00AC4;
	Fri, 21 Aug 2026 23:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787355015;
	bh=v+dH5bVNfNvYtFzF2cQ1b7nY01NW4X168+YJBJ8OAe8=;
	h=Date:From:To:Cc:Subject:References;
	b=dj6VPDLushZi8BEuOct0LWqTxA47VBbbu0EEWfANvlUsDGrUuoiksH5ZxiEvrcslc
	 9qOu/Sajaqw+X0a3vIx/AQHqdCYvOHGcgen8lBM8Yd20BzhlEXW+74jM6/4RXNf58p
	 FgP2JyuR7lHW+ATe80qZnx3uNo7Ct0Aap8kbl6dnOgptuYz2vdS0EZuSuPmQbVUqDJ
	 SA7jPmIC+W/1nRPvOjaodX241lgMwxtEEGPLwXj8T8i1Y2XT4ZshflsSkvhwf7ZfdE
	 jzQrjTxB1LLSpFnpMikOfTw2Wak7fM7CXkQQ66FLZNxw3Mmc5YdEnBlblCYiRTVsy+
	 JshffODYER2Hg==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1wxYhG-00000005rjq-2duu;
	Fri, 21 Aug 2026 19:30:50 -0400
Message-ID: <20260821233050.488131029@kernel.org>
User-Agent: quilt/0.69
Date: Fri, 21 Aug 2026 19:28:22 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Chen Jun <chenjun102@huawei.com>
Subject: [PATCH v2 2/2] tracnig: Add proper error message for glob use with "within" filter
References: <20260821232820.717143516@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8

From: Steven Rostedt <rostedt@goodmis.org>

If a user were to use a glob expression with the "within" filter, it
currently just fails with an errno return but does not update the
error_log to tell the user why it failed. Update it to use the parsing
error log to tell the user why it failed.

  # echo 'within ~ "*_read"' > events/kmem/kmem_cache_alloc/filter
  -bash: echo: write error: Invalid argument

  # cat error_log
  [ 4676.606481] event filter parse error: error: 'within' filter cannot take glob expressions
    Command: within ~ "*_read"
                              ^

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 297bf156ea65..f811c527cce8 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -118,6 +118,7 @@ struct filter_pred {
 	C(IP_FIELD_ONLY,	"Only 'ip' field is supported for function trace"), \
 	C(INVALID_VALUE,	"Invalid value (did you forget quotes)?"), \
 	C(NO_FUNCTION,		"Function not found"),			\
+	C(GLOB_WITHIN,		"'within' filter cannot take glob expressions"), \
 	C(ERRNO,		"Error"),				\
 	C(NO_FILTER,		"No filter found")
 
@@ -2024,8 +2025,10 @@ static int parse_pred(const char *str, void *data,
 		} else if (field->filter_type == FILTER_WITHIN) {
 			unsigned long func;
 
-			if (op == OP_GLOB)
+			if (op == OP_GLOB) {
+				parse_error(pe, FILT_ERR_GLOB_WITHIN, pos + i);
 				goto err_free;
+			}
 
 			pred->fn_num = FILTER_PRED_FN_WITHIN;
 			func = kallsyms_lookup_name(pred->regex->pattern);
-- 
2.53.0


