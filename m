Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com [209.85.128.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46411495501
	for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 10:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784630189; cv=none; b=rDmXJ4PQAX2CyhnWUf/6klCSmO/+ozewMZ8VoB2BENfe9s8zHudq7vB/xXGcpu2N9451UPkWQHzZEwEzJ9saxUcuHD1g6L4q71pokRTQP1LXKyQ4Cg7MzLIRd5Vl92ocmpkEg0nJ0uJbYpvvz4zO1KEQ/vE7PxuE3y2H2eC2LRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784630189; c=relaxed/simple;
	bh=xagJPrNjZb/dtvneKYsayneayvvh3mTVXhGsitmL6E8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=id4OhNe4kNr/cusawd/cTB3ipEAVnXCobbmPTxVdEmGoexKi6eDH8iHx4nKdOxt5Wzvy+PJCAU+a+O7260eHaRcqC9qgmeLoALtpK10afNmm50uFHADTG0LwSI2PfQtzN5iY8J03CNtQoBYvIiHduwDHRSeW01FTxzQqDMIEJQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=uyPRwAGo; arc=none smtp.client-ip=209.85.128.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uyPRwAGo"
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-490a767b782so56950675e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 21 Jul 2026 03:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1784630186; x=1785234986; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QheANfSBdNUVDagm7Vlq2pzJ0Z4rDcimV3tD2EO/BfQ=;
        b=uyPRwAGoojwx3MsKjk/X46EiBHzB89s0VHjNY9lEUI5lzZVPo/Fu2gqSTcdO3Dlz3N
         zqAqi8U98CBVvZVMgY/Xqe3tcksKo1qcJpvmQLsh9meVPkCAIzawepC3C7rr6S0cnWYk
         e75BuVK+tDc/fVyxltOTa2KNqeZ7pJ0MEvkOBEP5lr0hG+7l+V1S2bVqm1mx0zi0Vm6g
         nlTLmfp1aqXxJi434xgqdzpcQgIxDEujVrwfcvTEIXpPi2NeJsUeLIfy+IBzUbVlR1ZM
         dmyK88t6/G7d1LbULp1nyOifzFBt9xl58QPNoXtBoeyA4fojKEFDaeJD9ojz+ve9zGya
         zH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784630186; x=1785234986;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QheANfSBdNUVDagm7Vlq2pzJ0Z4rDcimV3tD2EO/BfQ=;
        b=Ff3z7CubtBm9Ib3s1YSdLC3WTiv8O7vDfVRVrk6lUGh0aSibrAa8CNYWH1Nd5vDEmp
         rKhDEK7hZJ6yAs/j9Y3qPvVKcp8VKygXNTdQ8vllFGVb0/BZm1Aa7asO/HkAmsDB0Hzd
         t7jap3df9hvk0YuMsum4SEB5vG70qjyZ4trWqmjvnQbwT07I/uxS02Gh++aVaPSd3wL/
         3aQMFtk3daODIxews9K7C8Nlq703gTmeHFoSfy/E2FMafB6fjI8dQn0k4/3pGotmopJS
         DEAu+Vgkw66FkcAuN50roWGPzVn263M4G1jDJ/TMFuYb5yTQr+muwXGCPNktUcXASZqA
         SvzA==
X-Forwarded-Encrypted: i=1; AHgh+RpIlp0CKmovz7iwguXJrc5kregnJ1HvCRuGgxtWX6wpnyp90AA0dvDIl5ax6Jj4N6lQ0umpvEkUDFp5n1SrBUv4tJ4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx3Jicudga3l05aW3SJP7oSazpfHSHep3NCNNM/hVe5sC+AlzqU
	9Oq6bBqU2iOfbISK9rREBYZmQWAdgV+EDm283UcDM/+SL3xuEsC7rdM67ruXOHEsMq/DOwgamme
	mGnvo06biWnRJVd06WgbbgA==
X-Received: from wmok17.prod.google.com ([2002:a05:600c:4791:b0:493:f7d7:4b2d])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:4ed2:b0:495:5fdf:2075 with SMTP id 5b1f17b1804b1-4955fee6628mr79568325e9.0.1784630186151;
 Tue, 21 Jul 2026 03:36:26 -0700 (PDT)
Date: Tue, 21 Jul 2026 11:35:50 +0100
In-Reply-To: <20260721103603.342266-1-vdonnefort@google.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260721103603.342266-1-vdonnefort@google.com>
X-Mailer: git-send-email 2.55.0.229.g6434b31f56-goog
Message-ID: <20260721103603.342266-6-vdonnefort@google.com>
Subject: [PATCH v3 05/18] tracing/simple_ring_buffer: Add support for
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
2.55.0.229.g6434b31f56-goog

