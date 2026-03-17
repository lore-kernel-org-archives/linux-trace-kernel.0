Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F9B19E819;
	Tue, 17 Mar 2026 18:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773771372; cv=pass; b=C/Anjz+RFap+xF+y1CT5dgsr9lo/cYjigQmy0hR5aVKx9Z9jNnN1gLEmztJYwG1QQ1EcRXC50mzSQUrqzKKwinbhat4Ql51/tcb268jhUkENNeiunv5ym7nnGS3iewVsuur89pFnsqJqSKilLnhXq2TMYpmmh79VltHIoMTvWPQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773771372; c=relaxed/simple;
	bh=Et8dFedx3WfPwJsmA2vWhMjaE6g9BDcNFCjp+uCyKMo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mQTAPbueGbhhJHe9CW4x1Gts44fDZRtn8WdZjQhASe8YgbsoPzoZVxhml7YDO/CRI15fYivrU1rCMOXeqyu2iXbRrccnt3ayh5VTcfjOEN8wUd65IpuG4mt2oQOZkwYx0gMSkSG5DxpHZYQ9ooC+ZhClQ2W++VqaARU67KVVFz0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=V/F4AGnR; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="V/F4AGnR"
ARC-Seal: i=1; a=rsa-sha256; t=1773771360; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=kKM2WOd3hovaeildklCCAhd4WSEGUqJLWR6VH/7bZANHP+nU/jbKKcmYOGCj2s6o55gv7pvRlqWVx3ud5AeJpIphkwVPzDdxRtPMQJte/QP9mzuY3lt4pZZOUV5AVxE/dBFxbFKignYiAInaH6AkvqZZFmGcGnKoePRJjtgGxm8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773771360; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=dJYnFEhPt2DkWNl/SUDKiZ5PqgEYKkcH/VOyeZ9wnag=; 
	b=iKkzzwxrFEkEzwZBGI+jEmEjKDIw9RbgAioUOo1JnazZ5dG2SJGeHNKXmiNPDF9kM1X/0ip0cXutWLRy9aOqnc/NWtg9srsl8EldkO/lBRGckjGTQYWoYT87c+ITqz7MuW/CX7ANYU8uQBRrryXttSqp/pN1LOT4pYEPWpIs9Kw=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773771360;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=dJYnFEhPt2DkWNl/SUDKiZ5PqgEYKkcH/VOyeZ9wnag=;
	b=V/F4AGnRjbJF4atd9MV0hp0h5TfGqcZYsh3+TmSMAvPchRpAme/VSCpi9LudwxF9
	xy3j4AHHIiN/cdICguZ4jAc959UJWXoa4r4YleZaTpTdtJmYGmKr17EkKTIyC88G83o
	3mA7nCFG6nHDot/ClFT8drmR/Iyce0XaEhmYm3iI=
Received: by mx.zoho.eu with SMTPS id 1773771357178456.60719411615514;
	Tue, 17 Mar 2026 19:15:57 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] lib/bootconfig: guard xbc_node_compose_key_after() buffer size
Date: Tue, 17 Mar 2026 18:15:56 +0000
Message-Id: <20260317181556.53417-1-objecting@objecting.org>
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

Changes since v2:
 - Added a comment explaining the INT_MAX guard.

Changes since v1:
 - Removed casting ret to size_t; with the INT_MAX guard, the existing
   ret >= (int)size check is sufficient, per Steven Rostedt.
 - Link to v1:
   https://lore.kernel.org/all/20260317173703.46092-1-objecting@objecting.org/

Signed-off-by: Josh Law <objecting@objecting.org>
---
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

