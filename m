Received: from out-186.mta0.migadu.com (out-186.mta0.migadu.com [91.218.175.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7584329C78
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203136; cv=none; b=NI7eJlpKi3y0LsUvWPffjeM6l0+JKb8MtgRkd17yjq0J+/m/OIvK4nVy95fR49FN9KykXGO3Iu/rbCCmQtvQkglsjs3VCvVmpEzEda5fSGpPdYblnEot8A9JZynIbUVrcXEqwfYAVRp2wlKd0AR5Ckt97VfS1oeyiQ+nZLP4mFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203136; c=relaxed/simple;
	bh=/Pe3//9w7IjRlZ5PxKu63g76brGyRa5s21C2q9PEXSY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cldhiYwGDtIlOcGhRguhCL9pFq5fnbXjH6ZMEALPiOIiekBbDw6bFid2DGJ0gSwz2SzJPmmFx1hZ241Q1t1sITLgex5mh1Yu7wkyjKpaEwR/vok+4sBYM7rM/iTRIqeqSzbDKAuZRAIKFCZRCWsNgN9tdhA4NcPY3m02YyYficQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=NkQ4kSRY; arc=none smtp.client-ip=91.218.175.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="NkQ4kSRY"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768203131;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dey/oVwL655ps/UccfLJszueXjmKm4iUYtixNmkF++Q=;
	b=NkQ4kSRYHQKog9dolagfPy1l0wY9hoVzmEFzdXdqH4dPhXxiyjiZiuHb5gP5imP5m1h/6k
	N49ll2G027dYaf1RuzrZDTzgdaiJkDyMdPxGz/D7J56gEF5JvM5WeYE7hOM6PE43uGmMv9
	DTzCtcwOQfKAOFrNlm2dc1KTu2B+chw=
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
Subject: [PATCH v2 5/6] time: Use copy_from_user_nul() instead of copy_from_user()
Date: Mon, 12 Jan 2026 15:30:38 +0800
Message-Id: <20260112073039.1185-6-fushuai.wang@linux.dev>
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
 kernel/time/test_udelay.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 783f2297111b..08ff8fd43471 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -107,9 +107,8 @@ static ssize_t udelay_test_write(struct file *file, const char __user *buf,
 	if (count >= sizeof(lbuf))
 		return -EINVAL;
 
-	if (copy_from_user(lbuf, buf, count))
+	if (copy_from_user_nul(lbuf, buf, count))
 		return -EFAULT;
-	lbuf[count] = '\0';
 
 	ret = sscanf(lbuf, "%d %d", &usecs, &iters);
 	if (ret < 1)
-- 
2.36.1

