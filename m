Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B7888593C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 22:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710972142; cv=none; b=PstqK4trYAeBkPST4l04Scqf+A8feVh/qdTehY4Nnj8G+JRHf84s/jFlZfQ2qCEq4E5RXfaQSj6erZ3Nt0nIIoPliEt7aOPjtTLumf+m9/Gm0pHK9kErADkbKCbCe6UeVBcDG+upw4g0Zv2n5GPX4O+74l4wf1Ebm94PvCz9DmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710972142; c=relaxed/simple;
	bh=wFy2ocajmQzl18h5nhYUNHbZaRyAmobqSM9VgYVPkIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q0/f1mXC8mgEA59j/IUJ1cduMCYqud0KvQt4fMfRvlgsb/IWCOHp5AivEY81usExDex3BLlHlNnMr4BWTjylvTa2qdZRcrD9f5XlvIKVUcH13xCL4UtcvuoAJyMzTxo35tCi+wc3j47d09NH/LElxmA489Bam37rRuVlC3ozO6w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=z8dn7H6U; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="z8dn7H6U"
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a46dec5d00cso41950666b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 15:02:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710972139; x=1711576939; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS8wc5N06+O63hK3jDZunVFBSBF3m9X5f2cGi7eyqww=;
        b=z8dn7H6U4n+xs6Oo06q11x+n9JklLRd0+ztcXhgq5d/v+gS4h6uZrrLTJOiMSsYQdo
         dOCz9FqOlyvp1D2+ysRfsvzvTaOlhwkybUzS1NDckuCuADkq27OW8xWl7jFS5xTPoCce
         vH/do+uEK1+2ZoCIMiMTe0PdAsJVzNjl0FcfD0A/KUyhdbmW81hRq6JCRUU5sU7bqdKq
         0Jzzq6bX21eFfodM5IgcG9v9Hwi+44V9l27+iICqxXp2N4cX00HsOtn800xZfWZPh1Fj
         PyknQFuWzI4zhRS2FOYwtfEColZRyUzf4kH8VDR8T4NOCdv5VKDmFoCThhCAW0ercLly
         Zhew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710972139; x=1711576939;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS8wc5N06+O63hK3jDZunVFBSBF3m9X5f2cGi7eyqww=;
        b=vjY3fyBb8Cp0VvngnbS3NwOc7UaCeSvk5xIPnHZStBvNgaGTQW0q/0OUEu2OLEPtRN
         jX+w7egvdZGo/oxZXdVbrrw/ELxjqOSpHSOqZ0m3KGMz/IoyIE2Xz/IjGNtNKRWEPX2G
         0++GWxJmMnfl2XyfTxG9EOgnJwUhXB05vzJvJ6YyW0MvRz4ozNyRhR8aMDTI/dyxeHKl
         vi9Qy4lUoQLpPVYXZ+vlja6M/sbBKFcJanttnJuCXBdDQmc++IUddsj1VuqFxKc7xoyd
         awqmm/IHjf59GlSygCeVAwnoqESqh/ie9Sm3RwArnl6i34w3lOu/R8ONMgcXbqIAT4vN
         8LGA==
X-Forwarded-Encrypted: i=1; AJvYcCXopmrWHiAQhnmF8ff7NHHG6ff398YtNovW4Xk4vouQQAAVNIuMvyCAtmFX10rCWVNHLMKTE0wG/gJHhN4I/7cZJPSDedPXr+5erO60+TeUvcw+
X-Gm-Message-State: AOJu0YzGayw+NShNnsd2rRLOB33ZjJI+XesZPdb+YOlnN2rWowxwEZnM
	45Jir82y3FIRBIDwKnxJro+PKAc8WTnklExwHZMkU7KdkGGndgAFjebNTr/7XnU=
X-Google-Smtp-Source: AGHT+IF8q+53jr2wCVMtAUloZJcedvijn/XpjSctXFuZBU9YRFJpLtrKHJpT0WDihxI53TIyF1jTwQ==
X-Received: by 2002:a17:906:3e4e:b0:a46:df38:6d4b with SMTP id t14-20020a1709063e4e00b00a46df386d4bmr95646eji.66.1710972138794;
        Wed, 20 Mar 2024 15:02:18 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id an14-20020a17090656ce00b00a465b72a1f3sm5239507ejc.85.2024.03.20.15.02.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Mar 2024 15:02:18 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [PATCH v2] tracing: Improve performance by using do_div()
Date: Wed, 20 Mar 2024 22:55:41 +0100
Message-ID: <20240320215537.71034-5-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <4E5A47C3-E9DD-4FD2-BDC4-BED67EF791F2@toblux.com>
References: <4E5A47C3-E9DD-4FD2-BDC4-BED67EF791F2@toblux.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Partially revert commit d6cb38e10810 ("tracing: Use div64_u64() instead
of do_div()") and use do_div() again to utilize its faster 64-by-32
division compared to the 64-by-64 division done by div64_u64().

Explicitly cast the divisor bm_cnt to u32 to prevent a Coccinelle
warning reported by do_div.cocci. The warning was removed with commit
d6cb38e10810 ("tracing: Use div64_u64() instead of do_div()").

Using the faster 64-by-32 division and casting bm_cnt to u32 is safe
because we return early from trace_do_benchmark() if bm_cnt > UINT_MAX.
This approach is already used twice in trace_do_benchmark() when
calculating the standard deviation:

	do_div(stddev, (u32)bm_cnt);
	do_div(stddev, (u32)bm_cnt - 1);

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
Changes in v2:
- Update patch with latest changes from master
- Update patch title and description
---
 kernel/trace/trace_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 811b08439406..e19c32f2a938 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -104,7 +104,7 @@ static void trace_do_benchmark(void)
 		stddev = 0;
 
 	delta = bm_total;
-	delta = div64_u64(delta, bm_cnt);
+	do_div(delta, (u32)bm_cnt);
 	avg = delta;
 
 	if (stddev > 0) {
-- 
2.44.0

