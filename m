Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.210.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795045830;
	b=3pUXgS7ARJ4a0Ru1WYj3dwtC/LP51SkxOs0zkgWgAHqrzkew9P6COYtA5Hee51iQdVWf
	 IDZVXVI5wnxZHSCyfxNMmj1a091DAAZ+Re3L98M30BlOxGzb4tt8QEXsVdK3Zpzng5jEi
	 qOUTmezZKh1Rs7pCSgJObpn17IrAuFuROnmNAB/Z9OVbzZPyWraClpaueSC5ZHl+ydExe
	 w5PhR3u4jfDtbEBI9ub/vnwzsBHfavkQFSEQtC5KcMQ40eEf75vLIE/IUKx9ljjdR9Xoo
	 4/uLPtnv1enYmlVbSpvF9QiGUX53uGX6RamOVdlKOoRVE4wDDuAof9/tJTQ/thA0UaQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795045830;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ubqPWeJTwTZYZ6JWo58kLzJgB3q5AxyjbXK9VjEgDRk=;
	b=0y+ksIwHQjjkCZVt1Dl21htBYQ74/CDil34pm0SFYvF79z8ckZEE9BVZzyUba4mliwvJ
	 tnkLQSXaeWZ2DQRnYYe1NJuTfYrDU7gZcLOToCkP/IzMxWfTxnC3vuOxzuUq7G5NSJSQi
	 noXA2k6puvDvc1OIttxPtlrHKBbZDnluvpLcxut7y78pXp7zdgOWyn3gTgfFL5L+XpuAa
	 1VhDs7UUxaDxrlHcCzJ0zXzk4a546Uej3Rr6YbV5gWfBD1tt/t/qFVXYmZ4xq8axJhgek
	 tjyLo7o+iH/oO9vpBRP370uUfP/tKpVPu0Dz5rYwT6vimwattUaymRLQ95kPTevlPCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYRTzxuC;
	arc=none smtp.remote-ip=209.85.210.51
