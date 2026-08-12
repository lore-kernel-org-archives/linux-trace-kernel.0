Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF8434307AB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551233; cv=none; b=iu9YIlNMUzMbGTviVuBe92N9qaHW+e64fLTDSJ3Wo7pEum0wHBWlhKncuUujYQrk4A6vPfGfxlaiECG0wFMbC4GeJhJjNDE6PQbm5fERriS+VeDKycgMs1oQxxON29+6yHn4lmFG2FS6kWClZw7DuKSoX4VOZm87dEnS9qXHjxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551233; c=relaxed/simple;
	bh=+6dPvGulOdcG8bTgTGM/N9X4v4myJf5iG43YXUqVW4Q=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=XHKjeAUtIgpJZDpUXhCQfRzVvz5dRf25XDFRG4OwWDxTIM6Q+aAVxjV7vbNUWW0JEaefNE4uZjQCasPbEf+/Jai+J53VK67cqy80KcMe9ZSIaT2RAleY6rLZOc6D5EjjvgKKWbhZNKb/IlNjInEuKeBHb9Q9IntMQmhUdKTEohs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HzGo5I55; arc=none smtp.client-ip=209.85.128.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzGo5I55"
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4955fd77c18so7898775e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 09:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786551230; x=1787156030; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=S8XgNxuY5DpwjIT2t2rtjilcKs/c3q6DS2R6kVT+oYM=;
        b=HzGo5I55ADTSGnq82yzIbUX1N3CX6lxYewp5Bu92yQH+ys5j74srmOHiSrZX8tWQlV
         oplItnRUjvYonvC8cABBfly722U1T6mi3n/FjGO+emHyginm9CpMbKtWRpl+5Eh1ULIH
         HGTm1SnQOuRokng8MTV/vI7Tk+CTSv9OhVsEK5ovUQyXhCSHHSCJcetjAupDpD28BF3W
         hXj9J4W3GjFxzX5AgxVOKKVEgEZQkUuY1JsFfV+B2YS+G8emuwqKhO0weCTxPx7fQJU+
         dfqMspuLbERniFRwDL20qb5T3T0MEhz5Pb3f2kH/pQ8siz1tr3a7U1b744IVKxlyywbG
         XmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786551230; x=1787156030;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=S8XgNxuY5DpwjIT2t2rtjilcKs/c3q6DS2R6kVT+oYM=;
        b=ltuuZyZPR7x0YjoDbY35W6qLJ3sLJws7pMi8DZLaW33ika++ccMyEVfUQZBGc+yWoJ
         uL1fmi8DT6P+CWLhdrRqpXlu5HMO+vHx0/pfGaoPTXQ7XvtFUMXHzBBAMb7AA42XgkRL
         tTovG1H/UDWogiXNeUYH06dxqVMIIKkl0OnsMLQ3irR6fmjy/kCEJ4/yJCKowESpgsQe
         8fwsEYsOatcgErnTEghDucvnDVnB3/faezNWoRB87fJvzyJRTYiqg1lST7eOGnA0Dhxq
         yPd5yoMrx0/WotUlCApmbE4AuXC89ASl94liucI3Pf/p31MZ5BgHWl6zR6pT/cOMi/pS
         B5ug==
X-Forwarded-Encrypted: i=1; AHgh+Rrt1dZdq0ZWdHMLpyR+hbqK7UPXDTpt3JkMKOu1BSHSIBDiw6MgsdsyyfI/ahuBb7oDmeCmO9TFmGwEKThjan4VGaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwnFPeG+3l//vAW0+Bu42ZLU6poAfanQA0GdpH6zmPNW2orGCjD
	UZ2WQKYPMwW1fAMUvcv9PrWHZJG7JucWf4PSEjBm9oR9nsNULeFGixjzAttYIT0moighyazVKVx
	dHBCFEnSRFUP2/3gxespqfQ==
X-Received: from wmqy6.prod.google.com ([2002:a05:600c:3646:b0:493:d1b8:3df5])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3146:b0:495:4d00:2fda with SMTP id 5b1f17b1804b1-4997c0f75e7mr70943805e9.2.1786551230039;
 Wed, 12 Aug 2026 09:13:50 -0700 (PDT)
Date: Wed, 12 Aug 2026 17:13:27 +0100
In-Reply-To: <20260812161340.2417322-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260812161340.2417322-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260812161340.2417322-6-vdonnefort@google.com>
Subject: [PATCH v5 05/18] tracing/simple_ring_buffer: Add support for
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
2.55.0.691.gc56d675ccc-goog

