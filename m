Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2802D17A316
	for <linux-trace-kernel@vger.kernel.org>; Sat,  3 Jan 2026 08:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767430069; cv=none; b=u++RXlKm2eBGca+rP4jn2ElXkbNqlwZz3xr0u7GeUCH98wfWezD14uYI/yf04B1XFGPE4qDxAINS7lF35U66cDogIxsObJRc3fHNszdl5ApeEa2J3d0xT/+6lX9EcAMFNd8rX8hUkzRp8m1kIFOAv+ESEj9+/sgtYz4tyjWkKfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767430069; c=relaxed/simple;
	bh=e5hoLtxYWSBKCaXnzyOlvdkNn/9oqCrmBamB2u6C5RI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rBNvG4PJHBeOFTceVhth1fDFqLd2LCq3xrykK5tSASXPzW1HVdLphgtZPwR3Q05QH2vhKRSUFWFst6l05aqVX4D9w5fOAhpXdy3bCN1wEls28jyBdfAtOw49d3JVqd1dXI9+etXUWVNKxfbGlS+sUWuIsmVuB+fMg7MKRouofd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KrZts75H; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrZts75H"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-7f651586be1so232604b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 03 Jan 2026 00:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767430067; x=1768034867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LLfzaNCKblQsWrgVFWjAAIDp8UyGda/a68IUZKqrEfs=;
        b=KrZts75HRzouzgG+XYA3TsuMuTGd957/RdLxYB6+BJjO4MuoooVt5TmExf57G/aFgb
         fBfNCBHsoTliQNgUSQiOjm3xt3DxZd4LrF5UEqgP3cscxq8ooI/fkIDCJzZbLCh3QyNW
         BY/l29Bch6zhxtS2DRajxc2TxZ8OOnjz8k7fNhPZpY6UnAEPggwBlrezeNF256xuWaXS
         1RWR4GX8ealUR2bdhWUHkgMPYKGNX8Puja/NLu8Upf7ElL2gSsLL3tV1I4zpMOxEkmEU
         UXTgBfJDWLAWXJNw8tZtG5TachYD2WRZaJ+2AIVxSHaCdCSyNlr0LlTRedca5buS0Lxl
         ziGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767430067; x=1768034867;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LLfzaNCKblQsWrgVFWjAAIDp8UyGda/a68IUZKqrEfs=;
        b=qm8qKwCbNQH00w6ooqwoArldOHA3nyESz/yIEhw+zuwo21VzRfrd/OOrtEx1+B1my0
         Aax+gkcedzGisZJO6cF2vKNsgODPwtfAZRkancqwiFjf4jTlcixmNhH+sYZQTdPuqMI+
         rb2MD2A5L4bPSAkFmoD9DVILqcgCAHTkRsYjOJD4NONFiHqwG6j5anw4ZOdANNmlo1Iq
         H2JfRwq3F7lf3lfm+zp6ykgb7fyUINZATHqAtEH2lKDGxQgEo3DmJCzoU2s/GULK4gXp
         48PLVfBzAVNrv0iU4L958t68UJ3BHaL6OPZ4a8EDzGDPDSiBD3SrCSZhz1cGFX71epjK
         9auA==
X-Forwarded-Encrypted: i=1; AJvYcCX83AakBTYAXDYwOyA3uL/bgG5zpeFfFKrUWqF01DM/yBkQjST9fRUAoB7qNdokJn8kjXov0eCix0E8nsiykNLsVUw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyXjgUNCNKgvGY5sc8cn6O/kyyQF0gwu4biqPa/oFWt9nZQiipw
	aWTblqe6ccvcOYJCvUZGZBM9vcRwQiNPTT1zGqBppVouGafpdwg7LAF7
X-Gm-Gg: AY/fxX4dctWSLcYt7oKCIvpnmcRWPUIF74PbL+iaQEvWc+5iwPqLOEIdPVFHG9OjpQs
	k2tsGAf0bOC3s26AK9unwStxWNe5OcWviLEUQ6BY7zBEOZJkc68tiXNijHj9XwMeVmgdBiLOvyX
	7AB9zpjnYi6dbWdgUtjdrhwSBu3SMLg+lgXIzwaYxPV0jxhZbQ1oF1N8yEP4CbXzUGhIn4/IBdf
	HjuHmL/nF3oT7zNjW0INwQD+8J6Je2SHq0Tx2O7R87AfJl8wjawDBt5p1g6v0wda5PxQ0CQE5Av
	p8KSEn89wUibhaDkk6VvLVwQKaV5LfJmibg+ovxKi3IqpFg1clFpeiD8pqFSNqIAFL8HArhXikL
	OTDwmrjdOe0o7BJ1xxICX0P1LoXyxQbZnUG8LUV6wuNHTup+hpBT+izhvvPGNO5jV295jtiIRaI
	OAuiFkT69YPt3whym03ZftY1iMoAHcmsm1jrg=
X-Google-Smtp-Source: AGHT+IFlp8qcq2QazAOf3KnrJVHQQLc5fUVTVkMNEtXBSYaNUnUycb5/s395woDebt+kaXn7KmVKuQ==
X-Received: by 2002:a05:6a00:4ace:b0:7e8:3fcb:9afb with SMTP id d2e1a72fcca58-8148ba19ccdmr1341264b3a.17.1767430067508;
        Sat, 03 Jan 2026 00:47:47 -0800 (PST)
Received: from jvle-ThinkPad-X1-Carbon-Gen-8.. ([210.73.43.101])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7ff7e197983sm42704939b3a.33.2026.01.03.00.47.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 00:47:47 -0800 (PST)
From: Keke Ming <ming.jvle@gmail.com>
To: mhiramat@kernel.org,
	oleg@redhat.com,
	peterz@infradead.org
Cc: linux@armlinux.org.uk,
	catalin.marinas@arm.com,
	will@kernel.org,
	tsbogend@alpha.franken.de,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mips@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Keke Ming <ming.jvle@gmail.com>
Subject: [PATCH 0/5] uprobes: transition from kmap_atomic to kmap_local_page
Date: Sat,  3 Jan 2026 16:42:38 +0800
Message-ID: <20260103084243.195125-1-ming.jvle@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The use of kmap_atomic/kunmap_atomic is deprecated. The purpose of
kmap-like functions is to create temporary mappings.

kmap_atomic() typically disables preemption, while kmap_local_page()
allows preemption.

According to the documentation, kmap_atomic() is primarily necessary
for contexts that cannot sleep.

> kmap_atomic() may also be used by interrupt contexts, since it does
> not sleep and the callers too may not sleep until after
> kunmap_atomic() is called.

> kunmap_atomic() may implicitly depend on the side effects of atomic
> mappings, i.e. disabling page faults or preemption, or both. In that
> case, explicit calls to pagefault_disable() or preempt_disable() or
> both must be made in conjunction with the use of kmap_local_page().

Link: https://docs.kernel.org/mm/highmem.html#temporary-virtual-mappings
Link: https://lwn.net/Articles/836144/

Keke Ming (5):
  riscv/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
  arm64/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
  mips/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
  arm/uprobes: use kmap_local_page() in arch_uprobe_copy_ixol()
  uprobes: use kmap_local_page() for temporary page mappings

 arch/arm/probes/uprobes/core.c     |  4 ++--
 arch/arm64/kernel/probes/uprobes.c |  4 ++--
 arch/mips/kernel/uprobes.c         |  4 ++--
 arch/riscv/kernel/probes/uprobes.c |  4 ++--
 kernel/events/uprobes.c            | 12 ++++++------
 5 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.43.0

