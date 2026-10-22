Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634263;
	b=0qhvAjvdHpC9LCJArvIi9qhk1Y0CSyXe9ApJYgspQPfCsx6/imEvN/q6epgECWpx4TnU
	 ZnbwjqS4+2gh657mVzzlr70q8qjwDqqkWru5wilQNwZkcUSOyKLyQk1OQZamStHqZ5KLI
	 en4WWokUlLaPFdSOErxo8dG/zc1AWbSYkAzLSieDkAT4+XfZpYoVVzTFaYU2pCKTYdz0h
	 KW5/U4IpRAMvOjCyi1eL3x0QOrhYIv4RSq0wRQj8Xl1cfcez40KcSR2h+Nyta7ESjeU9t
	 kZklI78FXEIxNtE0a3oF9M/geNtfkn4VM6Wx5eQX/h/NRMjNGLVzFBJEw7MGoLukrwQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634263;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=1YfAOVlMmaFO1m8awbcQvUypoDPfeD8mK+PEX0oRAyM=;
	b=fwmMtYjSfXywGhgos1RwLtf6+xEZsqH4WUcPtXd/F/w34ubuuMv2N86RZiDhSgcpshXq
	 JY5o0n693OismRLYwzl05mBqrGA0Ob8oJ6udA/yh5OjSqXgRo+3TLECLZw0EJfOSBdbV7
	 LJWxT1xMwOW/W2lnCSsXc2JmEnaYx09V8aoBrFFcGI3/IsV4tbghASbnsEC3ym6mqpe5J
	 tc+HZZJ8twjOG9xIXFSrOp4KAQbkaJuNM6QMcL4my31v21SIVARiIpvGuM+94BXoevGU1
	 aRANq0RwNwTH7IM1RYyVIFuVxgreT1apXjiJmv5hP0yTAZVao8c8RtzlzJbQH/EsSVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMifRPw7;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EFFF606A326
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 01:57:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9EFFF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=QMifRPw7
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2e8fe8e343fso9014765ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 18:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634262; x=1793239062; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1YfAOVlMmaFO1m8awbcQvUypoDPfeD8mK+PEX0oRAyM=;
        b=QMifRPw74ATHweuZbPUqbEJKY4CbQGRNSsvn3yPOvskEWe71YJcI/zC4jQs+00oX7w
         AnfEnYnVX28dLRI44N3yfdkR61rnHMRP4lNoh2cSUyUUtPRruc1ZumwNqmtF4opAMb1K
         dFb0OkilKx4tuI2gsL1PUSXTuXHCGkJpRxzMXDY5Q97X6m6a6FwdHdyOfvPuIjU1OweG
         oKw+fYZgVxT1ENZeN6Lcprmt0I3Wyyvw7Fd7d2dCsxHovO4BrdnGaZ7NBtM6AUJ+YrTR
         03ldC4K4udelto6khrnvnMnHTt0BonrFcW5VNoCjJpVS1CTcvaFHocA//TqSOTId+e26
         jQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634262; x=1793239062;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=1YfAOVlMmaFO1m8awbcQvUypoDPfeD8mK+PEX0oRAyM=;
        b=Zdrc0832wtRvT8E24Vf/S/K1jVZLfFs848a68pmSvvNFPbdcRmT2X8P7GnwyScJaZb
         zMf4B7FsNB7JUYVi/Dn/29nvWuQNBScedLGEEKGFiP1+VmMR/a1EoZqK0jkNDkqNhVGR
         Ks4pYvPLTiJhPfI5O61qz29KF3yQmpIQrCt/vStxSM9AnCEHdiUZNsTY9eCVYNfIBRCw
         T5WFoE0fWD951V2gLXEiw36Ax62sA46kEk0VMO5vXc2JwNlRepbPXtAP0S5uNy3vo3du
         n559sh7XZy2r308I/1aDAMBYxCsbvpvIXGdn9Mqwayppp4R8nqcEhpabRDskckNwyJUZ
         moaw==
X-Forwarded-Encrypted: i=1; AKwUvByThV0d0B+EGXTz9PDwCG4M3Mec1Kt3S2XwQF50nr/6KpJRfyRhhosn0WDLrfGU+Cu9xfnnP93U3WVdK6+/89wI3TU=@vger.kernel.org
X-Gm-Message-State: AFq9FYL0bZJcgNJbZ94kIQQOZvH2LjIqlp3lXCVeOY8PI6XyMzbaIUYj
	9Zj4XQI3cs48fis+cwAiiCBjOr2A4WKV0r34BPPfglbOSJbEsz5FKmR4
