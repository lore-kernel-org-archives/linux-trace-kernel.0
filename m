Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D732352C28
	for <linux-trace-kernel@vger.kernel.org>; Fri,  2 Oct 2026 11:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790940736; cv=none; b=VvBjD3V3YnUM0A3rZZKOEnJ3xK2VK7SU4057RLfYuKa4oIwJ9SWeC8Gv4oIv/crhzK3F7J2r7w1vw7X5imaxQQw/6AjeT0istnMh6jFVLsD0AB62EQquG7W5sk7w746fxc+p2PXN4QoAto6ZgDqYxyjPNenB5/2A57nsvnJcoyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790940736; c=relaxed/simple;
	bh=va3g36bFaY/pzZUpVhZvC3P48VfUDEtaenvTCUQbz9s=;
	h=Content-Type:Date:Message-Id:Cc:Subject:From:To:In-Reply-To:
	 References:MIME-Version; b=IKm3NoYjDI5ug0ZGItM3bEbeJ7SLJNrrF8zsdouYJsFcWBhQvG+p80MRwvbLvae3OsK4EBPfMlGc4YEe6ULwrayvLiW86xEd0GRQNkXVa6mKEjd7lre2VEL1NWw/jBWHitTNuIUJDWjsL7exdYWoVZ9oM7u1nKVDM6Yq8ZtrfAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y+9a3QJZ; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y+9a3QJZ"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dacf053eeso3911854a91.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 02 Oct 2026 04:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790940734; x=1791545534; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=HvBpVNuycHAAZEO2rCOJ/byw3aw5hAHgX9ZZeb5bA0I=;
        b=Y+9a3QJZ29MjSxC9Na9pfI3/TgY8o86MZQmoOe91g4RX5hbostjGCVxuFppttVV9u4
         nZiMh7KfXn4pBnJURQPsrAYGMeR0i6+3zfVTWS8noXVfTidmNodzYCcHxHITsZSBlAFb
         lCYOmGOgrp7e3aam3gEhbyY4SnHfuPWB1EcWknNJmT5BaJY4ZmLnfpP0HOePQhg2XZYO
         OVJMx+aWjuyEXRLDSmu/h28d1Ip0xcy7GBYwGSQaU53CwIWaKfSH/HVz9jT6DuR44PcD
         3ALBrH+sBTiiIl9u5nPu7dBxlphMTJM0rtp8QqA8TUeS55lzAVZC81Mi7wRamyMHWnYy
         waeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790940734; x=1791545534;
        h=mime-version:content-transfer-encoding:references:in-reply-to:to
         :from:subject:cc:message-id:date:content-type:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=HvBpVNuycHAAZEO2rCOJ/byw3aw5hAHgX9ZZeb5bA0I=;
        b=euJ1C2pN+9zjiWFEG6zRStXb5mzzdLnyZI/XuTNHbtL9ygeN/3FD9VtA/wr/TLGKh4
         3wqJ6Z9axajpt/v5ywqaNNxDs1rqnShwKbKVDBwnxKm4Nsu4z/fvldND14USd7s344xJ
         EdMB69RBXNnFTWVWWDrWoNxLNQNFxy7OUc5DHErpUTUicA68qzWU6Sbo7PqpgCmHR+xG
         9PTdc+ZG3rEGWa0AVrGYfVtsxVkbPz0Bt0dNRgEzjdZ5qXxiMl3kFnK8jKXCM/L99zcm
         Dlvj3EjiZmdEY6RHTwSiOf1ciwPV60V12qbyc96kea8SbhvoYVs+zQ7v6VtAK2FldZl0
         Zojg==
X-Forwarded-Encrypted: i=1; AKwUvBxlPnvGVRzqcqkWTeBmdAkDTyIILYMD+r1qyVeIYmBgSsZ5kcBhqKoRXKq9cHVshTPfm2CB7L2b6tAenL90tRdyOYA=@vger.kernel.org
X-Gm-Message-State: AFq9FYKG7fHfAX/Y8411NlsEx71JjJPuVKQBybk7SSsPHfiKcvzf5Msa
	2v1aqwieWYr3+MrqlXe0H2ToDRHdZIpMZt5EgOXEU5w2OyUUCygIYDua
