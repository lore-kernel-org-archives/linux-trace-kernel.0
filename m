Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CDCB15B125;
	Fri,  7 Jun 2024 08:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717750211; cv=none; b=n2OBYAyEqF5k5MFkXmuPWTeEnswHxrzvTSJCCgApIOVek7xhBqF+wLdnSyhOqqaJo0N4U3YFe6gLwv/k9a9p0F1jTN3zyZQB+/sCAmFGspbLF/juvYPat+cK8nuQ6PpAYU1ogI3xF2aM8CzI4f2OBkWJv6/wZHI1DGnki0rIfe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717750211; c=relaxed/simple;
	bh=415rIulzfGFkRHln3IbWpy7fZk79beQPt8R9hFxAnvg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=N2nrQecL/Gj0zn2pYm/ChlIl7F/Zo2Qv4usB2qs4V24wlXiGS7SxJdw4QteFH1AZkhHgC37eTkVPM0iVwXsoP/O+hZzdEhCFNI94VNix5BtYZRHKyM5wghZwPSjn6PPgva7uklDlbSlgzcWbIvnuQtZ6CuvFmoQ6IKoR+fVZQtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=Luh6PVZh; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="Luh6PVZh"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717750201; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=oB8ZdPWvAcaB5cF+sGsaHK1RrmQp4ShYTfx88jKD8Fw=;
	b=Luh6PVZhxmIRffv3AWca/txoPbfboOJ958kONZ5KjYRUhNfhLgMMG2/AJ6b1UedS9Htl3owcOopVl0s6fumEKzbOs4Ili+xLIqjl1bXdnPkmzo0qT1paFWxqkAordE4PS8wkM2/5/Fe7OBk6AnlR3YLga8q6JW5+1csAhbXAGIk=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=yang.lee@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0W8-WBWg_1717750200;
Received: from localhost(mailfrom:yang.lee@linux.alibaba.com fp:SMTPD_---0W8-WBWg_1717750200)
          by smtp.aliyun-inc.com;
          Fri, 07 Jun 2024 16:50:00 +0800
From: Yang Li <yang.lee@linux.alibaba.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org
Cc: mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Yang Li <yang.lee@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH -next 2/2] ftrace: Add kernel-doc comments for unregister_ftrace_direct() function
Date: Fri,  7 Jun 2024 16:49:57 +0800
Message-Id: <20240607084957.64715-2-yang.lee@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
In-Reply-To: <20240607084957.64715-1-yang.lee@linux.alibaba.com>
References: <20240607084957.64715-1-yang.lee@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Added kernel-doc comments for the unregister_ftrace_direct() function to
improve code documentation and readability.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9300
Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
---
 kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 4aeb1183ea9f..3b0dbd55cc05 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -5988,6 +5988,8 @@ EXPORT_SYMBOL_GPL(register_ftrace_direct);
  * unregister_ftrace_direct - Remove calls to custom trampoline
  * previously registered by register_ftrace_direct for @ops object.
  * @ops: The address of the struct ftrace_ops object
+ * @addr: The address of the direct call to remove
+ * @free_filters: Boolean indicating whether to free the filters
  *
  * This is used to remove a direct calls to @addr from the nop locations
  * of the functions registered in @ops (with by ftrace_set_filter_ip
-- 
2.20.1.7.g153144c

