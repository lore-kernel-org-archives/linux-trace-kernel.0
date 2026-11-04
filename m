Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793834458;
	b=XmWCU/DGyOXbdXtOsAwf+EWzdd3u0UF7LNX5RiEDQQvwv/KKu3lGV4A99OWYAHfYXXSr
	 ToCDCaTRmQD1rM7vrZOboOyH9rKilLbDep1QgJ3mwrf467ZmSpRuGyeDZap0lAk+k9ZvH
	 03vjbNVyTupuQuP73quJOzk+hZF86bMjMFP72LfRHT++pLS4I6TuBZH1j6/gywmzXss9i
	 dnuV00XutDD0lsMNfRC4DeidSmeF5CDKWPlsWzfgO/iBer6HaYgwghXHpD+J+jCFxjeUT
	 jBs2N+cXbaNDxWhGIx457F7M1HXP+ycmqK6k1pnsP3r9H45IVIA6LGslOfQizZz5LHQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793834458;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6pcpvaSe9ElEJt/G5lEejZAQ2sl+Ux6mleZlCU2LO+0=;
	b=i3AuH/0zEQMV2tZYDGDzi9IjJV3GVUeqKNl94i/UTN+bDFe7i/nUxYbMtiDI4havhv26
	 /pCzoEKyH73Imc3tondKCMy5XpGqUztLvPpeYNGYPFmquMOa37YoUD/X91DIWJQn16b5s
	 SRwhuHrYVrXa25CDNTOgYLro6xnu1mEV9bAHmc81CYdSaHyEkpJ5bjYCYjF2CJ/omHKaJ
	 haQ4fRwNJYwb7loe0tqxzt7LmhwLMunJhar+Pnm2uZyl0cPjDWhiyAEIgK2I9XIzwFO/I
	 XrRv1yJ0D+9wIApfNvfvRrxHklK/LWTCVjgoiLr5JQiTEO3dkvkRzkhTsjDGMKmhhpg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="D/kVshHl";
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1C0606A32C
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 23:20:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2A1C0606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D/kVshHl
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ea138a3497so8235215ad.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Nov 2026 15:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793834456; x=1794439256; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6pcpvaSe9ElEJt/G5lEejZAQ2sl+Ux6mleZlCU2LO+0=;
        b=D/kVshHlSztePvRdaME0VrDfCaifENALUV5qVvoTlOqwXmIOoRDvM8d+e2KtZbsp6n
         MM4W7BmOwFnTIQTJV5mH+nKzcfaDfcklz4psWGxjZ5qxFEwt2QZ7sKJVdw0UY3jZj2fv
         WvZCJQucY/GpO87C1GyoYqwyZoalSi4YsUwRR7pRgN5NQNV5NvdT5ApTpBg7QTjAyf2N
         CEJOh5k2RQxA/sIUZLzpy+JXq+tcwClbhZFcrLP53Ro/1nbmU9majZlr+vxKyDkQdDoX
         9ETPZ59lJPc8f9CcQ896HXzsNXUi3iujx/RpI2lBDkkIfSc0xdCdEVdycQERgRylhmwP
         9vkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793834456; x=1794439256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6pcpvaSe9ElEJt/G5lEejZAQ2sl+Ux6mleZlCU2LO+0=;
        b=y3iwniiU62Rl25EHUJNYwt5v3kvIMkxsWN2yVcZeeiY4vxQ1LMrYU2jC9ITolYss9t
         pPPqOoUy4yKf3KRckkaIWCuXCTcN2xjutwKqD2uX/5QvPo/pMqF9A0jMyRD710eqENNO
         ++dWEVOwM3iMeu1PhxbxwyEIpL9gPDa+jnbo3iOuYF7B05FZo5lvRcvQjc5GQQAGAOMD
         QFf5/3ZS7IxgrVHfCBwRBB3Fl5N/DlF3lCq2HfcpFm+uyHcE2mNWIoVedkzKtoSF0hbw
         h5lf7IEN8gzbMZByYMfD3dMSNpuBvIEYdogbG44QgCDxTGeTeDQRdKtRTCJw2/huDplm
         TsBg==
X-Forwarded-Encrypted: i=1; AKwUvBxdoSnvTWuZfHXEEIdtIn/F3dbM+EGsnBspmGey9mPJltSgYyAH3yhHIXDynjmT/TOpVSsDqhdFXLPBR7giBcAlTmc=@vger.kernel.org
X-Gm-Message-State: APuU4Z/xWvR5F01N3VLFDjZhBI/qTfw3EuII0B74OIMFra5TtqJ0aj+L
	OfWuOma+++K9ksTXzggXiXG8psceHjHn5UGpFFqbpTZPCeABdkRBNnBB
