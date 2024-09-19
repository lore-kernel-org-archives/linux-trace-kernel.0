Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A48919DF65;
	Thu, 19 Sep 2024 12:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726748861; cv=none; b=r29MWvhNkwyk0Hqq1drKXNCns9mh+N7XO8U3QYaQ6S4eq1bgW6NLIDIorPoWoUMPtj/BT/G7P7oypWsa00v1YcNp3zS6YKKdDfyD0JoHuTZ7q9XnMmbgOuGHXCXUnuwuHeIj3KEM81COET+7+4HssFh/hH9p155jdUzpzh7AvD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726748861; c=relaxed/simple;
	bh=sVdW3pEklIiiGVIPV681lRhmKdKVdMgyfeS8voww1y8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=im+25ycbyGigOr35z7Bmu1LWgMe3N2fqKVcpOeDv42+O3e2MqtMY7EYOfbkPEbbpzdZyuLVszfEgyxo8+OARB/TwJ8FLZmZ7n5QOSxProGigjWieOclzEm39nzsPqCYRRpynDlXVpoJpTUaxKzkPQRrgg8Gv6KHuXNIgKuBhjoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4X8ZXM4Ww2zFqnX;
	Thu, 19 Sep 2024 20:27:15 +0800 (CST)
Received: from kwepemd200013.china.huawei.com (unknown [7.221.188.133])
	by mail.maildlp.com (Postfix) with ESMTPS id A132A18010F;
	Thu, 19 Sep 2024 20:27:30 +0800 (CST)
Received: from huawei.com (10.67.174.28) by kwepemd200013.china.huawei.com
 (7.221.188.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.34; Thu, 19 Sep
 2024 20:27:30 +0800
From: Liao Chang <liaochang1@huawei.com>
To: <mhiramat@kernel.org>, <oleg@redhat.com>, <peterz@infradead.org>,
	<catalin.marinas@arm.com>, <will@kernel.org>, <mark.rutland@arm.com>
CC: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>
Subject: [PATCH] arm64: uprobes: Optimize cache flushes for xol slot
Date: Thu, 19 Sep 2024 12:17:19 +0000
Message-ID: <20240919121719.2148361-1-liaochang1@huawei.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemd200013.china.huawei.com (7.221.188.133)

The profiling of single-thread selftests bench reveals a bottlenect in
caches_clean_inval_pou() on ARM64. On my local testing machine, this
function takes approximately 34% of CPU cycles for trig-uprobe-nop and
trig-uprobe-push.

This patch add a check to avoid unnecessary cache flush when writing
instruction to the xol slot. If the instruction is same with the
existing instruction in slot, there is no need to synchronize D/I cache.
Since xol slot allocation and updates occur on the hot path of uprobe
handling, The upstream kernel running on Kunpeng916 (Hi1616), 4 NUMA
nodes, 64 cores@ 2.4GHz reveals this optimization has obvious gain for
nop and push testcases.

Before (next-20240918)
----------------------
uprobe-nop      ( 1 cpus):    0.418 ± 0.001M/s  (  0.418M/s/cpu)
uprobe-push     ( 1 cpus):    0.411 ± 0.005M/s  (  0.411M/s/cpu)
uprobe-ret      ( 1 cpus):    2.052 ± 0.002M/s  (  2.052M/s/cpu)
uretprobe-nop   ( 1 cpus):    0.350 ± 0.000M/s  (  0.350M/s/cpu)
uretprobe-push  ( 1 cpus):    0.353 ± 0.000M/s  (  0.353M/s/cpu)
uretprobe-ret   ( 1 cpus):    1.074 ± 0.001M/s  (  1.074M/s/cpu)

After
-----
uprobe-nop      ( 1 cpus):    0.926 ± 0.000M/s  (  0.926M/s/cpu)
uprobe-push     ( 1 cpus):    0.910 ± 0.001M/s  (  0.910M/s/cpu)
uprobe-ret      ( 1 cpus):    2.056 ± 0.001M/s  (  2.056M/s/cpu)
uretprobe-nop   ( 1 cpus):    0.653 ± 0.001M/s  (  0.653M/s/cpu)
uretprobe-push  ( 1 cpus):    0.645 ± 0.000M/s  (  0.645M/s/cpu)
uretprobe-ret   ( 1 cpus):    1.093 ± 0.001M/s  (  1.093M/s/cpu)

Signed-off-by: Liao Chang <liaochang1@huawei.com>
---
 arch/arm64/kernel/probes/uprobes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/kernel/probes/uprobes.c b/arch/arm64/kernel/probes/uprobes.c
index d49aef2657cd..5ee27509d6f6 100644
--- a/arch/arm64/kernel/probes/uprobes.c
+++ b/arch/arm64/kernel/probes/uprobes.c
@@ -17,12 +17,16 @@ void arch_uprobe_copy_ixol(struct page *page, unsigned long vaddr,
 	void *xol_page_kaddr = kmap_atomic(page);
 	void *dst = xol_page_kaddr + (vaddr & ~PAGE_MASK);
 
+	if (!memcmp(dst, src, len))
+		goto done;
+
 	/* Initialize the slot */
 	memcpy(dst, src, len);
 
 	/* flush caches (dcache/icache) */
 	sync_icache_aliases((unsigned long)dst, (unsigned long)dst + len);
 
+done:
 	kunmap_atomic(xol_page_kaddr);
 }
 
-- 
2.34.1

