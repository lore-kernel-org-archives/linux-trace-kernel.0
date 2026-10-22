Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792634256;
	b=ofG9GUNnKZ1CpXQ21Ck9oXi6uL86+qLuwFg5mQ+xiy0fjHEUMJL/exZFMO/fFlrK+lk4
	 Pxo6/Vsc4J5SLV0AOEV+8r4EESeW3Lq3SNT+JQ4nLWAkA5IMeS4Xhvp676JrwsfvW92Bt
	 5lCX/5m1usbkINhIq/Qb3XjKYBfhn8F609VaogeeDKjWAeiAk9Czwh+Uuc8qDHvHP7Fh+
	 u59QChRgtnlZx/HMCdC9wf/xPtUrqyPMLcuZwncn2RmxnLM6B3cXzLcx8VjCSV+t3+YwJ
	 rcv98zim9y6+BNYwA6AvpEAWVFH+c82PjEvQR9/PzC4SYyDEWcKxA4RWUh6xEh9RSfA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792634256;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
	b=XM6+sycGSVUDFFK/Ebbk6+ANxxg3CpdO08kx4N0P3v6nIBAIFsMW5NUzuyOXWkvvKAoO
	 3tRhgetaDqrss0dZd+5DtCVLcIm7uVGjt+pQ6lXAkcwIsonTLaUEDPs5LOhEkO8aUsags
	 WY+pcgcT5Op0hnUT2YcGALBQSYzUacIN/qLx1cLqrEbo9+2GaGch7CYpQuE6Mvdx04wVv
	 TzOZElD6/qFOeDoG4369aaS4m4YaVlxjswyR5dKpaX5aXt9NZSMxest+9q5H3sdyxRRRe
	 n5ded9nG+dDYa/9LPDyZHZoLxByS/wZ5fncNdsRW/w4MTNIpqI2i00mOTldEE/ic6+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENH+XPCy;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4917606A31A
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 01:57:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4917606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ENH+XPCy
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3ada8bc2380so127453a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 18:57:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792634255; x=1793239055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
        b=ENH+XPCyJctxYy0tq/P/dNgxodBKniOt72zMFjcHfl88zP152hyucaTU7RJZf4QI1x
         1VpGfRQTR9BMTIjq7PqmW4d78toRZTLTxsmwNZLt56CIZqKfeDGwd7/hVLiAQGUE9xLn
         F6LDiVHHO3801WBDL3nqEPo57ozaTFsl5oZIT4EPDiOWTd41sFl/XYF6hvSs1r9WurX2
         LXE4lsm4XWPQo2UgKi2+Q6LrGO/06MLbgfsSUUp8N/mlZQyiDVupLjeRTdemuXbfK63X
         mPm1iX4y2RdwuUMCaRNX4Slq5YKvU1lf3YRAFvofA1yVVeHpFoFuPQvpIr8zc8Z0+B7Z
         wHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792634255; x=1793239055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hzZTIl9xajYqJye47ARFhIH6S/mo0DE83iMFJBmKqCA=;
        b=tqNqjGnxayG31u/cl1/RWvRubxN0xwxm4Pl6PNp0KYOfgzV3/kyV0f0Z8PvS1oXgGd
         MIISh6GmLuhhdms1sCIOBFI+hMjChV5gLLR53go9sujKpB9fKbeJH1GBXYePJAJ/Hcgu
         Q/G/vbzJmilAJFVHKDdTyC4DRzIYM/rVKNwICQfa0OaxmuwB/gP/UPk+Ar9Z7NZropGr
         J7zwcSCdUMXMzKGq7rD5/6AQJdFyZSJMPeDDRcohwze24NADJNB7CmqAmU8iJomALr+/
         x4Mr99/72o4xxlBd7FpoZpL1LXZRpR3zCjLDVMns8C8kqD6Ur9Kny7we4J9XfIEHVHCY
         HsAA==
X-Forwarded-Encrypted: i=1; AKwUvBzWuWhZb1pAcas9MqAkFlpajEvWZyPm0Mmj4ofj429Fm6PsjiMWiuZu+bx3RzNNuhx3MslrDLhplz1ULRN+6EsXrFM=@vger.kernel.org
X-Gm-Message-State: AFq9FYJa705LnkS8N2k5gp4ej6n/IzwGD3LtDMdrEp8eBrlU5t0qpiA0
	F3Y7Mc2FI/s+kk8HxW11E3X8pX/nQI65D2iDDGtlVvflGxZRO22YxSD4aM4OVw==
