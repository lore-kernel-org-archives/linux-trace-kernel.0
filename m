Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE213357D0C
	for <linux-trace-kernel@vger.kernel.org>; Sat,  5 Sep 2026 11:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788607662; cv=none; b=pOAlukKO94JNEBW+legB69EOYaFIxTQhQEZuZDrq9efiHCIZ4NOwXkzbZRmW7hIWWixEr0XfsiTE0wXGAGbVWv/9XE+p5JdJ6RmkhoIhtHyYMXbs9PcuYrdJ2LG5RF6ULs5LCjwME0ZEtyORBztL5Jgyz3h+O35bx64r4QU4WCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788607662; c=relaxed/simple;
	bh=jOzaDBdr3/sMQdwWlV4kXUeidf5trkBy2USmz3olBYc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e6oerH1jXxQUTlw8hQYEC2Gk5rG6jH/GGXzR8Db3jMOQmoyf4RfxngAXiIaVwVL8GZnEmLhuSUjh5NILJ1b5EMkfDh9CJH50mVsuyVjGLktliFS1mc605N9DV20DGvie16h+DPtjVyQg8RsAnnamDJjHeRttvcKYNK3YzyhhLcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k66+LEjk; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k66+LEjk"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cc1c3c90074so1567201a12.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 05 Sep 2026 04:27:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788607660; x=1789212460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dEEm0xFIfPlvXoOjOJ7kdvGq8eNWj1xsAyDh5PO56Ao=;
        b=k66+LEjkiOmKQJdLd4OrUV9YqG/cfAMahAMGUeDe50MG9XxORFZe9HXk0kNJlz+IGu
         d4eRRZuKDSCt0u6YW1XN3gHiJSVIgOOjd/6KfjqHF02i+do4QPkoltcF67Y1S3DysEXH
         8yOoKJdq7wsSd7w3Tx/jNPER/Lh20COZUyNXKcXht2CWzVvtkTETn3a0Z/hGOVI8nUfe
         vZz5TBOKcdjL6+234fIWru3sbG47w5ABJscXIyf3rgncZZbFAJ1FWpv/l2+aBpq2XkSn
         48y4Vmbm69Aa6wtPe9owAE5837DgV941N/t2rafonKU5bAQpH51C8Vi13Ki+9mozlLWS
         rAlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788607660; x=1789212460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dEEm0xFIfPlvXoOjOJ7kdvGq8eNWj1xsAyDh5PO56Ao=;
        b=aCxbca2LPAYFQ1W/iqDnJzzFExG4yBDyVxWZVz7jmA/6n3F+2AOuGnd45UlBrYrDCf
         qoIruaVrpdh6TaRd1B+P7FG1PIC2XqWQkw0int8X1Vig4mKMgi1XW/4l9S3JUUGeATC4
         YVm6whL6sCJhfC/vTX6j5Tq4LI4hygXqjHqpfCKrD6uul/5MZeFWrWkcaWq05I6EDfHp
         QCbLTq1Gfcc2gHnX5gHTo4TnsHQdb1fWy4lshs8QOdOdryzP5slcp50AizuMgMqzZVKY
         TraZBzGXG1j+b+uqzcb/bmLbNEEHqtguTWof3wg/xr1egZhQ3eRUIuXiZLY9ul05e2YK
         SeWw==
X-Forwarded-Encrypted: i=1; AKwUvBz+zm3GGS36RbOcP+0AtPfG5FbMWyw+ZmlwDoJlcXQCXVyY5sOSNrZSPzY9ubWnYXKq7GsgUyfTX9abi6I568dXRcU=@vger.kernel.org
X-Gm-Message-State: AFuF++nsCVMjlJ6VLAzbl52Jkw/rxPPVrmkKYE79r9uTJ/bQLGL4i9lt
	6yi20t+OOFGQ1RC39LxyhPpqDcNHmZ/wWFG14X3D1QtOcJ98Hx4evP62
X-Gm-Gg: AYBFou34kPgro6GMfnf2HuWEEnDzeGOkl1ZDAlh4N0ZwDPBH8F9afOwir9n6Tu2jZAg
	sQRdrL0DV1ZAUs/nFppU4UBJUaP4AJCKB3XZ5T1fekiq0PqI+bPXFZB4IsnBFj2ckXzrvfzqnry
	8sJSirkViBndr3YUZITEvDf/V6iUu3Iv99An6+PeukNHAgPJmkKwF11af9P46k6jndkaPWlm7gP
	QCwNNBLo4O3kSB+IQysYx2Juqhb5+dD8NNaQ7wWDdu3GA8phNxvwqvi9VME6aNWBxzcmFukl7JW
	yYo8atGIDVErMm2TPIFXqbx03YpnibQ331vV4DcDf/1jEMdCMpdBD2metwELeUzzrNi4usmptpa
	6dJRdra9MowFC2/oZKb2AVIxxonLwA9XFYBPEAdQIPCLlOHsC+DyEXsbtlEgotY1sd129Y6yAMQ
	0Ny/uS1IXzbmvcYxaEruli6es4qs/U/Go+/xyE8/uUdrmU3Hptkr8XVk1CojUVPEem9xb5z/qRt
	Okr17GlrcGa3YRXwzsMU4ud5JOe
X-Received: by 2002:a05:6a00:174b:b0:842:2419:6bfe with SMTP id d2e1a72fcca58-86169578d15mr14988830b3a.7.1788607660096;
        Sat, 05 Sep 2026 04:27:40 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86152e39a38sm2228779b3a.39.2026.09.05.04.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 04:27:39 -0700 (PDT)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH 0/2] tracing: add ring-buffer memory usage statistics
Date: Sat,  5 Sep 2026 19:27:30 +0800
Message-Id: <20260905112732.3705405-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Report the memory consumed by the tracing ring buffers, rather than the
usable data capacity exposed by buffer_size_kb. Android low-memory
diagnostics need this to attribute the memory used by tracing when
calculating lost RAM.

The buffers can be spread across the global trace array, dynamically
created instances, and snapshot buffers. Userspace currently has to
discover and sum every instance, and snapshot memory is not exposed by
the per-instance totals.

Patch 1 adds:

  /sys/kernel/tracing/trace_stats/memory_usage_kb

reporting:

  buffers: ...
  snapshot_buffers: ...

covering the global trace array and all instances across all CPUs.

Patch 2 adds the per-CPU view under
trace_stats/per_cpu/cpuN/memory_usage_kb.

The values account for the full pages backing the data sub-buffers and
reader page, plus the cached read page and mmap metadata page when
present. Slab-allocated ring-buffer metadata is not included.

Xiang Gao (2):
  tracing: add ring-buffer memory usage statistics in tracefs
  tracing: add per-CPU memory usage statistics in tracefs

 Documentation/trace/ftrace.rst |  15 +++++
 include/linux/ring_buffer.h    |   1 +
 kernel/trace/ring_buffer.c     |  41 +++++++++++++
 kernel/trace/trace.c           | 104 +++++++++++++++++++++++++++++++++
 4 files changed, 161 insertions(+)

-- 
2.34.1

