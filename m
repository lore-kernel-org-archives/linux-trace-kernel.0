Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.71
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794492891;
	b=roFJuBBreYPF/+hfWhYIiIvGb20gOKanX1EdCeeUH1/xsk+75+G5w+XhnndU4Mjh2BU7
	 xOnohmDee/DNIfJmM7DOKnQhdEsmQSXyDCoeQMym73XLHU9lEZ9csCQ/udpA5vRsmwrDG
	 KqVRc7v5mhcKbs8pz5iGFmECskE9y1KubZn986VW2pVy81etOSmeBC57IJwSw4FykSPoQ
	 rKYozX+DvnVy8pdoV1wRVCYVaqHPydAdOmAb195+FQ4uqQ2iGkuM7gG6Hs4NkO0H8vMQf
	 nWP1k05nklh0hDndmx3Vaswz+bwBQp30BcWiv8xyyFmy/cdo53BleJPbjIMK4M3HHcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794492891;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=nUse+twsJnxew4r6zwWfOwbMG43DUEVmCdyLipFzEcQ=;
	b=BTOmEaBq8zMZF8urgQApfPg7Ahgc7ul0q5pEUg1A3Dy+He4snEocwYclZkBTCMhT56Mj
	 SePlGFgaAOo+X7d6nc+zXNq9B0IR/mn5SN8Fe+3fmFENYgaOvsEEp6TJ5C2KhX0w9sC3n
	 ncEj3yqzOhWcX5noNsjTfU6FI0LnVbOn9bNOYQLKbMEwFHfoNKI3iZ8BKVLO+VCiCepLD
	 wp0I9ouc9t6PjOn9M2UVShBEhVJ0FCZtKmhezLrtSH+uS8qvAombf0EMgzft9yufHjY2X
	 xAEMY4hfPmE+5nOX6+6ZOXJeDThvVYXy50+eo8nUUlcIqiPUuK3W+Gk9lOljdwP7cXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a9hYkTs5;
	arc=none smtp.remote-ip=209.85.221.71
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com [209.85.221.71])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DBC4606A323
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 14:14:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2DBC4606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=a9hYkTs5
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-4930269afdcso3526651f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 06:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1794492889; x=1795097689; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nUse+twsJnxew4r6zwWfOwbMG43DUEVmCdyLipFzEcQ=;
        b=a9hYkTs5Id401mmX/DwsMx1Ln1nZfkKQ2lK00AMAqT/GMbaGQ/Tn68UaHa2BSto9lB
         Tuhuk02Nwo8hi7mFjFvNax64TTdXr6HJp+4RSZAuzLnuJIaBeISRu+wdkOapRKWuYnDI
         4Ao8ZUPby2vVR+6Wr6sUr1nRaUkODWxKSPXUTctovN/8rOUI5+IA/qBRVpx9j+84TLj1
         g5Bkx12dIWKDwEleXyHPSbX52zxdgb+l1Np5+RiN+Qra7h0j9rL5vTGQ/ODzTEOYuvMm
         aU8kS7gv2O6Qx8pbdulb2Vft2f1Ye6hOJfAywqhWpzksTMBMhSQrDGnQp5u203MqUVS8
         kd1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794492889; x=1795097689;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nUse+twsJnxew4r6zwWfOwbMG43DUEVmCdyLipFzEcQ=;
        b=DkC+YaJtNnrPH/9jhM6TQCCLutU9oqQF6huAeQ9tpVbqwsLTMzDmFA00IN/mJcav+3
         55jULB+apIkuKfrZgQvocOPCADxQHlvvmRpfzHRoz8t2VS6tKRhWQja7ttd60hXklKqV
         /QuDKYFaz1OPhkwjf+1RK3cwzlbgmGhXEqN1PFGG+t913gQxOCGVJ+057e9K2/KeYQwM
         Wnpmejg6I5df2bjwx3Y9DHsQLkoo802xRTSWmkvAtIOmR6zCNVkS4dwikS9IZnuEkDng
         6aqMU9oaVuE4iGJONM/CSuBrTPN1MwnmsofMP/aMETJmTKqfKTp+yiP1pp2ebztv0pRc
         KzUA==
X-Forwarded-Encrypted: i=1; AL+hErGwAJcc9JzOda7kyUt67mvwSLvuTgTjV19rAPXWEOW4eRoH03xJ5VKqk5kesHNvbMsLlTIqInaVy8Tg9AyQW5UqbuU=@vger.kernel.org
X-Gm-Message-State: APuU4Z/8UmoGbXrA889A1tOfdqk0s8ZRcH7cIP59/x+N9p0Q8PTv1CbN
	r82PLgUe2UiJe7i9RK5orYzKMAypbRl/2/npr3a/PmxLZYYpmgngTCnOVPuIHJ0/IIvI2PcyhZi
	gAGhkaM6GXoFv1bM3mBAX8w==
X-Received: from wrvc14.prod.google.com ([2002:a5d:528e:0:b0:48e:5d2f:1d09])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6000:4818:b0:48e:6f76:de9d with SMTP id ffacd0b85a97d-499c6f8c3c2mr9735852f8f.46.1794492889329;
 Thu, 12 Nov 2026 06:14:49 -0800 (PST)
Date: Thu, 12 Nov 2026 14:14:31 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
Message-ID: <20261112141440.3050124-1-vdonnefort@google.com>
Subject: [PATCH v1 0/9] ring-buffer: Enable Clang context analysis
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

trace_buffer::subbuf_order has caused several recent resize races from
unguarded reads outside buffer->mutex. To prevent further regressions at
build time, enable Clang context analysis for the ring buffer and guard
subbuf_order with __guarded_by(&mutex).

  - Patches 1-3: Fix cpumask/hotplug races around buffer->buffers and
    trace_rb_cpu_prepare().
  - Patch 4: Fix a trace_marker resize race.
  - Patches 5-7: Remove subbuf_order reads from the write path.
  - Patches 8-9: Enable context analysis on ring_buffer.o and annotate
    subbuf_order with __guarded_by(&mutex).

Note: Patch 5 conflicts with the series removing absolute timestamps
[1], though both are independent on v7.4-rc1.

[1] https://lore.kernel.org/20261105202814.1350312-1-vdonnefort@google.com/

Vincent Donnefort (9):
  ring-buffer: Always read buffer->buffers after testing the cpumask
  ring-buffer: Drop cpus_read_lock() from ring_buffer_poll_remote()
  ring-buffer: Hold buffer->mutex in trace_rb_cpu_prepare()
  tracing: Cache ring_buffer_max_event_size() for trace_marker
  ring-buffer: Validate event length against rb_page_capacity()
  ring-buffer: Introduce rb_start_write() and rb_end_write()
  ring-buffer: Avoid reading buffer::subbuf_order on the write path
  ring-buffer: Enable context analysis
  ring-buffer: Annotate subbuf_order with __guarded_by(&mutex)

 kernel/trace/Makefile      |   2 +
 kernel/trace/ring_buffer.c | 350 ++++++++++++++++++++-----------------
 kernel/trace/trace.c       |   9 +-
 3 files changed, 193 insertions(+), 168 deletions(-)


base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
-- 
2.56.0.567.gdb80ae8cd5-goog

