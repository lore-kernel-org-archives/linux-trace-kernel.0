Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B1F38238B;
	Mon, 25 May 2026 13:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779715401; cv=none; b=rDillyl0AsLL7SHCluuJOAuh9DNUhnVedH+TBjSz82+CnJpNC+aMgVBtDZ+azXn0Of93ft0I79hnnFKAk/KTQLmJng1chClPjb8m4EhlKX6dW7Po+vsWd4fJRPUYkw/vYxsSE9qMnhqCM+N8sOU4d+fzrmBqH0g7GTawVgla7q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779715401; c=relaxed/simple;
	bh=1I/gLeG//iVs5evl8uZ+zZziK9mips3URDdHMvPSyss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qBlPIqsG5joT3motrtDw3Cai3iZqCdL0bM7DY4TJC2nUHEe8HCTh1gQB9lJRh3h3sKGUhzirW6RBl8XtMA0WvjIFvJEQy6ewg177DSmQiItQn2vM3sf0TOHGyGpUNRxqiDyOMra4PREUhj1+z3EQCZ3Y7I/vxTc6tSZYNoW6gNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.198])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gPGls0pQWzKHLvR;
	Mon, 25 May 2026 21:23:05 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 95A6440561;
	Mon, 25 May 2026 21:23:16 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP3 (Coremail) with SMTP id _Ch0CgAnhy8uTRRqZS0kDg--.6432S2;
	Mon, 25 May 2026 21:23:16 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH] rethook: Use tsk->on_cpu to check task execution state
Date: Mon, 25 May 2026 21:22:53 +0800
Message-Id: <20260525132253.1889726-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgAnhy8uTRRqZS0kDg--.6432S2
X-Coremail-Antispam: 1UD129KBjvdXoWrKr1UJryrJFWruF1xWF1kGrg_yoW3Kwc_ua
	10gFs29FnxA3ZFqw13u3yxXry0qa9YgFyvk3WxJrWDCw1UGF1Yqan5JFn3CFs8XF9I9F9a
	9FnIgwn7G3WrZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4xFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j
	6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oV
	Cq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0
	I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r
	4UM4x0Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWU
	AVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14
	v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkG
	c2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI
	0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4U
	MIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

When a task calls schedule() to yield the CPU, its state remains
TASK_RUNNING, but its stack is frozen and safe to walk.

Replace task_is_running(tsk) with tsk->on_cpu to avoid overly
conservative rejections.

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
 kernel/trace/rethook.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 5a8bdf88999a..bd5e5f455e85 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -250,7 +250,7 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
 	if (WARN_ON_ONCE(!cur))
 		return 0;
 
-	if (tsk != current && task_is_running(tsk))
+	if (tsk != current && tsk->on_cpu)
 		return 0;
 
 	do {
-- 
2.34.1

