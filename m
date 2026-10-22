Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792701744;
	b=Ckpk9BEwToWYDw0SDUv44tf20LHjdqJJCngXuYBLkspfbQY1m77pf+jJVsE7UuL351wE
	 nx4XNUN8XdEUGiFNr4hAq9/c3Uc7Rxkpf61WF57k59bBpEB0obLB3iGtZRkWh94eT/u2c
	 huEZxcyFBEGPO5F0S1C/C+PFDpqLO43nbCxlE0fqgBlg8iJChH3WxROwQuPYk8wfKIcPL
	 LVBnILgUdyYwuAQ4kLAph4nWJQifTgiCJRLDNMVKqv7Lu72ELHqMcEwTQlTZjsMiTy1Rr
	 k7FgWNrkHgFk3W9lQdxZ1wEeYIGBs8fl/BmiVVmV3FE5vqIw7kn4YJL83nrMQSWTtqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792701744;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=JhXZAj91SNuMu9he9BgFHy/gIFPKUvXivW06Udy0qjA=;
	b=QNAu6zntCL1DgnX9Dr0V49nWuq5vCRHXwfeO6oik5+QKYXTMTVCMXpCMmTn8yQMjwhk/
	 8/GKnM8J2GBJthZMIjjPqzPj8YWpInSP0EkXrerYOmkk05TslJKngzChisD65AGGH8XsR
	 GX54b/oMV5f8PYD6MCbH9dVVdQj+kgI4NJXU1gSUuoaZVrjfCF0lbxWR1eUCGMPTI9OTu
	 PaTBU+tL8cQ/QRoTM5VEyrzcTQoEVATO6eTI4mOlcLo7gAnp9W+xrqYnViD/QcBTUnHqO
	 w6+Zl3z6yfuChZf76+nvxA8J09LXLjWDWhMUNeNX+Hdon0pD1ynRlyxwB+ZqAno9cMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RXETzTLY;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD709606A319
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 20:42:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD709606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=RXETzTLY
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48b042c0728so59946f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 13:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792701742; x=1793306542; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JhXZAj91SNuMu9he9BgFHy/gIFPKUvXivW06Udy0qjA=;
        b=RXETzTLY07AsvZwWvneX90vtGwd7RsrE4SOu1HSjw+tA9JENKVIDQLmNDoM/bM4ERM
         BxOkfGwg3yiih0LofnWs2eptL9+l7j5ZLPhMK/DLu7zsPRO0wxeeGSdjdfnsnKY1NaBx
         W+sXX/BrmAWrJt+MjLoB9tdSUw8xFALnLMPPbwwajzZU3lO2bAzqp6GMkzOkdkmgwyE+
         fQw/1lcUyG0Vf7REq4AE/xX26rIvudWdTLW8PPFaOZdyM51dFDN3wMVDNk8iQ9qSmGBV
         evxzrbks2K50g7cAm/5qe1bkgmnoJtPXJYSlGPYYMuf5Emd2pyEwxP6PgbDT/qimQUQG
         e2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792701742; x=1793306542;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JhXZAj91SNuMu9he9BgFHy/gIFPKUvXivW06Udy0qjA=;
        b=NjfZISeP+Su7MkliEfFTkwSFqeUCm8mx/8/yLD5NKmt7ucnwOscP0O9XTJN8iDpfqU
         uhFFVOajJjrd8av+sd/u9daRjIiAOLbMKWP+QDAgyY6+v6J6TfPtObgYBzaQS/fPWoCe
         jJRTVHQuHYmkpO9K+a58LIOb0zHI7ceYepT28aZv+ICiAb098K5nEOEnxYeIY26X52Ou
         7PXLQFncu2s2WkQZulNY9vk1OWw75x3w57vbMzpc6YAXIcV0etPPTEBVIAE4WFP6lOF5
         fdg/nc0kypNKKPaNZvBBMnwqE6OGZYiEd1uFouS6UPwOsTRy+7OeguK62ufgYFJ5g7Cw
         3D9w==
X-Forwarded-Encrypted: i=1; AKwUvBzag3wMhbITFFoaGIWGTNMZ77QVIbqpboSgO2T0CJax39nt4M25qkdab332t9mbg63JuW2WoptRAJpzSdNaa9/v+9M=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ4R0IaDneU1hKaB2YNZLCFLzGY0mmFLvQleJw6suqLKkuLLRVU
	2W2c8YxqvSxIeZUHpVzbOW+7sEEMv3EIys7gZWdQVqZA/pJIQXBR2lm055+tcA==
X-Gm-Gg: AYBFou1TAejv6WD38xrUXshHitwwMaP1iXI1dDo8K2ixe5e7ubNWIi8cwgqK8i1tEEN
	D02DfKoLU/hTQ3+jFkdU/BBUZKBNasJSKFFGX8VxBeMNIK6PJtGL8pxbbadVwkLSrYoLspB/mta
	90/l+bL4EuJ2O7A03nqC++T2XySR+62jhfpzquoU5BEcnwwyrRRA/b1VFiIDMVJCkuGSKJJIJKK
	YvzbC7SUoSIX8H0lVs+rwnspaCWb58ArW2fAKgcDBLR1gNXTCmEjNjqS0Pv+p8UbC1muO1pVnCG
	+V1xwg5v+QXOamgt2ikPZKES4DbEirIvE9ovbRt58yXz4kUn3nqjYjEzPajtTqUXCVEI/dyHSa+
	Mxu1pC75UQO1mo/19/uHWhZzyiibNBzqKMQXivJliCJtIpfuQkCjvLYQim0+k2B+LWgrRjZJ1Nl
	oEhhHmpFFJzPts7pRIHI8uOQIhLMIk60/YQDxWW93a4ryXzDqQfIaclAHkt13ubQyd58LnqiFQv
	ROghFowv4/uyy6Bx2ju9ixWMdPPSVK+S9Abvm95TLh94eTKJs3Yhi/Aq/nlHEE5jPvfee2jh0aO
	gvMUcGnd/0+0qwUcmTaEorCRA84R58ZUOVstUmza
X-Received: by 2002:a05:6000:29cc:b0:488:8850:50ec with SMTP id ffacd0b85a97d-48e264d4203mr8976716f8f.46.1792701741736;
        Thu, 22 Oct 2026 13:42:21 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e37edcf9csm476853f8f.4.2026.10.22.13.42.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2026 13:42:21 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	=?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>
Subject: [PATCH] tracing: Define common event fields before enabling boot events
Date: Thu, 22 Oct 2026 21:42:18 +0100
Message-ID: <20261022204218.1222647-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

event_trace_enable() parses trace_event= filters before
event_trace_init_fields() has defined the common and generic fields,
so a filter on common_pid or comm fails and the event stays off until
event_trace_enable_again().

Fixes: 084100a1b579 ("tracing: Parse filter from boot event string")
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 kernel/trace/trace_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index a1ac2a02f4e2..e52351dd0e5e 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -5022,8 +5022,8 @@ void __init trace_event_init(void)
 {
 	event_trace_memsetup();
 	init_ftrace_syscalls();
-	event_trace_enable();
 	event_trace_init_fields();
+	event_trace_enable();
 }
 
 #ifdef CONFIG_EVENT_TRACE_STARTUP_TEST
-- 
2.55.0

