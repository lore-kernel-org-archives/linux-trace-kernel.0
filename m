Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.45
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794532429;
	b=CwgbBwyaerIBVgu1p7u9YjV7IV9ZK0ZydExdUoGvw+lO3kOEkySN2CP3y8QOrB68rbk9
	 wlm0M7MlRXLRxN647g3o72fdGpUfhwSHA2Wy+//pVyZR40dW1g/op2QeKgoCzzJB2fp0N
	 QLnclK4a6KKyga/eEmKMuTFVUCH3a8K8Bj3IB9xTkOnqHVSKPU+kxJm02G9WAz4S4WBSQ
	 R6DHWnEyH6mU3xxmOg42gDMf9VNqpC131sNNwKu3XHRkYwppj0qOTie76xtvh/lhBKLA8
	 XNYqwcqe+PnDvYG3l3SgZYn/A9Jtlx2UM16n2HPpmC5mu+6Z3w60VwhbiWo8JmEqLaw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794532429;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Sc5ygLidAeVc1fVLnxfVzT8pc+Zr0/C2OuXAjLAj5yE=;
	b=slp/i9LCgDAO0kMheMlUgNCG+9wHnlLxyIKPSay0H0u3RqGCpPPw+CzJgAnq1U0Mdvxe
	 UzXqtbX5oCyduj/js4N62UkEWRO2uDro1LgHb0Ngl2R7YpsUT70/d2UudKOEzRYjpDO3B
	 2sL20hDaWxV7GQ4KxJFfPI5P38U2jrapNd+W7yau/9jVtH7lijQSahZaMCSyNoNW2uRDX
	 n1RUFHTCsq+uMfAHeoMPQWpaCiX8ay/STvolCOaninUbiUDUJGD1qg9kRmaHopjdPPnkJ
	 c9YlpF8L6zWX2AA//gTUfOAvgkjrluSt/VsGoFgedxZD+lc8IO14g0R3e0G2QvOzlqw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlXfrmYC;
	arc=none smtp.remote-ip=209.85.128.45
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1814E606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 01:13:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1814E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=hlXfrmYC
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso3576695e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 17:13:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794532427; x=1795137227; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sc5ygLidAeVc1fVLnxfVzT8pc+Zr0/C2OuXAjLAj5yE=;
        b=hlXfrmYCQW0yWzGjrBwqAOEDYipKPP1+CZXPVrQdF0f9bnR6+43Z+bKQS6bZj/e9PU
         CgH3o8G8EhNDFlO5Ns7E5e4rz6oM5RcA/hMysCr9qHdOlsIoTi7hbklNQK4gJvkgUD6m
         EGsEVFU2xm1Rcyxqhpn+d9dpjcMRTNGlecx1h6772BeB+wdUV3K3EXfxAru/qrLkXYqr
         mopxtT5uDoVm7Vyo1nuOIXIFo+2id+X4zFRXfIrzW7D8VkqXNzjbaSWEA75iwLfhmLDZ
         wmN9sRoW4NmBkgIOP6ViEnYOY0MCY8ujBUUbSmahSP78PDqixll8kHy/UTUK3YpZI0Bd
         CLOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794532427; x=1795137227;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sc5ygLidAeVc1fVLnxfVzT8pc+Zr0/C2OuXAjLAj5yE=;
        b=HnwDFfkTjjJpDAoIMoj22B81c9SslbgGz3JLJdv6hnJV4UQrMGIz7xNQBZ0Y8Inm0H
         JVUFWS1mNMsIvMgOXYdUUJXZLTui6w8uEKhePw9EPPIORKdB4rhtiPCqzAk3NxFxNXfD
         ow8ZJQ24IaNvYy+LhTYhvcrz5l6G2RDd49aNzt2JaoMkSg1lOXoMuUBwkyiS+qC8RBpm
         OhLc46/6XAYX44G3lYUiwMVCOvKd8fwSjU+y8zwxf6s5X6NSp0/F1ytbjuEVoGJbmkZT
         p3ZYsMVGdkaUVpkUOTXTfiBQT0vyrvREyXSnqANNnqj7d3osvfjTB68uzs7u5MwniqAP
         jbpA==
