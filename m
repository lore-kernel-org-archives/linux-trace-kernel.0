Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795896133;
	b=lBaSLJ1E3SRdcJldD5PS5zD0mANAyL1895vs7DcMg3bJpYhJbIqqjF1H/pi/iFhGmoIV
	 /zl78MHqCu84od40Ow5s8jzsDreXun0dhUaCFNiKTGMHMLt8hR918HbfNAQe1nKLj5fJs
	 xnx78A3kQf8h8CZSeCa48cmDwjwPlKj5R6ENOariBlK2QvvonsDHos7F8D2CGfv2U1Rcw
	 2krsO0xWY0IC68DPxjQJ4CycDf/ZFT5etTEXW5vIvHVQQCz8r5efBSrLNmhovXoLSg5QG
	 cuK8s7zZ1OU5EEtseG98DQVm+o9lWl1fXlzR5zFpSJ3J4Xl8ycnrFLGkNr/bzpl7ZGA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795896133;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=5csytN22Xria0D5E/Z3CiCZztRWdZXqwTIdR9Eu+60E=;
	b=ltJ0caiWHYrbUY7KJpi69SqmYDON5kn4ZVDsEgY1lIxSpws02GfnaF9t29zFkXEoOEg6
	 8rKeH7YSE1Zsagnt1HHOrq5X4yTcNtBg4DT6/Y1SDsYloOZlcbo0add+D1XUH0EQb5j+6
	 1EnI8TjwvZTmUeMu/BgLYkiJGQ+VMqMTusxsfnzMhybYT8+Vpge02QfZfh6uvoDeevixu
	 Ksc0wnqfojAEc2DONZIS+r8VtcufOsXA0XavbE3xKDIlQICmBY5/MMaeV959JNvYqwlxG
	 2AvVyK1l1VxHohJi+j853T8Y9tuLVKO2SVKpSkEgj+gJArB+u7zYU5+BhsCDcEWHwcg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjboqvep;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0258606A31C
	for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 20:02:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0258606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=sjboqvep
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4bb64ef5a14so88885065e9.1
        for <linux-trace-kernel@vger.kernel.org>; Sat, 28 Nov 2026 12:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795896131; x=1796500931; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5csytN22Xria0D5E/Z3CiCZztRWdZXqwTIdR9Eu+60E=;
        b=sjboqvepKvOp84v74Rn0+T58ei7BxsJrAL5ekhK9NYkJeef7oHZ/9PCFd81TOpB/3C
         GZwMK+yeynWU6e7Vfo1o3BXFcBufJ47hJ0OPie8LmmGYRPMezFG7m2wBs8E/CqCvS4jX
         NLALo/sVXerFqFf+mSpklnQYyCPdOqmLe0zR4NoITN+ddRR4jz2N+timpa7o/3+WbeiX
         utByJW9bDTOgmGiUb1/Inn2sMM8THwl5D5xDZL8+4F/ec2O/cqaAr5B4098jcZ1etBFg
         WNz8iRmCiLgpO4tW88s6sl0k7PAIqeczdYCu2BfbHrem/PZCWW5CcSEFkl4Nfc/JtnEM
         ncRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795896131; x=1796500931;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5csytN22Xria0D5E/Z3CiCZztRWdZXqwTIdR9Eu+60E=;
        b=yx3bAMM/f4ftx8TTzs9GnWLarxLy5rDaC7rEZVob1ZVuayFawtYfI6bLreDnzxjrPl
         S0hQyzrUVcqhtdTNOGxirniepXCsO5NAFLIteQpI39w265sIBSO4lbXC/JOKSw1tquvJ
         nKapzj7C+qcir1ZKqnnZk+HdXDMgwfglKYD9NBZGa43DFcwqzo888rigTVAwocoRl56A
         /9GPfzUUcs+86edO9Wq177nQqQmYsG1n0hxFyQvedi6K5zR3yw+2jBuBAayEqmpIhcCW
         IwM7N8knhaZHU/shy3SD4Ts+1zK/GBKt7UU9X+HMn1LeKbzbGj18iGemBXXEZou6v4Uv
         GnMQ==
X-Forwarded-Encrypted: i=1; AL+hErHIVZ4yl/ORUSWjjB6sgP2mUv8FKeMV1XOMJf5akkv331FnrbH98cXCwVNsNi1/4mdytGmLlAvWKqEqqMUaPkDNkLU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8zQunfXXMclxo5YBX/S9iPYYz9oThhn6Y8F4FRCFi3bSDiJ9Ca
	Oviu8vKOBnow+Ki2i+WOthYA+2aD2yv/tcApxefZvEAvJ62tPUN60mG7
