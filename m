Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794923174;
	b=zgSl94mjH62ygAD544m3YwJLxm4C85GkeAiBUMh/C89PiStDfqXMj1V5RhjseapH6exQ
	 3Khi7pgfXO5X/ob+zHCZ4yqJ5sgUsDuEYv2abuHHTee/s5z938zIEp4OVTCgYWAUHI+oh
	 fQhCHA5/ByDoYCaHS6SMZ225Hcgd7vwEhqY6fKF04/5BgcZ2PUsQOq84xC/XyuT9zEUr/
	 IDriVzglrVDJOe+a6d15GdWLeW0jucVgW+YUP3jNfUkfQwjRO9t26wHOcCyn/YZRHUUE6
	 z9LXcQY5PgmHCpdEQLborvnpRdFpjs1r6HeQbhYtP6L+unJJ/ecqdFcGRqZ20yxTy+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794923174;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=iNYXgW14YJe8oSqCFEU11pf6U/rhOa8i8bpr+7yIhtI=;
	b=oGpEUC+CkQRV0f3dqTjGJhxVjGJSh/NtVDd5Ufqk4JP7V6qyrVkUds7FhPBIXYNORG2G
	 qKIgasdkjCjhlioDwAox8IjZrk+HKWCJLkS/o2JWKWXaBVtm1aSF/w7kBS31zBO+I6gze
	 p9m2DtY9zfoEp/DRAsmbALteBBoN3wU6fHn6Kg5S8AGp7kd4Lc6oeFuKcq54d0gysS5oA
	 SLhEdehkK9nEJ229ggsGW38AyOReLD1NDhCGqWQH40ID+QxLLRjafUW52Eopp8HlDXBf4
	 bIln+eZci5riMUrqlCY3waE2a1G826JR6ZKruoeJljYG+owyeHMU6zS0Oxb3Obo8y7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TqwR8CQT;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C72606A32C
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 13:46:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9C72606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=TqwR8CQT
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso4913588f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 05:46:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794923172; x=1795527972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iNYXgW14YJe8oSqCFEU11pf6U/rhOa8i8bpr+7yIhtI=;
        b=TqwR8CQTdLUXOb25oFu3C4dDWkXJrCfASgUeJ8SYiGfF4qzgU9jorovVEAXvr68pj4
         2UfImRI9WA+qYM0zYTgWutMfzQRATFOY55TJYa7kRM4FslsYdU1QeJYUGMxngjv4+PpA
         IoRlqJ3A7658+EgPzAtOz1qIbqCoiyDEQvFUc76Hoi7cA4RO+aPvnmf93vLT02SfzViM
         xtx0zinDEUHEVkBhY+59EBMWxZCqL/HrLytWFk4DtonWZitnlOPh06RhZUxCUDiqNGAg
         hQIgkyy8E10Y71whp8DdURZ3raXbYvxuG4j6ZAMWjE0IP39O/P6Whz1DEYqD2k4s6VeA
         SyhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794923172; x=1795527972;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iNYXgW14YJe8oSqCFEU11pf6U/rhOa8i8bpr+7yIhtI=;
        b=MAQEFy4IeMVOBUcUPCtkdxMAC2tjskjSF0hTLSsmfx5nH50oZoDFklxEa8V89zoscU
         pEUQaa8Esw5U5xUjiQudelG8gWKMg74TK8xUbaDAz0MAt0FI8WgKasZV8g8lxjdwSxpf
         IQBEE/e+HhUXanvAMLJv10Hw+ijMiXgcHhKY51xSQctN2+8biKt7BI+D+u/YA4/LyIqy
         gjncMqBuHiMRQUVyWqciOcuL4zKQkpiK0/fVn/6hH7xQPspKhvJ+TkJnPc1o5I8VdRId
         n/pKwGOqCBxZChhCE3FzNue6CqgltosC95YPq7bExx3CDduRHRaNhB245xJsIy9mXx18
         tZ+A==
