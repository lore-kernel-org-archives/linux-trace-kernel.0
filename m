Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795640955;
	b=bO9oGFHzcIjqpd7RI5KeTFIMfSUorFtPsA3mS0oeeMgefnk439+GUDZcn61jNAcIkqez
	 moJDhOs0NTy93mzBoGClAPJOQ2+7V5vemm5DV4ukDpqQXuSbglB2kqy6DkIrqXPtn6gO2
	 4jWMQFjlAHF0Q0Uu5403otBkbN1fiTOhmc1aZVugalyVTdYalOEs5HdHzPv1346CYGuwo
	 FSGH5impuoBCqZqrijiZ9d1Vrm7K5vbve/Jc+Sb2Mdd+njKZfkXmsx7mod3hy8PSSd5m4
	 B6tGRCtMlCyCxXk6n04+LJTMW16X6Q7qMXRxC12zjeWRTH3w3976CowKcbE+qpeA7Hw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795640955;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=UGooGTMeDb+bMWkU7jfUFCCnp+YQzwe+jXP8cT49pnM=;
	b=IffwyT5G2j3mxwdVSr93H6QVxTRhXOVmhXW7yktpte8WSZg8UY7L2V/pB1S6Ywpy/FMj
	 hTfPDgvxH7jWdNdWcOSAApFg8rH9aArP2Now/jKryPDOlPBQqFCiz2gCGS8iON6p2YPff
	 y28OtsYxEktb3ksZgao3hWq2BVCshSdMX/PUXkr+UTMGtyV3FbtRqkZQ2d/rTv+ArvW/e
	 NFwApaWxiufhqAKlY+OW2aC1763DmM22KGIvSseDVRKyx1BgRJUKbm9Ciu1kKte+6kZ85
	 clrgXtsKf/X9lBeDKzos03iNqQvco6fj6IHNVcxdjpATePeh7xZiftegKyW2PhL/C1Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t5VpqPIn;
	arc=none smtp.remote-ip=209.85.221.43
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACCC606A31E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 21:09:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ACCC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=t5VpqPIn
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-490d59c3f0aso2880672f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 25 Nov 2026 13:09:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795640953; x=1796245753; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UGooGTMeDb+bMWkU7jfUFCCnp+YQzwe+jXP8cT49pnM=;
        b=t5VpqPInnOChueEZpL/BqAq8rSR+DvA+ibVYNxZsXvUDJbjAbKxoOoK6FcguhZGhPs
         Xa9gn6E0pJs+Ex7L+KcKnhiAJxBfICeBwPQUDHPszrnp6O9UG+vh0L59FwkfNseg178H
         rVDJlINGNYZvSUTOQ7D8VQ6WFq9rYxaD5U+4R/zIj9d94X/7IScbtJ/G8VGuc5X6eP3c
         qWVRfWqi6b8U2VX1mIIs5cvv1h/74YsI0eJm3Jkv1CD1trAFBiGrMasolzyvAXYmmY11
         Gzyk/IAdR05mw1j76RJdzRJl3p3HGw58pN7nEyHTAf+Ulh8QMd395gZ9x0/RtnU1exqd
         I17g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795640953; x=1796245753;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UGooGTMeDb+bMWkU7jfUFCCnp+YQzwe+jXP8cT49pnM=;
        b=hy4jqscIRx1FhThnoVa7pBH8A3D3L27GCU9drP/sr8Z4bGyrbyNwdfbGw8MSuG7nFY
         pLY6PBl0tvcc8mVLg6Sg51nTjFHSyu90KhUp9j6hA3G3ere9n0G81JEwSuzB1eDPCL+1
         Sjhp7akNz+tJ5YMihkDMnCbcuazFblyRZ0bLlKxf90wHcyLVBJdKd7cr26aEDfeyPM0/
         1BrX7TYDqdJYubVSztdiOUoB4QkpUgfSlBOHnuIHHGEexDFCDoZpYmQ6yXPCQWz7tVIo
         b3VXc9RcMWkWEvxuwrTP1N50VsRXJ33OUSmZqQS4pBK2yPXlSY5HiTk6lW/lQhVKe+t1
         X8vA==
X-Forwarded-Encrypted: i=1; AL+hErHodh4aYenoEYuXu2ZmE36k2WNLm96tH2CzsnKzzsLt47i/pYLV7VjkqBjztPtBazOOaltAgBvLAxr5Y/9mLJXMUuk=@vger.kernel.org
X-Gm-Message-State: APuU4Z81ENps5LsM5MxtGw8qzsztB0vSUKlRxmKTBJxWvullwupyyD46
	WojmQUPYEtuWrNSwwO6NPLMyxMhHx2/M5lRURytGKGPlYNvWO7lolFF8
