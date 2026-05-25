Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 884E7277C81
	for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 17:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779728676; cv=none; b=KHxksZpU14W+dIsp98WaruPOcddUQF0sLoiabQImaH1AT6IzjksWdm3LzwCsiJT4ThTBIWiGQByZw/aPPDchqevpWhrdJmexapwt2Cf41SihYI3DrSvPIRB0hvA7FgKOWjUc12YQCzUyz+yu9CFtBNV+Q8I6ICxnFnPtt/8sPbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779728676; c=relaxed/simple;
	bh=PcXPCW/yoIMVKX3ScIB1BHyYd8omgOqK7kVsG8gOFJ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kTyJ1Ypxod7MZbhsXWurT4P/+ZuqIvShj5YVb/qSUZ3LXfl+cdi8+LUKGpJ0eQGV01ZwzZSyMgybcjys56s4+RJqtkizvfdNMgp4NeSUtHd53/Fq01DqhD1gRDEeN8+Us0LWoYlD0vWCmabyLpU/e+x5r7acapviGtltoYdaJGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pQZHmhkz; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pQZHmhkz"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-49068493267so7582965e9.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 25 May 2026 10:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779728673; x=1780333473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XmeW5o8MdJknDGHVfNB5TfOkmVnLEd+83DVfIpbufx4=;
        b=pQZHmhkzqk/V5HjdmRFkHep0tRcHxPsPNjnhT3MY79VRKMMCaSmY8g2NFw4p/wWP+h
         sUqTAkh9ufDfpS3GqwBHEdeD6OO0/9QMDW+5CVUDu6y7qzuORrXoOebn3/JMAXV53qDO
         h18jjUfd7cL1a0FsTdzp1qpYJcz3i083jnHTrkSCtaw0ewW+r/tu2Aq0pGXjhTzF4CCI
         Y+H8rO+Df47AQ7tBV8ty8QVTzBlB6VVEdPnvh+cluQVAcfftYTmFgxNC4ybiVCdyPnxs
         mIu1TA7nNwQOAWMv990wnZWqqBCMOVgMjSYPNHm0WOlIJjFC2bl44nLhlS+3JuNPCe3H
         1nBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779728673; x=1780333473;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XmeW5o8MdJknDGHVfNB5TfOkmVnLEd+83DVfIpbufx4=;
        b=dGCe1g1kQiNqynCJDbZepWJGHR4bz8IDNHvF9PsV9PQEdJICi+mc1Y8+ka63IWm1gI
         42lswHjBs4w1NU+dWj+n9q+8j7tsjkVWIwsdabNzpAYU3XNmHZ3ObbQLf8KzPx/t/FTf
         vIqVKqbxvVkWbe3Al90/DAAZUdTspOTFqxe3Lw9HXKGAakhcM8/EsI6ggnwDNsG7+CcO
         rwNaxpDuCrAv9qhacT17PlDe040Nmbs1jVXMVNGvN54wUKT49AvXeDNTaIGfHbQybCq1
         l5YJG11Cs6HWbXLEuDANsPGD0bOTlWpijZNaOxZJ1c7cCxjwEBoFOLUYNuG3itz/DKmb
         Oarw==
X-Forwarded-Encrypted: i=1; AFNElJ/82lUXwTLav78xzeJTtWkF3gog7Vla12qHM3DRpm/wDhyx8R/sSVCgriw4qUiNtPqDtliPxFmNKqR5UAmeTL6uHGo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyEoUw47USGPl3gXvwVfLTgg/4el1BnJPJHlwCfE1nBz8DpuVV8
	fQ7wQ7K71wFx2tXiEG/qUGi+XSOP/qmT2AMHPecA9MCfVXEySrdlurtr
