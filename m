Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com [209.85.128.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E89541D4FE
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Aug 2026 21:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786050799; cv=none; b=phDZwiCvhuRfok9KiVjqSVYGG69FkbqXG6fr8+kcmf3Lr6UWkJqC4owE6eDjy0jDJdUeupNimboLlWs1RyCuDdRNCNC8g6nY+M700vLrBm+gk463tAjPvfyItovGuieq+KrbxDz/FVm2iUgFov3U/izefmeqQIF3cDNpW0WhkBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786050799; c=relaxed/simple;
	bh=+gnfElGGQK5T9MdcVzAlpd12lgFMxbtMTdOesSKWdDE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GwbjZpwhrWNmUVnwG/fwayx2wdciEBlzqe5a0wbvZRBFQBpCMI2JPvq0ZFZNzH2JF013TEBUtyNvxHR+DQ4NRlNW4KaOL6Hfn8riH1wcfy2QwhZUzmGkSQJYc+MvYkvKfYSYXQRi2siawK5eV7OOqMVDwvQ8vmUY61yp3sDuGSM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Gi1E1tJl; arc=none smtp.client-ip=209.85.128.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Gi1E1tJl"
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49545071724so25032885e9.0
        for <linux-trace-kernel@vger.kernel.org>; Thu, 06 Aug 2026 14:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786050797; x=1786655597; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7u8F7+F+C1XVXYeKDzyuJSSv0Vmszc5Sx19/+zjpRcM=;
        b=Gi1E1tJl3Tmw5lAY71s+8NTNQP8b1WcEJd38Xbqyx3a2zffoGLa0DvwCm3hjOhzu/c
         I3NBD7HdwXF7Qh9WzH2Ux+phKJDeyZz3Gg+kgvmeDv3mMLW1qYCYTxMbDqskcFWK029v
         ldGDJZYkPB1uOESt1OTGEPfIeuSysRn20WWQqHMx5034BIxRmhffD0zI3t37T9CXR/XB
         qI983b6ehxHLxPq0L8rfXkBwaAZePza/+eGDbuJExz16GtAL0WfzUeDulFaS7nTJRtzv
         t11L4llElncFL2Rg2lwZsH72hJDfNnMYIAjLfuSG017WeoxUextXZItHLaCIHW5lJIql
         r1LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786050797; x=1786655597;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7u8F7+F+C1XVXYeKDzyuJSSv0Vmszc5Sx19/+zjpRcM=;
        b=GzwycU/KGPfnCmBEQcJwH6LvkxzQ43jsJPMB4qQtPicTyJMMxLBTeYsAxAMralHq2r
         LF6EVeHJ7dyeUIfuP7PPyzt5W6O/Nx+wOs78drCgCi0juqy7O3c+vZD6/gorryUcJ8Pn
         TBiJw+wqEa1ltJz0cV88KZrjwHV1kxgdg/L+xZNSsM40efvQaJAvWl0NfAzL2BEruKZL
         2o+wVqH/TES22VmZo3PClFz1wRofVXvz1BWw2S9HXG0fmnGrroAjmjaN4hnfY0FM+ujH
         hjtxBpL7gbQmBM7ygvZXJhvVnDgmWdEei0IJ9TQXx6QtrbHwC+rj+nwjZtPRlZXsKSR7
         5KZg==
X-Forwarded-Encrypted: i=1; AHgh+Rr0u4uq/5FXot1C4zGoMiN4TJ5qcKH6BMIdXz+M5FhqWF24x18yqnh3Xs/StIpHZpE0+litniXMLyoHVCyFZ7xotUg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yylf0/IuGdinWSep2dwP8RMgRMDB2GBLl27vSBmKthGGlrtvQ7o
	OXD0Bhgpolvrk2Qip0VK5SdF26i3HDbEa9zKF3O6dQ4dwYpyR6IuKYthk51V7a3GnJziqBp2CLN
	uvfevlP6nofSjMQ3UzjB5sQ==
X-Received: from wmjf20.prod.google.com ([2002:a7b:cd14:0:b0:493:aecc:774a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a7b:cc0b:0:b0:496:cb48:5eb8 with SMTP id 5b1f17b1804b1-49959e38ecamr50626375e9.15.1786050796387;
 Thu, 06 Aug 2026 14:13:16 -0700 (PDT)
Date: Thu,  6 Aug 2026 22:13:01 +0100
In-Reply-To: <20260806211306.3704194-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260806211306.3704194-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.654.g21b8a5bc05-goog
Message-ID: <20260806211306.3704194-2-vdonnefort@google.com>
Subject: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring buffer
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Dynamically resizing a persistent ring buffer is not possible. Disable
the feature.

Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8e2485bb3aa8..afe75ad2bbf2 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -2528,6 +2528,8 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 		if (cpu_buffer->ring_meta->head_buffer)
 			rb_meta_buffer_update(cpu_buffer, bpage);
 		bpage->range = 1;
+
+		atomic_inc(&cpu_buffer->resize_disabled);
 	} else if (buffer->remote) {
 		struct ring_buffer_desc *desc = ring_buffer_desc(buffer->remote->desc, cpu);
 
-- 
2.55.0.654.g21b8a5bc05-goog