X-Gm-Gg: AYBFou0Y9jUbokCyf3vjpJWvBu/PWqiUDpb7m/8KWPf7I952naLTm60mKMMUQ6GMICP
	+0e41uzShsKsxoXYaYg0v+6xJwQ66hwFOo/BCNlrk2L8W362uoFjShJXPsDP6Y6GbZhSXbH4Njy
	Lnn226Um4+fuZ0tBGVxuG8ZwDW0znWiZQc6pbAHa2brl+ut1m4FWD+FYcECxeh5H9UArWm2iph3
	ep4939vyUBXcVDJ2iroy1vcmZiw7t/c4y65KsMdwxAvOLkIdm5uvkODMu0AGOXh3iNEKWKXEdcT
	vb14p0L7mDJ3pQZSii6l7WdJ9yLhA2Z45bNh/8HMi/lwo//GhL/jUemVXiJnZYhwp4E0kyoYTmW
	rI3zIxLOYquaCssWMl1zuxPBHQakGuZxOdTQXmsoaEVjRqqxLqtuRio44f+yHDt1IQX1/rqysLx
	RkmI6keEY4YEUnupHWcVxd5EskfNGMuJey3Z1sNCYUcYJ1w15X8nXcziTeWOE/SgSF1wG4Pcuyg
	VB7pEzxUZ12bjjM9XxfzY2owubeIcmkg/BSm0LfgKPtxxQPx8BtX6bMSo5SHXb2OGmv2aD18Fsx
	5YKZ6BAgEmCCfB5g/5Rrlxq3eHjm
X-Received: by 2002:a17:90b:3811:b0:3b0:adba:45e9 with SMTP id 98e67ed59e1d1-3b0adc98d2emr1040635a91.58.1793834456448;
        Wed, 04 Nov 2026 15:20:56 -0800 (PST)
Received: from localhost ([182.216.53.174])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b094dec0e3sm2551500a91.1.2026.11.04.15.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 15:20:55 -0800 (PST)
From: Jaewon Jung <jaewon8868@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: sashiko-bot@kernel.org,
	sashiko-reviews@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v3] tracing: Keep copying markers when one instance is stopped
Date: Thu,  5 Nov 2026 08:19:26 +0900
Message-ID: <20261104232046.32519-1-jaewon8868@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261104085715.5838b869@gandalf.local.home>
References: <20261103005219.3236380-1-jaewon8868@gmail.com> <sashiko-outbox-194417@kernel.org> <20261103095019.6a88e783@gandalf.local.home> <20261104063552.28094-1-jaewon8868@gmail.com> <20261104085715.5838b869@gandalf.local.home>
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

When several instances enable copy_trace_marker, stopping one instance
can prevent the remaining buffers from receiving markers.

Continue copying text and raw markers even if one copy fails. Return the
largest successful write length, or -ENODEV if no write succeeds.

Fixes: 7b382efd5e8a ("tracing: Allow the top level trace_marker to write into another instances")
Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
---
Changes in v3:
- Return the largest successful write length, as suggested by Steven.

Tested on x86_64 QEMU:
- Before: A failed copy prevents writes to later live buffers.
- After: All buffers are tried, and the largest successful write length
  is returned. If no write succeeds, ENODEV is returned.
- Existing text/raw marker and instance selftests: 6 PASS.

 kernel/trace/trace.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 08614af8fad1..164da1ea5e73 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6329,9 +6329,10 @@ tracing_mark_write(struct file *filp, const char __user *ubuf,
 	if (tr == &global_trace) {
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
-			written = write_marker_to_buffer(tr, buf, cnt, ip);
-			if (written < 0)
-				break;
+			ssize_t w = write_marker_to_buffer(tr, buf, cnt, ip);
+
+			if (w >= 0 && w > written)
+				written = w;
 		}
 	} else {
 		written = write_marker_to_buffer(tr, buf, cnt, ip);
@@ -6408,9 +6409,10 @@ tracing_mark_raw_write(struct file *filp, const char __user *ubuf,
 	if (tr == &global_trace) {
 		guard(rcu)();
 		list_for_each_entry_rcu(tr, &marker_copies, marker_list) {
-			written = write_raw_marker_to_buffer(tr, buf, cnt);
-			if (written < 0)
-				break;
+			ssize_t w = write_raw_marker_to_buffer(tr, buf, cnt);
+
+			if (w >= 0 && w > written)
+				written = w;
 		}
 	} else {
 		written = write_raw_marker_to_buffer(tr, buf, cnt);

base-commit: d7ff48d92a0f28bc0612da47c054efbc28c19562
-- 
2.43.0

