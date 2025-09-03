Received: from mail-m2430.xmail.ntesmail.com (mail-m2430.xmail.ntesmail.com [45.195.24.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20AE2253359
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Sep 2025 07:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.24.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756884423; cv=none; b=eufuoEz1wvxJqsblCrCoTaq2ypxiYmHvSxza60pVMb++7RIg3MSTsW7XoDDVr46irJa3k1aLnsc+8OGx5jjj5quuabCOOAfEd9dth4ueF+o6Pyii+lcjM7LrYZHybQj9UTv3P09XSTvHDhrG0uW/4StMGnnF5ZZDdCRqSvH8+aY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756884423; c=relaxed/simple;
	bh=r/edZy7zk3JmqAvx7dz++SJNj68usKLXbSwngs9wNG4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aAcZtaiOsLS6W3XU6LjEfnEfoy2Y9NY6Ah8F/JROMRCf8baLEpWf5hwQ2WMNWa5aT0TMeBVYPuMrWzxvs8R0dJ8uBuSSAToKcePOdTaoSjV2Oc4Rf/kOd3sFNeR5LwhxoZWABPC+jrHnr+tipvrcS0U5LVOoSMVBRa0EpmjCpsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.24.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [218.94.118.90])
	by smtp.qiye.163.com (Hmail) with ESMTP id f9e221a1;
	Wed, 3 Sep 2025 14:51:21 +0800 (GMT+08:00)
From: Zhen Ni <zhen.ni@easystack.cn>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	Zhen Ni <zhen.ni@easystack.cn>
Subject: [PATCH] rv: Fix missing mutex unlock in rv_register_monitor()
Date: Wed,  3 Sep 2025 14:51:12 +0800
Message-Id: <20250903065112.1878330-1-zhen.ni@easystack.cn>
X-Mailer: git-send-email 2.20.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a990e58220f022fkunma7f356a26cca47
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkZTk1PVk5LTk4dTEgZTkIdH1YVFAkWGhdVGRETFh
	oSFyQUDg9ZV1kYEgtZQVlJSkNVQk9VSkpDVUJLWVdZFhoPEhUdFFlBWU9LSFVKS0lPT09LVUpLS1
	VLWQY+

If create_monitor_dir() fails, the function returns directly without
releasing rv_interface_lock. This leaves the mutex locked and causes
subsequent monitor registration attempts to deadlock.

Fix it by making the error path jump to out_unlock, ensuring that the
mutex is always released before returning.

Fixes: 24cbfe18d55a ("rv: Merge struct rv_monitor_def into struct rv_monitor")
Signed-off-by: Zhen Ni <zhen.ni@easystack.cn>
---
 kernel/trace/rv/rv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 1482e91c39f4..e35565dd2dc5 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -805,7 +805,7 @@ int rv_register_monitor(struct rv_monitor *monitor, struct rv_monitor *parent)
 
 	retval = create_monitor_dir(monitor, parent);
 	if (retval)
-		return retval;
+		goto out_unlock;
 
 	/* keep children close to the parent for easier visualisation */
 	if (parent)
-- 
2.20.1

