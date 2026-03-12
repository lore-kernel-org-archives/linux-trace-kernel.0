Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA0543CAE67
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 15:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773327959; cv=none; b=gnZDBNL4yONknoiS+e5h7f7X0GfqhgdXh1BEaDyUsDsgkxM/lfq1VZ++Fm8x1Vp3cGOAml2mKGeXma3COl0yQIDJHEwvvyT77Hy4sGymadN9DpaDCkcJLfWK7eytqiM+QKxLuleUE76KrldU4WbA0jLVSolkmuoROW1cYZDB4gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773327959; c=relaxed/simple;
	bh=CsLd9LpjDyThm27pkmlRfJ8mGowBNerp6e/POVZmOvo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gz4jWpp4lzE6wmGoqs3SH/F8sJPagaZ1maYMPpD77vG7TIb3XKWBo0cFDc3W7IMWZzBGtPW6H9KbJOatZiKx/WyQnYbnqzcN+aV1UlyOv0KxPYn5ZSfd7BSp3aP18d6yIc437jZ9BdOMgcltrAswfU8WiaoGFK9omtod6nATcRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org; spf=pass smtp.mailfrom=bitbyteword.org; dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b=av5vlO/h; arc=none smtp.client-ip=209.85.210.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bitbyteword.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bitbyteword.org header.i=@bitbyteword.org header.b="av5vlO/h"
Received: by mail-ot1-f47.google.com with SMTP id 46e09a7af769-7d75ed779bfso1249440a34.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Mar 2026 08:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bitbyteword.org; s=google; t=1773327957; x=1773932757; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=F6q/8hBK1ObEUJJeEuPBlXFpYM8cpAj3EFJgYDsQfdk=;
        b=av5vlO/hWPSnXk3FoQ+G/eerbmozw34hKUXX4oTWuO5fgu//lr9HClDw3VejR4dYLO
         CLMdWp2eNrwkDP4zYNiY72Hr/u8K8FrBBS6gyFi0ML59Xm9JFDZLdaL1TowKB3xsHYjm
         bxI/vzAfLdznTye63FFgHbP5qmOsZ9Ko2qlZ+ckUNC0bVKxYVeTr57NQKGIQQnsr8+9v
         qWQRM3OENO8bmnMpL7s6PzEC5Ou2bym36M9TqUgfBjc6Swiitm1WUXYob89YO2C+e/03
         55FdW5AAW2TPxFnLG5EWM5PnqB9Bm9aTpcU9HkSTPHt41MGn9y006oBRrIh+h99IUH9Y
         6kBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773327957; x=1773932757;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=F6q/8hBK1ObEUJJeEuPBlXFpYM8cpAj3EFJgYDsQfdk=;
        b=cMwv0SliAohYaNbNsyV6FoUs2AMJQvuie9lFa7DINR2PfZj7/Qf41p4u5QJTVSaQ8i
         I7fd6XZr+XI8zHUQmyZNcOLoB9A+cZ1MtRolJYJkQWE4YXnelYtsaIW0GE0Iq9kZlTuX
         HvvBLULdfnrsqE0sJwd9/TVl9AcSAKJmmn63Qyp5svxNIrTuWUULn/4pKG6Q68GlV35S
         RkkLSE4S5rWh/3O4rf0uR4i5FvfJTUcSYjzcUrsdRzRu4K6AqJ5FtngEV58UoByUF9ys
         UaleRW+bUZXUro4Kbk7y8UN0h7tEis6vAa5EMD8a13ija0kbPQNmiJ749fYdxVXDSp3m
         iNMA==
X-Forwarded-Encrypted: i=1; AJvYcCV2jka4dOo2YK5T5FhlXdVjJ432vzRMiQIK7kspLPvdw0ojIUkDO4jzqPpjHjhzPe2mntmsX5ZKpmp04mYyo+2HexE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzTVLxJbmqWuex44To11qyZFSS+uQT0YOSd8RZ2drqVVrWh/IC
	RTmY39jnk0f+tvfANgu/Diy53axeDKybnngjJ3hkJPBbGuddpBxxNxxg29apW4WRKp3sRioMRlc
	/2Kho6T1oMg==
