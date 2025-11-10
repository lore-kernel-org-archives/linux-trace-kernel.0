Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39AE2FC88B
	for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 12:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762777099; cv=none; b=P8HPXlsgg0gI6Pq0CIP54co/SW9o210LSfdErKIMavfr8iq2TLpJfchVydjRL4IMqAEiNzL42sbVSUWus6hiIvnyEKJLKwogqdDmA3nHGjd80nRqgQZP+e1q9JxsM0PZA0DPUOgqznMALN8x/FJgre2NZ4/dhk01dogCv69s6MQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762777099; c=relaxed/simple;
	bh=yiAV/fd/N37LsByBzQjNfuQsL1HCbFqYPib3ufTbct8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=K4i4697btpOANQ+jhzxnxxYa+dkIFhBn0h6usgr+AjmfMoONrBFDux9hjD6/CqloZqttN5COPka/k49xm/U7ZdeRc1QSSW6dUnn/lBs8Qa6BfoRA6Q1qQ+OHe9M+H97moGBb2Engaan01BbUKCSYGkFFiaaPVj513rb8xEIBlWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ct+faKxR; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ct+faKxR"
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-298145fe27eso12001925ad.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 10 Nov 2025 04:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762777096; x=1763381896; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3js87s4uRJTX6J5wR1Akhgx1Ub9JhRGdk0bxXqN53yk=;
        b=Ct+faKxRDJuIZwIEukLItMP2Mfn4BESSr9u2UTnHure2YaRykmtcGApHGvaQpLDCUM
         WQUxLJzPOXS2089W+CmFeTvVV3YLtmVZyK9ljWwTPqmQ+ld6ZvtpKpmkmOcEMz8sfVGf
         Y0ropQijuqAt7AShED6pb1vxec3jLLIJ2gjTr7R/f8aXhjJNPg8Z/VjD/DQv0p14GNI0
         yNqATBFUnLHuiRJuboA+cip3kF1z/SV7RLNpTjVG9rYKi7ZJNmyzvL7NcTCfh77XGkO1
         ivcHtymR9SmfdXlkGkkjQrBerKAJt8OJsg1fs24VdkjNJL7PDUPkB1mlApzeLC8SlDHT
         9izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762777096; x=1763381896;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3js87s4uRJTX6J5wR1Akhgx1Ub9JhRGdk0bxXqN53yk=;
        b=CHPRmJQskMB/GnGQyuxc23eao9KYq91VLUNMxVv31AEelTeJJ/W1ekDM6neQ0XsIB8
         wLqs3R8oj5GOr/DnZGnfYNuILZ1oMUn/ya/p82EC378S/estYVcrYUaEYfJRB80VS6ME
         tXAu51tsdKkt4AGkW+3cLlwSY1g1C32d+caAD0ZttAqu+zDuY2iWhN/io7WN7APmXoPz
         vy4yI+w467x9dFp8NJGXkUZ/rV4N4PG58nhIX8ArHGuG8WhsZQjYKtbQL/hNjDmG1DSE
         GVGSk5WV8U7X3rW74XPnr19C1VcoDq9CELAdkaYfxp4r7NIziwYKYjEeGvUhcM8GB3pt
         y9BA==
X-Forwarded-Encrypted: i=1; AJvYcCUrNQN8GmkQULocLV4smw1oBNUP7swQBVmdk9Vx0m0nfDsvd2YwViKnbfRXK4HXQZfhE1EREESiNg7pEVcSJ/n0ozM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZpn0eP5mUwoZS/OMdgr3N2AmjamUYLfWLNxFIcDN2dH5YozGr
	nCtLBJRXYCHj5k3jF6MwWStMI6kHyxUmsPNznfeCvIqEmsOVGoMLj1fO
X-Gm-Gg: ASbGnct2GIYrMvHaOAhnT5FxXa7NdxLlUWLKscTT2/+bToqN8ruhiOWDAvpkWg0ZWZi
	LBCDUqB9nsVsdlSYmtFyjsaumQDCN+pQLqKFmYxK/TU5oEFKuG/wW/IPnhEVRWstwZqUwlE1zGY
	GoLE+yn2HMvRtOehqmfzAGmkAqyosmqojGjM8/0LCr6z+6T98xNI9ZOf2BDPHZerQQzSI0+0vTD
	TALQqJOztVuUgIlIk5dDmKunPjA90v2GmcWcIHpwBlPjYV1koYIP6+gPyFYd3wEvedjyRmpVa49
	CsmVYrv+zEp7tQWGOflrwavSyd2npNhZrTk5kozOkyvUjw37NVACMvqgi9gklRAcjJ5yXG1CBVK
	LsGLZ5GAJak9h2B6/q8J3lL1ncc3SvGLufRGhH1jxgO5kcOz9zAOfp1FWuE8UlZp5RllyzwzimL
	i2wlDsBX+JKmZHhXt1Glq+sQ==
X-Google-Smtp-Source: AGHT+IEPwrYX6YCYhn6Q9zCx3HRfyuBq/4dWxpo0SHeeQsQ3hYDLG1ZkKZZn3/tm4vviI6ZKMPZscA==
X-Received: by 2002:a17:903:1450:b0:298:2cdf:56c8 with SMTP id d9443c01a7336-2982cdf5987mr23147225ad.60.1762777095893;
        Mon, 10 Nov 2025 04:18:15 -0800 (PST)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651c8f2b3sm147271785ad.76.2025.11.10.04.18.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 04:18:15 -0800 (PST)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: rostedt@goodmis.org,
	jolsa@redhat.com
Cc: mhiramat@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH] ftrace: avoid redundant initialization in register_ftrace_direct
Date: Mon, 10 Nov 2025 20:18:08 +0800
Message-ID: <20251110121808.1559240-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.2
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The FTRACE_OPS_FL_INITIALIZED flag is cleared in register_ftrace_direct,
which can make it initialized by ftrace_ops_init() even if it is already
initialized. It seems that there is no big deal here, but let's still fix
it.

Fixes: f64dd4627ec6 ("ftrace: Add multi direct register/unregister interface")
Signed-off-by: Menglong Dong <dongml2@chinatelecom.cn>
---
 kernel/trace/ftrace.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 42bd2ba68a82..efb5ce32298f 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6043,7 +6043,7 @@ int register_ftrace_direct(struct ftrace_ops *ops, unsigned long addr)
 	new_hash = NULL;
 
 	ops->func = call_direct_funcs;
-	ops->flags = MULTI_FLAGS;
+	ops->flags |= MULTI_FLAGS;
 	ops->trampoline = FTRACE_REGS_ADDR;
 	ops->direct_call = addr;
 
-- 
2.51.2

