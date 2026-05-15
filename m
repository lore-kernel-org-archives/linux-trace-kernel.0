Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2A4481FBA
	for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778853575; cv=none; b=TXxd4J0a+yj+jioRqvwioZKvCwdclWnXKiUeQPLktr0hnWn4gvWsKyN0imLWu+3RqjxWM2Nu9Y+9e45mXdTQXaZHvbWUgp1MTt50TLu3WXi2dTIj2trbVefDnHVJj6wOai9Gw8S7Va2oozNe7U0whRzChH5aKSXk+bkHm7VnWFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778853575; c=relaxed/simple;
	bh=FkMJTENUW/E8bLe8tbl/GqGiMdpwz+zWAF9iNXXhHYw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N0myOAMd5DR13W12VzOBMkCRHSExpFjguhebFvvLdFrwvgV9tjmaQvjvK3q6Uzm0NSXHAM7MFNuvOsaCtVSn3PHiEAbZtLplKP3tKFPRcZis157PpNeckj1SptOxBy0Z1aWpvq/QlGEc2K4KxmFz3dflLWmMe3tgiQ8OcRKVTxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=Rk1W/PSl; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="Rk1W/PSl"
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-9116861f004so306382685a.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 15 May 2026 06:59:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1778853573; x=1779458373; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=okrIOhQe2ZLHKZjZRr+SV2MUNrdUF09nc7mShRbgYsc=;
        b=Rk1W/PSl/VKPnZvIIni/hzjl5DNB/qI1OHC+atlkdxNc2tLtSzk4lXn4sh325YafaY
         CLq3SjZftmWUfSq/vq2GXJXhCfuK1IV8xYhB9kvhhxGn8Ca7cJ7JHfwfIJ2vDEQe092X
         XPgUQfbAuysTsJEKi3xYWMDEd1tJNE86RI+h1phrOUbpEHUqrBPDAAuGCd1H5hgr4b0z
         7llqo9DDXfrHytPbpJbwY6vA0Tx84mYyOD2kEAQUjw53HVAk2XeACq3CEjXHJL9jfO5G
         TFPtT01Rdm1hEN0ekRqgqajJPK8bkD8ltBd+BdRL9hAfZO5dbao4EcLfxWm690jgXSfk
         NXUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778853573; x=1779458373;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=okrIOhQe2ZLHKZjZRr+SV2MUNrdUF09nc7mShRbgYsc=;
        b=b+yT3OADH0SqtSjAz34Pq+8Siu97pNFyObTRvoZWKG/eKictO1Fzx1Pdhh1f8hinqI
         eT1rCJuxPRkfQSMMUvoRTMdBIPhzVlUdBTPqay+vMEPIFdXZG4a0ZG5v+PFRsAXQDmrB
         pMXNs9+Bfb6M6Q0H8l+x74bAz8tTjhdhhXaODaJBiZMzt3f3Z6d+boXcdeGI+YRzU5E2
         9c3GxLFdxD9sk9LWcQXlt9q7CoaysDq8tezGPWoIYG1KUUD1sFHtWDiDnFDNWE712vRV
         24cnXHNUaI1NU/6BEliMVHvP7WHUSRYKl2ERy8/Z4X7qvcJ3ZhDAQZYmgBh0SLiNlf80
         hmdg==
X-Forwarded-Encrypted: i=1; AFNElJ/4py7dcu9UqE1ynmXhtYrQUJ6//CubaQtQNs3PYjQWcTPGREZ3/8J4SPrMMpAzIkyGfZ/z/HYjFOLk8lgZxpnfyvI=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfnhWmgLQqeuMjb/9ZQn81uO/aLqRvCQF+clGNkqmf8iU0gV8w
	uqH5+rz2xbeozmWUBTHuw+vUuvi5S6dapQ8MykrS2RtXtfY0IGKvaxoNi7Vyf2oQau0=
X-Gm-Gg: Acq92OGxbuI7ikYYCXgzbqpN1AZDYc24ZcEftKfec/5y623yyQj/jcioJRjsWP7EaZH
	moRWKEaxRyTn7NeSIdvydvREUkUFQfNCv3lU5Q3eiKFir7S+bZbh0ERKqWko9EazPi7QaU6e7HK
	QQeUXr9yLV+h6mY4DedJgyvHOFPbbCEoSAM+TXYFJY+OB7fvFN6ad1uK4CFaJPasDqJ4JmNJztF
	spNOnQUzLoYEv55Iov2IVXdEvcX9Jx2hCo9e7aXH/Sv8nvxvahX+7ZLgNI/fkgr++8FpPLtp8U7
	XeaS2m4D+rt98XEppGkocduvIlhPLEozJvjBEVogxB0k/RZk4C9l8YMlI9oTDrz7CZ9+52+FES1
	MPah/CGUAUaT3kh438gLqOCYq88Q6Qn2Z64ovstnLFMWHfs3UOd/W0vKVtsrcBAqN/7juv8tKnb
	gRPxyewSWuCK0mglYzM1qNwlUWXZYP
X-Received: by 2002:a05:620a:44c4:b0:910:3078:5cf6 with SMTP id af79cd13be357-911d02ad04cmr617447785a.44.1778853572241;
        Fri, 15 May 2026 06:59:32 -0700 (PDT)
Received: from vinp2.lan ([2607:fb92:1900:6734:902:ab48:6190:9c1e])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bcf318e4sm535460585a.32.2026.05.15.06.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 06:59:31 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	Steven Rostedt <rostedt@goodmis.org>,
	linux-trace-kernel@vger.kernel.org,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v3 05/11] dma-buf: Use trace_call__##name() at guarded tracepoint call sites
Date: Fri, 15 May 2026 09:59:27 -0400
Message-ID: <20260515135927.2238823-1-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vineeth Pillai <vineeth@bitbyteword.org>

Replace trace_foo() with the new trace_call__foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_call__foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Original v2 series:
https://lore.kernel.org/linux-trace-kernel/20260323160052.17528-1-vineeth@bitbyteword.org/

Parts of the original v2 series have already been merged in mainline.
This patch is being reposted as a follow-up cleanup for the remaining
unmerged pieces.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/dma-buf/dma-fence.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index a2aa82f4eedd..a41cdd9c9343 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -553,7 +553,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 	}
 	if (trace_dma_fence_wait_end_enabled()) {
 		rcu_read_lock();
-		trace_dma_fence_wait_end(fence);
+		trace_call__dma_fence_wait_end(fence);
 		rcu_read_unlock();
 	}
 	return ret;
-- 
2.54.0

