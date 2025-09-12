Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0981F872D
	for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 11:28:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757676541; cv=none; b=f/EyfLEcLs4CZ9LPqTNe/+LlIWf9lTHAySaSKBTKgWcV5f1M+hzDfsQPmQHlBkvV1TsBL9Jj0IrUdAafXKT+ctNczqKw/SePB+e3pPmVTyWX8bx+7Kek4/mtb3/tQJm3Fl59z2laFi77/dSXhhp2df3TYywW00lZX5xW59V9U7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757676541; c=relaxed/simple;
	bh=GEi4Pu+BiQVVyU3qMyfkPd4FuBQrgtgvLqtdUY8/eKQ=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=nEDT1I2SqpPszlKJ9l+nr882qaZJZQwSgA42gPLj09BFthnO+Io/3ArGHj6Q2n52u74eSWi+cWNT00rZmY8WruAHkJXmdeXe0i8U82epBduX9zGoLH6Xb6UGRqgRB/eieCtWw16XWdOpXRm1ay0339ZfpnMTGmgtgKDvifSDKEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YkOnNN0t; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YkOnNN0t"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso12711475e9.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 12 Sep 2025 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757676538; x=1758281338; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zwVKnR8rFntApp7ZzuwxI7ZqvcEkE867VJlDRhLtWrE=;
        b=YkOnNN0tKCd7dFUxBO6a6OGfcGbvZUvBtanLpBXdR2QKt7UCxNFIPudZ9eszCm7xhx
         3IjxRynPnObsQs0MTKw/1AQhqJjasI61s95+FdIm9vdYHhw0Z8L8PHrWyUPXCSfyR4ss
         wR+0OT0xMHyZvtmG32aOE1Q14ILRm1Q+hFAcOnhD4bKw4x3o2Faegk2SW0mBHXMtyRny
         OOh0b+92gOCc+8055HK1pKQMF1dTrcPeHEDoP3AxCGKZNpN39zb9UUtbUzNQIAaeEPPJ
         2LKMzURZjq4xBTjrmjGO/AMov3eNE2JikehFC2EiCYvaDYcYOITbevyheofk+ZzIe14c
         wETg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757676538; x=1758281338;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zwVKnR8rFntApp7ZzuwxI7ZqvcEkE867VJlDRhLtWrE=;
        b=KKfz6su9wJTrycl192t5XbKyGLKslhJDejzL4H9s4+qb1ewz9OT4TAc6MfAZFravjw
         uW+7xZvqjUbXc23ByAiQl16ARiPBhGsEgUJuGR64ZQb8lYqUU/2y58WiLZZEHJ/aLDfF
         Dmna9XdmrsW6NSnCWj5sRv5f4jbuswMfpVJ1fYquxyKmDI9HG3TxsXsU3cfluHuD9eCf
         ePHi3nUeD7zLieLfVnyIXdZD0kzg0ssTZVHMba8mGXwSuW+3oBJjtdmOVKd+VhzvW6JE
         bi39xWl2rEYvaHthz7ETw3DISMia2f01b2jNZutfLeiJBQ6aT0fBdzfB8EkASq7M2UMV
         HMiw==
X-Forwarded-Encrypted: i=1; AJvYcCUqDYury/KatVYuShUz1CkdN/0Ws5rIZVkl1X9SfC8x3xfe4ppquX5skWOUlJ/0IJauc97yajw04L6LO97rERoIklA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyD/o0UayB9ciHrofKOokH/zHbKiXm5W9wTEcX7DgsjPanfOkHx
	LO1kyr7NKe5dKv6OZdvmRAqnSu1tuzRaJfAWfgWz3vHIy/aqS27ZE5Y=
X-Gm-Gg: ASbGnctO8cpjR2tXR0Gi/ccLgIO8HeOlXrbNhnLB7B8z4jc00NB3KNMN1hhONuC54kA
	ljcbP0sDrW+DlbyqKp8DgJiJNbz5m2BWQATL2mcSJ03BGaQ2d528f4kWRZWVMbXqXUEBnpvpJWA
	V2OwbxJio3CAy+ZoTk+uLE6OLDWjX2xRS5AIrVnPAHiW2eGHd5TLhFMw5pzIMh5ed/pydoFse5w
	T/irLO2Hnu3189W4OubNZskX+Gmlg870SLVtEIjpMNhyr+SSiix2M6NHslZuy8gC7FOigKxR7aD
	JUzDxvqPPpu07w4YP9kvCgi4lQ+6LMWcWZ+j3Bf0p/I3u6+AXg/jvdK+QcHFY/8sBDkAM37gdvQ
	9JbiK9D1do2YJWhW8+XmQ7hQ=
X-Google-Smtp-Source: AGHT+IFO8Zfr+KXGf/gZA9YAUU3Z1l/VSfoJhHCmcp+Qzls93TzCsPrunrvFxGOcxkZ8FeqrxBfgLw==
X-Received: by 2002:a05:600c:4f8b:b0:458:a7fa:211d with SMTP id 5b1f17b1804b1-45f2121ac21mr22734455e9.29.1757676537834;
        Fri, 12 Sep 2025 04:28:57 -0700 (PDT)
Received: from vova-pc ([85.94.110.241])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45e037c3ce5sm59042975e9.16.2025.09.12.04.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Sep 2025 04:28:57 -0700 (PDT)
Date: Fri, 12 Sep 2025 13:28:55 +0200
From: Vladimir Riabchun <ferr.lambarginio@gmail.com>
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v2] ftrace: Fix softlockup in ftrace_module_enable
Message-ID: <aMQD9_lxYmphT-up@vova-pc>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

A soft lockup was observed when loading amdgpu module.
If a module has a lot of tracable functions, multiple calls
to kallsyms_lookup can spend too much time in RCU critical
section and with disabled preemption, causing kernel panic.
This is the same issue that was fixed in
commit d0b24b4e91fc ("ftrace: Prevent RCU stall on PREEMPT_VOLUNTARY
kernels") and commit 42ea22e754ba ("ftrace: Add cond_resched() to
ftrace_graph_set_hash()").

Fix it the same way by adding cond_resched() in ftrace_module_enable.

Signed-off-by: Vladimir Riabchun <ferr.lambarginio@gmail.com>
---
Changes since v1: https://lore.kernel.org/all/aMLPm__QGrQCwz1t@vova-pc/
 - Move cond_resched below within_module check
 - Add some details in commit description

kernel/trace/ftrace.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a69067367c29..42bd2ba68a82 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7535,6 +7535,8 @@ void ftrace_module_enable(struct module *mod)
 		if (!within_module(rec->ip, mod))
 			break;
 
+		cond_resched();
+
 		/* Weak functions should still be ignored */
 		if (!test_for_valid_rec(rec)) {
 			/* Clear all other flags. Should not be enabled anyway */
-- 
2.43.0

