Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39E2F74068;
	Thu, 21 Nov 2024 07:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732174748; cv=none; b=LNDKP58CCPMp5UNvedchr0qdsyBzYWsKBEuCRt5qm6XopFFy2b1K+jzj4cB60uqZWPb0s3zyilp0f/iME2ZDAJ+c5UlwRYZEfnkdMJSMT+cjl7/nw+YyZetdgTKDlAEfaHQ9xw0PvkToeI8Y7Ge5k6B3t1k58xdidg3CX9tQw8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732174748; c=relaxed/simple;
	bh=0mNbvn1SFyjy2OOqBy9OO9VK2ZbbcJPMtV0ZKO8QwvY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rS+Kz5NIm6ojk0BlXPsOBINt/XT7s2lXcDbYCKd+r71AymIrH1N7HQZA2HSJB/DmA1ng6Dx73CVaBNI2/jvjlgQiPe9ZydSibMGVZrZFWyY/+BYLZ3pC7cyqsiGBt7A7QhDmdvlI00NPzYjrKMnkX6gcg+gB8nGXATb+n3NtA+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DGvKlbka; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PxXPMGND; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DGvKlbka";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PxXPMGND"
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732174736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xn0nijE3Gdm1C3OOWwYkq9mZCdk+DfIymWGjrWpc1L0=;
	b=DGvKlbkaZESL2BDPHwxlsem3KaSSGLL/Wqi/0jZqiR2tlqiH6YdiA1/88hCfzfJtBm2fV6
	SvwCEcMcHPvPP2KcXHI/SVR+/dTqPLlee7qIq4KaJ/khs63BRWe/bZ+KdukVrqUy7oYA9u
	ISYS3bH52yR1UKaomc+yDmi42DStMDOto2/vIygYQxatSTmz58NoaLKb4j7kf8yv9Vrr2k
	LDAyAOraDmaMQQG72+EfPP47QG3z7O8KhATpCR5yRtZQDD5np8vnU5TTrd7G7nLnFzOfCt
	jX5NyNn9HlWK/XZmAQNbJUlo10Q8QwWmpsEa5TolJa/Ne9zkz5ntVHsLRbSdbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732174736;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Xn0nijE3Gdm1C3OOWwYkq9mZCdk+DfIymWGjrWpc1L0=;
	b=PxXPMGNDyh4uQu0sfU5R5dn6qxE6jBGsomBOpLLWV3uYCx7TE2J1VrqIHOZPWmiETtbjfN
	O573Q19HLExh8wBg==
Date: Thu, 21 Nov 2024 08:38:08 +0100
Subject: [PATCH] kprobes: Reduce preempt disable scope in
 check_kprobe_access_safe()
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20241121-kprobes-preempt-v1-1-fd581ee7fcbb@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAF/jPmcC/x2MWwqAIBAArxL7naBSkV0l+uix1hKVuBGBePeWP
 mdgJgFjJGToigQRH2K6TgFTFjBv47miokUYrLaVMVarPcRrQlYhIh7hVtq1tvE11oubQSrxnt7
 /2A85f2EJ5aBhAAAA
X-Change-ID: 20241120-kprobes-preempt-09826f5e5d9c
To: Naveen N Rao <naveen@kernel.org>, 
 Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, 
 "David S. Miller" <davem@davemloft.net>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Clark Williams <clrkwllms@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 linux-rt-devel@lists.linux.dev, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732174733; l=3905;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=0mNbvn1SFyjy2OOqBy9OO9VK2ZbbcJPMtV0ZKO8QwvY=;
 b=0/TI3xrXhoMu8f4MLWUEecTzN5qTwekglXesD5hXPBW0zgprOOY5TJlu77HnFvZtH2feUt9nl
 A8DxuuU5eyFDCkU18dDNjsrowncAgxh0wFczEbILmRKiGlVruP/Qa0S
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

Commit a189d0350f387 ("kprobes: disable preempt for module_text_address() and kernel_text_address()")
introduced a preempt_disable() region to protect against concurrent
module unloading. However this region also includes the call to
jump_label_text_reserved() which takes a long time;
up to 400us, iterating over approx 6000 jump tables.

The scope protected by preempt_disable() is largen than necessary.
core_kernel_text() does not need to be protected as it does not interact
with module code at all.
Only the scope from __module_text_address() to try_module_get() needs to
be protected.
By limiting the critical section to __module_text_address() and
try_module_get() the function responsible for the latency spike remains
preemptible.

This works fine even when !CONFIG_MODULES as in that case
try_module_get() will always return true and that block can be optimized
away.

Limit the critical section to __module_text_address() and
try_module_get(). Use guard(preempt)() for easier error handling.

While at it also remove a spurious *probed_mod = NULL in an error
path. On errors the output parameter is never inspected by the caller.
Some error paths were clearing the parameters, some didn't.
Align them for clarity.

Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 kernel/kprobes.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index da59c68df8412c4662d39d3e286d516e8cee9a69..369020170e832a34ea9c05eda6693bded02ec505 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -39,6 +39,7 @@
 #include <linux/static_call.h>
 #include <linux/perf_event.h>
 #include <linux/execmem.h>
+#include <linux/cleanup.h>
 
 #include <asm/sections.h>
 #include <asm/cacheflush.h>
@@ -1570,16 +1571,25 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	if (ret)
 		return ret;
 	jump_label_lock();
-	preempt_disable();
 
 	/* Ensure the address is in a text area, and find a module if exists. */
 	*probed_mod = NULL;
 	if (!core_kernel_text((unsigned long) p->addr)) {
+		guard(preempt)();
 		*probed_mod = __module_text_address((unsigned long) p->addr);
 		if (!(*probed_mod)) {
 			ret = -EINVAL;
 			goto out;
 		}
+
+		/*
+		 * We must hold a refcount of the probed module while updating
+		 * its code to prohibit unexpected unloading.
+		 */
+		if (unlikely(!try_module_get(*probed_mod))) {
+			ret = -ENOENT;
+			goto out;
+		}
 	}
 	/* Ensure it is not in reserved area. */
 	if (in_gate_area_no_mm((unsigned long) p->addr) ||
@@ -1588,21 +1598,13 @@ static int check_kprobe_address_safe(struct kprobe *p,
 	    static_call_text_reserved(p->addr, p->addr) ||
 	    find_bug((unsigned long)p->addr) ||
 	    is_cfi_preamble_symbol((unsigned long)p->addr)) {
+		module_put(*probed_mod);
 		ret = -EINVAL;
 		goto out;
 	}
 
 	/* Get module refcount and reject __init functions for loaded modules. */
 	if (IS_ENABLED(CONFIG_MODULES) && *probed_mod) {
-		/*
-		 * We must hold a refcount of the probed module while updating
-		 * its code to prohibit unexpected unloading.
-		 */
-		if (unlikely(!try_module_get(*probed_mod))) {
-			ret = -ENOENT;
-			goto out;
-		}
-
 		/*
 		 * If the module freed '.init.text', we couldn't insert
 		 * kprobes in there.
@@ -1610,13 +1612,11 @@ static int check_kprobe_address_safe(struct kprobe *p,
 		if (within_module_init((unsigned long)p->addr, *probed_mod) &&
 		    !module_is_coming(*probed_mod)) {
 			module_put(*probed_mod);
-			*probed_mod = NULL;
 			ret = -ENOENT;
 		}
 	}
 
 out:
-	preempt_enable();
 	jump_label_unlock();
 
 	return ret;

---
base-commit: adc218676eef25575469234709c2d87185ca223a
change-id: 20241120-kprobes-preempt-09826f5e5d9c

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>

