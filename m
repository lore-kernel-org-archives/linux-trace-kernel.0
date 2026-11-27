Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795804844;
	b=gA38pOrj82E9xkdDuzLcQe+KpKvSFKwXjmF1A3CGIXBFHpyYBNSNB9CeOQY2FVabYsbp
	 DaIEFWDcpVqzVlqMFvFo1SH8BDiZNzp1uj40rpY4+YbskL07eZb0wPr1HaEX51ayGyl1u
	 pV4eFfHdlodKHzV53FsI9nkU0FPQxjIR66+VbMLf77CNgUS0ELV+6Ppz/COVXj+4TgAiV
	 TWjaSN8YRLBcmf0GzcEK42iUp3oiHe9jg5hzdc0MZk/nkgT2ZCd/pe6hLvR2R7KzMQn3a
	 Zc2x0ZHyEk1JKn9ggEKM5Pmg1HZXZAPVxXP69/dJ6fKDS1E2ob5RFlkMkZVhCTKYwjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795804844;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=wFT8y0Zr1HX3ZhgJaJpc87Z3ipUTEpMR36YcJXlJe98=;
	b=5ifGJZaw3JuO/8uqHoqVg+A0Z6UlGBtBNqsYVHhido5LJOYieflqgI4rNyqxjfIkw82s
	 3GHlN6hDQA1WqmjRADDSDVfBfoCCpEPImCugJ67blgIR4Tjua83/ML2zXvzy8qjIC29Oh
	 2LCEcoYZl3XqgdgPC1MYqXyo5lsdBAZ1ZP5O1GWWX5Xix3UKcg1VvRfaKwFzX4j2iAH5v
	 rSDjLhjLHNGRX2TzFhZKCnB+Uf1FgOfUVWOjKaWmG0n47L7zmu1hilZvf+fip5RUQaCow
	 7ovBQAIk2yNLwu+7+ziu5XcohqaetwCOR2NMLqPXcxhF2YhjuwEo5hBPB1PCJ3QUIdA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="qaAlchj/";
	arc=none smtp.remote-ip=74.125.82.42
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC2606A31E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 18:40:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FCC2606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qaAlchj/
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-170135e43c7so13047859c88.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 10:40:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795804843; x=1796409643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wFT8y0Zr1HX3ZhgJaJpc87Z3ipUTEpMR36YcJXlJe98=;
        b=qaAlchj/Ucow5nofE45YHfqxqw9Pc7Y7hUAk00bBshPSe3wFe8QQ5CHjBqpZzOcxy7
         OTH8bt9nzoVzkj45hNAJDjgOUadHBp+/ItdgZxqr5Pq71SjFPG8xA1QZTxUgTRZVjhMu
         OzX5AfG6tbiYZp6Z4GAUW6LILKPZZpGYTR3iNFHDhaOKp3FjgF6EY0sBp+JWpAmJEVew
         Jyd2keWP8WR1dYlOpw+oyKK8docypLKQ1/SGuJRZVACiSWGwZ+mUTWTXlU6XS+FFT3Yu
         jP8X42kCuhfparPRp0hlhnNMX+x2RVCfu046sNMc5QVyl6ZEg21MQ8lZ3URltnCBpENp
         vRhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795804843; x=1796409643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wFT8y0Zr1HX3ZhgJaJpc87Z3ipUTEpMR36YcJXlJe98=;
        b=ZJaehhS6iaf5XpUEA059WOLw+ZE/jNJE0etW+d0MtoYBOrsvVPGWCVB/LJSaJocoz8
         vU1KaxiLgVeupBCN2B/AWmKuKsY/vmw2e4FsbMadX+zm1zrosPtpjMejfIsHjdyzDuDl
         wyTAhaENkzS4fLIBvMVCr0nc3XQ53U1rubEimzoEvvXD+ZqR1Pw3SlzLSeW4SY651YmD
         7YwZA7HqkxLcwr/iKLRsQFW+jJ5UZdGiEno6LPOExiPAD16+QTPYNtfrU6o7CEHYW0ks
         6KHo0YIr7ZyahK0p0j8ZnSrgaRImSj0RcjqRnyFY+qbgwdtcx7EkwleQOetNt6AA/JWQ
         G+Zg==
X-Forwarded-Encrypted: i=1; AL+hErEBLGISGDqUkKVOQBt/m9JgqNu7u56+ZgD+Bq0cf/QZBJfD1jvXfJLTfwmvbnazxaLcXhPv0q44UeIBlV77jbvJtJo=@vger.kernel.org
X-Gm-Message-State: APuU4Z/kWPNdzjlBi8wS0geDAUHyG5QPiEwXFH0EKHjH5nkW25I7OoVR
	hCA6xkTNj1h9OwD54m5ZQKhpW3CHkTiAXi3gzotsZeg1X362Js3tJi/v
