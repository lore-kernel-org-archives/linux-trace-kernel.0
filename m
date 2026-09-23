Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CAD306D2A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 14:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790174953; cv=none; b=JXpSv744Ir/DH9Bd0nHwQ6DIngiMgGStaE+revdQS2p24UUSVkmp+W2AM7wDvX3c33FJp6hlM5akrnNAUUMUxa60OyJPxegO/sVNAhOpcz2TfZc7cfmGErRelC6YWOCXrEDd4xn+yb8xhyMIwE1zFFEH4ZlP6UN6blEbGr0cSEE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790174953; c=relaxed/simple;
	bh=wQCvOdr5DG6nGGHUmjf3dbvqPAsVzIgztOSMKuc72jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oBWUABYQfaD5N5/3j4N4NuCCJbbVHVSUqt0/bnTnP0BN/jRe7GG3gydbt3oZ+GLYP1RQeLBNiE8cpjX8N2/Tid7Ce1krhOENbCvqipkoKMk5gXGCF9Yr+Cgnsoy3xQw9jU93FZA6KQEo6GCcerh2n7uZimb1RMBFfM6Ey8LjJeo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVMvzhby; arc=none smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVMvzhby"
Received: by mail-oo2-f39.google.com with SMTP id 006d021491bc7-6b1ae736c63so627630eaf.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 07:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790174951; x=1790779751; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Jb40C5wg5KlMegSVoKPaSGTLlViBBhllfQg4nnGSKA8=;
        b=DVMvzhby3hWepqkLYFp3NitIWxCyCs+BvmMzaoEUuuZvhu/zgJBntz4evdhwOrXecL
         nB2D16y2jhP2bcHSMCf0iiShrA2usUUbKlVk7oaqTWeLynqUhmEoXUieXWozIVng5kqb
         v6ULCkYQCAvYEC0TGFZeNsRosSSl/c4LIJDjb7dgvFoONLQQW4oPFhfQsm/w5VkrVzba
         eBIwzc8Akvg9FCvwwW2e7TN3UGLPR0YASFvT0qYoDyTo0H5tCzpg+3ppn32pWYAeaK00
         yUuKVivSKMQof3WikcMALRJ8MtDVEoAi6OkatxjeIhvOT1HigvWrDu6j4sM+KUbaFrrL
         +9xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790174951; x=1790779751;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Jb40C5wg5KlMegSVoKPaSGTLlViBBhllfQg4nnGSKA8=;
        b=RvWVt10Bd/T7jUMgR5BAVOD+rfQ8Puey/ckTfzRVd1dgWHgTWsOAZNQdYp4/qapjWe
         ag2KciOFtZJ92BQmVdfL3HTqD93QDt5OqO3RNDJoFIY5rBZM4a8AT9gHUT9LNji5HQot
         hqAbD0OXLXmrbLi6iyTj3ohd/A66q93NGiQ4Y49MHEjZ7WfBa0ejwy6BnXlIj54Y6Agy
         7XQF9PniFpwijASnTRihNtxQkVIPTrmx8W+MRGpZScspfoDGVB0ABNX6/MynutW8iGpB
         wEnCvdda4iEbLO+AiZ94WT/6MbW0EpJNznJ6Xbx8qRHWWSWP/4T0/EAa8ynZJzng8OsC
         EvFQ==
X-Forwarded-Encrypted: i=1; AKwUvBzICO7SWYccd6VO9dxjYAOfoieq10lmcECeWTK8m7NClpD8LdDcY/YJnq9d2wQ5Pa3/apiq861D2SzzrDw+fGeH0/A=@vger.kernel.org
X-Gm-Message-State: AFuF++nTOZK+Xj47NK0GXbbd2ru/B/nMOR5qy+eJdy648aaRFBNv269+
	cUgPp//f1Jw57l7S0vCsDz9NIicBgCH10/huPIXQYavbfppbXQniMS/L
