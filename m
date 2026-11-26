Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795729072;
	b=Ewzf72LNjP7io/vh0ftGIQSRiKg/Lx2vnUJkGy9kUGTdEeusZ60bPhZ4+rbwRnAZPcqG
	 KSG/9Dm+2kX4hk4ykGsCF/ln1Q8gtytPI93WKiHJXbVRtZdgqYiZVpiLWQI0mt/3NZntv
	 odExci3at67dgtmWlWgLWrSx/fqxDmtc6dDdnjFH949RAUomPsTVsfwL2o733Kd6jrfWv
	 jgT9FQej1h5HBaIjuWPgnkSKlObiBSq2COU5t592FCVvJC7RSB2PMmn6QwHqB+o5gMm2O
	 rwdBIFFUuOeUntX59sTqyffZtm39ffWbiv5JPgw0yCaBkX3ZZmtFo52jA2JAh/A8wIQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795729072;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:Mime-Version:
	 X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	bh=+mFlV1Y/d18LL9hJ2/iQPBUptGZF6KZfpVM7ZDgF2QM=;
	b=qhRkymICIj4aNDhxtCmMr735NN+5s3BNgfa6eIvFVyyk1pXOEew/iDCQjEXbZ6Wmu0RN
	 kh7scB4Cik9GHdsTNDJGWKSYT3yJlqHglGwz84RBn9d0UvGo9L/p/4LFhBiGbwHB/JyO8
	 lClWPSc0oel2t/m9doSJkn6oNqmYPDw7NKHpgH2IgB53AEmpT4CpzCVJcOO+0QIVFn1jO
	 5r+czHUiJQagVUs5Ln5N1IJiccHrJHGzDO1EFz0vZxF9WAxQIrRcsPNhCN6d0f3fOWYs3
	 2ce/BNV0JeNYC5LhPx36pznIJAJcw4lKcZjF0ASWtyZzJvfeHQpILq6HmMpvTIbC0ig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eX0cfqBM;
	arc=none smtp.remote-ip=209.85.221.70
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com [209.85.221.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED0F1606A32C
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 21:37:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED0F1606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=eX0cfqBM
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4b9f361d9b8so1443836f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 13:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1795729069; x=1796333869; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+mFlV1Y/d18LL9hJ2/iQPBUptGZF6KZfpVM7ZDgF2QM=;
        b=eX0cfqBMsqkjTdAZKa26yO8ixE52LhB94CBDyUa8d9rxejQ/65p00cva/9T98VenN7
         sYwwtl9hqLhOyLjfuHjjAX/cdXD7Q+nlu/d5dq187nNAJhB1HbQO/ZVJOJkec5m3434p
         ZCRDW8OBfGSd+1JEGki3VSqNRc5tDfOd7mq1oJCZkDJNn8N319qBR9zGX0/Je5HHmYQB
         Q8kWLs4+C5xZvyA898bccsqQ2ULta1jzBx0PvWf19oHpfUpfCEqxfOaXGKX/fhEqlMpr
         GG6EuvuPh0rKf8pbjdrCJkaK/lJ1Bu6WehHR274j4m7Ti4IW+tfPSApopXSwaUv6n7QT
         FtWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795729069; x=1796333869;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+mFlV1Y/d18LL9hJ2/iQPBUptGZF6KZfpVM7ZDgF2QM=;
        b=AQ4oitDIzbGZyqARwX9hBiwP/nWwWRkZAzxCZ4v2PTO54E/cMmLyFky2qqatlVQbbg
         Y8sRqcTOmJKmZUgFlzOrwFA6/OEJNbL6NNI6b4dvDZHMVZrxveE6qjXSNG6CfGmtnobm
         Jo72hbdj+gnipfBYuagHdpVADtEulJpB561vRkcH3CxnJPpnF3RmxjaXA9qvxxsrgVWd
         M8QJf9lRLZMh5nqnDoSHnGDHqlfuKbBGD3N00FokyplDE6TWTnlwwzlCw14tZuo7/2X3
         d6+Vg1WLkOWfd2TxaViPvqV0aBCGa1sLOn9NsZIy1dagh4Xi0Q3EaHhaJIL4wWaZLKo4
         wTnw==
X-Forwarded-Encrypted: i=1; AL+hErGZeEbeX0wBcBYNuzOjfsc7UMcL1UU9iQ/6X5kmAFV0lgmCOUzdeGP4tqIX6sxzuuEZ/yBr53XW8wZn0Jv91Js1dYI=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Gy/ts2qnqZeil8ABgk5ggP9ojHfwx+40IxwaZUkbwj3KyjhfA
	qBGPHHgsdOSiqPMeUAFYxY/ozB6teFdNcBBnqEWy5LuSHylM9/ItJzv+fHPkkRMwQ+NTmElLwNC
	D27kYHSGiIqjSSShCzhm5Bg==
X-Received: from wmsp23.prod.google.com ([2002:a05:600c:1d97:b0:4a1:811f:6de2])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:3ba5:b0:4b0:a307:46f8 with SMTP id 5b1f17b1804b1-4bb8880f29bmr507010265e9.10.1795729069135;
 Thu, 26 Nov 2026 13:37:49 -0800 (PST)
Date: Thu, 26 Nov 2026 21:37:41 +0000
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
Message-ID: <20261126213743.3044079-1-vdonnefort@google.com>
Subject: [PATCH v2 0/2] ring-buffer: Remove unused absolute timestamp mode
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

Since commit b94bc80df648 ("tracing: Use a no_filter_buffering_ref to
stop using the filter buffer"), nothing enables buffer-wide absolute
timestamps on the ring buffer and userspace has no interface to set it.

This series remove that dead code.

Changelog:

v2:
  * Drop the tracefs timestamp_mode file and its documentation. (Steven)
  * Rebase on 7.4-rc4.

v1 (https://lore.kernel.org/all/20261105202814.1350312-1-vdonnefort@google.com/)

Vincent Donnefort (2):
  ring-buffer: Remove unused absolute timestamp mode
  tracing/histograms: Drop stale absolute timestamp note from docs

 Documentation/trace/ftrace.rst    | 24 ----------
 Documentation/trace/histogram.rst | 11 ++---
 include/linux/ring_buffer.h       |  2 -
 kernel/trace/ring_buffer.c        | 77 +++++++++----------------------
 kernel/trace/trace.c              | 43 -----------------
 5 files changed, 26 insertions(+), 131 deletions(-)


base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
-- 
2.56.1.839.g22a8290db9-goog