X-Gm-Gg: AZFdTZfWQgh4rQD8HuOoGYlaeSAjNxSHuPpiwK3WEnK+9GPMWBbklVTNfU7OE3OK2kQ
	JbzHNt5zVRp/QopKr5C1PpYXxiGrlYFkINZQxYOFfHuG82+62y/ZCfyL/27l5WjndcJuc0quFHR
	gs28OYm9ZbbXJxGQh3yPQ+JcIlxdAx5ovn+DtqBUNO8/M7CLMWYEIxKu272rAiM9Ec7D7zZtil4
	MJEdEejm4F2NltJSjDoPx2jf0GEYlUYbF6SJFKgqI6zysHQdYFe2GOLWFk4fw5R9EQNluwClL49
	YZN+Jq8E525tJEOIq/6HIdNyk7O2YP2eiK2t9Kkh0mQkJj/gIuYm3Fuyh0j+AewRwSCxW3b2Lb7
	HF23vaui9yskIv63+loN2ni2ic2GUZ76wUDXVxeb7PtxmYpuH0xgmGdctuEdOlwZbDTELfcOPBO
	3kuLpLxIRh4fAqYHMoT6l9JCW33vIGcqF0Dfah7H/7pwWN4V3WeRSiyFLAkz/rSuHdpG79qUkHq
	jWiY2uF7e37iTFNST3p7B6LRNS/CAP3w3yyEcj2oMkmU3e7Ic4y6IWS2blXyk1lLY3nPccgH3aQ
	1cbRku/H7yINig5972q5yEpLugkg3opsuuiW+KviH0P0yMtV5icNUFXnJ9cs/4mq6OgyKvTmG2x
	0BCLywjinTaS9IjJGc5dtgghPWBpFJO0s93f00Rf5BmcSmVKJGm0ke/KhvaM=
X-Received: by 2002:a05:7023:a8b:b0:1b3:af3a:e784 with SMTP id a92af1059eb24-1b5568fe775mr28302005c88.32.1795804843148;
        Fri, 27 Nov 2026 10:40:43 -0800 (PST)
Received: from FKXX2DL94F.bytedance.net ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b55684c85fsm88425895c88.14.2026.11.27.10.40.42
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 27 Nov 2026 10:40:42 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>
Subject: [PATCH] rethook: link the node before replacing the return address
Date: Fri, 27 Nov 2026 10:40:37 -0800
Message-Id: <20261127184037.71903-1-evanfengff@gmail.com>
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

rethook_hook() calls arch_rethook_prepare(), which replaces the return
address of the probed function with arch_rethook_trampoline, and only
then adds the node to current->rethooks.

A stack unwinder that runs in between, from an interrupt or an NMI,
finds the trampoline address on the stack but no node for it.
rethook_find_ret_addr() returns 0 and the stack trace ends at the
probed function.

Add the node to the list first.  Until arch_rethook_prepare() has
filled it in, give it the trampoline address as its return address and
a zero frame, so that rethook_find_ret_addr() skips it.

Fixes: 54ecbe6f1ed5 ("rethook: Add a generic return hook")
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
x86 in QEMU, kretprobes on 44 functions, call chains sampled by a cycles perf event: 388 of 119922 chains ended at a probed function before, 0 of 121436 after. kprobes kunit and the kprobe ftrace selftests give the same results.
Found and written with the help of an AI coding assistant.

 kernel/trace/rethook.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rethook.c b/kernel/trace/rethook.c
index 87a27f3aa4a6..c0d89720e1a8 100644
--- a/kernel/trace/rethook.c
+++ b/kernel/trace/rethook.c
@@ -196,8 +196,16 @@ NOKPROBE_SYMBOL(rethook_try_get);
  */
 void rethook_hook(struct rethook_node *node, struct pt_regs *regs, bool mcount)
 {
-	arch_rethook_prepare(node, regs, mcount);
+	/*
+	 * Link the node before the return address is replaced, so that a
+	 * stack unwinder never finds the trampoline address without its node.
+	 * Until arch_rethook_prepare() fills the node in, make it one that
+	 * rethook_find_ret_addr() skips.
+	 */
+	node->ret_addr = (unsigned long)arch_rethook_trampoline;
+	node->frame = 0;
 	__llist_add(&node->llist, &current->rethooks);
+	arch_rethook_prepare(node, regs, mcount);
 }
 NOKPROBE_SYMBOL(rethook_hook);
 

base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.39.3 (Apple Git-146)

