Received: from mail-oi2-f43.google.com (mail-oi2-f43.google.com [74.125.231.235])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B0038A72F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 02:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.235
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790044277; cv=none; b=h78CpgsXODlKOacyDO+uqZtqRxrTXRnSimj1Pu6DnsyPo6CsQDL2yd/NeVexBlW6mFeg6D09IyS5RIgfwhJq6Q388PTxhRlacFg3qoH05kSNMtrDnSQEAxqmBWP5E3uuz6/khX6wnSTCIMUadzrCSHza7Y3OhVGT5heAwc3qtRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790044277; c=relaxed/simple;
	bh=k3uI38McaBBwdCNJHLmxYV0OO7ZSK15O+198iKJMWk8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFsijzRpmBzo6uNpA86YjkMVAo3+ZokmO/PY8E7IE0RPvQCDM0kkk0l4RyCkJ20Tub+wCLg1kqj4GTEP5d6Z43oq+n70jg20HlD0w8RDyRt6hEpJvHm8g7a5sE7++Vg+7VKe64qEu/Oj5xNbF/1EIdjcYOeZBvzZtXun7Rj00ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zf+K4YCG; arc=none smtp.client-ip=74.125.231.235
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zf+K4YCG"
Received: by mail-oi2-f43.google.com with SMTP id 46e09a7af769-811424a645bso1141890a34.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 21 Sep 2026 19:31:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790044275; x=1790649075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=fPinNBMlDf+SVY9DzF+R+UP82SJBRH5lBM7N0iCV2os=;
        b=Zf+K4YCGtPSlWKAS9ChF4CK/ypowMzexliLuNTcAPn+m5zDoeVrZSB37+j5fW1WV6E
         iezjmWpJPtoXefrIpp1dqVRyKIuWWruXJAmlEZYDIWKRm8gBArFGt8GZnqJCpyhebHqB
         YBjoriZnUzStObQqbFCJG4GFn5NLhqjp1QoTucdldMahqENyzBq1Cn5g1DN/BF03mrIf
         hEif2CamcP/kkR0QpBQLtvVrNj0SDc3zAsymyMA0LHXpIL1FnV8FBQQ7iZxYjCerf5Rc
         IAPfzPepowVQeSmDsLEHwBji9aGJSB/3qExQRPBlr2ajV2UIROOAIYsSo9WTaIXsBn77
         ih8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790044275; x=1790649075;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=fPinNBMlDf+SVY9DzF+R+UP82SJBRH5lBM7N0iCV2os=;
        b=yTY2YYQuWwn3q6BjbilZU6TiRRNQ2Fl1Z21MU3IgVc/KfDasCDHuB5ASVK65ZjMJVX
         W2zz8Ohcc+x8uwG/YOSjsl43TO4+nMRlGn5F9ToZJ7lZigyjRbAlN/V4EuedK2cphNkN
         shIPqDXR0FG5ImR9sBkhLRW6quhvpGjFq5imYDvEY+AP8vUgg5Oyv6JCiNjEV9nOcuac
         S4FtXtAtAdZR2rADstgu+h1OWzWT0CsupFtyZFd3GGl29g1jsdkiipH9CuahnS1q+4Tq
         MWiGEf5x5PqyQbUsg39GoK3i1Vr7hy5eGYHxV3cWPLJUIX5Fsal4TjMKrZqjIKvtGsx4
         sVtw==
X-Forwarded-Encrypted: i=1; AKwUvBxvsCQgmI4Bs4RxiFxWGT4eCLEcrB2lwsNzADk9SIUyCNbyUMeZn8KJNKVq3/5EUadLy1ODTKuiLxOE6WIxIM2AFAw=@vger.kernel.org
X-Gm-Message-State: AFuF++m7OtQtEc8Ezp+8yxYYN/5oHzpOo/B7ITQmMVXsAnW8lgLfq3Qx
	noHPr0OI13LMX3iuC978an/PZjcqtlkfZddvYKLF+ODe/6KZ3Cw2YF1U
