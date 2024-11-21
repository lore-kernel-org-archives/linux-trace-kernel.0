Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF7223098E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 21 Nov 2024 02:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732154780; cv=none; b=Ye82/7kqxFq2Wg9ybYAwhndXLn3zBTkBZ1xSEdGaqrB7v6YmZ+RzmTUQI14MALNfw+ySnu3fRnblvsuoTW00RTnuylcnPC+M+iCPQXI8Kd/gAfFlH+YiSiYwck0r9GMG8MkxRd01Jyi3z+CCUDEWXZQgcWoo7WXrtO8oEOyy/g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732154780; c=relaxed/simple;
	bh=sRjCvfHv9bf1GeJPCBSha6df0l3RJi0IhSI/AbIG3zk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aXoAhYI4tOVVrdOOTQlNA36pyneOPCTnf1U7+AHyySMEfZ+r8/H83fteVuPTWfaDoqe5+sjM5c2JUbCa/1/ez1JicpOGzzDEz3ME1Q/APwYtuwHvLPqOH7k0rCgjktEGLt7GQzpV0H83dDpq8qVRjK76m4AS7u+KkPWCmtfW78k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xv1j31cpZz10S5G;
	Thu, 21 Nov 2024 10:03:03 +0800 (CST)
Received: from kwepemd100024.china.huawei.com (unknown [7.221.188.41])
	by mail.maildlp.com (Postfix) with ESMTPS id 9609A18009E;
	Thu, 21 Nov 2024 10:05:42 +0800 (CST)
Received: from ubuntu-20-04.huawei.com (10.175.103.91) by
 kwepemd100024.china.huawei.com (7.221.188.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 21 Nov 2024 10:05:41 +0800
From: Wei Li <liwei391@huawei.com>
To: <linux-trace-kernel@vger.kernel.org>
CC: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
	<mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	<xiexiuqi@huawei.com>
Subject: [PATCH v2 1/2] tracing: Allow custom read/write processing in trace_min_max_{write,read}()
Date: Thu, 21 Nov 2024 10:18:22 +0800
Message-ID: <20241121021823.1237741-2-liwei391@huawei.com>
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

The 'trace_min_max_fops' implements a generic function to read/write u64
values from tracefs, add support of custom read/write processing to allow
special requirements.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 kernel/trace/trace.c | 13 ++++++++++---
 kernel/trace/trace.h |  2 ++
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 2b64b3ec67d9..ab5ea6d7148c 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -7689,8 +7689,12 @@ trace_min_max_write(struct file *filp, const char __user *ubuf, size_t cnt, loff
 	if (param->max && val > *param->max)
 		err = -EINVAL;
 
-	if (!err)
-		*param->val = val;
+	if (!err) {
+		if (unlikely(param->write))
+			param->write(param->val, val);
+		else
+			*param->val = val;
+	}
 
 	if (param->lock)
 		mutex_unlock(param->lock);
@@ -7723,7 +7727,10 @@ trace_min_max_read(struct file *filp, char __user *ubuf, size_t cnt, loff_t *ppo
 	if (!param)
 		return -EFAULT;
 
-	val = *param->val;
+	if (unlikely(param->read))
+		val = param->read(param->val);
+	else
+		val = *param->val;
 
 	if (cnt > sizeof(buf))
 		cnt = sizeof(buf);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index c866991b9c78..2aaf3030c466 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2159,6 +2159,8 @@ static inline void sanitize_event_name(char *name)
 struct trace_min_max_param {
 	struct mutex	*lock;
 	u64		*val;
+	u64		(*read)(u64 *val);
+	void		(*write)(u64 *val, u64 data);
 	u64		*min;
 	u64		*max;
 };
-- 
2.25.1

