Received: from mx0.riseup.net (mx0.riseup.net [198.252.153.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEB751CD25
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724685907; cv=none; b=QIldqCAokXVGouOoV6devvCc0GJRY6slAnjqTXJ8IcMSIpmybxpQCq7tdgKl39X+l3v8Pb8L3IxPf/rUKESPYnXWVzrxBVc2J88g2S7AFpWKo6vrJliFjXBVEKVs7rGYHEQkpWBH7hM2SUujyEEj7yFFN3IC80TsbAX4zSS52KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724685907; c=relaxed/simple;
	bh=+zty0WUx+YuA6hbs5HYPFJH5m/j/zqcgKrZJW256Dto=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=O8m3EWJ4/IFl9UF8Gk23PDXpviPpxmaS6Iu3wdo24ke7EsLljwDhl+VbRneIS9435PifXUNwvD039mT4Il/TAc7LPnSJFqd7fy6Gy90kk5TPQh9XKnNuCUJ6saelD3Y1WHCHAwwi85jc6D7sZJms0DZCmuiW7d2rBDp3j5fjhmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=X/ES7vaC; arc=none smtp.client-ip=198.252.153.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="X/ES7vaC"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx0.riseup.net (Postfix) with ESMTPS id 4Wsvcd0ydDz9vnM
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Aug 2024 15:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1724685905; bh=+zty0WUx+YuA6hbs5HYPFJH5m/j/zqcgKrZJW256Dto=;
	h=From:To:Cc:Subject:Date:From;
	b=X/ES7vaC9OHFMYSkUlVg3nMkI5R7qsjSBPHw1Gowtzs/r2O0oPp5KAx7IJ4ObFf2W
	 qoBJnuyi7u3xgZEcYh21xI+z78Wr3wjAq1TjLd0Vzbh8vfTl0cBI/fOrWqQN7nsT03
	 hLELD7Tore08gnzvkg3w1yCO08osDpbor76D7Obw=
X-Riseup-User-ID: 588FCB460FECE076FC6AEBDE18189834C2791BA045698E9E58899A3047397D27
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Wsvcb5tydzJsSD;
	Mon, 26 Aug 2024 15:25:03 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: linux-trace-kernel@vger.kernel.org
Cc: Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH v2] tracing/probes: fix traceprobe out-of-bounds argument allocation
Date: Mon, 26 Aug 2024 11:24:42 -0400
Message-ID: <20240826152454.1990-1-ffmancera@riseup.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When initializing trace_probes::nr_args, make sure the maximum number of
probe arguments is honored. Oherwise, we can hit a NULL pointer
dereferences in multiple situations like on traceprobe_set_print_fmt().

Link: https://bugzilla.redhat.com/2303876

Fixes: 035ba76014c0 ("tracing/probes: cleanup: Set trace_probe::nr_args at trace_probe_init")
Signed-off-by: Fernando Fernandez Mancera <ffmancera@riseup.net>
---
 kernel/trace/trace_probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 39877c80d6cb..8d3eb1bcdb9c 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2043,6 +2043,10 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 		goto error;
 	}
 
+	if (nargs > MAX_TRACE_ARGS) {
+		ret = -E2BIG;
+		goto error;
+	}
 	tp->nr_args = nargs;
 	/* Make sure pointers in args[] are NULL */
 	if (nargs)
-- 
2.46.0

