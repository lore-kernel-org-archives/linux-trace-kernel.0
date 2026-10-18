Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA2C36CDF2
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 03:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792295427; cv=none; b=BERsMxkMzRKkiOg6D4/+/UmpbV2sWZeHLzUlEPx7Us7WbNs0C6FuAXSy7kG0su07KI+9FmIqnLju5S1lzeZ2Igs7Do2jfftGXAIkzCinSCsRxlk17oe2vmtwhTh+80JseCb0D/023G+cOLtvrK9EGPXexyQGvlTCUp1TFsTxwjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792295427; c=relaxed/simple;
	bh=ij8L3BD2pEttCYLuoGimsHWdqjy9b52xZ9+cpHTq7sY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 Content-Type:MIME-Version; b=YDQCfGMHVq9EirSKcWZCrhfYH/qd+PM09qmBFsB/Ifxr9Proabg4kDs2UzGzZ1p8NKAUeN8RmifCb7t+i5EwFP5G9QhjAsp63yDlfCM0z4e7D2FnZik8ZapEKmBE/zOZ9/Lweuo40L+n2tRWqP2kQ9BXBc3eqaUCKkrhehSdmN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bdcSV6ay; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bdcSV6ay"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3ab9268d90eso659489a91.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 17 Oct 2026 20:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792295426; x=1792900226; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ij8L3BD2pEttCYLuoGimsHWdqjy9b52xZ9+cpHTq7sY=;
        b=bdcSV6ay399XPcoRCwePT+ocLanf1EiK9ladARqJsxZX3gqyOwUUHb96ijoXrAx1Iu
         6C7UhTDxP7coR00AsdSjEJcYwNflCgc/Q7kDZAHjdeG8pOkk/9ypJVpgz5g9JQR6IUAk
         eaRbiI0HlRnAMSDnZNILupVSFqbt7Yrr1+RTe/Lq6aB+ucrkT9+COI0nfgmsQfxp6M5K
         UVD3/8ExR6ZHco8bX67EFrZBvLMz+6ZJYwkcZsmsspmGBbXNLLkTWIeNgmBuIK0ZKSLW
         9NoIXVH3BR9WQTyWAFvPYOWTBphzCANzGXi4SPqPHV/2SvsyKHAxFVbWSiXDvtELO8CV
         wb0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792295426; x=1792900226;
        h=mime-version:content-transfer-encoding:content-type:message-id:date
         :references:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ij8L3BD2pEttCYLuoGimsHWdqjy9b52xZ9+cpHTq7sY=;
        b=BK9MMf/9Ud3CLtDDhAUJS9mnJblSRFJ8nYqDLtNWO6VraL+rRaX/jNoCA9JZUDJYPY
         ny0hDW5IczU9TGKByDSTJBUzd6gsfJ0uGxvnUoTwGNAB/OzI2MHuAWjG1/boXGw5bt0p
         y34pLdD80p9KJBqpzqVz3nKH9+DoqiRZ4igG0F/l+whgOub19KnB5oVlWkI78uKNFnff
         ms4IZPm4YqOjsYEJaX/LZjs9dM6MWm0Qs79AmecUjm6nJB50JFIkn0zQqHvUs0mkxZGS
         Mfh11gugM4lphnzn/4dVEY93rHXC/asbOX86rq0kLz2QU9+YW0KKiNLwVxF4fU4LKWA7
         LsXA==
X-Gm-Message-State: AFq9FYK+xqjV+cQiPlZa7vEvKtz58gEd+BEe24pQsscdNeq6EM4mOrFw
	EYxlYvlBGXY3WTvD1EdSQWjTcySAODi4JkV/xIwn9QjcXzjWcksLVRxFBalf92Zw
