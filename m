Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793831193;
	b=fnWqMR+SoPZKj5wg8CyxMXiquweoqMiHPz7HVj15QojKsVdHinINdwqYWAFhi9rtvb+Y
	 69rTg6bGOJTvqN7xouUrIwTJKY8YDn1VAZm2BxDZPFAamFLUQBQaU8kkAhjXWAEwgR1OX
	 e0H9OcmZoVo7bGkglXkN9LmFtva4+L6nUZEa+V9SoISNnUO8CavDIOf7FYYODriy5HN+r
	 DvPofMbRAXaEMV7neJvXhJ9MIBsl2jTwEb7QRp2xm8WgFCOMcWEBV9k9Jt5r4WTesJcxb
	 WlA9Oj/lA65q71m3myQzcsphhonSylIMExe0pvaIKP+EGnPiPVkM0QfYJw6Agafdvmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793831193;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9OWHZGyN+/phkIGg4cLIcv2N+SmxQEX4nd4X23tehho=;
	b=uasRS/DnS+Bjo2FtoUmHymfZCffnEANONoHyQSer+3g0x+zYtxbW5U8Ic3xIuCI8LfN+
	 /PloqyK61Je7OCe0Je4x1yLb58CDfr2WQF64JX4UxXadG8PiDt9sl5Pfg+gtCr3W3QT6w
	 mD8MQtFcvhNLSXqJxfq9RfH69lm8XPQzDZpOLGCO6eTtrANcXceCVxfMi07OZ9GWA2xyz
	 jypWO2FsZtNvrTi7JUceEq1Rlmb6mD2flQX1hadkzAGxYCORSXu2KrjojOP/eeHllQ9qq
	 Hwb7WoBuOSzEyjuk9is1hLBmOLV8Qpc7xEPekRAtJvo2Hh1SfWv1f5X+4MOjDOo1uag==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVMOSdef;
	arc=none smtp.remote-ip=209.85.222.49
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5A58606AB13
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 22:26:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5A58606AB13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=qVMOSdef
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-990fbae94f5so772247241.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 14:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793831191; x=1794435991; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9OWHZGyN+/phkIGg4cLIcv2N+SmxQEX4nd4X23tehho=;
        b=qVMOSdefGWOPaPhYgIsTT0/yu/T1lgjF8OEFRqSM2f2ZDa1Va/tu3lWDeXvMSDjUCe
         JUleXfuq8jlUzkzkdU5pKHhwpEcEAKVzemhf5cq9Sz9qvnGHqpEG5eCkf+rlgSJCfFIM
         HAcixp4IuzoD2l83xDIZLlKDmaLRZst55kLFR5HXOGq9Avx+ynl0m2xtW/GNoBzq4frL
         oFAEaYVbR9Sho2NO7OAbA6rwDygZZ5fOKijj3LebjdXnxSWbIt/RhYSeMxHMIFb1R/Qw
         87dAtqTytU3Fcz0IGkf29OLrg2bZfsmzyoOPjDeRFCD/No+ZVfkpY3qunq98TEWRnG9I
         2A5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793831191; x=1794435991;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9OWHZGyN+/phkIGg4cLIcv2N+SmxQEX4nd4X23tehho=;
        b=CUZVroxWYBp997TJVu4Wy2tjfl+cbpHU9raWCXJ2FOoyarv9LysqsS+0m4GK2MHbtq
         /O+5U0djA2jhQdhrjmC4CRL9F0NDV/eHMfurKrZGNrsbyqa8Zr1bjcX/unrTd8p+CGLX
         a3jsAu2ID8mtn4Uop9Mjh5t56pPAZE3PVY9TXP31JbWt9hEeDQCTUfvi8SwAR1XZd58E
         wDpQCwq9ii3Aex7VVTyuHDLU+ESoQmn94B47XvX/QMdK3/Hauv6hg90qvXuUiOR2qJZq
         W7O/iHTcwfMzplzMoXaSJIARjbLRhomiHvPifHlBKH4TMpMlrE4U/Vwr2sCpQgMw4Snt
         9x4g==
X-Forwarded-Encrypted: i=1; AKwUvBxJP/fFm6XQbKq94vq75Lxe3f4sef8TFHaTF3idCzQI9viJx2AHzAHD7cpjRLQCbKxy2ONcgQ0PY0bkW22ApsdV620=@vger.kernel.org
X-Gm-Message-State: APuU4Z8gaOk4yeiPO0muaN8aod90kU7Tl69hYUBHhkUUEQwAYZKimgob
	oykhKse+//LrNe0bLGl618lYuXRyCjsvgw3KC5J7DsJA47acWVTzs8Dc
