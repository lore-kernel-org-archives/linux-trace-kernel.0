Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4059E3A0EB8
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 21:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779314319; cv=none; b=dTdjmqak6aFHI7qvlyuqoqTJTFSWgCREWldQYsqOJqVkgsTzUcQODstGVqdc+FZabtOpFWoRpz271I0oJj3v25Nm23jAfydAfYSS0MkMo+ITv58vKoaNGDO3I7DrDcH5mRstG1yo3HVzb2SmYq2ogvnkly3nA3fNriymPymuGRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779314319; c=relaxed/simple;
	bh=39Gt8rB1JCMWARzBhN7sjVwIsshPckmW2W55n9ARnbY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gSVd6cNLcVUzmTtjGLUzXXu/qUmhfy2WBqQWqN5B8tkQEWyP5shE/pP6Qljg6kZr+AcGSJ8EYBzQXd6AN1BNqvFcUiTzq8u7ImRfEFh17lTS44nVre7C4nkxEaTwxyHvkKdmGUTutfBDQF6mdV7lxrxlkLXsuuvEPEJ5kRH1dHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=snaad4Tl; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="snaad4Tl"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-36974220e45so2228104a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 May 2026 14:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779314315; x=1779919115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jDSnjm/dJwUnHCR5eUkgy/BeIvqG46BmxLZ8ZhFb2Wg=;
        b=snaad4TlCj+vJ0n8+bEkwQL9e2BOGqxR76JIc+Cps6/Qxc4zwSy34r1wLMjPHpVzOx
         KJHxZ4tm5o/zk+iiBK+1haShY7IzaJyV7IfZCNK3hT994G6QfEOkR+nNjzwKZjPsxCJ9
         qtmhd8ym03Rdk1GtxmC8khktS9Xf9qKujH8gPdsaRp0bNQZ2RSNlp1cZ6y6G3PIUnp5q
         +WIxnlXXXwzInAZFadpj7Tphhr2NGWSV4grNF2dqHm6TIQ6KpsraM4w1zZESOos+x547
         oge0NpdJB5luckjfnsm8GYFk8lXWMKFOu4OiSeYg361h8UCXqtVXVz145XsseflYPcs7
         vUpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779314315; x=1779919115;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jDSnjm/dJwUnHCR5eUkgy/BeIvqG46BmxLZ8ZhFb2Wg=;
        b=V+TrP5FLoXqwWIHzjNKncfJ63+KS6g4ru9LS9hQA+CahRHZX+oSqu2AnF4qSluBVFI
         i0ICKAtbQzaXKl9Or5JmKedLkmEDQHslI5S2k0u4ncauhj0ocLmLCHsIlS9nCEM9R8DI
         neQ0FnOJQ9F3OWmxefep9UMh/Crf4sOnZXERFCwQ1wQnQdTdQsiYV87hj5od1TjRMLCw
         jvlM0c002hFumCrhAgTGTSf3kn2TWZRtIsq2BTiU3s7r+AKadiovzuCYAMjbH6E6HL02
         9eCZvO4fLUwJJAh6Jt29RYL+iYdatbCIr/vLAfEQ0GfBKAQYAsIZmkKV8LamzIcz+qlV
         vrOg==
X-Gm-Message-State: AOJu0YxJS6x3aGYSalMj++vFMpORweNDPtDGQJIpEdLm7IXQeOnjWjKx
	j5lzzcpy9/39G5GBYzuiEWvwAF6wo9pzGrlLzSNjLUukXMCgyy6a93+kEk0oEi0h
X-Gm-Gg: Acq92OF0qypCwCBLQD4Xm9+J4tglg2slrzkLfpWzvZZFaBRI1ezxm0hmFqXiDprW3hs
	Jv7UGptOrKX3yWSjP+uZs4Yz2ck4mMA7A8WGeXlaA/7c3sO4vp+IueImvBsIAkDFhMlo8TSS4tV
	FLL5qkn3GBQHL3Foc/02Hl/gN9Gi/jYgEs+223fsflitOkZVhCZpiBoqKcIe6VjJCoRJees7vkW
	voWXCvCQYsRtqosC+LlhP33DpLjJPlLil8mjpYDar+UAzLinTzM1kCRuv7Z3leIecCrEh8atQlN
	BBoSslf9bdaidkczJdWYWndRuFKuFG/ra+r6Q0P+SBoTqejsSBqR9432s06icwq/besc9eF0Of3
	iViPr56g8KeT4fWwAHM0a2dBlCIVh9q5/tPUXdnsKvd0SHo4qhBbEHxaLMDAesLDjt/oyeXP65L
	8yBwrYwv6K1r++y0QyCpC0oBqXW5QpkjYDkfpz24HvjDIJ2uUAjtntMFFNrBjiNSZQzduDg3jY3
	A+aO9Q+YJbqJbxmPGUEwrexucM9dyHuKls=
X-Received: by 2002:a17:90b:3942:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-36a491ad00emr104057a91.12.1779314315554;
        Wed, 20 May 2026 14:58:35 -0700 (PDT)
Received: from ryzen ([2601:644:8000:5b5d:7285:c2ff:fe45:8a32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36a3cc5643dsm646368a91.7.2026.05.20.14.58.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 14:58:35 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list:TRACING),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be|_ptr)?\b)
Subject: [PATCH] tracing: Use flexible array for entry fetch code
Date: Wed, 20 May 2026 14:58:17 -0700
Message-ID: <20260520215817.16560-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store probe entry fetch instructions in the probe_entry_arg
allocation instead of allocating a separate instruction array.

This keeps the entry fetch code tied to the entry argument lifetime while
leaving regular probe_arg instruction arrays separately allocated and
freed.

Assisted-by: Codex:GPT-5.5
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 kernel/trace/trace_probe.c | 8 +-------
 kernel/trace/trace_probe.h | 2 +-
 2 files changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index e0d3a0da26af..39f040c863e8 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -838,15 +838,10 @@ static int __store_entry_arg(struct trace_probe *tp, int argnum)
 	int i, offset, last_offset = 0;
 
 	if (!earg) {
-		earg = kzalloc_obj(*tp->entry_arg);
+		earg = kzalloc_flex(*earg, code, 2 * tp->nr_args + 1);
 		if (!earg)
 			return -ENOMEM;
 		earg->size = 2 * tp->nr_args + 1;
-		earg->code = kzalloc_objs(struct fetch_insn, earg->size);
-		if (!earg->code) {
-			kfree(earg);
-			return -ENOMEM;
-		}
 		/* Fill the code buffer with 'end' to simplify it */
 		for (i = 0; i < earg->size; i++)
 			earg->code[i].op = FETCH_OP_END;
@@ -2051,7 +2046,6 @@ void trace_probe_cleanup(struct trace_probe *tp)
 		traceprobe_free_probe_arg(&tp->args[i]);
 
 	if (tp->entry_arg) {
-		kfree(tp->entry_arg->code);
 		kfree(tp->entry_arg);
 		tp->entry_arg = NULL;
 	}
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 262d8707a3df..1076f1df347b 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -238,8 +238,8 @@ struct probe_arg {
 };
 
 struct probe_entry_arg {
-	struct fetch_insn	*code;
 	unsigned int		size;	/* The entry data size */
+	struct fetch_insn	code[] __counted_by(size);
 };
 
 struct trace_uprobe_filter {
-- 
2.54.0

