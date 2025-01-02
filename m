Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D15D326ACB;
	Thu,  2 Jan 2025 17:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735839819; cv=none; b=dprvIxJ4YPTn2s399J07l0hQXR9RurW7HIEdyAE5ufZ6Zq5Jh67Fgz0GJu6djNPhELaxTye6tzoGft1MhYGy4KbZDii6CiYD7+YWH7cvj4pWj0ekGftcSbc8n1t4owGztAOmJTilsHgKrJTgddBS4CuCk6duwWB6l3MO9YH3KUY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735839819; c=relaxed/simple;
	bh=Iiq5ZbIBdxDWMYnSayWggD6SAmJu62Rt8houfgA0Ra8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tCZcYjMTR93C4j9Ukkpw5/c6xTr9RMTsoRype3Aijnqjudhc9LzpmG+SGycLMb20LJyicUprZN5mwUe1igLisFzi4s+cjvClyBKHBU/sc/2M/sCDHzfojOMfsqUKhYac4RyXpB/ai01IJQfaBrCIacY4pZfTk0CQ4zICryX7/eM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4YPDTv0SBvz6K9j9;
	Fri,  3 Jan 2025 01:39:15 +0800 (CST)
Received: from frapeml500007.china.huawei.com (unknown [7.182.85.172])
	by mail.maildlp.com (Postfix) with ESMTPS id 5816F140B33;
	Fri,  3 Jan 2025 01:43:34 +0800 (CST)
Received: from P_UKIT01-A7bmah.china.huawei.com (10.48.151.50) by
 frapeml500007.china.huawei.com (7.182.85.172) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 2 Jan 2025 18:43:33 +0100
From: <shiju.jose@huawei.com>
To: <rostedt@goodmis.org>, <mhiramat@kernel.org>,
	<mathieu.desnoyers@efficios.com>, <linux-trace-kernel@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
CC: <linuxarm@huawei.com>, <jonathan.cameron@huawei.com>,
	<tanxiaofei@huawei.com>, <prime.zeng@hisilicon.com>, <shiju.jose@huawei.com>
Subject: [PATCH 1/1] tracing: Support reading trace event format file larger than PAGE_SIZE
Date: Thu, 2 Jan 2025 17:43:17 +0000
Message-ID: <20250102174317.1594-1-shiju.jose@huawei.com>
X-Mailer: git-send-email 2.43.0.windows.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 frapeml500007.china.huawei.com (7.182.85.172)

From: Shiju Jose <shiju.jose@huawei.com>

When userspace reads a trace event format file, the maximum data size
that can be read is limited to PAGE_SIZE by the seq_read() and
seq_read_iter() functions. This results in userspace receiving partial
data if the format file is larger than PAGE_SIZE, requiring a workaround
to read the complete data from the format file.

Add support for reading trace event format files larger than PAGE_SIZE when
needed by userspace.

Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
---
 kernel/trace/trace_events.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 1545cc8b49d0..ef33614e7f22 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -1801,6 +1801,36 @@ static int trace_format_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/**
+ *      trace_format_read - read() method for format file.
+ *      @file: the file to read from
+ *      @buf: the buffer to read to
+ *      @size: the maximum number of bytes to read
+ *      @ppos: the current position in the file
+ *
+ *  * Return:
+ *  * %0  - No bytes copied (EOF).
+ *  * %>0 - Number of bytes copied.
+ *  * %<0 - Error code.
+ */
+static ssize_t trace_format_read(struct file *file, char __user *buf, size_t size, loff_t *ppos)
+{
+	ssize_t copied = 0;
+	ssize_t ret;
+
+	do {
+		ret = seq_read(file, buf + copied, size - copied, ppos);
+		if (ret < 0)
+			return ret;
+
+		copied += ret;
+		if (copied >= size)
+			break;
+	} while (ret);
+
+	return copied;
+}
+
 #ifdef CONFIG_PERF_EVENTS
 static ssize_t
 event_id_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppos)
@@ -2284,7 +2314,7 @@ static const struct file_operations ftrace_enable_fops = {
 
 static const struct file_operations ftrace_event_format_fops = {
 	.open = trace_format_open,
-	.read = seq_read,
+	.read = trace_format_read,
 	.llseek = seq_lseek,
 	.release = seq_release,
 };
-- 
2.43.0

