Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53A1D331226
	for <linux-trace-kernel@vger.kernel.org>; Mon, 12 Jan 2026 07:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768203128; cv=none; b=q+EXtit/GF+lAylDfWABQJ9R4Pv8C6/qHiDicFed8NYo3XoUPTzNIvulkkK7mUVAsz6FobQwHAh+FmIiZjxBYs93vOGXbKmcBO96Qy6Jafc3p0y6KnoNogZLtb0X4ghTICZj5AiBUl2pjJR0E2tIy/z6fE4WmusQBPsp4wL71uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768203128; c=relaxed/simple;
	bh=eHRTYFWu9aM7ya+jZzDKgChWnn9WNk9AfvsQ4P4sh00=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e8vGUO1+pjJY8JMqKr3VYD5KsmtAWlmdThrxF80BbZ1rfjsIi2gevafSXb/ger5IVJASW6EhWu9lNSOmC/rylGbOkt/lnbsVrs1R+53bXHMzLvm0L1HeNqq37ga7plnvl2hwAbRLV9UWoSWc+S2nriPhgnTs5UdCRyWazwMCJSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=u50Wkj6l; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="u50Wkj6l"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768203121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dmoiTseSNktfLj4CfwRlR/i2JM/XKf2Hh9f07dEccSc=;
	b=u50Wkj6lO5c1Lvizbeft3JcTB6QajgqhaTsRTW6t+3Xe5wyfj1zQ2LdgwjXdoYmP7fd5kf
	0cPRfbHuEP+l5Cc+ttVmqCmWOkp4+x+oS/GadCVbfxvzlEZUHXKk9EXJlCE96cTlqPTTId
	meqRDVkC+tlgZby4pgZXur9o36hyepc=
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
Subject: [PATCH v2 3/6] tracing: Use copy_from_user_nul() instead of copy_from_user()
Date: Mon, 12 Jan 2026 15:30:36 +0800
Message-Id: <20260112073039.1185-4-fushuai.wang@linux.dev>
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
 kernel/trace/trace.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index baec63134ab6..b6ffd006fcf9 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -11266,10 +11266,9 @@ ssize_t trace_parse_run_command(struct file *file, const char __user *buffer,
 		if (size >= WRITE_BUFSIZE)
 			size = WRITE_BUFSIZE - 1;
 
-		if (copy_from_user(kbuf, buffer + done, size))
+		if (copy_from_user_nul(kbuf, buffer + done, size))
 			return -EFAULT;
 
-		kbuf[size] = '\0';
 		buf = kbuf;
 		do {
 			tmp = strchr(buf, '\n');
-- 
2.36.1

