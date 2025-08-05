Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CCF0263F3C;
	Tue,  5 Aug 2025 15:08:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754406529; cv=none; b=W3iEn8ioI4BuKE+SI85/5Fx1fHWhaYye25vNSXjgqlFbJsT1LWhSBeFskU5yr033a0YYvnB1NRCeXDoR1a0P8XE8kZT01buj69C7xQyXBY9K4ZL46gQjkBZDBNMVAHXwYXAohpAaPnuppfxNRxMV/itAuonTwiwvPmfsO5OcZYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754406529; c=relaxed/simple;
	bh=hVcRW6KSa8Yn5WCJUu+xD2ZgiFj6m51RMmFzdtyVAwg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=idxaTql4Wyx6BoiIO4igJiMJFicA+g5npNQuFIvSqb9qT/qgJBV0m6RDChjmhxxAtOFL69+iFk8vTVnkZV2WsIlqrv4CKm0VbThXtyqOPjNPXi1bxaadEEuBZ8zaOfq+kLxG0imtLQrySdGEY5FmdWHUOYORHkwvgZQxfmyOhZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4bxGyx6TpQzKHMpF;
	Tue,  5 Aug 2025 23:08:41 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id EB4201A07BB;
	Tue,  5 Aug 2025 23:08:40 +0800 (CST)
Received: from ultra.huawei.com (unknown [10.90.53.71])
	by APP4 (Coremail) with SMTP id gCh0CgCHTg93HpJoQamsCg--.10744S2;
	Tue, 05 Aug 2025 23:08:40 +0800 (CST)
From: Pu Lehui <pulehui@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Zero-initialize parser->buffer to avoid OOB access
Date: Tue,  5 Aug 2025 15:12:03 +0000
Message-Id: <20250805151203.1214790-1-pulehui@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCHTg93HpJoQamsCg--.10744S2
X-Coremail-Antispam: 1UD129KBjvJXoW7Ar4UCryfuF4kury5Gw1rZwb_yoW8Kw4kpF
	WfKrs7Gw4qgF4IvFs5Zr10qa4kXan8GrW7GFs7JryYqa9xKF1j9rZrCrnrWw1fCryrJryY
	yFy8K3yUKr1DZaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyEb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU80fO7UUUUU==
X-CM-SenderInfo: psxovxtxl6x35dzhxuhorxvhhfrp/

From: Pu Lehui <pulehui@huawei.com>

When the length of the string written to set_ftrace_filter exceeds
FTRACE_BUFF_MAX, the following KASAN alarm will be triggered:

BUG: KASAN: slab-out-of-bounds in strsep+0x18c/0x1b0
Read of size 1 at addr ffff0000d00bd5ba by task ash/165

CPU: 1 UID: 0 PID: 165 Comm: ash Not tainted 6.16.0-g6bcdbd62bd56-dirty #3 NONE
Hardware name: linux,dummy-virt (DT)
Call trace:
 show_stack+0x34/0x50 (C)
 dump_stack_lvl+0xa0/0x158
 print_address_description.constprop.0+0x88/0x398
 print_report+0xb0/0x280
 kasan_report+0xa4/0xf0
 __asan_report_load1_noabort+0x20/0x30
 strsep+0x18c/0x1b0
 ftrace_process_regex.isra.0+0x100/0x2d8
 ftrace_regex_release+0x484/0x618
 __fput+0x364/0xa58
 ____fput+0x28/0x40
 task_work_run+0x154/0x278
 do_notify_resume+0x1f0/0x220
 el0_svc+0xec/0xf0
 el0t_64_sync_handler+0xa0/0xe8
 el0t_64_sync+0x1ac/0x1b0

The reason is that trace_get_user will fail when processing a string
longer than FTRACE_BUFF_MAX, but not set the end of parser->buffer
to 0. Then an oob access will be triggered in ftrace_regex_release->
ftrace_process_regex->strsep->strpbrk. We can solve this problem by
zero-initializing parser->buffer.

Fixes: 8c9af478c06b ("ftrace: Handle commands when closing set_ftrace_filter file")
Signed-off-by: Pu Lehui <pulehui@huawei.com>
---
 kernel/trace/trace.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 4283ed4e8f59..97e66cbd3617 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1776,7 +1776,7 @@ int trace_parser_get_init(struct trace_parser *parser, int size)
 {
 	memset(parser, 0, sizeof(*parser));
 
-	parser->buffer = kmalloc(size, GFP_KERNEL);
+	parser->buffer = kzalloc(size, GFP_KERNEL);
 	if (!parser->buffer)
 		return 1;
 
@@ -1860,13 +1860,10 @@ int trace_get_user(struct trace_parser *parser, const char __user *ubuf,
 
 	/* We either got finished input or we have to wait for another call. */
 	if (isspace(ch) || !ch) {
-		parser->buffer[parser->idx] = 0;
 		parser->cont = false;
 	} else if (parser->idx < parser->size - 1) {
 		parser->cont = true;
 		parser->buffer[parser->idx++] = ch;
-		/* Make sure the parsed string always terminates with '\0'. */
-		parser->buffer[parser->idx] = 0;
 	} else {
 		return -EINVAL;
 	}
-- 
2.34.1

