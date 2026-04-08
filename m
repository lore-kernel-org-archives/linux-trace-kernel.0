Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1A4135C1B5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 19:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674940; cv=none; b=cOeXTrwFiG7ahRuar8192UmIZXKHKePa6tEGelW61/K+NiQ5ulgWhKPR+LKB+d/5Fu3bcPTbwv/laIsA5zulsG7DmBCkL4UUpjjtn6ksDNSxWW6BHRuaJPFAdLjRyPrQcQznCl2l5BscSAZ1/63VQ72rmfFkFUhjSXHYvEsCU9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674940; c=relaxed/simple;
	bh=VdFKMNT5L/KA3XzmFwN0Fhycm4d6g0VlevgEnt/1Rz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=o9pLBRz5ceNtfYbBh4CaPK5jaA9iOyHkakACl3e+u4Y2Jyo5iSD2JP70b7xjN4TqzF7z6mRajk/SQzwO4X7OYBoLxZ3I0etul39XgkmokBVelnkgMnGNUgfy8n2kwrqIiSnaMOWhXxW0256Q3j0SCnkFLeNk+GxEqpTsykzdkiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJCUpkEU; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJCUpkEU"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-35d96be7c13so82054a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 12:02:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674939; x=1776279739; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=auGuTYgvSyaul+AIxfXecK4Li8tZkkMpaNVTbE1iobg=;
        b=KJCUpkEUXLavTfEXdGu8UcW9AjH2FuYU9D0O70J0g39i9QOMQaLCfF5+JnZHbajGYC
         hipwoHo2JXgLUOhPSjwfBr71a82vzbDUu1ftqFdjATr0quPNvh7LQyAsU75cmG12xGan
         CneJhmTGbUPnjAHHzsfN0a/hFDogOXADcSlP7d3xuaReh2qr2CS/Zvx+2Miev8qJPUrk
         VNgStMU/hhBQyP1uEo3OUtBXkuOaoH9Pv07ucYPKX0dEnhZApgW8M/bfZSaXg6gl910a
         l8OESx6MXsGUIxA3oRYPpD9dPlZa0pfkPE/D94PLhxXKqRcVZWMVmjJVOPWoqt5y/dna
         ukIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674939; x=1776279739;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=auGuTYgvSyaul+AIxfXecK4Li8tZkkMpaNVTbE1iobg=;
        b=MEo+1IedqAyTQUoZ4ksjVT/OeMdn9XlN+j5YFkcYt+t43VoA94Sq2NAQmiMG/AESZ6
         GGqiWPaOBwbdVax0ZDCqqWxDZraP5Sy7ThxXjzygMdP2eliTmmuoz9qWwdspD3mEmVcj
         AuhWBAX9S3mxzBVS2bSjlxym5W+rwpNCjqoy2nxmAB5R68przdbMQ+PG8mM2k1iFPme+
         8OKeEZyEXnNfGNRWipq7534ey5kfhiMuP+WKfivQNFSZuECQoObWay5lHISU49H9c1cx
         UQHQuviB3poADKDPube511pn7CBziG8cWdO4JtqG5P1ztj7q5RULg5rcTFKcWmYTa76q
         IS3w==
X-Forwarded-Encrypted: i=1; AJvYcCW1jMZj/EjMh9ISDGoiW7X6pjuvcAM44NwBNjw+m10B20nP0lBVCojAz6NvVz4scXdwk3HW54EgaKZabOdSEY48JRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPhoiFK6bt69kwOUtZ/KcRQsh7tIbsoRSZfFVdzokcSE7HDTeD
	7FX6QIpGQa9Lv9jrUBSG+46TDWlSuDSKxMcCbP033C/SUnX1pShy1U8P
