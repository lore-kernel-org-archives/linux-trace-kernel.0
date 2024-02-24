Received: from out-184.mta1.migadu.com (out-184.mta1.migadu.com [95.215.58.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9341646436
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Feb 2024 13:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708782740; cv=none; b=pvV9gSTZBX8Zjj9Th2lWO9NmTj6TGJ66UbY9lg9bM/LAaVeBaZORTOwHgbdtynLY6R48ew4QN5QIsTM48kNjZ3heHtqoFWDYZr58z1Xvmo+43LRcfcX48DVh8gbu3AxocPzbPod0Lhm0fmNmzJAJz3AU8yuQ0Bxy+eKyTRSAu/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708782740; c=relaxed/simple;
	bh=DWi/G6XObbnCjNhmKkVSdlq47mBz56V2FUFcf6XTH/A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=I5HzeRlotb004rlaMpOj4RE07n+E4QnPpzlNST73TizUA5h292P+wpjKs9OQPSaXnGpYoIksPNgUjvGZLfxNxl5Tv0RB9OdwoOB2KjKEYGwIJTgplBSlW8KR7VoJAPtGkIiSY+G6losI5h8+QXzMPRrnTWvB+eSsHHV2h0s1KKY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kVMssjGL; arc=none smtp.client-ip=95.215.58.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kVMssjGL"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1708782736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YFtXqFDS+/V/pPxlyQ29yAaA1FKzrLsOqyZdEIxRYN0=;
	b=kVMssjGLzngjIBFQ9FRjhikv4a2uzoSirFwYHZMbVlFcT7N0QQCxtPPwpZgXlmfXPCm7Oo
	5V99R5ge64NI3xnA+A4h4hM43P5/iLVGF0lT/8uEGkvHfMzXl0wLEMnynqpbibMiLTHRR0
	bW2fuW2DyaIMBf2+KwdE8LCc9F2cXQE=
From: chengming.zhou@linux.dev
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	vbabka@suse.cz,
	roman.gushchin@linux.dev,
	Xiongwei.Song@windriver.com,
	chengming.zhou@linux.dev,
	Chengming Zhou <zhouchengming@bytedance.com>
Subject: [PATCH] tracefs: remove SLAB_MEM_SPREAD flag usage
Date: Sat, 24 Feb 2024 13:52:06 +0000
Message-Id: <20240224135206.830300-1-chengming.zhou@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Chengming Zhou <zhouchengming@bytedance.com>

The SLAB_MEM_SPREAD flag is already a no-op as of 6.8-rc1, remove
its usage so we can delete it from slab. No functional change.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 fs/tracefs/inode.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index d65ffad4c327..5545e6bf7d26 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -731,7 +731,6 @@ static int __init tracefs_init(void)
 	tracefs_inode_cachep = kmem_cache_create("tracefs_inode_cache",
 						 sizeof(struct tracefs_inode),
 						 0, (SLAB_RECLAIM_ACCOUNT|
-						     SLAB_MEM_SPREAD|
 						     SLAB_ACCOUNT),
 						 init_once);
 	if (!tracefs_inode_cachep)
-- 
2.40.1

