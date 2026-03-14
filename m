Received: from sender-of-o59.zoho.eu (sender-of-o59.zoho.eu [136.143.169.59])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF88138F643;
	Sat, 14 Mar 2026 22:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.59
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527685; cv=pass; b=MBFs/PcqDWnGY+QkZf3WTCCzw4B1u8YJhud1T0IFInW5FNmy1wiQzKcxO1dMZVXTLACKksMNc4GPWfigqSL3NMA/MILFskpUBlz7yL6tbPfCGY7mfUCFPgRonB8nHXea39FbvjOFCgHjskic8E/OzNhSr7AyZ3h53ql2ILAO61c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527685; c=relaxed/simple;
	bh=6vJJkObBhfsNyQS+M22eHRqf8Wr8/6ywp4gTDNMOTqQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kgmG087sGvNobzfBU2VFW970D4eQUVUfQW4zJwtXgq1CU+k6tY3aQPRQwMNZNWgWz9Y8jkncNeAEHzNJvIz71tlUQYY/3dQfg9NDDyma7lqURGnh4dxgFXmhOQIzC3zXLOPoxpzhVDYT8NJ33OME+1rXlE7r57GpNlOw1HoOlP4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=S+db/pPc; arc=pass smtp.client-ip=136.143.169.59
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="S+db/pPc"
ARC-Seal: i=1; a=rsa-sha256; t=1773527676; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=YATn7pr6TON6I8uD7K1ikbkMNTtIW1E6mZ3rwnSYg1w0R4iHUUnYdIurJVvr0zhyz1rHqd0pBIKsSBvDiPbGqklYLbk/U4h1YZEfPMSFRzeCIbSSQp6hqi9p3GdlDPLkhJ7IfuS6GJ3gx+TBsS1zOAF5osPNV/8DXAwnRqOceLs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527676; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=wuwpjgw+yCW4f5PVQmIgF59vQTrbva8ITO8a3v7fL6w=; 
	b=Djal/24cSUXKjViau62ijXBuZb1j6Rhg0PWQkC0k6Bw1q2DXa8p9dwCoQTyyQ5i9dKE7saq+qwJRcvA+N+qBURNRXkKnhu7/Ewo7JTY0wXM0eFHVuiIKomPKr5hGssGjS+CXaZYjRuFtiIw9sLcYXZgR9c+Swl1XoCHNE3lLy8Y=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527676;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=wuwpjgw+yCW4f5PVQmIgF59vQTrbva8ITO8a3v7fL6w=;
	b=S+db/pPcdSR6v0aKuphZ39HKTYT+PL4Zh/WTWB9er8R1FGvJVH1V4OjNWly8Aa9r
	OrSl4Esy06HZ3AzJbL8M/1QmNU9JQ8c5TZN8JcNCxf+TF2uGQPuflPNNBaJ0VIrXPh0
	cIiA6lTcFTjAidIN+bLRM0nf/J91wrG5e9KtQFio=
Received: by mx.zoho.eu with SMTPS id 1773527674987635.4224193154647;
	Sat, 14 Mar 2026 23:34:34 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 16/17] lib/bootconfig: check xbc_init_node() return in override path
Date: Sat, 14 Mar 2026 22:34:24 +0000
Message-Id: <20260314223425.142966-17-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314223425.142966-1-objecting@objecting.org>
References: <20260314223425.142966-1-objecting@objecting.org>
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

