Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F5336493B;
	Tue, 24 Mar 2026 08:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774342119; cv=none; b=hVmdUvAG2fFg3pp76pziRWWnC8JT/coe1XdP3tKHCN5gK+ddVymX3ZOifn8/eUqidH6AYfo035rSuonwfoiFc7EhTZVmiXW12NlAcNB5+A7RTyJ+HtZxU4p89YzruHBckCykvbxi2SqgpLj4Y5RU7zaojfNCeUkaYmlhRmIQ1EQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774342119; c=relaxed/simple;
	bh=wiA3mBNHbtEvp/w1k1i0uwYum5jXhdIm8EzbSFtZ6k4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nEQExx7afXsoh7zAmr7U41j0WL2TbA8lELOGf9ifd+kUAeZHBvZ1m94tqPzDRYesJ/LTYlG0suCiDXsOU4BAhFRJOfnRnk4Q7OIvvK+nUTFCdTqgjyNDJCKi6LLHn0q61YPvVsWAD/5bozaVgPd/DVUqiJx9NcnA+CPJJk55beg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from ipservice-092-208-105-007.092.208.pools.vodafone-ip.de ([92.208.105.7] helo=nb282.user.codasip.com)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <martin@kaiser.cx>)
	id 1w4xR8-00000001fIK-0oit;
	Tue, 24 Mar 2026 09:48:30 +0100
From: Martin Kaiser <martin@kaiser.cx>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Martin Kaiser <martin@kaiser.cx>
Subject: [PATCH v2] tracing: fprobe: do not zero out unused fgraph_data
Date: Tue, 24 Mar 2026 09:47:08 +0100
Message-ID: <20260324084804.375764-1-martin@kaiser.cx>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260323102020.239567-1-martin@kaiser.cx>
References: <20260323102020.239567-1-martin@kaiser.cx>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If fprobe_entry does not fill the allocated fgraph_data completely, the
unused part does not have to be zeroed.

fgraph_data is a short-lived part of the shadow stack. The preceding
length field allows locating the end regardless of the content.

Signed-off-by: Martin Kaiser <martin@kaiser.cx>
---
v2:
 - remove the memset instead of fixing the length

 kernel/trace/fprobe.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
index dcadf1d23b8a..56d145017902 100644
--- a/kernel/trace/fprobe.c
+++ b/kernel/trace/fprobe.c
@@ -450,8 +450,6 @@ static int fprobe_fgraph_entry(struct ftrace_graph_ent *trace, struct fgraph_ops
 				used += FPROBE_HEADER_SIZE_IN_LONG + size_words;
 		}
 	}
-	if (used < reserved_words)
-		memset(fgraph_data + used, 0, reserved_words - used);
 
 	/* If any exit_handler is set, data must be used. */
 	return used != 0;
-- 
2.43.7

