Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1B3B39AD4A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 13:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778594067; cv=none; b=RIeny/V+HDFtO9oC4OXy6rwv6I4+Z9I9WD6fq8UerahTltx8kKrv8Kn0b+C+/FXr2V480YNtycWxyV83w5JUWMgVMChHVXpfgHeg0n7CMhLlrhBcLuyILiZq1VEWkRtyxlmgSRsM3PJ8fwWNlinUjCelqSdjV8DRpOTiJ1ODnZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778594067; c=relaxed/simple;
	bh=rXLoa9GBRBH6H+q+SMMAAzcD/K+nBASxRj8ZI+waeF4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ga4l/8+LZVT6BZeYrobCPMf46/+POiuEZ+3aejNfW7ncbn3EfQkNIYy0fBkkEZRIMgtHLIFi8xm/UHthjonUb3A7Ut+dC/c0nJjek4xnbPkCRmBQuH/sMN9VArpYPVNhe9U9Eaezb3WMx26O4yQjDtMO1TH7Xpsh49d3YIoWXR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DQrn9UbQ; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DQrn9UbQ"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-488b3f8fa2bso62992075e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 06:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778594064; x=1779198864; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=MsimPcdUANfcIFgHzpPOd6ABveJwxGYZMeC9Y1ifSik=;
        b=DQrn9UbQfmqEDaNFxTLznLX55Qp1UW3JRO4dcgoJfNKAdKab3bAS6cuiMRaO/uK11R
         N8QOKL1EmjSYKyXYpSJdjCLAFJds7h6ZWfq+DxBkOtK932OnrPgeUWUa7knVqvrX3YyM
         aOy7nERDh1BVVebhw4L7zUHOfCRicUzIw1E3fPQkc8jMxEF4RWVB9lgYwCFrNajYvKst
         EOggLMCBwdATnS4AVmW94614u9aCSYRyJq57A2Rb5NuHNpsDLa2IOr2egyOxk0urwUDi
         KIiDXhYrUuDR6VP6SbdRSQOBrl2ZRf5FL2ZyMw0MMQsxe6Wm83gg9IfklpN5aQy4oQUC
         mPwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778594064; x=1779198864;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MsimPcdUANfcIFgHzpPOd6ABveJwxGYZMeC9Y1ifSik=;
        b=hrfLnLXTnuojawv/Pl4d5+4ViYZFjLBfnR1L3dpUWrzBMy1UqIsfh3g6XKs1Lp8jYZ
         Dm0Az9nyYEAb66ZjGZ0N0eoLM8qh8O6P6EhLfEJNoyiRb4MdiCnj50fhNZy2XlIugntr
         BhjtuDRjCG1+zUMMHWqnmuLmNx+7T9JwW41Yz+nZYFR9oxvbTuXVlgA79BsBDEsJuGpt
         HCbXI4GGRCopF9Ivno+7Hn7dJ5x7Y6eOjmoVAK4JuEP/oCx9l40kRqkgLtPHq+Ld+m+9
         4NzNAuDQ2WcrbgmMfwUdhrel4Oo+ZI2sEUfhxIvjUzJULQDLDyouWC1bmdJjIaU/YOIc
         SJIg==
X-Forwarded-Encrypted: i=1; AFNElJ+o9dR/T85dJ03s1mlkOXVlMA/9omvgM8PIb37heySowRN6MD7Gff09wmRzr7xi7ISCKH3quL4IZJlE3wpuxkjXTts=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzxd7YsrGxKmx+PbX772xEFIblIHW5G8+b9ITljmllr1NL9/iOS
	s4JpjeNKPdJ5oWeHqTT+sjyiVnWbIpunsXZeZSWAtZHe+NfyJGaVzHWh
X-Gm-Gg: Acq92OG4BL9DTgHsYe7DP7ggidHm/MBIYNim6GZyDHOSSZZt6fsfwQkapjJsNoEJBER
	hkNNf38BLQnPVmZKBXlLNu1d7s/lLmPKPjQIFXRclzVvMcJ7JAWB1EYFdvqtuO27BCza73+TvG9
	ljZbij52g0QI8x6G81oMeyEAfgCFQsk7/T6rOGfsTL5j5GsKQR5/sP+2YVBQQfWPOFYqFj6ziLW
	Y0TMU7fsKSI+6JTvQhhSHhoGGaLq1uI8oU4sxjnhEpK/c0/Eq92pmFsPZO6QJOBh302H778DeU0
	MD7hlJkUJsGcsWIN3LR7cO9zh7OhiFp4/JWDteJhh/FAmh0Uv42w9cf4mDdTP9dprwPq0zFO3C7
	I1TDhWTV5BXnR0jsoiYZWsV6RRe3E/J7DaJLMo3I5gLxPUNAHAmxKxvxfwBG/yiYW09KZK1ppeo
	YOoI2lupdrtxTXLRO0zWnf06QSoFG84321i8blGpipTkVza3fJZKr/mMhS+vvfeSH5b4W6i77O0
	voXZL3k7EU=
X-Received: by 2002:a05:600c:3b99:b0:486:faa8:9e4 with SMTP id 5b1f17b1804b1-48e906c4525mr43131835e9.12.1778594063788;
        Tue, 12 May 2026 06:54:23 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48e908d890fsm43691055e9.15.2026.05.12.06.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:54:23 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: catalin.marinas@arm.com,
	will@kernel.org
Cc: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	vdonnefort@google.com,
	ryan.roberts@arm.com,
	maz@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH v3] tracing: Fix nr_subbufs initialization in simple_ring_buffer_init_mm()
Date: Tue, 12 May 2026 14:54:20 +0100
Message-ID: <20260512135420.99194-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

nr_subbufs in the ring buffer metadata is always initialized to zero
because it is assigned from cpu_buffer->nr_pages before the page
initialization loop has run. While nr_subbufs is not currently read
by the kernel, it should reflect the actual buffer geometry in the
meta page for correctness.

Move the assignment after the page loop so that cpu_buffer->nr_pages
holds the final count.

Fixes: 34e5b958bdad ("tracing: Introduce simple_ring_buffer")
Reviewed-by: Vincent Donnefort <vdonnefort@google.com>
Assisted-by: Claude:claude-opus-4-7
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/simple_ring_buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index 02af2297ae5a..f731f14d0ff7 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -395,7 +395,6 @@ int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
 
 	memset(cpu_buffer->meta, 0, sizeof(*cpu_buffer->meta));
 	cpu_buffer->meta->meta_page_size = PAGE_SIZE;
-	cpu_buffer->meta->nr_subbufs = cpu_buffer->nr_pages;
 
 	/* The reader page is not part of the ring initially */
 	page = load_page(desc->page_va[0]);
@@ -437,6 +436,7 @@ int simple_ring_buffer_init_mm(struct simple_rb_per_cpu *cpu_buffer,
 		return ret;
 	}
 
+	cpu_buffer->meta->nr_subbufs = cpu_buffer->nr_pages;
 	/* Close the ring */
 	bpage->link.next = &cpu_buffer->tail_page->link;
 	cpu_buffer->tail_page->link.prev = &bpage->link;
-- 
2.53.0

