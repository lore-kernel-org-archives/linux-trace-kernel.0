Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2164133E7
	for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Dec 2025 10:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765447274; cv=none; b=IrO3Hg2ixko+P5GbbXGqDZL0bQCRogIBjlyV9hFQEAcHWppp0yO4AN/DwXbvASE45qaSOUfW98ftpu6zyrmi7rWfIw/wbwBINnAvyjBRRT0/3/WkZXh1GlQSVxS4LNRsQz41F5ImkjFiOLu+A86rsA/yeDXP8kGfb69Tu79lKwU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765447274; c=relaxed/simple;
	bh=pVqkKjEXVMsrV1BoKv6j4NeN5cbUKVI6QzaVPeB0uR8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=spevN5qx1Q91Fa1wXxW90csOiTFqVLkUDd3GhRys/V8F7/LKEL9dekcNW7qk+wm3C4xStiXrtWazjDenPKzStjTnmUy0kCbmJE/GhgT0OhzM9/hrCKeM7KI8OxCMfHt5inr2AfHlM211ZIlPHPF+p4B+9nw+9bjHHynwZ+r3NyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BRXx8sO9; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BRXx8sO9"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7bc248dc16aso654652b3a.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 11 Dec 2025 02:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765447272; x=1766052072; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=qxUAwgYNPZb3dBwYcv0C/4y2So0BODQraJ+2jRjaA7w=;
        b=BRXx8sO9DbfIf3MxVh3J1zO/pxQ2xGwAaS7mtZGEWPlSB36gUgFApqqLyer8GQtTyg
         I4hWJyDYQPFeC+KT0mouOjfGnkQqu8kYA6MfjtVY8RPISm4fJPrbaFpo7juSbe/tESwQ
         /p+07p3yOmeW8oPstwsP5NWEPl1nNw9NQa4i4sNHwtQMFd+kvGzEE7d42ZSZOm8jq8LY
         1N7A7IatW1yw5ztQA9QPcRN+HzUcIsyJRQfrxHtS0xOZPy3p1BHJl2c5kWydSsIQ6wkR
         yyOVSRtPEz41dBsjoCe86v+xIrKi3sYWag2iN3J8ITWF+vw/SS3RL9pJepWgd9gp6GeF
         haBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765447272; x=1766052072;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxUAwgYNPZb3dBwYcv0C/4y2So0BODQraJ+2jRjaA7w=;
        b=cSxeN1TZL9tZzSVaTKq0/FwChXvIzUHXV3ZZq8urq1KRebHDObnRQlfDMHmmNb2hjL
         Fq3C/4Br3LRl43Rhf2vyKPa/5rnXarzTIgJvj2fTOZGwCKfjRclazIZtrTs0Jr5kCwuW
         xy5qGYq77a+hHxD9p1DRR05+jLIOr4JeCxLkP10ZcFrO/sgdJ0fOWvV64XyeOl3yFuQB
         03B5R85oU1x3aQGPAPd/cRECECv86eq0EiGoexnqw68n/VseiMyJKEE4R+yiApBN6lc5
         7BDM4McTKmNzPu96VHfTtk9Hixg8uwy1ux6IccgnEsRpg90I8C2bYaOeMrPEPK6hqodQ
         92Bw==
X-Forwarded-Encrypted: i=1; AJvYcCWUKMHTrLcb2PExir1UfOWVBo0gI9PFTG5pnsX0KziH6jA8brlYFqUlB4jJui2eeILMX62Gblsh7K2veUWYOyCVMBM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy0MN02G3dtvQx1OivHxw+TI9j8S8HbPjT5mIpv3iQ4BkKp2AFC
	S5z+K50rpOhVyHm6SQKeJaBYCsuMlTN1UpvaiWnM28EdEI+JHSAVU7l3
X-Gm-Gg: AY/fxX434mLC0heYmOthhn3Z8ShwC+UvXbpB8A8AAw2hjYDBIM1HjDM0jT45NIHjLDw
	V9crCVBIzQbsSki6/AUMOuV3Lv+2DfGCr+t1qzygXdIGBkebFVFl2OsY49e608Rv5+sWNRaramm
	OFQLl4EAa+PtkzgT4UqQKJcxgOfflBzUZHhOt+1gkpQYmaF19cj6TKz0Z7l8XFJx5eddAeqolgi
	Czr8td9EiaRnwBjWNWy7oHEeK4MnZZCD+iiqyI0dqsXyrfyEp2IfyztB94x4tVrSIZKhmcAa/Mz
	tzxR+AiOnN/MyiiwTNQg1d88ymSmJd19/SmNCWBpRPvNEkTWJF7Is6lt6kaKW/xAC1gfnKe6Uf+
	2Lq8sQOs8cGUbUzjoGlI3Kstxz8eeomHK5Qczkr5OxJ1TcrL9swtXafTdmYcy+5wIp/bD7snUG2
	nn+6RbtR6aGRFj
X-Google-Smtp-Source: AGHT+IE28P5MxEOst+lrzYcF5oWn2Bj1irMns/TapvB1X3yMs4xi6bm3rBPZTYcsNMKqPvxAsdI4cg==
X-Received: by 2002:a05:6a20:6a1b:b0:350:66b2:9729 with SMTP id adf61e73a8af0-366e2fc161dmr5264654637.60.1765447272165;
        Thu, 11 Dec 2025 02:01:12 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-c0c2c48bf7asm1932653a12.32.2025.12.11.02.01.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 02:01:10 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Tom Zanussi <zanussi@kernel.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Fix error handling in event_hist_trigger_parse
Date: Thu, 11 Dec 2025 14:00:58 +0400
Message-Id: <20251211100058.2381268-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Memory allocated with trigger_data_alloc() require trigger_data_free()
for proper cleanup.

Replace kfree() with trigger_data_free() to fix this.

Found via static analysis and code review.

Fixes: e1f187d09e11 ("tracing: Have existing event_command.parse() implementations use helpers")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 kernel/trace/trace_events_hist.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 5e6e70540eef..f9886fff7123 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -6902,7 +6902,7 @@ static int event_hist_trigger_parse(struct event_command *cmd_ops,
 
 	remove_hist_vars(hist_data);
 
-	kfree(trigger_data);
+	trigger_data_free(trigger_data);
 
 	destroy_hist_data(hist_data);
 	goto out;
-- 
2.25.1

