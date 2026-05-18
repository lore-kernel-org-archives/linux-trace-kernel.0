Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64728481665
	for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 13:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779111112; cv=none; b=e3i8WS2g2TKLiwlcX+P7/PwxAMB+KTrn39SvuVsza8gfz3sh+hyJuvjD4IJLixgcFpiyEdVZTEDOzpkoP9hSheJlB+cne92NxDbU0V0DoD1Gjnr+f4LtwOmOKcZ9xZA4hh6sYB7+cFxkNwZhTK4OFupDQ69jF3Gq0H7ePfsphjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779111112; c=relaxed/simple;
	bh=zZMMxqnny3cHOAYYaD4CNuMlxW/kWQlIMc0SJFkrcrI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oq9xmi1YeS7IbUuWy686b4qXxRRD0rsdtgu8LHNPUHPevKypFoWMLGcaLWzTa4cx2UKQOBhlZKB7p6+ry19V6lB2qTLiDPN1aklV+/FErYjLtumQHsBryWL+dz3+UyJ3bYIaAQ0VGdS+JCVI3wgH92P8qBv6exqyY3Q2SL8cwTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b=PEd+Cxwo; arc=none smtp.client-ip=209.85.160.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20251104.gappssmtp.com header.i=@kernel-dk.20251104.gappssmtp.com header.b="PEd+Cxwo"
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-43ab7bfaa18so382641fac.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 18 May 2026 06:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20251104.gappssmtp.com; s=20251104; t=1779111109; x=1779715909; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IqJ8roRy607EAYQ6vvcN1sGfcnFbnV79s0MYTtuprjg=;
        b=PEd+CxwojKFnxSYAYdk0NFy5VCq1fBhSN3f2T8LTe1ePEqiz1At25mPS50VltoJ0bP
         lcTwa1E4qQAF1DqeYdA630K8nPRBnrCXJT8qWjPZpTnpjGJdaR1EKdUWwW5um5p+y7pb
         U2B/cHoQ1+LVsGoFOu8eXMlzVt88fozYbiNmxFfOs59Q/cpoDWutmQSVvbo3MI13Cuef
         3zTbtWsT1cSePDTzXTpwfvPhcFxszbENRQxXkbfLf0aENS5hx5fnGwgqNXh/fxzmDlYg
         3oYQQaloxWWs01ZggqI1uQjAvmFVykFtwYFtTzd289YGWpt5fv1pXT8ztK6ZSFOP+ney
         1jKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779111109; x=1779715909;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqJ8roRy607EAYQ6vvcN1sGfcnFbnV79s0MYTtuprjg=;
        b=kmypWArDwrzwiPjlHapWNuNn9onpwO5Oel7BO/R6okJ2Z6zkwktsghgrhmlYZsvbxC
         upavFekPua6Gx2mI0gonH39qliOy+LbWp+ORiwJCo+zmW2dRvKKvZYffS50fDIwghD7P
         RHOK+evMDrdh9invIJ1hgZX95VW7AFv+lRfmHM6qGU/UxPNjCJRy9byrDayQQcUERrbk
         AchLPx2DB4XoIW6zeGL9Blp0eOpbekQZUxdpk7SGbnST1o6qMx5sywDxnsUHSHA0kUDu
         UOVVBq5z3lOGIif9nj2MLTGgfW4zJohg8y4z5tGGyDHYSqvAtfaPKqWgKCYlvJ6T1rSQ
         9xKg==
X-Forwarded-Encrypted: i=1; AFNElJ8FSNGtP8Rr37dwWCulId0R0DehmN9cLaCxXGMOW2Rr895o41NUflIIr5V+Xim0eyINnbY9aqIdhgkM4Dl8xfAYDe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4Ny4hdLtjtjP6TVv/1iktHVHX6gZ9+ykLnwkIMR0U9mLgNYs+
	yTd3OW+6pm823nLFsng1H1/oiwU/EooHoBYcafUmLoHko+2v+wEU8LqNuxJN3SkDlZM=
