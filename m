Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCEA472085
	for <linux-trace-kernel@vger.kernel.org>; Tue,  1 Sep 2026 15:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788278097; cv=none; b=YqRNoK6+yAAXhrWjio7sDNT7asAlVE0+ZGekYa/3is5cN3wTo9ve/VXZOW6vzIPpwTQi3U5eSGHWXfoFechJCXuNBGoBBRlbPaTn5JOEo+/vaLETLoYppD87Ljzhr1+pU80vzJOPKOPLMaGkzFipjkElJjmBMu+JB9WSspfawhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788278097; c=relaxed/simple;
	bh=eCijVtsZgcpRsQc0B1yK8vF1aLr7q+Wb3A8QSVFsXf4=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=uhgXb5qptLH4ukDn4QoyL32+ideBIZVYCGqt9ttsROlfuPQpIMx35YBis7jYOucKqRpmua+Uzfo9K2/1To4KKlsr43FxAe6TZ1eRaPlfQuiILw009brnvmsWHcjkVEkMJ0KzJT6ELmtad/NZa7MrTFeHj6H5gLTLxoo35YNjaY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JcuDtybu; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JcuDtybu"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-493fa6e28a7so34318395e9.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 01 Sep 2026 08:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1788278094; x=1788882894; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+cEeKicgVWXDi4JHgbduzXqGD43TsssX08z/lbVKR9c=;
        b=JcuDtybuyEdpyUzmFE5ep7hWA0JlnfjeP9ESGGTAdLW/UlERl9K9TVBuEJUFkYI6BQ
         JEMtvgxXjPcIRppsFwY2Zw0m+18osTDDuhQWTsA61O7AF4kvxjydeVplzezKca0gfTVu
         6gdx5pkLPBYjztaNB3J1dKAxzprVs5rgH7tA9gvOhENTGc1vG+cC18GySlIQ9K8Lg8ao
         E1mbHFmR1+cDfKhBr/hvEBkt4zRipQ4mjm+bMpYBr7mGZAU1l2I2ID8XMsdKTD9VgvX1
         MIkaocALF6dKYpkgIEekvP3FAzdUXWgXrwiuTVLB6H7XEI9gDlWUyA4LYaT3RXBb/NzG
         eQug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788278094; x=1788882894;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+cEeKicgVWXDi4JHgbduzXqGD43TsssX08z/lbVKR9c=;
        b=GvLj1nZt18h64MQemll01wLzpTSSbdls7ncLsxkUQ2zac+j9hQnQ7tz6PQc8NS3cyj
         f65TKP2tmztO13CabUBRsTuI2FR4X7FSlz/SFN7u6htnXgJK5Z5LJqFHGmNz6a7DPVNI
         YRIPnbnttgZCHhYuE06w3F/QxqTmrQNucOpFaGbNJYUXdv7smGCIhXtcYwcv2K3y7UY0
         /oM/XeASyZAsTdkAjFyeQWO9AVNhqQufdDjsPQjPu54uAVxrWzAwsUD4Xd+OYhqgysO5
         cMw4mwUmeHGP+QB9vcTDPEIbFgxBM2jhK7CNvrPYA2DXc7mKB09/ElkCxDsa2Dcx0Qbi
         S1mA==
X-Forwarded-Encrypted: i=1; AHgh+RqkGbdzJjEimwNI6onJOpLHddjuoeXvGOKLdzSXAFXi00XfAae5c4LoBSe77MjgwsoVdrXuFE3TLwmQtmY8xSPVA+I=@vger.kernel.org
X-Gm-Message-State: AFuF++lUt5z4x+UXakHEhaUxwpsCvktuRnjhDeOSQVs2mQVdTAypeffD
	EuDAOsi1Dg8p1yZSIDaSAexKZEUxX4lQpwUo7eNjs9PBfGETGeBxk6Lccswm5Hc2W4otIdDe7+6
	3xEuNhyCu94O7jqRXtAexoQ==
X-Received: from wmbz8.prod.google.com ([2002:a05:600c:c088:b0:493:c531:facd])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a012:b0:49c:d818:8764 with SMTP id 5b1f17b1804b1-49cd81887aemr239798875e9.11.1788278094045;
 Tue, 01 Sep 2026 08:54:54 -0700 (PDT)
Date: Tue,  1 Sep 2026 16:54:44 +0100
In-Reply-To: <20260901155445.1475405-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260901155445.1475405-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.897.gb25b4bd76c-goog
Message-ID: <20260901155445.1475405-4-vdonnefort@google.com>
Subject: [PATCH v9 3/4] ring-buffer: Cap static ring buffer nr_pages
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Static ring buffers (i.e. persistent, user-mapped and remote) rely on
the bpage::id field. The number of pages for those ring buffers must fit
into that variable. Enforce this limit on ring buffer creation or
user-mapping.

While at it, make buffer_page::id 31 bits. This does not change the
struct buffer_page size.

Fixes: be68d63a139b ("ring-buffer: Add ring_buffer_alloc_range()")
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 28dd76edfecf..c4260d6ecdfc 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -350,7 +350,7 @@ struct buffer_page {
 	local_t		 entries;	/* entries on this page */
 	unsigned long	 real_end;	/* real end of data */
 	unsigned	 order;		/* order of the page */
-	u32		 id:30;		/* ID for external mapping */
+	u32		 id:31;		/* ID for external mapping */
 	u32		 range:1;	/* Mapped via a range */
 	struct buffer_data_page *page;	/* Actual data page */
 };
@@ -657,6 +657,15 @@ static bool rb_is_static(struct ring_buffer_per_cpu *cpu_buffer)
 	return cpu_buffer->user_mapped || cpu_buffer->remote || cpu_buffer->ring_meta;
 }
 
+static unsigned long rb_static_max_pages(void)
+{
+	/*
+	 * Static ring buffers are using bpage::id and must account for the
+	 * reader page.
+	 */
+	return (1UL << 31) - 1;
+}
+
 struct ring_buffer_iter {
 	struct ring_buffer_per_cpu	*cpu_buffer;
 	unsigned long			head;
@@ -2842,6 +2851,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		 */
 		nr_pages = (size - sizeof(struct ring_buffer_cpu_meta)) /
 			(subbuf_size + sizeof(int));
+
+		if (nr_pages > rb_static_max_pages())
+			goto fail_free_buffers;
+
 		/* Need at least two pages plus the reader page */
 		if (nr_pages < 3)
 			goto fail_free_buffers;
@@ -2874,6 +2887,10 @@ static struct trace_buffer *alloc_buffer(unsigned long size, unsigned flags,
 		/* The writer is remote. This ring-buffer is read-only */
 		atomic_inc(&buffer->record_disabled);
 		nr_pages = desc->nr_page_va - 1;
+
+		if (nr_pages > rb_static_max_pages())
+			goto fail_free_buffers;
+
 		if (nr_pages < 2)
 			goto fail_free_buffers;
 	} else {
@@ -7836,6 +7853,9 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	/* prevent another thread from changing buffer/sub-buffer sizes */
 	guard(mutex)(&buffer->mutex);
 
+	if (cpu_buffer->nr_pages > rb_static_max_pages())
+		return -E2BIG;
+
 	err = rb_alloc_meta_page(cpu_buffer);
 	if (err)
 		return err;
-- 
2.55.0.897.gb25b4bd76c-goog

