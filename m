Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792420;
	b=dc8eaXmBg0rKWe+yMqlf59D2VXHix4j9ZBhCE7CFbH1+z1haDFCG/IK04LfiY33GfdGb
	 UYlrjcYBU4qpu71lVb4wPpTojxdjPQ+0d03EkRPklia5oXEs9ZV9tVIjBk4kiqVqsVEYR
	 5HZ26a4DY+dfiS5hxLs8dRb14SAhPIZ3IAialjA2fhxXbbI9PwLOu2lIVRSBMS+2VkUNA
	 XxH45ogs1Om8xiBdzjm1e/OlYksvKFsFPQ2Bu8sK6JX0GWPID/OzOJ1hNjNTLV6NfrU68
	 P9TXP/Z9pzddqENh16HcUbx9DwX+CHI/a7NXhBC3bhRk4cGpbocaRTkAK1TsdxDt3pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792420;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=R4ZdZ/Z/X95qaVtYQz57sFrlKFBZaBVJXWXtnEfxeZw=;
	b=ARww5ZBpp/TbcE3xAdE62W4kn/5GP1wZApIJRbjizwLizUXOLW651i+EBzGxpZa4QA4/
	 e7N1NARSp2JSnsUhqSltuwf/u05eSeorMpcUdm9SFOg65aZamaLJkmmRLf7QTN1xnvrvW
	 GRvLxAIndOVYohdyi6maPXLjSvJnunqaLDsN9IByASYuYUdweAKC+Z1RzSQQjpCFWE1nk
	 O++ARXuxnee0TI9B4GEbGcQrPB11OW0mGaiWbgd7+VObid9APjhFpk3mM0vqMQz/b/+O0
	 WhZK7Do91OdrGqTccoAfiIpEEksIvgxHCoyre1jaAwVww+9lPvE/YBq90zsTojdBq5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i78wvBAv;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE742606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:13:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE742606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=i78wvBAv
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4a7c864000eso4875160f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 07:13:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795792418; x=1796397218; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=R4ZdZ/Z/X95qaVtYQz57sFrlKFBZaBVJXWXtnEfxeZw=;
        b=i78wvBAvohyU2L3IaLOUfhATWQKDRKARv9EAS2PPUpzfz7y3PK8Obs2ufTxRvqCVF7
         IUC7PkHbaobjUqzf1T8l2yA/sXGEdEA5Io/ruAXE7otzzU+4uqpsQH+VcEE7sZdogq8a
         4X6MKTxRGMEBNEqVxfgwJNr6RUizh3Co2oOZTvE7dXgadGM2nBTER50M7S6ahufdymkO
         tHT4i+n7GcnXGIBJ1R5I0C+DVL9u7zV5qO9VLAnIFlYCS780gQjPIaZlXSBEBo1jb43E
         nnEwlab7lW3QtYqfFjup8praiFYJWKg3iAHrPbzRnOAyvNVrI6iTa7z8mkCwhAkbVt+R
         U+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795792418; x=1796397218;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=R4ZdZ/Z/X95qaVtYQz57sFrlKFBZaBVJXWXtnEfxeZw=;
        b=IhxK2vRllc7NbPxk/YSkp2mSp75doc43pcVi8iai4+B2sv5Dq3AVoWN2l68PZblf2k
         27jMeKf888wQbI4mHNYNeP0klkmnbV4pudd8ZbND10biNlLAblMET4y/IxJAnqp+91i8
         rxalReUe82WIl+qQzPMx7Qq4TEXomJS5fkL2PNNPmxUfBPBIazhPQ4ckTcfoWCokU6a8
         aGWqavoXkmR1YjuQWdk+S03GErzeOzKD3sNUarZH9SNvI+OS5LWM+ZXL2U5PptcYenvc
         3qObvkjp1rVX3V0YVn3ZQmwAVG8fXWgjevAP+/Qfa4p09T0KBdpFcTEyMf9G6ZUu4tyB
         JeGA==
X-Forwarded-Encrypted: i=1; AL+hErG9ZznjBHqnYwj6HigCMt1b3IHR1pbL64gJzfP3tWl0ozo63XvSHo4WC6i6SJDbG9Eo/qhvzo5W04339yDJIaKgQls=@vger.kernel.org
X-Gm-Message-State: APuU4Z8MDeMZEZzeqLkNojXmU+7AtI6w1b41GMUHwiaHfZzJnIeGRYhR
	nV7r4HzchJFBT3se2Q5USEdo7hNLBR7zNw2KI9NxNaCRHl53kVdzP2cQdaG98I/b0GkfsIYvvmE
	VB1khF9yqqVHlUsHyHpUodQ==
X-Received: from wrpq17.prod.google.com ([2002:adf:f791:0:b0:4a4:35d8:cd7b])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4809:b0:4aa:842f:5f78 with SMTP id ffacd0b85a97d-4abb759e947mr46727558f8f.46.1795792417605;
 Fri, 27 Nov 2026 07:13:37 -0800 (PST)
Date: Fri, 27 Nov 2026 15:13:22 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
Message-ID: <20261127151326.515232-1-vdonnefort@google.com>
Subject: [PATCH v2 0/3] ring-buffer: Use kvmalloc variants for big allocations
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Several allocations in the ring buffer code scale with buffer capacity
or sub-buffer order and require high-order contiguous physical memory
when using plain kmalloc. Under memory fragmentation or with large
buffers, these allocations can fail unnecessarily.

This series converts those allocations to their kvmalloc equivalents.

Changelog:

v2:
  * Drop "ring-buffer: Drop redundant ring_buffer_iter::event_size". (Steven)
  * Rebase on 7.4-rc4.

v1 (https://lore.kernel.org/all/20260922072944.1281427-1-vdonnefort@google.com/)

Vincent Donnefort (3):
  ring-buffer: Use kvzalloc_objs for user mapping arrays
  ring-buffer: Use kvzalloc_objs for remote buffer subbuf_ids
  ring-buffer: Use kvmalloc for ring_buffer_iter::event

 kernel/trace/ring_buffer.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1.839.g22a8290db9-goog

