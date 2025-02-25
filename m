Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7DC266EE6;
	Tue, 25 Feb 2025 09:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474069; cv=none; b=p4leIm5AzS1Da3afHxiqjp7e60EUqSFagRFL6p4DNBHCwk3aJGVFDBgQ0fU2emZv5uFZHxXOOoLNkgLqNGNQeCKARU464ZUJUDSkFn3bdpVjb4B4A9jD/8k+7/fbc1HuzXxsDNYcLv0B0r6aWHy/9FoKVyRxYjhX0r4AjfzYz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474069; c=relaxed/simple;
	bh=MXujraY/qrz9VsF63mgg+FLRt5PFyb1aIn1fpHd9zp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MpbwILTjxYqwmxCAGGcBvo87kWJ/FF6y+UWVbCt2kZ18hs4t2o0XYzIJiwrBuzq7stmTvGywCwTNiKZVfMATXzhA0VqJuA58R3rJ4N0mOvZsrMIGhE2zgeobe4naOuFCsBZVHF+8lIlx6J29uwC7PUaX9YOESlr95kbkuG/RTEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tz6difrt; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tz6difrt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14039C4CEDD;
	Tue, 25 Feb 2025 09:01:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740474068;
	bh=MXujraY/qrz9VsF63mgg+FLRt5PFyb1aIn1fpHd9zp4=;
	h=From:To:Cc:Subject:Date:From;
	b=tz6difrtmoVLNuzU8LBLkTGQpKbgn4SFARw8Y69kUam+kCNPoYh0sZ3dLH1JTZ9PG
	 JTf1AeIB3l5jBZDxgVftM8C412f27jf7/5XLlICkmi1Kmzr9kF8iJngZVsw/e2kFRL
	 IIs8dEJeco+xkRfDTZmmGe3gci8LUaN408f1yENvqA1ppubIAsv5LAMVWTl8wCjGa/
	 6wjS8SvGPFYf2ni8QxV35EodNsaoOyi5K9o9RAvWBE0nXAmbro3yChuEGW4cPtRDMW
	 r5H3P4T/ccu6dinBys2uXWrmSJFsgqMpTxN35wBZqxAo7qZ+tx7oqs3Op5qfXRSffI
	 59kguWkeUZ3wA==
From: Arnd Bergmann <arnd@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Joel Granados <joel.granados@kernel.org>,
	Randy Dunlap <rdunlap@infradead.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ftrace: don't call kaslr_offset()
Date: Tue, 25 Feb 2025 10:00:58 +0100
Message-Id: <20250225090104.554966-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The kaslr_offset() function is only defined on architectures
that implement CONFIG_RANDOMIZE_BASE, which leads to a
build failure on 32-bit arm and likely others.

Hide the function call behind an #ifdef.

Fixes: ef378c3b8233 ("scripts/sorttable: Zero out weak functions in mcount_loc table")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
There is probably a nicer way to do this, this version was the
minimum fix I found to unbreak the build.
---
 kernel/trace/ftrace.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index ac55b97aa540..f41245716e0b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7018,7 +7018,7 @@ static int ftrace_process_locs(struct module *mod,
 	unsigned long count;
 	unsigned long *p;
 	unsigned long addr;
-	unsigned long kaslr;
+	unsigned long kaslr = 0;
 	unsigned long flags = 0; /* Shut up gcc */
 	unsigned long pages;
 	int ret = -ENOMEM;
@@ -7070,8 +7070,10 @@ static int ftrace_process_locs(struct module *mod,
 		ftrace_pages->next = start_pg;
 	}
 
+#ifdef CONFIG_RANDOMIZE_BASE
 	/* For zeroed locations that were shifted for core kernel */
 	kaslr = !mod ? kaslr_offset() : 0;
+#endif
 
 	p = start;
 	pg = start_pg;
-- 
2.39.5

