Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793237951;
	b=tlKpupPcWZ0Hw1if0fU8MnH1D/udWb/x1Hgen9+Qz1Yg+0zm90I0uY4HId1FEXJJNh/w
	 sbjbD67gR+bokWaaTMKkzKqcYZjReiLhoUTy66iaT4Oa7zzV3Xe12BzG9yKhMUGyqE/ph
	 v5n+dxPMh+0MHOic4tlHmnS4QZVtcoyQihv56jjnppYiWwY4Vc9PX7J3HVt1UNX6xfEyj
	 sNa4z9W/CJn7SuELTF+2sCUR6ESUvXhmVmlhYZZY0gDRfmjKRzkoLG+eCtVp/769x/O5S
	 IKJGZ/M+51Gr/oRzGxqzmr2biah2j/tfwxUROKlm1LrMOjzNjAJMKeOIY14UafgKz5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793237951;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=zUzlcpuBM6t+utt5NdbvheCXI+f+IpOfFstVTVIUADY=;
	b=pym4PBKNUbQAUriHZmdyxALjii1qDaOBDWQe4KCs5K5pKIgel2ymU9P07JpjkCfAKilI
	 /hRd/lj9+hFp2LCBFVjtHwdhXQ/skIAiVpWBnrEcSRCYd18ij233DWpCKWJEh9tSnCgyY
	 eDxvJZHUzKznnkfmk6n61hzDCvgQXyfZ4COov7lWsR3gEZ+W+0SjgHgrLSWkRlYx7yxuJ
	 T5u668bkk88cnYwe3uUl/juDvSqKFUa9S27abNBdtPVzkhuIFNvyQYyDusEdrLJDcsCfs
	 9UpfNlJGnyMgPdnKnO0wwZUok23+P9EYM8ur77JSl1FtxhO9JTUh9Fmf8iSSHHSi2vg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnotiYKa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D519606A31E;
	Thu, 29 Oct 2026 01:39:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KnotiYKa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39AD71F01825;
	Thu, 29 Oct 2026 01:39:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793237951;
	bh=zUzlcpuBM6t+utt5NdbvheCXI+f+IpOfFstVTVIUADY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KnotiYKacMGrZxT6lRR6ltrj1EygcPPOWXD4GsunjrC6xuz87P6C7m9yCs4tQZ7Tf
	 agh7i0gHJGWUEeX6kxqGVLBJl0wBtARvyShUdHxvlp5c19NWyB2ljAJkK0qnOOcFS3
	 /l20h4CSBSEc371C+QbA0Sq8EmMdresyrTavkLFnAX00o8SPFLfUKn+WWvIT7cyGKu
	 509cTHiMedFqH3cGaDVB/Gi25d0+YYk700C61bfx+jbYB2s+2W66oDKTSWYbDjBm+p
	 CA4zqgLsXwr3X/kUWOayc7iZ+t/6QHuHroZfoXUkopdmpZbZpruQfo8O9MN34KBhJ0
	 LV6s57j03U1QQ==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v4 11/15] tracing/filters: Fix error positions in filter parser
Date: Thu, 29 Oct 2026 10:39:07 +0900
Message-ID: <179323794702.740114.679129900715570251.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179323784538.740114.15323117974242744566.stgit@devnote2>
References: <179323784538.740114.15323117974242744566.stgit@devnote2>
User-Agent: StGit/0.19
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In predicate_parse(), 'ptr' has already been advanced past 'next',
shifting 'pos' passed to parse_pred() one character to the right.

In parse_pred(), several error paths report 'pos + i' after 'i' has
already been advanced to subsequent tokens:
- When a field is not found (FILT_ERR_FIELD_NOT_FOUND) or when a
  function event field is not "ip" (FILT_ERR_IP_FIELD_ONLY), 'pos + i'
  points past the field name or to the operand instead of the field.
- In operator validation checks for string and numeric operands, and
  when select_comparison_fn() returns NOP, 'pos + i' points to the
  operand or past it instead of the unsupported operator.

