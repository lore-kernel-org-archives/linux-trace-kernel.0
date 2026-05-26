Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A2E3C5DC5
	for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 16:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779813433; cv=none; b=tLpibg9MHUeU0j1EADUpNMPfUIYqq6xkjbNKxmT9CyLACa2j+k1xvQXFA54jEklsmjgPob5caLaViT5UT7GNGsCyd7a5WgDISVuD4qRWmrhkI10lmqPJI164XuJSBfW1o1/Rr9l1fZRh1doyn/aXY8A4U1WAWloK43sHqdYbliQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779813433; c=relaxed/simple;
	bh=k7m3TShuDxcI1i40xO14T3m0hb0f1G2Z9ivDSnAllCY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QbWbl8zl/kZcC5pq3JG6dPiNm8JSijBXxRaEbJZ9pjfmvBvKNmz46x9nKJGHIaznjih0FULwS2S909y9s2nVTDVaMq2bcSNGB3+mXdADrww2uIpJCfdV6cX/eBMKhdBYypVv9G4Dk9VRWWBFxbRhWB7k1wBhIAWl1R5TiZ78s18=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=vU7TohBN; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="vU7TohBN"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-439c3768d56so4673280fac.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 26 May 2026 09:37:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779813430; x=1780418230; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vjWmpAZyQXAr6Dn33RGAFX5IxZ9Y2+mFnV5iI0sKiIg=;
        b=vU7TohBN9O6hqZeKb6RBvP8/+iNdQXbm6QfeeslBvIFp/lJYsZjJ+03mfv8ZVKUzxM
         wrzMfg26dXCjGJgpKUEuqyapjLUu3xZSBoMCGgOOebMgVSiLecC688XPU3YDRHU6q6EF
         Uq2+oCBpuIRPlFBxWcpC+XEE/dhHm3jdvR6G+1j0CIGUlIWDXFoVCfNhliNxSNgH+lCI
         kVuxcpN6BoO4l0xj/F0LIu01kd3UnjOuACjw23piNUBg11+oCU4Sn8c15KKfkw7+qseV
         YixxVyx/qZ3MYg9DuaxUbmAhed3bI5QIbc50jCk/gLWu9LopVypm6kgLG5HvYXQEygWE
         hCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779813430; x=1780418230;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vjWmpAZyQXAr6Dn33RGAFX5IxZ9Y2+mFnV5iI0sKiIg=;
        b=mjT0lnFBCKUlDwo7JKK6Vf9hU5hLOnnzC+MPXQl3Oi5rdIKRbxzcoOO2nFAnqUMdGt
         O0YUeWrpeYExQyr8l0e4rjf5jy0dvLJ03BPMx53N+InqOEdSxkI+B3XaqvMdw3VkdxnQ
         g6G6+3cXxXqIjXz/OHjnTfriK68aUUbAjF7+w+bNezDq5RfIKmMmcY3pnwPN/goeH0QU
         xeaInsjhtkFxyvDx+tv1EF5ly3EaR5FgwnfG45uA+MEGFc09G5ZWRPJt71wNiUWYTPai
         CVWz9gmwHpSri6RZLOzSf4MK4Lq8r108HuKGjYzbaI+Y00d+gEJnrPKTVJwIXZ9lki2A
         H6xQ==
X-Forwarded-Encrypted: i=1; AFNElJ+x/DHPJXKYHLN2jLjyEYc6UZfuPLlX7fm+c26jLYlVmHYb3jVawQX6FPeH8XJBB8WUJutDVQwYvvtEB1gVRCn7TBw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxATWt5qDk2O5dZzxbiqzz2CsiBhdVRU1EMIhMk8eOUKRR06kj1
	xxPAn7S7GFZyUZmUBpbkIHRxG6N7E0DmL/38wGImSRHaMSUeMpLkdrxyiiVdg2R0i3s=
X-Gm-Gg: Acq92OHBqo+/Sspdf7lWJHjur+FsfRGM8l+5+oyQzHIfMniHYPk/y8gpoJHsOmKmsmh
	wDcqjadD9moY4CRGSCMcOJ0AeVLU5ELZGHhzzqa7cj7GawbXvOlV2vY6vqcEEUyzkNu90vaZcgV
	mEp/jtP+uxSDW9Oi0KTkxJeroEiGO1A1kSV3/zCCBgXuuwOPnMzuyJt3F08YEopCLX1yXQM1QvW
	9QkHoSmyl1aXxjLd7lLma465Ea6siiW8lhRC1RctPumtdmU1wWVozKciByzIuiQiQG8VzthoT+F
	Z+IEgnbI5hRy3bucPvK2dNaVcsBpR+AbD3xxE8Hg6eIwRRt1/HGaySs8j7IY6daIlokHnd92rKa
	Ty2nPiykBtfYtHakOtsTIm4QNpDe66qt94x6KKZ8lzzKQ/VUihDgDuV8Z6mVnTtHgRt2a3nI6Rg
	ZbIAV4A+0dy1C5VlSmogjfBzeTJjL0eB9a0qi+9TyQVyiDfDhzaBCb9jONVtGTstKtbVhsIZ7xw
	Hbg6IoX825QBQ==
X-Received: by 2002:a05:6870:4595:b0:42c:f89:7555 with SMTP id 586e51a60fabf-43b5aa4a3bemr12861346fac.11.1779813430300;
        Tue, 26 May 2026 09:37:10 -0700 (PDT)
Received: from [127.0.0.1] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43b639fd7adsm13561265fac.14.2026.05.26.09.37.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 09:37:03 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: rostedt@goodmis.org, mhiramat@kernel.org, 
 mathieu.desnoyers@efficios.com, Aaron Tomlin <atomlin@atomlin.com>
Cc: bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com, 
 dlemoal@kernel.org, ritesh.list@gmail.com, john.g.garry@oracle.com, 
 loberman@redhat.com, neelx@suse.com, sean@ashe.io, mproche@gmail.com, 
 chjohnst@gmail.com, linux-block@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260525005123.722277-1-atomlin@atomlin.com>
References: <20260525005123.722277-1-atomlin@atomlin.com>
Subject: Re: [PATCH v9] blk-mq: add tracepoint block_rq_tag_wait
Message-Id: <177981342289.464267.13862280829247173081.b4-ty@b4>
Date: Tue, 26 May 2026 10:37:02 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2


On Sun, 24 May 2026 20:51:23 -0400, Aaron Tomlin wrote:
> In high-performance storage environments, particularly when utilising
> RAID controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe
> latency spikes can occur when fast devices (SSDs) are starved of hardware
> tags when sharing the same blk_mq_tag_set.
> 
> Currently, diagnosing this specific hardware queue contention is
> difficult. When a CPU thread exhausts the tag pool, blk_mq_get_tag()
> forces the current thread to block uninterruptible via io_schedule().
> While this can be inferred via sched:sched_switch or dynamically
> traced by attaching a kprobe to blk_mq_mark_tag_wait(), there is no
> dedicated, out-of-the-box observability for this event.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: add tracepoint block_rq_tag_wait
      commit: 9ece10778f8931630f86e802f94dc71115de0c8c

Best regards,
-- 
Jens Axboe