X-Gm-Gg: AYBFou3qix9bwNjDDma/6vXqnE04QIlYBImPoi6DLrjwha2sMwhiO+3o90BIrQcUnoo
	45b0cwpGpMToPQTzLkxVDXLWNrnoqnrIC7N3ovMHrpaIwco8PrJnOahGino5FuFp3f2FGBuVp2A
	2wrdtVzGz6a2hZ9Ij0iYJkzdBvcwTIBi4b/tE0lG1Yq1BoV6nw9yo/r4pEyd3KXtK5nXcaGevR2
	BsoT7jDOfsJPuvw8vepC1wbWVQC+5Blk9aNEwBS9YznVgojnWrObsren/u1xu7HDKj6Zngp1BQk
	ymZ2mSR9McLAcsw3mykAIujIHvOFhun2eC5fR3Trp/03sQSPFl1vWoYW+R8I+SSCgzkeeunwsXA
	RM9mnO1xpKotVGgZf8Q68/YSGDtP3M3iik7/jXHVOhWX0Sopt5qnCa/gpklfC1nssb5I+l19JeR
	ObTBkRjcdHGCNjyBDDV9zyQwBKP//FtJL+tyt6COnIcb/+nvvEbHxKXRIc96vxoihgeUVBniDLQ
	QuObq1n7mqvemdbLzdQiESNRIS1Zk1qSV7ysZC+E4oTbM0DQIbuOgpGIYLyDGNB0yrWP1n//l2g
	GGy+mKScswSRV9apumfaS24Gsa7QjadrsFoqNLLm3r3LkTHr2rz8IxZNiQ/buQ==
X-Received: by 2002:a05:6102:2d0e:b0:7cc:174b:f7d8 with SMTP id ada2fe7eead31-7d072247ab2mr7611158137.1.1793831191511;
        Wed, 04 Nov 2026 14:26:31 -0800 (PST)
Received: from bridge.vpn.bridge.ufsc.br ([2804:14d:ba6b:8339:9401:67ca:4be7:55d0])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5eca89b6568sm2863977e0c.1.2026.11.04.14.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 14:26:30 -0800 (PST)
From: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Vincent Donnefort <vdonnefort@google.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Thomas Gleixner <tglx@kernel.org>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>,
	syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com
Subject: [PATCH] ring-buffer: Do not WARN when trace_rb_cpu_prepare() fails to allocate
Date: Wed,  4 Nov 2026 19:25:58 -0300
Message-ID: <20261104222558.863948-1-christian.aurichzm@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Creating a tracing instance allocates the buffers of the other CPUs
through trace_rb_cpu_prepare(), which WARNs if the allocation fails.
But __rb_allocate_pages() bails out on purpose when si_mem_available()
is too low or the task gets killed, so a mkdir in instances/ with a
large trace_buf_size is enough to trigger it:

  WARNING: kernel/trace/ring_buffer.c:8094 at trace_rb_cpu_prepare+0xf1/0x100

The same failure for the current CPU, or in ring_buffer_resize(), just
returns -ENOMEM. Use pr_warn() here instead.

Fixes: b32614c03413 ("tracing/rb: Convert to hotplug state machine")
Reported-by: syzbot+fbe07bcf949966f3c00f@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/all/6a707c4f.13bfb6d0.1ecdd5.027e.GAE@google.com/
Signed-off-by: Christian Aurich Zanettini Martins <christian.aurichzm@gmail.com>
---

Notes:
    Tested in QEMU on 05441d697f7f (4 CPUs, 1G, trace_buf_size=350M): mkdir
    in instances/ WARNs every time before and only prints the message after.
    Same with a mkdir killed during the allocation.

 kernel/trace/ring_buffer.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1fd28a72e6ee..c018559ad61a 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -8091,8 +8091,7 @@ int trace_rb_cpu_prepare(unsigned int cpu, struct hlist_node *node)
 	buffer->buffers[cpu] =
 		rb_allocate_cpu_buffer(buffer, nr_pages, cpu);
 	if (!buffer->buffers[cpu]) {
-		WARN(1, "failed to allocate ring buffer on CPU %u\n",
-		     cpu);
+		pr_warn("failed to allocate ring buffer on CPU %u\n", cpu);
 		return -ENOMEM;
 	}
 
-- 
2.43.0

