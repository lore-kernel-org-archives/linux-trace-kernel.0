Received: from sender-of-o55.zoho.eu (sender-of-o55.zoho.eu [136.143.169.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1CC31F99D;
	Tue, 17 Mar 2026 18:06:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.169.55
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773770780; cv=pass; b=ajUG8vpKJS8uBb6DSRwR5z5dRWA6rB5xVM9Hu6p4ifZ+EXbkVBR4APzSdJGJRFrEnga8EA+x1pp5YVqboUhgXxfDD97lbhVda9E5uHZ56fYsJbnDa95kOV72aXintf1O1NDUdD5a79J2JnhAgyiK1JFBWNtmUsOsRwe4uZNRhQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773770780; c=relaxed/simple;
	bh=nEKzaqrCKHp7j/+WkdvJZABDcds6kxvyjssmqBwt1xg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VpotuNdFmlwJfiOJ6HNBfHnoywC0Wfo922w410BRehHmSzzM11FAUjbeX9hDZAyBFlmM2g0AA5h1ecpPsrMFglo34rngq02jYqjbrL9XLn3eg5efWp6QYrAfVHVuxO1MzHuyluMp1tKYk3Wz5mQHmiqsdrYZ/rAw5vyDlU8wbec=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org; spf=pass smtp.mailfrom=objecting.org; dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b=EPjpKoef; arc=pass smtp.client-ip=136.143.169.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=objecting.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=objecting.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=objecting.org header.i=objecting@objecting.org header.b="EPjpKoef"
ARC-Seal: i=1; a=rsa-sha256; t=1773770769; cv=none; 
	d=zohomail.eu; s=zohoarc; 
	b=KueugwzPUqqO8p3LFjUH0KgUxz5LIBUQka2uUF1mVYDXvMvK9ymJMk/gC4oKonE+UMb/JcMWI3VXSX6O9GjSatZpcDnbH9d5/yco78uathLRotEKkBbR2W7XBjWIDc8udJ9UZXqzj1jgpklAIps8JOEwhbXM7LBWlU8oSTyFYt0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.eu; s=zohoarc; 
	t=1773770769; h=Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:MIME-Version:Message-ID:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NHrLWG//GpAg14y6w7Vm5tI6KAhGu5Jog+emhxyoSMk=; 
	b=EJcmswAVwh4TzxAAiQDTaLtw45wISJRxLx7UdX+HbR1+OGPZ9G/RZngvhJ98HELgJtaaq1ygeLJClVrC17V/HLlAdk6YPbJ5ouCdzY8/QUYjXG96gBsB/nrhu7OnDd0xn27AtrmhGam0oFsCsI1vAMX9etzjd527XIi8a50vkgs=
ARC-Authentication-Results: i=1; mx.zohomail.eu;
	dkim=pass  header.i=objecting.org;
	spf=pass  smtp.mailfrom=objecting@objecting.org;
	dmarc=pass header.from=<objecting@objecting.org>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1773770769;
	s=zmail; d=objecting.org; i=objecting@objecting.org;
	h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:MIME-Version:Content-Transfer-Encoding:Reply-To;
	bh=NHrLWG//GpAg14y6w7Vm5tI6KAhGu5Jog+emhxyoSMk=;
	b=EPjpKoef+yVQ9vRdC7aK4ugetgU9xJWRlldZ4yxJdfGaEqchsyP5abfC0kZQINOA
	I/LqQphXpFPhuC8nV/Y2o8G/Dnz01mQG1jPf3R5/CRBm7y/OHaMDJ41uOO3EVSxFTwy
	l4AYe3fK3DFefMWfOLUnCxiqTdi3FQxIFXMpDhqc=
Received: by mx.zoho.eu with SMTPS id 1773770766993180.08137320550804;
	Tue, 17 Mar 2026 19:06:06 +0100 (CET)
From: Josh Law <objecting@objecting.org>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] lib/bootconfig: guard xbc_node_compose_key_after() buffer size
Date: Tue, 17 Mar 2026 18:06:05 +0000
Message-Id: <20260317180605.50970-1-objecting@objecting.org>
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
---
 lib/bootconfig.c                            | 3 +++
 tools/bootconfig/include/linux/bootconfig.h | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/lib/bootconfig.c b/lib/bootconfig.c
index 96cbe6738ffe..730209c83e62 100644
--- a/lib/bootconfig.c
+++ b/lib/bootconfig.c
@@ -313,6 +313,9 @@ int __init xbc_node_compose_key_after(struct xbc_node *root,
 	if (!node && root)
 		return -EINVAL;
 
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

