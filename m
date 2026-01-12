Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CCE335086;
	Mon, 12 Jan 2026 07:32:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203146; cv=none; b=nIOSt0ijXHk7t7ogcX3fm1r8dMzMPtJ5FrIiAKy9OC4YQvmVMdvmIZlq+s/LGearsWGEMQ5Wf3FKl1myMy3qkNKyRFTqBxpK766WGIyRjBZpfU4o0T9vIX1LYjGEwQfeHPVJPXjHlkJpAYOI57o+90jxLhyL/J1XeRpaFjVO/CU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203146; c=relaxed/simple;
	bh=G2quA3UBKlwpYY71RTQx6NE5SE7yumQOCJBy7zLmjpU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xj18kZgCmgr8YU2s7tKFyNHN3jnNPGvs+e9syuj0qqX+Lsk5YifQH/qMhP3ju5rmVSflmMLKlaraiKdJBVFaC48gZ6srj0r5xbvWo3WF7p36B51qaw3k6knOVjCZhj2+Y/9BeUn0sJND996kWXBALVmNcp0UE1hvsehRySKVSUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KNGH0pA7; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KNGH0pA7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768203136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IpOD+fYnrmJo+nD4L+qv9mFJmsh9VjP1W57JkVYRpI=;
	b=KNGH0pA7/xGz3mSnPL31Ffup/QPkvTuWKM4JcoLs2fFdZCWfR/+5YxMD9feCUV1OkJZEtP
	SWwpG3pJUoluYQYgfdU/WeT4arVkg+mWfvtLO7ii7+4KQRjJFu0B08kNmGF0HuT+X2im18
	77bOETKhd+BI/LKrEacbyrb+p307ojY=
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
Subject: [PATCH v2 6/6] kstrtox: Use copy_from_user_nul() instead of copy_from_user()
Date: Mon, 12 Jan 2026 15:30:39 +0800
Message-Id: <20260112073039.1185-7-fushuai.wang@linux.dev>
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
 lib/kstrtox.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/lib/kstrtox.c b/lib/kstrtox.c
index bdde40cd69d7..e4ee72b75e09 100644
--- a/lib/kstrtox.c
+++ b/lib/kstrtox.c
@@ -402,9 +402,8 @@ int kstrtobool_from_user(const char __user *s, size_t count, bool *res)
 	char buf[4];
 
 	count = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, s, count))
+	if (copy_from_user_nul(buf, s, count))
 		return -EFAULT;
-	buf[count] = '\0';
 	return kstrtobool(buf, res);
 }
 EXPORT_SYMBOL(kstrtobool_from_user);
@@ -416,9 +415,8 @@ int f(const char __user *s, size_t count, unsigned int base, type *res)	\
 	char buf[1 + sizeof(type) * 8 + 1 + 1];				\
 									\
 	count = min(count, sizeof(buf) - 1);				\
-	if (copy_from_user(buf, s, count))				\
+	if (copy_from_user_nul(buf, s, count))				\
 		return -EFAULT;						\
-	buf[count] = '\0';						\
 	return g(buf, base, res);					\
 }									\
 EXPORT_SYMBOL(f)
-- 
2.36.1