X-Gm-Gg: AZFdTZcA2a3M3uhO8duicWgxaNDChQSIWIzi/U6f4muGR39sM41H+4Bw53a29GCVsHt
	86jyyFH/XvagwXdmogsRJsyfRUzERSvtx3wxtj4lnC4ZOzbNubS/Mxl7cYL4IPYU67M2MPkmOOC
	V7pKdzcQxtAeWvsbnZhNXvkaVMDqT4Uzkp63b3fUtb8BwIQhiB0ygSkQQh/CAMdPfrfSbQEooHB
	v2MiwzvnwB6ll8fUHRvhQ6mCrqAv4x4pwaDx1d4ny+4jPOESTHQ/hPvptWj3p9Gwk0jApQTs7RB
	HGAbR7lWLyu0ig98Y+b9EBD9IMspPNPcyFz0mAIqbIowzPDc4R6X1n/uxLDFp8R/U9k6Bfo0UXX
	Ie2zfTVpZ5jqC6hcQuTkWZduIbSzOUrtvl8Gj41kgm7BECTkr95D2p+s5j7Rsb12RxCqqlmLSDh
	BEMjhkr3IDgid6iG2WRQSUbiVrkcJV8Zz7BdeZjmP2CKEX+urEOi2jLSbPqH7s2Nt4aYHD/oeCT
	mbLnEn925PKLlquEOPNI/b4UHc6Pn5GxWunyjfXoMVa7KHcUtj8+v9Deg+16jp5HSghWT14aCiG
	0lBHlCvR2IMWPZ0ip9XaijpB0YJ6bJfhWMjVseMJZmwihBWEWJM2nL0Rf0oqptKfCXLJocWMRkV
	5aQI0zJWByBGcfkY3bibeJsI5HRbf6W+1PY5bawcXZA2bjEW6x4i17YX+qhP0RWrGD9LR/mv3jG
	ARScchk9nTuI4a0AI=
X-Received: by 2002:a05:600c:a0b:b0:4b7:6a8b:9df2 with SMTP id 5b1f17b1804b1-4bb8882432bmr380703695e9.25.1795640953395;
        Wed, 25 Nov 2026 13:09:13 -0800 (PST)
Received: from localhost.localdomain (ec2-3-68-81-44.eu-central-1.compute.amazonaws.com. [3.68.81.44])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb853368d3sm542355145e9.1.2026.11.25.13.09.10
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 25 Nov 2026 13:09:13 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>
Subject: [PATCH] x86/unwind: Recover the fgraph return address behind a rethook
Date: Wed, 25 Nov 2026 13:09:05 -0800
Message-Id: <20261125210905.33319-1-evanfengff@gmail.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
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

unwind_recover_ret_addr() asks ftrace_graph_ret_addr() and then
unwind_recover_rethook() for the original return address. That works
when the function graph tracer hooks the return of a function after a
kretprobe did: the stack has return_to_handler(), the shadow stack of
fgraph has arch_rethook_trampoline() and the rethook node has the
original address.

When the kretprobe hooks the return last, the stack has
arch_rethook_trampoline() and the rethook node has return_to_handler().
Nothing translates that address, so the stack trace ends there:

  => rw_verify_area
  => vfs_read
  => return_to_handler

This happens when the kretprobe is registered before the function_graph
tracer or an fprobe exit handler is enabled for the same function. It
also happens in the other order when the function is reached by a tail
call from a traced function, like ksys_read(): the rethook node then
has the return_to_handler() of the caller.

Translate the address found in the rethook node with
ftrace_graph_ret_addr(), and repeat while that gives the rethook
trampoline again. Do it in unwind_recover_rethook(), so that the
unwinding from pt_regs gets it, too.

Fixes: 19138af1bd88 ("x86/unwind: Recover kretprobe trampoline entry")
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
QEMU: function_graph, fprobe exit and kretprobes on vfs_read()/ksys_read() in 6 orders, stacktrace trigger in rw_verify_area(): complete in 0 of 6 before, 6 of 6 after. kprobes kunit and ftrace selftests (kprobe, dynevent, ftrace) give the same results.
Found and written with the help of an AI coding assistant.

 arch/x86/include/asm/unwind.h | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/unwind.h b/arch/x86/include/asm/unwind.h
index 7cede4dc21f0..7ded718a8d6b 100644
--- a/arch/x86/include/asm/unwind.h
+++ b/arch/x86/include/asm/unwind.h
@@ -108,9 +108,16 @@ unsigned long unwind_recover_rethook(struct unwind_state *state,
 				     unsigned long addr, unsigned long *addr_p)
 {
 #ifdef CONFIG_RETHOOK
-	if (is_rethook_trampoline(addr))
-		return rethook_find_ret_addr(state->task, (unsigned long)addr_p,
+	/*
+	 * The rethook and the hook of ftrace_graph can sit on top of each
+	 * other in any order, and more than once after a tail call.
+	 */
+	while (is_rethook_trampoline(addr)) {
+		addr = rethook_find_ret_addr(state->task, (unsigned long)addr_p,
 					     &state->kr_cur);
+		addr = ftrace_graph_ret_addr(state->task, &state->graph_idx,
+					     addr, addr_p);
+	}
 #endif
 	return addr;
 }

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.39.3 (Apple Git-146)