X-Forwarded-Encrypted: i=1; AL+hErF1coe4aBVxaLPcB2gytjGoR7wfqJvnezA3jC1VdhxnEksGS3Cbkhz6fHfMG2d2r2heMBMmVl/vJ6xZCJ0bYZqUHJU=@vger.kernel.org
X-Gm-Message-State: APuU4Z8+P+lRLQoiZ4ytmTABdTG9m43tLspm6YbYAVt6yTj5Hxv6D6r1
	ApAR96ySGODCle1xPmnVssAZ4uBVQq615Au+GRaXKVWLiDOJeAGtv/RI
X-Gm-Gg: AZFdTZdz36EZO1xKrz7jsMfDn1710iU4JyaKcSM59Y6sut6/ClFI6vLznzbHfX7txtt
	JE4RNT6ITMqayqyNKDrq2jaKn9VudgNUdPigb5EmFhcEctOTY591kqREAGCi+1RFUQD8NFg/2nx
	lBBsNiRuDPGKgaNqRy4ebg3YIaSCt1vAPkpDJV1aKfSq8Hc9HFH6GIJRnAdMj/CgTNEEuHGpOvm
	2FtlQ5DCfCRrWipNDzCycP6SlBIRslq6r5Tb6rboqePHo2S+UPaUy4AXwpCK9OV/sr60XJLt2jq
	oUHM8t2OEHwojPfS7TC+SiHJ1A9XVmQ0acw5kMuYO5OweWit/iT49iPpP1AbSwntGu9jbxa+p8/
	eMma9NQVlaUxVcvYbNDpge+9pEnoI9tl3sgfuHEHHG7XZ+4mdIGybYbKTN/ty+MWig/kotA9vjw
	I72xq9OrnLRqLc8G5X0+TfVE/RmzpQnkG9uuUoBAgph2hEqFz+MpH1TwJNLmb8g38tjumVm204b
	FJgZO4TrVBvaiUkUQDbW6m6pXw+9WkfEIBqGhlC/9+ZBuXdMTzYaIQuNS1QEwk3KVPyJ7ao7ZbO
	ZoGuG0KcxTMQDE5XvhVmQnGjjlrEI56lHFoUEbkpJo6VdFyu9blkinB+oWL0C7JpaLjQA32ET1Y
	nYEXEkUGNQ/VfM66IkggSRLGa31BwV0D8k479UOA=
X-Received: by 2002:a05:6000:2006:b0:490:6e0f:a024 with SMTP id ffacd0b85a97d-49c70b051bbmr31562779f8f.13.1794923171789;
        Tue, 17 Nov 2026 05:46:11 -0800 (PST)
Received: from DESKTOP-0KSTGNI.localdomain ([41.44.127.147])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c888b90d4sm28285028f8f.9.2026.11.17.05.46.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 05:46:11 -0800 (PST)
From: Temitope obabi <obabitemitope765@gmail.com>
To: broonie@kernel.org
Cc: cezary.rojewski@intel.com,
	liam.r.girdwood@linux.intel.com,
	peter.ujfalusi@linux.intel.com,
	yung-chuan.liao@linux.intel.com,
	kai.vehmanen@linux.intel.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-sound@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Temitope obabi <obabitemitope765@gmail.com>
Subject: [PATCH] ASoC: Intel: Remove unused intel-sst.h trace header
Date: Tue, 17 Nov 2026 15:45:38 +0200
Message-ID: <20261117134538.1251-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Commit 970d299b0a0a ("ASoC: Intel: Remove unused code") removed
sound/soc/intel/common/sst-dsp.c, the only file that defined
CREATE_TRACE_POINTS and included trace/events/intel-sst.h.

Nothing includes this header anymore, so none of its tracepoints are
built. Remove the unused header.

Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
---
 include/trace/events/intel-sst.h | 148 -------------------------------
 1 file changed, 148 deletions(-)
 delete mode 100644 include/trace/events/intel-sst.h

