Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794679384;
	b=XRuuBm9P/8HAoEYi5aVbfyltTQYGF5QwI4DnyALWeDwtRUTA7huoSVlvhq2kItX+vXsS
	 BM1ZKqJQB31xsQE7yZoENzt2I5g5i/E7bpd8teX2FzdMX9kMMA9457XBqsGkKrF5HaXUD
	 g8TU8PaBET3DDRWgwmJky0cYTUeVwzUXivTKHPY1nizrJKB2hcWJ2VrQoL+47o+gCWCkO
	 AcDJsO/ZaweTSthHYygzH97HKsnvnBUQzqK8vtQ12tpPpJlFRXFQKFgoAMBdutqnL/mcq
	 wPbABBBzSyWg68LihRnnewjTmq4D0imQNhKiKQ5cbzvmFa+d/KL7H5CkjyRJVSfpzuw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794679384;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=VSe16UOk1kzVzD8ojXb7kA7BsT/+rEGWwW68R+M8TVo=;
	b=5MJ/V6oC2Df/6VcfBES/X5f7R6Opa5Fujlv1kKlJWdG3SBaW3jo5X6l39xWu5a5jkCB/
	 ENAMnMibTKDC4U6dnBumz+S8t6j61ahShaNClOvyNW1GHTGSe94BJBtk+hshlPC+lzLIM
	 eMrzmYEHmGA+1PFOPqi3ENNhcAXUE+k8AAQYZQWNplYC1MnTO7B8GmbAkS4j7ws/el6ss
	 F5U8zAJhHc56AkoEVcwSmciKRwLj00ABtRtBH16cE4YACujDggDNYZAxwsTV3XbR+hAqN
	 ndkce5EwKaXezKok55xPrpilQK+oWRryIaDMDtFXwT6C5OYROjrkckYGecuU8EIo2VQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K7ni9Co9;
	arc=none smtp.remote-ip=209.85.128.44
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47BFC606A329
	for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 18:03:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 47BFC606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=K7ni9Co9
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-4bb64c99d2fso6514705e9.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 14 Nov 2026 10:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794679382; x=1795284182; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VSe16UOk1kzVzD8ojXb7kA7BsT/+rEGWwW68R+M8TVo=;
        b=K7ni9Co9vimifkbmxN3A/WMhYEcZTJAa1C52yWXd006xAi9Zd15s4JP8+mnRQMKbRR
         +lI9mw1x5iD1SyXapJ4LLXbLbx0W0aTPRB+ELwPu28rr9fFezG1vashJxl7czosPv08L
         /0pUylFdOr2pWdxDutsD1m2S7Mzt2PWvApJGbLVCFAwm+T1ANSQ0s8rM4K4t+FCaXsyV
         bnvoafdIa6uc31zELv5pQwpf8FGTBWABEwD5NGkHFBEaoyilWoOhogh92HJaGfDsZGNj
         lXmn/CT3BOXSka24PJrVu5INE3MABPZ5wIaSU3A+Z41k5D+mIHS6zyJ8qCRvBVhDc7yC
         t9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794679382; x=1795284182;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VSe16UOk1kzVzD8ojXb7kA7BsT/+rEGWwW68R+M8TVo=;
        b=okNfikbuJKLAY5r4GcvRvAEy7n8hY+YQvBZm810zQVnvIIwYocSzQ8HHgto7qShynT
         PSjCkiMi1xlBCDFESnogG39b7IsRXGMjB/doeo1fbOPOmv+bYmHhea7HKtZDw4uYDVzh
         y+Kl82FI5Ebp7bNQyTCNHTF859splhvE/CVqgim0SttbFeFFrS33n6GmyvsoFW5pHXwB
         Ty+GXt94pet5HbnmuJzIFsKLkGcyaAv9dexEOZPETwz1+xEkkTMclt/lbQO2xUmK/72V
         1M4d0Ra7z5fpBMkoI6KZID4GH5IYLnDt5ZDarCO9yJQV6MHN05E+wYygWQXoBUlix//H
         pmaQ==
X-Forwarded-Encrypted: i=1; AL+hErGVYKmSY9WjRw2qvWkJAWWw/rmJ96Ml9J2hGUquUVmu1w2/sLAxFJqr/Zuz8p5fAE0VLLAQ/5/R/ZcDpHARzIkithc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8dYskpGPS+4b8NwAVDohr2FfxhmPYn/VPg/IvsaLK5vnVt4oB3
	5FJmXjqoz8mACzqyclQmtMKE+zGHaYkBPcLoJfPK9kh0s4/BLKxWaeIt
