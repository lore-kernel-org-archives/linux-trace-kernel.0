Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EFCD4F30FD
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062199; cv=none; b=Fcbi+KPbpAJokbMBwtgJ44vZ4CugW8Y42JcT/OV1De3ryik5jfZ8dGWfRZaePdWEaJfVu4YrGNvaXGasOEEhXmQEFeUDRJangwm/HvB1uUSPW7H+RX9T1BSM8VULfEIM8LAUJ4M9vBIfLlaKsenQpaOo8Ezcmdnu6pVmOLgrVy8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062199; c=relaxed/simple;
	bh=VQ/CNkma9Ihix0mslTlY/lTNmjjM6C9g2YivHyFT1rU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=D5A1L9sPxQ+IPfQzz84aMasmrzLG35hyQkL8vUozJADcYsOrugcTMKeDeaDSoAeIA8JZ1fvk9FAIaRP9zJXhTwbgDL0nCsYUrK6bwGns8oJSFLY90eT0qmtL0d7Z7HKID+bCizn2q+BFdLrlmo+5x8jgyoyyb3tC/pvzZHb5sTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DErGZJse; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DErGZJse"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-49e65bee41aso4937575e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 00:29:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790062195; x=1790666995; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=T6uCmfq+y+LNr8epKsVv0t5gG3mshNFczSag6wmrcqY=;
        b=DErGZJseYNCZobjSmbL4blhybrUj5Pxbljoqbk3AgGSLeVhJWwjL5WnF1SW4aZpQXx
         hxPvnuEVbduhYFt4JK6vQjauQaCi3IG/XOKtLWOElHiG4BD/+Ij82HaU6BgynPjebuW2
         a1dQiNZ+LCeMukwddCf6CpjpNrM1EtSwQ1tld9CKKRiGaehXNMb/xSwPZ2Q2on95eAKR
         5Gpr8zlyJkr+70+BJUR9T7VNychdWAAvjS0xfs+KCLfwHU8hewKWO22/U1Odng/Lkrlv
         SZxqK37vDiEOCahcRIDJmllKDkFmEktRGR4nliWJ+sNhf7TmSpbh4KFJD3zsLdGMSVo+
         jtXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062195; x=1790666995;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=T6uCmfq+y+LNr8epKsVv0t5gG3mshNFczSag6wmrcqY=;
        b=0mHTn+ghUoW2Y/mDcoX9ZAubiY1WJrqen1hEBJKKXz6SmKssBvmM7sqWpJS8co/MXG
         sncIPPl/UIojGqJHuh24J2xNrY0H+xUsnnI7JYA4WHEWrMT58H1Q3q0+nUAYNbdiswJu
         qQ434/JQgQ0JrblewrT3xzL7eV+g5WUKoE0UzfgnvnGE6Y9tXbgELNWTR5rD0Mlmd24u
         44+ssSYwlxRWuyRBzCY3oQU172M6MMmptGIqhD7vvOVFiWAh88CClLMSXPwQloKcKwiz
         fC4oBOdRhqHvqHIky9udUbu1v1jTBSRlz0t7bozkqAt2KnPPPqaQOcaf+UZOQiLMCb/w
         dtYw==
X-Forwarded-Encrypted: i=1; AKwUvBwh1QYAwmDwsiqYjjmFwsL5K04+NwsgrGJqhmWZfESfhzBIdliIYAzNeBvDtSglNCmVWyQHmpzxevmHL9JACpoqzlY=@vger.kernel.org
X-Gm-Message-State: AFuF++kb+rKAAoSyaXvQIHdILNG7BZ2oVC0P6s7INzAVnHqKbLFEexvy
	uPmc4MfRQEgiKH00Y6it05eP0p+UdqcSMHtC525oqiseXgEGFIm+MPG/j8Z7cJ6NDSoMTiqAxTK
	5I+r2/X+fwJ64953X6elsEA==
X-Received: from wmpi42.prod.google.com ([2002:a05:600c:4b2a:b0:49e:8337:33d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:c0d2:10b0:49d:257c:a735 with SMTP id 5b1f17b1804b1-49fd8a61947mr19151065e9.11.1790062195310;
 Tue, 22 Sep 2026 00:29:55 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:29:42 +0100
In-Reply-To: <20260922072944.1281427-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922072944.1281427-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922072944.1281427-3-vdonnefort@google.com>
Subject: [PATCH 2/4] ring-buffer: Use kvzalloc_objs for remote buffer subbuf_ids
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Creating a remote ring buffer requires allocating an array of bpage. For
large ring buffers, this contiguous allocation is likely to fail with
memory fragmentation.

Switch it to kvzalloc_objs() to use the vmalloc fallback under memory
pressure.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index f9be87c2cc3d..1a158a24b3c8 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2620,8 +2620,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int
 		cpu_buffer->remote = buffer->remote;
 		cpu_buffer->meta_page = (struct trace_buffer_meta *)(void *)desc->meta_va;
 		cpu_buffer->nr_pages = nr_pages;
-		cpu_buffer->subbuf_ids = kzalloc_objs(*cpu_buffer->subbuf_ids,
-						      cpu_buffer->nr_pages + 1);
+		cpu_buffer->subbuf_ids = kvzalloc_objs(*cpu_buffer->subbuf_ids,
+						       cpu_buffer->nr_pages + 1);
 		if (!cpu_buffer->subbuf_ids)
 			goto fail_free_reader;
 
@@ -2681,7 +2681,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, unsigned long nr_pages, int
 	return_ptr(cpu_buffer);
 
  fail_free_reader:
-	kfree(cpu_buffer->subbuf_ids);
+	kvfree(cpu_buffer->subbuf_ids);
 	free_buffer_page(cpu_buffer->reader_page);
 
 	return NULL;
@@ -2694,8 +2694,8 @@ static void rb_free_cpu_buffer(struct ring_buffer_per_cpu *cpu_buffer)
 
 	irq_work_sync(&cpu_buffer->irq_work.work);
 
-	if (cpu_buffer->remote)
-		kfree(cpu_buffer->subbuf_ids);
+	kvfree(cpu_buffer->subbuf_ids);
+	cpu_buffer->subbuf_ids = NULL;
 
 	free_buffer_page(cpu_buffer->reader_page);
 
-- 
2.55.0.1082.g2b9226bbc0-goog

