Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793442355;
	b=3eRjfFnC34AHJVEGNGhHVInm5Nak1Ev+Rk3VOfjvhy1sXDCu7lP0VuoHLCntHbtmuCX6
	 JPI0niLcadIUpp+5aN9xiM1/rSFonSF1f1eaWRxTWCofo2WdD20U9Y3gXtusGSt8yHSrg
	 Ab8Pt05+WzSvx5/urhGdIo02aa940fLAoQiBdypHw9M/xavExYUEyoEE0+YGJ031tbzym
	 QG7SBcpRqvjYe8EukmlcBp53UhII0BPyQQwZiFVGFGHDSldZI5Vsd8Cgbn9ebXlWHJA+T
	 ps46VAZZjSf5ZDwjgUnWyhFN2vCZ4d3+cmMi/M004aP/qwcQOKQQTdnCY2wrmH+jcpA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793442355;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=kplK2CyKAy4yx/18GwkbblUjaSX+3r2sP8SLaekUd+Q=;
	b=2w6QqDe2Fz3nqp1CYVlR/K7eUjCg8S0N090KgkcI2QgJ+n81VTNt+/TwwA72GvAeQ/OP
	 pWRDOmN/NEzlW4hhdOy6KrW0V+srA1Ekbs2Ed8pxfgpb57cUWX0MX8UDBR0Pk1CkbIPIH
	 xRvsn/vseC5DxyZG5qZq92jUVYSUVY2vv/kQS3OwWv82hn2KPD4DUgBGOHk2iXWWLFT73
	 2hBiKjv6Ko9ayQT8nKglTsy0TpUtKorxvg21/pQtnXcKlhL+A8NO5YeUnIFp5Ky83LVS3
	 fhI5yu+JPrPjQgwPcSWDzebxgPA8eM7LMvbg+YPT8CX4V8f4q8Ok2AqI6ojGj+DXL+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv35mfUN;
	arc=none smtp.remote-ip=209.85.221.44
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4721606A337
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 10:25:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D4721606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zv35mfUN
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso1422058f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 03:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793442353; x=1794047153; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=kplK2CyKAy4yx/18GwkbblUjaSX+3r2sP8SLaekUd+Q=;
        b=zv35mfUNlYL5jWE7rjG3YIAd0Um6VkKlBC3QpTka8fQVd2GZOTq53mM2BPr6mTohCt
         zbVUMbIId6O4cA8netO5aa1HDI62F4Uk//wgC8s6tL9tKrO6CsekMCzcxDMhBckPwLVV
         YdKaTSpx2NCrop9HcGNkSIqPDquLMklXA2FOcWGFOf/adPazhqSQU0I+Qf2wZWUUbdhZ
         t1/IKumb1EEYN4lD6C3LDH7yaFKoGHzsgQ9R7q1VgrcwVeSyXjaVu8wZoEYPIEzkis68
         /VBySBAMDWZMzRFUGjPjF8ssxBoejzyvXq2acblYrOwh036M5+xPbH+PxPfK3hY4DCY7
         8dKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793442353; x=1794047153;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=kplK2CyKAy4yx/18GwkbblUjaSX+3r2sP8SLaekUd+Q=;
        b=VpK1bb9S0m68zezX7OVVt8ZG+3tT7BSPSbWv1PHJpl6qjVoyw+pM8VH8AxsuC7ib9b
         RN/nijiBME1wCYQqMZJShGXL2V++pENSrKWuBuumTYWG3r/IEWMpipCp4gJ/e/RzvTmU
         k9l4b/APe0XoMid8rVsFW0mz4aozHzKMtll3o5IDPEcbYeTz5I2BT9jITeF8B4cgO0wn
         Ln8j/xvPbl4aynuC+o7hpU1hBLIugggBybJJLQnZxJi2htHGTWKU4BskXTDqm3ww9RtV
         5Y1I2tLd1NkszTgbzgHPaOptBr8mVJ+2he2qUyfm8ufropiuDq5lr/mRQnnvmZhl1ULx
         zxTw==
X-Forwarded-Encrypted: i=1; AKwUvBy2nqHUuz1n9SAx54+IvOTn8OUUsfPoC+ZihxVQX0k/xDUzXB1xH6AE+T7v+eROeH8riJUn5/qBaK5iPVxdvI2YjpA=@vger.kernel.org
X-Gm-Message-State: AFq9FYLRg25iZX2U6QQJV0X8gVpBOkuJx5FGJznS9UFqfZo0Rdcufe91
	o8EgbCUFmzGWhGJ/IpZc7afCVzvT8luvB3oYwjuLIrOQjzyYUqSNt8ae
