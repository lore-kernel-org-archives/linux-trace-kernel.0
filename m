Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B73512CD90
	for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Apr 2024 11:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714475645; cv=none; b=O+3vP8r2LXIr9oiQWUP6DS+HiFzIiCRvfbPmKqHYXfEYPWTWMac+lquOrIKW/IeYYgri9Cc1Vacby/EcsC7L7+qQAsD9S58qFpReBaM2Ia/feU1E2ZxC9NQNfzJyGBEH8ZossTv8fIX+nMzBHSnhXToZfFQgiz4oExxrEC/eYXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714475645; c=relaxed/simple;
	bh=l6oDZivJcyQTCOy+gknzagGu6pD9fjWdRZ/T8AH6uxk=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=pNtNOtjYikRnczpEsmmSVr24wzYd2mlto74lIvfTkwK46m6mkOKXu+m+TwjmgmicIlBOOESyvNUPz4Lp31zEz81RogkHJ/1GIAvtQ6/pSXlVFJKh/T0TGz2O94RUrhakOXFo654YugKahLhtZYE6sVcBF0e+vEW42jEtYtNR8iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nT+8gAA2; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nT+8gAA2"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-41bd87bb458so20839935e9.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 30 Apr 2024 04:14:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714475641; x=1715080441; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=RPOnWL9RPpAUuW6zSj0DHbUYz85VJ46LckD0gpweWUA=;
        b=nT+8gAA2qUrfL9l5//e+m1h2J/o7rGv6/m6hWNFVR2kVxqceQ6tUKoHdh5StxJO94A
         ZWwrCSMZZmS4yej8JCLUU2z/aW4RSma08IQkXRUXc5Wuanfdh+B685Qr9TMS/SCEus0e
         ZcQOcDyzSkfBYtuHhVu+dCjmN4VD/GbfbLhmBD2kWeD0+qY4wssFRwb6EiTPBErDdS6F
         GywbabcTHreEsPvy5a+UV8FVnuwYz3Ha9WQ4vrvAEH7kG4+aXFozF4yie9bgEuxZhbWo
         wxR9q/0krZaAECxYv/BHAPTIDq5yS9Mr+9mVUjinXt13YnbZHsGieeF0MU81g6PC+Yz7
         RFMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714475641; x=1715080441;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RPOnWL9RPpAUuW6zSj0DHbUYz85VJ46LckD0gpweWUA=;
        b=FXLo00U/6BSo55bHfEyAogTQuH05wPMkvyrQskglHVPQNLxWYP83y9GXK4Ds6VDcv6
         Qmbf8oq72tIXiNuYWd5zz5L0sCh4VA1Vr4wkZOtYQKZWNFGc4cfPlM6Icfs+MXKjgcU7
         A9MdPrR4bOVCou1FzEJfUsI7/AiQhkSAWg2TEkm4ac5UNg9ReNnlX/XPhkuvMCECE2LS
         wQzCx0LCRdzj6hFjhPTadxSNDVLW8UI+6IZ5Bc39u4lDr0wie3vaewZOgurI6OgVGe3I
         bMrgD/1U8/yQpHvYDkoVnkidLqIb629fyJBkrEJTahCg2DQ1dEdvYEc3ltzxkfEsQ7oB
         wc/g==
X-Forwarded-Encrypted: i=1; AJvYcCUT6TrsVAi9knF7w7FY4yqUALnMO5Tlw+dnwIj4RihN7JUoIBcJYbD1uOOn2AVRi8URIbyxcKLgivDRkbqQEQ58M6lH0gaNXSc+8x9Ls36p9Aae
X-Gm-Message-State: AOJu0YwZR2q32MZZIu+KBXNe/e17AEeh1rs7R7PqBI2E5DjBrUQlaZOz
	NqVISxy2psXFbLbWS3f8EatCVMSmHlDNbjCLD0B3drOOe6epZaiiQo1c6p5DxtTNcBo3q51d59g
	pkBkYxLQuOSVKJQN9+A==
X-Google-Smtp-Source: AGHT+IGg0qhb/Jba6e9SYF1X563jKL0wCkSy4jPLen+t6O0bQF5/hWi5hJTj+ZQVSBTh2zkExIaXqd4WY26ybQ/A
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a05:6000:d46:b0:34d:a111:5021 with SMTP
 id du6-20020a0560000d4600b0034da1115021mr1931wrb.1.1714475640882; Tue, 30 Apr
 2024 04:14:00 -0700 (PDT)
Date: Tue, 30 Apr 2024 12:13:50 +0100
In-Reply-To: <20240430111354.637356-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240430111354.637356-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Message-ID: <20240430111354.637356-2-vdonnefort@google.com>
Subject: [PATCH v22 1/5] ring-buffer: Allocate sub-buffers with __GFP_COMP
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	rdunlap@infradead.org, rppt@kernel.org, david@redhat.com, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

In preparation for the ring-buffer memory mapping, allocate compound
pages for the ring-buffer sub-buffers to enable us to map them to
user-space with vm_insert_pages().

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 25476ead681b..cc9ebe593571 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -1524,7 +1524,7 @@ static int __rb_allocate_pages(struct ring_buffer_per_cpu *cpu_buffer,
 		list_add(&bpage->list, pages);
 
 		page = alloc_pages_node(cpu_to_node(cpu_buffer->cpu),
-					mflags | __GFP_ZERO,
+					mflags | __GFP_COMP | __GFP_ZERO,
 					cpu_buffer->buffer->subbuf_order);
 		if (!page)
 			goto free_pages;
@@ -1609,7 +1609,7 @@ rb_allocate_cpu_buffer(struct trace_buffer *buffer, long nr_pages, int cpu)
 
 	cpu_buffer->reader_page = bpage;
 
-	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_ZERO,
+	page = alloc_pages_node(cpu_to_node(cpu), GFP_KERNEL | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page)
 		goto fail_free_reader;
@@ -5579,7 +5579,7 @@ ring_buffer_alloc_read_page(struct trace_buffer *buffer, int cpu)
 		goto out;
 
 	page = alloc_pages_node(cpu_to_node(cpu),
-				GFP_KERNEL | __GFP_NORETRY | __GFP_ZERO,
+				GFP_KERNEL | __GFP_NORETRY | __GFP_COMP | __GFP_ZERO,
 				cpu_buffer->buffer->subbuf_order);
 	if (!page) {
 		kfree(bpage);
-- 
2.44.0.769.g3c40516874-goog

