Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AF673346A0;
	Tue, 17 Mar 2026 17:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773769036; cv=pass; b=tvI4Xb1KC47zeXgqbtcNcG8XxCA74DZv8c0FkIe0k91s//YcWGSyufv6Df5IntJJ0553Z2qGRQkfGXAxZ9ZWVPzUuyCWUfuoeY54rWqCbDA+FJXlZZWDz8TGtPuCRfe/ispTcctig63X/T/nI/2Ls8Xlb77hHVyKVzpokneKkwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773769036; c=relaxed/simple;
	bh=gY4EfM1EKRnFM4DXQeAl3TFTvOB/Qwzikckkx2/dfdo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JSaF2pykI3/I+TCWsQ4MgEXyq98/bPdHvwWVdoDBZQlKpmr9IBHD4PQKJO2KRI72uh30ydbUyk3vQluoAjrHSd6VOZZxaPnpewK0hNlJRftRwEs8HMpxC//W0DtJ0V0nJvpZwD5c3bom8SQ65rk6Q3CftVSLZsMYRX1q0s1Oj1Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=YaDMqxRz; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="YaDMqxRz"
ARC-Seal: i=1; a=rsa-sha256; t=1773769026; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KFWEHeef/nrhgBUWvrs3wXEqRkE5e702RENnfHCVaogJYxC0xblFMidWkk19Dfs5aYfklrTlMbHLHvs+tKiaTqjCfoOU2o8WVuKMclu+A6yuGtUj0oSe547gOyT43GHQ8aX6wGEbd2Zt8QHo3a792EmCSA9AsUYW1cyujagougw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773769026; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ohOXXNaYRo+t4vhQe87dH1RU/dGaslNMc3eCaQfzc0M=; 
	b=eaXtjtSbDtWDjKmIFCrChpVCMKk563+XFUc6bgShsqtGNi9hdrTf5ulHHg7WBIqM62lTRC9aLJWUHPwl/YyZN0sZWahXyWGrE23826mMdPApY5jX5Q91ePzMFutVsXdpB7KunVPBYZLWxHMGgO4K04NOO887D7YqlJEvUlhYIe8=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773769026;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=ohOXXNaYRo+t4vhQe87dH1RU/dGaslNMc3eCaQfzc0M=;
	b=YaDMqxRzyIoTXCw8rg4eRwMFF+w96EfgJztPlnqTc1C0+hz9S83khSmem3ibcSW+
	NaioYHbb/OapktiO6unf2CTdOCLkIk6MUwTHjenLScvYl4mcAzzBKjvrMUkkxzpK+8K
	mW6ishmiay4NbZcad0tce2mOL7WcbpEMT4mHN9fs=
Received: by mx.zoho.eu with SMTPS id 1773769024812254.10526507691395;
	Tue, 17 Mar 2026 18:37:04 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] lib/bootconfig: guard xbc_node_compose_key_after() buffer size
Date: Tue, 17 Mar 2026 17:37:03 +0000
Message-Id: <20260317173703.46092-1-objecting@objecting.org>
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
INT_MAX before the loop, then compare the returned length as size_t when
checking for truncation.

Add a small WARN_ON_ONCE shim for the tools/bootconfig userspace build
so the same source continues to build there.

Signed-off-by: Josh Law <objecting@objecting.org>
---
 lib/bootconfig.c                            | 5 ++++-
 tools/bootconfig/include/linux/bootconfig.h | 5 +++++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 96cbe6738ffe..bc6751b632e3 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -313,13 +313,16 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 	if (!node && root)
 		return -EINVAL;
 
+	if (WARN_ON_ONCE(size > INT_MAX))
+		return -EINVAL;
+
 	while (--depth >= 0) {
 		node = xbc_nodes + keys[depth];
 		ret = snprintf(buf, size, "%s%s", xbc_node_get_data(node),
 			       depth ? "." : "");
 		if (ret < 0)
 			return ret;
-		if (ret >= (int)size) {
+		if ((size_t)ret >= size) {
 			size = 0;
 		} else {
 			size -= (size_t)ret;
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

