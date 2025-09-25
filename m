Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FA62777FD
	for <linux-trace-kernel@vger.kernel.org>; Thu, 25 Sep 2025 21:18:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758835087; cv=none; b=iLioDv+GWFumajhpPhqnmU5H6TnrVRpNTesIAzVCiNNto07OS6Zz0lXUbcKq3GLNAbrb70m5anO7eOdhIEN9kQRhSrRe0f4stKIPzX2N+lB1lCl9OfMx17ko5yZkFDSdpc16DIicA0z5cbBwNNUnPcKxg9A60dUtxsDZNh0RUg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758835087; c=relaxed/simple;
	bh=zaTm5h9yIX7z+QocQqn6mOZfuOl1NNzLZf6FbQyEhFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=QY3ZghODFBy72v43lp+COyYcqyGWEqu4eN8ScxaXXoxvIBm8dKrz3x/RT1o19OgC/w8eXLyTUIxNMhhwuqG5cA7UWH+FfKGjyhrzjac0Uk6wRU9PLpH6HPQ1c4K8619PjsKdhTLvwhgMFK2oqE3MBwOU6AHvc4UM1hdTjFgXlk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NOdcNEnx; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NOdcNEnx"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758835081;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fdOtnZuNeNCE0UcW1H6VwdYySrWH1lRBDozCjfTv1oo=;
	b=NOdcNEnxybDPkmobUeJh0SjwWIpez3gHhAPuxX6pQSzvW7aQyNJg3TUMLb4o396RXRAgzu
	H5Qm0jqmILTsyAfPjtLhRkM7x8m3TDlNkmovJ0OC1WdGSMgqQyO5evWoNZzPo3WRUvZkpL
	1zhqF9VQrX25TGq04d92gwglQRwOvRE=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] tracing/osnoise: Replace kmalloc + copy_from_user with memdup_user
Date: Thu, 25 Sep 2025 23:17:36 +0200
Message-ID: <20250925211736.81737-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
simplify and improve osnoise_cpus_write().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
Changes in v2:
- Rebase to apply to master and linux-next
- Explicitly include linux/string.h
- Link to v1: https://lore.kernel.org/lkml/20250905192116.554018-2-thorsten.blum@linux.dev/
---
 kernel/trace/trace_osnoise.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 337bc0eb5d71..ab0575a94be1 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -24,6 +24,7 @@
 #include <linux/sched/clock.h>
 #include <uapi/linux/sched/types.h>
 #include <linux/sched.h>
+#include <linux/string.h>
 #include "trace.h"
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -2325,12 +2326,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	if (count < 1)
 		return 0;
 
-	buf = kmalloc(count, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (copy_from_user(buf, ubuf, count))
-		return -EFAULT;
+	buf = memdup_user(ubuf, count);
+	if (IS_ERR(buf))
+		return PTR_ERR(buf);
 
 	if (!zalloc_cpumask_var(&osnoise_cpumask_new, GFP_KERNEL))
 		return -ENOMEM;
-- 
2.51.0

