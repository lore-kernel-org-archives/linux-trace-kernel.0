Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C012435A387;
	Thu,  9 Apr 2026 08:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775723436; cv=none; b=caRgQqOWdaXP/OS0Fio4WkjdB1IE79wacuQv96efXIKtGRH7cHvMFb18P2PgcH7HSSIJM4tngwabRbvuKEtqPSfQ5jTTDs4Ycmc9ri5FpIjo79YyDzhgJt1S2j29yCXtxcENwZ9hElxHNhD4p50pS7Pz7eKcRWaFIVJetVwhsOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775723436; c=relaxed/simple;
	bh=5wSbwJH8UarMnZ2Ix9MQ+h6r7sFYmHa4JvUEF1Ftako=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=qBxMnfWf95PWuVEYgsxlBGPXbunSEOXqwWUd/mAJJPqsanvQtEnQaICvzmIqggcr0zlCXTHFFV1JQlqmVUib/fNmPaEVB2hSTuFfAKTlRmoxk2LJdjpESLO7mM2FxjRG+BSREPq3HGpTeQq0TPpNs4ffTeRDVap6cPLpSjZrF4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-tracing-hist-expr-v2.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowACHqN+dY9dp7Kh3DQ--.57595S2;
	Thu, 09 Apr 2026 16:30:21 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Thu, 9 Apr 2026 10:56:28 +0800
Message-ID: <20260409123001.1-tracing-hist-expr-v2-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn>
References: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn>
Subject: [PATCH v2] tracing/hist: bound expression strings with seq_buf
X-CM-TRANSID:rQCowACHqN+dY9dp7Kh3DQ--.57595S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw47WFy7Zw4ftF47Zw43KFg_yoW7WrWxpF
	s5ArnrCw4UJr4xWw4SyFsruFn8Gws5Cr18GFyDuayvyw13tr4DWa1kur13Xr93trW0vr45
	GF45ZrZ8CF45WFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK6x804I0_JrC_JFyl8cAvFVAK0II2c7
	xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE
	2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4
	vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xv
	F2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r
	4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I648v
	4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr
	0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY
	17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcV
	C0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY
	6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa
	73UjIFyTuYvjfUehL0UUUUU
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

expr_str() allocates a fixed MAX_FILTER_STR_VAL buffer and then builds
expression names with a series of raw strcat() appends. Nested operands,
constants and field flags can push the rendered string past that fixed
limit before the name is attached to the hist field.

Build the expression strings with seq_buf and propagate failures back to
the expression parser when the rendered name would exceed
MAX_FILTER_STR_VAL.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v1:
- replace the previous bounded append helper and manual length tracking
  with seq_buf as suggested by Steven Rostedt
- keep the -E2BIG propagation back into parse_unary() and parse_expr()

 kernel/trace/trace_events_hist.c | 93 ++++++++++++++++++++++----------
 1 file changed, 64 insertions(+), 29 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad55..09aaedb92993 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -8,6 +8,7 @@
 #include <linux/module.h>
 #include <linux/kallsyms.h>
 #include <linux/security.h>
+#include <linux/seq_buf.h>
 #include <linux/mutex.h>
 #include <linux/slab.h>
 #include <linux/stacktrace.h>
@@ -1738,85 +1739,104 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 	return flags_str;
 }
 
-static void expr_field_str(struct hist_field *field, char *expr)
+static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
 {
+	const char *field_name;
+
 	if (field->flags & HIST_FIELD_FL_VAR_REF)
-		strcat(expr, "$");
-	else if (field->flags & HIST_FIELD_FL_CONST) {
-		char str[HIST_CONST_DIGITS_MAX];
+		seq_buf_putc(s, '$');
+	else if (field->flags & HIST_FIELD_FL_CONST)
+		seq_buf_printf(s, "%llu", field->constant);
 
-		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
-		strcat(expr, str);
-	}
+	field_name = hist_field_name(field, 0);
+	if (!field_name)
+		return false;
 
-	strcat(expr, hist_field_name(field, 0));
+	seq_buf_puts(s, field_name);
 
 	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
 		const char *flags_str = get_hist_field_flags(field);
 
-		if (flags_str) {
-			strcat(expr, ".");
-			strcat(expr, flags_str);
-		}
+		if (flags_str)
+			seq_buf_printf(s, ".%s", flags_str);
 	}
