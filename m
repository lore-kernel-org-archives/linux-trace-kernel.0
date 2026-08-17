Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B5783F3265
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 13:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786974932; cv=none; b=QXc71aBBm4wEi9bGfG6JHHDFY9nYdFOVYRvKGqx/gb7c1k2m0w5/oAoYgVV3Hc1jVZxxExRa5vVuErAUv1+t9WfwXnc8Q5aLyEqmQJMSM7oafnapC5hu8zCeBd0YA5GKeemQCLeBFbHVV0bRSpFG0MuPdANEyoxK8E6L2t0UmzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786974932; c=relaxed/simple;
	bh=5D+J+WN1PrdipY7Q2jg2gQvYQ4VzQwH6rBUeW8v+XAM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ef1ra/bmsdiHi8H77szxyN1hJtSzRvVxu8kJLTJqLYUIMNSE9dtcAOx7CHPmQgQmCk5kXUk8oyb0SFvzXYd3aIZ2XKyaqZssCS0ftSg+VwQsZyky+rqSLmpeqZHDmfkMoUd1kzltR6+bgxzc1veTVczP0u+sUuIN592QWWYl+JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rth2EUo3; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rth2EUo3"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4954a93c565so18109665e9.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 06:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786974926; x=1787579726; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JIc9fp2Xg7OV951Yd7ugobdgChHvuvN5bMxsVh4yLac=;
        b=Rth2EUo37UUqBenJtvVV5RzkSJALPpjvIBLI+a3rmry+nBnBrIZNh2ENiludNxcPga
         vEtVwYNSrIzljs4RcLMWFwRT+ojNlIjt3DfGmSbmXMG/h6iTLrkJftETTlSHkVKG8PKd
         SDqjFfIbErNjZ1QT6TVCSTXgiiqTiP6ss8+xrt+UU8vZupNn8wv3WyEHi3yEAc8T8KNx
         B6IlooqMbJFCIvyY7iVQBc5Uv8Oz3V6geRU2Y+mDJcH3BDelwTQ4O46Ys6OuXhnwzZNv
         1zBt3YEqHAPdXyp9ZO5LuZUqdFitZbhR+EReEPmePh/HkOxy73sRqJzlQOP1H49Mcvlq
         4kYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786974926; x=1787579726;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JIc9fp2Xg7OV951Yd7ugobdgChHvuvN5bMxsVh4yLac=;
        b=iJC3XIvzDzIsH7r5cQ20CyThFLneQQgN9kYazJpDBUaKKihYMlkuIU6Yix+FjLoyGM
         H1LmQ7uTUcBuBsnqbv930I7cJFQbccgGezAuprp/XEOXzib0lll2fgHgZ3GeBedrRpeB
         MbsDqzY1lVUVSwoPf4WOvZbhrNU/4QhAzamvs+c3HtQb0koskAAXk6y1y9Z+iF+0KEOb
         QneIbtAKdz0N1nPQw6agAU9K2WkstGVZI6ItSu/1ir9Ac0shaqDdNxZCEqo2c6S9P3W6
         ol9x1WyG+Kf7XHaBMHsefjCLuPqDkkLlbsEJndoXDdNXWqcAm9wzzCyvwP6MKM3m3TL4
         S7zA==
X-Forwarded-Encrypted: i=1; AHgh+RrYvBTHbVHgDMNT7K8zqqsV+w2kxVf3bi5PA2D9srW+flLuffODaR/j19YPbdnQGC7PJkZzZeSm9CAH8nEuA8w72HU=@vger.kernel.org
X-Gm-Message-State: AOJu0YxG5oHE2ljCjRSt2xxiRJCDXdFWyv8Nos3W/mXcMEsDPJQ4cJlz
	JzLb4tHqcNCuwdos3Y6aqBK1CsBHaPpNQb/zNX9FFQukD21TerUzmgzeSlOQ2ki7/wqi02QciCP
	gGeZ5lOilGGTD4HgniO+Q0A==
X-Received: from wmjq20.prod.google.com ([2002:a7b:ce94:0:b0:488:9b69:9379])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4fca:b0:493:a623:d090 with SMTP id 5b1f17b1804b1-49987961c23mr382490185e9.10.1786974925429;
 Mon, 17 Aug 2026 06:55:25 -0700 (PDT)
Date: Mon, 17 Aug 2026 14:55:04 +0100
In-Reply-To: <20260817135517.3919534-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260817135517.3919534-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260817135517.3919534-6-vdonnefort@google.com>
Subject: [PATCH v6 05/18] tracing/simple_ring_buffer: Add support for
 compressed length
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The array length is the total size in bytes of the data for the current
event. It is possible to compress this value into the event header type,
which has 28 unused types, saving 32 bits for sufficiently small events.

The compressed length is expressed as a multiple of the ring-buffer
alignment, 4-bytes by default. Enforce this alignment.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index f4642f5adda3..a7716064e11e 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -207,7 +207,13 @@ static unsigned long rb_event_size(unsigned long length)
 {
 	struct ring_buffer_event *event;
 
-	return length + RB_EVNT_HDR_SIZE + sizeof(event->array[0]);
+	if (!length)
+		length++;
+
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT)
+		length += sizeof(event->array[0]);
+
+	return ALIGN(length + RB_EVNT_HDR_SIZE, RB_ARCH_ALIGNMENT);
 }
 
 static struct ring_buffer_event *
@@ -223,12 +229,15 @@ rb_event_add_ts_extend(struct ring_buffer_event *event, u64 delta)
 static struct ring_buffer_event *
 simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned long length, u64 timestamp)
 {
-	unsigned long ts_ext_size = 0, event_size = rb_event_size(length);
 	struct simple_buffer_page *tail = cpu_buffer->tail_page;
+	unsigned long event_size, array_size, ts_ext_size = 0;
 	struct ring_buffer_event *event;
 	u32 write, prev_write;
 	u64 time_delta;
 
+	event_size = rb_event_size(length);
+	array_size = event_size - RB_EVNT_HDR_SIZE;
+
 	time_delta = timestamp - cpu_buffer->write_stamp;
 
 	if (test_time_stamp(time_delta))
@@ -259,9 +268,13 @@ simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned long lengt
 		time_delta = 0;
 	}
 
-	event->type_len = 0;
+	if (length > RB_MAX_SMALL_DATA || RB_FORCE_8BYTE_ALIGNMENT) {
+		event->type_len = 0;
+		event->array[0] = array_size;
+	} else {
+		event->type_len = DIV_ROUND_UP(array_size, RB_ALIGNMENT);
+	}
 	event->time_delta = time_delta;
-	event->array[0] = event_size - RB_EVNT_HDR_SIZE;
 
 	return event;
 }
@@ -284,7 +297,7 @@ void *simple_ring_buffer_reserve(struct simple_rb_per_cpu *cpu_buffer, unsigned
 
 	rb_event = simple_rb_reserve_next(cpu_buffer, length, timestamp);
 
-	return &rb_event->array[1];
+	return rb_event->type_len ? &rb_event->array[0] : &rb_event->array[1];
 }
 EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);
 
-- 
2.55.0.691.gc56d675ccc-goog

