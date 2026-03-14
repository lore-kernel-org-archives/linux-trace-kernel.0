Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336973909B1;
	Sat, 14 Mar 2026 23:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529337; cv=pass; b=RtRAoNfMeoqVeHZzloYPDoONYOP2qCMx2Cc0MGt8p4QunKGnMxcF45fOQW5Ptlk4XEdWfM07mei/y4FWuAYeD8s9PqXbX3jgd0Q4y5OKlB1wVeLHHVbIlP51PViZo8UGMqmA1W+5RdZ8zQ4R3THUGxjeJxIJ97rFFC/6YwVTJU4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529337; c=relaxed/simple;
	bh=V7ReOpjvgKpqLyMe87lV2El6zoCxd9xHdzcToswP9A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GV3KqOHEV/ZhHdoPpKJ4t9CnTGwzy+HZAbYozilG6bLihEnG9vjccfpLjn9IN9IxsAzc5OHkCTGEk+Y3HpuDKS13U7+vgJfQr/l1b5iQdtqgppzs9YvDYaHcRelT1evRcSyZX1yxX8LlG9vw0XSV7kJvouqa9ZvYOsgTlti3Gwg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=KczknU7D; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="KczknU7D"
ARC-Seal: i=1; a=rsa-sha256; t=1773529328; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MuoJpKfseca+d4EuijvxY9jtiXwHjlINhuaflPwRzV0LIrz2tLZ+irBgN50JwGehc3fkGPaQBVoz5BZgDwOUQqUh802TDreJ0gO0r0AQOBIA0MTOfoLLeA176OD83VHHvY1lEJHPnpZJkhsVUabwJEZEHeDTBJ9XbCukfd/Sa5A=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529328; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AWTtpdsy4qWl6puGZW7KMyBkMjPa87avwV40la3Leew=; 
	b=k0TfFEYeUnp+tWvOc8UjXyL5KLfruXAeJrOUwUDhhdn8QyAI1fTUpKAljq1vfGC3OPz/3fCuuPCBh/dVf7K1IL8zjmbIrh+VI6q1FssGXUDY2HOdoXZeQRJ5y5+XeRuja/6J7E5dq0P4BvkfoiOsJWqQl3CaG0M0THOW3BB1gmE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529328;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=AWTtpdsy4qWl6puGZW7KMyBkMjPa87avwV40la3Leew=;
	b=KczknU7DRzr+KG4Fzf2DmsV1+fFlGIy4odBWuijEx9sF9U1UUvZktqPgJkJzu/II
	3WkEOcqnNtzW9mygGNVja697lkKtEIcRJIzUMsGwu77fc/IghGyxMisPGaAhTGsnhPP
	l3alkJMVsD4j6JrcUdW9boBEIkj4B8kV2ueYNN9A=
Received: by mx.zoho.eu with SMTPS id 1773529326162947.6157472151848;
	Sun, 15 Mar 2026 00:02:06 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 16/17] lib/bootconfig: check xbc_init_node() return in override path
Date: Sat, 14 Mar 2026 23:01:54 +0000
Message-Id: <20260314230155.155777-17-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314230155.155777-1-objecting@objecting.org>
References: <20260314230155.155777-1-objecting@objecting.org>
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

