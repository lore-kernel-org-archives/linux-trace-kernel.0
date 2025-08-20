Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1671D27877F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 18:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755713465; cv=none; b=HXo+VY3z717lyEgM1p59h/bA3v486vJZh0OA6u1ouBfceZO6tKcFQYmItkyZV5JpUhTy18GCxKfUV5VNnCD1yECYtGAey7g7WIoFI6YBDL1gQR0M6figupS1IMRzWKSPEoJOaEz1UKXDjfnSf5U63naqbtraGTSwV12iwZdLy60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755713465; c=relaxed/simple;
	bh=a5AYMxBqdJDz6gkrxlobXlcTTsJboGuBBxIbO2fep+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FX5/zpN8IY7P4s1cfV+ZhDIjxYZhz+rOn7u/sGdwgKhDmclVUGxTmtyS3/7TN5sMdru3bLz3OnP66JHcvdNsflPgtFWaphyjv9UQU3sbVnLMeyicpKC31iq01cqhP84YY/yTq+KWnpW47WwLAI3Hpo3dJip2G/vqjEoddikQv6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com; spf=pass smtp.mailfrom=criticallink.com; dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b=ScQ5WqDX; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=criticallink.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=criticallink.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=criticallink.com header.i=@criticallink.com header.b="ScQ5WqDX"
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-70a9f556d65so2016036d6.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Aug 2025 11:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=criticallink.com; s=google; t=1755713463; x=1756318263; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OEg9IzJfORmEUVVC8tp3QP7XHlH+b0gTJgTrq0ptJu0=;
        b=ScQ5WqDXI7SNslQQibKXPDO/FwX/9aBx3xSJKPEDx5KdgublIoLF3dT3vmr0ozgTmt
         n2GaACW9DrM9DUUn3fIpN4vfn1ZjkqshxY8Udjdec9iURh5lMDT70YKxaTq3tYpqcZew
         a1U5m9AJi6rex4guVIAXBJ3PxNz1FvNy9jQNLflP9km9pr6jQLOgvvK9swyvpBTzgy0n
         F4f647uYzRZjHrI3Aq6LyAyExv551USMtZrPW1ZCCY3b9WTWbm5ohpcgOULh+kudcNH3
         VhZlhUaqtKTeIDvpR7tzTAs86+AHS09FOsddi410hhZZL+rvgb/x0AGfRlHFBPA4i+4Q
         4Ziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755713463; x=1756318263;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OEg9IzJfORmEUVVC8tp3QP7XHlH+b0gTJgTrq0ptJu0=;
        b=l50z6O9+zDDAZjW+TyvBcZTVYaOWY7fUbPL+3DO3014twZ4uhX8YQ/ZAVAnteX4ZTF
         dTxwjQqcUVW6udZNs/4CaSa4W9cVw9CdNtM5pQL6R76nEkGlMSxKnbDVSxRjG4aN3LZn
         M7M4Z7rp8RJNuVEomcg8kEwYNou53kgWVyLDAd4u2r0ECxhQXROC3ShxRfskWkIyhhFR
         q/WStycVxzSX/HXbs3AMK82zseFUMz5EiG/Whm9SKzSD7q6frbsPIxfymiotkDOW7Tw5
         bpAEBaMWX2+tOVbs+99LGFO0HyPTu/wHVU+d+e38XEI9C0rBpfIXSSPpoYErSeuap7m2
         QVxw==
X-Forwarded-Encrypted: i=1; AJvYcCWKK2CghMRZyd2ZJgX43Lhl0ASa2tnVwe2N4FqCjXZYp0mI/lUxVwboD494K15bvPGfkWAjoNzuVDxVfeVtHIc5TFI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4e8G+RPrWY+HHz5Zyoxbu5XdSVGkSpo69W5HwWgVjFIKLWve2
	kkE8WK+Lmqk9tZnyCkrsTta1e4Ehwnyt8myKanwhIsnVGCLnV4HPhM+PBMki9yYodMZBtAP5W1c
	KLPMfEg==
