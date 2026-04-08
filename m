Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71CAA2857C1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  8 Apr 2026 19:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775674935; cv=none; b=RagFPIGz7aK+ICgpuixx1HrDKGQ5+pIRM/YJnJ3t8sMyaetV86fYacxJe5QRMX6NOXJdA2sWcuC4uEuYyqaDDkgQqDuzy8YjGHSeyf5UBetCd5eqPNddZKHlEmtU4M2cPUxqX+G6iCCniFMGuVmVe8DvzyNMYvhXyNKBkEU7KOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775674935; c=relaxed/simple;
	bh=1TRc0F+pxHZ7qBjE9nq3utn2aEfuFmKm3mLNbUw2pr0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=chFh6+ikxBkJjNTql7/ECQ4vVNbR1MDnmN2qCRLfnbduezC2yYnRFi/GvcTudIZLo6yUW4tknvpZQGz/I9lDRzOx2ZV+XB99yLRrK0c+wBrlYnGGJUFZBvkQVHLJ0N05c1ttS0OeVPCW+iQCqx+V+SW2HJ9pOMxd2EpWUk+lGpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXH7cr0J; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXH7cr0J"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so132812a91.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 08 Apr 2026 12:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775674933; x=1776279733; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0nesqW8fDLklcjrRw63qDNiqcszXblDoKfTOnToW0Sg=;
        b=kXH7cr0J0qYWahH1YtFmpoHcxwPb1m6/aIYju/4B0AUIv0yIEDBGqawlfdOey6gUKZ
         5wN4EG6Zw9kSXTcbPJsw4iymyyafceTFf4+bCPcWREOrdmvOhdbusaGuIwh2Al6yCONb
         FHd4rCdt3XAMhWYMrxTf8Cjn8FCGf+hQvIa+4z2sl8LucXTJE8K6L0BkiRh9vD4Ub4sF
         NUVrzKpQoAgVqrU3xMKbU3kuE20fQHa59QRPz0OSylO/NbTgQM8PR84I1wxUlBon+NMX
         9ZYUxeMHF3WXoi4eAh+IiZvzFpE6xhsyA21pdEow9ft0PsbGSja01aoBmA3cyPwHiTo9
         UPIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775674933; x=1776279733;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0nesqW8fDLklcjrRw63qDNiqcszXblDoKfTOnToW0Sg=;
        b=MY3wcaWpUCgj4e46n1PQDf1eGuO9f+G7xrCXBF7Id80WUGeqiBmyWK1JWI1nUuTpzg
         Wv5N68C3zeheiLszE4XP7G6CRnTgdcppIBnnJ2L4w0AQGt/TQSyA56Fw3uATdwQOOI2X
         mgDWN+eqAtbWgyRMtV81GKCizJslk31wcRPc1ub+GhWT3SGy612cXgZ/M+h+zNkiyYSu
         VM/A/9v+fj4VZw7GDImYzddPW7isQpf6xqsrbiitX9t9dPslgEZ4zo8GKZsp+9Amsq7P
         qZ1zzVvLdZSH6d8TfmsDcomaojRb2Kt7NwePH/IP3Gt250ceHmgcVJWPktEaw0Eg6UTv
         2Nsg==
X-Forwarded-Encrypted: i=1; AJvYcCWR+7wxkKi5sYQ9OwIGFbdEK4TUHVNPcJoa13fT7/gOHW0sGMBboJWfNL7WedjcpW/HSyi65Ve5VjcAzFa3hiJ97oE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTY4mx4uEwnilfUBDqetLY39INdGZxIiMt5+NcwzC7oYe/BJOe
	fi6/ICVEhaXRJsmz39iU7Neyrr7/jmFVmydIAD4jihAXUiurEZvgKdJS
