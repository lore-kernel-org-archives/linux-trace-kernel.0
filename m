Received: from mail-pf1-f194.google.com (mail-pf1-f194.google.com [209.85.210.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 187A62FF144
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 08:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760517166; cv=none; b=gAsonPwqhAPAk0Ug0HFHr806FlEY3hYOr8EUm+EKDCTlGAm/hLBO/PGh+WEj4bM7DGBUPsWFKhydeEeF4maX5EGrb/teP3qf3N+VKI+67/t3MmbBUAGycQO63mh9gWHYseymF/SJTc0YZ3NKW6uQmOGFDIEwgnGT22n7GI4sSKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760517166; c=relaxed/simple;
	bh=kvAL+9sXIpj3PTIh76IBr6613CVdujv2Xh7EGODtLbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=blXg02+5zxFZBOGpZ5tfLGCo1ycDiEyfQWiJTKZHmcylv4y4rvLtzz6I9kGwUE8XSJieuW5KVozlyhh6GXa7M63yt0Xlaa3bdZeLemC3svCS39UiZJBnxjFEuzqSswcy3FtHicu7OxpGbrZ2vgILjKn7kTLbQyP5XMFFCnbZtNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FntKxp/g; arc=none smtp.client-ip=209.85.210.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FntKxp/g"
Received: by mail-pf1-f194.google.com with SMTP id d2e1a72fcca58-796f9a8a088so5986782b3a.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Oct 2025 01:32:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760517164; x=1761121964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Unis2qMmhyRpJCDJ7RaN7XWgJDSIS/FlvH2xyG99SG0=;
        b=FntKxp/gGF3NefNxDDuFJ2EiS9UzPKiqd4eOiMC9lHxsy+pV15uDoFVjYQM+x9tQTq
         opCHTyfR4e8IaH6yqWyTloWUbGwuzj3E/ZsJ1s94P7NP0l3snm52eQn1UqEXHbwkl9K6
         tdgMxSFjZ92ARgTJ/TH8favI7P4UaVk1uyTsDoPoTwdVxYEU0BlZwYxBjO5j1D2aXKj+
         E7IHjzX/Gj84e3AUS2oy9r91tH63H2UFD20KzMAjM9a3CnuuiKE24fmke++tHj03BJOn
         FI1ySdFBEIboPhDjtMMMYkIVwzKyMj4lh3XiPjVDOvRLlz09vEPmudF1Pz4P7DZYCyed
         zAYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760517164; x=1761121964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Unis2qMmhyRpJCDJ7RaN7XWgJDSIS/FlvH2xyG99SG0=;
        b=m7PPCXYdV8zApnO8m8f33KYK2tDOyn2MpcysYGeub9e0r3moxH3CEWqbBA6RzWLt6U
         SDJPhTraZKPkudI8oYKIKIbtUmjdpyTyXdTDh+NyKa1+/xVMODrLyPnNFbJiJ9batAUl
         190E6F5wCiBDhbm4TOWM2fKL8xg4aI22sfCl2GEwIljCnvn6s97sg5XN6TOwXR1X8xIO
         f8IZMa1gIp/S8RLUGGkz8YXWlvkJ6HBY6UpiTgph+qbqtnz0u+I2AUU6dBHazsaocg5e
         9cfjmkmHwmtwo55+Yt2futNQz2qomLrAFUEywZSEjtT7zDjffo775IiAcN/idEYoEozl
         YHLg==
X-Forwarded-Encrypted: i=1; AJvYcCXAbgGHIcJPW+6CpFARsucjS2cmWZBuP5WdD0pQYmebe/egxr0EzsZgLeBjh2TrATWQZ6EzMuyLoYXrlgxMvsKg+fM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxzieHVoEde6ofrgDt3IZKiGZPoKzQhp9lsJQ647t87z98inx3N
	YvQ6Kbijx54cXTJ6PSHJqodG1l9BziPbvPgoqH0mAdZDJnLmTQZ8ppxk
X-Gm-Gg: ASbGncs0sOkgVxYdDi9Z/hcnZCIXFsXR2Vn/qZRBdgA8z2GWoG5TdoVK0/EKJmijJdd
	TSn2XQCTgIoFLThBxRq0EAr1Axc808Erxg040d8uA1lPzCXKpNuQSHyqHHAyHowcDORAcuvhLe9
	pbDdgGi94WTTHWFzgX0VU2wAOJgIE7ycp1oP83ZeE+33Os5BNtWviXyuuC/eNYRijJoTTbNNGXn
	SKZSL6Xncaffr4pKuXLCnJK0ja5wGEgAiYsUsBHzJcYQWpoT7hLD6L6oBAz72eOCVyTGWsCm4Ex
	aVwVlet3Y2zI6uc0r6veRZOeXgWKFdzrqly9ZvY4JhKMnwayK/++qhEtlEgd7N/f/yheC7RZc6C
	i75rdLVkDi4ipuKRUbmdXEflfErtsqJnY5zf+aLJEtiB7+9OtIRFU
X-Google-Smtp-Source: AGHT+IFrfU5Dg0coLJWp8rp4JqP2mYICgRQA5oJXaWGO4H3aK9sZvSgQGPKaZ1Y+JB/GSbIA6x+KXw==
X-Received: by 2002:a17:903:1a87:b0:26c:2e56:ec27 with SMTP id d9443c01a7336-2902737495amr365673965ad.19.1760517164118;
        Wed, 15 Oct 2025 01:32:44 -0700 (PDT)
Received: from 7950hx ([43.129.244.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29034f35e62sm188932455ad.88.2025.10.15.01.32.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 01:32:43 -0700 (PDT)
From: Menglong Dong <menglong8.dong@gmail.com>
X-Google-Original-From: Menglong Dong <dongml2@chinatelecom.cn>
To: mhiramat@kernel.org
Cc: rostedt@goodmis.org,
	mathieu.desnoyers@efficios.com,
	jiang.biao@linux.dev,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH v4 0/2] tracing: fprobe: optimization for entry only case
Date: Wed, 15 Oct 2025 16:32:36 +0800
Message-ID: <20251015083238.2374294-1-dongml2@chinatelecom.cn>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The first patch is to optimize the fprobe for entry only case.
The second patch is to add testcase for mixed fprobe.

This series base on the "linux-trace" tree and "for-next" branch.

Changes since V3:
* fallback to fgraph if FTRACE_OPS_FL_SAVE_REGS not supported

Changes since V2:
* add some comment to the rcu_read_lock() in fprobe_ftrace_entry() in the
  1st patch

Changes since V1:
* merge the rename of fprobe_entry into one
* add some document for fprobe_fgraph_entry as Masami suggested
* use ftrace_test_recursion_trylock() in fprobe_ftrace_entry()
* add the testcase for mixed fprobe

Menglong Dong (2):
  tracing: fprobe: optimization for entry only case
  lib/test_fprobe: add testcase for mixed fprobe

 kernel/trace/fprobe.c   | 127 ++++++++++++++++++++++++++++++++++++----
 lib/tests/test_fprobe.c |  99 ++++++++++++++++++++++++++++++-
 2 files changed, 214 insertions(+), 12 deletions(-)

-- 
2.51.0

