Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F1832E154
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203134; cv=none; b=phv6XIlpdj4HVEhJ4OyJe4RMKMmG+mtR9fjh4HHimG/LdzleY91HkOCFMr6KLn+85N3lQ70k3X1lT2OMAyJFobzLOjievBlAYrYL/2s/6EPt6Fs5JJ27HEArkqx0o1jxvz31zeu3uxPaaOymhmPgujO+tpBOAeJN4Xb96jR3yYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203134; c=relaxed/simple;
	bh=OnqAbUWVy7D0WXGNVBkrLwkuw9vg94fN5udfoCsYN8g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KywjbRfRDv3l9IqVwDM38Qlm6cjV0w0LOaxLp230cLWC5WqODtbH4je9nHbfkQ/po2UvePOs2ZRzVflzR0NYOKvNjwHBAnTXdUkbxnxDwR8KvzQ3oaR/j9mG+eYSMZWD/f1CMaA6tMxMdexKoCjGYZjUGVCQkKoPGN/4qd7vah0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QQzgX29E; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QQzgX29E"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768203126;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AwRqj4wTYeIgUDX0xZiGWFeCRQeFcAPC39VTqib2tBs=;
	b=QQzgX29EQmy4am2md5KjS0HuRT47z1dVNL4CH+BM0JYJb/YmzU4y/+lWkgxufMtBChEJ9G
	VcJND5bpCED/8yd1po0iwV4o93eczOgcIUlhgDMVZOGrhCqSQwJn8BqLoguJloK/x6VmCU
	bWhz9AVqeugOgV5pVfu2xggICKU01BI=
From: Fushuai Wang <fushuai.wang@linux.dev>
To: tglx@kernel.org,
	peterz@infradead.org,
	mathieu.desnoyers@efficios.com,
	akpm@linux-foundation.org,
	aliceryhl@google.com,
	yury.norov@gmail.com,
	vmalik@redhat.com,
	kees@kernel.org,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	hpa@zytor.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	brauner@kernel.org,
	jack@suse.cz,
	cyphar@cyphar.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	wangfushuai@baidu.com
Subject: [PATCH v2 4/6] userns: Use copy_from_user_nul() instead of copy_from_user()
Date: Mon, 12 Jan 2026 15:30:37 +0800
Message-Id: <20260112073039.1185-5-fushuai.wang@linux.dev>
In-Reply-To: <20260112073039.1185-1-fushuai.wang@linux.dev>
References: <20260112073039.1185-1-fushuai.wang@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Fushuai Wang <wangfushuai@baidu.com>

Use copy_from_user_nul() instead of copy_from_user() to simplify
the code.

No functional change.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 kernel/user_namespace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/user_namespace.c b/kernel/user_namespace.c
index 03cb63883d04..881a05a3502c 100644
--- a/kernel/user_namespace.c
+++ b/kernel/user_namespace.c
@@ -1239,9 +1239,8 @@ ssize_t proc_setgroups_write(struct file *file, const char __user *buf,
 
 	/* What was written? */
 	ret = -EFAULT;
-	if (copy_from_user(kbuf, buf, count))
+	if (copy_from_user_nul(kbuf, buf, count))
 		goto out;
-	kbuf[count] = '\0';
 	pos = kbuf;
 
 	/* What is being requested? */
-- 
2.36.1