X-Gm-Gg: AYBFou198P3lFMhaaMTxTCQBxe5CgwMCLQ1c+PHAnt8y2aZrpRs1lOkJXvOFceVoyaW
	3fK6MEZPiGBm0nYSurcEPtqAT4/AdoBHedgsLrinhfaNNL6H23ZsH1QFm0h1+V/KzdP7fB7UghR
	PjWHv07qD1U1LzTUwMR8ca3XDDSIO/bm/YPnlJkldyGSEriESeJsLMQaZ9rgt4ljN2dz0PIi+iA
	XPnHmOXtn1Pkoh32OnZ+gdXz6NKA3xBgmRTSmF9PTb542qiHquq9cwNPTgEy6B54G/50d6idZkI
	gpfup/Le5L1zJcv1Pk4QdwegFjAxRhbtrJjIHE27ot2l5qI9fzy9Igrgc07aSUns1QqFgeMQciv
	f5uragQVg7PRNjlWS62XTUxEdXQ60wm7uwfZhs+EId4/EC9f0fd+u26fTidII87ScgnpseP1n/w
	a9bSnFl9uVl30FfS3wR2lz30oKryqD0Xjy15xQ8BnLmAjpTufq49DxY01+XbMvTrxQxpPCCDJXr
	g4Zvk1PLHz3zKkr/cxwOODgDcRJoSf4qBGMSmUy
X-Received: by 2002:a05:6830:71a3:b0:806:621a:e71 with SMTP id 46e09a7af769-80de38f0d07mr12983273a34.31.1790044274956;
        Mon, 21 Sep 2026 19:31:14 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-814e6396f1fsm662102a34.16.2026.09.21.19.31.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 19:31:13 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: Andreas Larsson <andreas@gaisler.com>,
	"David S. Miller" <davem@davemloft.net>,
	Peter Zijlstra <peterz@infradead.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH] sparc64: uprobes: use kmap_local_page() in copy_to_page()
Date: Mon, 21 Sep 2026 21:31:11 -0500
Message-ID: <20260922023111.49951-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kmap_atomic() is deprecated in favour of kmap_local_page(), as described
in Documentation/mm/highmem.rst.

The generic uprobes code and arch_uprobe_copy_ixol() on arm, arm64, mips
and riscv were converted in v7.0, see commit a491c02c2770 ("uprobes: use
kmap_local_page() for temporary page mappings") and the arch patches that
came with it. sparc64 was not part of that series: its
arch_uprobe_copy_ixol() writes the XOL slot through a copy_to_page()
helper, which still uses kmap_atomic().

The mapping only covers a memcpy() of one instruction into the XOL page,
so it needs neither the pagefault_disable() nor the preempt_disable()
implied by kmap_atomic(). Uprobes is only built for sparc64, which has
no HIGHMEM, so kmap_local_page() is just page_address() here and the
only effect is that the copy no longer runs with page faults and
preemption disabled.

Tested under QEMU (sun4u) with CONFIG_PREEMPT, CONFIG_DEBUG_PREEMPT,
lockdep and CONFIG_DEBUG_ATOMIC_SLEEP: a test program put a uprobe and a
uretprobe on one of its own functions, then called it 1000 times in one
child process and 100 times in another. Every call returned the right
value, all 1100 returns went through the uretprobe trampoline, and a
kprobe counted 1102 calls to arch_uprobe_copy_ixol(): one per hit, plus
the trampoline for each of the two XOL areas. No kernel warnings while
it ran.

Assisted-by: LLM sparse
Signed-off-by: Danish Khateeb <danishkhateeb03@gmail.com>
---
 arch/sparc/kernel/uprobes.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/sparc/kernel/uprobes.c b/arch/sparc/kernel/uprobes.c
index c8cac64e9988..1b54f9e72e8c 100644
--- a/arch/sparc/kernel/uprobes.c
+++ b/arch/sparc/kernel/uprobes.c
@@ -33,10 +33,10 @@ unsigned long uprobe_get_swbp_addr(struct pt_regs *regs)
 static void copy_to_page(struct page *page, unsigned long vaddr,
 			 const void *src, int len)
 {
-	void *kaddr = kmap_atomic(page);
+	void *kaddr = kmap_local_page(page);
 
 	memcpy(kaddr + (vaddr & ~PAGE_MASK), src, len);
-	kunmap_atomic(kaddr);
+	kunmap_local(kaddr);
 }
 
 /* Fill in the xol area with the probed instruction followed by the

base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0

