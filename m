Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6511B81AB6
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Sep 2024 09:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727171626; cv=none; b=OKm0ppRxHlSIXCWwcMmbnZ+gjVPxQJZmsNiHpgpy/A+Hr3fU6yR0CJpxjze53fz1fo1kqnXNCQqkiOlLaFBh1L1X4HQJj2JgDvU58KXpxkuMif+r+THwkFm04mfrzujaIKUyWxsjG5hifufpZbaKfy2/IoTnTbXkG04uhHKVe6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727171626; c=relaxed/simple;
	bh=Lc2e0zRgXM5T4imJ4gDTFpO2qeQWnRCIRERqVJbVRBQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Og1+wriEgu3RJ7QPR7CQ2ag0h+ue7znu6djWmysrPDx0co22ZDXH8ATJQagib48nlVjr7htVEhKgSdKIAoe3UM9D6cWCuqRSTGGIXDfy0V5XuLb1lYoNsDmPtrqS4MIpcf24XKyJ7wvpkBCp0KMpUbH316xdKyhxZ74f27oQR2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4XCZt03Ssmz2QTxJ;
	Tue, 24 Sep 2024 17:52:56 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 4EBAF140119;
	Tue, 24 Sep 2024 17:53:42 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 24 Sep 2024 17:53:41 +0800
From: Wei Li <liwei391@huawei.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Daniel Bristot de Oliveira <bristot@redhat.com>
CC: <linux-trace-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>
Subject: [PATCH 1/5] tracing/timerlat: Fix duplicated kthread creation due to CPU online/offline
Date: Tue, 24 Sep 2024 17:45:11 +0800
Message-ID: <20240924094515.3561410-2-liwei391@huawei.com>
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

osnoise_hotplug_workfn() is the asynchronous online callback for
"trace/osnoise:online". It may be congested when a CPU goes online and
offline repeatedly and is invoked for multiple times after a certain
online.

This will lead to kthread leak and timer corruption. Add a check
in start_kthread() to prevent this situation.

Fixes: c8895e271f79 ("trace/osnoise: Support hotplug operations")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/trace_osnoise.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 7e75c1214b36..934a14bc72e6 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2007,6 +2007,10 @@ static int start_kthread(unsigned int cpu)
 	void *main = osnoise_main;
 	char comm[24];
 
+	/* Do not start a new thread if it is already running */
+	if (per_cpu(per_cpu_osnoise_var, cpu).kthread)
+		return 0;
+
 	if (timerlat_enabled()) {
 		snprintf(comm, 24, "timerlat/%d", cpu);
 		main = timerlat_main;
@@ -2061,11 +2065,10 @@ static int start_per_cpu_kthreads(void)
 		if (cpumask_test_and_clear_cpu(cpu, &kthread_cpumask)) {
 			struct task_struct *kthread;
 
-			kthread = per_cpu(per_cpu_osnoise_var, cpu).kthread;
+			kthread = xchg_relaxed(&(per_cpu(per_cpu_osnoise_var, cpu).kthread), NULL);
 			if (!WARN_ON(!kthread))
 				kthread_stop(kthread);
 		}
-		per_cpu(per_cpu_osnoise_var, cpu).kthread = NULL;
 	}
 
 	for_each_cpu(cpu, current_mask) {
-- 
2.25.1

