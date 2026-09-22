Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com [209.85.208.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30173478E56
	for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 07:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790062197; cv=none; b=dV8llwiRkNy8aUv/ynHp1QE5aQ6R4gnPM6BOUXWGF52VGzdl3lH+qD3EsKANo+vCvFTklGOPu2+fPJBAynhQ7kU4rx2UOzEGr30RtoBAHvS8oQ6CUAojYs/LiL1BHcSchoeGmquHAylM1cIcMkvoB8mdRi+E6Jss9iGpeOBITbs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790062197; c=relaxed/simple;
	bh=wBmoW6SlI+DC5Zo7nszZiPh4qcmH88blCnLCKOLq9Ts=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=V8JyHh8bct4Rs2z8y1Jur6+QCXwYijk//Uf0t7BVmKarO352xX4in9eJ3j5YnspB7pCJzXTAe1hD3UtoJ14IzggBu2/ZXj9qkQOmu3NLzr9p32KbDI4YRjr2yT3jZSCbvVEobpEC4Ue8fLBKivTpN8WfcIq0wD3DXMxNvSofZN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=T27D6m2C; arc=none smtp.client-ip=209.85.208.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="T27D6m2C"
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6a98e5d6e49so5306184a12.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 00:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790062193; x=1790666993; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=O/74aIvxNYyyoJvw2o9e9799tBrQw2tGF0+8eTzGM4A=;
        b=T27D6m2CjyhSVbxHZbpuzRzT0ek/8rh9aFF2lyxmRcD8T4Kbep1V3crRDLbM/W7fJG
         MjpzHLyu1GEb0ulQfm1l00K59yIU2LpvdDyilHbTqLYKkIOMswnaSrlO181qVnRO2XR8
         UO9jhpvv1+BRwvuU/5vLIV8vdHIe//wS3oMh/k9q+eWUQEgREVkRFviBnKBZ9e9jfJRf
         yC6ho4d/FFHqvO7eAvTf9+57+b8q6nxd+uAhYSCbCvG5Ai9pJO/Fy1tcK7dY6GF90yu3
         piV2QZAF/diCHrOLXDxpJnGJ6F6kW/XcKUSniL3t+dCUq/ycRuMbyj5eycCtn8vCdmEg
         az8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790062193; x=1790666993;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=O/74aIvxNYyyoJvw2o9e9799tBrQw2tGF0+8eTzGM4A=;
        b=ic3CkCi+lJ+3V+3hSOf69O16/IGl/JdQjVsgEzY1zW9uNbXBgf89CD9HEzkYajsx2p
         bvzcI+U8t0FNpf0r/ugajKJC7gcZcKcpgFhEEh0wz3ZxzJIVB7fiu6vq73dzSGNyU6wg
         ZQpBxsGU1uw/qAJb2QxAo1KTHPFc0T9eBNI13QmsD0KKtDkiC6uuQratbpq5iVe8clcI
         MKWjO5/EcpbuhFUbWEVfhI/k+878pygRjymSmojUravwLsBDC0QAZFcXMcycjYNkG2H6
         i7rxE/tTux6EnwatHnyAHe8mQE2Y5yzq19d3jHLSYd+viJPaGLBJxk7VIQ3JF5KDGLjM
         D6PQ==
X-Forwarded-Encrypted: i=1; AKwUvBwx80dtUc1KgY00bFCd6298zRCPCJGHRDe72pDx1R/tNH8QsfZ4qv2A8u/wWbOLQoLrXKAoqSiXFbUMtuU3kX4Pevw=@vger.kernel.org
X-Gm-Message-State: AFuF++kXWMQhOhciwkm2ZE+MALzzNPjiZCL6BSulWFgSraQyzs/E6Q3b
	Z28jy0535zkcJeTtNkQovN2NFMohPGKAVw/K5zBUj7R0hLeIVwbFOyoongr0J9/k9UOR07Utxu6
	L7zD1SJC8HVONMOh2OyVhpQ==
X-Received: from edbay21.prod.google.com ([2002:a05:6402:2035:b0:6aa:8682:2b6a])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:20d5:20b0:6aa:734a:a095 with SMTP id 4fb4d7f45d1cf-6aa734aa1a0mr4992621a12.44.1790062193331;
 Tue, 22 Sep 2026 00:29:53 -0700 (PDT)
Date: Tue, 22 Sep 2026 08:29:40 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922072944.1281427-1-vdonnefort@google.com>
Subject: [PATCH 0/4] ring-buffer: Use kvmalloc variants for big allocations
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Several allocations in the ring buffer code scale with buffer capacity or
sub-buffer order and require high-order contiguous physical memory when
using plain kmalloc. Under memory fragmentation or with large buffers,
these allocations can fail unnecessarily.

This series converts those allocations to their kvmalloc equivalents.

Vincent Donnefort (4):
  ring-buffer: Use kvzalloc_objs for user mapping arrays
  ring-buffer: Use kvzalloc_objs for remote buffer subbuf_ids
  ring-buffer: Drop redundant ring_buffer_iter::event_size
  ring-buffer: Use kvmalloc for ring_buffer_iter::event

 kernel/trace/ring_buffer.c | 35 +++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)


base-commit: 93f51579e7df248780214094418f205253383cc5
-- 
2.55.0.1082.g2b9226bbc0-goog