X-Gm-Gg: Acq92OEHnoxYk3baIOiRI9Bz0sfpWdqUW282ZVYKVtpiknY9SRtHel/TeJnsp8UaaQW
	bhrZYbklJpK0zDwUVUgxnk+3xvorgxnnLhE/KwK1Op5QMZWkq0+I2+cxv/rmwnZ1j5+Zpl5UCuL
	KF3b7ftPFBI8N1h4U4VY5xUU8/xnj97HbxMB+W8WJCC3KlvyEB9j2WUEDmHBuhXBU0Qo948H0zr
	eMEYYsct3J60+mRDLE72WRTn/wqcHeJhTS01fwJ0DPphLTdaaocLyWiF8K+8KhoYEnnchJHS2w+
	dXjzdafyP7Dx3pEtIGNgjij2jOLiA9cArnKIP5Mj5M3fFVJ0QjWQG9mr663VWGOr+ToW8kqUxTH
	tehsVfBeOSc98LIiqcHoQ38nUWyAWXZvWSfIFwv4CQEbS4BELGGxFZMyvPOIbygu+kqWw7AKcJs
	gGSKZvfV6QsrfPaCd7FPS2PgvUoq4H8L3hGizyjS75jSZfiXcF9zja338ZvGyK214oTbMM/MiH2
	pFq74TjlQiL+K/V5tI=
X-Received: by 2002:a05:6870:4e8c:b0:42c:b844:a8a4 with SMTP id 586e51a60fabf-43a2da1c5f3mr8755914fac.15.1779111108749;
        Mon, 18 May 2026 06:31:48 -0700 (PDT)
Received: from [192.168.1.102] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-43a946f3b20sm3944430fac.0.2026.05.18.06.31.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 May 2026 06:31:47 -0700 (PDT)
Message-ID: <189ddfd7-f579-4c86-bcfc-334cf574bdfc@kernel.dk>
Date: Mon, 18 May 2026 07:31:45 -0600
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 0/2] blk-mq: introduce tag starvation observability
To: Aaron Tomlin <atomlin@atomlin.com>, rostedt@goodmis.org,
 mhiramat@kernel.org, mathieu.desnoyers@efficios.com
Cc: bvanassche@acm.org, johannes.thumshirn@wdc.com, kch@nvidia.com,
 dlemoal@kernel.org, ritesh.list@gmail.com, loberman@redhat.com,
 neelx@suse.com, sean@ashe.io, mproche@gmail.com, chjohnst@gmail.com,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
References: <20260517213614.350367-1-atomlin@atomlin.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20260517213614.350367-1-atomlin@atomlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 5/17/26 3:36 PM, Aaron Tomlin wrote:
> Hi Jens, Steve, Masami,
> 
> In high-performance storage environments, particularly when utilising RAID
> controllers with shared tag sets (BLK_MQ_F_TAG_HCTX_SHARED), severe latency
> spikes can occur when fast devices are starved of available tags.
> Currently, diagnosing this specific queue contention requires deploying
> dynamic kprobes or inferring sleep states, which lacks a simple,
> out-of-the-box diagnostic path.
> 
> This short series introduces dedicated, low-overhead observability for tag
> exhaustion events in the block layer:
> 
>   - Patch 1 introduces the "block_rq_tag_wait" tracepoint in the tag
>     allocation slow-path to capture precise, event-based starvation.
> 
>   - Patch 2 complements this by exposing "wait_on_hw_tag" and
>     "wait_on_sched_tag" per-CPU counters via debugfs for quick,
>     point-in-time cumulative polling.
> 
> Together, these provide storage engineers with zero-configuration
> mechanisms to definitively identify shared-tag bottlenecks.

Why not just issue the trace points? Then there's close to zero
overhead, rather than needing to need added counters for this, and the
kernel to keep track. If you just issue the get/put tag kind of traces,
then userspace can keep track. That's what blktrace has done for decades
for things like inflight/queue depth accounting.

IOW, seems to me, this could be done with basically zero kernel
additions outside of perhaps a trace point or two.

-- 
Jens Axboe
