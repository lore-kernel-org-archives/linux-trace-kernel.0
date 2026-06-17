Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4796538A70A;
	Wed, 17 Jun 2026 10:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.40.203.114
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781693914; cv=none; b=uslkCrqFev6N8Td+LQeK7qKKyhetoEAvDVIyrwv7EkuXb3o0bl6vFmgednRJ4qoVbCh5qPZlAU5J01R1NveGfu46TNNqmvvOKusNcZf5cTnK7s9GazPiO4DxdU/EIHMrJTcQQATIZaL32Mq47w3TOG9Co7QJIf/AriXuF4oI3D0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781693914; c=relaxed/simple;
	bh=+ch+e0r2RaLQrFTKjSmAz9PlhqWPWvAFjCPO4w8fWVo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bycXnYtwzj5romWxjUQiLTUtWFFRv2vzKXTVbNLHj0CiNs4DkOD7eQoEt1cQFSwvr7DQR3z0cg8sDWZpqWmkwlIHlB7+AylY/KQ9ZNOJ7cpg4hqGaJv56Ks1Gg0H1axGompOctxRHl7UZGXNPXx/Eg+S3DETggg/S8KpTeTWeqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk; spf=pass smtp.mailfrom=codethink.com; dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b=n0nKv5QW; arc=none smtp.client-ip=188.40.203.114
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=codethink.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codethink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codethink.co.uk header.i=@codethink.co.uk header.b="n0nKv5QW"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codethink.co.uk; s=imap4-20230908; h=Sender:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:In-Reply-To:
	References; bh=NagXp31gSoq9/pIKhS/bMoRqIkuD1Ir/xbKECEVuEtA=; b=n0nKv5QWkxQ5pN
	BBh8POOgD/wfNXxR2uG91plkHsA5yTbYm8VqCHLPcPlZ1ypJVoTZkYaiL1YK43/BjffNd9TQIocNy
	DRBmGztK0+kr4D0hQUuy0ifCCsu6EbY5uaAZES2IIUk78Q5Pv2ceaG7sTxVy8HWf0Hh6o1+KzTI2h
	aVuZkfbnENU46BJhMaKLz15nBiREw9OYQp3euaCq+vx7mBxygHJaWBU9Z04/mBzHhIUhk0x/Umi2O
	bM+upgc1DyzUEB6B9z00DvuxY4DFilD5vv057r1J0t2iGRLa7jcdwgZtGArdqdASPsgwQYwYfkXOD
	SZICEOwYZ4IRqUKbXB+w==;
Received: from [167.98.27.226] (helo=rainbowdash)
	by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
	id 1wZnyS-008Uwe-CD; Wed, 17 Jun 2026 11:58:24 +0100
Received: from ben by rainbowdash with local (Exim 4.99.4)
	(envelope-from <ben@rainbowdash>)
	id 1wZnyS-00000003nDz-0Qc2;
	Wed, 17 Jun 2026 11:58:24 +0100
From: Ben Dooks <ben.dooks@codethink.co.uk>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: Ben Dooks <ben.dooks@codethink.co.uk>
Subject: [PATCH] tracing: make tracepoint_printk static as not exported
Date: Wed, 17 Jun 2026 11:58:22 +0100
Message-Id: <20260617105822.904164-1-ben.dooks@codethink.co.uk>
X-Mailer: git-send-email 2.37.2.352.g3c44437643
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: srv_ts003@codethink.com

The tracepoint_printk symbol is not exported, so make it
static to remove the following sparse warning:

kernel/trace/trace.c:90:5: warning: symbol 'tracepoint_printk' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6eb4d3097a4d..4c3729c8d5e2 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -87,7 +87,7 @@ void __init disable_tracing_selftest(const char *reason)
 
 /* Pipe tracepoints to printk */
 static struct trace_iterator *tracepoint_print_iter;
-int tracepoint_printk;
+static int tracepoint_printk;
 static bool tracepoint_printk_stop_on_boot __initdata;
 static bool traceoff_after_boot __initdata;
 static DEFINE_STATIC_KEY_FALSE(tracepoint_printk_key);
-- 
2.37.2.352.g3c44437643

