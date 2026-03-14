Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFCA38643A;
	Sat, 14 Mar 2026 21:46:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773524777; cv=pass; b=lNLk3GaO5JLX+zywKAigFXuQAuTZcMwEhOnW4+zi3g1hGBN65sAB8v3OdMR09Zz82GWcbLfse/HN4gm41LyrFQWwkEa/HCXnOhV4vffWDQ5De3nsr949iK5fwZHo/apbMc/6EsJN4x8xbdjPXg1r5W0Whnf/xTjJiGPbFIZ6QXc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773524777; c=relaxed/simple;
	bh=Ca2yOMLol0eXm8Z93sdZF0uzxBHDnoJJ5YjTb0UjCSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dbaUUsTRAOLUnwGj1kIjKaXuBtNyVs9XtyqAgxAQ0RaT8WWkObvZHoBIf98qFiTtD6/Hpv0y//6rFRjv9TzZbVcJaSXINt9jB+39uLh+6G0XBxGkXJgAKpVtGXQwb5F5TiK6fIRwApEdjD4xJJHdh5U3q63tez5EJiV73ac1Nag=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=b1TI2XIj; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="b1TI2XIj"
ARC-Seal: i=1; a=rsa-sha256; t=1773524764; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=cf6gVdB3L+eTalFWfxmj6LtzWBvFYKErzQbztnblVxbdTbE0a/ex80qs8EB9zGJvS9FEw7sc4x7TeFW5NYH0Ijjuj8FlqH1cUFNS6JWKE3VuTpwhq4mBCpGa1GzVG106oPULzUsfEdbdmK6bEqyPd5N++/7JcYLPp/Em6gU1H/U=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773524764; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M861Pari/lV9kRCqOVfEViiGvsDrnuYG9MG+0z+YaXE=; 
	b=kB4d19ZRdZSNfYDfeIPGjX6vS07G7rvD7M2/xU3CTzuhmSC4i+jWAWqIRLbpCN/LkA/gPHnOSTYSFbeP/pMbuuXgy8ReQxURPXLJkfpBj4MtOCPDgAZ8Ns9VUXImQjjTjCjnPa+o2cJaaeoIztMmvGLhGk6thmIGrYG7YqetyN4=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773524764;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=M861Pari/lV9kRCqOVfEViiGvsDrnuYG9MG+0z+YaXE=;
	b=b1TI2XIjAwe3PuvuR2JCmGjHdP92SPthuY1f2cuyhfz/ftPnwgcqqSW12Y7UCnNE
	p15/N3Zx/Q0uB6yJh9PGPjRuJCeGBh5q433IieH9g3+Qz6LkQ5FFhQBtRD9KS6al6hV
	ANFDwGwmhmi5hR79WjKyNSfd+cfSLmHQeiYL+5HA=
Received: by mx.zoho.eu with SMTPS id 177352476103285.71315154004913;
	Sat, 14 Mar 2026 22:46:01 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH 05/15] lib/bootconfig: fix inconsistent if/else bracing
Date: Sat, 14 Mar 2026 21:45:45 +0000
Message-Id: <20260314214555.96217-6-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260314214555.96217-1-objecting@objecting.org>
References: <20260314214555.96217-1-objecting@objecting.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

When one branch of a conditional uses braces, both branches should
use them per kernel coding style.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index e955d2f7e7ca..45db51bc9cc7 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -473,8 +473,9 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, boo
 				sib->next = xbc_node_index(node);
 			}
 		}
-	} else
+	} else {
 		xbc_parse_error("Too many nodes", data);
+	}
 
 	return node;
 }
@@ -992,8 +993,9 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 		if (emsg)
 			*emsg = xbc_err_msg;
 		_xbc_exit(true);
-	} else
+	} else {
 		ret = xbc_node_num;
+	}
 
 	return ret;
 }
-- 
2.34.1

