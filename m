Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73B0242847B
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 11:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786448909; cv=none; b=u4hf14NuGmLnoy/ZFxY5KVoth6mpgTLF98jTasWcIMJKJQO0DRHChC3LEQ5vEoeSdgRNL8Lc5jUE6JAUSOgSEgMOF0/qX6K/7Fj9MabyJCmnI8R0/h7e39CegJmkIo99dYeDmzQFk/KxKlLvvktKN7seVZyVtp8eWV+AFq6x8yw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786448909; c=relaxed/simple;
	bh=Wwpp2QBKxO80rQdmYtZq04G1A4n+7GSNMaf/gwqK3Vo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uu+iSfTwMe0rgQveI0uSuRZXdNFwkWCIGy3iOd5PEP3Z5KmZwvHcrR2SKeTv3volEt3g81R1QBl1/iJnTF4ArENwOIitAsC2mb7akPaFbPDFTJrrFEfybFhMd4aMeUBzjFFfFw2gdQG+Lk0zzDtAWDe/THmMz63oLYqpVzDDBbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F+0pyluA; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F+0pyluA"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-38deea72eebso2914787a91.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Aug 2026 04:48:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786448908; x=1787053708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Ss9z8frgXLbOyoae93z63ypP8jpNcSWpfGevNSq30Jc=;
        b=F+0pyluAyOvkVvCe0yyfUdAlOLfQTNSaptWat57t1ukwDFkMsiQICMbUaJ3XIB54ty
         2BuJ4hlj0kRl8MjTcv+xnd1AwTkywTFS7KfYS+/xIzmFpnK9zKM0VRlY+mIEu2ERKGEL
         8PCdKrxSY1jtifGlq8gsLcdRK+a5X/W5SgrRu6WDKnw5fbXH3xnT8Y7AcOeATfnsbniy
         BJ4XkpRZXM5HuedDkywBbHdgvG513yu7Au1GDkMDlsfIW9kzSkFqWv18EWmfactbIjzk
         TJfGISZblwINaTVsO4a0B7WqxTrKJUjYzM1Fm87A2ugOQJ5wFgvRstVBSg+mNAPnaEPN
         WP8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786448908; x=1787053708;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Ss9z8frgXLbOyoae93z63ypP8jpNcSWpfGevNSq30Jc=;
        b=FPcHinxcl5Acsgvru5xF9jX3MN3lEV6RjjOJGSReHjww5I+WYzlqRYkd38NrzrLyBB
         d/lI/5rU4GJ3efbNRgUr4tX72btjfMdw3RAejJPcYGqw6sZEZyYksvYb6/YCLcPJgBpi
         gC9xOShJ+g36y+slNEAv8IUjxCjls9Xx/qTX53PNnhlSejlu9ohrtyPlxdrOaVr9cUep
         oHoXr4y5aFRv1s/bF9VH/lN0dUkoNAefw3nm3uQaLf7OPWKxMZ2kcEfUxjXow32fWlTF
         +76t9QfFcslkGbtJV1xzuGL9U2/bSEp3NSsVzg/aUIOxnEUBhNkj5dwwt0vK3nnjwAMn
         fllw==
X-Forwarded-Encrypted: i=1; AHgh+RrrMIJWyc1gVDdQyXFRQ3ZIpc3tZ+kdvWNr6PnveXrQtWm2OCRgovThvJIQ3QfEEKMAJ5gg9NahDIQ8vH9+M9wzslY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4LlA15ZMNBXRRcCoWj8GvumQ4KseQKdMHAOLjoUOAjOgr02CT
	Z7VWWTvYZsyZomiBmxO7+e+XevJu9cWjfFXsfjiOLACa/UzwJvIXxaTd
X-Gm-Gg: AR+sD10SvGxhsgXQZH/+kT/X/ZGaR4AqMcF0f9hGkGZ+thnIASqd59dE2s8eKd8jHpX
	o5iqfXxYoQCdJgR4Om4e1N8Kt/jc1gLd9Ht2Ig+TRrm8uB/R0IH2gYDS33nF//P0jVw0v3Oda9B
	BVFQHe2O7MYhnva3157hH7kFVd9PNhyh524RjNL1ya6xmT2Cde6qKKLmdFAWqddKkhASOX2D7e9
	qTpGuyDoy2A3hrUs+4fm1+tEnd5Ia01mPhBKl90uBuYo+Oe+zxXK4DF2ZdbxNeNOv8qbIhMNFQv
	ebRLFejgGE1Is65HEVzsMYxmD5KQG5VfOj8ZMd6osBeRMqvkR1wOzcghhvJrYEgqmIPQZRZwZ5h
	QdqiveKCLthGTN96F5T344UHGqAj+IbIu+pdkXn8ijenI0bouEM/liWT++8sDzpwCOkbFU+h6zN
	OOfPYDtWQBtX8HzImsBGOoo2gRFVHf9LtsM048PlkFL1ArR9VNs4iQr4VequFbXD567oicU4t5E
	x25frehm+XH0Qi/FSs2fDJGSEJm
X-Received: by 2002:a17:90b:4c4b:b0:38e:659b:f366 with SMTP id 98e67ed59e1d1-392ec0efc61mr2838777a91.0.1786448907678;
        Tue, 11 Aug 2026 04:48:27 -0700 (PDT)
Received: from bj-kjy-standalone-gaoxiang17.mioffice.cn ([43.224.245.230])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-392ee1e369esm1850103a91.2.2026.08.11.04.48.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 04:48:27 -0700 (PDT)
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
	linux-mm@kvack.org,
	Xiang Gao <gaoxiang17@xiaomi.com>
Subject: [RFC] tracing: aggregate ring-buffer usage statistics
Date: Tue, 11 Aug 2026 19:48:18 +0800
Message-Id: <20260811114818.1449933-1-gaoxiang17@xiaomi.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I would like to clarify the motivation for a tracing-specific memory
usage interface.

The original requirement comes from Android lost-RAM attribution.
Ftrace ring-buffer data pages are not represented as a separate memory
category, so userspace memory diagnostics may treat them as lost RAM.

The memory can be spread across the global trace array, dynamically
created tracing instances, and snapshot buffers. Userspace can read
buffer_total_size_kb for the global trace array and each instance, but
it has to discover and sum all instances, and snapshot buffer capacity
is not exposed through the same per-instance total.

On one Android device, the global buffer and 24 tracing instances
accounted for 395,664 kB of ring-buffer data capacity. This makes the
missing attribution significant for low-memory diagnostics.

The core requirement is a stable tracing-specific interface that allows
userspace to obtain the aggregate tracing buffer usage without walking
all instances. It does not need to be part of /proc/meminfo or
show_mem().

One possible interface would be under:

  /sys/kernel/tracing/trace_stats/

It could provide an aggregate buffer value together with a breakdown
for main and snapshot buffers. Per-CPU statistics could also be added
if useful.

Thanks,
Xiang
