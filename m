Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C80922D7A1;
	Mon,  3 Aug 2026 00:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785718620; cv=none; b=P1BPnsjmgWO47btrq6Wn8tppo+T2lVGJQRho0WoldzABVFyOuhi2VZ9VHJdokZki/ei9/t7XUDCtO7U8qx1sg2MXkZ+6idJ81sci3SKu9jH7IIrTqAB3a8P8iAFrfibhlPmTUvX7zK3J3VdXTHw7wgpIWw8DXviFI+bCm4ZKkjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785718620; c=relaxed/simple;
	bh=ru9DgSxBp6Tro/UaRi9w8TehHY6eve4LN7HNM+5PDa8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XTz30L2Cr2PlrswP8aIH+MtbBMKHFXi/OutU+zI8E+gjYkW8w+a7cGYSQQ/dJeiGGnKbmOYTa2EihT859oWsK6BviYqQ+rle54IwMZ7LL0tsiuXag8CjMc1NjF7eykrSG/ablMHfurNIasbMhj1BJ1efvIOVAbXuDRr0xL/qRz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.177])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4hCytW6SRKzKHMQV;
	Mon,  3 Aug 2026 08:56:51 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.252])
	by mail.maildlp.com (Postfix) with ESMTP id 1B89B4057D;
	Mon,  3 Aug 2026 08:56:54 +0800 (CST)
Received: from huawei.com (unknown [10.67.174.45])
	by APP3 (Coremail) with UTF8SMTPA id _Ch0CgB3s0JO529qhaulAw--.212S2;
	Mon, 03 Aug 2026 08:56:53 +0800 (CST)
From: Tengda Wu <wutengda@huaweicloud.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tengda Wu <wutengda@huaweicloud.com>
Subject: [PATCH v2 0/2] ring-buffer: Fix snapshot swap race and improve user experience
Date: Mon,  3 Aug 2026 00:56:38 +0000
Message-Id: <20260803005640.2445666-1-wutengda@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_Ch0CgB3s0JO529qhaulAw--.212S2
X-Coremail-Antispam: 1UD129KBjvdXoWruFWfur13ZFWxtr45uryrXrb_yoWDAFX_u3
	92q3s7J34xWr9rKw1IkF4Fvr18W3y8ZFyrW3WktFWUZw18Ar1aqrs5JFyfur4xWa4qgr9x
	Gr93Zr93ArnIqjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUb4kFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8w
	A2z4x0Y4vE2Ix0cI8IcVAFwI0_Jr0_JF4l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Jr0_
	Gr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AKxVW8Jr
	0_Cr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj
	6xIIjxv20xvE14v26r1j6r18McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr
	0_Gr1lF7xvr2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7MxkF7I0En4kS14v2
	6r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY6r1j6r4UMI8I3I0E5I8CrV
	AFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUAVWUtwCI
	c40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF0xvE2Ix0cI8IcVCY1x0267
	AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Jr0_
	Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIevJa73UjIFyTuYvjfUehL0UU
	UUU
X-CM-SenderInfo: pzxwv0hjgdqx5xdzvxpfor3voofrz/

Patch 1 fixes a race condition in ring_buffer_swap_cpu() where the
committing counter check can be bypassed during a write operation,
leading to inconsistent buffer state and a RB_WARN_ON. The fix uses
current_context instead, which remains valid throughout the entire
write.

Patch 2 improves the snapshot user experience by using work_on_cpu()
instead of smp_call_function_single(), ensuring the swap only occurs
after any ongoing write completes and avoiding confusing -EBUSY errors.

Changelog:
v2: Add fix patch for ring_buffer_swap_cpu(). (Steven)
    Reorganize commit messages and Fixes tags.
v1: https://lore.kernel.org/all/20260730011912.2325121-1-wutengda@huaweicloud.com/

Tengda Wu (2):
  ring-buffer: Use current_context for safe per-CPU buffer swap
  tracing/snapshot: Use work_on_cpu to avoid -EBUSY during snapshot swap

 kernel/trace/ring_buffer.c    | 8 ++++----
 kernel/trace/trace_snapshot.c | 8 +++++---
 2 files changed, 9 insertions(+), 7 deletions(-)

-- 
2.34.1

