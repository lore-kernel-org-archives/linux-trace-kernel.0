Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 943121E8342;
	Fri, 17 Apr 2026 05:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403587; cv=none; b=HVwjncbI8AQx/T4cUyoSkSnC24Bx7tApN6w9HFHVt1Mxl9ucl/p8oeseh97XGP4KIlM3383pKeuvnbKQqyhhbarrM4pDpND2SrEDS//F0mYFWw+iqXD7MmClKFddsgldUlXg7uQ6gTkpaNNFdnZS3cAxX9vl6b0oYX70dwjQlaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403587; c=relaxed/simple;
	bh=xHQXAyxHaYnuDbx7mtFbBBRDI+LNl96ogJ2yzLlFiBo=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=GmRQhCBcl2ZS+tPc5lY21HjysSY5PLI09M/l+emkfgvF+gQSeGe8OwTzWrRWawtMP1xq9GioHF1i9Js3RwkpDuoB4AylFuEBD2n6CGl+b9Nt6SEYf6oKRbQkAMInh2zfOlzKDNgR40r3uP2x5/3jMp9uNkXq0Sq7yvZAtG7n/2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0003-tracing-expr-v3-2.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowADn_NN6xOFp9TdZDg--.14391S2;
	Fri, 17 Apr 2026 13:26:19 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 17 Apr 2026 20:28:00 +0800
Message-ID: <20260417223002.2-tracing-expr-v3-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260417223002.1-tracing-expr-v3-pengpeng@iscas.ac.cn>
References: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn> <20260409123001.1-tracing-hist-expr-v2-pengpeng@iscas.ac.cn> <20260417223002.1-tracing-expr-v3-pengpeng@iscas.ac.cn>
Subject: [PATCH v3 2/2] tracing: Bound histogram expression strings with
 seq_buf
X-CM-TRANSID:rQCowADn_NN6xOFp9TdZDg--.14391S2
X-Coremail-Antispam: 1UD129KBjvJXoWxAry7Zw43Cw1rCr4xWw1kAFb_yoWrWF4Dpr
	s5A3ZxCr4UJrs7KwnavFsrur15Gw1kCr18tF4DC3yvyw13Jr4DWa1kuF13urn7trW0vFWD
	GF45urZxGF4rWFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvE14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26F4j6r4UJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4
	x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG
	64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2jsIE14v26r
	1j6r4UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0xvEwIxGrwACjI8F5VA0II8E6IAqYI8I
	648v4I1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7
	v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF
	1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIx
	AIcVC0I7IYx2IY6xkF7I0E14v26r4j6F4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI
	42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWI
	evJa73UjIFyTuYvjTRAku4DUUUU
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

Build the expression strings with seq_buf and return -E2BIG when the
rendered name would exceed MAX_FILTER_STR_VAL.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2:
- split the ERR_PTR() conversion into patch 1/2 as requested by Steven
  Rostedt
- keep this patch focused on the seq_buf conversion and overflow
  detection

 kernel/trace/trace_events_hist.c | 67 +++++++++++++++-------
 1 file changed, 45 insertions(+), 22 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 954e0beb7f0a..3a74880ac4d1 100644
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
@@ -1738,32 +1739,35 @@ static const char *get_hist_field_flags(struct hist_field *hist_field)
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
 	int ret = -EINVAL;
 
 	if (level > 1)
@@ -1773,49 +1777,68 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	if (!expr)
 		return ERR_PTR(-ENOMEM);
 
+	seq_buf_init(&s, expr, MAX_FILTER_STR_VAL);
+
 	if (!field->operands[0]) {
-		expr_field_str(field, expr);
+		if (!expr_field_str(field, &s)) {
+			ret = -E2BIG;
+			goto free;
+		}
+		seq_buf_str(&s);
 		return expr;
 	}
 
 	if (field->operator == FIELD_OP_UNARY_MINUS) {
 		char *subexpr;
 
-		strcat(expr, "-(");
+		seq_buf_puts(&s, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
 		if (IS_ERR(subexpr)) {
 			ret = PTR_ERR(subexpr);
 			goto free;
 		}
-		strcat(expr, subexpr);
-		strcat(expr, ")");
+		seq_buf_puts(&s, subexpr);
+		seq_buf_putc(&s, ')');
 
 		kfree(subexpr);
+		if (seq_buf_has_overflowed(&s)) {
+			ret = -E2BIG;
+			goto free;
+		}
 
+		seq_buf_str(&s);
 		return expr;
 	}
 
-	expr_field_str(field->operands[0], expr);
+	if (!expr_field_str(field->operands[0], &s)) {
+		ret = -E2BIG;
+		goto free;
+	}
 
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
 		goto free;
 	}
 
-	expr_field_str(field->operands[1], expr);
+	if (seq_buf_has_overflowed(&s) ||
+	    !expr_field_str(field->operands[1], &s)) {
+		ret = -E2BIG;
+		goto free;
+	}
 
+	seq_buf_str(&s);
 	return expr;
 
 free:
	kfree(expr);
	return ERR_PTR(ret);
}
-- 
2.50.1 (Apple Git-155)

