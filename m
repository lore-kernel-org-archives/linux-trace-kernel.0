Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276503214;
	Sat, 24 Aug 2024 03:02:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724468529; cv=none; b=YgyR8B1I3dZ+UbFG6TsWROr3ic14SYBODdD3InUOEocyYr79XI8VAz1RFRw0jTASV00fkR8R8ixwPu1WFJevsKmMY3h1dheh4ebjWL4OFliKglJ9C9cSlSkpz64B30mQERP3mjUjl/SanGayXCH+t69kzTJtMAakmr6H+8DN94s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724468529; c=relaxed/simple;
	bh=aCsaSC5Z9DMCz/A4HHJPPM1jYcII5yyYNMMM1ZfCP3Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=VTD4qWwcKuNDKXetkSpDhlKM0tIAh48MI9bRfjqSdJ0nxx9ThWSXnu1l9RknzzW5sGmkuHq7/hel30AoGwdk6vrAwSwZ8+iPzCPDyZ3kd/klhSMKb1mdiiLCBhx3S+b5Qk8xR23eScRM7dC1JZU9Pxdnn8S0BR221iFq3H9x6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.235])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WrMD10HVWz4f3jM1;
	Sat, 24 Aug 2024 11:01:53 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id C969E1A058E;
	Sat, 24 Aug 2024 11:02:02 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgCH_IIkTclmQGszCg--.18290S2;
	Sat, 24 Aug 2024 11:02:02 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	zhengyejian@huaweicloud.com
Subject: [PATCH] tracing: Mitigate possible softlockup in __tracing_open()
Date: Sat, 24 Aug 2024 11:03:43 +0800
Message-Id: <20240824030343.3218618-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgCH_IIkTclmQGszCg--.18290S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw45Zw43XFyDAF18Ww15Arb_yoW8GrWfpF
	4aqrZrKwsrJw45Jws7AF18uFy5Z3s3Ja47GayUC3WrZryUGr1aqF90ga13tF47ArWfK343
	trWYkw1DWryjvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUSNtxUUU
	UU=
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

In __tracing_open(), when max latency tracers took place on the cpu,
the time start of its buffer would be updated, then event entries with
timestamps being earlier than start of the buffer would be skipped
(see tracing_iter_reset()).

Softlockup will occur if the kernel is non-preemptible and too many
entries were skipped in the loop that reset every cpu buffer, so add
cond_resched() to avoid it.

Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 kernel/trace/trace.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebe7ce2f5f4a..88faa95b457b 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -4706,6 +4706,15 @@ __tracing_open(struct inode *inode, struct file *file, bool snapshot)
 		for_each_tracing_cpu(cpu) {
 			ring_buffer_read_start(iter->buffer_iter[cpu]);
 			tracing_iter_reset(iter, cpu);
+			/*
+			 * When max latency tracers took place on the cpu, the time start
+			 * of its buffer would be updated, then event entries with timestamps
+			 * being earlier than start of the buffer would be skipped
+			 * (see tracing_iter_reset()). Softlockup will occur if the kernel
+			 * is non-preemptible and too many entries were skipped in the loop,
+			 * so add cond_resched() to mitigate it.
+			 */
+			cond_resched();
 		}
 	} else {
 		cpu = iter->cpu_file;
-- 
2.25.1

