Received: from out-181.mta0.migadu.com (out-181.mta0.migadu.com [91.218.175.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E5B2314B72
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203112; cv=none; b=S54HCEmHdSez7bbxHYBMpGFc3EiClvTG41F7ooMBRVKOn9Jk8SG2hHb39pbDyMHql+DzBi7evGtrbIMWqLcL+zntzb2YP7ng7+rx+qlEe8hjEktiYFQ5aEgEeQ+QkFW9Gk2wwdYqYeJGKUBKP191Ag8TJ7RwTaulNz25PuKLNhM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203112; c=relaxed/simple;
	bh=0w8glGv5zehTU8mYqRipHl0MsH4jVNl2Z7VDxD4FQoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gyQz1MBz/0pHQ36kBxChbZRhFOU0ln1Q3isUU68vGaKglz4aFFbHeQQRrWzKjDyy15FCYqcQxl4d/+q6kcf4zH0Ptfd6Pz+4OtOtGSA1TuFsGfW799YugfF2st3jT211nTVrtcZ0/FQ4IQur8uC663QUGmXhID1ZEwn+ewPWhpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=phie3JAT; arc=none smtp.client-ip=91.218.175.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="phie3JAT"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768203109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RVzCy4in+NcnK6/nhRnifh8d5UAeV3WaYJGZ0fRZrUk=;
	b=phie3JATXRtHR8qqfJ1kMcrZDQ5Rbzu7BArH8wdeNaW8ggrVtzX9ioBSiFPL8Q9ojxBo5n
	CyPvTA1tMXk5zHbrObIyWAG8nTFNN88TOv88pBLXRyfj3rsjm3cNT4z7JDBHah3I1ESa42
	w4YBmXmv/doUmbkeZzFzvvmwhtqC6R0=
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
Subject: [PATCH v2 1/6] uaccess: Add copy_from_user_nul helper
Date: Mon, 12 Jan 2026 15:30:34 +0800
Message-Id: <20260112073039.1185-2-fushuai.wang@linux.dev>
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

Many places call copy_from_user() to copy a buffer from user space,
and then manually add a NULL terminator to the destination buffer,
e.g.:

	if (copy_from_user(dest, src, len))
		return -EFAULT;
	dest[len] = '\0';

This is repetitive and error-prone. Add a copy_from_user_nul() helper to
simplify such patterns. It copied n bytes from user space to kernel space,
and NUL-terminates the destination buffer.

Signed-off-by: Fushuai Wang <wangfushuai@baidu.com>
---
 include/linux/uaccess.h | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/include/linux/uaccess.h b/include/linux/uaccess.h
index 1f3804245c06..fe9a1db600c7 100644
--- a/include/linux/uaccess.h
+++ b/include/linux/uaccess.h
@@ -224,6 +224,25 @@ copy_from_user(void *to, const void __user *from, unsigned long n)
 #endif
 }
 
+/*
+ * copy_from_user_nul - Copy a block of data from user space and NUL-terminate
+ *
+ * @to:   Destination address, in kernel space. This buffer must be at least
+ *        @n+1 bytes long!
+ * @from: Source address, in user space.
+ * @n:    Number of bytes to copy.
+ *
+ * Return: 0 on success, -EFAULT on failure.
+ */
+static __always_inline int __must_check
+copy_from_user_nul(void *to, const void __user *from, unsigned long n)
+{
+	if (copy_from_user(to, from, n))
+		return -EFAULT;
+	((char *)to)[n] = '\0';
+	return 0;
+}
+
 static __always_inline unsigned long __must_check
 copy_to_user(void __user *to, const void *from, unsigned long n)
 {
-- 
2.36.1

