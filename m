Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFAB266578;
	Thu, 13 Mar 2025 10:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741863068; cv=none; b=W/9OI+7xFVulpgFfAjGL19u+VXsMcOqjUGvfHpGmImKdqHfO5yy4D3fORSlJ2FSxJ8jPfIUvlUYBkJWxwYDLsgk0jqd6w/wG5k2ogl4ySwmrfcDR3LKgRPlX2nd2GiA49JB1avW0CwXPW7weg7e6q6/HYSQUy8vzMzaau+FOenk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741863068; c=relaxed/simple;
	bh=VlSKajxwCcrAGC2H4wSEe/GQJ2Aq09jTQ6WAdOURlA4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MxpK3LbHL2LlvOv56MvoD+u9b43TdtgXj7POSeHXsKWpJUud56weJwgHgtjn7Y10H2VUIadcq9JylYBfu5qTJ5gfFolv+2DkRujX+05z/f+VcPTEYQ/C/7LrTFDpnM8VwG9SJaaMd0jZIrIhWxQr4uF9mRULTIHhVYHO3TenzFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4ZD46G4ZFDz4f3jYl;
	Thu, 13 Mar 2025 18:50:46 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id B01CC1A0D4C;
	Thu, 13 Mar 2025 18:51:03 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP2 (Coremail) with SMTP id Syh0CgBHUGORuNJn1k9ZGQ--.22745S2;
	Thu, 13 Mar 2025 18:51:03 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Zheng Yejian <zhengyejian1@huawei.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Correct the refcount for hist/hist_debug file if single_open() fails
Date: Thu, 13 Mar 2025 10:37:19 +0000
Message-Id: <20250313103719.1191073-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgBHUGORuNJn1k9ZGQ--.22745S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Aw1kur43JrW8Jr4kJrW3GFg_yoW8CF45pa
	95Jrs8Kr18JF1vg3Z7Aan7u34fC3yktrW7Wa4Du34fJrn8X34FqanrKrW5ZF1YqrZ5XrWj
	va1jgFyjkrWUZaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUGVWUXwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU1yE_tUUUUU==
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The function event_{hist,hist_debug}_open() maintains the refcount of
'file->tr' and 'file' through tracing_open_file_tr(), but it does not
roll back these counts when the subsequent single_open() call fails,
leading to a refcount leak.

A very obvious case is that if the hist/hist_debug file belongs to a
certain instance, the failure of single_open() will prevent the deletion
of that instance, as it relies on the condition 'tr->ref == 1' within
__remove_instance().

Fix this by calling tracing_release_file_tr() to correct the refcount
when single_open() fails.

Fixes: 1cc111b9cddc ("tracing: Fix uaf issue when open the hist or hist_debug file")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
Cc: stable@vger.kernel.org # v6.7+
---
 kernel/trace/trace_events_hist.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index ad7419e24055..900b06fa8505 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -5702,8 +5702,10 @@ static int event_hist_open(struct inode *inode, struct file *file)
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
 	ret = single_open(file, hist_show, hist_file);
-	if (ret)
+	if (ret) {
 		kfree(hist_file);
+		tracing_release_file_tr(inode, file);
+	}
 
 	return ret;
 }
@@ -5979,7 +5981,10 @@ static int event_hist_debug_open(struct inode *inode, struct file *file)
 
 	/* Clear private_data to avoid warning in single_open() */
 	file->private_data = NULL;
-	return single_open(file, hist_debug_show, file);
+	ret = single_open(file, hist_debug_show, file);
+	if (ret)
+		tracing_release_file_tr(inode, file);
+	return ret;
 }
 
 const struct file_operations event_hist_debug_fops = {
-- 
2.34.1

