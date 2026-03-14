Received: from sender-of-o57.zoho.eu (sender-of-o57.zoho.eu [136.143.169.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3316E391501
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Mar 2026 23:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773531136; cv=pass; b=uw5NWRQG/l+0AgZK+eqBQ+etKKOjq8/x+Iw0NUKHyX5hiUC3zC9SstyBACpH+U7mVDq1L8N0e1qvR/mrYblEclA9IFR8NHPgveZ5sN/bcOSCULUfvYMfkHWp+LzV1ACmPepiJv8cNaLl+Y9Vj5gpV2YYaxr5m3J/X+effR8+pQw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773531136; c=relaxed/simple;
	bh=V7ReOpjvgKpqLyMe87lV2El6zoCxd9xHdzcToswP9A4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=tlNDbT9O/jkgHnSPtK4LFoOIHCV5oo1N0J2RitNuHJMlhSiKWMisOT1q38CH4V8oI0abbC+iE0wEZy44Z1d0oNdVPOpJCnoEhX+WLs2MPHx8Db4LxDU0HGOBgOemnyVA6uaNY988H3m0AHqhfvGjO3sRAQILhM4IdE3z6d3K/NM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=huSbb3xC; arc=pass smtp.client-ip=136.143.169.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="huSbb3xC"
ARC-Seal: i=1; a=rsa-sha256; t=1773531116; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=DQlJIBi8i6vj92RLNeegKLZnI3cEMEoZNPxR5GugGM0zEiiotKA/l3Uo9lnYlb+v71/Yq1bhCFV5wpiQol7QreFfj8spD75EQPAOxQF4ihsySE6TsipVK0LtGtTBhDE5QkuzI4Uq5dqFjxQDElmMn3k1K0yNQ6GFMbhDP81LpUg=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773531116; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=AWTtpdsy4qWl6puGZW7KMyBkMjPa87avwV40la3Leew=; 
	b=cd6qaPoymqJ87g62wiQFAdXAu88g1/3ESsWDVzgyEduCMw4c6Nx8UoY724B7LKOIS6nGMbILKG7pIVIRjLPy95S2do+0Jcfo9ymDgxeaOYuS3MP/22jvYGS5rurzs8Fsz1EOT3zcM6HONZmiP8XclKLKj6XntmI7MUGw6szeoFc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773531116;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=AWTtpdsy4qWl6puGZW7KMyBkMjPa87avwV40la3Leew=;
	b=huSbb3xCkXqGOojf01LrSJJ2XgRzxLEYQ08F9zyOqhsIlqfCJmML6xb9K2s6C+Nf
	ei6J74X5UMnjaFqwLY3edLlrLkHyjbjl4QFlC23/wxCBgp06GkkMf75MKTH3nHThpYJ
	QKwhKhk6OHWV9NLdeY/zc6OpSb1mL7b2Hlonw8mY=
Received: by mx.zoho.eu with SMTPS id 1773531113731902.1726274425757;
	Sun, 15 Mar 2026 00:31:53 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v5 16/23] lib/bootconfig: check xbc_init_node() return in override path
Date: Sat, 14 Mar 2026 23:31:37 +0000
Message-Id: <20260314233144.187273-17-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314233144.187273-1-objecting@objecting.org>
References: <20260314233144.187273-1-objecting@objecting.org>
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

