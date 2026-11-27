Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.14
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795817440;
	b=T2E6KxJwX9e4JrWDzBRrCsNbIStCXzmGZO0aDltgQwj4Ky5APt8RjSV9mhXrNNnhV/TK
	 T/+AzZ1rC3VpJfCDt4eJWlnBC0NoYCvzDYH/4oR8ccd3RrMDNtJv0ZL2hYDAyzLjtXtuk
	 Pu0wgwV7eTGsPW6R8X9yzU93qEdf2yigKmdUXZk3m8XkiEiLrcldLJqa/kNryEKWVk5jq
	 iM8UmHeuukVUlRMMnpZ7Ue+zh3Axc5ALJZKUydKuuQPVLG1oIYN8txS+BgUcZQhKrG+cu
	 S8Kd9s5BAvCj82FwXJRiGs1WbNKQysdeZTNPOIIDuAc+NgaUsA+LRPMwKoDkvVDTWpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795817440;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 X-Rspamd-Queue-Id:X-Stat-Signature:X-Spam-Status:X-Rspamd-Server:
	 X-Session-Marker:X-Session-ID:DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=mJT5K7gegm6ISBCrj1RV8eBhZdoveK/Y7YwBFdWGiSU=;
	b=4NnLFBiU41RWKNMkvtZcFHG7Y9EspUZj807UhLh2Dc/DIL8WYUFR0puDGLLEBRmEaM0Q
	 rAbfKVnvN77KqsFRL9ZU7+LQ3DxkeH5p4d7yP5nDinGNvcNdDHzkTgnuhNpONivthNMds
	 MO9SRtH328QpDXBs9ScTcPfm+W4FYx4/uchBDwIHZXq2f5+vDMpYMdmEfKkVz3UNTMQoX
	 MVvA1sJiG5beqH1DcU6b0ywoZvEvFPU2FfcZxDJ5XQqoqPP8XPTK2paUo2g4bXMz8lFEw
	 G79XqpCFPFbi+0lX9Rceg9dcq7GdRdDmc5TVuMxl9NemeGaapq22Q2dAlequ9ib9JlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PTX3q0EO;
	arc=none smtp.remote-ip=216.40.44.14
Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62C95606A31C;
	Fri, 27 Nov 2026 22:10:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 62C95606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=PTX3q0EO
Received: from omf07.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id A1B4A1404F8;
	Fri, 27 Nov 2026 22:10:37 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf07.hostedemail.com (Postfix) with ESMTPA id CA35420033;
	Fri, 27 Nov 2026 22:10:35 +0000 (UTC)
Date: Fri, 27 Nov 2026 17:10:34 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Frederic Weisbecker <fweisbec@gmail.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>
Subject: [PATCH] sched/isolation: Have housekeeping_any_cpu() use
 raw_smp_processor_id()
Message-ID: <20261127171034.60e9de0c@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: CA35420033
X-Stat-Signature: fc8s379cbksce3ygb7a6n37donga3thf
X-Rspamd-Server: rspamout03
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19JMOyvqjAZHlGN5s05k8KxFP4SqFvkACQ=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=mJT5K7gegm6ISBCrj1RV8eBhZdoveK/Y7YwBFdWGiSU=; b=PTX3q0EOxs6JiW3tu8vPDMDeI2XDlktTxMiHQ2cNMPLyzuuFh5vad+/aFK3zRXTPRqyXjHt3XtH7PR+tjK7E5N3Mhvm6Y9EyQH7nim/52Wx+PiR+If7H/lnZPdeTwMMWvM3GnJzQo2cmZxOdJTv26R4K78Q35Fa+ItvBlIUlv1k=
X-HE-Tag: 1795817435-336239
X-HE-Meta: U2FsdGVkX1+7aESZXbZ7YhIdH0h767AMJQ0cCK3lys1hEyED/wdSQ+GiDQLFWWlTS9s4Fd1j8SeMBIMngMSlp5CSmvJrIShetqRS6UMqY08Flkax+MY2vLcLRxTgPI6eNv8cUB26Y3+MlyfJjp3BAg+TDDZDmFkhmCB3kpF380lg7vywsBxjHOUZSlch3wkjdLYWwU0qgc7ObQKe1ffhXLUTG1hsy2brdCr5Q5N9vNtJJtlNU3N5SOb1146bVKp3iGcrpaDmhP/AKWmzeJhkt29Ac6c6OPHNtvKIJmFYcXVw3KNYqKXXsDexyjIwKQ5ej83Dyp+QEisM8m/gVv7eFRriWkJG1C2DHAC55cEJppLwCk/Q9IQY8q+5HyAA0Xzk

From: Steven Rostedt <rostedt@goodmis.org>

When isolation is not enabled, houeskeeping_any_cpu() returns the current
CPU via smp_processor_id(). If this is called from a preemptable context,
it triggers a WARN_ON():

  BUG: using smp_processor_id() in preemptible [00000000] code: ftracetest/21785

As the function is to return any CPU that is for house keeping, it
doesn't make sense to require it to be called from a non preemptable
context as the result is not guaranteed to return the current CPU anyway.

Use raw_smp_processor_id() to suppress the warning.

Fixes: 7863406143d8b ("sched/isolation: Move housekeeping related code to its own file")
Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 include/linux/sched/isolation.h | 2 +-
 kernel/sched/isolation.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched/isolation.h b/include/linux/sched/isolation.h
index cf0fd03dd7a2..81617d5c8e69 100644
--- a/include/linux/sched/isolation.h
+++ b/include/linux/sched/isolation.h
@@ -50,7 +50,7 @@ extern void __init housekeeping_init(void);
 
 static inline int housekeeping_any_cpu(enum hk_type type)
 {
-	return smp_processor_id();
+	return raw_smp_processor_id();
 }
 
 static inline const struct cpumask *housekeeping_cpumask(enum hk_type type)
diff --git a/kernel/sched/isolation.c b/kernel/sched/isolation.c
index 156025ef81b7..c1c84d72c7c5 100644
--- a/kernel/sched/isolation.c
+++ b/kernel/sched/isolation.c
@@ -99,7 +99,7 @@ int housekeeping_any_cpu(enum hk_type type)
 				     type != HK_TYPE_TIMER);
 		}
 	}
-	return smp_processor_id();
+	return raw_smp_processor_id();
 }
 EXPORT_SYMBOL_GPL(housekeeping_any_cpu);
 
-- 
2.53.0

