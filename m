Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.161.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792777597;
	b=0D27v4jouuxEL7/4+UnLDWVx8c0dzjMmdeFxJfWxT0db0unqc7YpHb5lZW3KdJyade5o
	 PuqneEyuLtdgYiKrkGc1JSAjLV6rgrsUAFunEwGDP31LFxCGeStKDbOwyS6VvjhgwMsY7
	 eIMLld++tCWL5eA8a3MyGkkG+BHyPWMoOZpF985tUZobPPLkECvL+brSYvS3ne5yAYhKe
	 yhHcNPws9ugCrCPL6KMqqEpMbrp5hES1DMd3itArR6sY51IuJHFkBSLaBTSxhF3IOkLuk
	 uKfgPmXfri/qm9MdEZyhReVSz+wZYrUeDcXmdEZB1939g9Zir/vCt/aOm302LSsAZ1g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792777597;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=xlzj9+7VUiD0rDPjj9xsdhl6VeuEJi64iOeLJzH8Fak=;
	b=iEUUKRe2jSl8y+Fs6ixJxo31jnVzK+A66PMq2ECW1HlJ/yZNwVecLwVMB3GSLxg70OQc
	 RA3krwm6bsXEUvzsS47cMMLm6DGvwHPD3RUGlSIqgVxE/bbGudD/F1FQdyfo7V1kIpK1i
	 2jPwVyxhxiUPzft+RrR7prj1WgZ2p0OLsnjg9quEULzn/PKUWZg547d3hO5DVzBrsHXB4
	 ROkFY0nQZj1CytClIDrwk4Z7LBRmgffx0qX2249pAARwPFbL0eRWK6nncfeKuVzLvfcWv
	 q9MEdVpKCPTxVh2Fe8klPePvDQOhd/B9Ve2+zH+rfJuQdcWKFpnQOhqrCfW3gCSBirA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=openai.com;
	spf=pass smtp.mailfrom=openai.com;
	dkim=pass header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=YxiS9C1Q;
	arc=none smtp.remote-ip=209.85.161.46
Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB91606A31B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 17:46:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3BB91606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=openai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openai.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=openai.com header.i=@openai.com header.a=rsa-sha256 header.s=google header.b=YxiS9C1Q
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-706113e92f9so656967eaf.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 23 Oct 2026 10:46:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openai.com; s=google; t=1792777595; x=1793382395; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=xlzj9+7VUiD0rDPjj9xsdhl6VeuEJi64iOeLJzH8Fak=;
        b=YxiS9C1QOQiQj62KnEdVaa4HjaEBExW5bp5Ol+/YPk+f2I+3STcUEaRI1aixJFSIVQ
         foZtdo93KcXjp+UKIWW7nmoC0ZCH4CyhqCW+I/QewtnJZBg1/bONh7uFQO3PyIDaFftP
         Cul9W/M1VUsKfdYKyQllyYvirVbrAe3fb5DeI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792777595; x=1793382395;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=xlzj9+7VUiD0rDPjj9xsdhl6VeuEJi64iOeLJzH8Fak=;
        b=vyTFRm4C+oXyCr6wjU7iTp6yjLGz51LQ1SpkvWsu3+yuUt5fGh0pTuamntB5WuX7bA
         g2ZFgHkSfJIY+2Y1v0pc6QCYsojWVzJkeJIBTNIsr56xts6ycP+wwzFiUqlWh1tysOT6
         QDYUzpMRq7XVNIAtHDKhF3HAGGIgrqdLADvkhUIeg4rW0QLBYqa1y5GDWlMlnxeXoud+
         QTWT/sHTC1mudRNlOQhM3guVLIBn7zdKwPfECF4oI/N13VTv4h/VbHsS0J3C3ZxYgOC0
         uXTGShnbcxUFGABR0CCBn1LciqZY6gJ/E0iV7gAlgfXHuchCOeRvD+xV3Q5ISFIpKRui
         x0XQ==
X-Gm-Message-State: AFq9FYL6HMa9uNmKVpb1tDjy0J5eY3qAWLNRzLSZHA002RTWaqd+8ubO
	hYWBoths0XBY4qwon7yTavJY/qGD0iB6n/yBqlpaMGGIMvGc/6rnHoRh022b7m78ndDSeO8Wd0M
	ZMm+eveI=
