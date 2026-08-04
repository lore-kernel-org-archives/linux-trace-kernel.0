Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com [209.85.128.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D16346AF0A
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Aug 2026 14:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852241; cv=none; b=iWGMMSr8hmTT5aFZM38pfnw09jAuNEuRc/S6QcTyScjtdcobAoLjy3Xb69/cmDvbrezfYoZgqW9gVjBbYOVItz2V7zsq5S55e0WEWhsBCu+0xVsjtsBldM11q12V35e4u8n7PJUDUIBfCZYKksN13COY4zuezsUhqAPCPPcUK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852241; c=relaxed/simple;
	bh=gAxmUXxonnyTb1ML02g71HD++Ag+MWMb9gtk5XKi+VI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ot7oOziQe02+hceOyjlODY98ZMRblLgNnYOvKMOHf08OSCc3c8qxy1cW6Lm1XxVHM+8sCAm4uQfdpJ2L65hbemKnxstrUGyyLIpV6sWXSTNpBzZpLW7wbp4xyKFFUwq61UX1PYlwRhY2GYvjKEUf2gF7AHXsil/3OeGbkLPGhDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=k6EVTpwF; arc=none smtp.client-ip=209.85.128.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k6EVTpwF"
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-496b6f97676so36344675e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Aug 2026 07:03:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785852237; x=1786457037; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UowPlZ8bZ1cpN+rdzysaXkXW4M7Wma5JPRhoyN5DsfY=;
        b=k6EVTpwFEveW8BCU08pDX4Ocd86byh1PiXQoHS8oNczX52JoK/P+5/o7DswQkVhets
         Sob3v1B59ET7B9wbp4p/kmkfp6lvLfrCAyvJJkiy8uLPrW+yR8rLx9Kndrig3i3hFhd+
         JGqj9qTw/aD4gahV4YXmSgXkzcG92vs2afppfBCBesaq0TPGor54PdsOCkiY+Uwk99i2
         lDeDnbzL6gRCRgJOHHiUDsljHWvvpSsxWse44P9e4sikUEMbly5zWCUDdXbAiSbbIyJY
         dUeb4vR0O1oMtUxf/xSArXRog/0+ViCDh8M8LHNbXTBYfvIw2MCbkW7RlvEJOPjNg4No
         M2Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852237; x=1786457037;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UowPlZ8bZ1cpN+rdzysaXkXW4M7Wma5JPRhoyN5DsfY=;
        b=ARN80osPW/zsY/BYBZnscg0g9XWUebUu+HFOchFM9lg7Qjp2uaLRkACF5qYdi6ER0c
         TocTX0JL6SN729qmaKjtz5RSex4s7DTRhbJIV+OyE8sJCoM8Qzczz5KYcp9xi/dYz48A
         xdO0vwTndv1WC5qkReqDlTgW00Y5Ks0fBtUOlfRjPtkX0kDVSezimy9sUdJxpPGBWwc2
         PqIYIsUCXR0Vp+m9qCFMbheelTWl7MiVF/CVsAojOKJI0/jLUbctUceMkfZBW8Q2DjT5
         YWCs4+0/LiTvUE3QisTIxLvUdl/GRPWPuymXbi8i4tJhXu+BLID1r7TQcjKe9jjBpBEE
         0aZQ==
X-Forwarded-Encrypted: i=1; AHgh+RqYt93EAvpmSJ149mirPVUz0rp2jCUVhf5FAQ3BuxfLADyKDO6RlI3KddegsjKxtU/VYjgeF0m+gJwwzyw7WMwiu/Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzyz85CZQSZqXrlkwuCasbtg0RNFwbFL2DZ/eoxhrK9wx7JesGW
	W64l6souy7+71GomsQ1CAclMTlbeIcaFATGgHUm0ILQBxBzX62edcRwR+NH4R3Q5HTXzORG4azD
	/l5ev4lQ/8mUywUnw2F6nJA==
X-Received: from wmqd6.prod.google.com ([2002:a05:600c:34c6:b0:495:4aa0:4b5])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4445:b0:493:a438:7f98 with SMTP id 5b1f17b1804b1-4980c694df5mr289599095e9.18.1785852237299;
 Tue, 04 Aug 2026 07:03:57 -0700 (PDT)
Date: Tue,  4 Aug 2026 15:03:20 +0100
In-Reply-To: <20260804140333.797210-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804140333.797210-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.571.g244d577d93-goog
Message-ID: <20260804140333.797210-6-vdonnefort@google.com>
Subject: [PATCH v4 05/18] tracing/simple_ring_buffer: Add support for
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
2.55.0.571.g244d577d93-goog

