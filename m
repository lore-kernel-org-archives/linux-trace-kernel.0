Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91F547D947
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 13:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786626728; cv=none; b=GpgTTCWy/oU7o0SFcECn5RQ7tvWWV0k0rg8NlAJHIFlKS7DY/thldpHi0w8WvMO1Up7/n3B2iMF/zymNgseB6Vg3aL/2WBRI3vuU76xV1/gXJhFec6rUuaaS4il6zpEqig6qhfW5H5dAoo+KaIEbGci2EM9Z6UHY25GhZtFFk+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786626728; c=relaxed/simple;
	bh=9Bysv873vAwyLyA6UGP4Oj7s+qZVTUQxM1pxMfTnQWU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LfeFARGQy0CuNI8MBPULg/rO4PpGYJLT72kGGak9LZSo/s207nEnTl7Y5CnJgz1nRoo8NADIZEtXNZITOXd6f+vg8TKVMrTNc4I/rmANo6CneZpAyK8T5Eu68M/QyX8+G/Tn/rC0qSWhDsru8ZyZ1k2WdiL/xrUFRw9KY6FzKng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZAAlhlfx; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZAAlhlfx"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-47f83450a8eso1582444f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Aug 2026 06:12:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786626725; x=1787231525; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+i0aZeQq/1kOTYHHYrCCwFz33cStEuYr57NKxKQ74mE=;
        b=ZAAlhlfx+ytAWbRJm1rjBJrwjQu/XTBB0KWxlClBezwJfsVp95ytBeC+T74QYOaPEQ
         3oWDTH51NwqfOwybjDe1G73S06lRgtJE+Z+OpRtPauOclpCRg1Vox0XJqh6pZoVRWouo
         NPsKMbGrMK0i6Ie47pV9OnsGVhVg5U/EsRqW+5KTyocbJba4zL6hy/TofYuP1dS1StKU
         llTt5o0bpgSXbdNOo5bf7qonX5Q3E+p1IFD/IJOw/vjzdXwaRXQSW3NwvC8rxhCc4C8b
         hxaeRZgPuA2+3DUXVj1ZELKpujljw+b2B5HRMLOcyDlp2oMWMYYaOlFjl1kKblc94D/E
         Okrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786626725; x=1787231525;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+i0aZeQq/1kOTYHHYrCCwFz33cStEuYr57NKxKQ74mE=;
        b=SZIweeiXZxhDYn09/xqWswZy4lRl5wDHVPs3l1/KKy2w6w6isGe/BgPXrtVJYi42bP
         Xke8Or/0r0aehLfKATrBIma+5rc51F8hS0fkutMibdk/7BuuDLkjYgqxhlaEHFh5TbBg
         Phf/6G891pKevGirr4qKFSGcXyG86FmwFOhpezezY9iL+NSsP2WQIOoAIzLSasjAu9Jr
         h6hDh0dzKCCDWq+3KpMTfyni9C5e5yfG84fDZKNYDqDiG+DQbIV2L568zahe6UkfQbVu
         Hc6bWXxvdCOYYkWUkYLR2O0jv67KoV4V40Z4UPfYCIFLIGp7+PalT+fT1/74bDFSMl2G
         o4tQ==
X-Forwarded-Encrypted: i=1; AHgh+Rp7eOimRHSsangbs+wtuYP00ms5NRwvR0HVCvprsKPHv5E5ShfKYwmYtOdUye2hRAesLl5XAlLoRNQJir84zv5cpZ4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIy0951/5zvLUmzgn+EY00bpaYD1ZjzOGT3SsBH258EieuzOl8
	MHomq7cVqCZPNToPv1kWWM5wtyd54ZW0HCeWGVSN3k0TrpaP7ybu1xVFpq/M8CJMMru98y3bZPF
	0vJ5h3XZ4+NyMIAl8W+i+cA==
X-Received: from wrbfn12.prod.google.com ([2002:a05:6000:288c:b0:47f:5596:2c69])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:adf:e989:0:b0:47f:9254:d453 with SMTP id ffacd0b85a97d-48159ccc645mr6978361f8f.8.1786626724876;
 Thu, 13 Aug 2026 06:12:04 -0700 (PDT)
Date: Thu, 13 Aug 2026 14:11:50 +0100
In-Reply-To: <20260813131152.3589632-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260813131152.3589632-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260813131152.3589632-9-vdonnefort@google.com>
Subject: [PATCH v5 08/10] ring-buffer: Remove trace_buffer::cpus
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The 'cpus' field in struct trace_buffer became useless in commit
8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their
allocation order"). Remove it

Fixes: 8e7b58c27b3c ("ring-buffer: Just update the subbuffers when changing their allocation order")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index d7b3c56e4263..905b2e6df9ab 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -572,7 +572,6 @@ struct ring_buffer_per_cpu {
 
 struct trace_buffer {
 	unsigned			flags;
-	int				cpus;
 	atomic_t			record_disabled;
 	atomic_t			resizing;
 	cpumask_var_t			cpumask;
@@ -2796,7 +2795,6 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 	init_irq_work(&buffer->irq_work.work, rb_wake_up_waiters);
 	init_waitqueue_head(&buffer->irq_work.waiters);
 
-	buffer->cpus = nr_cpu_ids;
 
 	bsize = sizeof(void *) * nr_cpu_ids;
 	buffer->buffers = kzalloc(ALIGN(bsize, cache_line_size()),
-- 
2.55.0.691.gc56d675ccc-goog

