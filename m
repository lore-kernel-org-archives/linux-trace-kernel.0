Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793148320;
	b=Kgw4twZ68dAzH7z+2TicxMAUBHXHE+c2be/SbqNOCD4jBUDjn2IbOV1o/5tNtqOskxx+
	 aNsuFW7fF1yfRhXmf0Dmk0Q9K/WQN2mahruUVz5UqtJeUfjd/gIjw2WeKgwihc6B0piel
	 gaTimi4cYPakcSnNOc7EmxzKapPAFPdm7SICu0/E3hr0+oEbIYR6sVf55GyYBxtRF80H/
	 Q9hHkdOtL6/z0suuPVBwHCkLiXHI2lgVN2BHwwbun7mQZ4b4Axt9LhkucSKZSQeZsQdHN
	 E5/HIBY+38BqqC5TLP6jMqGQmWuryKFHOR1kod3e4zm/aWKQALH5hSG5X99FRDUVt9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793148320;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mECQp1OGbZe3ifTrJl3DzX+ZkgyulIOJqgA2aHmx/tw=;
	b=lgLbMMPJPhnvBvr8vg7Q7pP5tkAgDna43FQXQUzOCN81Bi4Y2SxjjI3Wo1JtC3IgxABU
	 kwhfem0wl7F2dK+/Zj9bYkXORZg2zmczPeTZ3M4HcboA3TgH73I5HnNME9mo98VifQuV/
	 Aj+XKUTKxfQp3fFi/CPvnQO6r25FR3ZuHEh98Yj30qGxr8jff2KZYugcq3SZYEnUb32GA
	 oKfRYvNOJK6nJHUO4vMm5FGyeWYo5xcEon9Ys0yhibXEnbSKn8VOi2xE3twOtRgrvEP+0
	 rqMxooAgJJanFFY3vqFHKSWUh5izpIjKew4pegX9fAGULD6BtQFZwHcWr43s9f/EOxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5gTSqCZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D914606A31A;
	Wed, 28 Oct 2026 00:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5gTSqCZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B811F031E2;
	Wed, 28 Oct 2026 00:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793148320;
	bh=mECQp1OGbZe3ifTrJl3DzX+ZkgyulIOJqgA2aHmx/tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5gTSqCZdO7/QwkxUF4SwCAzRlNu97XscEwuRlkf5osFCVv2CwBnXX9IRiP6l+Lwu
	 xIcAa1ki8X0Yx3NQsllesKxle4zpbfVG2yS+mWplOH5nEgE+6VFAXkrYF5BN3DgcQG
	 Gq478eyaFlJN9KUkhwNE3uKhie1zvLCZPeQV2nSEOT2pxtY8uYcoQMdboQ+7Qw8x6I
	 d6tuUXeF5b1tNHVBCRsUGq2jbmLa3gByCXUjOuflPMTSQD5F6ouWOtcgWdLtw9ot7P
	 Oq20W/v3Z4CDnZ1ke3u6zumFcXDywVGa1YrEo3OoWK0QXqoXSSK7RcJfcMgI2udm7k
	 9Q8crV7KYsBhw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Shuah Khan <shuah@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3 12/16] tracing/filters: Fix error positions in filter parser
Date: Wed, 28 Oct 2026 09:45:16 +0900
Message-ID: <179314831623.684037.5555582639802159483.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <179314820431.684037.4147763044424284198.stgit@devnote2>
References: <179314820431.684037.4147763044424284198.stgit@devnote2>
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

Fixes: 80765597bc58 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
Changes in v3:
 - Group all error position fixes for commit 80765597bc58 together into
   a single patch for ease of backporting.
---
 kernel/trace/trace_events_filter.c                 |   19 ++++++++++++-------
 .../ftrace/test.d/ftrace/tracing-error-log.tc      |    2 +-
 2 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index f3c18324b07a..903caf62a407 100644
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
@@ -1694,12 +1694,15 @@ static int parse_pred(const char *str, void *data,
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
@@ -1720,7 +1723,7 @@ static int parse_pred(const char *str, void *data,
 	field = trace_find_event_field(call, field_name);
 	kfree(field_name);
 	if (!field) {
-		parse_error(pe, FILT_ERR_FIELD_NOT_FOUND, pos + i);
+		parse_error(pe, FILT_ERR_FIELD_NOT_FOUND, pos + field_pos);
 		return -EINVAL;
 	}
 
@@ -1739,6 +1742,8 @@ static int parse_pred(const char *str, void *data,
 	while (isspace(str[i]))
 		i++;
 
+	op_pos = i;
+
 	/* Make sure this op is supported */
 	for (op = 0; ops[op]; op++) {
 		/* This is why '<=' must come before '<' in ops[] */
@@ -1747,7 +1752,7 @@ static int parse_pred(const char *str, void *data,
 	}
 
 	if (!ops[op]) {
-		parse_error(pe, FILT_ERR_INVALID_OP, pos + i);
+		parse_error(pe, FILT_ERR_INVALID_OP, pos + op_pos);
 		goto err_free;
 	}
 
@@ -1844,7 +1849,7 @@ static int parse_pred(const char *str, void *data,
 		 * (perf doesn't use it) and grab everything.
 		 */
 		if (strcmp(field->name, "ip") != 0) {
-			parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + i);
+			parse_error(pe, FILT_ERR_IP_FIELD_ONLY, pos + field_pos);
 			goto err_free;
 		}
 		pred->fn_num = FILTER_PRED_FN_NOP;
@@ -2033,7 +2038,7 @@ static int parse_pred(const char *str, void *data,
 		case OP_EQ:
 			break;
 		default:
-			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + op_pos);
 			goto err_free;
 		}
 
@@ -2130,7 +2135,7 @@ static int parse_pred(const char *str, void *data,
 		}
 
 		if (op == OP_GLOB) {
-			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + i);
+			parse_error(pe, FILT_ERR_ILLEGAL_FIELD_OP, pos + op_pos);
 			goto err_free;
 		}
 
@@ -2169,7 +2174,7 @@ static int parse_pred(const char *str, void *data,
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

