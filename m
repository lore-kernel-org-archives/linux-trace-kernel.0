Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783AC30DEDF;
	Fri, 21 Nov 2025 22:19:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763763552; cv=none; b=RRNoSY0W00DCLJF4MLydEn79zBeoZ+GB1NghQubGWGwLjJPTypzTRRGfPiXWVQrzWn1mYwRLDmBRPrpuPbJRGfgg0TxztGum/EMK7LxyAk45xzX4jHbTtj0I+kG+cqEmG383uKs+QcC5N5UWXl5zUnN3wUCExhHzvucJrE5JePQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763763552; c=relaxed/simple;
	bh=FzjHx/bXu4lX/H9i0gOf918NwMP3Po7A4ypq+6sl6j8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AsJY0S/5dig6Mw8sJGakP5QMvOv/3tiKfFSaAgKddWN/zsh/QK9cLn0jCAkMViYI8yfLZeusVxuGse+45DL4w+PPNPfbXbwojG7xQ4TA/3vF9kevlH0nE+eigz6NzbCtbhns+B3I0r4oepIbGGd4d/viy19WtArQqzzlZix3bQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=le4fSbaj; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=le4fSbaj; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="le4fSbaj";
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="le4fSbaj"
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4dCqPl3Fpvz9tjW;
	Fri, 21 Nov 2025 23:19:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SE//RnLm+RWLlQtT55RUpb8XvaYIbZtYCYKxfObWWMU=;
	b=le4fSbajlfDI+iPPw9AevIkzsI+n0J9PyooawLv9NCLHiMMsMVtCBae7w2doBenWF96s3I
	XP7SeKBnwM18qaE+CM/s48V493wyeVi24q7/hF/nns6M6m9sy+UOCmC2OV1v1mBl24Wro5
	XCC8FBTBgzGBz6rxRUdTiKPO6CcpkWlZIjvpzX00fj+noskG5vODixZcECy1lLwz25uqFl
	CgsRDLhyrrhgW7SEdRDmHzKmxdMx7Gp90Ibhd3BxCxbTl0z7aiNn9u9/Rr/1WJAKnjb/kW
	Xdb/OmqY/pDRBkw8p/n/n2zlP0fF/2g2cXq/sgMJH4Vck7quDmN/v2+4h9268A==
Authentication-Results: outgoing_mbo_mout;
	dkim=pass header.d=mailbox.org header.s=mail20150812 header.b=le4fSbaj;
	spf=pass (outgoing_mbo_mout: domain of mhi@mailbox.org designates 2001:67c:2050:b231:465::202 as permitted sender) smtp.mailfrom=mhi@mailbox.org
From: Maurice Hieronymus <mhi@mailbox.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1763763547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SE//RnLm+RWLlQtT55RUpb8XvaYIbZtYCYKxfObWWMU=;
	b=le4fSbajlfDI+iPPw9AevIkzsI+n0J9PyooawLv9NCLHiMMsMVtCBae7w2doBenWF96s3I
	XP7SeKBnwM18qaE+CM/s48V493wyeVi24q7/hF/nns6M6m9sy+UOCmC2OV1v1mBl24Wro5
	XCC8FBTBgzGBz6rxRUdTiKPO6CcpkWlZIjvpzX00fj+noskG5vODixZcECy1lLwz25uqFl
	CgsRDLhyrrhgW7SEdRDmHzKmxdMx7Gp90Ibhd3BxCxbTl0z7aiNn9u9/Rr/1WJAKnjb/kW
	Xdb/OmqY/pDRBkw8p/n/n2zlP0fF/2g2cXq/sgMJH4Vck7quDmN/v2+4h9268A==
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mhi@mailbox.org
Subject: [PATCH v2 06/13] tracing: Fix multiple typos in trace_events.c
Date: Fri, 21 Nov 2025 23:18:28 +0100
Message-ID: <20251121221835.28032-8-mhi@mailbox.org>
In-Reply-To: <20251121221835.28032-1-mhi@mailbox.org>
References: <20251121221835.28032-1-mhi@mailbox.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MBO-RS-ID: 06523b29f25e7a13a3b
X-MBO-RS-META: ocf4wpohskkgzwxdiyuobb6f41g5t9oi
X-Rspamd-Queue-Id: 4dCqPl3Fpvz9tjW

Fix multiple typos in comments:
"appened" -> "appended"
"paranthesis" -> "parenthesis"
"parethesis" -> "parenthesis"
"wont" -> "won't"

Signed-off-by: Maurice Hieronymus <mhi@mailbox.org>
---
 kernel/trace/trace_events.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 9b07ad9eb284..b16a5a158040 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -360,7 +360,7 @@ static bool process_string(const char *fmt, int len, struct trace_event_call *ca
 			/* Anything else, this isn't a function */
 			break;
 		}
-		/* A function could be wrapped in parethesis, try the next one */
+		/* A function could be wrapped in parenthesis, try the next one */
 		s = r + 1;
 	} while (s < e);
 
@@ -567,7 +567,7 @@ static void test_event_printk(struct trace_event_call *call)
 			 * If start_arg is zero, then this is the start of the
 			 * first argument. The processing of the argument happens
 			 * when the end of the argument is found, as it needs to
-			 * handle paranthesis and such.
+			 * handle parenthesis and such.
 			 */
 			if (!start_arg) {
 				start_arg = i;
@@ -785,7 +785,7 @@ static int __ftrace_event_enable_disable(struct trace_event_file *file,
 		 *
 		 * When soft_disable is not set but the soft_mode is,
 		 * we do nothing. Do not disable the tracepoint, otherwise
-		 * "soft enable"s (clearing the SOFT_DISABLED bit) wont work.
+		 * "soft enable"s (clearing the SOFT_DISABLED bit) won't work.
 		 */
 		if (soft_disable) {
 			if (atomic_dec_return(&file->sm_ref) > 0)
@@ -1394,7 +1394,7 @@ int ftrace_set_clr_event(struct trace_array *tr, char *buf, int set)
 	if (!tr)
 		return -ENOENT;
 
-	/* Modules events can be appened with :mod:<module> */
+	/* Modules events can be appended with :mod:<module> */
 	mod = strstr(buf, ":mod:");
 	if (mod) {
 		*mod = '\0';
-- 
2.50.1

