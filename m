Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793887353;
	b=TjDuAAKm4dFIRHv1FDeTkFRV6nPlX7AJF37zbryiCHZONIAzZy6WKImdbmW9c+P9We9w
	 T5cbW/7R7ueT9Vjn/nG/NolG1TtPmeYOVs3syxzjHM3bDztc8eesBEcsnHDaEr/Qwlnii
	 +69HoWEsVvapjN6alVIeQQaZEl+Kazn5TZE1WNVqSOQN//xsLymAn5/jqiezcT1LZJYQt
	 wLZgd4zCwwbW2OLCz1OTgtISlspHQAS7cIyUulpHfkUQx7sFvE4oYaIKg+Lo2cwd5NP0x
	 zZLgVY5md7gHnCltuWU9Kh6x/c/jEdPtd2vTV8AYQdzKk/yzspqOhLMetzTJXrY1JFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793887353;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:X-Google-Original-From:To:Cc:Subject:Date:Message-Id:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CsA47jlziSnaFpmvT7xQoqdEKB3PsFd0BRY4qsHG+7I=;
	b=ePNIio6EJfcey0SN1hJrtrbym8oc715Ty8/JjSZoQD7utmzXjew5/pNDKmsUvy9L2/Ef
	 9hgs+ycyNxUiGM9jM2oK5cRj2VgnjnNHx/hs9CQ/A4AYS4ls0Hyj2D8szc0j3kR6ToGnO
	 aLRPzMRTJ83Oovi4H9Kng+VO/e6dtr6vTF0ecMImw2cmii+e9xxGArNV9ZSRTBOlD5n/v
	 SquVwcQd6RZO5XZ/TC/InUCSlVACk+pSH+4U+q332Lny2xUVgCp6J8zRxWohXKRodRyjB
	 ktfsoy0T504KFSjFtMr8Rs6S0jXU8bbifpzgmAzlu62UojyEkIkOzYGhxP2R+OuU0Fw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H6mgw6v5;
	arc=none smtp.remote-ip=74.125.82.178
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com [74.125.82.178])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9F18606A328
	for <linux-trace-kernel@vger.kernel.org>; Thu,  5 Nov 2026 14:02:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D9F18606A328
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=H6mgw6v5
Received: by mail-dy1-f178.google.com with SMTP id 5a478bee46e88-36661f953e4so2640948eec.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 05 Nov 2026 06:02:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793887352; x=1794492152; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CsA47jlziSnaFpmvT7xQoqdEKB3PsFd0BRY4qsHG+7I=;
        b=H6mgw6v5CH/UL6jnl0LH+IpMHbKEAIG99n5A0BuqDhF/ASRwZ2uvQJYncSiGOC+fIA
         /RBcbRsOTGK+L2ZceiuKoNNkIKqW1fj3itD5dWiXLVyyMNB13+54eUaMrdA8GDvVTYm1
         AfYXMEQs4gG8aRha0p/7CBA+yRlqgXlyB0ESkwYOjmf6SJA1uhdYUeLUXQjFxXjsrvra
         nnCDNZYifiQPD0dNVXR6FxLh/axGxqc6irQzaog9+nJf8V3S7lfaLEJ52/UgxVHIHnVs
         bi6UWwkXFcIpt9szZjlpSC6nmH7P2EeLN7nmvgMo7QVGWvaGTmY9cgu8SWx7D1lCeCLr
         wxuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793887352; x=1794492152;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CsA47jlziSnaFpmvT7xQoqdEKB3PsFd0BRY4qsHG+7I=;
        b=nHrCMQPcm60XivndfA95FIdGfkSVh9N8CohOZFXJdZp0rztlln9k9oa19r7LRjrRhI
         J+pTz5sAfaB9cXTqiUjiCcTwlcQN1zMEaq4Yc8a1h8DxnieijLrcy4/TL2OgxTcjMCbt
         zKLC/o8koKchYUlzbMDOHct3/ZHylbIgoM5nHTEA90JXUErn6nBuhOLuu703H6Dp4VHb
         L1d5k0OXnjKIP6TwSLWbfXO4giHhDQwGkbB8l1FW8kcpK1mzQ0BnlNpiOrwISHSSuGeL
         VrZ111tPrCO3CSREM2nylKH7ft49kiRk4mCsRZdmxWNE5sMEq0AptAh6yh/x2ZB5sFmN
         /v1g==