X-Gm-Gg: AYBFou2yBV5K5xIffTWfGxIimUy6uHKE1wBSxtCAOTNQ3+Rjxw2SvUpUnIQCCkn7tRk
	T1816Wuw3vk21/9Edkp5lcF3sq7ogg1HTOqvehyNB/9yDBZnZ51uTRPcBVAdW3/WoY0k6SHaA63
	kVDPcDlE4OQPR1qhkz465jgEXF+K2Z8sjaReq+SITY+hdQiGnF/oLdYNrfp3GMm2ZajRelBrDQn
	+lY6IZXcjMO/gKFvtyC31OR/IaflBOB83nKzncXm8wMP+uxgZLVMgm/B7m+8dF5xMQE+ogVx0Tu
	dHaJQx/EBE2yvDQvsIyH0AWkIjYwRmDfE2WoliTZmrA9//lG8kSmc18vLinKPs+HF4iM+Sn6R/A
	B6volLNecAiMJd+lL2wbniEdq7qk4KnfamiOb1HiitwLP7Evo9KSMftDmNALcl30l3IOKqvEIrD
	KQFdE7OAlZWkzlF/gJFraOlozIGPrLha2Mcst/PjEEXplf23bQ+v4bZd2pRNVNTiPSf78/dWswo
	Y7A7hbRdVQmwvZbYA8MxxsLUeXaIukIrFBsm4ZHxuJmz9ZrfYrdek3ICIfvtMgsuOCCFv+AMSJU
	7qhDlNCocSRT7fUO89cuxbmJs9EpsD4B1k8fltvVU1M/war+7oM9lavv92L+zKkTkX70ZUnrXuU
	7+85JxhbpIHWShSseR4bJyDUA
X-Received: by 2002:a17:902:e74c:b0:2dd:c0ff:e72b with SMTP id d9443c01a7336-2ea4404e987mr25918265ad.61.1792634261828;
        Wed, 21 Oct 2026 18:57:41 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ea3b4af4dasm17474295ad.75.2026.10.21.18.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:41 -0700 (PDT)
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
To: bpf@vger.kernel.org
Cc: daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com,
	oleg@redhat.com,
	peterz@infradead.org,
	mhiramat@kernel.org,
	jolsa@kernel.org,
	akpm@linux-foundation.org,
	liam@infradead.org,
	ljs@kernel.org,
	surenb@google.com,
	david@kernel.org,
	vbabka@kernel.org,
	jannh@google.com,
	hughd@google.com,
	kees@kernel.org,
	mingo@redhat.com,
	tglx@kernel.org,
	x86@kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-perf-users@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH bpf-next 4/9] uprobes/x86: Don't WARN if an optimized probe can't be written
Date: Thu, 22 Oct 2026 01:57:07 +0000
Message-ID: <20261022015712.1297331-5-alexei.starovoitov@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
References: <20261022015712.1297331-1-alexei.starovoitov@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alexei Starovoitov <ast@kernel.org>

__arch_uprobe_optimize() and set_orig_insn() do WARN_ON_ONCE() when
uprobe_write() fails, and user space can make it fail:
- -EINTR from get_user_pages_remote() when current is being killed.
- -ENOMEM when COW can't be broken, since memcg is at its limit.
- -EINVAL from __update_ref_ctr() when the process cleared the semaphore
  of SDT probe.

Kill the processes that call probed nop10. It warns in 8 of 8 runs:

  WARNING: arch/x86/kernel/uprobes.c:1186 at arch_uprobe_optimize+0x291/0x3a0
   uprobe_notify_resume+0x1c3/0x4c0
   exit_to_user_mode_loop+0x63/0x4e0
   exc_int3+0x1f3/0x250

The next patch calls set_orig_insn() from fork(). Kill the processes that
fork and keep mmap_lock busy, while a trace event on nop10 is enabled and
disabled. The kernel with the next two patches and without this one warns
in 3 of 3 runs. The whole series in 0 of 3:

  WARNING: arch/x86/kernel/uprobes.c:1161 at set_orig_insn+0x161/0x170
   register_one_mm+0x154/0x180
   uprobe_dup_mmap+0x61/0xb0
   dup_mmap+0x149/0x9f0

The callers handle the error. arch_uprobe_optimize() marks uprobe as not
optimizable and byte 0 stays a breakpoint. set_orig_insn() returns
the error. Drop both WARNs.

This depends on the previous patch. Without it WARN was the only sign of
the bytes that set_orig_insn() cannot restore. Hence no Fixes tag.

Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/kernel/uprobes.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 62bbe41c6466..33c35bf07801 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -1170,11 +1170,8 @@ int set_orig_insn(struct arch_uprobe *auprobe, struct vm_area_struct *vma,
 		int ret = is_optimized(vma->vm_mm, vaddr);
 		if (ret < 0)
 			return ret;
-		if (ret) {
-			ret = swbp_unoptimize(auprobe, vma, vaddr);
-			WARN_ON_ONCE(ret);
-			return ret;
-		}
+		if (ret)
+			return swbp_unoptimize(auprobe, vma, vaddr);
 	}
 	return uprobe_write_opcode(auprobe, vma, vaddr, *(uprobe_opcode_t *)&auprobe->insn,
 				   false /* is_register */);
@@ -1197,7 +1194,7 @@ static int __arch_uprobe_optimize(struct arch_uprobe *auprobe, struct mm_struct
 	if (IS_ERR(tramp))
 		return PTR_ERR(tramp);
 	ret = swbp_optimize(auprobe, vma, vaddr, tramp->vm_start);
-	if (WARN_ON_ONCE(ret) && new_mapping)
+	if (ret && new_mapping)
 		WARN_ON_ONCE(do_munmap(mm, tramp->vm_start, PAGE_SIZE, NULL));
 	return ret;
 }
-- 
2.55.0

