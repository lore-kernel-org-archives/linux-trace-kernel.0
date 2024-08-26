Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277D76FB0
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Aug 2024 03:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724642764; cv=none; b=VkeOVVLZg76Z9/gTf+OMCEWCRKp3tmX8Ctn0B3PSG6k9Pf3M40L6Nau6cKCMrMqBLdGBKJwnCySKqt2bBYWb47mLTDTc7US9uu4YcJ+pmWio5gbzAnO3atX4kAR8Pq27dMvqI2B2C2VNrAH6pqtvWLTwjQubAoLy2eYfD3Pap3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724642764; c=relaxed/simple;
	bh=+cOEeJPXYaCEfTyWxcCzB4J1/TtvK69rEjJS6f8bP10=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=eqVeNE3VdLK4Bemd0hKT8tv+xd77zHAQIvkm/p7sm7wLa0/x3e32vkXbrlQ55hPnq2TpEynKcn99R0UW6rr2o98ODBD6TmKs0T8SUWGkCuDRljIvw4KAtEZhAMa4mlAmQEvBza1K6TZ1WnfvMfH9xkhtBRc+A9GxFlY5v+ts3tM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wsbdw3LLmz14BGv;
	Mon, 26 Aug 2024 11:25:08 +0800 (CST)
Received: from kwepemd200011.china.huawei.com (unknown [7.221.188.251])
	by mail.maildlp.com (Postfix) with ESMTPS id 951E21402E1;
	Mon, 26 Aug 2024 11:25:53 +0800 (CST)
Received: from cgs.huawei.com (10.244.148.83) by
 kwepemd200011.china.huawei.com (7.221.188.251) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 26 Aug 2024 11:25:53 +0800
From: Gaosheng Cui <cuigaosheng1@huawei.com>
To: <naveen@kernel.org>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <mhiramat@kernel.org>, <cuigaosheng1@huawei.com>
CC: <linux-trace-kernel@vger.kernel.org>
Subject: [PATCH -next] kprobes: Remove obsoleted declaration for init_test_probes
Date: Mon, 26 Aug 2024 11:25:52 +0800
Message-ID: <20240826032552.4016314-1-cuigaosheng1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemd200011.china.huawei.com (7.221.188.251)

The init_test_probes() have been removed since
commit e44e81c5b90f ("kprobes: convert tests to kunit"), and now
it is useless, so remove it.

Signed-off-by: Gaosheng Cui <cuigaosheng1@huawei.com>
---
 include/linux/kprobes.h | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 5fcbc254d186..8c4f3bb24429 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -269,15 +269,6 @@ extern unsigned long __stop_kprobe_blacklist[];
 
 extern struct kretprobe_blackpoint kretprobe_blacklist[];
 
-#ifdef CONFIG_KPROBES_SANITY_TEST
-extern int init_test_probes(void);
-#else /* !CONFIG_KPROBES_SANITY_TEST */
-static inline int init_test_probes(void)
-{
-	return 0;
-}
-#endif /* CONFIG_KPROBES_SANITY_TEST */
-
 extern int arch_prepare_kprobe(struct kprobe *p);
 extern void arch_arm_kprobe(struct kprobe *p);
 extern void arch_disarm_kprobe(struct kprobe *p);
-- 
2.25.1

