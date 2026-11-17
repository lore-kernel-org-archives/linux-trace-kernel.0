Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794953231;
	b=qnrnMNmHYV1FBfZsnFCLnWt9bLBDQ4m3fSUkNAKoQ4WDS6sY0B76FZjG+VTxTL3B7R6B
	 JczRbhzBP33rKUrYTm9SEcDOtGcJRSNcjEbMK9z4IoJ9hw7/WQnPaEUMK1AFqSWbzoYl2
	 gRUo7PwE4/Bjpp+P7tUAkYPQpplttoW1Q5dIukgk+uSN9rQ4T5XXX+gr0oGzf2f1+DpKI
	 szGNPa19axumM4qp9TESlvkiUebjvOUMbZ6tzBQjnVkABsqsf3KMgFDn/55y/4NXX9BPp
	 lQtGoP33/fmJ68qAZwiWPRyhcxetmo18TAW97EgwiRsevTjQVk51Iftq8/ufdTo2zMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953231;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=2GBjuuLx2RWaDTkuZWX477BOGa5Oz0VCn9xw/zNR/10=;
	b=RQBv2bC/yvtgtZ7PXpgGt7R2fVZ1+Hs9SSasORQEnuy7pu5qsz7F/Tls1YxQVIU9pv+Q
	 VdXLThKpdGXJ3Guj5DrwyH3vDjou3+aABOU89Sp8IKaYg1cxJXb0IJ0AwAcOuFRQORihj
	 6KFXPrX/ht8ujjG5pnfq+sBdy3CEI5IoaF3hXnlN28/cpbab9Ns+O98I/Vg/gGazBp3fl
	 ur8NyZe3g3f4eCD8H1BW1ObXyQbJYUeOaPoj1pPsp87ZPYpsGwH1gPMtWasdcq5q9go88
	 Pb46rUv9LdRI2jtUGvCO3dGS9iIt/jIffbh0rbBObveetont40OOVz5RdUmv1387/TQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjMcTPAa;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA4A3606A32A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 22:07:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CA4A3606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=YjMcTPAa
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so3650435e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 17 Nov 2026 14:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794953229; x=1795558029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2GBjuuLx2RWaDTkuZWX477BOGa5Oz0VCn9xw/zNR/10=;
        b=YjMcTPAaCNLwh8YsFsR8o8tzBojZaFxao/nIUzjkmHeCAnTlRnk18p8hhIrmyoFrb0
         WY/MtG30d17cQePBcSMFTOf9TW5ckUX8s3qtayr3oPTvHhkOYgayFQeLgs2nU/NWw0hq
         rXgqZRMiPeaA+mhjiJfK9Gs9lqp8vlL/AZanTe8OEw/GQzlFe+IXt/WBGsHQm/aVqHAH
         fuO+GY3GFEDPNs1OiWvgGeQs8Z8MKNNrkZwTXxGj2sigIWdJaAzrdj+8loP05qbF257K
         kC5VCdfiH/15c4x6wJBwoRdbu9dLVd7/yED+i1EnuKg6jeP8ScbCPhPN5rjuuF9q/QEc
         WZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794953229; x=1795558029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2GBjuuLx2RWaDTkuZWX477BOGa5Oz0VCn9xw/zNR/10=;
        b=qfhhwvGb18lM0zfLaij+82eY8+ZFEsWE91FRkLNtXLQsOUMk/uRhHmVOQ9qC8SSamK
         cnGUfi4rDRQ3ORoDn9E201twklLkf8zLauxy0qAfxER2e3fbFvQplM6XLTSnKF4Pr/n2
         haw1a2gSLWKchgkPHjoaGD/R81A497B3EPg8q0ik+j7aaao3xKIJWlHarYCU7f//BqdW
         mS3WBjitaxmupvbspxdkBazcvKi6FePC1ll0fEtVwdt1dVyoIgmMPD//UCo+kpSwatE2
         ZN5G5npZujO3QNMu0h5+LuKkpbMBkLRx+z0rWbs/3wGYw7svXwSk0A7CqxFn+nPhEiWk
         YZbw==
