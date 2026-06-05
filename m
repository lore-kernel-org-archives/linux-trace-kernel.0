Received: from mail-wm1-f73.google.com (mail-wm1-f73.google.com [209.85.128.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9D5383C64
	for <linux-trace-kernel@vger.kernel.org>; Fri,  5 Jun 2026 16:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780677584; cv=none; b=knyZ1lcDdNgTChHJ89S4IO4+1qP4A/T/fzhVUwoLyDKCR0WiVUES4QgK0DIN9fNBGtHt8AZhdcP7TeIMMIvsQK7hvpNWddbygADKzyojVtp+KH+Tn4sZXvZUf81RdUpqF+bGasQz3AbtV6D7lfwideyjepYbKmH72CPCpro6zwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780677584; c=relaxed/simple;
	bh=MbixKbdFwSh/paHvdfryVLZy4WnwvCPimrbFkMMEvaA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=HqfzuW3tGQengZPUe/iKC1FhExKp1a/gF1aJzqO02hM5zsLzjUh1t7+5UgwGtuNVSZraCNIXTduQ5AqMarm0AMtKBJQHNGDY09Lei4nyLvWZ3z0YhFBQK25NLKUnWunBSAhIkKLG+Ju0k7jzxGEsz5MgRmjwIj+vrnee+SjwpVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uZb7LNni; arc=none smtp.client-ip=209.85.128.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uZb7LNni"
Received: by mail-wm1-f73.google.com with SMTP id 5b1f17b1804b1-4908af8d7f9so3022875e9.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 05 Jun 2026 09:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780677580; x=1781282380; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=j9Az+x/ve13gLbdORw9cBY6nMJyoGBG3j2gyvMui8cc=;
        b=uZb7LNniBLmTMFdocDYxXLh//5jpXysXcMH8nwv6cqi/TQcCe2xbaKkIbRDmyo/7TU
         RXI4qbbaH44+94BGvb/l5lu7+IMPzML04yLzJMGRKGCOQGGqAolQpICSbzchM7kD+E7v
         7JxbjUkKjEaQ/+OMA4Aryh1Gpvniadmjie/EyTIxNE9GXomcbQfvwLdCHflqL5fEjS94
         6QZPg59Mqxn49pbnTA6WqEa3scWkyAzEBnPv4Jp9MOMOz8XTule80Iyml9lxVHXdDKJd
         RnkotDUDxLZiq1QApbQobJN1ijaOywP+8HntJBTN+TVIIM3bgerIgqtHQV8ET3y7JOq5
         MOkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780677580; x=1781282380;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9Az+x/ve13gLbdORw9cBY6nMJyoGBG3j2gyvMui8cc=;
        b=gHzHCNRzQG9c4kgQCQXvWjwF0ILaDMwLnjuUizgxXGFex6JFpoW0pR5hbV3mbeKVrX
         lcoL/J/51z1eBW/LaBzHESMfvUo1Ea22HKK1dPkgCHr5VBTCOEt6qDG0ncBBNU3mEW0s
         BJLXgs4WxwzBWzjc+uaIxa5X8xAcT63NP8x0evee2OaJIGqVbC97HELQUauK2obUpXpm
         55M/Du419ut7kmczl11T6HlN2Iy/g3wYVcIjXACrTNSBlmA65rlwFl1m6neZJNe0297T
         4LWDeRkt7MTO7TUUMpegwbG0yk8Eiw4KKkF0G0rB3c8tG5ElUfJVpdl1jknk9QhO2Vht
         yHLQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dQXrlHtmTBBLGjr+yKhoDjJdmPGsrx+AhDpudxNZz9+NHs8mRh+Og7PFvPFmXCVLFmDSI1CHBv+Ud5pqs9g7cJ4c=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHgzsbZ9Z7DnIDwTifgnRY8K+RHEV2nykhUvk97VoPAAvLLmQW
	b9xTTa6CL7qDH7/MAuok2u85MwegQaD/PEdwxci0wkaDlU2mHQlaLKRUIK89BIjmy5SvT0kRqFV
	BXjeotUn5jPjJOOGUoJ76WQ==
X-Received: from wmlv24.prod.google.com ([2002:a05:600c:2158:b0:488:9b69:9379])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:a302:b0:490:c2a3:1781 with SMTP id 5b1f17b1804b1-490c2a317c3mr56654085e9.34.1780677580144;
 Fri, 05 Jun 2026 09:39:40 -0700 (PDT)
Date: Fri,  5 Jun 2026 17:38:12 +0100
In-Reply-To: <20260605163825.1762953-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260605163825.1762953-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.54.0.1032.g2f8565e1d1-goog
Message-ID: <20260605163825.1762953-6-vdonnefort@google.com>
Subject: [PATCH v2 05/18] tracing/simple_ring_buffer: Add support for
 compressed length
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-trace-kernel@vger.kernel.org
Cc: kernel-team@android.com, linux-kernel@vger.kernel.org, 
	Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

The array length is the total size in bytes of the data for the current
event. It is possible to compress this value into the event header type,
which has 28 unused types, saving 32 bits for sufficiently small events.

The compressed length is expressed as a multiple of the ring-buffer
alignment, 4-bytes by default. Enforces this alignment.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index f4642f5adda3..1a97d17cca24 100644
--- a/kernel/trace/simple_ring_buffer.c
+++ b/kernel/trace/simple_ring_buffer.c
@@ -207,7 +207,15 @@ static unsigned long rb_event_size(unsigned long length)
 {
 	struct ring_buffer_event *event;
 
-	return length + RB_EVNT_HDR_SIZE + sizeof(event->array[0]);
+	if (!length)
+		length++;
+
+	length = ALIGN(length, RB_ALIGNMENT);
+
+	if (length > RB_MAX_SMALL_DATA)
+		length += sizeof(event->array[0]);
+
+	return length + RB_EVNT_HDR_SIZE;
 }
 
 static struct ring_buffer_event *
@@ -223,12 +231,15 @@ rb_event_add_ts_extend(struct ring_buffer_event *event, u64 delta)
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
@@ -259,9 +270,13 @@ simple_rb_reserve_next(struct simple_rb_per_cpu *cpu_buffer, unsigned long lengt
 		time_delta = 0;
 	}
 
-	event->type_len = 0;
+	if (length > RB_MAX_SMALL_DATA) {
+		event->type_len = 0;
+		event->array[0] = array_size;
+	} else {
+		event->type_len = DIV_ROUND_UP(array_size, RB_ALIGNMENT);
+	}
 	event->time_delta = time_delta;
-	event->array[0] = event_size - RB_EVNT_HDR_SIZE;
 
 	return event;
 }
@@ -284,7 +299,7 @@ void *simple_ring_buffer_reserve(struct simple_rb_per_cpu *cpu_buffer, unsigned
 
 	rb_event = simple_rb_reserve_next(cpu_buffer, length, timestamp);
 
-	return &rb_event->array[1];
+	return rb_event->type_len ? &rb_event->array[0] : &rb_event->array[1];
 }
 EXPORT_SYMBOL_GPL(simple_ring_buffer_reserve);
 
-- 
2.54.0.1032.g2f8565e1d1-goog