diff --git a/include/trace/events/intel-sst.h b/include/trace/events/intel-sst.h
deleted file mode 100644
index ae7c269b0824..000000000000
--- a/include/trace/events/intel-sst.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#undef TRACE_SYSTEM
-#define TRACE_SYSTEM intel-sst
-
-/*
- * The TRACE_SYSTEM_VAR defaults to TRACE_SYSTEM, but must be a
- * legitimate C variable. It is not exported to user space.
- */
-#undef TRACE_SYSTEM_VAR
-#define TRACE_SYSTEM_VAR intel_sst
-
-#if !defined(_TRACE_INTEL_SST_H) || defined(TRACE_HEADER_MULTI_READ)
-#define _TRACE_INTEL_SST_H
-
-#include <linux/types.h>
-#include <linux/ktime.h>
-#include <linux/tracepoint.h>
-
-DECLARE_EVENT_CLASS(sst_ipc_msg,
-
-	TP_PROTO(unsigned int val),
-
-	TP_ARGS(val),
-
-	TP_STRUCT__entry(
-		__field(	unsigned int,	val		)
-	),
-
-	TP_fast_assign(
-		__entry->val = val;
-	),
-
-	TP_printk("0x%8.8x", (unsigned int)__entry->val)
-);
-
-DEFINE_EVENT(sst_ipc_msg, sst_ipc_msg_tx,
-
-	TP_PROTO(unsigned int val),
-
-	TP_ARGS(val)
-
-);
-
-DEFINE_EVENT(sst_ipc_msg, sst_ipc_msg_rx,
-
-	TP_PROTO(unsigned int val),
-
-	TP_ARGS(val)
-
-);
-
-DECLARE_EVENT_CLASS(sst_ipc_mailbox,
-
-	TP_PROTO(unsigned int offset, unsigned int val),
-
-	TP_ARGS(offset, val),
-
-	TP_STRUCT__entry(
-		__field(	unsigned int,	offset		)
-		__field(	unsigned int,	val		)
-	),
-
-	TP_fast_assign(
-		__entry->offset = offset;
-		__entry->val = val;
-	),
-
-	TP_printk(" 0x%4.4x = 0x%8.8x",
-		(unsigned int)__entry->offset, (unsigned int)__entry->val)
-);
-
-DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_inbox_wdata,
-
-	TP_PROTO(unsigned int offset, unsigned int val),
-
-	TP_ARGS(offset, val)
-
-);
-
-DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_outbox_rdata,
-
-	TP_PROTO(unsigned int offset, unsigned int val),
-
-	TP_ARGS(offset, val)
-
-);
-
-DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_outbox_wdata,
-
-	TP_PROTO(unsigned int offset, unsigned int val),
-
-	TP_ARGS(offset, val)
-
-);
-
-DECLARE_EVENT_CLASS(sst_ipc_mailbox_info,
-
-	TP_PROTO(unsigned int size),
-
-	TP_ARGS(size),
-
-	TP_STRUCT__entry(
-		__field(	unsigned int,	size		)
-	),
-
-	TP_fast_assign(
-		__entry->size = size;
-	),
-
-	TP_printk("Mailbox bytes 0x%8.8x", (unsigned int)__entry->size)
-);
-
-DEFINE_EVENT(sst_ipc_mailbox_info, sst_ipc_inbox_read,
-
-	TP_PROTO(unsigned int size),
-
-	TP_ARGS(size)
-
-);
-
-DEFINE_EVENT(sst_ipc_mailbox_info, sst_ipc_inbox_write,
-
-	TP_PROTO(unsigned int size),
-
-	TP_ARGS(size)
-
-);
-
-DEFINE_EVENT(sst_ipc_mailbox_info, sst_ipc_outbox_read,
-
-	TP_PROTO(unsigned int size),
-
-	TP_ARGS(size)
-
-);
-
-DEFINE_EVENT(sst_ipc_mailbox_info, sst_ipc_outbox_write,
-
-	TP_PROTO(unsigned int size),
-
-	TP_ARGS(size)
-
-);
-
-#endif /* _TRACE_SST_H */
-
-/* This part must be outside protection */
-#include <trace/define_trace.h>
-- 
2.53.0

