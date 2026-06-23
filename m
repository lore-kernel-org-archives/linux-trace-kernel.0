Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601A0368D6B;
	Tue, 23 Jun 2026 01:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782179074; cv=none; b=iTd695cknJm5p7pmLVJ9pJQk0LT1GeSAKxMqEENeLA9e9+TKJldgvuHCMwy71c00yolbnpFoSeT1lwwRpGng2zIXH78pVZAAB0uR5o/+0Z+yk4FWv2dKPg83a4fzHDbfTfXP2OkOJOt3HgRGwCuXopSkba2IHmmMnygdIDHFW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782179074; c=relaxed/simple;
	bh=y2KDfsSMeydRTgMTbNSwDFZcIn/gOvSrDhuEUdHJbBo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YUzU53YNme6YlR1d5xERYDBNNXQGOoSHNtBHrui62IIXR5HsqcMufI6CV+w8+9bAfiYRiPFxDSZf6Bvz9IIL+z23M+mDzmCaNZDzMkxZ/mK4Dw/eRI67If6OJBqdOQKvlCdpWQCArKu4fo4B/NT5CRRc4gBQTJliz7HFFHFcw3A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jUnJHmOa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jUnJHmOa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BE201F000E9;
	Tue, 23 Jun 2026 01:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782179072;
	bh=FEyT75a7Ln9SJEB/lBlO2EAvgEs0LJySWVueUDn0Rf8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jUnJHmOapCP9DGYwKvAnpWbH0ZOCVkwpP5J4SAumN6uaaLMvhrTHs0RljXUlds3cH
	 7A275fw1lhiby/p3EWer0KbPTVYVojAM9gvBv0gMUx4K+acEaL6MStdUKXljjJVSkd
	 QIGWeQlAjGF+gCETLG9J5Bf85uHiYhCjQiOXl9ehzr3qL9sQXJwvcXAH2wtfxVCj8r
	 uJ7AyELOnVQnRG+Y5k6LE/TSIhhgQcyJdPDlRJ2esqOgLHsxYkDX9LZXaaVgwJ1c80
	 kzN+2o7t8nVxB7pLDLEakfcdWJSHLZLR4ObMTw967U/nB5X58XkiuKjLbWp81aLOvr
	 wVp32lznVQKqA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v7 02/10] tracing/probes: Rename FETCH_OP_DATA to FETCH_OP_IMMSTR
Date: Tue, 23 Jun 2026 10:44:29 +0900
Message-ID: <178217906914.643090.2958799486090467704.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178217904992.643090.15726197350652241270.stgit@devnote2>
References: <178217904992.643090.15726197350652241270.stgit@devnote2>
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

Since FETCH_OP_DATA is used solely to store immediate string
values, rename it to the more specific FETCH_OP_IMMSTR.

No behavior change, just rename it.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace_probe.c      |   12 ++++++------
 kernel/trace/trace_probe.h      |    2 +-
 kernel/trace/trace_probe_tmpl.h |    2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 502fa6da5949..d1c55596725b 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1307,7 +1307,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 				break;
 			ctx->offset = cur_offs;
 			if (code->op == FETCH_OP_COMM ||
-			    code->op == FETCH_OP_DATA) {
+			    code->op == FETCH_OP_IMMSTR) {
 				trace_probe_log_err(ctx->offset, COMM_CANT_DEREF);
 				return -EINVAL;
 			}
@@ -1328,7 +1328,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			ret = __parse_imm_string(arg + 2, &tmp, ctx->offset + 2);
 			if (ret)
 				break;
-			code->op = FETCH_OP_DATA;
+			code->op = FETCH_OP_IMMSTR;
 			code->data = tmp;
 		} else {
 			ret = str_to_immediate(arg + 1, &code->immediate);
@@ -1483,7 +1483,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 		} else {
 			if (code->op != FETCH_OP_DEREF && code->op != FETCH_OP_UDEREF &&
 			    code->op != FETCH_OP_IMM && code->op != FETCH_OP_COMM &&
-			    code->op != FETCH_OP_DATA && code->op != FETCH_OP_TP_ARG) {
+			    code->op != FETCH_OP_IMMSTR && code->op != FETCH_OP_TP_ARG) {
 				trace_probe_log_err(ctx->offset + type_offset,
 						    BAD_STRING);
 				return -EINVAL;
@@ -1492,7 +1492,7 @@ static int finalize_fetch_insn(struct fetch_insn *code,
 
 		if (!strcmp(parg->type->name, "symstr") ||
 		    (code->op == FETCH_OP_IMM || code->op == FETCH_OP_COMM ||
-		     code->op == FETCH_OP_DATA) || code->op == FETCH_OP_TP_ARG ||
+		     code->op == FETCH_OP_IMMSTR) || code->op == FETCH_OP_TP_ARG ||
 		     parg->count) {
 			/*
 			 * IMM, DATA and COMM is pointing actual address, those
@@ -1668,7 +1668,7 @@ static int traceprobe_parse_probe_arg_body(const char *argv, ssize_t *size,
 	if (ret < 0) {
 		for (code = tmp; code < tmp + FETCH_INSN_MAX; code++)
 			if (code->op == FETCH_NOP_SYMBOL ||
-			    code->op == FETCH_OP_DATA)
+			    code->op == FETCH_OP_IMMSTR)
 				kfree(code->data);
 	}
 	kfree(tmp);
@@ -1767,7 +1767,7 @@ void traceprobe_free_probe_arg(struct probe_arg *arg)
 
 	while (code && code->op != FETCH_OP_END) {
 		if (code->op == FETCH_NOP_SYMBOL ||
-		    code->op == FETCH_OP_DATA)
+		    code->op == FETCH_OP_IMMSTR)
 			kfree(code->data);
 		code++;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 0f09f7aaf93f..cd586e67b21a 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -94,7 +94,7 @@ enum fetch_op {
 	FETCH_OP_COMM,		/* Current comm */
 	FETCH_OP_ARG,		/* Function argument : .param */
 	FETCH_OP_FOFFS,		/* File offset: .immediate */
-	FETCH_OP_DATA,		/* Allocated data: .data */
+	FETCH_OP_IMMSTR,	/* Allocated string: .data */
 	FETCH_OP_EDATA,		/* Entry data: .offset */
 	// Stage 2 (dereference) op
 	FETCH_OP_DEREF,		/* Dereference: .offset */
diff --git a/kernel/trace/trace_probe_tmpl.h b/kernel/trace/trace_probe_tmpl.h
index f39b37fcdb3b..51436f19083b 100644
--- a/kernel/trace/trace_probe_tmpl.h
+++ b/kernel/trace/trace_probe_tmpl.h
@@ -109,7 +109,7 @@ process_common_fetch_insn(struct fetch_insn *code, unsigned long *val)
 	case FETCH_OP_COMM:
 		*val = (unsigned long)current->comm;
 		break;
-	case FETCH_OP_DATA:
+	case FETCH_OP_IMMSTR:
 		*val = (unsigned long)code->data;
 		break;
 	default:

