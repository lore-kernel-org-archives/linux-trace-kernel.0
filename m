Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.181
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795262619;
	b=4zQHsRFYn71L6IZLK+nHZEJp1H5pZzq9xdBquD0LawpNV0k42tRxh8Az7rTQyhvmpszV
	 bvBo0b+PI/bHkaC0MlIVZXnWscHqn/1+bqL5QYVLd6tOytV+xWNzmjJrOD+GU7RedmW9A
	 IGQ/e/B3uI0GmWs378hy7rtPKOw+dR/V977YJoeSkxhaDEAGb8lBD/kmttvLKKriEDw8t
	 cq+8qgzlNacIasSfSGphhHgSk6BewUJiM+nz9zlWZHYUidbJ/hf+X2CeFAmMOV1DE+Vx+
	 R0vSZnvScrsinWE7fc0PN0KLAOSU9mYkNmasoT+c+IiRvUDB4/wceNZbi98bGjQkONg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795262619;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=8S5/KqNfuIt27SJJNZdfEe4DOCxa4rr3UivWTDl1Z8Y=;
	b=JM6lr1zjlvl/xqJ3VbZJ+BHtQ+NERT8QoTVGNq5R4WzFRA+tZaCDz2jdXgqs/ZlC0yX1
	 ej2SdeJOVpRzae+Itc3icL2OgZuWbTFbxoVJVW3QFyNlntZqRwIIK2LUdQ19uCNqLz2rx
	 wesNLQZBOOF2WyREPINEP07IpIGuo/y26/95mf08pT4lm/SbHMqnzrjUJSVB5F2gFv1lI
	 0CuXGR3LojjJ1wKhoLhteS+d14XGNmfAGaoq/sBmKDRmbUdbNx1VMGGRX7oFPAKyNy3A0
	 1pxRdxlUB8L85EEB+Qqz/rAsHwyXJIw9r0zg55dJoP/XCZwit6X+odOzhoTYONcLDIQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVihNDy8;
	arc=none smtp.remote-ip=209.85.214.181
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07AC1606A320
	for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 12:03:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 07AC1606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=nVihNDy8
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-2f04244c3d0so15133605ad.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 21 Nov 2026 04:03:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795262618; x=1795867418; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8S5/KqNfuIt27SJJNZdfEe4DOCxa4rr3UivWTDl1Z8Y=;
        b=nVihNDy87HH1roi01mqOIvZ3A0P1CyQdsBF5oW+nMAaJbFW29GlWliLncjPJfM36ML
         CPLZ7TRrDufMD4vRRsQguJBPbSNNQNUPpRUnWSqwBRTetjMbfExEnvLA4xljAFDhd0KM
         uMP3keTZLAXh1xAuOXhjbdnKStCqM/X34BTLq6m8u5931YiG0SpFKL4XYwo4LlOhG2R1
         6jwtck+XLxot766E5D1oQ8Y0fCLHaXShxvoEINR1+ra0cVWVhzEsuccfFf8aG3YrSaNW
         mnGVRcvYdr7bBJPlsso4WuJLbSAU++xJyBQwyU+7ZZBu8vx+MglChEYiY7QmQ6VyMeaf
         jKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795262618; x=1795867418;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8S5/KqNfuIt27SJJNZdfEe4DOCxa4rr3UivWTDl1Z8Y=;
        b=owcJ4xFf6m4wHgo0Np67Nxsi83ngWjo295Zn//OfCt2f8PweRjWA/o7YvKvZhvjFUE
         xmqVbysBDThIVDoZ/f8pF0r8RDBkL8a+LVloLeE8CuBt0abE1RfQcMWLSTtq2Je1dWqc
         6ojeY4G5hMePwdwd+HwMlUwOmWt97az7ujQ79Jv3KxMECB4LjMrXihvPQ57Hg57+vhZY
         NmsWagAoRWg2qHiE9jGAOsrFnQGNeIjkfZAK7h6YPs9RK08+TeeJnb0meWKN2bhgYe9H
         Y9jv19Jv2kR4I32DM/WfFjsgxiZnQbZDmDZ9mMuG9jFjSjoSZVVwbNrF53DCKBtx9Tho
         meLw==