X-Gm-Gg: AeBDiesM5AeHR/q75rJgRzTtjJfGSshyJdWYqoLdn3BNG46BNoEQg6NVf7SoD8WG2u6
	LBnK5uAd+C/tWp16QYHZM8zpChv1LTE9a6EJUZ0/a4EDP9YTx+tyuGxO01QtPKiqBCTQg+yFoFF
	U7MofeO//fhUtHopK0Vrr9JF/4KnD0byTALDl8sYb8VPbIAV+eYNKNqOVYgR9YDWLLcxoBRqEDA
	nubXBtGNvIedVfdfEHW6e/HnyVbD0wL/E+cY25V4OmLld7A4SkaPjMZfUQ+0tNINiRhyg+ZMC+2
	JeTV5+bu7P9Iu/TX6Y0yQdcudK8xufXQuUjtlqFTd7OObCsKQX8RmoUgH6GG7ydttTf0xX+fW0H
	cI3dNPSozgqpqq+3DS2x+9kjf6cBr12HWQjjOWL2F7KcS5AnRnxL+fkg4+3hbFL63StLeLd0yom
	RtTIXfZHxnbkTddRMG/EfBjEv88kK82G2zwptPc/cVZ1snST+tQkhhWeyHXTSBdm+Zfdjt8WKkE
	70Tf8s=
X-Received: by 2002:a17:90b:3811:b0:359:1130:1047 with SMTP id 98e67ed59e1d1-35de68ebf53mr22776643a91.17.1775674932556;
        Wed, 08 Apr 2026 12:02:12 -0700 (PDT)
Received: from computer.goose-salary.ts.net ([2a09:bac5:40b2:1a96::2a6:4e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35e34d0d9efsm143630a91.8.2026.04.08.12.02.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2026 12:02:12 -0700 (PDT)
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
Subject: [PATCH bpf-next v5 0/2] Reject sleepable kprobe_multi programs at attach time
Date: Thu,  9 Apr 2026 00:31:35 +0530
Message-ID: <20260408190137.101418-1-varunrmallya@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

These patches fix an issue where sleepable kprobe_multi programs
were allowed to attach, leading to "sleeping function called from invalid
context" splats.

Because kprobe.multi programs run in atomic/RCU context, they cannot
sleep. However, `bpf_kprobe_multi_link_attach()` previously lacked
validation for the `prog->sleepable` flag. This allowed sleepable
helpers, such as `bpf_copy_from_user()`, to be invoked from an invalid
non-sleepable context.

This series addresses the issue by:
1. Rejecting sleepable kprobe_multi programs early in
   `bpf_kprobe_multi_link_attach()` by returning -EINVAL.
2. Adding selftests to explicitly verify that attaching a sleepable
   kprobe_multi program is rejected by the kernel.

P.S: The first of these two commits has been applied to the bpf tree.

Changes:
v1->v2:
- v1: https://lore.kernel.org/bpf/20260401134921.362148-1-varunrmallya@gmail.com/
- Defective selftest added
v2->v3:
- v2: https://lore.kernel.org/bpf/CAP01T74YgnKop-dgwBToOcfg4_D44t1wUBopFYPMquirCmaLfg@mail.gmail.com/
- Selftest separated from change into different commit.
v3->v4:
- v3: https://lore.kernel.org/bpf/20260401191126.440683-1-varunrmallya@gmail.com/
- Selftest moved to test_attach_api_fails.
- Changed attachment symbol to bpf_fentry_test1 for stability.
- Changes suggested by Leon implemented.
v4->v5:
- v4: https://lore.kernel.org/bpf/20260408183549.92990-1-varunrmallya@gmail.com/
- fix the mistake of leaving test_attach_multi_sleepable after changing
  location.

Varun R Mallya (2):
  bpf: Reject sleepable kprobe_multi programs at attach time
  selftests/bpf: Add test to ensure kprobe_multi is not sleepable

 kernel/trace/bpf_trace.c                      |  4 +++
 .../bpf/prog_tests/kprobe_multi_test.c        | 35 ++++++++++++++++++-
 .../bpf/progs/kprobe_multi_sleepable.c        | 25 +++++++++++++
 3 files changed, 63 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/bpf/progs/kprobe_multi_sleepable.c

-- 
2.53.0

