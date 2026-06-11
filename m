Received: from cstnet.cn (smtp21.cstnet.cn [159.226.251.21])
	(using TLSv1.2 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379BB2DB7B9;
	Thu, 11 Jun 2026 05:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=159.226.251.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781157597; cv=none; b=I8KnFzsyV7vTDtgvdFZWOSMSuvoYxN/GV8sTIzjshmWp1Qhm6kx9eYrOo9dou22TB3LGAnIwW0st+xPTZ5Whip1jE8lB5vEAcnh5sYdb11xeVZdxFmzaL9a/i0OSyrmh9rw4bnzNMF9D/TOhct/eEjmkGcylXSfxTBYGa39+CZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781157597; c=relaxed/simple;
	bh=xIWDsWMDfzSC9s4Hxf2T695OOeCQGjh3p+/FrdCRcZ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tijsdrP7RSqLSKuqfxkKeTn0kl7jj5DrZPE4c2GlUykLttDEYnopptHOSp0X0lSYyBC7zY/yODSWsowV5kU6hIj7hPOWJ0VWq5DFC59pgRqwCx3+tYG1xkEGyZrCiLOMDkym/jqoFOzCTikmXK6cbyyX+RHIKwQ2DTaMLjgNKXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn; spf=pass smtp.mailfrom=iscas.ac.cn; arc=none smtp.client-ip=159.226.251.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=iscas.ac.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=iscas.ac.cn
Received: from localhost.localdomain (unknown [111.196.245.140])
	by APP-01 (Coremail) with SMTP id qwCowACXPdbTTipqvyxFAQ--.9346S4;
	Thu, 11 Jun 2026 13:59:48 +0800 (CST)
From: Pengpeng Hou <pengpeng@iscas.ac.cn>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pengpeng Hou <pengpeng@iscas.ac.cn>
Subject: [PATCH v5 2/3] tracing: Return ERR_PTR() from expr_str()
Date: Thu, 11 Jun 2026 13:59:44 +0800
Message-ID: <20260611055945.22348-3-pengpeng@iscas.ac.cn>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qwCowACXPdbTTipqvyxFAQ--.9346S4
X-Coremail-Antispam: 1UD129KBjvJXoWxWr4fXF18tr43KFW3tFyUGFg_yoW5XFyDpF
	4kXwnIg3ykJF4Ig343AF48u3W3G393Gr4UGF97uay0yrnxKr48Xa1UWF1UX34SvrW0qrW3
	JF4UZrZ8Cr42gFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBl14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jryl82xGYIkIc2
	x26xkF7I0E14v26r4j6ryUM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_Xr0_Ar1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1l84
	ACjcxK6I8E87Iv67AKxVWxJr0_GcWl84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v26r126r1DMx
	AIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_
	Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwI
	xGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWx
	JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcV
	C2z280aVCY1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7VUULZ2DUUUUU==
X-CM-SenderInfo: pshqw1xhqjqxpvfd2hldfou0/

expr_str() currently reports all failure cases as NULL, so callers cannot
distinguish invalid recursion depth from allocation failure or later
string construction errors.

Return ERR_PTR()-encoded errors from expr_str() and make parse_unary()
and parse_expr() propagate them. Clear expr->name before destroying the
hist field so the error pointer is not freed as a string.

Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
---
 kernel/trace/trace_events_hist.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index f778f060e922..082842e64ccd 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -1762,11 +1762,11 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 	char *expr __free(kfree) = NULL;
 
 	if (level > 1)
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	expr = kzalloc(MAX_FILTER_STR_VAL, GFP_KERNEL);
 	if (!expr)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	if (!field->operands[0]) {
 		expr_field_str(field, expr);
@@ -1778,8 +1778,8 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 
 		strcat(expr, "-(");
 		subexpr = expr_str(field->operands[0], ++level);
-		if (!subexpr)
-			return NULL;
+		if (IS_ERR(subexpr))
+			return subexpr;
 
 		strcat(expr, subexpr);
 		strcat(expr, ")");
@@ -1805,7 +1805,7 @@ static char *expr_str(struct hist_field *field, unsigned int level)
 		strcat(expr, "*");
 		break;
 	default:
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 
 	expr_field_str(field->operands[1], expr);
@@ -2624,6 +2624,11 @@ static struct hist_field *parse_unary(struct hist_trigger_data *hist_data,
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
@@ -2836,6 +2841,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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
@@ -2849,6 +2859,11 @@ static struct hist_field *parse_expr(struct hist_trigger_data *hist_data,
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

