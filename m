Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 763CA54676
	for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711728246; cv=none; b=K5ncPJD3/itpiNDj5G3Te0WqaS6U1ycwpefzFLjB5tFXzGSUTmiBkj+1iCXBtB12zo7Ii54b+a/5jv7bcwcoNWcOn7+n0wWbuodkWtgKXajqzj13AX0EtJ4TaDEm+t0fVFX2nAK2qRE6pgRUGq68Kpv37OqkWbPOYUZ3RIjipFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711728246; c=relaxed/simple;
	bh=wFy2ocajmQzl18h5nhYUNHbZaRyAmobqSM9VgYVPkIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rjqj9m3zCagn8dW0M6w1VhfjKs0hc9Gnp5qwTbvxuWb3EillShckYTAua2RaKK8raeqGGaC2jV/69hJmi1I6BIEeHpToDGONVuRc3urYNuvEJ80oh3nv8yAg5aB1A/6CUlJ5/lZvoTbZTi5ujAuHtrUgsNSHiSuQJb1Bc0AA/FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=QbAWB6oM; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="QbAWB6oM"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a4734ae95b3so282535666b.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:04:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1711728243; x=1712333043; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sS8wc5N06+O63hK3jDZunVFBSBF3m9X5f2cGi7eyqww=;
        b=QbAWB6oM3Se3vRG4kNWCwFOczHTIvaE/TTPXO00Pgzj9MNQ7q3cPmUs+Yuk6JQ1mzp
         FFTLJoG9xeCqhlIoNccQxB1hSZ7DZ2Kk3zLV1ir6ikUBD2Ze6S2FnDl1tramR1VhqZSo
         kvQIp68ATLg0/st/aQ0PHq8/sFcK7sWxLv2GYO71kEdE/Vj6QpqUW2KoVSctF8sieAid
         Mhn4AW1NUg9CZI1hBn3uLhIzMe+s7ddtk8y+WljRn0u5gm+Spc5pOEVZMRlX3qiZcxdQ
         0FtYIo5unlYLxV47k4GJqT+P/7qIr49zIZNvv+QtcgEFrxE8IOrCeXWv9GkVvoIxhav2
         A1oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711728243; x=1712333043;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sS8wc5N06+O63hK3jDZunVFBSBF3m9X5f2cGi7eyqww=;
        b=ZboaOy6B4NEcYGsduthtvSRtP0Pv3GX1mQIGaj3V30AHejaWCSLBvF95q0lOfElmog
         Llpd1VQ7VT06MmYHHxPit4puRqTgIIKdeQSjn02S3cEopWA4odf+TqfaPygeRpYizCnR
         5iZAF1C9iFWzNAL2+GFWzhKcX1sA4pODb7YJNRR4fZ7BynvgXZJ13+GUML5k5P3Nmq8U
         EKXAoj354jZs33KRH7QNV6e2pokkjehaayBMNvpZu9dgyWbWOLhjdVP6b3sCYGHWgDMY
         DnFRf21z9qDhkvHcAqDqB+CAN5Bbr9SGE8BOEpcq8Cv3v716AbCy6buAyjEWu+7nJaqK
         +LAQ==
X-Forwarded-Encrypted: i=1; AJvYcCVn8EPCMzGxg8/+ZsHDskjeFz8j10q6fFFsVFSerd2aTzEMBsOwDsLpIBSXPmkAxDEVegYKKW6h1vuvUWyBvOK4SfIJ2N2z3Gc3wqeS9UEKbM95
X-Gm-Message-State: AOJu0Yz2XISXtWzIIMs3sFo6Z5a3bgbCN5rt7IJtGfDN592j9lSuRVmm
	950l8WE4vvWEzOGtglXW/UpbTkEKZkEnE3FAIMKIoCqd7+mpHkm5a64v+eHpsaM=
X-Google-Smtp-Source: AGHT+IFnI2YKOOVkagxP/BUc7At9KYFILXTu7yGhat+OGyeCg6hF2QqfF4se7FCbeLkXd5P1YXlv+Q==
X-Received: by 2002:a17:906:69c8:b0:a4d:f58b:9e9b with SMTP id g8-20020a17090669c800b00a4df58b9e9bmr1629316ejs.25.1711728242840;
        Fri, 29 Mar 2024 09:04:02 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170907098900b00a4e3fda23f5sm386088ejc.165.2024.03.29.09.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 09:04:02 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: thorsten.blum@toblux.com
Cc: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	mathieu.desnoyers@efficios.com,
	mhiramat@kernel.org,
	rostedt@goodmis.org
Subject: [RESEND PATCH v2] tracing: Improve performance by using do_div()
Date: Fri, 29 Mar 2024 17:02:30 +0100
Message-ID: <20240329160229.4874-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240320215537.71034-5-thorsten.blum@toblux.com>
References: <20240320215537.71034-5-thorsten.blum@toblux.com>
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

