Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792468337;
	b=OcZ1j4vF7Vwf/t04mosBIW1wCHjfRwqblykvhz5TSswEvL/gXVpJilysMPb75TBQG+qw
	 rtxIyUdW8V1VhIX/vk79mk31X9ZN8RrtlGE2RuYLT4JUQgg8AJnsRgP4opsx9lJAOKKW+
	 ESQtpA+Dd3cclA94iWxWQ1QVHODmn0qLy7Lir7PRGfqxX7RBJy0edw9nVFK8z6Sf6T7vu
	 5qLNQyC5qRH7y66g2c2KSOY1lwk9Se8L6O3n3iqbVnE5OHaxFPcXnumc0Bj9wJiWRTOox
	 fbROMQZ7wWBSd5bxMialoN1C8xC1jQvhnnvaBEgYmeSxa2gvq1u53GEFgvn9Mv8Q1GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792468337;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=p6i3Nyqj9VM8axM0TbP0nxGC8kaEPnrFMpaIGWIrppM=;
	b=nbHbCBNy8UBjsXtWKPNJyOpgWOuhMNq+w46HR6Qf0qZTYW98ekifj1e+R8SBdlsF4khm
	 OA5SWpCmsMtRkMuJGV4KzPydpOG38cfDBtponucmJJPCxA2pDkY6hWUSu0/wnaKDhaBOl
	 fS18zHwSB7TYcp6IAKJfBGFv2PYZThZaphzQkyiC4M307DXWKUPlJ8yXR3RX9/WFiVFC6
	 uk6rrBNEqGwtc8O2TzhVu3tA7wW5IScMsGvSnqI+vOO5JwuV3HgPhBhj+uSt0dOkq2/7G
	 jeINaBhneBxDsyHsb7KVmBhdR+N2A2ZUPyHkG1p5hf9r+U5ZEOHrBVRddF2rMkK5iKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O1lw4mFR;
	arc=none smtp.remote-ip=209.85.128.50
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FF65606A31A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 20 Oct 2026 03:52:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1FF65606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=O1lw4mFR
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4a1e3098ee2so21451435e9.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 20:52:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792468335; x=1793073135; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p6i3Nyqj9VM8axM0TbP0nxGC8kaEPnrFMpaIGWIrppM=;
        b=O1lw4mFRi/skXUvJdvDqHe+9u+ZmKs08VVKzN14/tEC2aR2MBmRqAbTK5YeeyRVmE4
         9t0vlNRCi4OzaqvfethRNyJpdvt7Pt+RfdQKoVaWDSVUjJ2Wj7WoGBN1uWjdiz7XpIln
         6kSuyHRJW4u5DD7ibNtavP/SsZa4j2wn+xgcKLh7QHBQQh4KCaJjMRzLmfXtClCVAmLL
         AmniQiYXn8tDf9Cv1fmiW2ynqSDGWG6dmIfawGQ3nY0oon3MoUJ7cExawIQmIl5klHE8
         rKRH+v/lU04So1O5vOMEW/ug+BPI5FnuFdS6HLqJQYFAuhMR2rVHzPduFypWe1cGp+eX
         jYjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792468335; x=1793073135;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p6i3Nyqj9VM8axM0TbP0nxGC8kaEPnrFMpaIGWIrppM=;
        b=SsrM1e4wfPU5lcUYRBMkN2N1Q0PpZPqFAzSJsWNOqlU5g2abPlXsZSlH/YaRP6AlUD
         yP5iiElTAYeCVUZ7K7IfHfaRmkALjgz25R7R8KAEfGST4ab5VJRi6NaM6f7qS0WTb0c9
         nysSVVZE1bcNE3aR8k2RT1Mb49mLxLYd2+QO6mQJhNoCJ65pe9n61Op0eXDZaVJGg7KL
         H0ImcUw8adQ2anvXFvTdUkuI9DqvZkpxK0Y3q5PtF2UTwejog11Q5lQSeEF4xew/SUJg
         4JCHjMI2Luw8YvyiJIKMQIA9at4iVRCmYctnkLGBoERuXELfMTFmUS/xyjNYc393nwjt
         ivnw==
X-Forwarded-Encrypted: i=1; AKwUvByid+/x7zQYa0Ga0sbvme3NmCopgfeyL3aLADsWo4a/lMc67f7xD0tJCX0if2D0G38aizg9qeAx5IqGyIEIsXfpiyI=@vger.kernel.org
X-Gm-Message-State: AFq9FYLMXbb9atXI8ZEBKyAj5LMkD5IyD5lpAXRnY1KNDG0i+o/I4MnW
	ywlopHYzpuwc3YuD7K9wosjZAeJ8vaQBGQVF/S6NMZQXj4Nw+cv77JAd