Received: from mail-ot1-f51.google.com (mail-ot1-f51.google.com [209.85.210.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475BD606A332
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 23:50:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 475BD606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=LYRTzxuC
Received: by mail-ot1-f51.google.com with SMTP id 46e09a7af769-86288992de5so292190a34.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Nov 2026 15:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795045829; x=1795650629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ubqPWeJTwTZYZ6JWo58kLzJgB3q5AxyjbXK9VjEgDRk=;
        b=LYRTzxuCbuF3jxZspOIrUliZwI5TbKqNalpuAbdLkvX5n63pZyStvF+GmWdcyegdQl
         /ACtj+R8aFsPHyLkCJ7qZZFm6ugLgJPEx98LcKCe16kwGONA3z8YcnHoxfSWlxoidqRS
         sjFgoOWJ047Nhf4eXxOH2XW0kjr/BoXhTboP1EhMxU64piB+hA5v9eTY3B4AF0x3Xfu4
         IoLYauYPeJhN3ujc2nB3VLpXmbbpXG19lEKLttFNxMj1C6osaKimsJ+i3FpRPIzpXtll
         d4B7Leca7kxcc0BxSanYk5KugpNWxZxMaNSoaPnl1SMwm0+7SFcWubVj031N7H5pTeOl
         4mww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795045829; x=1795650629;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ubqPWeJTwTZYZ6JWo58kLzJgB3q5AxyjbXK9VjEgDRk=;
        b=EkJKSFGto558RxcOLetV3iIK8PBJ3MK856h1w2ABjUK/oMPWWg+hzEYSvi5+c9qTZQ
         1QDcsoam2AmO5bRTWhE64hys2OvN82o5qgJmmaIjB+ASh2q4Hke41hurXnpDaGK5HI6b
         1HOw7ynzLlHYERcJVKux2vMy6DjLheEVhNz7NA++agEruY6PKaNDwZ8tNFmy7qO6M6Ge
         DRH1/SV3Yu14fBn3+1goQXnaMfTTst5yRjaMZIevQJH6JRahj0cNuShuJKFkSOq4AL7C
         /WOitoJKvAQWBnH3HXnWaYiU9JBd+l2cp3JLfddIYhOHXvCF+HbzT6203pplvh6uVDZz
         LoVg==
X-Forwarded-Encrypted: i=1; AL+hErGVulqkVWHGw+dgxO96yINnvo0PrcSZ4OlBhxuO8xZfQ+SXeTKU/Ow6nakiNYMBVSXhVpuXdfgBffl/MVauAHv0Nso=@vger.kernel.org
X-Gm-Message-State: APuU4Z94YqXH8qTSjrZlvFFOka8UYi48kq5TArfqFXnNLSU2lGCmYAJx
	FzP8CxqxGxkZwUkaCBBAKQxH6D7vsP9blztqOSFWxLbHdAcXEDSbYuNs
X-Gm-Gg: AYBFou01Q5dUfzm/4vTvhvPc/IyKfh845gqB6GtAhLcdX820DuKqAYp4ewX2+tQpNv+
	zPWm7tJdgXlRArc5J84kYSZ8sqfZOGiKByRNkeS76qLZKPWjQjbNxbReFwc3ikp+BVBj7qChUbe
	rX1A/SFLmrJFQZ0GY1yTOclTyLgfYJ/8axtYweZZdfD2TN0Yje7ISFFn2fSbVR9EVjQ3DgDB2ub
	Rj6R4n17v2Ph0uR4bKROGaVqAh3sGLKOkc8+adVt8bHx6s8LCos/RTGKssoYS1B98v0lmCHsWyu
	dWt2ni7zA64aU8jSfR6TXdMwNDsLHTtUIVAG52DgxfvbXmp29WCytGDc0zCHNi3VbnpEx1sfnE9
	PKtvnAS8Nhetlpa4rzfLCsS1P1Hsw4af6q4fRdopSRzoxssDbNk5/U1LRhZc5oGS6MdfcEClrOo
	ItZQwfpP5PcU/IlZn0k6NWc7CJn6S053EYU6CqQDjIrN0Vmupvv7Pp0jR543+qD/9y+k4SuZ4Ew
	eCevg6/mcG/gddPQI/1m29Fyr76Evm1y3KR0noa0Cw5WbahxtvzFHi2crynu+d6wu3QOgb98LL9
	eNOGN4eyZb8mVAJ+75U8JPrIgPozHzLI+S19gqQkXbJ0URAZowxGfrsz4ZJpZRNT21fAe0O/3Ra
	Fh1IPO2mfMKsVjF/n4ZG07bsDecOuxa2CbLLAUQ==
X-Received: by 2002:a05:6830:6413:b0:85c:e511:ee04 with SMTP id 46e09a7af769-863040ea2e9mr131360a34.16.1795045829136;
        Wed, 18 Nov 2026 15:50:29 -0800 (PST)
Received: from FKXX2DL94F.bytedance.net ([72.29.204.230])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-862f00891e6sm3102871a34.0.2026.11.18.15.50.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 18 Nov 2026 15:50:27 -0800 (PST)
From: Yifan Feng <evanfengff@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org
Cc: Jiri Olsa <jolsa@kernel.org>,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Alexei Starovoitov <ast@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yifan Feng <evanfengff@gmail.com>
Subject: [PATCH] x86/fgraph: Fix the unwind hint at the end of return_to_handler()
Date: Wed, 18 Nov 2026 15:50:23 -0800
Message-Id: <20261118235023.14978-1-evanfengff@gmail.com>
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

return_to_handler() reserves 8 bytes of stack for the return address
and marks that with UNWIND_HINT_FUNC. The hint stays in effect after
"addq $(FRAME_SIZE) + 8, %rsp" has dropped the slot again, so the ORC
entry of the following call has CFA = sp+0:

  return_to_handler+0x41: sp+0	call .Ldo_rop
  return_to_handler+0x46: (und)	int3
  return_to_handler+0x47: sp+8	mov %rdi, (%rsp)

A stack trace taken from an interrupt which hits the call or the mov
ends up at that entry, the stack pointer does not advance and the
unwinder prints:

  WARNING: stack going in the wrong direction? at return_to_handler+0x46/0x50

The return address is only in %rdi at that point. Mark the code as
UNWIND_HINT_UNDEFINED again, as it was before the hint was added, so
that the unwinder stops there without the warning.

Fixes: 20a0bc10272f ("x86/fgraph,bpf: Fix stack ORC unwind from kprobe_multi return probe")
Signed-off-by: Yifan Feng <evanfengff@gmail.com>
---
QEMU, function_graph + 20 kHz perf callchains: warning in 2s before, none in 10 min after.
Found and written with the help of an AI coding assistant.

 arch/x86/kernel/ftrace_64.S | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kernel/ftrace_64.S b/arch/x86/kernel/ftrace_64.S
index 4b20673a3395..8b488f99de02 100644
--- a/arch/x86/kernel/ftrace_64.S
+++ b/arch/x86/kernel/ftrace_64.S
@@ -387,6 +387,8 @@ SYM_CODE_START(return_to_handler)
 	movq RAX(%rsp), %rax
 
 	addq $(FRAME_SIZE) + 8, %rsp
+	/* The return address is only in %rdi now, the unwinder cannot follow. */
+	UNWIND_HINT_UNDEFINED
 
 	/*
 	 * Jump back to the old return address. This cannot be JMP_NOSPEC rdi

base-commit: 20eef29b7c8465ac98d7dd6d6f2ac07a8d8056ca
-- 
2.39.3 (Apple Git-146)

