Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1E99368D79;
	Thu, 21 May 2026 02:28:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779330525; cv=none; b=f7GmnUxUcccB99+WBjgk4RzFdfzfdOaH9g5FAQ+R1uv4jI+JlvJGk8B0afFJmSGoUDEwTAoiMLqyecVANPvcOh4JF6agz1d4v4TMx5ghS69zSDfL88h74fwIA+SJZGJt01ZNnTj9w7W0EEjpIqAoCfQhsxNNb+dUAdKrugfPTg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779330525; c=relaxed/simple;
	bh=BRXlhKGwjZpjzuI+awDgwML69Vb8GC53VbYgZ3b7LkM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CgTgnUChTNnJryBwRSuwEsqgtzOfyUx4zLzQM3Q7/DD559SVP/hAsvzHHVg7ivv3bHvhm1GMSSuaUxMUri3XY82E0VDX6T1cAs9n/VfCpVW0sS5Aw30Smo4PQif9YHSRFmbA9Yo5gtxNtzw1j3jhltRaT1CmrNI2tlG9O5N1/Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-03 (Coremail) with SMTP id rQCowAB3meDEbQ5qvrDAEQ--.20225S3;
	Thu, 21 May 2026 10:28:21 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v4 2/2] tracing: Bound histogram expression strings with seq_buf
Date: Thu, 21 May 2026 10:28:17 +0800
Message-ID: <20260521022817.38453-2-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260521022817.38453-1-pengpeng@iscas.ac.cn>
References: <20260521022817.38453-1-pengpeng@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:rQCowAB3meDEbQ5qvrDAEQ--.20225S3
X-Coremail-Antispam: 1UD129KBjvJXoWxAry7Zw43CFW5KFyrWrWrGrg_yoWrAFWrpF
	s5AFnxCr4Utrs7Kwn3AFsruFy5Gw1kCr18tr4Du3yvy343Jr4DWa1kuF1furn7trW093Zr
	GF45urZxCF4rWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26F4UJVW0owAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUhvttUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

expr_str() allocates a fixed MAX_FILTER_STR_VAL buffer and then builds
expression names with a series of raw strcat() appends. Nested operands,
constants and field flags can push the rendered string past that fixed
limit before the name is attached to the hist field.

Build the expression strings with seq_buf and return -E2BIG when the
rendered name would exceed MAX_FILTER_STR_VAL.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v3: https://lore.kernel.org/all/20260417223002.2-tracing-expr-v3-pengpeng@iscas.ac.cn/
- rebase on top of v7.1-rc3
- keep the ERR_PTR() conversion in patch 1
- use seq_buf for expression construction and return -E2BIG on overflow

 kernel/trace/trace_events_hist.c | 62 +++++++++++++++++++-------------
 1 file changed, 38 insertions(+), 24 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 0b33bb8ef6f7..c878dc8f0cb9 100644
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
@@ -1743,33 +1744,37 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
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
+	seq_buf_str(s);
+	return !seq_buf_has_overflowed(s);
 }
 
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
 	char *expr __free(kfree) = NULL;
+	struct seq_buf s;
 
 	if (level > 1)
 		return ERR_PTR(-EINVAL);
@@ -1778,47 +1783,56 @@ static char *expr_str(struct hist_field *field, unsigned int level)
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
-		char *subexpr;
+		char *subexpr __free(kfree) = NULL;
 
-		strcat(expr, "-(");
+		seq_buf_puts(&s, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
 		if (IS_ERR(subexpr))
 			return subexpr;
 
-		strcat(expr, subexpr);
-		strcat(expr, ")");
+		seq_buf_puts(&s, subexpr);
+		seq_buf_putc(&s, ')');
+		seq_buf_str(&s);
 
-		kfree(subexpr);
+		if (seq_buf_has_overflowed(&s))
+			return ERR_PTR(-E2BIG);
 
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