X-Gm-Gg: AYBFou23difYo9ocppdCw0WU+BYLCVbFje/2hRdH5Pm82fBr9onmC4+O2N76AwXxBrE
	Cx/xpcjcXtj5SJPYwKGquu4lLrVFuRCIworq3mgyhqxlLI4CZmgBzLqNgqsQodqMPYIkUX0GR4z
	NEjpS2MoU49icW4xy+TA1V32ifzw//ChwIGwgjuD4jz24ofKDQBL9/jLH4Cg5R/51/zbCRYimRv
	qx6WGZIvQpQBrDySixIaAoiaskENJwNQo7r8NaSIAaICjhdHJLy0pkkljVUA37Eue8vqhUEVBnJ
	rVWW4VWlZ3s1rqhbYv8/CRBUyqa2oKywfa+BXTO5voq7aLULDnbj3ra5SxbEKRqi1z0cefJi2Fn
	7hLv5o+I+ZZISEn0e29KKLeimXW+2eIbm1Z7H2eg8YP4VCP3C57Oxl0pUz3vUsRrRDL2buWadC2
	95Y4p7K8MagIigt73Kav6U/QahiCkFJw9JpDcC6Bfklvtq4qUKs8P/GALdt6rPxUtdhE5CpPbUu
	r4BQtMfilWd75S5n/+xgEvaC0X1xNof4Ur7WM3i3ZQlqw2BnG176Po+0IK0TSmzP9Pqm3Ch+AIJ
	0onXuBnpt5H+HxEp1z6O5x0ZSGx9GrkrKuZO/tBvXvhimcwuih40R59MHI4k2DHidrTBgoFUiZB
	Maw==
X-Received: by 2002:a05:600c:3554:b0:4a0:2488:71cc with SMTP id 5b1f17b1804b1-4a1d76234a3mr201359065e9.32.1792468335363;
        Mon, 19 Oct 2026 20:52:15 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-9c92-6501-cda9-90cd-4e49-75d9.310.pool.telefonica.de. [2a02:3100:9c92:6501:cda9:90cd:4e49:75d9])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2d569d4sm39329925e9.10.2026.10.19.20.52.13
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Oct 2026 20:52:14 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rv: Normalize opid IRQ state to a boolean
Date: Tue, 20 Oct 2026 05:51:58 +0200
Message-Id: <20261020035158.90190-1-kmehltretter@gmail.com>
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

The opid hybrid-automaton guards compare irq_off with 1. However,
irqs_disabled() only guarantees zero or nonzero. On 32-bit Arm,
arch_irqs_disabled_flags() returns the CPSR I bit, 0x80. Consequently,
valid events with interrupts disabled fail the guard and spuriously
trigger the reactor.

Normalize the value before returning it. Add a KUnit regression test
that handles a need-resched event with local interrupts disabled.
Without the normalization, the test triggers a reaction on Arm.

Fixes: 2b406fdb33387 ("rv: Convert the opid monitor to a hybrid automaton")
Assisted-by: LLM
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
Tested with an ARMv7 GCC 16 W=1 build and targeted SMP1 QEMU run:
rv_test_opid and the RV KUnit suite pass.

 kernel/trace/rv/monitors/opid/opid.c       | 2 +-
 kernel/trace/rv/monitors/opid/opid_kunit.c | 6 ++++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/rv/monitors/opid/opid.c b/kernel/trace/rv/monitors/opid/opid.c
index 9ae619f176fa1..a14532cc41778 100644
--- a/kernel/trace/rv/monitors/opid/opid.c
+++ b/kernel/trace/rv/monitors/opid/opid.c
@@ -20,7 +20,7 @@
 static u64 ha_get_env(struct ha_monitor *ha_mon, enum envs_opid env, u64 time_ns)
 {
 	if (env == irq_off_opid)
-		return irqs_disabled();
+		return !!irqs_disabled();
 	else if (env == preempt_off_opid) {
 		if (IS_ENABLED(CONFIG_PREEMPTION))
 			return (preempt_count() & PREEMPT_MASK) > 0;
diff --git a/kernel/trace/rv/monitors/opid/opid_kunit.c b/kernel/trace/rv/monitors/opid/opid_kunit.c
index 3cb087a74241e..8aa1fb9c62344 100644
--- a/kernel/trace/rv/monitors/opid/opid_kunit.c
+++ b/kernel/trace/rv/monitors/opid/opid_kunit.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/kernel.h>
+#include <linux/irqflags.h>
 #include <linux/rv.h>
 #include <rv/kunit.h>
 #include <trace/events/sched.h>
@@ -17,6 +18,11 @@ static void rv_test_opid(struct kunit *test)
 	guard(migrate)();
 	KUNIT_EXPECT_TRUE(test, preemptible());
 
+	/* Need resched with interrupts disabled */
+	scoped_guard(irq)
+		rv_opid_ops.handle_sched_need_resched(NULL, NULL, 0, TIF_NEED_RESCHED);
+	RV_KUNIT_EXPECT_NO_REACTION(test, ctx);
+
 	/* Wakeup with preemption and interrupts enabled */
 	RV_KUNIT_EXPECT_REACTION_HERE(test, ctx)
 		rv_opid_ops.handle_sched_waking(NULL, NULL);

base-commit: c03c1a14507dfaf8b856c2608f9ac216021fc222
-- 
2.39.5 (Apple Git-154)

