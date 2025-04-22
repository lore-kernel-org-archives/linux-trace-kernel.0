Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39D4B15B115;
	Tue, 22 Apr 2025 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745308169; cv=none; b=KjlsxZfc9KjpRtwHPKLxwoFXP0JnzyZP7Hw6lu2H9zHpjKxlea0HeqW4cbKIopr3Fz8JTefLQInL8UyfYpA/Bm1mQWhbYOCsvJeWdYqtqL+v2KRb9jLiWmXblBLMSPq7ySY1sQF7r7bKAsNKytSUDfVDgu6IXrPKwfvXWCjiycc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745308169; c=relaxed/simple;
	bh=88lOgi3xu7hzqGNyHhhR9o/AIcemv5r5pdFBgOamQyI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XW43XO/OtwEvJrEn+Pfv5BuFVVJChhnhCUgHj1ywNownZbg7Y9bIebu1EoWXG695XSH789yU7+ix550iiAvYYonzvqNYaHSJADAKynliu3X3hpD1o3WjFnznT8k7Rb5xWMqrK3jJn/Pml0xIE0aqr6oEHrcE2DuV5Uua2HT0jQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [113.200.148.30])
	by gateway (Coremail) with SMTP id _____8AxaeH+SQdoIeHDAA--.18636S3;
	Tue, 22 Apr 2025 15:49:18 +0800 (CST)
Received: from linux.localdomain (unknown [113.200.148.30])
	by front1 (Coremail) with SMTP id qMiowMDx_MT9SQdoWaGPAA--.27089S2;
	Tue, 22 Apr 2025 15:49:18 +0800 (CST)
From: Tiezhu Yang <yangtiezhu@loongson.cn>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: loongarch@lists.linux.dev,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rtla: Define __NR_sched_setattr for LoongArch
Date: Tue, 22 Apr 2025 15:49:17 +0800
Message-ID: <20250422074917.25771-1-yangtiezhu@loongson.cn>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:qMiowMDx_MT9SQdoWaGPAA--.27089S2
X-CM-SenderInfo: p1dqw3xlh2x3gn0dqz5rrqw2lrqou0/
X-Coremail-Antispam: 1Uk129KBj9xXoW7XFy3Xr1fWrWxZFW7JryUtwc_yoWfGwb_tr
	yxAw17Xr95CrWUtwnrXFW5CF1fWay3ZF4v93Z7trZruF15KFy5XFs0kr98WF1Ykr4qyF9r
	Gws3tr1ruw4YkosvyTuYvTs0mTUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUb7xYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	W8JVWxJwA2z4x0Y4vEx4A2jsIE14v26F4UJVW0owA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
	Cr1j6rxdM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
	8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AK
	xVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41l42xK82IYc2Ij64
	vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8G
	jcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r126r1DMIIYrxkI7VAKI48JMIIF0xvE2I
	x0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14v26r1j6r4UMIIF0xvE42xK
	8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8JwCI42IY6I8E87Iv6xkF7I
	0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x07j0FALUUUUU=

When executing "make -C tools/tracing/rtla" on LoongArch, there exists
the following error:

  src/utils.c:237:24: error: '__NR_sched_setattr' undeclared

Just define __NR_sched_setattr for LoongArch if not exist.

Reported-by: Haiyong Sun <sunhaiyong@loongson.cn>
Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
---
 tools/tracing/rtla/src/utils.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/tracing/rtla/src/utils.c b/tools/tracing/rtla/src/utils.c
index 4995d35cf3ec..d6ab15dcb490 100644
--- a/tools/tracing/rtla/src/utils.c
+++ b/tools/tracing/rtla/src/utils.c
@@ -227,6 +227,8 @@ long parse_ns_duration(char *val)
 #  define __NR_sched_setattr	355
 # elif __s390x__
 #  define __NR_sched_setattr	345
+# elif __loongarch__
+#  define __NR_sched_setattr	274
 # endif
 #endif
 
-- 
2.42.0

