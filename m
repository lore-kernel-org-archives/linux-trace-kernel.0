Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375F94FD280
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 07:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062199; cv=none; b=AcPfaq19xpdZOMuP58KsR3umd9L352zfrYG9woYE7eTftDNGKEoSqyef2XvCShsWC6MZ/235SjwuhjpEQTkjYHHSfTXsNjKqMjISjdDytVXQ8lxS9ofeb8BWxWD3EB3aFgpxKPHGRG+9DC23Zj4NClKLaKGrlp6k/opX0RRhbKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062199; c=relaxed/simple;
	bh=d4W1CAKZqJFP+rhzc/mGkXmSM4enJRB9Jj4NgZnjZbc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XXwq797pXGf/iVH+qYnm2mHigw/+2HV4e7OrGe4KH0RIyBnL2/gro9jdWqNaGZdBzpV1dkE+hIBjFkUhYqvy2JpRQOGOc4OLc0XMOjZrktnIBfkuQ/3BAyjRSWxxE5AWoe/0fg7YKyPy+JW6IPfCyMxAqLBmsPsqRRb+PdO4Lz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=G/Ik0XL7; arc=none smtp.client-ip=209.85.221.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="G/Ik0XL7"
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-486f3c0d896so2099761f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 00:29:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790062196; x=1790666996; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=j1G2B+1jiMpXjFmSkI0X0frbWg2TCjpXRk9JIZopsjE=;
        b=G/Ik0XL73T6Ln+9drxC5PWRNnCyhPGJztUXGtf1kJBuwJS8jF5d9Kfh+gUK2rAsZLC
         1y7lOSG3WLo+AGpdD/i0oA94wCwg4+R0ggMWVC/i19tiTQTYiH/rF/R6o7gG4sIptmY9
         B5zw6Ofu0rLfrgAlxvB3HYYV5lasCS1Xog93klxnldeD8XPDXApUtPjxhxxyz2L15QSO
         UI5QAVi+EUcCGskSFJYpG78m4AdVeC8cfV4WuKitzZc+Zsn+CjRxVJXwj7bnViFKeCSU
         WwvDv6eMNediewj7KZTrmPczqeDEYqEC0qCXUZ1+E/2FOlsILgt9bnoDhJzdZ3iiwDd/
         qYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062196; x=1790666996;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j1G2B+1jiMpXjFmSkI0X0frbWg2TCjpXRk9JIZopsjE=;
        b=mcDKFgXQutwXyzvL2j8O2lR8+l0o5UpcX6eJB3qS9jdnUHVWdLvzLP6x2T5k/bg6qV
         W+7Pf+WdZ0ZJKXoNwttSkfzlBdtplR58NqPzRDIml/HHxUwG+scnsKo1QqebllzKYrRe
         ZmWpukFucvdrQ8XgkZSlHcPyn+xzG6FPP9ZX/NnsxFj0zG6vN9rOTMUe5iGIVvoC4BIx
         ddPHfWv19arKDOw2jBzmOEHQhCd9Xzd5LSsOQiwL/25nkvvFnNDgEqtnxDzgT4zYZfuA
         LdTEsDdcW0y4lHQ0v001YG3UfPcYLlPN7mvXj3wlZeg1OGmhnWB8NjDqsP9jTDQVoqcA
         cM8w==
X-Forwarded-Encrypted: i=1; AKwUvBxh9b25uajckgSkNB8fsSODveEI/A8jy0Qq1Gz0fTbv81sfeD8ZUdn4Wo6Y8B6cbkjHK+PActnuKK4n3mbGgR/erQs=@vger.kernel.org
X-Gm-Message-State: AFuF++mga2VtPBb3XHhHe8p38TLIRYZWU2ktYosft9A7yJxFIEMtWNJL
	mfqIuTIY3lNZ/Fzo0Hj/QwGS5efewn/dEK/+9INwg8qeA/sg78I89gAHU0WmLzOXqJsztZNiiyd
	sQWGnPMvkcmsGMusAuy88jA==
X-Received: from wmxe3-n1.prod.google.com ([2002:a05:600d:6503:10b0:49e:6ad9:14a2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3e07:b0:49c:fc6c:be09 with SMTP id 5b1f17b1804b1-49fc58594d0mr181580785e9.32.1790062196167;
 Tue, 22 Sep 2026 00:29:56 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:29:43 +0100
In-Reply-To: <20260922072944.1281427-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922072944.1281427-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922072944.1281427-4-vdonnefort@google.com>
Subject: [PATCH 3/4] ring-buffer: Drop redundant ring_buffer_iter::event_size
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

event_size contains the maximum size the iterator can read for each
event. It corresponds to the maximum capacity of a ring-buffer page.
During non-consuming read, resizing is disabled. It is therefore safe to
just use rb_subbuf_capacity(), making event_size redundant. Remove it.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/ring_buffer.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 1a158a24b3c8..3129589e2d0e 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -680,7 +680,6 @@ struct ring_buffer_iter {
 	u64				read_stamp;
 	u64				page_stamp;
 	struct ring_buffer_event	*event;
-	size_t				event_size;
 	int				missed_events;
 };
 
@@ -3558,9 +3557,11 @@ rb_iter_head_event(struct ring_buffer_iter *iter)
 	 */
 	barrier();
 
-	if ((iter->head + length) > commit || length > iter->event_size)
+	if ((iter->head + length) > commit ||
+	    length > rb_subbuf_capacity(iter->cpu_buffer->buffer)) {
 		/* Writer corrupted the read? */
 		goto reset;
+	}
 
 	memcpy(iter->event, event, length);
 	/*
@@ -6488,8 +6489,7 @@ ring_buffer_read_start(struct trace_buffer *buffer, int cpu, gfp_t flags)
 		mutex_unlock(&buffer->mutex);
 
 	/* Holds the entire event: data and meta data. */
-	iter->event_size = rb_page_capacity(READ_ONCE(cpu_buffer->reader_page));
-	iter->event = kmalloc(iter->event_size, flags);
+	iter->event = kmalloc(rb_subbuf_capacity(buffer), flags);
 	if (!iter->event) {
 		atomic_dec(&cpu_buffer->resize_disabled);
 		return NULL;
-- 
2.55.0.1082.g2b9226bbc0-goog