X-Gm-Gg: ASbGnctzMQsa8Vqsu/3vE7+avjExylN2RjaFkMSzS6mZwEoQhSd57eVc9iTyOaWs5+a
	8W13c8/5VeLSY57zz9m5+evZK/CFAH5cJqvuHHp+GNbKFQIm8ZRKevmyhVK6nrj4LTk70zmW11T
	8WFI6NeuCaT4DKs47DSnQa3cjf5dmoVX8rp4L7nfhG+Fqqbcto3mIQT9QAZJOAtQbCu6Z4XkAih
	4+uwRqFCO3489uIKUO5TQzMAYFz0VuzfppIcNFfdj0f4ikCbKiQdd/BO7Ym/2+zRJIIYfW1/bS2
	ovUtWwVnri133uxee5UcDFAKz+MI4YpN5Gilagq5jOq3u88OGO8FtX7pksU0s3MEvrvB04CcwTa
	ZQbTXkH27OlxHCCnWYQvvYS8tbzmzwe0waXJZ6iMVL5NgOM7GAf+qXI0XoaN8d8pz71Hsnxfwfv
	tLhjoBVB5YlgXuPY/4g9J1RnkG7yg3kNbc5ce44LTqSdts1A==
X-Google-Smtp-Source: AGHT+IEhwtbBn17CFSkW+x+E31JWfVdYnrpp1FxIk0F5/CAtt0bQ5xc/VvPHKPM3nmoyKj+xtB3uWQ==
X-Received: by 2002:a05:6214:d83:b0:707:6665:eb67 with SMTP id 6a1803df08f44-70d76fe0302mr39522186d6.27.1755713462700;
        Wed, 20 Aug 2025 11:11:02 -0700 (PDT)
Received: from jcormier-MS-7A93.syr.criticallink.com (static-72-90-70-109.syrcny.fios.verizon.net. [72.90.70.109])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e87e076811sm977497485a.36.2025.08.20.11.11.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Aug 2025 11:11:01 -0700 (PDT)
From: Jonathan Cormier <jcormier@criticallink.com>
Date: Wed, 20 Aug 2025 14:10:45 -0400
Subject: [PATCH 2/2] firmware: ti_sci: trace: Decode message types
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250820-linux_master_ti_sci_trace-v1-2-2a69c0abf55e@criticallink.com>
References: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
In-Reply-To: <20250820-linux_master_ti_sci_trace-v1-0-2a69c0abf55e@criticallink.com>
To: Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Santosh Shilimkar <ssantosh@kernel.org>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-trace-kernel@vger.kernel.org, 
 Jonathan Cormier <jcormier@criticallink.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4840;
 i=jcormier@criticallink.com; h=from:subject:message-id;
 bh=a5AYMxBqdJDz6gkrxlobXlcTTsJboGuBBxIbO2fep+o=;
 b=owEBbQKS/ZANAwAKAdzX/S4LNuuqAcsmYgBopg+y65DfxJcmBr7YNYJ54nyOqO3l3NJUMUR7E
 KADuw/pnDiJAjMEAAEKAB0WIQT/MozqCeZtYxNnVN/c1/0uCzbrqgUCaKYPsgAKCRDc1/0uCzbr
 qnB4D/0TzDsPJ7lRUNl2m1uohyDVNtltT1shOqGDs66CxsyOs6kuIzGUc+yEVSIhPMrkY1iKD8X
 G+heAKTVSssyrwBiEWItF318NblLONNj9uU8OPndwP39HMJgcPbC/9J3Gvr6S6B3SSsHSST4Svr
 CaVqCfxh+CNuVrnH2cM/MuNIG0yigWUZS5BkV88qdqG3xVykc91T769HPEqXkCuTc9Qn5SD1VXG
 T5A0FziX8wFILfXfBXLNztp2+jR5s2f89oYVQFyzZ9+xDLgIQKjIgEFm3sLLy4K1cBJOPjmFdPh
 g6dcdaNOX6fbRLAlBKebIXRn5xcDieK8IbY9NWRuIND9wrWTCRTBt8zyEJZXgmJpBpmwPEFavm/
 uLsyVSE1DJbQi+AQhzf0aghepy1gqWntTK88OXH4hgUeAN2ON8LsHcZOK+665FmZwuWrdbwHGpQ
 Q0VoETLzgwZdVkJ0BnYIlgIF5KTJ92rXaFJANPVsRbQGWHJvi6GJeFq3tdx9TkM9JvXgrAT6IhU
 hzfoGW3GvHCMmATRgHFiQeKyymbsD3sCoZEuvZ7nv5xq5eGNJdlc3MAtFsXh6Mig7EiUfWLDdsQ
 CNwsna+Yv4mGWYItziGkFwyXbqg6VR3rz7ddrJ+DQsUzrXNTK6ZuXPNnQqTtWV/4f0WXjSRbKT6
 UMSvOKeRXSdKAkQ==
