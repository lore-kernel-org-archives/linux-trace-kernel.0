Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A4F23098E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732154777; cv=none; b=RXa3CuoFiE/+rbld0ngopTo+5uFrJOiqEda9PL1GE0vaYqYLKwM1iu7G0nC+vaRKug/p9Y8M383tUN89By2Yu9oVZcDhByyrJUK30r7m6DPBSa5eqQXAi4+mHJy2uZSIkmFJ5FaJdhA7slm9LYct11eU3CwrU7BMwjHv/dPV21c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732154777; c=relaxed/simple;
	bh=Bqgr8MuHn3y9rge2LPtA6rsqjdrs/1DbrBE+peqWo7s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hy8pkvdNnf0xIBXtzEpkRY8HWqXeCtr78eLIs6AdWm1BRq2EQ4Bwhgy2kAwwACcgQU4UqjljKXMlv2YFwKWqnUDy09qObU6kIPfhivrDDoNZr+3DDP/avwWrBFHwdVv3jQsogEHkfzy/JI47/2/kZ5jOtV2SsZKkgG7VHasiEwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Xv1kX27XQz21lX2;
	Thu, 21 Nov 2024 10:04:20 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 229031A016C;
	Thu, 21 Nov 2024 10:05:43 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Nov 2024 10:05:42 +0800
From: Wei Li <liwei391@huawei.com>
To: <linux-trace-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<xiexiuqi@huawei.com>
Subject: [PATCH v2 2/2] tracing/hwlat: Fix deadlock in cpuhp processing
Date: Thu, 21 Nov 2024 10:18:23 +0800
Message-ID: <20241121021823.1237741-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241121021823.1237741-1-liwei391@huawei.com>
References: <20241121021823.1237741-1-liwei391@huawei.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd100024.china.huawei.com (7.221.188.41)

One "hung task" error was reported during the test, and i figured out
the deadlock scenario is as follows:

T1 [BP]               | T2 [AP]                     | T3 [hwlatd/1]                  | T4
work_for_cpu_fn()     | cpuhp_thread_fun()          | kthread_fn()                   | hwlat_hotplug_workfn()
  _cpu_down()         |   stop_cpu_kthread()        |                                |   mutex_lock(&hwlat_data.lock)
    cpus_write_lock() |     kthread_stop(hwlatd/1)  |   mutex_lock(&hwlat_data.lock) |
    __cpuhp_kick_ap() |       wait_for_completion() |                                |   cpus_read_lock()

It constitutes ABBA deadlock indirectly between "cpu_hotplug_lock" and
"hwlat_data.lock", remove the mutex_lock in kthread_fn() to fix this.

Fixes: ba998f7d9531 ("trace/hwlat: Support hotplug operations")
Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/trace_hwlat.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 3bd6071441ad..7d50b5ea999a 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -108,6 +108,7 @@ static struct hwlat_data {
 
 	u64	sample_window;		/* total sampling window (on+off) */
 	u64	sample_width;		/* active sampling portion of window */
+	u64	sample_interval;	/* sample_window - sample_width */
 
 	int	thread_mode;		/* thread mode */
 
@@ -370,10 +371,7 @@ static int kthread_fn(void *data)
 		get_sample();
 		local_irq_enable();
 
-		mutex_lock(&hwlat_data.lock);
-		interval = hwlat_data.sample_window - hwlat_data.sample_width;
-		mutex_unlock(&hwlat_data.lock);
-
+		interval = READ_ONCE(hwlat_data.sample_interval);
 		do_div(interval, USEC_PER_MSEC); /* modifies interval value */
 
 		/* Always sleep for at least 1ms */
@@ -729,6 +727,13 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 	return ret;
 }
 
+static void hwlat_width_window_write(u64 *val, u64 data)
+{
+	*val = data;
+	WRITE_ONCE(hwlat_data.sample_interval,
+		   hwlat_data.sample_window - hwlat_data.sample_width);
+}
+
 /*
  * The width parameter is read/write using the generic trace_min_max_param
  * method. The *val is protected by the hwlat_data lock and is upper
@@ -737,6 +742,7 @@ static ssize_t hwlat_mode_write(struct file *filp, const char __user *ubuf,
 static struct trace_min_max_param hwlat_width = {
 	.lock		= &hwlat_data.lock,
 	.val		= &hwlat_data.sample_width,
+	.write		= &hwlat_width_window_write,
 	.max		= &hwlat_data.sample_window,
 	.min		= NULL,
 };
@@ -749,6 +755,7 @@ static struct trace_min_max_param hwlat_width = {
 static struct trace_min_max_param hwlat_window = {
 	.lock		= &hwlat_data.lock,
 	.val		= &hwlat_data.sample_window,
+	.write		= &hwlat_width_window_write,
 	.max		= NULL,
 	.min		= &hwlat_data.sample_width,
 };
-- 
2.25.1

