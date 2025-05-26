Received: from dggsgout11.his.huawei.com (dggsgout11.his.huawei.com [45.249.212.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9A93594B;
	Mon, 26 May 2025 01:47:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748224082; cv=none; b=ur/osDXSR85SD/mIfxumObEF022WN1AW9Q+D+jwHbbrwM8dORwC7X0UcLEUdCxxc9C6i5jkS5cJVJwLkEOPOIb6h7vUQ08l0ecbeJSU2DjyduM/YVqjv4yQkyCRpJ4LGdMAfcR/MW7eHjdHi7inv1jltIG2cqApv1iP4EZbFxBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748224082; c=relaxed/simple;
	bh=EK5+g2KRPgs09M5g0IkpysmjiVXyuNapUrxE2vvMBss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uJeRcOIk+JWdq9SX5yinTa7Nxjh/M8ygOJ4glLJpk2GWxyugAs3kkNE1zzTX+ttt63QAjjuObWbaCXnUkeZlWm5KChhm2k/Lg1e6KpmyHX8n6hsRfGVR2m0/0Iez8m/Z3aNwBShDeXcaSHDGhuhpzXsu16nrjCOkUxQZsIm1J28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.93.142])
	by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4b5JYG1LtYz4f3kvp;
	Mon, 26 May 2025 09:47:30 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E3E801A07BD;
	Mon, 26 May 2025 09:47:56 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.95])
	by APP2 (Coremail) with SMTP id Syh0CgC3c2ZLyDNo8e+uNQ--.34254S2;
	Mon, 26 May 2025 09:47:56 +0800 (CST)
From: Pan Taixi <pantaixi@huaweicloud.com>
To: pantaixi1@huawei.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	aha310510@gmail.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: yeweihua4@huawei.com
Subject: [PATCH] tracing: Fix compilation warning on arm32
Date: Mon, 26 May 2025 09:37:31 +0800
Message-Id: <20250526013731.1198030-1-pantaixi@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:Syh0CgC3c2ZLyDNo8e+uNQ--.34254S2
X-Coremail-Antispam: 1UD129KBjvJXoW7ZryDKFyUCr4fXr13Zr4fZrb_yoW8XrW8pF
	1xGrnrG3yUGr42ka4xWF10934xGwnrG347Gan3Gw1fX34DtFyagrZ2gFy2qa1FgrZIk342
	kr129398Kw4UuaDanT9S1TB71UUUUUDqnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUyKb4IE77IF4wAFF20E14v26r4j6ryUM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Ar0_tr1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcxkI7VAKI48JMxkF7I0En4kS14v26r1q6r43MxAIw28IcxkI
	7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxV
	Cjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY
	6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6x
	AIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY
	1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjxUF1v3UUUUU
X-CM-SenderInfo: xsdq3thl0lqx5xdzvxpfor3voofrz/

On arm32, size_t is defined to be unsigned int, while PAGE_SIZE is
unsigned long. This hence triggers a compilation warning as min()
asserts the type of two operands to be equal. Casting PAGE_SIZE to size_t
solves this issue and works on other target architectures as well.

Compilation warning details:

kernel/trace/trace.c: In function 'tracing_splice_read_pipe':
./include/linux/minmax.h:20:28: warning: comparison of distinct pointer types lacks a cast
  (!!(sizeof((typeof(x) *)1 == (typeof(y) *)1)))
                            ^
./include/linux/minmax.h:26:4: note: in expansion of macro '__typecheck'
   (__typecheck(x, y) && __no_side_effects(x, y))
    ^~~~~~~~~~~

...

kernel/trace/trace.c:6771:8: note: in expansion of macro 'min'
        min((size_t)trace_seq_used(&iter->seq),
        ^~~

Fixes: f5178c41bb43 ("tracing: Fix oob write in trace_seq_to_buffer()")
Signed-off-by: Pan Taixi <pantaixi@huaweicloud.com>
---
 kernel/trace/trace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 5b8db27fb6ef..766cb3cd254e 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6824,7 +6824,7 @@ static ssize_t tracing_splice_read_pipe(struct file *filp,
 		ret = trace_seq_to_buffer(&iter->seq,
 					  page_address(spd.pages[i]),
 					  min((size_t)trace_seq_used(&iter->seq),
-						  PAGE_SIZE));
+						  (size_t)PAGE_SIZE));
 		if (ret < 0) {
 			__free_page(spd.pages[i]);
 			break;
-- 
2.34.1

