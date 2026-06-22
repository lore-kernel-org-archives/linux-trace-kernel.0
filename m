Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDF835839E
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 16:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782144046; cv=none; b=J9qHd9+MefFoNoI4OXCwpy0yAPmdjT99SRbM7bbwHH9qF60O8LS++Iwkw/QXSoKgko2073sxyseVbA/iomrrrwLM74fKN67IjehwyZXlxOaIRQ1EpX999FWk3Xh3H9CC4H2Qq3hsIR6VBlZkP+vHLW8PZUPTixi+oe7LOBV2e3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782144046; c=relaxed/simple;
	bh=oCqsQTLzKc7BYIdGcaeMAIuabYRddRvNDDrQsYyUKyU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPj/WxvhSCjbVoub5uUooQIQocUfKKFQkkmoBNA52fsDZmqxJB1K3tJesY6Tu9/K4ay9C7SQNrAT1JOGo38rzD8HwOqXUcYJ4wkaGxnRhuwZlu8NEn7fdJQLzU1BNSoLUgaN6I5LFISgJKuu9Ec7dwmBg6HkLEw+wd3eKtR+K3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H/BGbB2k; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H/BGbB2k"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-37c73707374so278563a91.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Jun 2026 09:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782144045; x=1782748845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZT+VAiMRNlf6hoVq+DyywqQP3pG1p+oX2OgGmWGyy0g=;
        b=H/BGbB2kwfsW0mieKlu4xX4tPYWtS4QGDmjQFjc3Uq7IHPU5H/wXcYOuTl+j7g1TQ0
         dl3Q8Q1zfn+xKgZ2FT8V7a8R/yPa7NfXBr3/cwXeu1g7OpmsnIFBhgyYFTE28OvkNQdj
         C3xqN3E6RUn901O6L3VZEbTA7naWmIB7XwV4q+Ywh4Os1LAaeIvCP0azqT+ztYVzZwuz
         KqA2reslgcrjszuYSdboHhcLf0m3WFWL1mvDwpDJIzrAPa7R7/iIOmr67TizmHzvmB1K
         lpliz8czjJ3ZxFltHYapFQlhMFSMpxuuPF/c9TFh6wPQtDIUCaRzVLJoih51+xecgW3x
         I5pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782144045; x=1782748845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZT+VAiMRNlf6hoVq+DyywqQP3pG1p+oX2OgGmWGyy0g=;
        b=c0HF43WehVkg8BRFcbn6dM8hKSLcP4HntrG932t2+OAWf5E7qYG33c08sUQ5uxDVaY
         9vf/ypJc8fZsOsvlv+lYCApmii5Unl+ei814dvDGoK9xJNcwUUYiJdDoBKxQm7na28eN
         mU2fajsA/2VOprsOedHYG8vxwm1ucpAs7I7vVa+fC17AyY4Hb2tayVf/hldcmoOOe258
         B82ARNzobKrMY0f6950Z5eIF79lb2fCFlmMSEvnUMafa+hbuw/4Ffp8PL/HZSRq+uUnm
         OKDGYznsRcV+Y1d1DRWQFOO/2GROii0PITz34gt1IGCIugUjKLY93sTvt/jFZqesRpR3
         bN1g==
X-Forwarded-Encrypted: i=1; AHgh+RqBX3oN7lQsPUargg6n+UhkIZ4Z2NaBuHo+I+48jU10aJ67DiEqyPqG3S6D5j2wp//oBJWeL6AXDt3SHTU7flf7B8E=@vger.kernel.org
X-Gm-Message-State: AOJu0YznadMzk6FqRiy2FVKnkFb4lkxQYbH8l+i9RaLAt0CEbJeai7jF
	B1hi5Pvo/4aT727pZl1M4/nadD9/nrxpCuxj/EeFqY6qucnhLYe/h20h
X-Gm-Gg: AfdE7cnMKwC6oABQmwL1Kel8dlUANMZAjBsuw8AOsH4DsYOyku92KqmziuGReozHbDU
	L0SB13vDi4X/VyEL8m70nqtrNFPyG/KzcajBTMXYISjihT1xRp1GHSGNLIUXJoLaYUJJb2OHCYm
	C6OfbRw1P7wj3c0Me/11qwaKPnXAVVySL94VnyxXiA6TtnvOJX8BJFywdRVTL6KBEglu7E8p6sE
	Ek2bslnQB9cBlqByKEAo/BtKUEPxltObofGOCfktHDjLQ41GdLQlO+ijdReBZonTMx5ztUws56g
	PV0eWo3FWOF1XtF/1NGvdh3bZUr2BkJYanFY5QRrNwMPMUiR+Drzdzos4GulO2iTrf0odolZDrd
	t+aLrImtPdeFk3342Q+gbJXEeEiviRsab6uuQdDPw4BfNqU3yYEAiislMeCpI7x9FrM6AvpxuCV
	ZTdYs+nl19dFUu
X-Received: by 2002:a17:90b:570d:b0:368:e6dc:eee2 with SMTP id 98e67ed59e1d1-37dc9825435mr506851a91.3.1782144044668;
        Mon, 22 Jun 2026 09:00:44 -0700 (PDT)
Received: from pop-os.. ([114.4.214.207])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-37d4f315842sm7479818a91.17.2026.06.22.09.00.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 09:00:44 -0700 (PDT)
From: Yudistira Putra <pyudistira519@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yudistira Putra <pyudistira519@gmail.com>
Subject: [PATCH] tracing/probes: make file offset error message probe-agnostic
Date: Mon, 22 Jun 2026 12:00:32 -0400
Message-ID: <20260622160032.99834-1-pyudistira519@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The shared probe argument parser rejects file offsets for kernel probes.
This path is used outside the kprobe event parser too, but the diagnostic
currently says "with kprobe" even when emitted from another probe path.

Make the diagnostic probe-agnostic.

Signed-off-by: Yudistira Putra <pyudistira519@gmail.com>
---
 kernel/trace/trace_probe.c | 2 +-
 kernel/trace/trace_probe.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index fd1caa1f9723..fec0ad51cf61 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -1228,7 +1228,7 @@ parse_probe_arg(char *arg, const struct fetch_type *type,
 			code->op = FETCH_OP_IMM;
 			code->immediate = param;
 		} else if (arg[1] == '+') {
-			/* kprobes don't support file offsets */
+			/* Kernel probes do not support file offsets */
 			if (ctx->flags & TPARG_FL_KERNEL) {
 				trace_probe_log_err(ctx->offset, FILE_ON_KPROBE);
 				return -EINVAL;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 15758cc11fc6..6162f066c2b8 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -516,7 +516,7 @@ extern int traceprobe_define_arg_fields(struct trace_event_call *event_call,
 	C(BAD_MEM_ADDR,		"Invalid memory address"),		\
 	C(BAD_IMM,		"Invalid immediate value"),		\
 	C(IMMSTR_NO_CLOSE,	"String is not closed with '\"'"),	\
-	C(FILE_ON_KPROBE,	"File offset is not available with kprobe"), \
+	C(FILE_ON_KPROBE,	"File offset is not available for kernel probes"), \
 	C(BAD_FILE_OFFS,	"Invalid file offset value"),		\
 	C(SYM_ON_UPROBE,	"Symbol is not available with uprobe"),	\
 	C(TOO_MANY_OPS,		"Dereference is too much nested"), 	\
-- 
2.43.0

