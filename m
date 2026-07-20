Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B074D3D9690;
	Mon, 20 Jul 2026 10:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784544264; cv=none; b=U7n2BJkXr1p4S6Y27f3CDDDN8YM2nbta8ZqjJbYHoaLEbRb3QyjBL8JKWqdDG/iGM/qtb0tYLXWzO/MTGMO4Chswo6yx6G3WLavJV5q4XwLSt6CJ93w6J1LmE0DGCo5gRQ4Rm7CisDNNfONYAhSL8b5hep+p00o/QMIIhQjI1ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784544264; c=relaxed/simple;
	bh=FNRVNPmNaEWmQEPDDA6nagdSq3O+d53haEr4O3hDXLw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cYyxOp5eGYN9qn479ylE5QCgDY/Znc9oBVSzZpRZNma74s71QbpqONEZ3H4QOSvFe7vbCfOR4S0PobVL9f+HrcHkrQBNNUnaXaiilovdmukHCMvwJ9LA2gXpbAR0jyhjatgzHUTX6DNoXpeZqAGSigHFBTyCWB37LgXdZzfKbVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fT2LB3Xc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fT2LB3Xc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EBBB1F000E9;
	Mon, 20 Jul 2026 10:44:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784544250;
	bh=qtEKS4+ecMMcLw2egjWiwbg3Kco0HW+YqEdNdM0Zzi8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fT2LB3XcvXNM39+8/BvAxmYakMa727QslYk61LeuTGgswCc8dkXPEAf4YvuhxyvXz
	 jFoOV1IoXvXS669RAAHWJFdvNJy94O+YEpSl/3mbG+2OFKOojQWZuuN6IenDDO3gxV
	 G2DzB6g/hikNpm7UR7BzMMWv9itU9Js6gE7lU6fLTYegD7GrohRXmI3E7r34Vo4oi0
	 mka4CWA7aa7xz7Qme48SsrPpP0Lq/ep4DwBq3aNJcOxzspjBUlHm7purRIqBJYkfhC
	 fvk3FTbcihBk3tJOcgU06xI+ZedMKVN3nnvcZ0oKn31kWScOQ2M16YsK0dRjxqTXqt
	 BzZBB/j+FG2Qw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 04/10] tracing/probes: Remove unused parameter from parse_probe_var_retval()
Date: Mon, 20 Jul 2026 19:44:07 +0900
Message-ID: <178454424711.296567.15352344258939682112.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178454420994.296567.10239174745865301350.stgit@devnote2>
References: <178454420994.296567.10239174745865301350.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

The parameter 'arg' in parse_probe_var_retval() is unused. Remove it
and update its caller accordingly.

Assisted-by: Antigravity:gemini-3.5-flash
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 91ba4490937b..eb7be3725e85 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1262,7 +1262,7 @@ NOKPROBE_SYMBOL(store_trace_entry_data)
 
 #define PARAM_MAX_STACK (THREAD_SIZE / sizeof(unsigned long))
 
-static int parse_probe_var_retval(char *orig_arg, char *arg,
+static int parse_probe_var_retval(char *orig_arg,
 				  struct fetch_insn **pcode,
 				  struct fetch_insn *end,
 				  struct traceprobe_parse_context *ctx)
@@ -1415,7 +1415,7 @@ static int parse_probe_vars(char *orig_arg, const struct fetch_type *t,
 		goto inval;
 
 	if (str_has_prefix(arg, "retval"))
-		return parse_probe_var_retval(orig_arg, arg, pcode, end, ctx);
+		return parse_probe_var_retval(orig_arg, pcode, end, ctx);
 
 	len = str_has_prefix(arg, "stack");
 	if (len)

