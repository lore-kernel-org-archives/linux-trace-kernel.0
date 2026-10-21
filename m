Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792606608;
	b=aoBdxPY1Jr2DeQytMzlBug5rEfdK709yBXPJRBAKOb4zU9mCcCoiaqmezdCv/UQSU/X3
	 +u6vxI6i2qQGsDcQ8HAueMS2YOnNyAOqoltp2jdqFoU73PDZyl3zNhI9APK7SAcOZy/1x
	 ViV9oS6sUKSak0vY/mKS2ZMlany92+xWYfAEZjpDWZ5YoqrKHT1TtRbUpaJ3uh0BPdR+E
	 1DMtklFKYJH2kOCgMNeIfmKONRgmki2MCup/JCazlUkt42H5Zkq8qMP6PNYaO1Qzn6cpz
	 /84M7eUOtLXcgRQAproJgES+tSLT1GpOtDd7SZ9qoZxulJQkvxFtCHLYN9V+logVpuQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792606608;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=yEhVZPhGMEYsPhUdE3zVy4aLvJE9Xbyd5jbdjX2FImA=;
	b=AXWOqM80GHhWY/wTDiEYbIvpO26UGFyeJ2DkPAQrsmB2LZ60fTsZwhbUg2FZ4sI35H9y
	 pt9EdEAwvH89EsOPMMk2YyANLewP0/Dn3d9LLWpSN6FdsddwbnekHz8LTQSyffeEVJ469
	 U36oYoQ3iWgD5iwRX6NWJON2Xl6qcYVsXVzLTP/uWhXTcIr6of4hNop3hEhBGMyxt4QRS
	 hR7j32EIgMrbcez1Bk2FjFuWXRqoS4gYzBJzF7ms8ZtQ6oh69fuyGo7H3lXiylJSLJSm2
	 wr8ogn0Fm7m3MxiIQyoHtcWh1vx1iyEw5VYIj3FFPSLlBYZvUgmexSq9EisU8C1p6Dw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nK1eZqMZ;
	arc=none smtp.remote-ip=209.85.128.47
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4348606A31B
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 18:16:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4348606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=nK1eZqMZ
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-4a1fbd52ab6so7535955e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 11:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792606606; x=1793211406; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=yEhVZPhGMEYsPhUdE3zVy4aLvJE9Xbyd5jbdjX2FImA=;
        b=nK1eZqMZ7+PSQI7iCEqS+Fc64a20N+Lyojhw37axMqXg6vIJ233XhS7EedOKzdtRzu
         QHc3TsiyKpsQHMurFC91Jvuyx9MY+H/5LM6a6IPnHD+9yIlUO9e2ipkZIgArrfVqDt1e
         LgQGVpPTZmpsdimBc9AfEMN1Sd2W35rod0fmj2UtrRYv7j4k/f1+23nmMoVZg6mBYznZ
         U8QXY1I2ZbJ2cHnXcEkRErGJNJzlW6YOY6bgNQ1z6Hk1u4JLYF1kYivzVvvHO1FTdmNn
         vNEXTZ50/4iNxoLIrEB3YR2vxP8eVf92fOEBjDLeXAtXgkOhORe83A/n41607XEKi9/4
         ZlDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792606606; x=1793211406;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=yEhVZPhGMEYsPhUdE3zVy4aLvJE9Xbyd5jbdjX2FImA=;
        b=SnpJAZiN/D6gVsNJhwGV29qZSWPfBnD1dv2UyqBWfrWJ4z+C1YmjEUIaV2em8Z6Ly2
         xlWKmHsx3bm9uJpv7JmzrPH19XTXp/qkFnIqXOIZbwKmTjqPLbXf8s0asO6KJCBE99cW
         hlkMieHCIAtc1/P+eIWpunA9hVPWz31VAJLR+qkkLAp1kkPJ8PKeMrQE6/WDNt1/SvNL
         rCBAdCzwW4fiE7vS9IBztYYj1Rijyf4qtMtvxRV15HmuYOgHJYHNfwfoqXQRAfF9DOQV
         OQqGrlurK8ecJYs3FzHC3cfQW36OLG8mMNUIGRmyjHG3ytLx8iC+2+lBgQ3O9gTlvRfz
         J7ug==
X-Forwarded-Encrypted: i=1; AKwUvBz56UFht72j5SCW5B+Gc9d3MfI6RHGYv4QM1A+zT5rMihCr1bDNxxAAaVYdvv3FBhZ7zJ7jeGM4nEblr2l24r6iRW8=@vger.kernel.org
X-Gm-Message-State: AFq9FYLQ1LfrRkkLUUezOOEIzqOI/nDVvvjUXt8V11C+1GmJct+A9w7U
	1JX5ZTRGwT23NQYENKA6mOl6nHggg2G2Z6+6UHkk9tClgkjga2C2ybAw