X-Gm-Gg: AYBFou0PQ9mBJWTseKxFrx85iDDIL86Hqbm6KrXufhTvxw8HnvrFtbG//lTn8s2O5Jb
	zC4OillF+nvaLwuVJ/9XLjzsTRRIY0xramFkeQGAaHNS1ywSRlk4iTedLHnFJCmP9K3fu7N9JqP
	ZEp5b+UuQrvqDvCL+4n80rG40vOAln6Mx8/OM4VACLjUQk0JLzUiTRW4TD/pvPSix95wg13LpMB
	cirURERCPSxZRgKI2qRVx7yy4MDUL2Yf/nDWB1hifebdiYdOZ9dSGP50i5G+tcPhaVTDfy6vfUl
	H5OR5lZDFN08bl8mnKBKiJPKoZP5Ff2RHTm1/fbPXKsLfKMZi9+RWGVp/NisGUO83WLDtoaaFKQ
	laG7acRKBxGCqnFYHyZTnXmq0excUEuJ+umMZmCod02j/O0F5WhAQfxrmQcj7UbuRm8Dy07rEQG
	XfLwC0XYTyNkAS9CTyyLOgtHyBUV+/Q0oXdzuZXWRguSndR9GaAB4uY5R/KG3lMoH6AHPT6jTgJ
	vybWl6TJFRFFsUHzQwdEWeeGkMJ5M3MTj1Vtnd/aJhgpDea2ammXkgDm0lc7IFD1curEJvV6aTs
	4a9i
X-Received: by 2002:a17:90b:4a10:b0:3a0:9640:802c with SMTP id 98e67ed59e1d1-3a6f910f530mr659274a91.3.1790940734296;
        Fri, 02 Oct 2026 04:32:14 -0700 (PDT)
Received: from localhost ([153.61.198.255])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a6dd456214sm1143301a91.4.2026.10.02.04.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Oct 2026 04:32:13 -0700 (PDT)
Content-Type: text/plain; charset=UTF-8
Date: Fri, 02 Oct 2026 11:32:13 +0000
Message-Id: <DLUBI6OS1J07.Z498VKY5084C@gmail.com>
Cc: <yonghong.song@linux.dev>, <andrii@kernel.org>, <eddyz87@gmail.com>,
 <memxor@gmail.com>, <martin.lau@linux.dev>, <song@kernel.org>,
 <jolsa@kernel.org>, <ihor.solodrai@linux.dev>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>, "Yuan
 Chen" <chenyuan@kylinos.cn>
Subject: Re: [PATCH] bpf: Claim the per-CPU send_signal irq_work before
 filling it
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <chenyuan_fl@163.com>, <daniel@iogearbox.net>, <bpf@vger.kernel.org>
In-Reply-To: <20260928081144.207908-1-chenyuan_fl@163.com>
References: <20260928081144.207908-1-chenyuan_fl@163.com>
X-Mailer: mkdraft (claude review draft; edit before sending)
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, Sep 28, 2026 at 04:11 PM chenyuan_fl@163.com <chenyuan_fl@163.com> wrote:
> irq_work_is_busy() cannot see the per-CPU send_signal_work while
> it is being filled: the check only matches after irq_work_queue()
> has claimed the work. An NMI interrupting the fill therefore passes
> it, both callers race for the same irq_work, and the loser's signal
> is silently lost along with its task reference while the queued
> work runs with a mix of both callers' fields.

kprobe, tracepoint and perf_event progs exclude each other on a cpu
via bpf_prog_active, so one of the two progs has to be raw_tp or fentry.
And since commit 87c544108b61 ("bpf: Send signals asynchronously if
!preemptible") this path runs with irqs enabled too, so hard irq
can do the same. Not only NMI.
Pls describe it in the commit log.
Did you reproduce it or was it found by code inspection?

>  struct send_signal_irq_work {
>  	struct irq_work irq_work;
> +	/* Covers the fill-to-run span which irq_work_is_busy() cannot see. */
> +	atomic_t claimed;
>  	struct task_struct *task;

can work->task be the claim ?
cmpxchg(&work->task, NULL, task) instead of irq_work_is_busy() and
set it back to NULL at the end of do_bpf_send_signal().
Then no need for extra field.

> -		irq_work_queue(&work->irq_work);
> +		if (unlikely(!irq_work_queue(&work->irq_work))) {
> +			/* Unreachable while the claim is held. */
> +			put_task_struct(task);
> +			atomic_set_release(&work->claimed, 0);
> +			return -EBUSY;
> +		}

Drop this hunk. It's dead code.
irq_work_queue() fails only when IRQ_WORK_PENDING is set.
irq_work_single() clears it before calling do_bpf_send_signal()
and the claim is released at the end of it.
bpf_mmap_unlock_mm() doesn't check it either after
commit fa9dcacdcdf4 ("bpf: Fix mmap_lock leak in irq_work path").

Pls tag the respin as [PATCH v2 bpf-next].

pw-bot: cr
