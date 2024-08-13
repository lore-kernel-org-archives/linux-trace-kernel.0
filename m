Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBD51991AD;
	Tue, 13 Aug 2024 11:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549621; cv=none; b=GiE4I8sygWzdSbaNte7B2O9fJ1DX8Dk4K0Tt79ELPyCk+LdBbfqMVxvS7rCZn3qvSjWb8kzkNCJXhndvof+hSZgPwRtxsc/Coc7HPqM6VjaQGL8Pvcck/fWs1svFf4bC93/Clt8V0QxSIfd99CcartFGOhQwvZXLZ243+E0UYeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549621; c=relaxed/simple;
	bh=IPrAPNWYxqIcrgurZSIeUYXHtzu6PAQ2/q34NUflszo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rcQQHjfMupLEoBSpQri6VXJ/vRhpYNopNC4I3zbYxfT2EuK83hWe/EiOqBvM6eTnr2zkWKF9RNj6MF9vMzGsIYgUF1lr4MD2+aRvh2TOdce8IMz2FfHTO0IWJyOsbFTTjeJgxQ/RjFxRxDubfzymH2UdeXCtuFXn5KekHmJF2eg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WjqNY2RCJzcdRP;
	Tue, 13 Aug 2024 19:46:37 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id 377DC1800CD;
	Tue, 13 Aug 2024 19:46:51 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 13 Aug
 2024 19:46:50 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <naveen@kernel.org>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <mhiramat@kernel.org>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 2/3] kprobes: Cleanup the config comment
Date: Tue, 13 Aug 2024 19:53:33 +0800
Message-ID: <20240813115334.3922580-3-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240813115334.3922580-1-ruanjinjie@huawei.com>
References: <20240813115334.3922580-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemi100008.china.huawei.com (7.221.188.57)

The CONFIG_KPROBES_ON_FTRACE #if/#else/#endif section is small and doesn't
nest additional #ifdefs so the comment is useless and should be removed,
but the __ARCH_WANT_KPROBES_INSN_SLOT and CONFIG_OPTPROBES() nest is long,
it is better to add comment for reading.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/kprobes.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index e6f7b0d3b29c..ca3fa8652c49 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -353,8 +353,8 @@ struct kprobe_insn_cache kprobe_optinsn_slots = {
 	/* .insn_size is initialized later */
 	.nr_garbage = 0,
 };
-#endif
-#endif
+#endif /* CONFIG_OPTPROBES */
+#endif /* __ARCH_WANT_KPROBES_INSN_SLOT */
 
 /* We have preemption disabled.. so it is safe to use __ versions */
 static inline void set_kprobe_instance(struct kprobe *kp)
@@ -1543,7 +1543,7 @@ static int check_ftrace_location(struct kprobe *p)
 	if (ftrace_location(addr) == addr) {
 #ifdef CONFIG_KPROBES_ON_FTRACE
 		p->flags |= KPROBE_FLAG_FTRACE;
-#else	/* !CONFIG_KPROBES_ON_FTRACE */
+#else
 		return -EINVAL;
 #endif
 	}
-- 
2.34.1