X-Gm-Gg: AZFdTZd0Qd+eWxrmsNoF/UAVq4CRPAaGhS2s0HDq394EZ6H2yyO2AfiV7NpCWQlUt4Z
	mYjC3GOBJnDIaByCD9ERZfBDEHkpM7mh1FbIdF3KF3XCf7CMb+6zRIPCF+Ki2ZuCVdPR9FXDv4q
	1TFOh4PostB2Xa9lFFL2K8ISXnHC+MfwYOV+MUXpL97zc3MeA7JdDtulTZElTeCBguGya5Fwlcd
	T5EWnsomr7gQRdB1qQRdlMb8P+bGBGB7YtHJD4/9ZTFGAFssGE8UeOM4/NjupnpJrKn1rdejP1O
	U2ap5plJTIDiekmPZw7cL2BIZCSjw7cqYBEHocUO+AlfPiZigmc7F+E7HJXB4lk25auhaAZEZBm
	KoGCqjehnXxuKIDl35EyntlYerG3HnOI3+6oSPNu05k6iEx5uJFB0g3LGciofRrKj/vGlTlJbkx
	Qr1/ClDM+hK0TfDnIxBQYWKUjpvI5gCaEg41HbV4jRfgJ674sgt6yn2iQZ/OCn7lBIKg7hx+MFO
	z1FEhyeeQXLOQjWjhnjbSiW9l89BhtfyHQcmGFKjsfMhKM7eVV5lKQTRR+TZQfqespCnHd/LFat
	tBkNngWXJgxlROlbfOXxDEzSM51ekK3XoWhqCL0EHg2CdJYgNR1t58qeq+hoTwEcUZuL8fW9Xee
	22HSnm2kM5vaAEOkR8+nx9qQ8b7vSwy2kxZwh1sQ4lUD0xqMNeHFrsm1wZldlszfddeAFKoVP1k
	70UAh5mJQ+hh1r1+kfVOPb5dpro7xwg4gq
X-Received: by 2002:a05:600c:6290:b0:4bb:741d:eba with SMTP id 5b1f17b1804b1-4bb88824a5bmr564086485e9.13.1795896130922;
        Sat, 28 Nov 2026 12:02:10 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a02-3100-a9a0-e301-d19e-76f1-f69d-bf77.310.pool.telefonica.de. [2a02:3100:a9a0:e301:d19e:76f1:f69d:bf77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b2c9sm56770333f8f.31.2026.11.28.12.02.09
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sat, 28 Nov 2026 12:02:10 -0800 (PST)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Nam Cao <namcao@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] rv: sts, nrp: Fix UP build with CONFIG_X86_LOCAL_APIC
Date: Sat, 28 Nov 2026 21:01:57 +0100
Message-Id: <20261128200157.6496-1-kmehltretter@gmail.com>
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

Building sts.c or nrp.c on x86 with CONFIG_SMP=n and
CONFIG_X86_LOCAL_APIC=y fails:

  include/rv/instrumentation.h:18:17: error: implicit declaration of function 'check_trace_callback_type_reschedule_entry'
  include/rv/instrumentation.h:19:27: error: implicit declaration of function 'register_trace_reschedule_entry'

arch/x86/include/asm/trace/irq_vectors.h only declares reschedule_entry,
call_function_entry, and call_function_single_entry when CONFIG_SMP is
enabled (and irq_work_entry when CONFIG_IRQ_WORK is enabled), so
if (IS_ENABLED(...)) still references undeclared helpers when disabled.

Guard these probes with preprocessor conditionals in attach_vector_irq()
and detach_vector_irq() to match the header.

Fixes: d0096c2f9cfc ("rv: Replace tss and sncid monitors with more complete sts")
Fixes: e8440a88e56b ("rv: Add nrp and sssw per-task monitors")
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/trace/rv/monitors/nrp/nrp.c | 30 ++++++++++++++++--------------
 kernel/trace/rv/monitors/sts/sts.c | 30 ++++++++++++++++--------------
 2 files changed, 32 insertions(+), 28 deletions(-)

diff --git a/kernel/trace/rv/monitors/nrp/nrp.c b/kernel/trace/rv/monitors/nrp/nrp.c
index 4b5646a..48a268b 100644
--- a/kernel/trace/rv/monitors/nrp/nrp.c
+++ b/kernel/trace/rv/monitors/nrp/nrp.c
@@ -29,25 +29,27 @@ static void handle_vector_irq_entry(void *data, int vector)
 static void attach_vector_irq(void)
 {
 	rv_attach_trace_probe("nrp", local_timer_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_IRQ_WORK))