X-Gm-Gg: AYBFou2uIwWKvyGrZSPwdgoz8jJnNyvHKMd20HVKbUWTiL5AL7+ElLRrkSRp654mARM
	2oGcjhhQb3tKKuN7JIa14+t/hvMZ3TRUVj0f5hIWyOc+w9H+KDm/ke3iqnRxdLoC7LWraRDFOm2
	RfZ6re9YgCgr0X0fyhwlqlbY1eC26izW0Ztkahb5YD1NF5jQ6qFJOQCvew2f3ua7qomLQycYx2y
	eSze/q9O3VS2Ppoi4mDnyl3Ti34veLCU3HiP+vNTEG7t4zhAAL/eOaP43eRGSY3OYok7A0JIi/3
	Ag7BUq1jPYypueDm4pe3gR9Tx/Wm1YboMTAR+mYNNT/Af0gww1Qc+sSilV3kgBphUoLD208uDi8
	v3q/cCuYXXNJ1xUS2F+sYSRUO+Gfqm0vMjboA1En8eIoG+AnxziZYGD2eCNg3hmr4Oh4un7TrF7
	GhREGuMf3XVXyFSTSenNW1HVFJuYf9I0lEH406td1H+I3U3XS7EB8yrV+niHq+P2JEurxbsiqCt
	oqESEuabdp5lKPcM0ZRe5D6JsOzOcMG/NNkaNCp
X-Received: by 2002:a05:6820:190f:b0:6cd:3fec:de75 with SMTP id 006d021491bc7-6d2d3012efemr2156575eaf.75.1790174950870;
        Wed, 23 Sep 2026 07:49:10 -0700 (PDT)
Received: from archlinux.lan ([136.34.156.120])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6d2c92c2619sm2788537eaf.0.2026.09.23.07.49.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Sep 2026 07:49:10 -0700 (PDT)
From: Danish Khateeb <danishkhateeb03@gmail.com>
To: "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Allen Pais <allen.lkml@gmail.com>,
	sparclinux@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Danish Khateeb <danishkhateeb03@gmail.com>
Subject: [PATCH 0/2] sparc64: fix relbranch_fixup() for BPr, FBfcc and FBPfcc
Date: Wed, 23 Sep 2026 09:49:06 -0500
Message-ID: <20260923144909.414968-1-danishkhateeb03@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobes and uprobes on sparc64 single-step a copy of the probed
instruction, and each has a relbranch_fixup() that moves a taken
branch's target from the copy back to the probed code. Both only
recognize call, BPcc and Bicc. A taken BPr, FBfcc or FBPfcc therefore
continues next to the copy, which crashes the kernel for a kprobe and
kills the task with SIGILL for a uprobe. BPr is a common first
instruction (a brz,pn on an argument), so a probe on a function's entry
is enough to hit it.

Patch 1 fixes kprobes, where the check dates back to the start of git
history. Patch 2 fixes the uprobes copy of it. They are independent of
each other, and of my pending uprobes kmap_local_page() patch.

Testing, in QEMU sun4u with sparc64_defconfig plus PREEMPT,
DEBUG_PREEMPT, PROVE_LOCKING and DEBUG_ATOMIC_SLEEP. A static init puts
uprobes on seven branches in its own code: brz,pn at a function's entry,
brgz,pt, fbe,pt %fcc0 (FBPfcc) and fbe (FBfcc), plus be (Bicc),
be,pt %xcc (BPcc) and call as controls. Each function runs 200 times in
a child, alternating taken and not taken, and the delay slot's effect
and the path taken are both checked. It then puts a kprobe on
__se_sys_getcpu(), which starts with "brz,pn %o0", and calls getcpu()
200 times, half of them with a NULL cpu pointer.

- fe2ec83746e5 (v7.3-rc4+): the four new uprobe cases die with SIGILL
  on their first taken branch, the controls pass, and the first taken
  getcpu() under the kprobe crashes the kernel.
- Patch 1 only: the kprobe case passes with 200 hits; uprobes as before.
- Both patches: everything passes, with no new kernel warnings. Boot
  has three DEBUG_PREEMPT "__this_cpu_read() in preemptible" reports
  from iommu_tbl_range_alloc(), with or without these patches.

W=1 and sparse are clean for both files.

Danish Khateeb (2):
  sparc64: kprobes: fix relbranch_fixup() for BPr, FBfcc and FBPfcc
  sparc64: uprobes: fix relbranch_fixup() for BPr, FBfcc and FBPfcc

 arch/sparc/kernel/kprobes.c | 13 ++++++++-----
 arch/sparc/kernel/uprobes.c | 13 ++++++++-----
 2 files changed, 16 insertions(+), 10 deletions(-)


base-commit: fe2ec83746e501645709761605c2464a44fd2929
-- 
2.55.0

