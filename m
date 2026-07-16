Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 633BE2F691D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 14:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784212363; cv=none; b=bHFOLMA9C2dliCITnoKwREnq6MtM/zn4wh9cnmIrOXxLKwl01yxMFq6dYjiRbBJWmCECyES7ASzL+4jcYqwLv1cysWT8LHC4CMXyJLoC6vqZzQexOsPS3d4Vnzl8Yrv4N3XGvS4RFTGJXXB5p0qRsbbgZ6H+lxtal18NokMkjuk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784212363; c=relaxed/simple;
	bh=xWFWLM6PPd4BC7Wru9yX1KPMY1C2JYqGrBIy6wgPD4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CuwBZKYK4iQ7ONhpgus4RghCGEpayEJi4sUtsXpeC9D1CIrM1hQE4Ewly5wjvY9GqhehwqC/IR6GysHCw7eIYINXnrVP5G6OJp2hTyewuWrUmqbNQmNLAFpQkbgZQejbX7h+p5zSSqTEh2aUSvsFZgdyJdbA3si+o0crCXwS7n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PoDfzymr; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PoDfzymr"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-493b1710405so37238525e9.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jul 2026 07:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784212359; x=1784817159; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=5f0QojCaRyOlV2E9YXj/J+35e8vJwchULBWmTPvTC48=;
        b=PoDfzymrNyVS8vT6so7/TAir7vfYvC+f7bBdaMPER/kZJE/IU4hOOczJbtmyThB9h5
         Cb+aNKgcsWPP0hlrctQSbaoDgWww3PLW6TVUrfUUM8ejvbK+gTC5Pxjhnhoiyjpd5s19
         P8tT+sXtwDY59GIJaXlIkRnihgXAXotPSe7eXBj1SlAy83cqYUpH55koJmIuxYovduvH
         r26mPsG+gt/Z0CF7t8M0Zirpt7VsZe0IoI53XeiS2B+Ii7JHub1VNOYCOHB05zwVfHYV
         WkwWNDFmYq2eox+7x3CuaMpWkGlG4Jo38HApk2P6mfyo75kbHhpHD6oMpJAvTN8Mrqvz
         gToQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784212359; x=1784817159;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5f0QojCaRyOlV2E9YXj/J+35e8vJwchULBWmTPvTC48=;
        b=RgQSYyva5aOid3WeMUQFGNFd8LXnpS7OdmDNQyV//XnIa5Dffk4Wvodh+Udnj72jHx
         mdSmZTZFKTqDCcxDYPBsauHk+BivnEu0k4uJya5MBEApfoPcCIVLmyP6LUFl85mF0Pdy
         B/6SRquTf8Z0u8+7v1RJTOn888xZacdTrAyAKQVyK0JCq/sfaGqM/L8U4H+WPgJKDyxx
         SpixUXjpSgqMBBvv4SxIcY7TMvVujsX72rOGHbeZeXOUT5xk0B3d06Im0I6fJ7BA6Ymt
         K/tc6EgXjBj9xqA9wOTX5s56FZtKL+Hm4SgLJlAIrGfCcwpcLLedX0Q5hEHRCvYJZULQ
         LXTg==
X-Gm-Message-State: AOJu0YzY+pwfldhJdWxL6WfIzJBRr0prC/mrxtNpiZt9N4Lom9g7gHGz
	88f3pReTd4w+FOKBnGAAbMbyh9S9OI33nmkiFSTx7D3njk2aA+Cf9I7G
X-Gm-Gg: AfdE7ckSpRTGAXfWVtvMDt4wxj83TG8yvkiaDXKjcIW90fZux3DwCsZfm5MT7zbzh4L
	asKoINgDlkqTVh11XPmiZM/1mM5Gn1HDtpwuYw7ojBs3LVZ3lMRv5hRLtSu8kJfjPnSoUARGj6s
	4cJeEguZfuozu6NdT9oJnRbQLs7+Gbor/hROJCn1pjRnLY16wbnrDGR+o+uOID5eVXSR1i0lwWY
	/cBZkHLIFd+jd0cza3ucpH2JgmO6RYZqpOpvSHLjiFS+rTP2KVImxS7GJ9TnrY/Qo1ZP4fJDtoE
	baIiXVryE3ngVBvnhZ16gaaxNTz/hV64sTydu5NIojyxe+hjG1li2EqTWXLIteSrzqj5mOXdfBC
	qgAwFM9b1cWAFrB9O2nfkdgRn6Wa5M8KR4PRzTLu3D3OrpYwK1jI3c5+z3hY1iguNU/0ZlTKP9n
	uiAfpdGu0c5bVOsYNCNWaX3R5n1+BZgpLYQjR+nNM/riOuIptSESVARcMsNg==
X-Received: by 2002:a05:600c:6216:b0:495:4047:7ed2 with SMTP id 5b1f17b1804b1-495404780d3mr58319645e9.32.1784212359319;
        Thu, 16 Jul 2026 07:32:39 -0700 (PDT)
Received: from ptb-02009389.paris.inria.fr (wifi-pro-83-187.paris.inria.fr. [128.93.83.187])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f4634e0e4sm26256307f8f.4.2026.07.16.07.32.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 07:32:38 -0700 (PDT)
From: Ella Ma <alansnape3058@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com
Cc: linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	julia.lawall@inria.fr,
	Ella Ma <alansnape3058@gmail.com>
Subject: [PATCH] tracing: uprobes: Fix incorrect __free function that frees an error value in __trace_uprobe_create()
Date: Thu, 16 Jul 2026 16:31:54 +0200
Message-Id: <20260716143154.1091840-1-alansnape3058@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before applying the __free annotation, the original version goes to
label `fail_address_parse`, and does not call function
`free_trace_uprobe` on pointer `tu`. However, after the change, the
function will be called whenever the function returns. This makes the
error value returned by `alloc_trace_uprobe` get freed.

This patch fixes this issue by adding the check for error value in the
__free function definition.

Found by Clang Static Analyzer (my own development fork
https://github.com/Snape3058/llvm-patch-revision/tree/cleanup).

	warning: Argument to 'kfree()' is a constant address
	(18446744073709551604), which is not memory allocated by
	'malloc()' [unix.Malloc]

Fixes: 8b658df20658 ("tracing: uprobes: Cleanup __trace_uprobe_create() with __free()")
Signed-off-by: Ella Ma <alansnape3058@gmail.com>
---
 kernel/trace/trace_uprobe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index c274346853d1..ccbdc96e5578 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -533,7 +533,7 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
 	return ret;
 }
 
-DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (_T) free_trace_uprobe(_T))
+DEFINE_FREE(free_trace_uprobe, struct trace_uprobe *, if (!IS_ERR_OR_NULL(_T)) free_trace_uprobe(_T))
 
 /*
  * Argument syntax:
-- 
2.34.1

