Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 868B32EC54D
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Oct 2025 13:09:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759324189; cv=none; b=h9OL8Wm9iriwou50VaOzXEHhy5icpMJGzpl+Lj3jRChyomwry94sRZh/GxN7AzQP+/T/SCInRg5HvYLBOOG7FqZcxjNsoWUVWwtdnUK7f4kGSEE/0ITUqejIlE4fnyfJQTkU+HCppsls0WVpQoaetMQdWAwn+rlKz/w9VvvsZwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759324189; c=relaxed/simple;
	bh=SlsGcKn94cKwOpOeiRAUGFtV6V4m7TLuSa4h3z5bfoY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jd4+Cnjo6XzbVekTjb8jJJnKCmUBpyE3d3xN4tc4YbLXVPkkul/4Lh7lqF/vaJ+Fe36A9i9CJnMvL5kWL4bKCPgtOEvE5NL7rUZSU/9yfzeMiaxPWX9MYOPHR5noJUumrlO54omHFC9XMuzMWan6C10TeqredMo3rYBnOkBzY8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Vr4LmgH3; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Vr4LmgH3"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1759324184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jQ2vxUuusUzPFZ6c9hhAoRIgWPBIwaTDhcjuiNNYLdA=;
	b=Vr4LmgH3ZGMXT4VGTlPJsq67IEo3030yK04nIbMiOiM5MNZ2MV4n1hHnwC4dWujXseiXjq
	meIOg20eL1IXpb78H+6C4zybc27lpKmfIuCRisNn4Ruq6fB7LF0p3/9+ZuPz4k3ilRWTE+
	m5SKKZc4Xx6pXW3LBQtjsyn5ZVpLxNA=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] tracing/osnoise: Replace kmalloc + copy_from_user with memdup_user_nul
Date: Wed,  1 Oct 2025 15:09:07 +0200
Message-ID: <20251001130907.364673-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user_nul() to
simplify and improve osnoise_cpus_write(). Remove the manual
NUL-termination.

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v3:
- Use memdup_user_nul() instead of memdup_user() because of the fix a2501032de0d
  ("tracing/osnoise: Fix slab-out-of-bounds in _parse_integer_limit()")
- Link to v2: https://lore.kernel.org/lkml/20250925211736.81737-1-thorsten.blum@linux.dev/

Changes in v2:
- Rebase to apply to master and linux-next
- Explicitly include linux/string.h
- Link to v1: https://lore.kernel.org/lkml/20250905192116.554018-2-thorsten.blum@linux.dev/
---
 kernel/trace/trace_osnoise.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index dc734867f0fc..26d0c99125f5 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -24,6 +24,7 @@
 #include <linux/sched/clock.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
+#include <linux/string.h>
 #include "trace.h"
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -2325,13 +2326,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (count < 1)
 		return 0;
 
-	buf = kmalloc(count + 1, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, ubuf, count))
-		return -EFAULT;
-	buf[count] = '\0';
+	buf = memdup_user_nul(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.51.0

