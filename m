Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CB851991AD;
	Tue, 13 Aug 2024 11:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549615; cv=none; b=sQQvBU2Lrs3Habc1jc4kiSejtfOur0WziXdl2LouCNVsE46+ePLsw6w8L9WmHE01QVBslYdY3j3QPy8cVa9ItmpjZzXczYBobYxwtf+BqQy75+jI0CiNbCtGVFUwQZuVC/rqlF9WSHuaYS+Gm420J2UfiCO+U13hgZUKQkAzoOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549615; c=relaxed/simple;
	bh=r5BdEDtP0mypMR3yjszaHYFTiospBThuLrxuRmX8NF4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MnrLrLReqWA3QW2+FUI/1iEJ4AMz+9DnDT0SE4zpXMK9iE8VXJsTHGWB7tsqnNRd/72lq9ZUS7mgKk09B4CGe7yZbdzqCbjmTx94DwtATJTJjglKEerfbh8cREWpbQEIKVT5+8+hKQSes0SIIG7AAw25Rf4XLK/EyLfb+0eEuxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WjqMG4d12znd8c;
	Tue, 13 Aug 2024 19:45:30 +0800 (CST)
Received: from kwepemi100008.china.huawei.com (unknown [7.221.188.57])
	by mail.maildlp.com (Postfix) with ESMTPS id E6021140135;
	Tue, 13 Aug 2024 19:46:49 +0800 (CST)
Received: from huawei.com (10.90.53.73) by kwepemi100008.china.huawei.com
 (7.221.188.57) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.39; Tue, 13 Aug
 2024 19:46:49 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <naveen@kernel.org>, <anil.s.keshavamurthy@intel.com>,
	<davem@davemloft.net>, <mhiramat@kernel.org>, <kees@kernel.org>,
	<gustavoars@kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH 1/3] kprobes: Annotate structs with __counted_by()
Date: Tue, 13 Aug 2024 19:53:32 +0800
Message-ID: <20240813115334.3922580-2-ruanjinjie@huawei.com>
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

Add the __counted_by compiler attribute to the flexible array member
stripes to improve access bounds-checking via CONFIG_UBSAN_BOUNDS and
CONFIG_FORTIFY_SOURCE.

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 kernel/kprobes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index da59c68df841..e6f7b0d3b29c 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -92,7 +92,7 @@ struct kprobe_insn_page {
 	struct kprobe_insn_cache *cache;
 	int nused;
 	int ngarbage;
-	char slot_used[];
+	char slot_used[] __counted_by(nused);
 };
 
 #define KPROBE_INSN_PAGE_SIZE(slots)			\
-- 
2.34.1

