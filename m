Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35AC303A04;
	Thu, 11 Jun 2026 05:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157598; cv=none; b=dZ9X9Sn2B+A/5ESSa2X46U+iL5AxrgQQJj7bGryQ0cmdTjc03QfUOb6jAPXq+7eFsCZiRyEgOlaacSOgwSeyJTWbAS5DCLlRVjF+MG3q41u92hti96UkTBa/79zGGtA7QU2S/4uQ1uSybfLrSKfmVQBkxjwiSM0fT8VqU8/Uelw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157598; c=relaxed/simple;
	bh=l31heR2k2Y+pRrr1195jqS0c/72aVCam/xDngTX4IEU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXYtlCEO4gDHCXEYftlkXDEltAs9tlpYwDKymhEck5vuz4RVdLK67BmI112pOXVyZl0fo3iX/PduXJW5uOY2WWcDABFGCQbWb8eyxuWc4cvdbCtO+1YgHX1/4VYPMFo6gNGdC2ORAzVG+jp+B4kgLGp/154LMjo64l3PJ55/lJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACXPdbTTipqvyxFAQ--.9346S5;
	Thu, 11 Jun 2026 13:59:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v5 3/3] tracing: Bound histogram expression strings with seq_buf
Date: Thu, 11 Jun 2026 13:59:45 +0800
Message-ID: <20260611055945.22348-4-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXPdbTTipqvyxFAQ--.9346S5
X-Coremail-Antispam: 1UD129KBjvJXoWxAry7Zw43Cw1rXrW7GFWUtwb_yoWrWFWxpr
	4rJF9xCr4Utrs29wsayFs8uFy5G34kCw18tr1Du3yvy3Z8Jr4DXa1DuF1fur93trW0yrZr
	GF45urZ8CF4rWrDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVWrJVCq3wAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_JrWl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Cr0_Gr1UM2
	8EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUwFxUUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

expr_str() allocates a fixed MAX_FILTER_STR_VAL buffer and then builds
expression names with a series of raw strcat() appends. Nested operands,
constants, field flags, and generated field names can push the rendered
string past that fixed limit before the name is attached to the hist
field.

Build expression strings with seq_buf and return -E2BIG when the
rendered name would exceed MAX_FILTER_STR_VAL. This keeps the existing
tracing-side limit while replacing the raw append logic with bounded
construction.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 kernel/trace/trace_events_hist.c | 57 ++++++++++++++++++--------------
 1 file changed, 33 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 082842e64ccd..810c63c6b3df 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -94,7 +94,6 @@ typedef u64 (*hist_field_fn_t) (struct hist_field *field,
 #define HIST_FIELD_OPERANDS_MAX	2
 #define HIST_FIELDS_MAX		(TRACING_MAP_FIELDS_MAX + TRACING_MAP_VARS_MAX)
 #define HIST_ACTIONS_MAX	8
-#define HIST_CONST_DIGITS_MAX	21
 #define HIST_DIV_SHIFT		20  /* For optimizing division by constants */
 
 enum field_op_id {
@@ -1733,33 +1732,36 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 	return flags_str;
 }
 
-static void expr_field_str(struct hist_field *field, char *expr)
+static bool expr_field_str(struct hist_field *field, struct seq_buf *s)
 {
+	const char *field_name;
+
 	if (field->flags & HIST_FIELD_FL_VAR_REF) {
 		if (!field->system)
-			strcat(expr, "$");
-	} else if (field->flags & HIST_FIELD_FL_CONST) {
-		char str[HIST_CONST_DIGITS_MAX];
+			seq_buf_putc(s, '$');
+	} else if (field->flags & HIST_FIELD_FL_CONST)
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
 	char *expr __free(kfree) = NULL;
+	struct seq_buf s;
 
 	if (level > 1)
 		return ERR_PTR(-EINVAL);
@@ -1768,47 +1770,54 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	if (!expr)
 		return ERR_PTR(-ENOMEM);
 
+	seq_buf_init(&s, expr, MAX_FILTER_STR_VAL);
+
 	if (!field->operands[0]) {
-		expr_field_str(field, expr);
+		if (!expr_field_str(field, &s))
+			return ERR_PTR(-E2BIG);
+
 		return_ptr(expr);
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
 		char *subexpr;
 
-		strcat(expr, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
 		if (IS_ERR(subexpr))
 			return subexpr;
 
-		strcat(expr, subexpr);
-		strcat(expr, ")");
-
+		seq_buf_printf(&s, "-(%s)", subexpr);
 		kfree(subexpr);
 
+		if (seq_buf_has_overflowed(&s))
+			return ERR_PTR(-E2BIG);
+
 		return_ptr(expr);
 	}
 
-	expr_field_str(field->operands[0], expr);
+	if (!expr_field_str(field->operands[0], &s))
+		return ERR_PTR(-E2BIG);
 
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
 		return ERR_PTR(-EINVAL);
 	}
 
-	expr_field_str(field->operands[1], expr);
+	if (seq_buf_has_overflowed(&s) ||
+	    !expr_field_str(field->operands[1], &s))
+		return ERR_PTR(-E2BIG);
 
 	return_ptr(expr);
 }
-- 
2.50.1 (Apple Git-155)

