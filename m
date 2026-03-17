Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63523305045;
	Tue, 17 Mar 2026 16:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763787; cv=pass; b=kRT463UglhYe6MKFCdsPZovqWPFnOOfGTpWNhfiNM7Gmp5CyWYBDlJCf+HP6AGF8maItOeXffUttVcf2nhln4o/DkIyvyoJ1g7WtGf8wEuP+HTrHN89Bns9HeavbzClF91dAO/VpXnAjmH4FMkTgM8WdpvgJbjpLMNf+8c5bJeE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763787; c=relaxed/simple;
	bh=/HTM1vkxBM9SoKrz6RIYt2QFZ7EuH4iZflenAbS4ZAo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=f8JGdDuvx7tVjICBpKx0oVtCBxvbxOj1U38V20MbWuHfw1iUggvBGmbP+yhSIVr1BeT3bn02DtqBL9SYQNQrCy6GbHnGrLt4QgtRu5uaMi9axSsmrtimAC9UP5Ge1yUjX1HihGFTpo40hQy8rZIGdmmyJf7z0Xf1ed42OzNehXQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=fmei6//r; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="fmei6//r"
ARC-Seal: i=1; a=rsa-sha256; t=1773763763; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=CPGG6f0pbDJfnuAUGsguUV8zjEzgZV9BIiZI7IFzIc0OXL/r95WjcAfjgWHULwTCkPK57fsDr+50KcyjoESwO/k3nxKwzK1BzMpnbPvBzxtgdNKHkru4fViyTFKI5K39dgODlG+cUTUhHZ8XM8K+4g87NHECR6Xeo8FMZbKuJn8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763763; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wQFyRPqlyhXtP7Cik8jB5wy9RJRVH73G8I3fT158msE=; 
	b=f7eOmkxhMZhSTJwICWfMWxXB9GBguSAc4CcSFi9ZmcrBzCWHZP/+xh354fYz4vilAUdcZRLPJZzjpz4CUujMB8n4Zly1BAngtUve2+pe2hyLix70IgH262Zmwfg9UcutXEMcTf5oSPWlkjPz4hjWVK/bsnuu5wLM1D3j7NWhlZE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763763;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=wQFyRPqlyhXtP7Cik8jB5wy9RJRVH73G8I3fT158msE=;
	b=fmei6//r6+802cKDMMILYo9vfPVfF1jQvjCP2XkFXDJGDjymAc95ANhdDUzHCe7m
	pxv5Fug8o7tKWJ4amrSN+sz/EDdX8A/NGL2yfsBOkbQ5PQy/Su54niZpjXuvZUa3uv3
	DdB9Zl9utBoxmdjIM8SVoMYmBYp2jjszOL5oeqTg=
Received: by mx.zoho.eu with SMTPS id 1773763762454516.8758136211599;
	Tue, 17 Mar 2026 17:09:22 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 09/15] lib/bootconfig: check xbc_init_node() return in override path
Date: Tue, 17 Mar 2026 16:09:10 +0000
Message-Id: <20260317160916.33576-10-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317160916.33576-1-objecting@objecting.org>
References: <20260317160916.33576-1-objecting@objecting.org>
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
value. If xbc_init_node() fails (data offset out of range), parsing
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
index 1adf592cc038..ecc4e8d93547 100644
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

