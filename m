Received: from mail-wm1-f74.google.com (mail-wm1-f74.google.com [209.85.128.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45B03AE708
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Mar 2026 14:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772807757; cv=none; b=hCpw89N+uweU/VCVqTOZNi3ypMzNOuSNiOIJqhE7Y5chOJ3u85WN31KZoRRvSeqW4zgSu2KILS6zItdlRdFWxapQOqhwtdQeliwDrj0RbxoA5NB46ih4HbKp9qIt+YOtm0DVyhlN6x0NTiHNPOvY4S8Y1yd5T/j2h9dbrFfaOtI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772807757; c=relaxed/simple;
	bh=boc/4d3DKHVDTv6LY/mfgI2uhQ4fDoqeAnOqtQ703cY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ab/47NxEtJUFkd8vUbOmVLfM7cDOlLbxYrRrjUaEQcb0g8DwI7B12wjzLZFgV/LQHtsEboTm7xV5CDEGnAHO6UbB9ZZQOiNGCpIx14qUksEvC8gQ3/YGXSIg8oP9d9fF3L5IqFLKYNYiK6+jlhGCzthLz24pyHdha7T3sC5/EVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QsRPWM71; arc=none smtp.client-ip=209.85.128.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QsRPWM71"
Received: by mail-wm1-f74.google.com with SMTP id 5b1f17b1804b1-48069a43217so97669835e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Mar 2026 06:35:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772807754; x=1773412554; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jbx9+EVK6y4U1OT7nCohIUASMhFn/GxeOgFoW/iLRw=;
        b=QsRPWM710yAJ8jnvtv3QfveiUmtO9znO1M91J3KtlnSV2bJqtlPJqVkSzzjhSFxiNa
         OCa48h9q3k+4eoyYOpkNfMERzqYlwlWP786bCBf6BbX6xfMbJyHkX2wTVj4JaAop7T+x
         QY968X1rIoOXfhhtwQov30JBsGXk1DhSw2RcfAMYd30Yr6U5iaEN4xqKh+c9op/re+LI
         aEzhdAUg79MhqmF9VzFl/hu5lgXJt5Jr5AxrKXGNZgxovjPxDx4qVnBaH7WMHIussV1t
         KYPZr2D0/stGdLK9gj3wRfFhFVesVup4AHLobqRW+wUElHaCgnqxjAZ0s2xY/lCQFZiq
         jZ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772807754; x=1773412554;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3Jbx9+EVK6y4U1OT7nCohIUASMhFn/GxeOgFoW/iLRw=;
        b=p6aSKKnYEkLP8OHB5IeDw3TuTeLOxGs3w7TkXot0PsqAyAKia+rl6C+Nvj6hxX6yEJ
         lVg7P3YBQ1+1neixJF7ZWJTsVt9t5Oq9T1li4PzKxGYpN/dpKH4i4canxzp1debZZNds
         tU1giFalXCb72SJBlJjm3BSqC6tdWaWQWLV+llYzUd4wxfZVHB4P99h2wWuNER2MsjqS
         NsqnxgWfDnJkZ9hjDo3vQYFb0IRCvDtTSAQOYt02jwoBSuYEyz6M5TWKg4LmJa+7aEPh
         eh0a60RQSjggOy5ehv1hcdksXSywGIQOO5ULg6cA5mYSklgOxyEC7HW+sYE9BZhEg9Nt
         hIcg==
X-Forwarded-Encrypted: i=1; AJvYcCXp0naIYYTex3ShNaqBsKrIgYz4BYrCw+awcH4evG/HFPgtc1ilBbbHOnyzEMYrlAmO7esgn/ORzctICC3LzxK4zCo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzEtqhE1kIfSSMbQ5kChhmp38uKOXONFeHmZ+nmVrloIK2BNYSt
	44TX90XzkyYkRAVFTONa9p3nER9k21F+Q6wDubauKwLNiVmD03NPZa4BwyJ1IlCCV60LOcrz0Lp
	im5f4nxGw2FysRmwRxiDe5g==
X-Received: from wmbjt23.prod.google.com ([2002:a05:600c:5697:b0:483:2c43:9664])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3488:b0:47a:81b7:9a20 with SMTP id 5b1f17b1804b1-48526923bc7mr37026555e9.9.1772807753846;
 Fri, 06 Mar 2026 06:35:53 -0800 (PST)
Date: Fri,  6 Mar 2026 14:35:06 +0000
In-Reply-To: <20260306143536.339777-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260306143536.339777-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260306143536.339777-3-vdonnefort@google.com>
Subject: [PATCH v13 02/32] ring-buffer: Store bpage pointers into subbuf_ids
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org, maz@kernel.org, oliver.upton@linux.dev, 
	joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com
Cc: kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
	jstultz@google.com, qperret@google.com, will@kernel.org, 
	aneesh.kumar@kernel.org, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The subbuf_ids field allows to point to a specific page from the
ring-buffer based on its ID. As a preparation or the upcoming
ring-buffer remote support, point this array to the buffer_page instead
of the buffer_data_page.

Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1b8be41faa78..45ec49d6c81d 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -555,7 +555,7 @@ struct ring_buffer_per_cpu {
 	unsigned int			mapped;
 	unsigned int			user_mapped;	/* user space mapping */
 	struct mutex			mapping_lock;
-	unsigned long			*subbuf_ids;	/* ID to subbuf VA */
+	struct buffer_page		**subbuf_ids;	/* ID to subbuf VA */
 	struct trace_buffer_meta	*meta_page;
 	struct ring_buffer_cpu_meta	*ring_meta;
 
@@ -7036,7 +7036,7 @@ static void rb_free_meta_page(struct ring_buffer_per_cpu *cpu_buffer)
 }
 
 static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
-				   unsigned long *subbuf_ids)
+				   struct buffer_page **subbuf_ids)
 {
 	struct trace_buffer_meta *meta = cpu_buffer->meta_page;
 	unsigned int nr_subbufs = cpu_buffer->nr_pages + 1;
@@ -7045,7 +7045,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 	int id = 0;
 
 	id = rb_page_id(cpu_buffer, cpu_buffer->reader_page, id);
-	subbuf_ids[id++] = (unsigned long)cpu_buffer->reader_page->page;
+	subbuf_ids[id++] = cpu_buffer->reader_page;
 	cnt++;
 
 	first_subbuf = subbuf = rb_set_head_page(cpu_buffer);
@@ -7055,7 +7055,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 		if (WARN_ON(id >= nr_subbufs))
 			break;
 
-		subbuf_ids[id] = (unsigned long)subbuf->page;
+		subbuf_ids[id] = subbuf;
 
 		rb_inc_page(&subbuf);
 		id++;
@@ -7064,7 +7064,7 @@ static void rb_setup_ids_meta_page(struct ring_buffer_per_cpu *cpu_buffer,
 
 	WARN_ON(cnt != nr_subbufs);
 
-	/* install subbuf ID to kern VA translation */
+	/* install subbuf ID to bpage translation */
 	cpu_buffer->subbuf_ids = subbuf_ids;
 
 	meta->meta_struct_len = sizeof(*meta);
@@ -7220,13 +7220,15 @@ static int __rb_map_vma(struct ring_buffer_per_cpu *cpu_buffer,
 	}
 
 	while (p < nr_pages) {
+		struct buffer_page *subbuf;
 		struct page *page;
 		int off = 0;
 
 		if (WARN_ON_ONCE(s >= nr_subbufs))
 			return -EINVAL;
 
-		page = virt_to_page((void *)cpu_buffer->subbuf_ids[s]);
+		subbuf = cpu_buffer->subbuf_ids[s];
+		page = virt_to_page((void *)subbuf->page);
 
 		for (; off < (1 << (subbuf_order)); off++, page++) {
 			if (p >= nr_pages)
@@ -7253,7 +7255,8 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 		    struct vm_area_struct *vma)
 {
 	struct ring_buffer_per_cpu *cpu_buffer;
-	unsigned long flags, *subbuf_ids;
+	struct buffer_page **subbuf_ids;
+	unsigned long flags;
 	int err;
 
 	if (!cpumask_test_cpu(cpu, buffer->cpumask))
@@ -7277,7 +7280,7 @@ int ring_buffer_map(struct trace_buffer *buffer, int cpu,
 	if (err)
 		return err;
 
-	/* subbuf_ids include the reader while nr_pages does not */
+	/* subbuf_ids includes the reader while nr_pages does not */
 	subbuf_ids = kcalloc(cpu_buffer->nr_pages + 1, sizeof(*subbuf_ids), GFP_KERNEL);
 	if (!subbuf_ids) {
 		rb_free_meta_page(cpu_buffer);
-- 
2.53.0.473.g4a7958ca14-goog

