Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A3C91DE8BE;
	Tue,  9 Jun 2026 00:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966674; cv=none; b=XTdo47xF/oqnaA6lEnZj2mgKwa0Z5nBRzhIdgQlR7uiHGSgM76zQYNHn12rQIwX7OO+Vm/AUVRLfwG5MjhcNUTO3GwZB975/kIkzLW0OOyGapwgIMYKM91oBS30reOfs+e0512yfqaGImx0aEgb1yu9DAeRdDloU/0Q1FOmud8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966674; c=relaxed/simple;
	bh=npk6CJnDFd0uFgUY49NbSbNfAxomh/fyqtAe9L1vnx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=RiTKhKHkCooBt3RmDRw9+co7m/PTRMvQaXe6z0WvX23EOxkwnuNVZicZiSfCSzE3sf+UPl8nlHRJXn/u63msX4dHZKEgl41HskCpZxc1/A7jxiy6XrfKep/3NyWQGxEp1zJVAg11iuuUH7jaC3NTRxYFkIGEevY+PwF0k79/BM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gZ9VK5vvZzKHLyv;
	Tue,  9 Jun 2026 08:57:13 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.128])
	by mail.maildlp.com (Postfix) with ESMTP id 8E00540561;
	Tue,  9 Jun 2026 08:57:48 +0800 (CST)
Received: from huawei.com (unknown [7.197.88.80])
	by APP4 (Coremail) with SMTP id gCh0CgDXK4ABZSdqFaOGBA--.4659S2;
	Tue, 09 Jun 2026 08:57:46 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Alexei Starovoitov <ast@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2] rethook: Remove the running task check in rethook_find_ret_addr()
Date: Tue,  9 Jun 2026 08:57:28 +0800
Message-Id: <20260609005728.458962-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:gCh0CgDXK4ABZSdqFaOGBA--.4659S2
X-Coremail-Antispam: 1UD129KBjvJXoW7WrWxAFyrWrWxWr18Xw4kXrb_yoW8GFW8pF
	4xKwnYkF4qya10yw1qvFs5Z345Zr95Kw13GanrGw1Sy3Z8Jw4DGrya9w4YvF4FgrZIkasI
	vay2yrWqkFsrXFDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUkG14x267AKxVW8JVW5JwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2ocxC64kIII0Yj41l84x0c7CEw4AK67xGY2AK02
	1l84ACjcxK6xIIjxv20xvE14v26w1j6s0DM28EF7xvwVC0I7IYx2IY6xkF7I0E14v26r4U
	JVWxJr1l84ACjcxK6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_Gc
	CE3s1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E
	2Ix0cI8IcVAFwI0_Jr0_Jr4lYx0Ex4A2jsIE14v26r1j6r4UMcvjeVCFs4IE7xkEbVWUJV
	W8JwACjcxG0xvY0x0EwIxGrwACjI8F5VA0II8E6IAqYI8I648v4I1lc7CjxVAaw2AFwI0_
	JF0_Jw1l42xK82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67
	AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v26r1q6r43MIIY
	rxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_Jr0_JF4lIxAIcVC0I7IYx2IY6xkF7I0E14
	v26r1j6r4UMIIF0xvE42xK8VAvwI8IcIk0rVWUJVWUCwCI42IY6I8E87Iv67AKxVWUJVW8
	JwCI42IY6I8E87Iv6xkF7I0E14v26r1j6r4UYxBIdaVFxhVjvjDU0xZFpf9x0JUBVbkUUU
	UU=
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

The current check in rethook_find_ret_addr() prevents obtaining a return
address when the target task is marked as running. However, this condition
is both insufficient for safety and unnecessary for its intended purpose.

The check is inherently racy: a task can begin running on another CPU
immediately after task_is_running() returns false, potentially leading to
concurrent modification of rethook data structures while the iteration is
in progress.

Rather than attempting to fix this unreliable check deep in the unwinding
path, remove it entirely. Callers that require consistency are expected
to provide a safe context.

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Signed-off-by: Tengda Wu <wutengda@huaweicloud.com>
---
v2: Remove the running task check.
v1: https://lore.kernel.org/all/20260525132253.1889726-1-wutengda@huaweicloud.com/

 kernel/trace/rethook.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 5a8bdf88999a..f70f11bc6c91 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -250,9 +250,6 @@ unsigned long rethook_find_ret_addr(struct task_struct *tsk, unsigned long frame
 	if (WARN_ON_ONCE(!cur))
 		return 0;
 
-	if (tsk != current && task_is_running(tsk))
-		return 0;
-
 	do {
 		ret = __rethook_find_ret_addr(tsk, cur);
 		if (!ret)
-- 
2.34.1