X-Gm-Gg: Acq92OHi9Wxzjt75l+X9oETOUN6jqD12zWVmbwqxEf/flPTaI2ufrYMN9Qisi0luPa4
	RbzkfWprnc4VZyjxD6CWfzB6ry0wS3ctq/oFSuQdOuSPGNNf8YlA6xLnufgCzNMQcrXqyknb1BN
	vIY/pMp+5Hhj3YfDKDcFlYRHU2th5KBIB40G4o2gbAzBQOgtQuWRp1CalExmco3IGorlkChxudJ
	ktAz8vlyA62468boC2KDDvCa562xpQ3MdIWGyQ9maW66c54EiEBAAR08BNdlRcJO2kyPlvVP826
	TGerF7MaoBVKCA9XvnH66NCxOVp3/cN12e8oLE2L68v4Tdf9B4/fJ92WqzNEC7Z1G6BFFGMrjZf
	edZ779sbhlUdVJ+yYbq2qXUvkw2vLYIU3pym9yVUX6Q4r7PXEJKpMUDnBk+CfkvQXaulZ86qQ8D
	Qn/eBKzgyGG4xXttKRCt/Dngi3UKjiDvzHswgd2ZMtiHePEglFDzjkvx15gSPVA/GBDBrext1kv
	Y7i4xAvRUtG4Y1a7AMWD3Nlk3YFzmaKCFw4j5Ul3K7OSPst1mEdD8yILEwUq+hhoAXwuSPMTEzf
	pqTFQmjSgl8LMbo8MDxo61HoESD47xrasQtBO+bD
X-Received: by 2002:a05:600c:3106:b0:490:6889:1ff with SMTP id 5b1f17b1804b1-4906889025dmr54325725e9.28.1779728672490;
        Mon, 25 May 2026 10:04:32 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-a9eb-0401-e55f-5ad5-546a-1b1a.310.pool.telefonica.de. [2a02:3100:a9eb:401:e55f:5ad5:546a:1b1a])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490452580dfsm136970515e9.1.2026.05.25.10.04.31
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 25 May 2026 10:04:32 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Andrey Konovalov <andreyknvl@gmail.com>,
	Marco Elver <elver@google.com>,
	kasan-dev@googlegroups.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Karl Mehltretter <kmehltretter@gmail.com>
Subject: [PATCH] tracing: Disable KCOV instrumentation for trace_irqsoff.o
Date: Mon, 25 May 2026 19:04:28 +0200
Message-Id: <20260525170428.67211-1-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When KCOV runs its boot selftest with whole-kernel instrumentation
enabled, it sets current->kcov_mode to KCOV_MODE_TRACE_PC without
installing a coverage area. Any instrumented code accepted as task-context
coverage in that window dereferences current->kcov_area and crashes.

On ARMv5 Versatile PB with CONFIG_KCOV_SELFTEST=y,
CONFIG_KCOV_INSTRUMENT_ALL=y and CONFIG_IRQSOFF_TRACER=y, boot hits a
NULL pointer fault during the selftest:

  kcov: running self test
  Internal error: Oops: 5 [#1] ARM
  PC is at __sanitizer_cov_trace_pc+0x4c/0x90
  Kernel panic - not syncing: Fatal exception

A diagnostic run showed the unwanted coverage comes from the IRQs-off
tracer callbacks reached from ARM IRQ entry before hardirq context is
visible to KCOV:

  __sanitizer_cov_trace_pc from tracer_hardirqs_off+0x18/0x1cc
  tracer_hardirqs_off from trace_hardirqs_off+0x34/0x54
  trace_hardirqs_off from __irq_svc+0x58/0xb0
  __irq_svc from kcov_init+0x7c/0xdc

and similarly through tracer_hardirqs_on().

trace_preemptirq.o is already excluded because this tracing path can run
from early interrupt code and produce coverage unrelated to syscall
inputs. Exclude trace_irqsoff.o as well, instead of requiring users to
turn off CONFIG_KCOV_INSTRUMENT_ALL=y, which is the default whole-kernel
KCOV mode.

With the exclusion in place, the same ARMv5 Versatile PB QEMU test boots
through the KCOV selftest and reaches userspace.

Tested on ARMv5 Versatile PB QEMU with CONFIG_KCOV_SELFTEST=y,
CONFIG_KCOV_INSTRUMENT_ALL=y and CONFIG_IRQSOFF_TRACER=y.

Assisted-by: Codex:gpt-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 kernel/trace/Makefile | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 8d3d96e847d8..f934ff586bd4 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -48,9 +48,10 @@ ifdef CONFIG_GCOV_PROFILE_FTRACE
 GCOV_PROFILE := y
 endif
 
-# Functions in this file could be invoked from early interrupt
-# code and produce random code coverage.
+# Functions in these files can run from IRQ entry before hardirq context
+# is visible to KCOV, and produce coverage unrelated to syscall inputs.
 KCOV_INSTRUMENT_trace_preemptirq.o := n
+KCOV_INSTRUMENT_trace_irqsoff.o := n
 
 CFLAGS_bpf_trace.o := -I$(src)
 
-- 
2.39.5 (Apple Git-154)

