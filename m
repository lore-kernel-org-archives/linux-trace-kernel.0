Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E20338DEF
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Mar 2024 10:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710759225; cv=none; b=qclRRliQrlWHDEx9KERfnSIgTx/Crk1Loq6f2GrU9V3T/2T/DOgjGz93v2XOqXrJRykNmz49Aul227+VDcrglAc3bWe622OKQvUiARhWbPxoL9L8sg237dSsBZU+WOStQiRyFYqoS1fiMatH0ygU6vRGeX8nWh+H76FD9Ss6nUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710759225; c=relaxed/simple;
	bh=XhvyBK8RuxD5Aa0izhkt9Ci2OFjxet20Xsv0wYg085w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MWah7g4M06CFjvjfxLJYo5vo7ZPmH4YnSPGo8igGK6ZLScgUq4q5JeLMRaG2h2K6CT5Om9mRPHIo8d3hKNwg0axseORc8gLocG3+e4ShKNy2EQhMEvSPv/ZSkXjBAQ0rtGL34Sx3p58cRxasPpdOYftbdkt/b+5YS7jUpxehG0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com; spf=none smtp.mailfrom=toblux.com; dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b=vxCL4z8Z; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=toblux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=toblux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toblux-com.20230601.gappssmtp.com header.i=@toblux-com.20230601.gappssmtp.com header.b="vxCL4z8Z"
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d48d75ab70so39378801fa.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 Mar 2024 03:53:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=toblux-com.20230601.gappssmtp.com; s=20230601; t=1710759222; x=1711364022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8XqG2x/M+BHVWmsybR9voBPoGJqnviYlltRdmFVnhHg=;
        b=vxCL4z8Zz+RPK08OJfwtsNI69yzftiLXolj3IgDqIZ2adfnMtyp+MRXKdHGcUthY4X
         pJIbOUULQVgQJKVnlGhZBcYueeCx0vrzto0OBZ8S/AWRUbP/q+fteE7IRXHbrR1iUiiS
         wQFVvEhbqrDRFIVD+SKex+MBUsrCxJCKI/iCjgbocz5X0fmslBgsIKetJbH7n2MkJT+q
         8YY3NNUrMmnj3I6mbbyYDytpnpLrDO3DdpemePM++azlnUYlzmWvfTX4kXy8uC+d4BVb
         p1wGpfV+QDlYg5TuMUos/Bf+GPM55g9xDGpFg4eygjOS5TyDECaUeXC7BMdAdyH7E3zA
         7ssA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710759222; x=1711364022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8XqG2x/M+BHVWmsybR9voBPoGJqnviYlltRdmFVnhHg=;
        b=ItBDqmkyGukjX2fOjKwSXYtsxLAtuGvwUdVJO+5bCsJtR2aW2t+QneAOeB5+Q20/Fo
         gusRA+4HiovBQMykBSv/NWVf64j90m/twHYZ2fpKWN2JTZ8mNYYslhAnvEWgS+xv/zng
         xojIUSrIY4np+JtFs8lo1W1cx+YLf7sl1u7ZFl7I5qGMru0U4yEqPn0m3vzLSupudem5
         jicTBon3CeNODdns9IRvK6S1+RgGs9u3xzuxS+nJwG3ilGWT0c5XpCiGpmghMjAOidfh
         0TEtK4TqnFLiONHwj4+wde5EQE2pMUHOXDIkjAN5U8njiJ7/HPb+wZ9dnyUo/xOo6vT9
         Iq3g==
X-Forwarded-Encrypted: i=1; AJvYcCXu5gIPk+UjZkP8zpUZkknbc67eGvQHB++Qt4IleGHNtK9OXssLSQM/pu4loAIRvIHN1k3KlioccjM3C6P0Ezu2xi0GM6tfXVBDo0VI+W9xZ6Bf
X-Gm-Message-State: AOJu0Ywi7mCn3QHzy+3VM3Piov+i/LOZCKegs7T/HgkTnMmIxmLNRtfQ
	Hkee9tiy7rf+pWBme55xD+uR3amgHNHC4O4SZEkSjd9fXlnxtQGYnrJ4vVUlWVc=
X-Google-Smtp-Source: AGHT+IGHB5gHClxTzaPri9vHfioAkOsY7ktzCLS7y8Ff5PRJViyHNbO7xTE9ZiCC4tYmAwqZCG7Rgw==
X-Received: by 2002:a05:6512:28c:b0:513:cadf:ef0c with SMTP id j12-20020a056512028c00b00513cadfef0cmr7852924lfp.18.1710759221771;
        Mon, 18 Mar 2024 03:53:41 -0700 (PDT)
Received: from fedora.fritz.box (aftr-82-135-80-212.dynamic.mnet-online.de. [82.135.80.212])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b004140c161e8dsm4871932wmo.43.2024.03.18.03.53.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Mar 2024 03:53:41 -0700 (PDT)
From: Thorsten Blum <thorsten.blum@toblux.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Thorsten Blum <thorsten.blum@toblux.com>
Subject: [PATCH] tracing: Explicitly cast divisor to fix Coccinelle warning
Date: Mon, 18 Mar 2024 11:52:44 +0100
Message-ID: <20240318105243.117911-2-thorsten.blum@toblux.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly cast the divisor to u32 to fix a Coccinelle/coccicheck warning
reported by do_div.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
---
 kernel/trace/trace_benchmark.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_benchmark.c b/kernel/trace/trace_benchmark.c
index 54d5fa35c90a..218b40050629 100644
--- a/kernel/trace/trace_benchmark.c
+++ b/kernel/trace/trace_benchmark.c
@@ -105,7 +105,7 @@ static void trace_do_benchmark(void)
 		stddev = 0;
 
 	delta = bm_total;
-	do_div(delta, bm_cnt);
+	do_div(delta, (u32)bm_cnt);
 	avg = delta;
 
 	if (stddev > 0) {
-- 
2.44.0