X-Forwarded-Encrypted: i=1; AL+hErHwfxG97m3skqXEHPKRS8mVO6amGcTzgg6HUFglHU//e9X1yCUo5i7/v+5HdE0LmB/GUV5GOXkCgk97suWgTzZefbY=@vger.kernel.org
X-Gm-Message-State: APuU4Z/UxCMdXKNIn/B0scLHtbsDbIgOHth0nDJBi5kJRVmU3a7mXEF2
	+GuEu+zm48KJUKZxqHO2/GTm4/9gG2+Wae5KRRinCdB/tg0nXJM7JZ/ji4Sh9Qws
X-Gm-Gg: AYBFou1WF53+ChfN66dpiZCWOkrO7TmiB5qH55bZceBHsCYeGqESm5EAQ67Hg1Y0QAM
	QBGUl+GTm04S5NiQDnQySn+NIqeCjy7hZv1pRlhowno+K1llBudbHQDbLUbsstE6Vkz0bthuHGy
	5DRW5mvEdusv5+5VrQJ1QfW0xGKxsAyKXlT3ZQPbvhSyRGjveKSD41lTraOdIYlSe7wG9xIJH1g
	VMOrhRhaRS5gS5yGazL4qiNDl2zQZ5SoGIspg1llvMNMwqeJl3RS3xYFmB4XsNGYGuq4pOS9Cxi
	a+P9gS7te4F0KoA33pHZViP8rbjd86VZrjXWMamLgM2WYOk5yZ3PwWLvc+lSOGR9rVoNZWwox9b
	5KShQGlZf7bbuZk+NCGseFQJQJTkQr6mj9YXb3r/6EH/ZwKwgDguamuZ8GFveRBX/+giZBe6UFw
	1KzaqjmEl+bXcD4JTQ/pHy6jxRYgukHFZIXLI71AohbrdSfIG4fTAjd3imVU1yAMetnAIlNDCN4
	Nl9GSwrQcg4ANX9bgnVPsrYTirZZ5OxWL8LhJDbWAsOiBzpsN8RES/srdYwwAR5q7mAE2Igsc1c
	/jP76etFPajJorzCAsfIS5sfGqQsT9ZwZY7ZDALqoPatyrt6LcdPDsrtUQR1gR+bb3dVlQVw5nk
	ZkjJoxY3ef9uCVE++79Le/JA4kl214V04T3PcKnOaWZb/iKhkivtAKzhtIRaClNX1GRBy7YgDLC
	LNSoF+kbI+ax8nvTZEm0c6+1bJuQE1KNnw+bg=
X-Received: by 2002:a05:600d:82c6:b0:4a7:9006:b176 with SMTP id 5b1f17b1804b1-4bb55c5f5f5mr21265355e9.7.1794532427325;
        Thu, 12 Nov 2026 17:13:47 -0800 (PST)
Received: from MBP-von-Karl.localdomain (dynamic-2a02-3100-a440-c701-58be-494d-aade-0870.310.pool.telefonica.de. [2a02:3100:a440:c701:58be:494d:aade:870])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb55acdccfsm21838685e9.8.2026.11.12.17.13.46
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 12 Nov 2026 17:13:46 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Song Liu <song@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tracing: Keep preemption disabled until the recursion bit is cleared
Date: Fri, 13 Nov 2026 02:13:33 +0100
Message-Id: <20261113011333.20813-1-kmehltretter@gmail.com>
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

Function tracing can drop calls in interrupt entry and exit code, such
as irq_enter_rcu(), because it wrongly detects recursion.

trace_test_and_set_recursion() sets the recursion bit before it
disables preemption, and trace_clear_recursion() enables preemption
before it clears the bit. If the task is preempted in either window,
the scheduler's traced functions find the bit still set and take the
transition bit meant for interrupt entry and exit code. An interrupt
that arrives during one of these callbacks then finds both bits taken.