-		rv_attach_trace_probe("nrp", irq_work_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_SMP)) {
-		rv_attach_trace_probe("nrp", reschedule_entry, handle_vector_irq_entry);
-		rv_attach_trace_probe("nrp", call_function_entry, handle_vector_irq_entry);
-		rv_attach_trace_probe("nrp", call_function_single_entry, handle_vector_irq_entry);
-	}
+#ifdef CONFIG_IRQ_WORK
+	rv_attach_trace_probe("nrp", irq_work_entry, handle_vector_irq_entry);
+#endif
+#ifdef CONFIG_SMP
+	rv_attach_trace_probe("nrp", reschedule_entry, handle_vector_irq_entry);
+	rv_attach_trace_probe("nrp", call_function_entry, handle_vector_irq_entry);
+	rv_attach_trace_probe("nrp", call_function_single_entry, handle_vector_irq_entry);
+#endif
 }
 
 static void detach_vector_irq(void)
 {
 	rv_detach_trace_probe("nrp", local_timer_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_IRQ_WORK))
-		rv_detach_trace_probe("nrp", irq_work_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_SMP)) {
-		rv_detach_trace_probe("nrp", reschedule_entry, handle_vector_irq_entry);
-		rv_detach_trace_probe("nrp", call_function_entry, handle_vector_irq_entry);
-		rv_detach_trace_probe("nrp", call_function_single_entry, handle_vector_irq_entry);
-	}
+#ifdef CONFIG_IRQ_WORK
+	rv_detach_trace_probe("nrp", irq_work_entry, handle_vector_irq_entry);
+#endif
+#ifdef CONFIG_SMP
+	rv_detach_trace_probe("nrp", reschedule_entry, handle_vector_irq_entry);
+	rv_detach_trace_probe("nrp", call_function_entry, handle_vector_irq_entry);
+	rv_detach_trace_probe("nrp", call_function_single_entry, handle_vector_irq_entry);
+#endif
 }
 
 #else
diff --git a/kernel/trace/rv/monitors/sts/sts.c b/kernel/trace/rv/monitors/sts/sts.c
index 2a044cf..b5ff582 100644
--- a/kernel/trace/rv/monitors/sts/sts.c
+++ b/kernel/trace/rv/monitors/sts/sts.c
@@ -30,25 +30,27 @@ static void handle_vector_irq_entry(void *data, int vector)
 static void attach_vector_irq(void)
 {
 	rv_attach_trace_probe("sts", local_timer_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_IRQ_WORK))
-		rv_attach_trace_probe("sts", irq_work_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_SMP)) {
-		rv_attach_trace_probe("sts", reschedule_entry, handle_vector_irq_entry);
-		rv_attach_trace_probe("sts", call_function_entry, handle_vector_irq_entry);
-		rv_attach_trace_probe("sts", call_function_single_entry, handle_vector_irq_entry);
-	}
+#ifdef CONFIG_IRQ_WORK
+	rv_attach_trace_probe("sts", irq_work_entry, handle_vector_irq_entry);
+#endif
+#ifdef CONFIG_SMP
+	rv_attach_trace_probe("sts", reschedule_entry, handle_vector_irq_entry);
+	rv_attach_trace_probe("sts", call_function_entry, handle_vector_irq_entry);
+	rv_attach_trace_probe("sts", call_function_single_entry, handle_vector_irq_entry);
+#endif
 }
 
 static void detach_vector_irq(void)
 {
 	rv_detach_trace_probe("sts", local_timer_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_IRQ_WORK))
-		rv_detach_trace_probe("sts", irq_work_entry, handle_vector_irq_entry);
-	if (IS_ENABLED(CONFIG_SMP)) {
-		rv_detach_trace_probe("sts", reschedule_entry, handle_vector_irq_entry);
-		rv_detach_trace_probe("sts", call_function_entry, handle_vector_irq_entry);
-		rv_detach_trace_probe("sts", call_function_single_entry, handle_vector_irq_entry);
-	}
+#ifdef CONFIG_IRQ_WORK
+	rv_detach_trace_probe("sts", irq_work_entry, handle_vector_irq_entry);
+#endif
+#ifdef CONFIG_SMP
+	rv_detach_trace_probe("sts", reschedule_entry, handle_vector_irq_entry);
+	rv_detach_trace_probe("sts", call_function_entry, handle_vector_irq_entry);
+	rv_detach_trace_probe("sts", call_function_single_entry, handle_vector_irq_entry);
+#endif
 }
 
 #else
-- 
2.39.5 (Apple Git-154)

