Received: from mx1.riseup.net (mx1.riseup.net [198.252.153.129])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6E0F18C3D
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.252.153.129
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723570337; cv=none; b=uEv6BMxLbLlL0B/fNRGkg84iynM5BGp75ZbO+FMdbO1IVgNCXaEyyMQh+PYHXuG4c2Ai/cdyjod+lfbUuJG4LK+dmpag2+rg86AWT7bEGbZR6t/01Rbr80DohRqM18SwGViLX18I8gjDEj71k6nrJPc0pMxmDcJblpEnmDcuQ28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723570337; c=relaxed/simple;
	bh=MFY6nmbqVO7INKEWRg3Pom2nFk7JxWqprC2CP+yx9Rk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=V5O/9q+qyAKK1/il1C7co5Me/0vlTdHQDjWWt58gOeftjv2NbUgx3bGtx5e1vW3wUBnKRk3KrWWLZy64UNvN9kfPE6uWpPMAoFdgoUXqI50COhH0X3+UNjxgACE1qwuBZ7pPC+BQfpMoGaRBCmhYsOAf01FisWSX02X+5wMDflA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net; spf=pass smtp.mailfrom=riseup.net; dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b=miYuT0nz; arc=none smtp.client-ip=198.252.153.129
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=riseup.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=riseup.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=riseup.net header.i=@riseup.net header.b="miYuT0nz"
Received: from fews01-sea.riseup.net (fews01-sea-pn.riseup.net [10.0.1.109])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx1.riseup.net (Postfix) with ESMTPS id 4WjywH35J0zDqGC
	for <linux-trace-kernel@vger.kernel.org>; Tue, 13 Aug 2024 17:26:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=riseup.net; s=squak;
	t=1723569967; bh=MFY6nmbqVO7INKEWRg3Pom2nFk7JxWqprC2CP+yx9Rk=;
	h=From:To:Cc:Subject:Date:From;
	b=miYuT0nz12cIVDJKgeKW3A4iaHPNqN5Ls0RxkBqwqYyLgeucArcqjdtyKuaBUM4vp
	 sqnY3lx4VsTtv1d6mw8Jl+My+3okEvlrEWj2ZsQKqv8FiM2N0iExMADHyxTIjTAfhQ
	 C6UdPCIOrRhwl7EOZsDP1Wrbe8jLooBZFIuZBsgk=
X-Riseup-User-ID: F947E7C332F60DE0E6AD6D017BE9E11ABA6D53CCCCF6CE1BA11CECA23CB77357
Received: from [127.0.0.1] (localhost [127.0.0.1])
	 by fews01-sea.riseup.net (Postfix) with ESMTPSA id 4Wjyw30bWkzJqT7;
	Tue, 13 Aug 2024 17:25:54 +0000 (UTC)
From: Fernando Fernandez Mancera <ffmancera@riseup.net>
To: linux-trace-kernel@vger.kernel.org
Cc: Fernando Fernandez Mancera <ffmancera@riseup.net>
Subject: [PATCH] tracing/probes: fix traceprobe out-of-bounds argument allocation
Date: Tue, 13 Aug 2024 13:25:40 -0400
Message-ID: <20240813172546.3151-1-ffmancera@riseup.net>
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
 kernel/trace/trace_probe.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 39877c80d6cb..f577b5e71026 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -2043,10 +2043,14 @@ int trace_probe_init(struct trace_probe *tp, const char *event,
 		goto error;
 	}
 
-	tp->nr_args = nargs;
+	if (nargs > MAX_TRACE_ARGS)
+		tp->nr_args = MAX_TRACE_ARGS;
+	else
+		tp->nr_args = nargs;
+
 	/* Make sure pointers in args[] are NULL */
 	if (nargs)
-		memset(tp->args, 0, sizeof(tp->args[0]) * nargs);
+		memset(tp->args, 0, sizeof(tp->args[0]) * tp->nr_args);
 
 	return 0;
 
-- 
2.46.0