X-Gm-Gg: AYBFou1keAdp/nGobfJ5rUoKwPa0SLaWdEZpZ56RAdcf5PHjbiHdzK7vOp05mYd6AE7
	WDKbSG8iQq1LH2lbZ633i5lLQOBfNyBjH+GGYevT/rVwrvVlFJhDjsQZxV4idr+XOX6Sj2n4vK9
	Dc1TrTZn7bz9WSbWDFcfaLsyhFGEzTXvBiX18qLHoSSfbsFQLLVIEfYo+K1mOf36oZLbGy9VrL/
	aUVqw5tkQ5o1x/ji7CPfzGmw/jX9YFK7sFXEdyN0Ir4Tx1bf7HWuMd7ste/UJ20gjR8pZKOA7b9
	Hy7Nz9/wrV+dKIjlANh6asGcZFEq1weLtFEqiuiwVbuBRq8EnL4ecHTRQzKWQCMIlVIjjQ4Ny2T
	HetahmS6DRImI7lkz1WE40lGU/cjkY7nGM0ZND2dSrXxS5F5cufUdPXP1cCpydpqgk4F1bVIhXJ
	rMjdP1m/IlJIRA2Va7KH9d5eE/yco1J4G5ttrcRX5WlNFAI2s2YGcnB+0my5r3X9THZw==
X-Received: by 2002:a17:90b:57c3:b0:3ac:8ee5:e007 with SMTP id 98e67ed59e1d1-3aceec24801mr3186137a91.20.1792295425562;
        Sat, 17 Oct 2026 20:50:25 -0700 (PDT)
Received: from localhost ([183.242.161.82])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3acc4991b8asm10357333a91.16.2026.10.17.20.50.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2026 20:50:24 -0700 (PDT)
From: Chaosheng Qu <chaosheng.qu.linux@gmail.com>
To: linux-trace-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Tomas Glozar <tglozar@redhat.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] rtla: add tests for tracefs instance cleanup
In-Reply-To: <sashiko-outbox-175505@kernel.org>
References: <20261017122359.402696-1-chaosheng.qu.linux@gmail.com>
 <sashiko-outbox-175505@kernel.org>
Date: Sun, 18 Oct 2026 11:50:20 +0800
Message-ID: <179229542008.41291.4713973899027586435@gmail.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Thanks, the four points split into test-harness bugs and one test premise
that I over-claimed. The series is fixed locally; details below.

1. SKIP was swallowed

cleanup.t now emits a TAP "# SKIP" line when the helper logs SKIP, instead
of reporting a plain "ok". The helper also treats a missing tracefs, a
non-writable tracefs, or a missing CONFIG_OSNOISE_TRACER as SKIP rather
than a failure.

2. SIGINT race and leaked process

The repeated-interrupt case now waits for the tracefs instance to appear
before sending SIGINT, and verifies that it disappears after each run. The
SIGINT case also reaps the background rtla when the instance never
appeared. The helper is run under the suite timeout, so a stuck wait cannot
hang forever.

I also added SIGTERM to set_signals()/unset_signals() in common.c. Before
this, rtla only handled SIGINT and SIGALRM, so SIGTERM left the instance
behind. The test now checks that path instead of recording it as a known
issue.

3. Missing exit-code checks / action case

The self-timeout case now requires exit 0, and the action case requires exit
2 (the mismatched-action result). The action case uses -S, the stop-total
threshold, and skips if that threshold was not crossed. An idle machine may
not generate a sample above 1 us; that is a property of the workload, not a
cleanup result.

4. Unused TIMEOUT / reset_osnoise / dead code

run_cleanup_cases() now calls reset_osnoise and uses $TIMEOUT. The unused
check_instances_absent() helper is gone.

The series is based on 2f2f7eeef8b0a1a9b9ca998231419873ccae8d4e and is
commit 455d304ece2a938d0148a908c83f1774d4dbf298. I ran bash -n and
checkpatch.pl locally. The host has no writable tracefs, so the suite
reports SKIP here rather than a real pass.

The patch is attached.

Thanks,
Chaosheng
