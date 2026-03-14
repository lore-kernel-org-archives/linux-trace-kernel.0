Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4614538D000;
	Sat, 14 Mar 2026 22:34:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773527684; cv=pass; b=ISoHt9illw/zBTVFRt8jkqNZ9NrmXUP8Qn3OcFY/uU74gu01Cj7C96Z4ISjepD7VRzuUbXrMbv4NVgdQOobDP23cBxj1ffMQlIicH/tfGku9CjZ2hWP4ecdfaUrfqeKSg0K0OM0AMphLWA6gGnTubflQLu0Grddrc9vMhqyIuZ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773527684; c=relaxed/simple;
	bh=Ca2yOMLol0eXm8Z93sdZF0uzxBHDnoJJ5YjTb0UjCSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jQwc0GNJzCGybA/NhzNUyfZ3Ndet57aLPLCokTYBF63zx0679ZijJaFxNUPz5eFIeSKo05QU4SVzzIl8psMcd74VsHFuLlfJKsQngyHfY91NazjAsllO+9KrzugJtoawniU+SR0PVa13wRa4OhUrWjjzHaP/tZXpd/E+f8XdgPM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=oMt7u4ci; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="oMt7u4ci"
ARC-Seal: i=1; a=rsa-sha256; t=1773527670; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=MUAqpTDbscu86PZTsoA/2VCNBNiQLgybBahUa7455L8augcaHgwh2iurZZ1rxj3pX3oY6sQZ6Dtrj5NwoKUe2UCVEa++JQ5kBFuKXm9OGEzVpVAM7MWlD6Pn0cVdKyq/GjDIM0Nvul8U12BfL/xIrkcsOlrP6LtYTABLhSNXUc0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773527670; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M861Pari/lV9kRCqOVfEViiGvsDrnuYG9MG+0z+YaXE=; 
	b=grJP2wUyC+Li5ZVOI0NdzWbQZptoQ6ROfqKc3QLLCWyWo3Gb0ik7NRd5/BDGrAjmUSouqs2ycDqlN2EYTVpqD/gvmETiAHjqDnsCoggpIa+g8gOCd5FmJ+WdfRRmwlHBhHnKbmNhNmJB4/CosRHZzAP9QC8qmvG82FSjrZdJtDY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773527670;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=M861Pari/lV9kRCqOVfEViiGvsDrnuYG9MG+0z+YaXE=;
	b=oMt7u4ciJBtgDZWcyk2dy1JttJeJoQ6KnCj4/z6WzuwsIm+iwVqouxg20lQnzD8D
	r8LvrUz/b3gcGgSjKcHOGUVO+9MAbNgzuvH5HOy26q4TWQyKo9qdcoFlxqGSoNyBZIe
	GXvSZ+ofyHtHzVnoKndj5MCKaKtU/TYM8J1WEcrI=
Received: by mx.zoho.eu with SMTPS id 1773527669077741.3149385166;
	Sat, 14 Mar 2026 23:34:29 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v3 05/17] lib/bootconfig: fix inconsistent if/else bracing
Date: Sat, 14 Mar 2026 22:34:13 +0000
Message-Id: <20260314223425.142966-6-objecting@objecting.org>
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

