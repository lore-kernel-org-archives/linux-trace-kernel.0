Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76F9019C546;
	Wed, 23 Oct 2024 09:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729674242; cv=none; b=K8geqMM+XWJ7uwHWglzbvYSLd3FAUIi4lxbRbC9r17xgFRKgygHh72Ux8DluEPMYY5205Lr3gS3w1i2t7mrUnbcVF2AbtjOwjIOVXQXx13fsByAFTe7opDiUdBAEcTU0QbGYiAihFfGGmEjXg3OkehKlKPn77Zw7xFGr6QLJcI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729674242; c=relaxed/simple;
	bh=B0dcN+BupGltjscxxKKIw6/MugI4xtnT804Z0BJXYIM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/Z9kM5Mk7GAk+gUJSV+bsyQ59xKXSpHGDm6tLkw2QU5Q5wnNRfDdSaO0qGbWf80e4ljRMKIDKvyvOFDVtzw3i+nbOjDRjJd6fHbslqJQzRIlRuZzj3NutYhyryYEmOzgyoA8eyx5dEZ69buWHkUBqJsaw6EvW34cJWOuVLz2AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4XYNNL4S8zzyTdq;
	Wed, 23 Oct 2024 17:02:26 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 107BB1401E0;
	Wed, 23 Oct 2024 17:03:58 +0800 (CST)
Received: from lihuafei.huawei.com (10.90.53.74) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 23 Oct 2024 17:03:57 +0800
From: Li Huafei <lihuafei1@huawei.com>
To: <rostedt@goodmis.org>
CC: <dan.carpenter@linaro.org>, <mhiramat@kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<oe-kbuild@lists.linux.dev>, <lkp@intel.com>, <lihuafei1@huawei.com>
Subject: [PATCH] fgraph: Fix missing unlock in register_ftrace_graph()
Date: Thu, 24 Oct 2024 01:04:48 +0800
Message-ID: <20241023170448.808512-1-lihuafei1@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemf500004.china.huawei.com (7.202.181.242)

Instead of returning an error, goto the mutex unlock at the end of the
function.

Fixes smatch warning:

kernel/trace/fgraph.c:1317 register_ftrace_graph() warn: inconsistent returns '&ftrace_lock'.

Fixes: 2c02f7375e65 ("fgraph: Use CPU hotplug mechanism to initialize idle shadow stacks")
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Closes: https://lore.kernel.org/r/202410220121.wxg0olfd-lkp@intel.com/
Signed-off-by: Li Huafei <lihuafei1@huawei.com>
---
 kernel/trace/fgraph.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
index 41e7a15dcb50..98fa7b2a4903 100644
--- a/kernel/trace/fgraph.c
+++ b/kernel/trace/fgraph.c
@@ -1259,7 +1259,7 @@ int register_ftrace_graph(struct fgraph_ops *gops)
 					fgraph_cpu_init, NULL);
 		if (ret < 0) {
 			pr_warn("fgraph: Error to init cpu hotplug support\n");
-			return ret;
+			goto out;
 		}
 		fgraph_initialized = true;
 		ret = 0;
-- 
2.25.1