Disable preemption before setting the bit and enable it after clearing
the bit. The preempt count helpers then run outside the recursion
protection, so they must not be traced.

Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Patch 12 of my larger RFC series [1] also moved the RCU check and the
trace_recursion read. This version only moves the preempt calls.

Assisted by an LLM.

No Fixes tag. Most callers had the same ordering before ce5e48036c9e
("ftrace: disable preemption when recursion locked") moved the preempt
calls into these helpers.

The preempt count helpers are __always_inline, except on arm64, where
inline implies notrace and Song Liu's series adds an explicit
notrace [2].

Tested on v7.4-rc2 in QEMU TCG with PREEMPT, PROVE_LOCKING and
FTRACE_RECORD_RECURSION, running the function and then the
function_graph tracer while forking processes. On x86_64 and arm64, a
test module also sent IPIs to a CPU inside an ftrace callback.

Calls dropped as recursion, two boots each (function / function_graph):

                 v7.4-rc2       + this patch
  x86_64         0-12 / 14      0 / 0
  arm64          4 / 6          0 / 0

This also reduces use of the transition bit, which Steven would like to
see removed [3]. The remaining users are mostly interrupt entry and exit
code, which the early-hardirq series [4] is meant to cover.

Functions on other architectures that needed the transition bit,
whether they got it or were dropped, counted by a test-only hunk:

                 v7.4-rc2     + this patch
  i386           123 / 123    13 / 14
  ARMv7          118 / -      3 / -
  riscv64        115 / 116    17 / 18
  ppc64le        84 / 90      6 / 8
  ppc32          67 / 89      3 / 5
  mips32         76 / -       7 / -
  mips64         87 / 107     5 / 7
  sparc64        70 / 87      3 / 5
  loongarch64    114 / 119    11 / 15
  s390x          15 / 19      3 / 4

FTRACE_STARTUP_TEST passed with this patch on x86_64 and arm64, and
gave the same results as v7.4-rc2 on i386, ARMv7, riscv64, ppc64le and
loongarch64.

No result on PA-RISC (crashes) and sh4 (does not boot), or for
function_graph on ARMv7 and mips32. Baseline v7.4-rc2 behaves the same.
s390x traced only scheduler and interrupt entry functions, because full
tracing stalls under TCG. csky, microblaze and xtensa were only built.

[1] https://lore.kernel.org/all/20261022051654.79224-13-kmehltretter@gmail.com/
[2] https://lore.kernel.org/all/20261023011049.1164625-1-song@kernel.org/
[3] https://lore.kernel.org/all/20261015084821.3fcf69bf@gandalf.local.home/
[4] https://lore.kernel.org/all/20261028033127.82193-1-kmehltretter@gmail.com/

 include/linux/trace_recursion.h | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/include/linux/trace_recursion.h b/include/linux/trace_recursion.h
index e6ca052b2a85a..a7c66313bf360 100644
--- a/include/linux/trace_recursion.h
+++ b/include/linux/trace_recursion.h
@@ -132,6 +132,8 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	if (trace_warn_on_no_rcu(ip))
 		return -1;
 
+	preempt_disable_notrace();
+
 	bit = trace_get_context_bit() + start;
 	if (unlikely(val & (1 << bit))) {
 		/*
@@ -145,6 +147,7 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 		bit = TRACE_CTX_TRANSITION + start;
 		if (val & (1 << bit)) {
 			do_ftrace_record_recursion(ip, pip);
+			preempt_enable_notrace();
 			return -1;
 		}
 	}
@@ -153,8 +156,6 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
 	current->trace_recursion = val;
 	barrier();
 
-	preempt_disable_notrace();
-
 	return bit;
 }
 
@@ -163,9 +164,9 @@ static __always_inline int trace_test_and_set_recursion(unsigned long ip, unsign
  */
 static __always_inline void trace_clear_recursion(int bit)
 {
-	preempt_enable_notrace();
 	barrier();
 	trace_recursion_clear(bit);
+	preempt_enable_notrace();
 }
 
 /**
base-commit: 7475ea8b58616b33c04afb976cf0fbaad9dd63fb

-- 
2.39.5 (Apple Git-154)

