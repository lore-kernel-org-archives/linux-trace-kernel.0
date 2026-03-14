Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90C326E71F;
	Sat, 14 Mar 2026 23:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773529453; cv=pass; b=FLTB3FT6ltXEt5eEozeA3A01huWgMVkc94O4iauWG3eZ4cM2WHVh0JnIi5xRZQUK3rLJKZkb1enYDN8ASmpoPD+xtteFVoUNr5DtkKNEJTITv7LhXk41cIB1682yclaqHS6QdcOT5iHq5K52KIGVxt+ovpFeQqwj9PTqWImAhpg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773529453; c=relaxed/simple;
	bh=Ca2yOMLol0eXm8Z93sdZF0uzxBHDnoJJ5YjTb0UjCSg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=O05jbr7AntpHi/mxym0VefBzJNzBS+gE+ACAh6MqKj/Cu9Cb78MoDl9CksSw/rQ/Il6lnRnqkCaR6pOzZRWuem2BtX4JjkskRiTVKd6JdRCh1oTXkKrc2HuC3UXw8SPQh1t6gGbwiKid0N/j1wbcFt6DFXgE2jrvqDeLCAjEonc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=CBIeX0iA; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="CBIeX0iA"
ARC-Seal: i=1; a=rsa-sha256; t=1773529323; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=V9tiRcNmwthJXnqKnBKzJDBHwBmQIoQjjzjlvkPII1CE/EiZ0GqJXELzpKMgLB+eQ7jfmR8v19en3vzj3fNCr5Vom+qba5CIEyPnoEVVN1xsZqRdgo+dI2Q/yiyGSOY5m1qmAG5bo2kRZHZzMehxQ9uzaELaoClWtMiIgy1xqkk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773529323; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=M861Pari/lV9kRCqOVfEViiGvsDrnuYG9MG+0z+YaXE=; 
	b=fqhJ9tBVuqIaJbZlZzPbuEKjHtkR42ZMkEpedhNtahHaNEraPSs6H+qFQv0gLPqgrkUO2zlwb9SuwMAgRlSZALjteZEjk7HjlmGVfeWhqDKVuFILsCHuJ+6eL02/Rzo2XL7s/QHgkShnRUGjrwQX/SHj3NPzT3VDonT96F74ffE=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773529323;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=M861Pari/lV9kRCqOVfEViiGvsDrnuYG9MG+0z+YaXE=;
	b=CBIeX0iAc7yDmrWHYnjLO53xJ+ejhClrNb5LYYIV+oI+fhnRZLkVcLuWZmHR9j1B
	kJxsoRlwRFoTR0pLNVCk3FlijrUT7yYnoRKBtsu0NZSwrDLQdx5CyFzKforEJ2SFCa2
	7e4Ylld53ttwQv08me3Ptels/FzfF7VoOPPaYwYc=
Received: by mx.zoho.eu with SMTPS id 1773529320220765.7209768440242;
	Sun, 15 Mar 2026 00:02:00 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Josh Law <objecting@objecting.org>
Subject: [PATCH v4 05/17] lib/bootconfig: fix inconsistent if/else bracing
Date: Sat, 14 Mar 2026 23:01:43 +0000
Message-Id: <20260314230155.155777-6-objecting@objecting.org>
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

