Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E931D1DE89A
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Sep 2025 19:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757100113; cv=none; b=kAWy/4cyAb7Cx2MVk1t6aGfNjZu823xO9kKQrt4el5uLeFe4U4kzlzqbwd2wzuYKnsdtIn/RYjR/nHyozawznj54/+5pwyRlRt7xxNA7B+c8Dd5RByfuX1lmUnwQKn+MaEP3TQmOVbiJFu2TEPJt5j3K6e4aKYIzEvmbq4oR9uk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757100113; c=relaxed/simple;
	bh=b56PyGhSnpNehYj6T1uMpp+w6UN1jN6CXg65rEyxeJ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bsUBDfDraDuOmI7uw6DEdLIk8U09RULdh7Bjd5xaUdffP6LQioxwcxzzw9Ml1cGV9NBlx7y4gKt3HiMKWdyskELu9bghwzIuAXaZ6re5cw7AELqfcpO1pRoR2guF5LzKOitnzmHGH2W7hY54Dxkw1syZJPJ4V2dPM+mLZVCH1Aw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kHuJkxbn; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kHuJkxbn"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1757100108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pkHeOlPdETL+hOiJxj40JWxkGH5nYJc3pWzCiTMWFoo=;
	b=kHuJkxbn5aslX+Zb/pLJs/nh2LGXYLdEnJKKVehgS/i/Py87oGfiuSK6wZRNNMSPrfhC57
	MY1FkJtBFsO6yMyE7uPm5fepGrwsHEUd9DDj1jRja1pK0c2LIosJDpZtorYAM6gYSV1wUB
	bEPLZ6N6zbgVKLnvjFAn+i6w/dPaMNQ=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing/osnoise: Replace kmalloc() + copy_from_user() with memdup_user()
Date: Fri,  5 Sep 2025 21:21:17 +0200
Message-ID: <20250905192116.554018-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Replace kmalloc() followed by copy_from_user() with memdup_user() to
improve and simplify osnoise_cpus_write().

No functional changes intended.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 kernel/trace/trace_osnoise.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index fd259da0aa64..dd97f6bd03a4 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2322,12 +2322,9 @@ osnoise_cpus_write(struct file *filp, const char __user *ubuf, size_t count,
 	int running, err;
 	char *buf __free(kfree) = NULL;
 
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

