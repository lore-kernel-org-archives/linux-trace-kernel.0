Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793471751;
	b=HSqXKpPGD6W4S/+I2iFRv9CCADNR9HLbATsVthgiPiljieOgBBk4HrkrUV6A5EPjeuDa
	 kKw0F481k5KmRocW5kS5MGdkZSWbTU/EFh36uiDYlixVsJCQKRt9Dqgw3aPyYAatl2WNJ
	 k217331k12z3N80HnqJ5V3D8MERQx3PYZUHH5KU5hhAWCqU7dQ86dfqeif14hFx4Qk/h5
	 039FCo6wIQZpRDDrXLVXF0jJvFA6pUCv+8Q0UOa3UToU3D7kSocpx/FzQpL4yXoAF4vMx
	 RSyyNvAFx8MIrh0iUmsrIc+1tiMz9LIw3b783jfsUdYHCmTrwgVF3of9ghaxOnV34dQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793471751;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=JSWP+8K5x8OQvpScI07jlPc5QtG7BUmJR3OiQnYapBI=;
	b=31A+qz8ROKZuIy/nbXxadN7lwiYoiZ2vsYbWmsOfbDlPwwq7Ao8oOntQ5fCP5i1BRZ08
	 TaDD7SvWEhIzRRoi6j0/hBQbj9eLPXVvbzCZa0BBxTxcLbgszvBdqQyywUeKCx5/3coBJ
	 xQWH7JoM9FHdLaP/EARO5NzxkUAHiFPtGSEkAp8LVv8FhenxHXkYvTrVOZBaZ4eUv0Q6f
	 zVbvrkhfaOfC/7CNqt7phh5jnUbw8GVzrQgkX25OUJsn3hMA1ip3/mRop89NKSMKtgYfI
	 z2I1fxK6zaQCtOUjRizvCufcT+HQfXI9BZY6tTJkp0QFy45JKjRYfiTFbfaWQ6seVew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="GY/h5Vxu";
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A30BC606A31E
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 18:35:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A30BC606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=GY/h5Vxu
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4ac95761c85so10183595e9.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 11:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793471749; x=1794076549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JSWP+8K5x8OQvpScI07jlPc5QtG7BUmJR3OiQnYapBI=;
        b=GY/h5VxupOjUe7HiUqsjDuG86vdsQtf2I8PDsyeeiyfCElZ8UuZpZ0d1rhkeyGIxh5
         vkUYDggjh0GZpN8IJ743cizGwowqBKWVdxbboLQWTNN+jzXbDz92J+uZ5WC5y8TESnSs
         wRaX3TH0ipCOiIbpHrBBgnhtpqQwV4D81kzKE2AyY2TnAMBfQaOioEob7PuamSEdHIlO
         zPplGiz61RJKLtyjz5bwVwH/3k4th1+CTqDH74LZ6gCLCO/o3t3yLCn+k5aqgA0TUn2M
         wp0gtAcgJz/wQLl4qIrS2Dva2miqZl9kAQ/0duzGwm/5+xqQBg25vzO5bevuHeHuySfn
         f3VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793471749; x=1794076549;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=JSWP+8K5x8OQvpScI07jlPc5QtG7BUmJR3OiQnYapBI=;
        b=d9s2EruNj+dS8oTnCDyey4gx0PFY6/O8wZR15GkLXUcKyELQaiwS9Gxsni3oCvtZrb
         GRpjSFgUEPfy78c1aIY4G6nD22PeqKC55TKqiIu9+9Hr377wlMTfWNf+FPIo+t/F31sQ
         vRpkPmIIBuwhmpFLgcDHtE2uwuH1t4MeGSqa1SwUh2j7tjNx8DXuraBbT0g4jFKTvSKf
         teqPVyN+51O/+WwfXF66I7e+AOfHRhnh72kGRHYPLOYSMP4glmSso0ykqrlL+paVG7+R
         KF7230T7jfmgA3b4RS430GJ4fC8Kit0r1tM2z49/NIeGkf/fv77DW+0hyfFTedwkr8Lx
         OMTQ==
X-Forwarded-Encrypted: i=1; AKwUvBzhS1wZNK1685AsbJ3GqXQ3+wk6ZNdG3qohX6pyeXpPUTfnbdrRkOa6Sfc6bOcSPHwyp++M/5U1kKblyZ3hTOuVgx4=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsVuqkYIBuxCDERzsPNjmghOsWeTP/lztKuRaun004GuoPzDex
	6GqeXRvNgRT/W6OW9q2tVwsDHgFSahTyYVID7YknlrX48ZME4sgAqHcA
