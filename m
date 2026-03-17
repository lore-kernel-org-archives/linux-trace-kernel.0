Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B282F7AD2;
	Tue, 17 Mar 2026 16:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773763783; cv=pass; b=K2dnvluSQ1DTPJlj998485nSoc9jPK1897WduzOelP+GIfze1T+OhpIQ74JZPXNqNe2Simf8lg3GF06k5j9S+tpEHJEXGlFcF5upNr5J01tZsB9xwA2fdGhZ0jIjlHjT/Z2sFtVmHtswmVQV0maMI95G6NxdB7HB7kkVa1qj0p0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773763783; c=relaxed/simple;
	bh=6Fo6RSQQSEkzHn7Jh8Smo8YsAtoTRq1YRco2C0K7n18=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bp501ERFwAzVeb0ayMAoDFvFpkIhQnFfuA3Kzg5QU0HW0d4xG9c2kGyDl7inPWzSvCc6PSGxpFlQOqpg3qioPfGLzoYTK4me2CafbRGvXKCo3bo1dyl8kfXXnt2tvkN8OnnH5CRVSv9gY9s8FxgQAnHYdv+OPehDOnOsclx9BBo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=FbHePYTz; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="FbHePYTz"
ARC-Seal: i=1; a=rsa-sha256; t=1773763762; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=hm6TrNBrvC+ixeeIjFOBIvbDllgVHppxwvgaJADSHXN7Kp7CuvdMqQQyPxcN2kORBlHfaekiopqgah4vvUtuV9pzdGQzgn0b751ilj5t5XjH1ZNaiq7C6DRzKqGitBKXrkvJPaZyW1OalVI3xJKwLyCHWdDLHzVzAuL7N+U5OQU=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773763762; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=vtmO6u/jqqPXfSKF2EgGWY5wmzpnk5cpwQL3qgwBYG4=; 
	b=XXiVLEkLGwczKUkwOeSCltOlye0yyj6/qU5Li3iC5GQ0AsixkdlL6rzqp2kCu1LHyRyGvEbQALf1ozqt4i69+sA+l0BbgAtvWgrCkgD6TLM5xfkkMXSaBpwxbxTRSfkgAsWd7NUOVTa/vcklynp6bv4/CsKYNcDjTDrHSDo9+LY=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773763762;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=vtmO6u/jqqPXfSKF2EgGWY5wmzpnk5cpwQL3qgwBYG4=;
	b=FbHePYTzV0KdRUzgifD+67TzqPP6jwSVeFGKoM5UxaBkWL7FyrJ15xxuvjn2yDg1
	gbfbmRVTaXawGG0wY1E/HD7Jng112L36euN8cKOPzp36dKb7xyTVMt0y7sdmCXOLLxQ
	QT2xKFlvhjN7PROdNzT81igs4rcG3CGLilrhYSCA=
Received: by mx.zoho.eu with SMTPS id 1773763758809468.18190920887355;
	Tue, 17 Mar 2026 17:09:18 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v7 02/15] lib/bootconfig: narrow flag parameter type from uint32_t to uint16_t
Date: Tue, 17 Mar 2026 16:09:03 +0000
Message-Id: <20260317160916.33576-3-objecting@objecting.org>
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

The flag parameter in the node creation helpers only ever carries
XBC_KEY (0) or XBC_VALUE (0x8000), both of which fit in uint16_t.
Using uint16_t matches the width of xbc_node.data where the flag is
ultimately stored.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index d77b6533ac00..d69ec95d6062 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -408,7 +408,7 @@ const char * __init xbc_node_find_next_key_value(struct xbc_node *root,
 
 /* XBC parse and tree build */
 
-static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag)
+static int __init xbc_init_node(struct xbc_node *node, char *data, uint16_t flag)
 {
 	unsigned long offset = data - xbc_data;
 
@@ -422,7 +422,7 @@ static int __init xbc_init_node(struct xbc_node *node, char *data, uint32_t flag
 	return 0;
 }
 
-static struct xbc_node * __init xbc_add_node(char *data, uint32_t flag)
+static struct xbc_node * __init xbc_add_node(char *data, uint16_t flag)
 {
 	struct xbc_node *node;
 
@@ -452,7 +452,7 @@ static inline __init struct xbc_node *xbc_last_child(struct xbc_node *node)
 	return node;
 }
 
-static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, bool head)
+static struct xbc_node * __init __xbc_add_sibling(char *data, uint16_t flag, bool head)
 {
 	struct xbc_node *sib, *node = xbc_add_node(data, flag);
 
@@ -480,17 +480,17 @@ static struct xbc_node * __init __xbc_add_sibling(char *data, uint32_t flag, boo
 	return node;
 }
 
-static inline struct xbc_node * __init xbc_add_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, false);
 }
 
-static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint32_t flag)
+static inline struct xbc_node * __init xbc_add_head_sibling(char *data, uint16_t flag)
 {
 	return __xbc_add_sibling(data, flag, true);
 }
 
-static inline __init struct xbc_node *xbc_add_child(char *data, uint32_t flag)
+static inline __init struct xbc_node *xbc_add_child(char *data, uint16_t flag)
 {
 	struct xbc_node *node = xbc_add_sibling(data, flag);
 
-- 
2.34.1

