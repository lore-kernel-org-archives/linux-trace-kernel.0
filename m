Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6473491F1;
	Tue, 17 Mar 2026 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773780257; cv=pass; b=uY98P3aIa+rFW5cbDuiFchjIh8c5y/69uPDNlBVgXZku/FkX6WlDy3Px1kJLF0wpQl0FQgCUwoMHcQIiu/9trVRz43g+lhL3v3LlcgU+Dxf213D+MZBoxelLyh9Fsg0ZpcXAK/E1xf0KRifaNznek0kesepmfQstAHx1KAbhlxE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773780257; c=relaxed/simple;
	bh=FajaaTcCDF7W933H1AkJVqYlC9Mf1H27OTW5bm6qvco=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ftJkytvTTqhm1rRmYXlBFqsJ/VEUytsWxj7tCJ2sMRIFG4+F47vwC7B8OSc8nnbQKN5/0lU7YEGJ3KS9j1Z+VHqitqXWcN+cFZrseumCqyqyj5BV80g+m2t+B0ghczz99anJjVi1aSnSeAsf4MjP7j7CCaJCi69WtXXT3N12+Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=YLXEhSkz; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="YLXEhSkz"
ARC-Seal: i=1; a=rsa-sha256; t=1773780246; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=loAGTEP6TK+bM+3lQcSsz6S6hUL52kfelp9GAPFQOgds+WshQv/HfViY6pKb+1dzuAjzFXLxEtcSmAvAhGvcOphXMyBVK0+Ta5BRf0YP9tIxyKt41f022+oX+daYSS2sDg1nNy2XXWzS+tIJcF3OeBM75fQqe7sF+3jWwMseT10=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773780246; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=FNPONanpcF90VAKkxMUyhRz9rFK/8tyQtAG7fMJAqyg=; 
	b=hKjDg4X2KPIiuXyHgSFz8cs0UUZw9C7FBW1K58n8pTA+RYR2nBCyQ9L9lhVM2IppAiq46cAWyzljGXJWVSZxOq5lF1kHdsJxZoBU+Uf4bOdkPagppiosUCMpZ4l18/XOnH9u+uAbCMcbzPXsc/U5Yn0dEJ5JUb/LxAtsPVKkByc=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773780246;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=FNPONanpcF90VAKkxMUyhRz9rFK/8tyQtAG7fMJAqyg=;
	b=YLXEhSkzgfGXE1Tlwf+6Mq0rlkkt8A9Ta6NqPqMkv05Ujs41JNafKUCVRV1tdIqt
	2mJmNLwLqkqfeY7K62CH7ciRrUZoVhkqEJJRTO1qrQ4ouOXUprFX5OH1Fub6KDL2t+/
	GPk0eRgYpMbtzRPZzg7TD+OkBRS9oLyy8269VsFs=
Received: by mx.zoho.eu with SMTPS id 1773780244439239.82620473642874;
	Tue, 17 Mar 2026 21:44:04 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4] lib/bootconfig: guard xbc_node_compose_key_after() buffer size
Date: Tue, 17 Mar 2026 20:44:03 +0000
Message-Id: <20260317204403.72375-1-objecting@objecting.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

xbc_node_compose_key_after() passes a size_t buffer length to
snprintf(), but snprintf() returns int. Guard against size values above
INT_MAX before the loop so the existing truncation check can continue to
compare ret against (int)size safely.

Add a small WARN_ON_ONCE shim for the tools/bootconfig userspace build
so the same source continues to build there.

Signed-off-by: Josh Law <objecting@objecting.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
Changes since v3:
 - Moved the revision history below the --- separator so it does not
   become part of the git commit.
 - Added Reviewed-by from Steven Rostedt.

Changes since v2:
 - Added a comment explaining the INT_MAX guard.

Changes since v1:
 - Removed casting ret to size_t; with the INT_MAX guard, the existing
   ret >= (int)size check is sufficient, per Steven Rostedt.
 - Link to v1:
   https://lore.kernel.org/all/20260317173703.46092-1-objecting@objecting.org/

 lib/bootconfig.c                            | 8 ++++++++
 tools/bootconfig/include/linux/bootconfig.h | 5 +++++
 2 files changed, 13 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 96cbe6738ffe..2a54b51dec5c 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -313,6 +313,14 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 	if (!node && root)
 		return -EINVAL;
 
+	/*
+	 * Bootconfig strings never need multi-GB buffers. Reject sizes
+	 * above INT_MAX so snprintf()'s int return value cannot overflow
+	 * the truncation check below.
+	 */
+	if (WARN_ON_ONCE(size > INT_MAX))
+		return -EINVAL;
+
 	while (--depth >= 0) {
 		node = xbc_nodes + keys[depth];
 		ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
diff --git a/tools/bootconfig/include/linux/bootconfig.h b/tools/bootconfig/include/linux/bootconfig.h
index 6784296a0692..48383c10e036 100644
--- a/tools/bootconfig/include/linux/bootconfig.h
+++ b/tools/bootconfig/include/linux/bootconfig.h
@@ -8,6 +8,7 @@
 #include <stdbool.h>
 #include <ctype.h>
 #include <errno.h>
+#include <limits.h>
 #include <string.h>
 
 
@@ -19,6 +20,10 @@
 	((cond) ? printf("Internal warning(%s:%d, %s): %s\n",	\
 			__FILE__, __LINE__, __func__, #cond) : 0)
 
+#ifndef WARN_ON_ONCE
+#define WARN_ON_ONCE(cond)	WARN_ON(cond)
+#endif
+
 #define unlikely(cond)	(cond)
 
 /* Copied from lib/string.c */
-- 
2.34.1