X-Gm-Gg: ATEYQzwEkKZ6mMFpdf33Ob2v7qx9wS4eD2lUDreZGzN8I1dyG1Hf5Hpj5wXMwYL2N9j
	051aDbDkfsnf6KUWSiahftElXYffiRAA5ZA51KdiUWAmOxV//2x9ekPda+kkTUuTTYYaJpbSMNR
	bBzrsMZZW9XfRSqwcJFUJHZzFEqmG1nBvS8ct0y2u8gOU9UD93FjfNBzCUU+jwuLLiJucgp24fI
	8cUh6tz78KtVHjH1Uhk384quCYcqjXAR7dFe8H8YN0Qo7a2i4PobuZ1eMJJn8bdCPJswkteOuGU
	0JCZI88TxAS2xtsm8OkU9Pbdb70Gxs8xN1m5N/ABdi+vdt43vFkm0geahJhU3hGH7CEM2X0hV8L
	q7MOkh03nljrSfLOpt4PWdNh1A0Vq5Lh5HPDqHjuxixDAWkPYO3XLEN7G23eK8L0Frs0su3e8Im
	FFpYqpmWihsFxxwULpoZDws82d1SZ4ga4ABGeFAaUz+gUUVgTK5fwsDzTjTPdjdQ7QO23dP+dDK
	uje
X-Received: by 2002:a05:6830:6a92:b0:7d7:4361:e33a with SMTP id 46e09a7af769-7d76a8da6b6mr4642874a34.30.1773327956799;
        Thu, 12 Mar 2026 08:05:56 -0700 (PDT)
Received: from vinmini.lan (c-73-143-21-186.hsd1.vt.comcast.net. [73.143.21.186])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76aedae57sm4321776a34.28.2026.03.12.08.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 08:05:56 -0700 (PDT)
From: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
To: 
Cc: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH 08/15] dma-buf: Use trace_invoke_##name() at guarded tracepoint call sites
Date: Thu, 12 Mar 2026 11:05:03 -0400
Message-ID: <20260312150523.2054552-9-vineeth@bitbyteword.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312150523.2054552-1-vineeth@bitbyteword.org>
References: <20260312150523.2054552-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace trace_foo() with the new trace_invoke_foo() at sites already
guarded by trace_foo_enabled(), avoiding a redundant
static_branch_unlikely() re-evaluation inside the tracepoint.
trace_invoke_foo() calls the tracepoint callbacks directly without
utilizing the static branch again.

Suggested-by: Steven Rostedt <rostedt@goodmis.org>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Vineeth Pillai (Google) <vineeth@bitbyteword.org>
Assisted-by: Claude:claude-sonnet-4-6
---
 drivers/dma-buf/dma-fence.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/dma-buf/dma-fence.c b/drivers/dma-buf/dma-fence.c
index 35afcfcac5910..8884ad1ff0dab 100644
--- a/drivers/dma-buf/dma-fence.c
+++ b/drivers/dma-buf/dma-fence.c
@@ -535,7 +535,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 
 	if (trace_dma_fence_wait_start_enabled()) {
 		rcu_read_lock();
-		trace_dma_fence_wait_start(fence);
+		trace_invoke_dma_fence_wait_start(fence);
 		rcu_read_unlock();
 	}
 	if (fence->ops->wait)
@@ -544,7 +544,7 @@ dma_fence_wait_timeout(struct dma_fence *fence, bool intr, signed long timeout)
 		ret = dma_fence_default_wait(fence, intr, timeout);
 	if (trace_dma_fence_wait_end_enabled()) {
 		rcu_read_lock();
-		trace_dma_fence_wait_end(fence);
+		trace_invoke_dma_fence_wait_end(fence);
 		rcu_read_unlock();
 	}
 	return ret;
-- 
2.53.0

