Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EF3434FF59;
	Sun, 15 Mar 2026 12:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577234; cv=pass; b=rSicpuKNlY75JrTQeU0CzAcbenpvBt90VcC9PqC9IL4ZqkktNjyiIhsD5ANsyGUnUNSuPxnVI1vadrIuE0vulsgeTFMKvmClhkJFcAIa+3KrbNrEN5XpTNBvAYt+OWP4hFjuZiC6BN3pGAZFyyXtRqO/4YqU6rGxPKNhPuxW36I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577234; c=relaxed/simple;
	bh=EWCRpZBNHCZU8iztguL/vt47WImiwDpV31hec4mL7Lw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F/AqemLVXcCMW2MERFb6rMV5y57/9anQtreRkZcxK4rIgPpXskwDe5fzDjJ3KarOHz+AW8UM22im4qNeh2ugWiiIJQIBJnoBWp71wKCBN7rBqY12KAmFvnajjLlTiZJyMPl4uct7E0azuw0OqhjYFxsZvBmWhUqSe98q9IYzkj8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fRFH3YZj; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fRFH3YZj"
ARC-Seal: i=1; a=rsa-sha256; t=1773577224; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=UqS8DO54HyUvGycrHc12thIIVl2mjaOmKUtLVsXj307dYwk6fJMhVoCbkYFWpBPISm6SPuMPhIyh1tMRCZ5bItSYeOBMveqTN52WkCZ/9mSB6d/jOylX3sdni6F1BZQNEfeZ5wEW2TIEYVqEDKvWh8VfjZUZIWe06GrLrM43qyM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577224; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=; 
	b=ksCHEOWFZr0+QqMugMvuq532ivzKH54VWKdxHHfCsG+3kGmXATLI1M6cAo1CtV/PDAZb8S3MN8p2wi0SGpH6AP8l++fh4OCXp+l37uvyeseq1ZJTcZpkRlqb4AdMQiozmwdYRHd/nufhpVnUjXGD9q2nAY+pCnCI2wnVO+MpEfs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577224;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=Y3g/gWcuZygcqvX4QpGo9gnBChjnwRu7NCitJ/yvsXM=;
	b=fRFH3YZjR5eIU5bQk2H+R6lGA8/Cb6fHTmou5oEJrErjqDAXi7NtzRHg2WQSaRSq
	DdE22FDeQ03QqialWmgCpfgJXSXHtC1E/zplzrvCK6W1rvjGPaXqENEzFUIydFyYYVW
	GFIBUtXV7L/+UVa4CrteQfzXQN3bA2jZoq5jzSWo=
Received: by mx.zoho.eu with SMTPS id 1773577220817555.7823977868879;
	Sun, 15 Mar 2026 13:20:20 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 06/17] lib/bootconfig: drop redundant memset of xbc_nodes
Date: Sun, 15 Mar 2026 12:20:04 +0000
Message-Id: <20260315122015.55965-7-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260315122015.55965-1-objecting@objecting.org>
References: <20260315122015.55965-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

memblock_alloc() already returns zeroed memory, so the explicit memset
in xbc_init() is redundant. Switch the userspace xbc_alloc_mem() from
malloc() to calloc() so both paths return zeroed memory, and remove
the separate memset call.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 06e8a79ab472..fe1053043752 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -71,7 +71,7 @@ static inline void __init xbc_free_mem(void *addr, size_t size, bool early)
 
 static inline void *xbc_alloc_mem(size_t size)
 {
-	return malloc(size);
+	return calloc(1, size);
 }
 
 static inline void xbc_free_mem(void *addr, size_t size, bool early)
@@ -982,7 +982,6 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		_xbc_exit(true);
 		return -ENOMEM;
 	}
-	memset(xbc_nodes, 0, sizeof(struct xbc_node) * XBC_NODE_MAX);
 
 	ret = xbc_parse_tree();
 	if (!ret)
-- 
2.34.1