X-Gm-Gg: AeBDietDP9jUDRotlbHcolWRRiReQQLVY6O8NgR3X16rDBC2YWMXLxHpanEcKOrEu2d
	mzljfdW6CQHXHJMCpwdIotrg7ksCjL8bLUXKrvYklYHupTutDWSM2O//n7RlLA8Eo+PSNwCWYI+
	yIg/5vS5Ub5/kYZFuCmc706L2MA9RUZqa5VWIp3KNXjLIOHPt0c4mzC4AV0+hJzewbZTeh7xl4H
	j9X4WXmATN7w0k4MFJmP9Ign1UHJlzpMr/H7laeXgezfESFShLcJLb8hfekJnFppg9FFi1L8K7K
	qefQnQCiXW5rdDKBhTUyQbPH3zPAkNg2Lat68WF69EOm8VXlbi1JBKb4QJ9lyxPE6HQu+yGDswI
	0klPLm1A5pW8TxAbHAiCtsmBX6ACjsUrRKqfkgrvz48XCh9HjbzL2CSiR71i7H/UmZBC87tlbAx
	F0QBL4Kdu2jR0JJbvU7jGXRDW8TNoy2+6UrD3zIP3yaIURDxxtqJOcmNYLCaF9UhimNwegdvZQ6
	NA++l4=
X-Received: by 2002:a17:90b:3e81:b0:359:8df1:8553 with SMTP id 98e67ed59e1d1-35e3542917bmr500387a91.9.1775674938847;
        Wed, 08 Apr 2026 12:02:18 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34d0d9efsm143630a91.8.2026.04.08.12.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 12:02:18 -0700 (PDT)
From: Varun R Mallya <varunrmallya@gmail.com>
To: bpf@vger.kernel.org,
	leon.hwang@linux.dev,
	memxor@gmail.com,
	jolsa@kernel.org
Cc: ast@kernel.org,
	daniel@iogearbox.net,
	yonghong.song@linux.dev,
	rostedt@goodmis.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	varunrmallya@gmail.com
Subject: [PATCH bpf-next v5 1/2] bpf: Reject sleepable kprobe_multi programs at attach time
Date: Thu,  9 Apr 2026 00:31:36 +0530
Message-ID: <20260408190137.101418-2-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408190137.101418-1-varunrmallya@gmail.com>
References: <20260408190137.101418-1-varunrmallya@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

kprobe.multi programs run in atomic/RCU context and cannot sleep.
However, bpf_kprobe_multi_link_attach() did not validate whether the
program being attached had the sleepable flag set, allowing sleepable
helpers such as bpf_copy_from_user() to be invoked from a non-sleepable
context.

This causes a "sleeping function called from invalid context" splat:

  BUG: sleeping function called from invalid context at ./include/linux/uaccess.h:169
  in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1787, name: sudo
  preempt_count: 1, expected: 0
  RCU nest depth: 2, expected: 0

Fix this by rejecting sleepable programs early in
bpf_kprobe_multi_link_attach(), before any further processing.

Fixes: 0dcac2725406 ("bpf: Add multi kprobe link")
Signed-off-by: Varun R Mallya <varunrmallya@gmail.com>
Acked-by: Kumar Kartikeya Dwivedi <memxor@gmail.com>
Acked-by: Leon Hwang <leon.hwang@linux.dev>
Acked-by: Jiri Olsa <jolsa@kernel.org>

---
 kernel/trace/bpf_trace.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/trace/bpf_trace.c b/kernel/trace/bpf_trace.c
index 0b040a417442..af7079aa0f36 100644
--- a/kernel/trace/bpf_trace.c
+++ b/kernel/trace/bpf_trace.c
@@ -2752,6 +2752,10 @@ int bpf_kprobe_multi_link_attach(const union bpf_attr *attr, struct bpf_prog *pr
 	if (!is_kprobe_multi(prog))
 		return -EINVAL;
 
+	/* kprobe_multi is not allowed to be sleepable. */
+	if (prog->sleepable)
+		return -EINVAL;
+
 	/* Writing to context is not allowed for kprobes. */
 	if (prog->aux->kprobe_write_ctx)
 		return -EINVAL;
-- 
2.53.0