+
+	return !seq_buf_has_overflowed(s);
 }
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
 	char *expr;
+	struct seq_buf s;
+	int ret = -E2BIG;
 
 	if (level > 1)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!expr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
+
+	seq_buf_init(&s, expr, MAX_FILTER_STR_VAL);
 
 	if (!field->operands[0]) {
-		expr_field_str(field, expr);
+		if (!expr_field_str(field, &s))
+			goto free;
+		seq_buf_str(&s);
 		return expr;
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
 		char *subexpr;
 
-		strcat(expr, "-(");
+		seq_buf_puts(&s, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
-		if (!subexpr) {
-			kfree(expr);
-			return NULL;
+		if (IS_ERR(subexpr)) {
+			ret = PTR_ERR(subexpr);
+			goto free;
 		}
-		strcat(expr, subexpr);
-		strcat(expr, ")");
+		seq_buf_puts(&s, subexpr);
+		seq_buf_putc(&s, ')');
 
 		kfree(subexpr);
+		if (seq_buf_has_overflowed(&s))
+			goto free;
 
+		seq_buf_str(&s);
 		return expr;
 	}
 
-	expr_field_str(field->operands[0], expr);
+	if (!expr_field_str(field->operands[0], &s))
+		goto free;
 
 	switch (field->operator) {
 	case FIELD_OP_MINUS:
-		strcat(expr, "-");
+		seq_buf_putc(&s, '-');
 		break;
 	case FIELD_OP_PLUS:
-		strcat(expr, "+");
+		seq_buf_putc(&s, '+');
 		break;
 	case FIELD_OP_DIV:
-		strcat(expr, "/");
+		seq_buf_putc(&s, '/');
 		break;
 	case FIELD_OP_MULT:
-		strcat(expr, "*");
+		seq_buf_putc(&s, '*');
 		break;
 	default:
-		kfree(expr);
-		return NULL;
+		ret = -EINVAL;
+		goto free;
 	}
 
-	expr_field_str(field->operands[1], expr);
+	if (seq_buf_has_overflowed(&s) ||
+	    !expr_field_str(field->operands[1], &s))
+		goto free;
 
+	seq_buf_str(&s);
 	return expr;
+
+free:
+	kfree(expr);
+	return ERR_PTR(ret);
 }
 
 /*
@@ -2630,6 +2650,11 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
 	expr->is_signed = operand1->is_signed;
 	expr->operator = FIELD_OP_UNARY_MINUS;
 	expr->name = expr_str(expr, 0);
+	if (IS_ERR(expr->name)) {
+		ret = PTR_ERR(expr->name);
+		expr->name = NULL;
+		goto free;
+	}
 	expr->type = kstrdup_const(operand1->type, GFP_KERNEL);
 	if (!expr->type) {
 		ret = -ENOMEM;
@@ -2842,6 +2867,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		destroy_hist_field(operand1, 0);
 
 		expr->name = expr_str(expr, 0);
+		if (IS_ERR(expr->name)) {
+			ret = PTR_ERR(expr->name);
+			expr->name = NULL;
+			goto free_expr;
+		}
 	} else {
 		/* The operand sizes should be the same, so just pick one */
 		expr->size = operand1->size;
@@ -2855,6 +2885,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
 		}
 
 		expr->name = expr_str(expr, 0);
+		if (IS_ERR(expr->name)) {
+			ret = PTR_ERR(expr->name);
+			expr->name = NULL;
+			goto free_expr;
+		}
 	}
 
 	return expr;
-- 
2.50.1 (Apple Git-155)

