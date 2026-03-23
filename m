Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 097EA38C42B;
	Mon, 23 Mar 2026 10:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774262424; cv=none; b=Z64fkQWAfbsXt83lcXv7dRDcVar3uOwEqN2p5Q2QKDeaAyqgcs5G+ksqrva3z0rqfb7sEHBEoyxHa6+PE9S0xDADOc/uYhQFjBi8VmVzR35UXs5TYsUA5UYdgV4cLDflZKKDHbCdDDcUjt28Gcp8AEeWg6IS4geQTwTm02qzLNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774262424; c=relaxed/simple;
	bh=1hCCkmQUs0bLrA/OH4MBJ4sc2NkuG0D52C4RqPnGYSI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+gZTXtOFPNVobH5G9iULe/0ejxJ+rYQyIAI8R/VzFQcxXXsDja6CjwYYTEE1Ls/a0ZbutUtDHhoIUFzhFn92+Vn+Hz43FzY2JlX5Fwy6U950jb5IqTMITBTXKq54hoBgjkplrbIpWFyeLaF8VIcFiQ/AdJAYBU7TiyytBFn8f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1w4cOk-00000001Wr7-16Ro;
	Mon, 23 Mar 2026 11:20:38 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>,
	stable@vger.kernel.org
Subject: [PATCH] tracing: fprobe: fix the length of unused fgraph_data
Date: Mon, 23 Mar 2026 11:19:36 +0100
Message-ID: <20260323102020.239567-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fprobe_entry does not fill the allocated fgraph_data completely, the
unused part is zeroed with memset.

Fix the length for this memset call. Both reserved_words and used are in
units of return stack words, but memset needs the number of bytes.

Cc: stable@vger.kernel.org
Fixes: 4346ba160409 ("fprobe: Rewrite fprobe on function-graph tracer")
Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
 kernel/trace/fprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index dcadf1d23b8a..6a1192515afd 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -451,7 +451,7 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 		}
 	}
 	if (used < reserved_words)
-		memset(fgraph_data + used, 0, reserved_words - used);
+		memset(fgraph_data + used, 0, (reserved_words - used) * sizeof(long));
 
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
-- 
2.43.7