X-Gm-Gg: AYBFou1E7BzzWgl9YeO0sQTOfaulM6llZLMWFTTJuFavVsl37ptAQMK9Tg+krWbBKZM
	6Wiaih2LcOzl2/hwPdpcY21b5MG5NcrH3+GsVwWSBwnnqB+w9WgadMj1A4vLbAt4La1sAiMlca0
	O8oQtK8gumg1DRK26ZsXl+TPba5ZHhkqURqhAY4/RhWTBzADjD6DC9p/FvQPtHXrys97+Ir1hhN
	02MIE0lhQpsVC7oJyDD7OXrSpGvP7/zwPyqeiz59IN+AwGXWfP3foT3Fr65g/npBKTGA0brm/Ej
	wxgLaBHOxhW0EblgnbFluJhpZmx2QwgzlJj1FG2YfsCAJGn1+Uc+zKdB36T/80iEUor2GHYXzCD
	OyXOPJvRWaMgF4w97Iau0bXN1ulE6/oqstLA2T3Ef+ewPmwJYzZtune536/VG+caJJ7qdeXlzM0
	p+7D5VxTQZGTzp+UD1ghYMLSEeqDtzEnYrCJCFXpSkSV0qoAucAhUJ/H4sFc/LL505ESLcltdke
	nKX40EY5+HcGISu/EbUYJHhpGCJ1ozDgx6voW4dmP+mJzallwc3jndHsD29VDuuxPAJ0Z7VCZMK
	D44oAWntM3ErwtXaY2MJt3O3Ik7FcsxmWP5H8GS1/K1Xr3peGo+Le2HVwnfO+xahBf628azUo4O
	HTjlq2fyLcUphBTHdoyZd8KVIKhlTCmVCq3Z+M8Ly0KKei96qgjxIEcmETN/gsilS2zNjm6Wo7p
	1UOQyL0PsYgQ0BvJCDnMmtaQRmOIwMQtT4alPVq6ymgeypugQgzXyUAeAGNq/VdxsdJdXnEYoaF
	uQpt0Q=
X-Received: by 2002:a05:600c:4f82:b0:4a1:d8fc:8165 with SMTP id 5b1f17b1804b1-4ac1889c857mr99757055e9.20.1793442353201;
        Sat, 31 Oct 2026 03:25:53 -0700 (PDT)
Received: from longitude (2a02-8434-fda5-4201-994c-f615-42f0-2afb.rev.sfr.net. [2a02:8434:fda5:4201:994c:f615:42f0:2afb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4aa7f3229dbsm195363135e9.1.2026.10.31.03.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 03:25:52 -0700 (PDT)
From: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] tools/bootconfig: Reset histogram variable tracking for each instance
Date: Sat, 31 Oct 2026 11:25:33 +0100
Message-ID: <3ffce36857ca841dc9fb69da304f7575bb637499.1793442331.git.edumucelli@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1793442331.git.edumucelli@gmail.com>
References: <cover.1793364709.git.edumucelli@gmail.com> <cover.1793442331.git.edumucelli@gmail.com>
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

Histogram variables are scoped to a trace instance, but ftrace2bconf.sh
keeps DEFINED_VARS across calls to event_options(). If an earlier instance
has defined ts0, a later instance can export a consumer of its own ts0
before exporting that instance's provider. Replaying the configuration
then fails because the local variable has not been defined yet.

Initialize the variable resolver state when starting each instance so
that its consumers are deferred until their local providers are exported.

Fixes: 2b86062a34a8 ("tools/bootconfig: Add a script to generates bootconfig from ftrace")
Signed-off-by: Eduardo Mucelli Rezende Oliveira <edumucelli@gmail.com>
---
I reproduced this with two temporary tracefs instances on my Ubuntu
machine, running kernel 7.0.0-38-generic, with recording disabled. Both
instances defined a histogram variable with the same name. In the second
instance, a consumer sorted before its local provider.

The original exporter put that consumer first and replay failed with an
undefined variable. With the fix, the local provider was exported first
and all three histograms were restored correctly.

 tools/bootconfig/scripts/ftrace2bconf.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/bootconfig/scripts/ftrace2bconf.sh b/tools/bootconfig/scripts/ftrace2bconf.sh
index 9100ebcd5af6..b63e04bf9400 100755
--- a/tools/bootconfig/scripts/ftrace2bconf.sh
+++ b/tools/bootconfig/scripts/ftrace2bconf.sh
@@ -84,8 +84,6 @@ synth_event_options() {
 }
 
 # Variables resolver
-DEFINED_VARS=
-UNRESOLVED_EVENTS=
 
 defined_vars() { # event-dir
 	grep "^hist" $1/trigger | grep -o ':[a-zA-Z0-9_]*='
@@ -164,6 +162,8 @@ retry_unresolved() {
 
 event_options() {
 	# PREFIX and INSTANCE must be set
+	DEFINED_VARS=
+	UNRESOLVED_EVENTS=
 	if [ $PREFIX = "ftrace" ]; then
 		# define the dynamic events
 		kprobe_event_options
-- 
2.53.0