X-Gm-Gg: AYBFou2+a8xLebnI/I4GWxc0D88HYH4mD6AM/pxV6lSCMAqbKp2DDKQ6i+6FOnhQWpc
	iYUZuERa5AER2cRNk4RblNSiCGipe/mC87O4NDYjOnrOfqOqH3Aq+FX4aulOW5Elgn4KZQJ/JuZ
	a6f5YtQWXdikaxdQ7m46Cb0g7XKKZzj0dbrK7cNN6QsmBvvVGJdHDEqLSWroiSgYjR/cQBAu7Ry
	8azLDREkBKQvYX9aolw+GBy/MKTPfLTK+N6phTorzMhwHV7sSgjXoqe2G0AyzJu8SlXsGCpFrvH
	viyaERfOzj7c0z1qeFb/QdGhK6hK899+X/bm8ZyzNzCRJcqB2ygdycalUz3OgFZwIvIgvyqoS5Z
	0yWNyQvDjjD6Mm49FCgUV15UmiKKMHkqPps+6TQ1FopyxmeuABKlJPfJ6yjwCWvDkbB9UG29MRU
	tiNM5RkyweJXrj9mrUk+/JWf2BJ1G2BkocYbvEXxCdAWm1ltrkUMsYh2hfD96sBZQ2kSJUV6E2L
	lFwrerWYPiWtybARsrd/Ne/Xto4AMwMX0DjR1Ja/xiz5+r4IVc5yA3r6wGwgWtrmnfFn75BYYDQ
	421R2Bww5QypWQzBYGslnEILQjKRskiBy73XtrgdaYvO2cFStUwKRfY9D3/a5ijE91N2Hm4L71V
	hoPnZFK5e//u1kQWNB/q/hSRHYnPT4gSx1mhE16jJbYWtq3VzA4b2ZwJqBHqQacWL287H6K2BN8
	0lUYWaielFsNAaCqjjHMKROEzgJTarqw==
X-Received: by 2002:a05:600c:3b1d:b0:4a1:d41b:5060 with SMTP id 5b1f17b1804b1-4a1fdb1358bmr65477465e9.22.1792606606135;
        Wed, 21 Oct 2026 11:16:46 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-fbd6-1bb0-8c10-7bd8.rev.sfr.net. [2a02:8434:fda5:4201:fbd6:1bb0:8c10:7bd8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a200c1cc03sm28195805e9.0.2026.10.21.11.16.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 11:16:45 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] tools/bootconfig: Fix enabling all events in bconf2ftrace.sh
Date: Wed, 21 Oct 2026 20:16:26 +0200
Message-ID: <20261021181626.2004489-1-edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
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

A bootconfig containing ftrace.event.enable makes bconf2ftrace.sh try to
write to events/enable/enable. The per-event loop treats the global
enable key as an event named "enable" in a group with the same name.

Since events/enable is a file, this write fails. With --apply, the script
exits before it reaches the code that enables all events. The same thing
happens with ftrace.instance.NAME.event.enable.

Skip the global enable key in the per-event loop and let the existing
global handler write to events/enable.

Fixes: 1d8365a553a7 ("tools/bootconfig: Support per-group/all event enabling option")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
This is my second submission to the Linux kernel. Feedback is welcome.

Tested with --apply in a temporary tracefs instance on my Ubuntu machine,
running kernel 7.0.0-38-generic, with recording disabled. The original
script exits with status 2 and leaves events disabled. With the fix, it
exits successfully and the instance's events/enable reads 1. Per-group
enabling works with both versions.

 tools/bootconfig/scripts/bconf2ftrace.sh | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/bootconfig/scripts/bconf2ftrace.sh b/tools/bootconfig/scripts/bconf2ftrace.sh
index 850c207343..7745c97e7a 100755
--- a/tools/bootconfig/scripts/bconf2ftrace.sh
+++ b/tools/bootconfig/scripts/bconf2ftrace.sh
@@ -218,6 +218,7 @@ setup_events() { # prefix("ftrace" or "ftrace.instance.INSTANCE") [instance]
 	prefix="${1}.event"
 	if xbc_has_branch ${1}.event; then
 		for grpev in `xbc_subkeys ${1}.event 2`; do
+			[ "$grpev" = "enable" ] && continue
 			setup_event $prefix ${grpev%.*} ${grpev#*.} $2
 		done
 	fi

base-commit: a804c5742bff224d4cb4d25dd383554d598be32b
-- 
2.53.0