X-Gm-Gg: AYBFou3ffYsMSfyVlTLdxVusbqyZkwB6kbD1XNJ+N5mmV9jKux39nfc8JUNyl1qbybI
	wDuxjNTH7LhzO7mXuTrna0CFRdtUMDOYHb2/HgqeZjmXuhoknZiTQ1+9TBC0j11qKyhSrn6shWB
	DNMyWAdZZSIRO9NwvCfjePnNJ1QjWoRr2F43/YeR/FULlq6EvJ8KP+8dgzKUKlwWdfY6jWE9KAC
	NxwGlqUWW+GkNvegOSJdrKABrD1w/L034H3knXUwEotQ8q9sV0aKlea3jk/7gARxeOzp/jKDvbg
	fpcAfCXUIFPliKKZuSQaaOmo2eXTenJAC4DWzjURacHoRO43AiINs0sdQSaeRm2s85uZLKWWi4y
	7t+vQFpcM/LzCGKGaWAYsyu0U+Tk76avz7q6yDciyBwio80sxsZZD6Bl44ZnbLflhWV8e9WAWli
	VmFGDVYz3k7UvGcwU7sU7Uv1Nx+UWWNx0VS+5f9+xvQ0Mx93PzAkipjoj5GpzyxsAXBAeOzeEf1
	14683IFJi83+7X6MzC9R/FH/+shDqCBo7kB7GwCcKw3JiUJ0Q4tnz100noAgiI8b659x+yw+9GM
	aL/5VfuoWw4ply2qo5r6EB+dIJ28ZALG33OXdAPyuCIMceI+wPcHeka85nH7m9/DEJ5P/qv0U2u
	m22fjR59IYyJ1cJF3dwqqzpYy
X-Received: by 2002:a17:90b:1dc4:b0:3ac:8897:7baa with SMTP id 98e67ed59e1d1-3ad86d4e4abmr2953396a91.40.1792634255162;
        Wed, 21 Oct 2026 18:57:35 -0700 (PDT)
Received: from coder-ast-ast-dev-ml-0.tail2dda0.ts.net ([153.61.198.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ad85fa6b87sm2978876a91.3.2026.10.21.18.57.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 18:57:34 -0700 (PDT)
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
Subject: [PATCH bpf-next 3/9] uprobes/x86: Finish an unoptimization which failed half-way
Date: Thu, 22 Oct 2026 01:57:06 +0000
Message-ID: <20261022015712.1297331-4-alexei.starovoitov@gmail.com>
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

int3_update_unoptimize() restores optimized nop10 in three writes:

  48 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%rsp; call tramp
  cc 8d 64 24 80 e8 d0 d1 d2 d3    1. trap new entries
  cc 2e 0f 1f 84 e8 d0 d1 d2 d3    2. restore bytes 1..4
  66 2e 0f 1f 84 e8 d0 d1 d2 d3    3. restore byte 0

uprobe_write() can fail with -ENOMEM, or with -EINTR when the task is being
killed. When the 2nd write fails the result of the 1st one stays. Byte 0 is
a breakpoint and it works. But the next set_orig_insn() doesn't find lea in
byte 0, takes it for a plain breakpoint and restores one byte:

  66 8d 64 24 80 e8 d0 d1 d2 d3    lea -0x80(%rsp),%sp; call tramp

Nothing recognizes these bytes anymore. The process keeps the call into
uprobe trampoline, which can be unmapped already.

Teach is_optimized() to recognize the half-way state, and let the 1st write
of int3_update_unoptimize() skip what is already done.

The failure wasn't reproduced, but the state can be made by hand. Attach to
nop10, call it to get it optimized, write 0xcc over byte 0, detach.

"uprobes: Don't sleep on mmap_lock under dup_mmap_sem" needs this. There
fork() removes the breakpoint from its mm. When fork() is killed in
the middle register_for_each_vma() removes it for the second time.

Fixes: 554ba38456da ("uprobes/x86: Move optimized uprobe from nop5 to nop10")
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
---
 arch/x86/kernel/uprobes.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/kernel/uprobes.c b/arch/x86/kernel/uprobes.c
index 65a2de82ecd2..62bbe41c6466 100644
--- a/arch/x86/kernel/uprobes.c
+++ b/arch/x86/kernel/uprobes.c
@@ -896,6 +896,9 @@ static int verify_insn(struct page *page, unsigned long vaddr, uprobe_opcode_t *
 	case EXPECT_OPTIMIZED:
 		if (is_opt_insns(&old_opcode[0]))
 			return 1;
+		/* An earlier attempt got this far and failed, nothing to write. */
+		if (is_swbp_opt_insns(&old_opcode[0]))
+			return 0;
 		break;
 	case EXPECT_SWBP_OPTIMIZED:
 		if (is_swbp_opt_insns(&old_opcode[0]))
@@ -1109,6 +1112,17 @@ static bool __is_optimized(struct mm_struct *mm, uprobe_opcode_t *insn, unsigned
 		s32 raddr;
 	} *call = (struct __arch_relative_insn *)(insn + LEA_INSN_SIZE);
 
+	/*
+	 * INT3 followed by the rest of the optimized instructions is what is
+	 * left if int3_update_optimize() or int3_update_unoptimize() failed
+	 * half-way. It works as a breakpoint, but to restore the original
+	 * instruction it has to be unoptimized like a completely optimized one.
+	 * The same has to be done if a debugger has put its INT3 on top of an
+	 * optimized uprobe. The trampoline can be gone already, so do not look
+	 * at the target of the call.
+	 */
+	if (is_swbp_opt_insns(insn))
+		return true;
 	if (!is_opt_insns(insn))
 		return false;
 	return __in_uprobe_trampoline(mm, vaddr + OPT_INSN_SIZE + call->raddr);
-- 
2.55.0