X-Forwarded-Encrypted: i=1; AL+hErEb38BW6+Kp+WY8Y8HXQ0j7l9Q/YLJ2plT6SQdA4eeKgEg/Wb8syC+Htiv8RSMAWpBQYCovgMlPf2WaPgB8fx2C4Kc=@vger.kernel.org
X-Gm-Message-State: APuU4Z8w2jzjuRVB5i4YOAZgsKRmdRnOc0JPsSsPu08L1Czuut18NJNx
	flBCv+LGNP53LX6dNk68yzmrvtWA7+8qme/WGIu4liY7oAYzlKuvX5Z0
X-Gm-Gg: AYBFou1zrSzgQGu14fM+Pbd5tveM+vrEbEWdsL8Bbh5Yiey4ncrxMkS+ye6iXCcnnt/
	pqPnH6ZdSGKPuPAq4s16bXawZ1XfMwK4O7xbujWk7I+/CrKlTwMebZqrqPcedQcJNhcNbgyogj2
	bgMnnkFs0MfwZ9AJDuD7Io7pL4aDzphXbzzUPb1wXHjWKFYNfbGYgHoXSrXq+/XJT4aHZlfvKuw
	RPI+QDjOhj233d8K0c/8CEStPLHVu4/6UsJ+/P0StoU6J7Sl/nbFzb/2hZmbB+n/gpwE3z3xqiV
	tcUhOLHSnJoRgQhAQ0tWQPt+JK1eF2TBG6XvAJDnkPPzJvHsvRwJNjD4jwKTPhpIM0v0FL2T4Wg
	AcdRlbOILuTeOcV9zW237BcKftputWG7aAgt/6ssh9Oyk1vSZJF/RxqR3pv3yBTWhKDEOGOQ5Lt
	8T42P0m68VE/A6ZAfLxUmR3WTHqnDp6OYbKi9CJktYN58805epHVXRuVt/I8PfHWmFgqiSEAMS1
	VWtM9thPzuCsSjO/WkV279RsDm95FC6XwgLvaffLDeemLIUhgYFypgwj5cSUwpY88s1giQVlKGN
	lJH4sGtUn7OGCwaF0WWMu5pZKXRWzFjuWVNGEDpMa86NapYI6M6CCR5Ay3cAn0Erqb9EiBO1dE9
	u0FkJ+s6Re1z3/dTaIePMTu8P/6E8s1wr8mQobQ==
X-Received: by 2002:a05:600c:3e19:b0:4bb:659c:b8db with SMTP id 5b1f17b1804b1-4bb7da18500mr9671815e9.12.1794953228777;
        Tue, 17 Nov 2026 14:07:08 -0800 (PST)
Received: from DESKTOP-0KSTGNI.localdomain ([41.44.127.147])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb7d2b8032sm15360655e9.10.2026.11.17.14.07.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Nov 2026 14:07:08 -0800 (PST)
From: Temitope obabi <obabitemitope765@gmail.com>
To: broonie@kernel.org
Cc: cezary.rojewski@intel.com,
	amadeuszx.slawinski@linux.intel.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-sound@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Temitope obabi <obabitemitope765@gmail.com>
Subject: [PATCH v3] ASoC: Intel: Remove unused intel-sst.h trace header
Date: Wed, 18 Nov 2026 00:05:57 +0200
Message-ID: <20261117220558.2702-1-obabitemitope765@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111223102.1310-1-obabitemitope765@gmail.com>
References: <20261111223102.1310-1-obabitemitope765@gmail.com>
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

Fixes: 970d299b0a0a ("ASoC: Intel: Remove unused code")
Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>
Acked-by: Cezary Rojewski <cezary.rojewski@intel.com>
---

Notes:
    Changes in v3:
    
    - Rebased on broonie/sound.git for-7.5, which already has the earlier sst_ipc_inbox_rdata patch applied.
    
    - Added Fixes tag.
    
    - Added Acked-by from Cezary.
    
    - Added the people from commit 970d299b0a0a to Cc.
    
    v2: https://lore.kernel.org/all/20261111223102.1310-1-obabitemitope765@gmail.com/

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

