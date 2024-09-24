Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E4B154BE0
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:53:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171628; cv=none; b=bGztoIs3Z03ZuH3PriwGAJgZqNY24j71eyN8y7y+hIy1qLGeDp84Z/cYRnydaepUZ3X6zGjTP+gC+W5ghjjfWt/otsaa9cx81WjFtt4CA4e21R1zm1qcqOH7vLIZOLPVAz92eWfizRQbNULFXiY+aplWGK3NTMI4iccsSc403Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171628; c=relaxed/simple;
	bh=uIZTQqwRLlVoS24DHh587irsQCRGnKJbXqjbYpbUsuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RF8L/0CoLDSrnb8ZpqYEPkJf0psVz+1mNbiI3QjfqcGwN7E5LKtiDR1Q3tuEoRuRZy/wKGe3mCiA91rTneW+0xRhhhWYDDz3vJNid/F4DocYmIWhJlbZqZ+GvtIymoQErZL26Q0Rti2PkuPcRzAGhh0k24kaUd1kfKRpVWqNPu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XCZt23F66z2QTxR;
	Tue, 24 Sep 2024 17:52:58 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 47995140119;
	Tue, 24 Sep 2024 17:53:44 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 17:53:43 +0800
From: Wei Li <liwei391@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>
CC: <linux-trace-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>
Subject: [PATCH 4/5] tracing/hwlat: Fix a race during cpuhp processing
Date: Tue, 24 Sep 2024 17:45:14 +0800
Message-ID: <20240924094515.3561410-5-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240924094515.3561410-1-liwei391@huawei.com>
References: <20240924094515.3561410-1-liwei391@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemd100024.china.huawei.com (7.221.188.41)

The cpuhp online/offline processing race also exists in percpu-mode hwlat
tracer in theory, apply the fix too.

Fixes: ba998f7d9531 ("trace/hwlat: Support hotplug operations")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/trace_hwlat.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6536..3bd6071441ad 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -520,6 +520,8 @@ static void hwlat_hotplug_workfn(struct work_struct *dummy)
 	if (!hwlat_busy || hwlat_data.thread_mode != MODE_PER_CPU)
 		goto out_unlock;
 
+	if (!cpu_online(cpu))
+		goto out_unlock;
 	if (!cpumask_test_cpu(cpu, tr->tracing_cpumask))
 		goto out_unlock;
 
-- 
2.25.1

