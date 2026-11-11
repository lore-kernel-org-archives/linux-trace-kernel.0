Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794436362;
	b=ft6wVl4CETQM417lT+rG1nIKo300uHTF2Vng0fOoBVdapysaUdCFS39dFCn6StndvOfq
	 Ys+NH8vve4MABc94NIqlYTLAXOLvQn4viT7IsY35XRlK1dz++7DJqtwvjogcf8VAqHBFZ
	 H0lwUTRoqWoc8q2dCHCCEUizbg5agjE4/qkm4GZ3iuqo2Cj5X6SPJUL2F7Ttc2Uepdj5+
	 OfjYrAAOgY92IIOQy6gavCIobpiaBnETcUB9c98wzObwV7v5xxzgElxULlJMIHp6FOfLc
	 yhDpkkFCzKTawMI/EFP2z0R4V1l3TgXtxxzkaBkM3f7QwoeSJMMsU5uINrmQRkJTKJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794436362;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=ifjkH+2k40MmZV7RSbPynQ7YvHJ4bk5X1IWs8GsBC/M=;
	b=FMfWxEN8CGD4LY1Bv6ApExKlQ82tspwfyjoHQGD8IdRsTMv0h3CTHGclS+cSq9eH+vDE
	 LCVl0Eg/vgA0bUPD6ClHqpbHrNBAn3DrpMsD+7D5WV7lpy+Q9YOUYS3rofVmd+ukMSTfA
	 5JSKuMIL4T6fDQRomnqCY6oNmwHzzsJsRDg5FNuWU6QeHNndlJ9+8Zo/FYQQfqNK3W0X+
	 t+7QAjOJPzdGJzMB54m7FYYj7rT9Xg70LOc+ieY4YzsLsU5rbM3yoLGfzmcBqMnGXdnPG
	 +sk3htFEUN3ts5I+8zC8Xqr/1cIatYOaH9ob4l0Y1HPO2EUFDWlV/sv8osVc8PA9s3w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8Gc1mFV;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250F9606A32D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 22:32:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 250F9606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=Q8Gc1mFV
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4b4571ff080so40828535e9.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 14:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794436360; x=1795041160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=ifjkH+2k40MmZV7RSbPynQ7YvHJ4bk5X1IWs8GsBC/M=;
        b=Q8Gc1mFVPVMJ7Kc526aYIIYaPlqHJb/kg30LX16srMTTFtW8mTJJVYR3Vvk9GKpN8x
         SzWST2y5RrhIWkmHRPq2674Bs6mUVvK+RDaMZZ9CbBsl1gOK+oM+HbD/ZZNAVfYAoZj+
         x63/uBZDVSgruZhKsPKYVX1kwMxcPjHH2uy+TXqDxLWqaoeZ1nyvYkVbdUChiUT48y8S
         43Op2zvSrze6xKkKQepttO5SdxeWgGsDM6VNNOTT/L5ltXA+E3zGoA9AW98lqjgBidfI
         XtMUcZKel9XEeb+SvrogKwvQspT5aBA4TW8dvoXkkcse30vsKNLIzpBSl7Aeok55T3AG
         AiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794436360; x=1795041160;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ifjkH+2k40MmZV7RSbPynQ7YvHJ4bk5X1IWs8GsBC/M=;
        b=qXiaD/JH9AwAB0X4VH72RAY11GWT1YmXQQZPO2fUF9i/zykhsNbR+RrIiLxrh62BOt
         NY0HzMScoHDnj5myK0NdRpkf/l7IsVXbxesc9WGh3hYGdlCFC7KcS44CcLt6pkvMEhHQ
         obldwDXGk2E8irw4XybZ8JaXIoMIux2tvTzNr6OXFMC52dSxujUUPLoIKFyGQWwdDQe/
         LWo8PwqSZEWshQm3MaN1i23g9Di8oHJKLojydrcja/F6mUWwRZwmQxs0fb1MQKUsMt3H
         NLkG7TV4QB31vJwpe0KL77BoWiPJ0Yd/u5qdx3IQwkPMHT9KtoKzWX3GvgbsEgFOPi02
         MXgA==
