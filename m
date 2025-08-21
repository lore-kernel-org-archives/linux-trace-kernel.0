Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA772246786;
	Thu, 21 Aug 2025 07:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755760496; cv=none; b=XMFyDWvGRR+xxqU0QdMhGsKs+d7xz4kwIAO9XxANCKN1Wocbt4TnMUkF6hFN3abSVScbIo9GkyqZQfVYHfLl7r3CiBvQ2hOBLt7NvIq7BAHKxL0C0Vl0VXrrtXbHWEExhfcnKxUKFwjJf9k+cd1XrxiNH6eZOCfmaJljFZbtJxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755760496; c=relaxed/simple;
	bh=NqCENmEVfUXXxHawVcKeQSrD5jWM+cjvxrnkE33kh4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=V2aWtUrk8TWgv8mj14w6dXXGR/NngR9wWcfdm+xLQuXsCHz+Ckv2zwqInePGlo17c48z9EDiO92mVvmGgI8H4uEOBbK+pN+M4aR6UV0LjeyhwZFxkBe77GlTMq1D8e2P9o7hAGVojvEefplYomfhAYyQ4X6LuiOKraMUoCUKpc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4c6vhp4mwRzKHNFH;
	Thu, 21 Aug 2025 15:14:50 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 2706E1A1968;
	Thu, 21 Aug 2025 15:14:50 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgDXng9mx6Zo2+2lEQ--.46218S2;
	Thu, 21 Aug 2025 15:14:48 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	pulehui@huawei.com
Subject: [PATCH] tracing: Fix missing errno when zero parser->idx in trace_pid_write
Date: Thu, 21 Aug 2025 07:17:21 +0000
Message-Id: <20250821071721.3609109-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXng9mx6Zo2+2lEQ--.46218S2
X-Coremail-Antispam: 1UD129KBjvJXoW7AFyDJrWrXF18Gw1rJr43KFg_yoW8WrWrpF
	1akF93JryrJF4jya18XF4kuFyxG3s5XryxCFs8G34rXa42yrWqgwsrAasxX3WfKrWUGFWf
	J3yjyrZ8KFZFvaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxU7IJmUUUUU
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When trace_get_user in trace_pid_write parses an only space, the
!trace_parser_loaded branch will break with no errno, causing
tr->filtered_pids to still be assigned with pid_list, which may trigger
potential problems.

This patch will also silence the fault injection syzkaller warning in
tracepoint_add_func [0]. We can reproduce the warning by following the
steps below:
1. echo 8 >> set_event_notrace_pid. Let tr->filtered_pids owns one pid
   and register sched_switch tracepoint.
2. echo ' ' >> set_event_pid, and perform fault injection during chunk
   allocation of trace_pid_list_alloc. Let pid_list with no pid and
assign to tr->filtered_pids.
3. echo ' ' >> set_event_pid. Let pid_list is NULL and assign to
   tr->filtered_pids.
4. echo 9 >> set_event_pid, will trigger the double register
   sched_switch tracepoint warning.

Link: https://lore.kernel.org/all/67cb890e.050a0220.d8275.022e.GAE@google.com [0]
Fixes: b27f266f74fb ("tracing: Fix return value of trace_pid_write()")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 8d8935ed416d..feeb7eb71318 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -853,10 +853,10 @@ int trace_pid_write(struct trace_pid_list *filtered_pids,
 		ubuf += ret;
 		cnt -= ret;
 
+		ret = -EINVAL;
 		if (!trace_parser_loaded(&parser))
 			break;
 
-		ret = -EINVAL;
 		if (kstrtoul(parser.buffer, 0, &val))
 			break;
 
-- 
2.34.1

