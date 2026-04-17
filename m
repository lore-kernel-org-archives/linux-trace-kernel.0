Received: from cstnet.cn (smtp81.cstnet.cn [159.226.251.81])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5941831B830;
	Fri, 17 Apr 2026 05:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776403587; cv=none; b=uQ3Y+PFTXIhdC78xfIRWKWM/eYUU0Q0W8FtWwGRF7CynCSVi7pwAitPuh3JIbaazgk5NFExwjF/MqucliNO07jax20hQml3qDpFh328++r34DbOfJEtt4P+t1jnKlJ+jxaaWaHV0135UiJ56CHkVgGGlLr/ufgZgNTwWiXQJOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776403587; c=relaxed/simple;
	bh=HopUEUkmbp049g/UzkdGX9kDvUu3+Ov4KZBpKUhqfao=;
	h=From:Date:Message-ID:To:Cc:In-Reply-To:References:Subject; b=LJCOkySD8JgO9NRcB7+Ijr7P/MQuT22tW1nBvpScmPMN9Vu2K4yEJsoDUeZgVRM5FOvtWLwkQhaZo094wqwdPMB+IV2Wm1KzEbXzwW8sQKME7VoFIILAnGOP1gqvYY1DcCUp8IB8hANS91w6KrP5gUoHfPxop+F7/O6fX4iPR8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from 0002-tracing-expr-v3-1.eml (unknown [111.196.245.116])
	by APP-03 (Coremail) with SMTP id rQCowAC3m+J6xOFp7TdZDg--.55075S2;
	Fri, 17 Apr 2026 13:26:18 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
Date: Fri, 17 Apr 2026 20:24:00 +0800
Message-ID: <20260417223002.1-tracing-expr-v3-pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, pengpeng@iscas.ac.cn
In-Reply-To: <20260409123001.1-tracing-hist-expr-v2-pengpeng@iscas.ac.cn>
References: <20260407153001.1-tracing-hist-expr-pengpeng@iscas.ac.cn> <20260409123001.1-tracing-hist-expr-v2-pengpeng@iscas.ac.cn>
Subject: [PATCH v3 1/2] tracing: Return ERR_PTR() from expr_str()
X-CM-TRANSID:rQCowAC3m+J6xOFp7TdZDg--.55075S2
X-Coremail-Antispam: 1UD129KBjvJXoWxGw18WFWfurWxtw1fuw4fuFg_yoW5Cr4rpF
	48XwnIg3ykGF4Ig34SyF48C3W5G393Gr4UGF9rCayIyrnxtr40qF4kWFyUXrySvrW0qw43
	JF4DZFZ8Cr4jgFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUvK14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2jI8I6cxK62vIxIIY0VWUZVW8XwA2ocxC64kIII
	0Yj41l84x0c7CEw4AK67xGY2AK021l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xv
	wVC0I7IYx2IY6xkF7I0E14v26r4j6F4UM28EF7xvwVC2z280aVAFwI0_Cr1j6rxdM28EF7
	xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40E
	FcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr
	0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcVAKI48JM4x0x7Aq67IIx4CEVc8vx2IE
	rcIFxwCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbV
	WUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF
	67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42
	IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF
	0xvEx4A2jsIE14v26r1j6r4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxh
	VjvjDU0xZFpf9x0pRD5rwUUUUU=
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

expr_str() already has failure cases for invalid recursion depth and
allocation failure, but it currently reports them as a bare NULL. Teach
it to return ERR_PTR()-encoded errors and update parse_unary() and
parse_expr() to propagate those errors.

This keeps the error conversion separate from the string-building change
so the follow-up seq_buf patch can stay focused on the overflow fix
itself.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
Changes since v2:
- split the ERR_PTR() conversion out as its own patch as requested by
  Steven Rostedt

 kernel/trace/trace_events_hist.c | 33 +++++++++++++++++-----
 1 file changed, 26 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 73ea180cad55..954e0beb7f0a 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1764,13 +1764,14 @@ static void expr_field_str(struct hist_field *field, char *expr)
 static char *expr_str(struct hist_field *field, unsigned int level)
 {
 	char *expr;
+	int ret = -EINVAL;
 
 	if (level > 1)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!expr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (!field->operands[0]) {
 		expr_field_str(field, expr);
@@ -1782,9 +1783,9 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
 		strcat(expr, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
-		if (!subexpr) {
-			kfree(expr);
-			return NULL;
+		if (IS_ERR(subexpr)) {
+			ret = PTR_ERR(subexpr);
+			goto free;
 		}
 		strcat(expr, subexpr);
 		strcat(expr, ")");
@@ -1810,13 +1811,16 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 		strcat(expr, "*");
 		break;
 	default:
-		kfree(expr);
-		return NULL;
+		goto free;
 	}
 
 	expr_field_str(field->operands[1], expr);
 
 	return expr;
+
+free:
+	kfree(expr);
+	return ERR_PTR(ret);
 }
 
 /*
@@ -2630,6 +2634,11 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
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
@@ -2842,6 +2851,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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
@@ -2855,6 +2869,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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

