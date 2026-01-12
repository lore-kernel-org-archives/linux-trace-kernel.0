Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8372E329C78
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203120; cv=none; b=jFjiXv4saXxY2G/O09OKqpCmG8GxGsLaoixAfRhj//fpNMt35zidBipRW6PZnfcLvUh4UyqkFUgAVLvn59eFCzF/0NPpV+XpmagWARpmyUb9fPZGznEhxalJhDV0HKsKwtQoBBcSngH4hgWbkm/YEddkV9v69a40myyivPsZrB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203120; c=relaxed/simple;
	bh=dalNA0BxdWJLQHtJZnm34WkI5gbCzurqkKSSozGr3Z8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=snSxw/DgPvw/ae4cO83mHYHlcCWkHLlI1i/ugr7QZkpiRCrWnMq1+y/BJdeZu3TZ73h+OttYp8NvHXHMpxd+6/vFmlbKD8YZzc01nbIlPBowEVfOpAqEslJR1wvl+UO6uGlXks8pmKUaqIpHUAuyFivtl62K/qB03lnB5TLG8KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jE7S1QL7; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jE7S1QL7"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768203114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RW/CePLfpA2cGIbxlZCaBzT9qs/BsPWVBCiDlhNUjWo=;
	b=jE7S1QL7faF8pM+PQ3qz7/gONZwLuf22VH7YNNseR6jXXdqtKxNBogGlV4nqM3wPpeSAPD
	eQwJGXWmgaXqtAgLzd06r41dY4j74XFyLyzr0lj6KlKa9d/+tQ6YWI2mKCpf2ihDi4SRQp
	tz6xHlGi1cjtwYfx4OvbNHsV7sXfWDQ=
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
Subject: [PATCH v2 2/6] x86/tlb: Use copy_from_user_nul() instead of copy_from_user()
Date: Mon, 12 Jan 2026 15:30:35 +0800
Message-Id: <20260112073039.1185-3-fushuai.wang@linux.dev>
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
 arch/x86/mm/tlb.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f5b93e01e347..ae81e5cb510e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1807,10 +1807,9 @@ static ssize_t tlbflush_write_file(struct file *file,
 	int ceiling;
 
 	len = min(count, sizeof(buf) - 1);
-	if (copy_from_user(buf, user_buf, len))
+	if (copy_from_user_nul(buf, user_buf, len))
 		return -EFAULT;
 
-	buf[len] = '\0';
 	if (kstrtoint(buf, 0, &ceiling))
 		return -EINVAL;
 
-- 
2.36.1