X-Gm-Message-State: APuU4Z9Ho/ZW4rcQNGEUqFGhSujBr71eMfcSPG+NHgPNWOeROqHp6NqC
	O2ZjYpbMmHrjkuNrRhh0WfPe9FHGfHQl76L5uDoAzYc0O/8xoL0e9BSrBp5NmDrT
X-Gm-Gg: AZFdTZdmYyjcujbBR5EqqFH0WhjQLTj7bQIfJTxmDKW3WgusWe6JXyc3trm4KaNV+bI
	k6emrtB6EWXcltjyUdK1iCdoXg7cexayPu4qxYmPtxokSjjYQeBJYa0WUgZrZxp/HnfknMgpy8/
	bt9N+a4ZrCsFoKTsdEkHk8GV6ONUE/9VLiV+fL4a9LxZlqpKJ4kFx5I6b5iB70fF2vBsThxBZNA
	6vQxtWpkwJbEJY2kyr6DUXTiyNKXAehnx8YgOk3G3mZZgiEvxMIdenOSHwU31ZmQjGhh2nqRPzK
	9coSAJ0T1NO6Q0wjQ3JfIM1zIH/s5B16gFrbLed00kPJScPZoiKYnlqA46Z9fUatasSwxl/aFe9
	X6ybnTpaUK+uc3y44FU41cnrDwcPFLD6UykDhlQAPj79vZBzNUVHqWKXblFBSy+g2oHJEDs/8Bt
	NlFG62EVc/xqNt60J/wRPYPZREM4Lvk0eD3r89hc8qN3vN78ZUahiv8PIA7WJNjrmBozYexGC0J
	Kq4WhxpffKROMENLBabm3cymFglWjordvyO+p7nUXkP2v9xdvCV9WTYmK9qFYEpNGaaguk0x5a7
	NZN8AAybrYpLgsVVoGR7fHox5+4CcFaR8WnBSEvGdw==
X-Received: by 2002:a17:903:2b0f:b0:2ef:d981:9576 with SMTP id d9443c01a7336-2f03f181ee6mr61370735ad.54.1795262618383;
        Sat, 21 Nov 2026 04:03:38 -0800 (PST)
Received: from [127.0.1.1] ([220.196.193.21])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f03f0c2ab7sm25475535ad.15.2026.11.21.04.03.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 21 Nov 2026 04:03:36 -0800 (PST)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] rtla: handle SIGTERM during a run
Date: Sat, 21 Nov 2026 20:03:22 +0800
Message-ID: <328ecfadb98649f317985124b6b49bae2d356bcf.1795262546.git.chaosheng.qu.linux@gmail.com>
In-Reply-To: <cover.1795262546.git.chaosheng.qu.linux@gmail.com>
References: <cover.1795262546.git.chaosheng.qu.linux@gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

rtla installs a handler for SIGINT, and for SIGALRM when a duration is
given, but not for SIGTERM.  A run stopped by the system - a shutdown or
a service manager - therefore dies without going through the cleanup
path and leaves its tracefs instance behind, so the next invocation
finds the instance name in use.

Install the same handler for SIGTERM, and restore the default
disposition in unset_signals().

Fixes: 2f3172f9dd58 ("tools/rtla: Consolidate code between osnoise/timerlat and hist/top")
Signed-off-by: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
---
 tools/tracing/rtla/src/common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/tracing/rtla/src/common.c b/tools/tracing/rtla/src/common.c
index 8c7f5e75b..b86a60076 100644
--- a/tools/tracing/rtla/src/common.c
+++ b/tools/tracing/rtla/src/common.c
@@ -39,6 +39,7 @@ static void stop_trace(int sig)
 static void set_signals(struct common_params *params)
 {
 	signal(SIGINT, stop_trace);
+	signal(SIGTERM, stop_trace);
 	if (params->duration) {
 		signal(SIGALRM, stop_trace);
 		alarm(params->duration);
@@ -51,6 +52,7 @@ static void set_signals(struct common_params *params)
 static void unset_signals(struct common_params *params)
 {
 	signal(SIGINT, SIG_DFL);
+	signal(SIGTERM, SIG_DFL);
 	if (params->duration) {
 		alarm(0);
 		signal(SIGALRM, SIG_DFL);
-- 
2.43.0


