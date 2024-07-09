Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E792187850
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Jul 2024 21:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720562240; cv=none; b=tkoey0LNV/JI36TW+Un4B/clLLOldAw7Vdz8FxpV1slQMDXbQvVCo9qFDENxM6QpKARdtmHT3Z7TimrBADJqxW80x869rxZg1Oo2zbLej7k0fzkMi8kVsDbIBwh5yfWN1vuf74xtmwIVrm652A9cCKhWE+eI9IRE8lE4VPXHx7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720562240; c=relaxed/simple;
	bh=JUqS5ttBBM1omPFCYgFWCMxpQuQRl+1KMMx3uqcfNqg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AFndxAFuYpdNZuwAHsHRuoHjBsNNpWEoAKK6H4W8vBgaNtaQr6DUTUsVDp6UFbvVdo1oX3rQaqZdp7W2l7/nkhliFsENNQ3wagiahx+ZzcVyzFcsMCLaZguRuj5n5SwKTV1h9BpjaDXrsL69PhKT5oLwnqr4HNn0/YcKBR6a2H8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=L/lbTHYE; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="L/lbTHYE"
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a7979c3ffb1so6099766b.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Jul 2024 14:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1720562237; x=1721167037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tJgVkcG2gOFg2qkpKsciV3FiyRxdKHB8MVcn4EaNMzM=;
        b=L/lbTHYE//IOA3xtJVToffU9ybVoic8qvNnOkgMQs9tCydP+ZQ2X82mjvrfAuNfEtD
         fAHuYHh1xHX6uMTIX7hK+xT5yqHEBddQgm//xhuTTfNr5SWh3sY1UztxnBKGitSHU3xa
         Pm449Jj7vx7u4X7UBncOGiGQN+kP370Cf1+x4i01vIFlg/PxwDJFz3xiQ4Ex7ZMQg/+v
         zRw5L7bgE4IpsujG6kNNQKTI4zNpUglqm5/on3SY3V22Ln2ToM10WwyAHmOVFQ7B6Gy8
         zJ9IEgZKqyS++mexlyagT0E4hGRsAhCGSCFDEbrMlCoulMlmFXORPVymF6vBEiH9MJlF
         yZZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720562237; x=1721167037;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tJgVkcG2gOFg2qkpKsciV3FiyRxdKHB8MVcn4EaNMzM=;
        b=jmUIkk+6uC/hswEeY4D4vEzw2o4TFrw1spHDHcNiGt+8aXPUK1BMyvPSnzzd/cXBkq
         GAKDAqHGg42klYPbP1/8nS+i2jrTKhp1Sc8PWdUbJglMQ0wdoHwIiJJvhtv8BdbgpJmU
         5sd34IPSNmzVwAmkUvgGhYGelI7r6um1gHFGzHOI6JAUMf8RX7MgZPqvJZPfL1DmvGA8
         AMm60ygwvdpMMtDnwJo9hFpH6RLT5ZEw9gCCW+UoGOpqSsEaAwYZnZwyztxXQrBaQbcR
         VkE8FKCZh26+1tPYvGdlOhis1k3wHUQPPV93WX2GvehybSyeMaXWwz6g/IRD6uxROqdF
         muMA==
X-Forwarded-Encrypted: i=1; AJvYcCXq2ktzkJCgQFK0gqEWJvuwV8ZlgYNZxFsb1ybywbZEhpIvELCw681h5lNv4DiOoEolJsaDia2Kg8ttVvqxGGXj3YHkhi/rKh1DYgMMilAAPm9b
X-Gm-Message-State: AOJu0Yw8ZXMr9T6tGT68lFlY+3duXXAi0PTROjLZX7zPX2G1707H2mkU
	IVjTn6f7mdEFPSA4QbhCx1T2HNLsY19J42seU5IVeg5MuUqn1L2hcKnrTAWqHTs=
X-Google-Smtp-Source: AGHT+IFJslFIOpghoKDTLR0OGIUDV2UVIGb9hL36ZC1+ww2JbzD7HcVhw/J/gYtk0+dYuF64+MiEEA==
X-Received: by 2002:aa7:d0d5:0:b0:58e:2f7c:a9c with SMTP id 4fb4d7f45d1cf-594bc7cab19mr2781021a12.26.1720562236651;
        Tue, 09 Jul 2024 14:57:16 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-224.dynamic.mnet-online.de. [82.135.80.224])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-594bb9605dcsm1499572a12.6.2024.07.09.14.57.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jul 2024 14:57:16 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [RESEND PATCH] ring-buffer: Use vma_pages() helper function
Date: Tue,  9 Jul 2024 23:56:58 +0200
Message-ID: <20240709215657.322071-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use the vma_pages() helper function and fix the following
Coccinelle/coccicheck warning reported by vma_pages.cocci:

  WARNING: Consider using vma_pages helper on vma

Rename the local variable vma_pages accordingly.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28853966aa9a..473ba56b889b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -6226,7 +6226,7 @@ static int __rb_inc_dec_mapped(struct ring_buffer_per_cpu *cpu_buffer,
 static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 			struct vm_area_struct *vma)
 {
-	unsigned long nr_subbufs, nr_pages, vma_pages, pgoff = vma->vm_pgoff;
+	unsigned long nr_subbufs, nr_pages, nr_vma_pages, pgoff = vma->vm_pgoff;
 	unsigned int subbuf_pages, subbuf_order;
 	struct page **pages;
 	int p = 0, s = 0;
@@ -6252,11 +6252,11 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	nr_subbufs = cpu_buffer->nr_pages + 1; /* + reader-subbuf */
 	nr_pages = ((nr_subbufs) << subbuf_order) - pgoff + 1; /* + meta-page */
 
-	vma_pages = (vma->vm_end - vma->vm_start) >> PAGE_SHIFT;
-	if (!vma_pages || vma_pages > nr_pages)
+	nr_vma_pages = vma_pages(vma);
+	if (!nr_vma_pages || nr_vma_pages > nr_pages)
 		return -EINVAL;
 
-	nr_pages = vma_pages;
+	nr_pages = nr_vma_pages;
 
 	pages = kcalloc(nr_pages, sizeof(*pages), GFP_KERNEL);
 	if (!pages)
-- 
2.45.2

