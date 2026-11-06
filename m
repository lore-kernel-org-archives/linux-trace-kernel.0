Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988472;
	b=nw24PHQXrKX7CDlqtc3IjNtmlOSolbR/qQ54SSGbitqR72Co4YaSLnw03tSB9DLWaodU
	 A/vN2DofCti4XPYIQbCNFF4nZarFPkbVERTtIBZCZc9EaPoyLqLoGyGPvUJU9MrEmPOVx
	 Ib9FzZdWUUYaStzApSFgCM/izufzV2GucciBtyI08MH+NQshn/QeYDMLeZ7K71GH1MMgR
	 pAO58VHnI7IlDTwPH75ZdCqXbXcCDaIX93HzFSG1mctmbNHCOwf1QwCq/tVLkeywtNWEF
	 8PLF6IjfwAFVEP+ts5+OoUho4bm+QDHxNo7ZIj5dnPGjLMxAVHrO8nISkQ68474Z4Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988472;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=EuW+q0IZAiSlccInoGG1ZV09yqmS19RZQDDu5PkfcPQ=;
	b=Tr9ZNSsWMJ6pF2N48yOxL37z5r/YIpWW31iI5epciq+n9Ye/bKRZnnO7yjHGj8A4Z5OO
	 dW/M/G4rxyTAoMceeZb4Dpa1t+MyBmVDDbDS3t9WNwoHbuVLbQE1jw98DjpJIVFPoer1P
	 kqaOpoGC9mUAvGKOxN7rlcW5O4X21L3ZCzgY7+55ZsutmEiaLJl5r2vJ/30KGCh5iyxAD
	 +rNCgzwb2TXQq54wTMNFq5czTbqdc6/K485Hn1gMXs29gzAfnvNAi1ADfjMTscsIXj3aS
	 03t2rqPVvajyjnQ/ATtEHW3eTBWk0rOToJEMvukm+ZOw2Oe9uAj5A7UVe9CHuWOPcZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UDP1eJ+K;
	arc=none smtp.remote-ip=209.85.128.70
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com [209.85.128.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9631A606A335
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9631A606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=UDP1eJ+K
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4a4af69e06fso6324795e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988471; x=1794593271; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EuW+q0IZAiSlccInoGG1ZV09yqmS19RZQDDu5PkfcPQ=;
        b=UDP1eJ+KhmpIr7wybsu1glvXvBSx2mNVvyKwqSxdJ1pyt9ekZkC8gMJBNmSylo2G2S
         DOzPfIB/+eF5LtkZEtGDFLyM17Zmuc6kTFk4RfCvPy4hGH8kd4SMOYdhVvgjRhEiqMs8
         knXo3ctfMDZEoe3BdQGK9P83EUaPVMqLdE/q84DYa9s/g6UT104ywYLkOBAOuiAiDj+o
         b3KrNM24i7d6F6eFyl3UjfNoL7s8zCPYxSOimlO3xjiPti3o2DpxD+O0MHuvHZUlU7TF
         wYD/HAH/NlgZvxhSaMmgwLVDkulTBwbq1VXxL3P1yUzCfvSBfwUm01c8qTywf05jAVZW
         3zRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988471; x=1794593271;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=EuW+q0IZAiSlccInoGG1ZV09yqmS19RZQDDu5PkfcPQ=;
        b=PuTbd/e+3TAfG1uz1kPnfveZ995UDmeTkghlVX322E0lsknyG4E2OlhF2GhHLp6GIp
         B0wr7uzwjrt9LlqeStzEy9GLBKjDwHPk3nN715cAn7VPeMIxxMjFvBXtn6OqZD1TClDI
         aKMEdB+vEUweR7CjwlyaDDhxZH5s1sck9nyqZ/GrZQwZ+Kyi2JTVMGW2g7C262QoU9Mi
         eOqaGsT+bhbktmKyly9C6KcDcjcfemmC5Tq7xxet7Ve9jCvtpx1rouXHqa1nJR5oLFzw
         Fzi+X2lvvlf9k/0nxtMIPtixwhCKbcj/f2dSKzBF5MUodQ0uuauU157LityTn4xr9ADa
         2nDA==
X-Forwarded-Encrypted: i=1; AKwUvByKoUN71WuKwqJxi2tFNMx4udpWGWq0cQwK3VJLs9Rd3Y1tCDmlWHJY9QQRHEK9sfM+Sw5d89yieas0jqvSGPpmmwk=@vger.kernel.org
X-Gm-Message-State: APuU4Z/9u44huRa+XdKdvk//4nwxmvxy0+5P0CVuyo2Dtu1ckGPmYLtz
	Vx/heX5gfSDbaboHFwQWyH49lO+izE0rYzfRNYxTruO+btnFlN+d5+i8Btxy9WTCkRmg11euIOp
	mNv4lEllgE/mbFGO79Z3LoA==
X-Received: from wmna17.prod.google.com ([2002:a05:600c:691:b0:4b2:3c81:ca])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:8b24:b0:49f:e701:51c8 with SMTP id 5b1f17b1804b1-4b6de4a766cmr59495905e9.9.1793988470935;
 Fri, 06 Nov 2026 10:07:50 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:43 +0000
In-Reply-To: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
References: <20261106180657.2460376-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.56.0.455.g6c5a503b38-goog
Message-ID: <20261106180657.2460376-8-vdonnefort@google.com>
Subject: [PATCH v8 07/21] tracing/simple_ring_buffer: Add support for
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
---
 kernel/trace/simple_ring_buffer.c | 23 ++++++++++++++++++-----
 1 file changed, 18 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/simple_ring_buffer.c b/kernel/trace/simple_ring_buffer.c
index abfaf9bee12e..a305331d29ba 100644
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
2.56.0.455.g6c5a503b38-goog