X-Gm-Gg: AYBFou1Dw0QjltnY0nYI6jIv/0GgDQNpupJdb8hG2OlzBf6PxGIExPHcrKlPu9ixCIs
	VNd8n9KGM5CihfGzao/LSZLHqjZTUgmqa2vA0a6z9a48/KAsLjiDyo5WsZ54iaU4WG7/gNz50Rx
	fA/c82znxbs+kJ9suPYSIYrhaDukpMGomYwfoG4q2x9mt3GLd9Edbk3Os5DY9r9cuDoSOmBQykj
	/QAzWtyr3TVzpbYLRErxIRYYLphRhmrRpwQumqhuuUH23TmjvtDejlrt8IxUcwRk+pKd6OxtKJw
	o8ATbrY+3xTzBNCPL969gRrC2mjlXlXZYG3x2E0+FXXK2ofjlZYNMqbP1+eS5Yx+Jb1PsKLqEUp
	oFCmgp78xP3yJA2uKJDBfzEa6Tqy9i/ItUrU59GbYwtUCBv8TbMeeMV63DWcY/BjrvlrKNS6/R8
	5aHHIV+VC3ICLQByS+dxwf4WbOI2LCKgUaFrFcPgntZ3CqYUrzDrX8397ImA2Od0visjpnSb+Y8
	0k+PtsjrkY8GwNbEHdCV/LmPXod0kKiWsQhvl7E/N9/Yr4hAcuO5fINYSJb245otLRzPf4TlPFQ
	bTZiFc3hXFWDRwAR8cWg6ZQc/gBi1JJ0MYj7GE7o+iujimIS/9rpgyRKZ10m41omZveUOHKXZU/
	9og/7cMHW3aaSuHOJvYsOaYpxjA00ibpQ9B+h7GHhIxs0DcpWgWkptCMeTnTPXgI/XsftMZRLc+
	yOkN247/zRkDATAATyowkSsy/oCLiP+qQ=
X-Received: by 2002:a05:600c:6986:b0:4bb:6a2d:b438 with SMTP id 5b1f17b1804b1-4bb6a2db52fmr1309225e9.0.1794679382371;
        Sat, 14 Nov 2026 10:03:02 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-b358-dd01-fd08-0f0c-fef7-8409.310.pool.telefonica.de. [2a02:3100:b358:dd01:fd08:f0c:fef7:8409])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c5a32d336sm13422619f8f.0.2026.11.14.10.03.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 14 Nov 2026 10:03:01 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Helge Deller <deller@gmx.de>,
	"James E . J . Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Sven Schnelle <svens@stackframe.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	linux-parisc@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] parisc: Fix register corruption in 32-bit dynamic ftrace
Date: Sat, 14 Nov 2026 19:02:50 +0100
Message-Id: <e184f942e0933a1618f161abe672ad8a90bab529.1794672077.git.kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
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

The 32-bit dynamic ftrace trampoline allocates a 64-byte frame.
ftrace_caller() saves %r26 at offset 20, which overlaps the third
argument's spill slot for ftrace_function_trampoline().

In the failing build, GCC spills org_sp_gr3 into that slot, overwriting
saved %r26 with the original stack pointer. Tracing preempt_count_add()
then passes that pointer as val and corrupts the preempt count.

Allocate two frames on 32-bit, as 64-bit already does, and update the
generated trampoline instruction to match.

Fixes: 6ca6366220ed ("parisc: add dynamic ftrace")
Cc: stable@vger.kernel.org
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested with GCC 16.2.0 on a 32-bit SMP kernel under QEMU 10.0.13:
function tracing of preempt_count_add(), preempt_count_sub() and
update_rq_clock(), followed by a combined function/function-graph
workload. No warnings or faults.

I used an LLM to help isolate the failure, inspect the generated code,
write the test harness and prepare the commit message.

 arch/parisc/kernel/entry.S  | 4 ----
 arch/parisc/kernel/ftrace.c | 2 +-
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/parisc/kernel/entry.S b/arch/parisc/kernel/entry.S
index e04c5d806c105..b0728dbee53d7 100644
--- a/arch/parisc/kernel/entry.S
+++ b/arch/parisc/kernel/entry.S
@@ -1949,11 +1949,7 @@ ENDPROC_CFI(mcount)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 
-#ifdef CONFIG_64BIT
 #define FTRACE_FRAME_SIZE (2*FRAME_SIZE)
-#else
-#define FTRACE_FRAME_SIZE FRAME_SIZE
-#endif
 ENTRY_CFI(ftrace_caller, caller,frame=FTRACE_FRAME_SIZE,CALLS,SAVE_RP,SAVE_SP)
 ftrace_caller:
 	.global ftrace_caller
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 10fd5b3e63e75..963a741faa42d 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -146,7 +146,7 @@ int ftrace_make_call(struct dyn_ftrace *rec, unsigned long addr)
 #else
 	u32 ftrace_trampoline[] = {
 		(u32)addr,
-		0x6fc10080, /* stw,ma r1,40(sp) */
+		0x6fc10100, /* stw,ma r1,80(sp) */
 		0x48213fd1, /* ldw -18(r1),r1 */
 		0xe820c002, /* bv,n r0(r1) */
 		0xe83f1fdf, /* b,l,n .-c,r1 */

base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb
-- 
2.39.5 (Apple Git-154)