X-Forwarded-Encrypted: i=1; AL+hErGf6zfOOPtx61UHGmaMTpMsPo5wzG6F6OVOi4jKQ/GlySIp90tp+n2GJRL+cs9/hn0aU05Z2ymukIo3DtBmbSYe5oE=@vger.kernel.org
X-Gm-Message-State: APuU4Z+KhircidQQMzRakljo66uInMV9ny8Acu7DE465KU42YtbV6re2
	9dzRGDrinf5jCq96/zZcNLKOkDqoyD22sVgU61DyCele6whQ0Bi7JrQ7
X-Gm-Gg: AYBFou2mIY44+zZAv2OgjiFWPFsZXaxs3bauAuQbPHcNEqDX2Rv3RvyQVDX9itu5FHe
	N2wplCItehmAc7vVtKULnNbCBzbV5OpmIKz81Vv+ZTFBdoM84giLZzLbjaUcsvF/XQW7cWq12Iv
	goqomzCuqidVzOwwBrQomnbP124RlyPMJbe0aV7fBl3f0CFu5aOxqzprsQfsVhp07Cz6rOfyHeE
	6sZ9TNGSdf6wdBTWspt4SSa8AyyOaTj28LlnATVOwleTAU5LiwQvwgJgxStcy6hhuYCQHj6RpJB
	26glaZraI0khHiw360j7qR+c5CIPn/Ax7N2mKHhh+F+wVNmxgEfWhZVoe5mSgjMsxSVh/8NX0+p
	DkVEuLlPMpq26Cx5RO/Mkq9dfi8azP1hCcSBhlyXWe/aakp4wa6VY7hoMcHgdFyv8jkK+W1t94O
	FTVyMgoLXOhT1osOPSrVTLg5hsTpCeufoaat8mC5qKLCuCtKcbv3rP7r8y3WhJKjpTmFfzj6tdA
	rtRs19l5fiAqJ7EpBi5klUW5zbwJjUJCn9F+pPSG501KUXEJaJjvp1q5u/eqD3VQ1WB8KoGhOBt
	PEYT38QK8U2/KJR+viGIdyG6aGlsQEh3MyDmWq8u+fzbJjjGaQWuuIlOB4/AJZw8P5bycK0Y+QJ
	hDtfkuguWT0GmBm5bjfoqnjNyt6J3Kk8IvKZOmLE=
X-Received: by 2002:a05:600c:1986:b0:4a1:fa21:fd90 with SMTP id 5b1f17b1804b1-4ba09377221mr64220145e9.9.1794436360284;
        Wed, 11 Nov 2026 14:32:40 -0800 (PST)
Received: from DESKTOP-0KSTGNI.localdomain ([197.45.135.182])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e1f9e5asm18247355e9.0.2026.11.11.14.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:32:39 -0800 (PST)
From: Temitope obabi <obabitemitope765@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Temitope obabi <obabitemitope765@gmail.com>
Subject: [PATCH v2] ASoC: Intel: Remove unused intel-sst.h trace header
Date: Thu, 12 Nov 2026 00:31:01 +0200
Message-ID: <20261111223102.1310-1-obabitemitope765@gmail.com>
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
Changes in v2:
- Remove the whole header instead of only sst_ipc_inbox_rdata, since
  nothing includes it (reported by the Sashiko review of v1).
- Drop the Fixes tag and the claim about memory used per tracepoint.
- This also replaces the earlier sst_ipc_msg_tx patch for the same header.
 include/trace/events/intel-sst.h | 156 -------------------------------
 1 file changed, 156 deletions(-)
 delete mode 100644 include/trace/events/intel-sst.h

diff --git a/include/trace/events/intel-sst.h b/include/trace/events/intel-sst.h
deleted file mode 100644
index 0416e91f8181..000000000000
--- a/include/trace/events/intel-sst.h
+++ /dev/null
@@ -1,156 +0,0 @@
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
-DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_inbox_rdata,
-
-	TP_PROTO(unsigned int offset, unsigned int val),
-
-	TP_ARGS(offset, val)
-
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

