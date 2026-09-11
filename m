Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2173835950;
	Fri, 11 Sep 2026 14:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789136009; cv=none; b=WOIwqwiPp14rjDLbEUDxGQiFThjFp6vAs64Ckud64u3f4MIl/JKbt3uivh7BuacppQOlFl6rwjvTFY/J0p5G3esnIcosPo15YbOxkXEyEFQ6FUx8UrFTjUkzYi5iLHNxoHUruj0vJn1/jD5ddcFkJGYHvbD+ue7y2wJgiTXoTnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789136009; c=relaxed/simple;
	bh=gaQ5Xs18z39QaJwI9yW27cWzRZ5tq/OyB+9wrAfaws0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HbN1AGUdL6JqcNKZTqJ/aoRCrkia8SxF+1touUr2VFLQfiZupOjoXoaFRMbWzEWOPvNF5L0jfwiSmE4O5bK/yV59K8K8yRDls0U/lPEDTY6TVhtWSFngZuw/ngPntj1Y0t5wm0ZQmi3JdbYwTuzq9/JhUz3gwaLv/BVg5jtYLhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eqkP9GEr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eqkP9GEr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DB8F1F008A2;
	Fri, 11 Sep 2026 14:13:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789136007;
	bh=/HV0MLuSBgaL1qmMEBUkUTq3L2F/ZFCkWyKIdA3nReA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eqkP9GEruSBlvtmbGkL7qPBurTs91QbfUWPdGC97TW+KsJHXT62weW0bZIxFx94lK
	 Cahw1Zz/P4CKmuVODHRG4EIeGzfYwr/rko5YGPIlKVXKmObVL2FaiPr25fDkgtQvyL
	 Et63Edj5jqQ4EW1lDjLtZpDihUDjybEvxrbBKxxfMh0Vf2Er3AOjG+7SX1i639pDRI
	 QVzHHgSKqausbQNOP8eT4twx3UHwhsVEFGqVP2UHmyPq3jykUtphmVRejT3wRqiVqd
	 IVP+xsjQE3ZoAb5qTYUUp/bH5UNgv6NbLoTo7C/yVhbFMsmUoEDD/0MdZL9yLXVT9d
	 FgAw0SKrfQLWw==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Sang-Heon Jeon <ekffu200098@gmail.com>
Subject: [PATCH v2 3/4] bootconfig: Skip internal tree sanity checks in kernel
Date: Fri, 11 Sep 2026 23:13:24 +0900
Message-ID: <178913600409.248794.12941798680046327623.stgit@devnote2>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <178913597653.248794.1237187523153227751.stgit@devnote2>
References: <178913597653.248794.1237187523153227751.stgit@devnote2>
User-Agent: StGit/0.19
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

In xbc_verify_tree(), the loop iterating through all nodes to check that
xbc_nodes[i].next < xbc_node_num and xbc_nodes[i].child < xbc_node_num
is a defensive sanity check against implementation regressions (such
an out-of-bounds index cannot be produced by malformed input).

Running this check in the kernel adds unnecessary boot-time overhead.
Split this check out into xbc_sanity_check_tree() for userspace, so
that it continues to run during userspace bootconfig validation (e.g.
when applying or testing bootconfig with tools/bootconfig), but is
omitted in the kernel to speed up initialization.

Reported-by: Sang-Heon Jeon <ekffu200098@gmail.com>
Closes: https://lore.kernel.org/all/20260905141637.1547429-1-ekffu200098@gmail.com/
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Reviewed-by: Sang-Heon Jeon <ekffu200098@gmail.com>
---
 lib/bootconfig.c |   38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 61cae6d6e3f8..20b3d6e78fea 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -1003,9 +1003,30 @@ static int __init xbc_close_brace(char **k, char *n)
 	return __xbc_close_brace(n - 1);
 }
 
+#ifndef __KERNEL__
+/* Sanity check for regression: node indices must be within bounds */
+static int __init xbc_sanity_check_tree(void)
+{
+	int i;
+
+	for (i = 0; i < xbc_node_num; i++) {
+		if (xbc_nodes[i].next >= xbc_node_num) {
+			return xbc_parse_error("No closing brace",
+				xbc_node_get_data(xbc_nodes + i));
+		}
+		if (xbc_nodes[i].child >= xbc_node_num) {
+			return xbc_parse_error("Broken child node",
+				xbc_node_get_data(xbc_nodes + i));
+		}
+	}
+
+	return 0;
+}
+#endif
+
 static int __init xbc_verify_tree(void)
 {
-	int i, depth;
+	int depth;
 	size_t len, wlen;
 	struct xbc_node *n, *m;
 
@@ -1022,17 +1043,6 @@ static int __init xbc_verify_tree(void)
 		return -ENOENT;
 	}
 
-	for (i = 0; i < xbc_node_num; i++) {
-		if (xbc_nodes[i].next >= xbc_node_num) {
-			return xbc_parse_error("No closing brace",
-				xbc_node_get_data(xbc_nodes + i));
-		}
-		if (xbc_nodes[i].child >= xbc_node_num) {
-			return xbc_parse_error("Broken child node",
-				xbc_node_get_data(xbc_nodes + i));
-		}
-	}
-
 	/* Key tree limitation check */
 	n = &xbc_nodes[0];
 	depth = 1;
@@ -1203,6 +1213,10 @@ int __init xbc_init(const char *data, size_t size, const char **emsg, int *epos)
 	ret = xbc_parse_tree();
 	if (!ret)
 		ret = xbc_verify_tree();
+#ifndef __KERNEL__
+	if (!ret)
+		ret = xbc_sanity_check_tree();
+#endif
 
 	if (ret < 0) {
 		if (epos)

