Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A50C35294F;
	Sun, 15 Mar 2026 12:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773577238; cv=pass; b=jZ7NyMFmo0qYyN5L3brgaRJZr5rFHl3MpUa+ZwQ8ZwkjrmxA9ma7iWWTDheT1GcW/9YE+8cgHqfir8S29f/ki/E5sH5FbMc99usB7dw0CeUbY7pjVgu8R/Looq3z3h5cd7b58nSaw6pZ1vsRoGzJTd7iYqAVej/Or1F66O7ibus=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773577238; c=relaxed/simple;
	bh=ZFHhcduH6BPu+n2EmpRHQ4MrmATKI3qjWWcYFT9yzww=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BpBDc4GtzW9DT3NQ2QEjqiJnC0CNQC3t7lHJwOAnPO7jv6SI541u7UFOXxAbNTcmZAzxtWnG4kPk5foOAzxeeUGCndaOoaw4ua+CFPrN9X+ZbkBmZFVljsjOOWlP4fXvXrVjYvyvfeI7CU16nUNtD/N3EIqsLMG+5/bvQVAYh+I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=nXvOphPI; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="nXvOphPI"
ARC-Seal: i=1; a=rsa-sha256; t=1773577226; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=eWCPNp9e1sccsJM7BPCsrzJLhEZSjNntsURoDuSrNyOR7SL+TrnhPnct+/vIIt4Mxba5m8o+FvyPwyDnzIHz7Ro4AbI6bW3Ig+1DQ8qZakCKEXaVIk5bIAQuhGXPrzMyfYd90DpjJSaf6mWYKgfMRVpkszxWz6ZRoPOzK5gd/UY=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773577226; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=8RKGFqygVzwj3nKGmrh8LIQUomaXoUXBIT1/jbFgSvo=; 
	b=chqbabCoLwVRVy/9/gKOHQ6hTLDcTPPcyPG3Qw+EIr9Om46lEBgGQbwuES7WewPBeAeDc3YatetG+GuPT3v1zJmTXF04ouHhQKcKVE8E+OGDXwKYqL0Q/knSBc0t6lKvpm1Ue+SwZXpZ7OJFyiecERRLOxD/diuCOiTLzG8bx7U=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773577226;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=8RKGFqygVzwj3nKGmrh8LIQUomaXoUXBIT1/jbFgSvo=;
	b=nXvOphPIDktM2/Rzo4xsMpFWZLcrfdEid4RMUmtiT6v6KMW9+Y/omh5idV2xUZhO
	GH2STpEZ+RuWxGVEGLYb8IZWF12lIYC+SM/roIdyUUHr/plZG2NLf7zqSUIOYwedirP
	wmUqtPhrBq2kCNF0bRTegJn4vjSA4UYK/SsbVZoE=
Received: by mx.zoho.eu with SMTPS id 1773577223085138.7012228454397;
	Sun, 15 Mar 2026 13:20:23 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v6 10/17] lib/bootconfig: check xbc_init_node() return in override path
Date: Sun, 15 Mar 2026 12:20:08 +0000
Message-Id: <20260315122015.55965-11-objecting@objecting.org>
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

The ':=' override path in xbc_parse_kv() calls xbc_init_node() to
re-initialize an existing value node but does not check the return
value.  If xbc_init_node() fails (data offset out of range), parsing
silently continues with stale node data.

Add the missing error check to match the xbc_add_node() call path
which already checks for failure.

In practice, a bootconfig using ':=' to override a value near the
32KB data limit could silently retain the old value, meaning a
security-relevant boot parameter override (e.g., a trace filter or
debug setting) would not take effect as intended.

Fixes: e5efaeb8a8f5 ("bootconfig: Support mixing a value and subkeys under a key")
Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 038f56689a48..182d9d9bc5a6 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -728,7 +728,8 @@ static int __init xbc_parse_kv(char **k, char *v, int op)
 		if (op == ':') {
 			unsigned short nidx = child->next;
 
-			xbc_init_node(child, v, XBC_VALUE);
+			if (xbc_init_node(child, v, XBC_VALUE) < 0)
+				return xbc_parse_error("Failed to override value", v);
 			child->next = nidx;	/* keep subkeys */
 			goto array;
 		}
-- 
2.34.1