X-Forwarded-Encrypted: i=1; AKwUvBxJRbI84oG/gs/U7hthMTZUxKsPHw2c/+GVq0fhAAJ6VNe0jwDKVJuu437dVnnvPK+L1BRapzI7zXI3JRm122oGyDo=@vger.kernel.org
X-Gm-Message-State: APuU4Z8bLLXFsOX80dgvbjTChWG+Bv7uX1b8RzodznYELLvjXCKl7L15
	UA0K7FXrb670c2LoboQbNKrcRBKmJyFdNsysVcuHGlXcZ+Ua2lxrhHwU
X-Gm-Gg: AYBFou1YkdZGgcgrDYp1df9fDX1BY4CNOyMzIwv9YW61w6jgpPbrQYXJamOO5VKNFrW
	3tNwHOjdV14wWl/O6EA16MVnK+DwS4q5BWeqCzf5FM6MdC7VaDs3/v7btBxtkH5Cu+SRmmnGI2a
	T9IObFp5L/Nfd2NknqxMwSNux2G0GwR5+kd53UldHA6Q39AFZPYXy8WXNAGEw+kDzNa888BXu4h
	CHPMSeFvRsyznYqrrdG5drTAYWvbjgF7tdQbiH0dc5+/gosXWaOmTiXIN0bsNAsZqL9upHYHjm3
	gaOXb6ziuWaa0lB/1O96EGmkOQAecWRiaAN7qeFjXwFR/OWV/tcqKXkDFleJpfMSakcqlw8SU1J
	zFNvd0pe+M39kiWfDeiAgwhOuDKShEmuSW8Tl8GLxjfRbT2COjZQ1Dmfr0taLZWQuSTZBqk16Qm
	FG7d9A4OCpY5rmtivSKR3VAXogIIWsBhbaixlwsMmKrL7vcGYzYevXyxSUFMTWkz2kHmqjtF/0I
	scuhDCMAXOj28z+T8E8EKWm9pUpmapZSiIsheWEKwOONP52uoVUVaGgrz71z/jotO7aLGZc55bX
	vSCDcm2PfsUQA/HfPAuWx92p155zTgWqX4s5loA6QyhWRAE6dBDlv3YmKuEt32yI3FsWoA==
X-Received: by 2002:a05:7300:cc93:b0:36d:7ec1:f38a with SMTP id 5a478bee46e88-36d7ec1fc14mr4539748eec.8.1793887351058;
        Thu, 05 Nov 2026 06:02:31 -0800 (PST)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm20969616eec.24.2026.11.05.06.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Nov 2026 06:02:29 -0800 (PST)
From: Xiang Gao <gxxa03070307@gmail.com>
X-Google-Original-From: Xiang Gao <gaoxiang17@xiaomi.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Donggeun Yoo <donggeunyoo.kernel@gmail.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lorenzo Stoakes <ljs@kernel.org>,
	gao xu <gaoxu2@honor.com>,
	yinchuang1@xiaomi.com,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [PATCH v5 0/4] tracing: add ring-buffer memory usage statistics
Date: Thu,  5 Nov 2026 22:02:17 +0800
Message-Id: <20261105140221.44614-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
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

This series adds:

  /sys/kernel/tracing/trace_stats/memory_usage_kb

reporting:

  global:
  instances:
  snapshots:
  persistents:
  remotes:
  total_system:
  total_carveout:

global, instances, and snapshots come from the page allocator.
persistents use reserved memory. remotes are not yet reported and are
always zero. total_system is the page-allocator memory, while
total_carveout is reserved memory that was never in the free pool. A
per-CPU view is provided under trace_stats/per_cpu/cpuN/.

The memory source is split into system and carveout only for now. A
finer-grained attribute (host/guest/reserved/device) can be added when
remotes are enumerated, since guest and device memory do not exist in
the current accounting.

Changes since v4:
- Categorize the report by buffer type and memory source.
- Make ring_buffer_memory_size() generic so it returns a size for any
  buffer type instead of zero for remote buffers.
- Skip the backup instance, whose vmalloc memory is already accounted in
  VmallocUsed.
- Rebase on v7.4-rc1.
- Split the documentation into its own patch.

Xiang Gao (4):
  ring-buffer: add ring_buffer_memory_size()
  tracing: add aggregate buffer memory usage statistics
  tracing: add per-CPU buffer memory usage statistics
  Documentation: document trace_stats memory_usage_kb

 Documentation/trace/ftrace.rst |  22 ++++
 include/linux/ring_buffer.h    |   1 +
 kernel/trace/ring_buffer.c     |  37 +++++++
 kernel/trace/trace.c           | 188 +++++++++++++++++++++++++++++++++
 4 files changed, 248 insertions(+)

-- 
2.34.1