Fix these by passing 'next - str' in predicate_parse(), saving the
field position in 'field_pos' and the operator position in 'op_pos', and
passing 'pos + field_pos' or 'pos + op_pos' accordingly. Also update the
tracing-error-log.tc selftest to reflect the corrected error position.

Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v4:
 - Drop Fixes and Cc: stable tags since this error position fix is a
   cleanup.
Changes in v3:
 - Group all error position fixes for commit 80765597bc58 together into
   a single patch for ease of backporting.
---
 kernel/trace/trace_events_filter.c                 |   19 ++++++++++++-------
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |    2 +-
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index e91ec41bfd2a..6ff208f0e033 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -537,7 +537,7 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 		inverts[N] = invert;				/* #4 */
 		prog[N].target = N-1;
 
-		len = parse_pred(next, data, ptr - str, pe, &prog[N].pred);
+		len = parse_pred(next, data, next - str, pe, &prog[N].pred);
 		if (len < 0) {
 			ret = len;
 			goto out_free;
@@ -1700,12 +1700,15 @@ static int parse_pred(const char *str, void *data,
 	int ret;
 	int op;
 	int s;
+	int field_pos = 0;
+	int op_pos = 0;
 	int i = 0;
 
 	/* First find the field to associate to */
 	while (isspace(str[i]))
 		i++;
 	s = i;
+	field_pos = i;
 
 	while (isalnum(str[i]) || str[i] == '_')
 		i++;
@@ -1726,7 +1729,7 @@ static int parse_pred(const char *str, void *data,
 	field = trace_find_event_field(call, field_name);
 	kfree(field_name);
 	if (!field) {
-		parse_error(pe, FILT_ERR_FIELD_NOT_FOUND, pos + i);
+		parse_error(pe, FILT_ERR_FIELD_NOT_FOUND, pos + field_pos);
 		return -EINVAL;
 	}
 
@@ -1745,6 +1748,8 @@ static int parse_pred(const char *str, void *data,
 	while (isspace(str[i]))
 		i++;
 
+	op_pos = i;
+
 	/* Make sure this op is supported */
 	for (op = 0; ops[op]; op++) {
 		/* This is why '<=' must come before '<' in ops[] */
@@ -1753,7 +1758,7 @@ static int parse_pred(const char *str, void *data,
 	}
 
 	if (!ops[op]) {
-		parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+		parse_error(pe, FILT_ERR_INVALID_OP, pos + op_pos);
 		goto err_free;
 	}
 
@@ -1850,7 +1855,7 @@ static int parse_pred(const char *str, void *data,
 		 * (perf doesn't use it) and grab everything.
 		 */
 		if (strcmp(field->name, "ip") != 0) {
-			parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
+			parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + field_pos);
 			goto err_free;
 		}
 		pred->fn_num = FILTER_PRED_FN_NOP;
@@ -2039,7 +2044,7 @@ static int parse_pred(const char *str, void *data,
 		case OP_EQ:
 			break;
 		default:
-			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + op_pos);
 			goto err_free;
 		}
 
@@ -2140,7 +2145,7 @@ static int parse_pred(const char *str, void *data,
 		}
 
 		if (op == OP_GLOB) {
-			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + op_pos);
 			goto err_free;
 		}
 
@@ -2179,7 +2184,7 @@ static int parse_pred(const char *str, void *data,
 			pred->fn_num = select_comparison_fn(pred->op, field->size,
 							    field->is_signed);
 			if (pred->fn_num == FILTER_PRED_FN_NOP) {
-				parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+				parse_error(pe, FILT_ERR_INVALID_OP, pos + op_pos);
 				goto err_free;
 			}
 			if (pred->op == OP_NE)
diff --git a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
index 6c190620db47..2c900873ce3c 100644
--- a/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
+++ b/tools/testing/selftests/ftrace/test.d/ftrace/tracing-error-log.tc
@@ -10,6 +10,6 @@ fail() { #msg
     exit_fail
 }
 
-ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || dsig ^== 17) && comm != bash' 'events/signal/signal_generate/filter'
+ftrace_errlog_check 'event filter parse error' '((sig >= 10 && sig < 15) || ^dsig == 17) && comm != bash' 'events/signal/signal_generate/filter'
 
 exit 0

