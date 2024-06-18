Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 022DA54724;
	Tue, 18 Jun 2024 07:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718695229; cv=none; b=mj/lukqNABcunU4C9msfHhx9ImsrIahLpELXPCETJEKhP3gFODuQfWyEnu5Q7PhxI5fWx67hqfbmycBioWCKSca6zRVtja9b9mAHT7WO5deeFXnCXEVIpn8XLSez54C0v9C+dFmcg5KesXupt4/JBPiD0KfqJElGM+wXeSQeEuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718695229; c=relaxed/simple;
	bh=FIPT6lCf+zj99FHHyw3mQx//uLZykQ8rPdsZXxS6W+4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UWLtTZe4HQFP8dUnwLrl9wYZl2sPX4XFC1EABe6+GCtJlhqGCaErywTDNTw7STKYuzHyS7269gWASpIkIouLiuA4EZ40WFJbxmcqlOLki+wpkgatqitHOO49NacZH/azriN46uhi+x+b3bfUvyfXKHJknFuyTIkuErNBEH4CWbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=teSK2Z1u; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="teSK2Z1u"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1718695224; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nDo5YAs2CRrhczpgfzOhYy/3dEdPBFGSExQgFzNnxkg=;
	b=teSK2Z1uJK8Ct48u8YsNoDIu1LbRvgYRMrna5tIRlNO/HLcu8hPvqbYWx/4YbelL6eY5rm62sa+Pc0by9etczmFxlF3R9GLFGyKKXhLQRGumPbcz99P+EFp/mUVyyapr2IOwF6m0t8MJBdnAKu15z1sohwV+HUS57dEftWMmwxA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067110;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---0W8jHIvY_1718695214;
Received: from localhost(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0W8jHIvY_1718695214)
          by smtp.aliyun-inc.com;
          Tue, 18 Jun 2024 15:20:24 +0800
From: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Jiapeng Chong <jiapeng.chong@linux.alibaba.com>,
	Abaci Robot <abaci@linux.alibaba.com>
Subject: [PATCH] fgraph: Use str_plural() in test_graph_storage_single()
Date: Tue, 18 Jun 2024 15:20:14 +0800
Message-Id: <20240618072014.20855-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 2.20.1.7.g153144c
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use existing str_plural() function rather than duplicating its
implementation.

./kernel/trace/trace_selftest.c:880:56-60: opportunity for str_plural(size).

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=9349
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 kernel/trace/trace_selftest.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index adf0f436d84b..97f1e4bc47dc 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -877,7 +877,7 @@ static int __init test_graph_storage_single(struct fgraph_fixture *fixture)
 	int ret;
 
 	pr_cont("PASSED\n");
-	pr_info("Testing fgraph storage of %d byte%s: ", size, size > 1 ? "s" : "");
+	pr_info("Testing fgraph storage of %d byte%s: ", size, str_plural(size));
 
 	ret = init_fgraph_fixture(fixture);
 	if (ret && ret != -ENODEV) {
-- 
2.20.1.7.g153144c

