Received: from mail-pg1-f202.google.com (mail-pg1-f202.google.com [209.85.215.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C6F198E91
	for <linux-trace-kernel@vger.kernel.org>; Thu,  8 Jan 2026 00:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767831991; cv=none; b=p3snZtNYrCbEff80L57lHiGBWgSG/d+Afg3CnXjq/tfBEBfse7zLk9K5VR4ZjasudhqDaTNnYS/A5BWhrz3TN5EABtMms+qrEh8tEob7NsUkFLnxjLxrmafviFvEBhvo+MBIOn/y/rNzOyeVWXUS6ZoWkUe/+RtP0W9b/vj0hiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767831991; c=relaxed/simple;
	bh=k3sAb0XeYbzvwvAPQHAnYzp7msyQ9i69ex5WJgAAaXE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=FdYELK0F4jO6HR+4OyVr36USb9/yTtz0ai8p8RTNPu/Bxas+k3J3EWFNjrrW6BRX/pDyMEKEfG+lpzmAWPF/UdtrxbB9Bdg+iMPJjUV9RbNNPuJsalPHsu6Ku26GnLHnYXekyRPw8uMxe+q1i+J8TcaPETDid4zOgSfLBWTca0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=jUeTzKgE; arc=none smtp.client-ip=209.85.215.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--irogers.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jUeTzKgE"
Received: by mail-pg1-f202.google.com with SMTP id 41be03b00d2f7-b6ce1b57b9cso2148139a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 07 Jan 2026 16:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1767831989; x=1768436789; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Rr1Dru9stk8d467rZzPtV2sYPWJ4jerVHwr5PFdH2m0=;
        b=jUeTzKgEOlMr9t6ZdSb+0wB4+GmUMz5CovNfBh4xH6PpEUApx+lEHNR21BAQe4q0th
         yQ3y7/8lipU9OQ8madsPkVGV5TbNnvMjYRRikrcZmXvmazk3ZOW/CKvMTmjujJfSeiid
         cUe2c+lwTYqfNhbm5zBt/CMTBH/MIEFL2JbTnLQRZPIVUMdbcqQ7cmYuAd7ruETnkZh/
         0G2Ubfgp8tUpbQvRfgRMS+YYLHs7nSY8QpFYbFmgRKyPUwmnXbyLf+60jngXOla3cDRK
         wHTNzlpaxv0SL63dGfZ4SFJjAf0Yk45gBAvIr62Uzalqg41NpZULYdjglo0PiDPgXssa
         sptg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767831989; x=1768436789;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rr1Dru9stk8d467rZzPtV2sYPWJ4jerVHwr5PFdH2m0=;
        b=cTrj0VYO6IdCsPqB9+ab0fJ5ncJnueuYiorXj3aVRrzuXSZBGrF65MzlFREFPxGpLG
         ee3D3xEhDjRyIbImevcI0j8GLHpGMisc1UaqmfHDIWr2/8qX7499y/o6mLsjDRH+BqMo
         +isz2uyaIvv9WX/T1Y5SgsbfazHND8yD8lKsWO0d/6GXEocysvga/gb1xk/x/PmuhNt+
         CdzzTQqoBirc0oN7k+0NGFKbzCDjDzY8Pw0MneszXYQJeiJ9g8T9rh/3XWWccXvGQmlW
         sgf+ChVS5kZccfkuUPG4icRPJJ3u4Vo8B0S0nDoZrMNqp94boUJ0LsoFvkmNAmNK5oEZ
         CUYg==
X-Forwarded-Encrypted: i=1; AJvYcCX2vB1Ppc1jAMH2Olt7mLjKc90TuwNxPkqkCLsytgN+4j2EyxSeirwZM2AVSWM7fiZ+3dhW6UAIRSU6k6Fnd/l7uuo=@vger.kernel.org
X-Gm-Message-State: AOJu0YznW40dVvXOSqI7C0m7NnI6Dq/AYLs70h19IDQsvqQdgxo0Ekm6
	T2ji0uUl+6Y3sgOq/p6sBST9iTbknkBEm7MaydahryQe32yAwXgZx1TtHevZtR4O67bIac8xPLz
	mg+MQbWF/7g==
X-Google-Smtp-Source: AGHT+IEsabmtWapDF2dFBzjM6LPsJo7u+kWkYVbY0WmxRJLm/Sg1gYng1Cja4Vn12hdS+0Hrn5kjl0CZU1Mb
X-Received: from pghi13.prod.google.com ([2002:a63:e90d:0:b0:bc4:8a19:36d4])
 (user=irogers job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:3286:b0:37e:4319:d7c8
 with SMTP id adf61e73a8af0-3898f9abb78mr4207216637.75.1767831989425; Wed, 07
 Jan 2026 16:26:29 -0800 (PST)
Date: Wed,  7 Jan 2026 16:26:25 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.351.gbe84eed79e-goog
Message-ID: <20260108002625.333331-1-irogers@google.com>
Subject: [PATCH v2] tracing: Avoid possible signed 64-bit truncation
From: Ian Rogers <irogers@google.com>
To: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Cc: Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"

64-bit truncation to 32-bit can result in the sign of the truncated
value changing. The cmp_mod_entry is used in bsearch and so the
truncation could result in an invalid search order. This would only
happen were the addresses more than 2GB apart and so unlikely, but
let's fix the potentially broken compare anyway.

Signed-off-by: Ian Rogers <irogers@google.com>
---
Reduce the number of checks as suggested-by Steven Rostedt
<rostedt@goodmis.org>.
v1: https://lore.kernel.org/lkml/20251209224024.2322124-1-irogers@google.com/
---
 kernel/trace/trace.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6f2148df14d9..5e2d597b4377 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -6109,10 +6109,10 @@ static int cmp_mod_entry(const void *key, const void *pivot)
 	unsigned long addr = (unsigned long)key;
 	const struct trace_mod_entry *ent = pivot;
 
-	if (addr >= ent[0].mod_addr && addr < ent[1].mod_addr)
-		return 0;
-	else
-		return addr - ent->mod_addr;
+	if (addr < ent[0].mod_addr)
+		return -1;
+
+	return addr >= ent[1].mod_addr;
 }
 
 /**
-- 
2.52.0.351.gbe84eed79e-goog

