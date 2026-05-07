Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44CF933D4F8;
	Thu,  7 May 2026 08:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778141477; cv=none; b=RFRlgyOesJruxOfeVE7lo1boBiMid9FsEmCcQRc2+ibnXAKuhRzenmu7/aWPDCAhJSYmgV3HdzRdErMMaNXB8oMdzDNvYt9CETRAy4swXAGFpwrIiNuPCO7kyrA227c2MJ3ENL8bCZN/kKAllT47sgFjqWBMkuuqMxuNPGyo9xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778141477; c=relaxed/simple;
	bh=ns1VzcUvCuCNyjJOObVqqjpzOPsnMmDlHqihr7MJALA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h8318j5cuEGkvergoKN0KMbaPyfsDwltpz4VwPKRVy1OwGUYDftsvuQmdqU5I6BSVPubO8EKxGrFdtRz7JAHILhmb16m+PXAhP2XH8751oTNJXCPNAHXrbmM9ACct7YVtV9TMh+mKYa4pZA7FzOVueWeV3Xz4y5G4i1V5D1jUUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1wKtpA-00000000bpd-0X4r;
	Thu, 07 May 2026 10:11:12 +0200
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH 4/4] tracing: trace_fprobe: fix typo in function name
Date: Thu,  7 May 2026 10:09:09 +0200
Message-ID: <20260507081041.885781-5-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260507081041.885781-1-martin@kaiser.cx>
References: <20260507081041.885781-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function name should be __register_tracepoint_fprobe.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 kernel/trace/trace_fprobe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_fprobe.c b/kernel/trace/trace_fprobe.c
index 9f5f08c0e7c2..4d1abbf66229 100644
--- a/kernel/trace/trace_fprobe.c
+++ b/kernel/trace/trace_fprobe.c
@@ -764,7 +764,7 @@ static int unregister_fprobe_event(struct trace_fprobe *tf)
 	return trace_probe_unregister_event_call(&tf->tp);
 }
 
-static int __regsiter_tracepoint_fprobe(struct trace_fprobe *tf)
+static int __register_tracepoint_fprobe(struct trace_fprobe *tf)
 {
 	struct tracepoint_user *tuser __free(tuser_put) = NULL;
 	struct module *mod __free(module_put) = NULL;
@@ -836,7 +836,7 @@ static int __register_trace_fprobe(struct trace_fprobe *tf)
 	tf->fp.flags &= ~FPROBE_FL_DISABLED;
 
 	if (trace_fprobe_is_tracepoint(tf))
-		return __regsiter_tracepoint_fprobe(tf);
+		return __register_tracepoint_fprobe(tf);
 
 	/* TODO: handle filter, nofilter or symbol list */
 	return register_fprobe(&tf->fp, tf->symbol, NULL);
-- 
2.43.7

