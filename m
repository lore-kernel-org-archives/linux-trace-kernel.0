Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA7A2322A;
	Tue,  7 Apr 2026 06:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775542578; cv=none; b=o3D4yOfWCJr58Obk9MAaxangz6xl2iAkkjUshcQ2FUzKnjLh3eW1Q9fuG2gNnW3jHCM3JC8tCMLqWxTgCZ8mfzi7fbdFWc73mYVDj2TAQ5XoF80UA9J3ODoo1zEeBkp/qTWyEmZK9MBXDt4OkE0n6DTVn36tGFljocPlTw6Gm6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775542578; c=relaxed/simple;
	bh=gSgGyjJCfMiebRxwZhR/IwTY9OE6+VTlDvApFLxyA0o=;
	h=From:Date:Message-ID:To:Cc:Subject; b=GZEIBjPN2GrfMP4ObEM+ieoiwt7WtLsLstcDqyCBn/Tj7qhY192Us9SrpVnDUcYjTWr3EHmaklwcWtgvNVSzLMgHqCdXcO9PMAyYPEmpvtJKre/5ptqI0hiNZgT2Keob8aafe+o6WFYybb87wddCjHFLLxZ9B7EaUkm8lG5EI0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0001-tracing-hist.eml (unknown [111.196.245.197])
	by APP-01 (Coremail) with SMTP id qwCowAAHsGsjodRprOh7DA--.45450S2;
	Tue, 07 Apr 2026 14:16:04 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Tue, 7 Apr 2026 14:09:10 +0800
Message-ID: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
Subject: [PATCH] tracing/hist: bound expression string construction
X-CM-TRANSID:qwCowAAHsGsjodRprOh7DA--.45450S2
X-Coremail-Antispam: 1UD129KBjvJXoW3Xw47WFy3ZF1xWF47Jw18Xwb_yoW7XF1fpw
	4FqrnxGr48Jrs7Ww4ayF4fCF15C3yfCr1rGF1Dua92yw13tr4DXan7uFyjqryftr409r47
	GFs8ZFZ8Cr42gFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkv14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26F4j
	6r4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWU
	twCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r
	1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij
	64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr
	0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF
	0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUcBMtUUUUU=
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

Convert the construction helpers to explicit bounded appends and
propagate failures back to the expression parser when the rendered name
would exceed MAX_FILTER_STR_VAL.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 kernel/trace/trace_events_hist.c | 101 +++++++++++++++++++++++--------
 1 file changed, 76 insertions(+), 25 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad55..caaa262360d2 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1738,85 +1738,121 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
 	return flags_str;
 }
 
-static void expr_field_str(struct hist_field *field, char *expr)
+static bool expr_append(char *expr, size_t *len, const char *str)
 {
-	if (field->flags & HIST_FIELD_FL_VAR_REF)
-		strcat(expr, "$");
-	else if (field->flags & HIST_FIELD_FL_CONST) {
+	size_t str_len = strlen(str);
+
+	if (*len + str_len >= MAX_FILTER_STR_VAL)
+		return false;
+
+	memcpy(expr + *len, str, str_len + 1);
+	*len += str_len;
+	return true;
+}
+
+static bool expr_field_str(struct hist_field *field, char *expr, size_t *len)
+{
+	if (field->flags & HIST_FIELD_FL_VAR_REF) {
+		if (!expr_append(expr, len, "$"))
+			return false;
+	} else if (field->flags & HIST_FIELD_FL_CONST) {
 		char str[HIST_CONST_DIGITS_MAX];
+		int ret;
+
+		ret = snprintf(str, sizeof(str), "%llu", field->constant);
+		if (ret >= sizeof(str))
+			return false;
 
-		snprintf(str, HIST_CONST_DIGITS_MAX, "%llu", field->constant);
-		strcat(expr, str);
+		if (!expr_append(expr, len, str))
+			return false;
 	}
 
-	strcat(expr, hist_field_name(field, 0));
+	if (!expr_append(expr, len, hist_field_name(field, 0)))
+		return false;
 
 	if (field->flags && !(field->flags & HIST_FIELD_FL_VAR_REF)) {
 		const char *flags_str = get_hist_field_flags(field);
 
 		if (flags_str) {
-			strcat(expr, ".");
-			strcat(expr, flags_str);
+			if (!expr_append(expr, len, ".") ||
+			    !expr_append(expr, len, flags_str))
+				return false;
 		}
 	}
+
+	return true;
 }
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
 	char *expr;
+	size_t len = 0;
 
 	if (level > 1)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!expr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (!field->operands[0]) {
-		expr_field_str(field, expr);
+		if (!expr_field_str(field, expr, &len))
+			goto free;
 		return expr;
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
 		char *subexpr;
 
-		strcat(expr, "-(");
+		if (!expr_append(expr, &len, "-("))
+			goto free;
 		subexpr = expr_str(field->operands[0], ++level);
 		if (!subexpr) {
-			kfree(expr);
-			return NULL;
+			goto free;
+		}
+		if (!expr_append(expr, &len, subexpr) ||
+		    !expr_append(expr, &len, ")")) {
+			kfree(subexpr);
+			goto free;
 		}
-		strcat(expr, subexpr);
-		strcat(expr, ")");
 
 		kfree(subexpr);
 
 		return expr;
 	}
 
-	expr_field_str(field->operands[0], expr);
+	if (!expr_field_str(field->operands[0], expr, &len))
+		goto free;
 
 	switch (field->operator) {
 	case FIELD_OP_MINUS:
-		strcat(expr, "-");
+		if (!expr_append(expr, &len, "-"))
+			goto free;
 		break;
 	case FIELD_OP_PLUS:
-		strcat(expr, "+");
+		if (!expr_append(expr, &len, "+"))
+			goto free;
 		break;
 	case FIELD_OP_DIV:
-		strcat(expr, "/");
+		if (!expr_append(expr, &len, "/"))
+			goto free;
 		break;
 	case FIELD_OP_MULT:
-		strcat(expr, "*");
+		if (!expr_append(expr, &len, "*"))
+			goto free;
 		break;
 	default:
-		kfree(expr);
-		return NULL;
+		goto free;
 	}
 
-	expr_field_str(field->operands[1], expr);
+	if (!expr_field_str(field->operands[1], expr, &len))
+		goto free;
 
 	return expr;
+
+free:
+	kfree(expr);
+	return ERR_PTR(-E2BIG);
 }
 
 /*
@@ -2630,6 +2666,11 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
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
@@ -2842,6 +2883,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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
@@ -2855,6 +2901,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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