X-Gm-Gg: AYBFou2hmimWE1ggv/MfLr1XmUL7h6PD0JCiK+OQYlPm/9rALUTNDd9gCdlqRi7uy/E
	ITmmuo/zhc/P3Nf4uOVQK2bC3TEnZ/YZkydZ+yCOv5lwjaeJmT1IvsfTQtL3qAgebjCP3/NHfqh
	pP6+aIJtaHjBvTsN/K7bwatfD+iJY/skDK2B7ZkZr9iQPUGhWL083JdNrI5VmE24bj/l0nvbTix
	XskHBErTii0nl0D9aBDCkMaSbAPHgdV1vBAkzZcYzyGDjkUrFc4kX5gZ7UDbLyFcxBqJMotR6x5
	comOvRl/HRQoAZiHpqD8hSJ1jtgMYK14HZuxFcz43EDJYOkETEapx1+Y8Bgg838HCPSppanZmTB
	o1q7GNMDN9QOMswq2M8N8mFQiRXD9fD/rWKFpTK5xtRe/m47CQZXZWE3M1nIggfSWUk1e/xPn04
	W/FwySasRaGvQFnniMDv77AejXS6WV5kHQG6L7jBdJw6dAXy+V0dwuPW0ihQj9MlJhoeVb0jnB9
	jQBMBGRXfxJxA3EJF3uUA9ju6DEFpRj6RhV1gtKIA2meZolY4+graJD8NFdLUgZWzNVV14gGI5N
	4DbmZJrWyC8bgIjsk2khoUXoEEdfS7Iah7Jk6jPHz4FFsMw+hdQYyv0rBA==
X-Received: by 2002:a05:6820:2215:b0:70b:980e:454 with SMTP id 006d021491bc7-70b980e054bmr960802eaf.6.1792777595042;
        Fri, 23 Oct 2026 10:46:35 -0700 (PDT)
Received: from com-75606.corp.openai.org ([199.47.143.5])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-70b9aec6172sm565349eaf.11.2026.10.23.10.46.33
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 23 Oct 2026 10:46:34 -0700 (PDT)
From: Kyle Zeng <kylebot@openai.com>
To: linux-trace-kernel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: Reject incomplete event filter expressions
Date: Fri, 23 Oct 2026 10:46:20 -0700
Message-ID: <20261023174620.91969-1-kylebot@openai.com>
X-Mailer: git-send-email 2.55.0
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A non-empty expression normally finishes in predicate_parse()'s inner
loop, which resolves the pending logical operators before jumping to
finalization. If the input ends after an operator, possibly followed by
unary '!' tokens, the outer loop instead falls through with unresolved
operator state.

For example, "common_pid == 1 || common_pid == 2 &&" leaves
prog[0].target equal to -1. The second pass then reads prog[-1] before
the forward-jump check can reject it. Depending on adjacent slab
contents, it can also copy an out-of-bounds word into a branch target
that passes the forward-only check. A self-targeted perf tracepoint
counting event can reach this path through PERF_EVENT_IOC_SET_FILTER.

Reject the outer-loop fallthrough when a predicate has already been
parsed. This ensures that non-empty expressions only reach finalization
after the inner loop has resolved their operators. Keep the existing
no-filter error for input that has no predicates. Add a regression test
for trailing logical operators and unary negations.

Fixes: 80765597bc587 ("tracing: Rewrite filter logic to be simpler and faster")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-6-astra
Signed-off-by: Kyle Zeng <kylebot@openai.com>
---
 kernel/trace/trace_events_filter.c            |  6 +++++
 .../test.d/filter/event-filter-incomplete.tc  | 24 +++++++++++++++++++
 2 files changed, 30 insertions(+)
 create mode 100644 tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2b46ca536045..405651be9c93 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -596,6 +596,12 @@ predicate_parse(const char *str, int nr_parens, int nr_preds,
 			top--;					/* #12 */
 		}
 	}
+	/* Only the inner loop can complete a non-empty expression. */
+	if (N) {
+		ret = -EINVAL;
+		parse_error(pe, FILT_ERR_INVALID_FILTER, ptr - str);
+		goto out_free;
+	}
  out:
 	if (top != op_stack) {
 		/* Too many '(' */
diff --git a/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
new file mode 100644
index 000000000000..cc6df762845f
--- /dev/null
+++ b/tools/testing/selftests/ftrace/test.d/filter/event-filter-incomplete.tc
@@ -0,0 +1,24 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+# description: event filter - reject incomplete logical expressions
+# requires: events/sched/sched_switch/filter
+# flags: instance
+
+filter=events/sched/sched_switch/filter
+
+for base in \
+    'common_pid == 1' \
+    'common_pid == 1 || common_pid == 2' \
+    'common_pid == 1 && common_pid == 2' \
+    '!(common_pid == 1 || common_pid == 2)'
+do
+    printf '%s' "$base" > "$filter"
+    for tail in '&&' '||' '&& !' '|| !' '&& !! ' '|| !! '; do
+        if printf '%s' "$base $tail" > "$filter" 2>/dev/null; then
+            echo "Accepted incomplete filter: $base $tail"
+            exit_fail
+        fi
+    done
+done
+
+echo 0 > "$filter"

base-commit: fd179f8a05be3ccae366b9b96e176b51fbe54aab