X-Gm-Gg: AYBFou2V8QNAILQ7Coc/CEKqE1WyOzkPZkHcObGDGrGcSyP5I5qZxVOAMfnTnmK5Nn0
	AARvGoWvK1aaMolNIbtPr8Z5NT5WY48vvSMQ02iddHj+YcvDFZZuFRZxf57479Gd05+HvPgG43z
	cK59eSHDGIJnQmSw4mV/9MfyWf8fcaSuEa5fpr0mBAVqQ7ybgigBE5Ek/MIEg+iDxv9pLd0Ccz8
	/Vvhz+TygeFpC9F6SJgvfQyQPv8GPiMTKbauDeiIAO2t+gBTe+gXlU6GY8vcJi9/ONhjHK8xPfV
	0JUae/ioL49bsdOuctNi/rcHucs0y7hc6R1P52CEdqj12OuHg7N/0aTOsWX2tGrO/hRO+SI7s6H
	JcfFBwNsajJa142bA9DTLGumaoKDh1kG6r3wFmEGgtcr440MJ+2ksnGnfJaZHC+T9eeS4m6voWK
	c/LE+2GxCx0cXtfv8FEO7KtAl+ONth+gBhyQGD7ZrPlzrVVfMavxK1GAv7DHvYzowCWWHOX+RzZ
	rP+qOWknY+VM4Fbusz9XEFTdM83IOjByXsFyJWg1VWP8B+4j+CMlUgEPNV1ZrQGf4Tdx/1sybBC
	UK6FyJyMEs6bvWTzxopZTkI/VU9Cfh6FwjOHb6IhNUvax3RH4SZfy23DevFE9qpduQmfWI+IkeO
	o8gb/3FoXeFc1W4KTz95iIawcVQfmrODHc3ahO1O3zVBrbDApNJ3/hcaoPf8uu4hlkst01IV/jK
	hiGx+9o4osLVAdX4+gNSVD1fNgTsWK47FD7fSE4+Rl8uQjLNpOsvrKXVN1uc6wvdaCwIivgJoOt
	GgWedReBHqYKGDa
X-Received: by 2002:a05:600c:6095:b0:49e:7c8c:361d with SMTP id 5b1f17b1804b1-4ac182dc30fmr122145225e9.22.1793471748993;
        Sat, 31 Oct 2026 11:35:48 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-0247-bf06-1f38-d09d.rev.sfr.net. [2a02:8434:fda5:4201:247:bf06:1f38:d09d])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm219745075e9.1.2026.10.31.11.35.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 11:35:48 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/5] tools/bootconfig: Read the documented ftrace.notraces key
Date: Sat, 31 Oct 2026 19:35:30 +0100
Message-ID: <41adc1bbe842f6f9240aa877b85d6b0310259743.1793471731.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793471731.git.edumucelli@gmail.com>
References: <cover.1793471731.git.edumucelli@gmail.com>
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

The boot-time tracing documentation and trace_boot_set_ftrace_filter()
use ftrace.notraces for function exclusions. bconf2ftrace.sh instead looks
up ftrace.notrace, so the documented option produces no writes to
set_ftrace_notrace. This affects both the root instance and named ones.

Read the documented key so that the script applies the same exclusions
as the in-kernel bootconfig consumer.

Fixes: 7e66ef0046cc ("tools/bootconfig: Add a script to generate ftrace shell-command from bootconfig")
Link: https://docs.kernel.org/trace/boottime-trace.html#ftrace-per-instance-options
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I tested the documented ftrace.notraces setting with one and two function
names in a temporary tracefs instance on my Ubuntu machine, running
kernel 7.0.0-38-generic, with recording disabled. The original script
installed neither exclusion; the fixed script installed both exactly.
Fixture checks also cover the root instance, named instances, arrays,
an absent setting and the unchanged positive-filter path.

 tools/bootconfig/scripts/bconf2ftrace.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 7745c97e7abd..e5a833171b57 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -258,7 +258,7 @@ setup_instance() { # [instance]
 	set_value_of ${instance}.tracer ${instancedir}/current_tracer
 	set_array_of ${instance}.ftrace.filters \
 		${instancedir}/set_ftrace_filter
-	set_array_of ${instance}.ftrace.notrace \
+	set_array_of ${instance}.ftrace.notraces \
 		${instancedir}/set_ftrace_notrace
 
 	if xbc_has_key ${instance}.alloc_snapshot; then
-- 
2.53.0