X-Developer-Key: i=jcormier@criticallink.com; a=openpgp;
 fpr=FF328CEA09E66D63136754DFDCD7FD2E0B36EBAA

Make debugging easier by decoding the ti_sci message types

Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
---
 drivers/firmware/ti_sci_trace.h | 69 ++++++++++++++++++++++++++++++++++++++---
 1 file changed, 64 insertions(+), 5 deletions(-)

diff --git a/drivers/firmware/ti_sci_trace.h b/drivers/firmware/ti_sci_trace.h
index 7f99c41ea08aec6cf64d601576cad29b14c6ad5b..88a159e13907d7d7806b312a2ad3103c106d1972 100644
--- a/drivers/firmware/ti_sci_trace.h
+++ b/drivers/firmware/ti_sci_trace.h
@@ -7,6 +7,63 @@
 
 #include <linux/tracepoint.h>
 
+#define show_ti_sci_msg_type(x) \
+	__print_symbolic(x, \
+		{ TI_SCI_MSG_ENABLE_WDT, "ENABLE_WDT" }, \
+		{ TI_SCI_MSG_WAKE_RESET, "WAKE_RESET" }, \
+		{ TI_SCI_MSG_VERSION, "VERSION" }, \
+		{ TI_SCI_MSG_WAKE_REASON, "WAKE_REASON" }, \
+		{ TI_SCI_MSG_GOODBYE, "GOODBYE" }, \
+		{ TI_SCI_MSG_SYS_RESET, "SYS_RESET" }, \
+		{ TI_SCI_MSG_QUERY_FW_CAPS, "QUERY_FW_CAPS" }, \
+		{ TI_SCI_MSG_SET_DEVICE_STATE, "SET_DEVICE_STATE" }, \
+		{ TI_SCI_MSG_GET_DEVICE_STATE, "GET_DEVICE_STATE" }, \
+		{ TI_SCI_MSG_SET_DEVICE_RESETS, "SET_DEVICE_RESETS" }, \
+		{ TI_SCI_MSG_SET_CLOCK_STATE, "SET_CLOCK_STATE" }, \
+		{ TI_SCI_MSG_GET_CLOCK_STATE, "GET_CLOCK_STATE" }, \
+		{ TI_SCI_MSG_SET_CLOCK_PARENT, "SET_CLOCK_PARENT" }, \
+		{ TI_SCI_MSG_GET_CLOCK_PARENT, "GET_CLOCK_PARENT" }, \
+		{ TI_SCI_MSG_GET_NUM_CLOCK_PARENTS, "GET_NUM_CLOCK_PARENTS" }, \
+		{ TI_SCI_MSG_SET_CLOCK_FREQ, "SET_CLOCK_FREQ" }, \
+		{ TI_SCI_MSG_QUERY_CLOCK_FREQ, "QUERY_CLOCK_FREQ" }, \
+		{ TI_SCI_MSG_GET_CLOCK_FREQ, "GET_CLOCK_FREQ" }, \
+		{ TI_SCI_MSG_PREPARE_SLEEP, "PREPARE_SLEEP" }, \
+		{ TI_SCI_MSG_LPM_WAKE_REASON, "LPM_WAKE_REASON" }, \
+		{ TI_SCI_MSG_SET_IO_ISOLATION, "SET_IO_ISOLATION" }, \
+		{ TI_SCI_MSG_LPM_SET_DEVICE_CONSTRAINT, "LPM_SET_DEVICE_CONSTRAINT" }, \
+		{ TI_SCI_MSG_LPM_SET_LATENCY_CONSTRAINT, "LPM_SET_LATENCY_CONSTRAINT" }, \
+		{ TI_SCI_MSG_GET_RESOURCE_RANGE, "GET_RESOURCE_RANGE" }, \
+		{ TI_SCI_MSG_SET_IRQ, "SET_IRQ" }, \
+		{ TI_SCI_MSG_FREE_IRQ, "FREE_IRQ" }, \
+		{ TI_SCI_MSG_RM_RING_ALLOCATE, "RM_RING_ALLOCATE" }, \
+		{ TI_SCI_MSG_RM_RING_FREE, "RM_RING_FREE" }, \
+		{ TI_SCI_MSG_RM_RING_RECONFIG, "RM_RING_RECONFIG" }, \
+		{ TI_SCI_MSG_RM_RING_RESET, "RM_RING_RESET" }, \
+		{ TI_SCI_MSG_RM_RING_CFG, "RM_RING_CFG" }, \
+		{ TI_SCI_MSG_RM_PSIL_PAIR, "RM_PSIL_PAIR" }, \
+		{ TI_SCI_MSG_RM_PSIL_UNPAIR, "RM_PSIL_UNPAIR" }, \
+		{ TI_SCI_MSG_RM_UDMAP_TX_ALLOC, "RM_UDMAP_TX_ALLOC" }, \
+		{ TI_SCI_MSG_RM_UDMAP_TX_FREE, "RM_UDMAP_TX_FREE" }, \
+		{ TI_SCI_MSG_RM_UDMAP_RX_ALLOC, "RM_UDMAP_RX_ALLOC" }, \
+		{ TI_SCI_MSG_RM_UDMAP_RX_FREE, "RM_UDMAP_RX_FREE" }, \
+		{ TI_SCI_MSG_RM_UDMAP_FLOW_CFG, "RM_UDMAP_FLOW_CFG" }, \
+		{ TI_SCI_MSG_RM_UDMAP_OPT_FLOW_CFG, "RM_UDMAP_OPT_FLOW_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_TX_CH_CFG, "RM_UDMAP_TX_CH_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_TX_CH_GET_CFG, "RM_UDMAP_TX_CH_GET_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_RX_CH_CFG, "RM_UDMAP_RX_CH_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_RX_CH_GET_CFG, "RM_UDMAP_RX_CH_GET_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_FLOW_CFG, "RM_UDMAP_FLOW_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_FLOW_SIZE_THRESH_CFG, "RM_UDMAP_FLOW_SIZE_THRESH_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_FLOW_GET_CFG, "RM_UDMAP_FLOW_GET_CFG" }, \
+		{ TISCI_MSG_RM_UDMAP_FLOW_SIZE_THRESH_GET_CFG, "RM_UDMAP_FLOW_SIZE_THRESH_GET_CFG" }, \
+		{ TI_SCI_MSG_PROC_REQUEST, "PROC_REQUEST" }, \
+		{ TI_SCI_MSG_PROC_RELEASE, "PROC_RELEASE" }, \
+		{ TI_SCI_MSG_PROC_HANDOVER, "PROC_HANDOVER" }, \
+		{ TI_SCI_MSG_SET_CONFIG, "SET_CONFIG" }, \
+		{ TI_SCI_MSG_SET_CTRL, "SET_CTRL" }, \
+		{ TI_SCI_MSG_GET_STATUS, "GET_STATUS" } \
+	)
+
 
 DECLARE_EVENT_CLASS(ti_sci_hdr_event_class,
 	TP_PROTO(struct ti_sci_msg_hdr *hdr, int status),
@@ -28,8 +85,9 @@ DECLARE_EVENT_CLASS(ti_sci_hdr_event_class,
 		__entry->status = status;
 	),
 
-	TP_printk("type=%04X host=%02X seq=%02X flags=%08X status=%d",
-		__entry->type, __entry->host, __entry->seq, __entry->flags, __entry->status)
+	TP_printk("type=%s host=%02X seq=%02X flags=%08X status=%d",
+		show_ti_sci_msg_type(__entry->type), __entry->host,
+		__entry->seq, __entry->flags, __entry->status)
 );
 
 DEFINE_EVENT(ti_sci_hdr_event_class,
@@ -73,9 +131,10 @@ TRACE_EVENT(ti_sci_msg_dump,
 		memcpy(__get_dynamic_array(cmd), xfer->xfer_buf, __entry->len);
 	),
 
-	TP_printk("type=%04X host=%02X seq=%02X flags=%08X data=%s",
-		__entry->type, __entry->host, __entry->seq, __entry->flags,
-		__print_hex_str(__get_dynamic_array(cmd), __entry->len))
+	TP_printk("type=%s host=%02X seq=%02X flags=%08X data=%s",
+		show_ti_sci_msg_type(__entry->type), __entry->host,
+		__entry->seq, __entry->flags,
+		__print_hex(__get_dynamic_array(cmd), __entry->len))
 );
 #endif /* _TRACE_TI_SCI_H */
 

-- 
2.43.0

