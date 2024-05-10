Received: from mail-wr1-f73.google.com (mail-wr1-f73.google.com [209.85.221.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 275C8135A6D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 14:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715349885; cv=none; b=jfdms5i1EWXHH4mR+WxBr9Aw+iysutmVcILkkTATe2liZ79Br93cgPmXnSQklU3L8cMRUzQN5vYC/vtTGt+fM6c6yNjtYojzlnBxOoE/jURJCzZnuES0AGJCJd89PVfzZiwdG3VHo3Af/Vmp/cLbIhsrrdZKV+k667C6ND6pMOw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715349885; c=relaxed/simple;
	bh=SZOR+cdwvHoOQJtmOOG1N3KpDv0/bZPsbnxNNIa91OQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=FfFPYoo8POXZ0RQX0JIBZSBgBRCbl1/NsUYLIbIPuwzODd08QE2v89DRYJLeot5s2AWCTKGPjeKg6Ojrnow7zJhvtrD8Smrw3qgyfpKkQ4XVOwsx7yl8maZLRHGyP7cvXoyA+Udg4oMUST2jhDSwFM09050UZoL35hM/yfRxmBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=O0tvWHfb; arc=none smtp.client-ip=209.85.221.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O0tvWHfb"
Received: by mail-wr1-f73.google.com with SMTP id ffacd0b85a97d-34e08bdc701so1277837f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 10 May 2024 07:04:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1715349882; x=1715954682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JnCpfZnwxk3j+z1aMY5Xz+L+IXVW2XNLvHkBjDivyKk=;
        b=O0tvWHfbskQQp3QLPGx0I3HM6sYGfNA59QSt/LPAJUhAP0WHISQcbEydjmS+l55Ev7
         6CQ/iN0CAJttNUimJcl5iguMf7QcmzDAl2P2ZhQ+YkQYZB+SM7uLbfHAevt2k/bcRB+Z
         2tT7745TPpAhCm90ezNio6YGVGOq1SJqpYBte+T8h/tQ2SeblccMKXNI4MfjJ097QYVY
         EvZBqcPgN7ytFmW6yfPYJBKfT5xGngG3Op+vqhsdr2eGctRH7D1fHvms86jkgPaczlVC
         Ma+BQgYYEioxTEjqPN8ThRv3uN0vauKX4GI9peFoWqN8pNAZqqNAyByZ5K9ifU+2rKXw
         lYWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715349882; x=1715954682;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JnCpfZnwxk3j+z1aMY5Xz+L+IXVW2XNLvHkBjDivyKk=;
        b=DYN+CNy7zW6IMArRMGAquk1qWAvOhZ5DeD+TE/+nOk+rxqBt0Dv+ZNuBK5LmnhJBnH
         8C+JAKI7PusSaTiEM0PUheMlEvFdnPE/PmX0hUrhLJwwEsouczIoCv4Khih0EKWm1U6T
         tpznnIzidWaQa/0CBHBJSALOTj+yckxRux91I8vHeHDKo9u0Wtg6Gr/NkanriupJdb8f
         2/IxV42M7bbCc8Uc13n6x4DYnSk/rM7ul1pHf/5ycZg+OC/4a0AhCitjuFYn8siMY+Ql
         Rh77rb11tXVE1vt0ujCBpEFowp5wk5cWeo8seHDBgO9QwqDC0xa3c7mvSXanRg58O/yL
         p4EA==
X-Forwarded-Encrypted: i=1; AJvYcCVzDhF1HNLd1KGBga7M7mlz5KXOjJDVWpvjQEDTB3QCBGgLEwllz7s9PaUJWJSh18NBYOPfW2M5BzXdnZ4hSD4LWgPLYNCox2f9BpL5KhQiwGZR
X-Gm-Message-State: AOJu0YxwbJD0rhnUvZ3fOvQawXjj22MOpETHl78ShlJD8bD7HDGArDtD
	DT1gTS+XsSkt0MVX6tsy6GtlzRH0C0KsBNlQKeo7XUE7iN663mBgh6QS4dLOnsxgp52TMAfoXiQ
	bGl0VVlyL88oxTXnOAA==
X-Google-Smtp-Source: AGHT+IFXhnWP84kxCNk+PZ9vj0MgxirNqa14pNH4yG32+TVtHaIZdm+mDsQT3iO7l5L6O8intT/2Zyw7O7a8WEcH
X-Received: from vdonnefort.c.googlers.com ([fda3:e722:ac3:cc00:28:9cb1:c0a8:2eea])
 (user=vdonnefort job=sendgmr) by 2002:a5d:5943:0:b0:349:ba19:6e4d with SMTP
 id ffacd0b85a97d-3504a736156mr6749f8f.7.1715349881300; Fri, 10 May 2024
 07:04:41 -0700 (PDT)
Date: Fri, 10 May 2024 15:04:30 +0100
In-Reply-To: <20240510140435.3550353-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240510140435.3550353-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.45.0.118.g7fe29c98d7-goog
Message-ID: <20240510140435.3550353-2-vdonnefort@google.com>
Subject: [PATCH v23 1/5] ring-buffer: Allocate sub-buffers with __GFP_COMP
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

Acked-by: David Hildenbrand <david@redhat.com>
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
2.45.0.118.g7fe29c98d7-goog

