Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4BA1A01C4;
	Tue, 27 Aug 2024 12:45:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724762717; cv=none; b=P9fVN25oCADAW0yzGsFf3raFKQKccpLOqDWnDqPQkPp0/RTgQhEmqUEGKGi8e4qO1lD1eaKBcQ5iLsBinpavG0kcE/hWI7U8vpZPgMoLVEjL0s4v8xcyCDWp2S3ORGuGYpmvWQ6uilt2AFIn5xCm212FgEbWdy7+VhGJ8NHXU0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724762717; c=relaxed/simple;
	bh=ayBM3X9Waua/pT1URpHpdU3JoUSS/LRmAK2G4r7r43s=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uu7VgIpx7TKpRpt5IJDYsZZf83edmKrIprNNYr5x/bF5wNQXwphfGAKVTeWrMMB/Yi8eF86MDUGjupQGgbfdUKebd0kIHBrquOOZxYSJBCn4uSFjdLD9BW4V0p07uw5yL/Xb9fUBFBcLx02hBBqbGpHtJLcJFnfhx/qhk5b+Ob8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4WtS1S6gV1z4f3kKt;
	Tue, 27 Aug 2024 20:45:00 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id D5B8E1A1322;
	Tue, 27 Aug 2024 20:45:10 +0800 (CST)
Received: from localhost.localdomain (unknown [10.67.175.61])
	by APP4 (Coremail) with SMTP id gCh0CgDX_oRPys1mVyF3Cw--.61313S2;
	Tue, 27 Aug 2024 20:45:09 +0800 (CST)
From: Zheng Yejian <zhengyejian@huaweicloud.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	zhengyejian@huaweicloud.com
Subject: [PATCH v2] tracing: Avoid possible softlockup in tracing_iter_reset()
Date: Tue, 27 Aug 2024 20:46:54 +0800
Message-Id: <20240827124654.3817443-1-zhengyejian@huaweicloud.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240827075241.5cd652ae@rorschach.local.home>
References: <20240827075241.5cd652ae@rorschach.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDX_oRPys1mVyF3Cw--.61313S2
X-Coremail-Antispam: 1UD129KBjvJXoW7tw45Zw43XFyDCr48Zw4UXFb_yoW8Gry8pF
	43XrWDKw47Ww45t397CF1fuF9rZ395tFy7GFWDCw4rZF9rCF13XrZ2gF4aqF47ZrZ3KryS
	yrZ2kw4qg34jvFJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkC14x267AKxVWUJVW8JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26ryj6F1UM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4UJbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: x2kh0w51hmxt3q6k3tpzhluzxrxghudrp/

In __tracing_open(), when max latency tracers took place on the cpu,
the time start of its buffer would be updated, then event entries with
timestamps being earlier than start of the buffer would be skipped
(see tracing_iter_reset()).

Softlockup will occur if the kernel is non-preemptible and too many
entries were skipped in the loop that reset every cpu buffer, so add
cond_resched() to avoid it.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Zheng Yejian <zhengyejian@huaweicloud.com>
---
 kernel/trace/trace.c | 2 ++
 1 file changed, 2 insertions(+)

v2:
  - Change to add cond_resched() in tracing_iter_reset()
    Link: https://lore.kernel.org/all/20240826103522.390faa85@gandalf.local.home/
  - Update commit title and add suggested-by tag

v1: https://lore.kernel.org/all/20240824030343.3218618-1-zhengyejian@huaweicloud.com/

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index ebe7ce2f5f4a..edf6bc817aa1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3958,6 +3958,8 @@ void tracing_iter_reset(struct trace_iterator *iter, int cpu)
 			break;
 		entries++;
 		ring_buffer_iter_advance(buf_iter);
+		/* This could be a big loop */
+		cond_resched();
 	}
 
 	per_cpu_ptr(iter->array_buffer->data, cpu)->skipped_entries = entries;
-- 
2.25.1

