Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.208.70
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988469;
	b=zUUXjE2mp4QWeoVJcHUmhOhegAZf66iqgT/Rk3ryziAvrXZ6BELMu322yWSDeieavtBq
	 dsK0IyW+F2zZKC48Z527G58m2JmdXRcqkayK8J+S+y8wHQAb28E+5lcoSTFT9f3dV37u9
	 jhtKxxifvoZurNF+EtV78sISsqKE6N5mSMxU1tmy7zwQYMEKQX0s3MnnGsz7RdqMRjHFQ
	 5yJKnISZ+2duUYV6DVdd90tlzqGiyhjE/Qjk3VbhkNNGSbjWt5U4IXoxe26d8urq3BQCN
	 irwVN+GMueFPRga4Blmug50tSVfIsEfywty56N+O2hZgR9oQcI8AMkmhldenqoNbz4A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988469;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Received:Date:In-Reply-To:
	 Mime-Version:References:X-Mailer:Message-ID:Subject:From:To:Cc:
	 Content-Type;
	bh=NF+p8TaNog+GEkVOzYIekPEmlnmf2+ljMEUGy7nnhKw=;
	b=gfkk/MBQlpYAirsuhkWsQLpLrfQcbOmVaIOZyyCvr5xUA4xRcdJIDgKFMUGXtaixYyOU
	 QKCAWCh4cMmpOgFZKCMzA3g7JnZtc6bwMKca58g2Q4MK6XzLnWvEanYj1jn1c5G0a0EQS
	 RZNw6fojG08pVDNRUnTiy4rDqgushINNWF4F8Xz6TB4coF6dTs1Cb6WjbKICqrFxa2vQX
	 OqPYbvNJqMakOqNGYLtSrQkUhAoCfjkE9uAH1NA9y3QhSAKAk0aU83g01X2I1c/6P5gbK
	 p64u3SYz1eF8e+PCwrZcZQPmGVIPc+1PJbVsXuV9fkuC54gWc+unoH97rMgKfbEPhKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JMcvktGq;
	arc=none smtp.remote-ip=209.85.208.70
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com [209.85.208.70])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F75606D807
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:07:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C9F75606D807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--vdonnefort.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=JMcvktGq
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-6b565e7a09aso998667a12.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 06 Nov 2026 10:07:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793988467; x=1794593267; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NF+p8TaNog+GEkVOzYIekPEmlnmf2+ljMEUGy7nnhKw=;
        b=JMcvktGqzIA8+4JJXWq2y++Eg32OgX5gCXGTkEQoSungUlwWkLG1B/sVFGZ/6xAA5y
         uhkCp8i++G5MhrzIiGLRDnDASCmzfj10zpC+/Pjn4KZ+ZC4awVlZb0zUtFCuoswhQG7z
         7Bow3psYj8eaM2vezN09VlBX18PFKg1i+wWDmmPinj63ECAnF468j42k9MEJMo1lc2Ic
         +I9ylLxX/SgI5n1aSljEccPLEvi2jz2n3cU7VcGwBX9KywQduaS78xhqvFPveYgJ5bvx
         hy0VdEhwjVSFWKvMAQR+357rZ7YLK1rMKldyJVOLzyVv562kmo8OzrFJ08BVF5nzpRbn
         LcPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988467; x=1794593267;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NF+p8TaNog+GEkVOzYIekPEmlnmf2+ljMEUGy7nnhKw=;
        b=Cy254EJ0DivB2BMFGpA/euPJZTSOhLmU8JaSetKGORK007WeeMWNjxh7ukucpX1cCI
         CWgBqSzNj7O9yaZAg96qm0Wzkv6YnRpTrL0ddkkUf48IAu1DFWWh3WHc+ZMvy4AT8B/u
         iHYOw+UcCyHMU2zOzy9OlbCe7syIWZrCpsewZ1DRpiP0hODHPuV1mVS6q9Bbd6f4M6Qp
         B1brlHWrmMAHjpct+sZglboDtQkKo8Eqc6JhrjGcqzOjVLaWcH8ThF+LmX6HeMv7MyA5
         a876W7cZxpdpL49VbusproKRxJWwCUFERYAKqMq0nHR8qy12vBcxoRp7YgpnMmC1QKbD
         4KTQ==
X-Forwarded-Encrypted: i=1; AL+hErGCmdF7peB7SASCmIZq8fTdo15V/scqIOP2TSc3x/Ub99q1ecuURtu9ln4DF5nOmo3repSONE4Pxm/s8dMUQiqsQVQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z++Fe5/9NWspv8I4S9EYSt5odxae3mnOFoLzE91zjJCMkxieB+m
	evs/YImAYj73nagaQlL4hxk/WJRdW3s3WPsph2x2+fnPdgI8AJPl2DICt3NXN95WcDQ4WEtjH1/
	QjLY1LCQxJZboVJRCtln2aA==
X-Received: from edk3-n1.prod.google.com ([2002:a05:6402:4043:10b0:6b5:8758:c1b6])
 (user=vdonnefort job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6402:400e:b0:6b6:f3ca:94c7 with SMTP id 4fb4d7f45d1cf-6b6f3ca95c9mr952111a12.12.1793988466853;
 Fri, 06 Nov 2026 10:07:46 -0800 (PST)
Date: Fri,  6 Nov 2026 18:06:40 +0000
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
Message-ID: <20261106180657.2460376-5-vdonnefort@google.com>
Subject: [PATCH v8 04/21] tracing/remotes: Initialise pos in trace_start()
From: Vincent Donnefort <vdonnefort@google.com>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: mathieu.desnoyers@efficios.com, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, Vincent Donnefort <vdonnefort@google.com>
Content-Type: text/plain; charset="UTF-8"

When *pos is 0, trace_start() passes a dummy local variable i to
trace_next() to fetch the first entry without modifying *pos. In that
branch, i was left uninitialized.

While i is discarded and causes no functional issues, initialise i and
keep static analysers happy.

Signed-off-by: Vincent Donnefort <vdonnefort@google.com>
---
 kernel/trace/trace_remote.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
index 026f6ec9b07b..317ba3124343 100644
--- a/kernel/trace/trace_remote.c
+++ b/kernel/trace/trace_remote.c
@@ -748,12 +748,12 @@ static void *trace_start(struct seq_file *m, loff_t *pos)
 
 	trace_remote_iter_read_start(iter);
 
+	i = iter->pos;
 	if (!*pos) {
 		iter->pos = -1;
 		return trace_next(m, NULL, &i);
 	}
 
-	i = iter->pos;
 	while (i < *pos) {
 		iter = trace_next(m, NULL, &i);
 		if (!iter)
-- 
2.56.0.455.g6c5a503b38-goog

