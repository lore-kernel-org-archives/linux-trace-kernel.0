Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795553118;
	b=LnRNqCFnNFrQUJyCx9LhcBZ+3P2BTYR3XtP/kfspa8SGkTRlwfg3QphOvZhGyS5ja22X
	 B7pyhgjSZ6NpK0q1r95xE0WbUAODliGibcq9E8HlyClMdydUtR6LK89cttUlcGl/do4oV
	 CgBb83teNxv9KQYmfj4f0EoHHag824zb059VF78jDa00Zlzn3fNbJ75325QGK8VR/mjc0
	 1XlP1Ilwy/I4Fp0AYZyFbWCrr5fCbarzm3UmxTBv1kDN7E6KO7wEtjCCcF8TRs79JxUHa
	 U9Tk25RTTiYx+oXi6u5xXGY2Z25kanDy9QSiSg1KLEAL0Mksn1gSFQIVYHIVYkGDCzg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795553118;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=ul/eaXDe8p6w/1jXk7D4O5GkkvQEdYd258eHwZDOOIs=;
	b=cA91lgCesor18kv2IYP5PNVSnFqJinYlRZiByjkFuiuY8hbHK/3jw66hoYoMPvGTMA3J
	 jhHZqvGda5TbjeR6ePvQ6m//VNyflub0F7MDyLV36zUU4wAgYImvMCIwS3y729OnZ2YLT
	 V/PXhVPd+qTJXSGUhWz64VLJjmKORdhhYclCGJAVd0GlVIpm5UwFQ6E8grUFIT4kousyH
	 j6St8c1suZM7IyIh8RUsmLiv+BZm2ntbtURV0ib0Ly0+LScPeA0fpdzReZ4HhsNNlHsEu
	 sf1W6wP6hnPrcI2Ww8itF5+iwCvZAPE8Edt0aZ3Gq7OPCxbvsnyP+hFPuk4c6Oy8Lcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BCn08jhD;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1DF606A323
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 20:45:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8D1DF606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BCn08jhD
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4a3e706b5dfso3183342f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 12:45:18 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795553117; cv=none;
        d=google.com; s=arc-20260327;
        b=XfBrXE8t3pFP/Nk9+MR73+DN0Dj9qus3CIoj7UEozPp1WCr6U4B/Eqs7Ka2P918M2y
         e9Iq8Ii4gduEwdcvlXKBvJJiza5Dnka9Qgh2xskiN3NYA1rLPwUcpfsioFi0rR+Lv4XI
         DJ9tEPo0QdNPpAStP9Ozp+Rxdth1UsvRrEauT1WxkM4oHHl+43zGLFuJdvVXIl/HI328
         zkBfooVukDhtXDlCPQtnbCb5lrRgQpOFU1RAT8JKYJTN2yX14vfMF3gUIQyeBnzBktqT
         Db9kTh9au+VjiUv4xTlWJaT/fdkUbsZPjsPPDpUIkguKtznDu2ITTeVy1o5mIjEMkvEZ
         sYvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ul/eaXDe8p6w/1jXk7D4O5GkkvQEdYd258eHwZDOOIs=;
        fh=nfnVO8I6k6gnzmFXUuXmVynt8Z4U9zprvLOz7gX3TcE=;
        b=a+ivMiSKfC7I3L2BuKACZPVe6rEXzBt7IbIV1czhjsh0KxI136815W54JHkUdVbwck
         jijityjHs0vHA3RLWfta15UjqL5yfandJS9zs0Depe3VaBKOjspoFvNegWoCiXcB0zVv
         ir9sefF0kUVO6tTKhb1CxsDE61d5wZF8kY2+Iu4h5Uyw9s176MY4bPkYiXAcim9kpgTp
         AQJ5CR40r0CY5zp7F847XSkeJCofrBgGD9UCtZrw4ZCVNECLP1Mbl011V8jovbRZYnWo
         oPw8JVQllxvtr0ermwLZkL4rDd66KxXQzwQHpTpkuDxTwLfWai1uIaNx30RbHSt2wJrm
         cGNQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795553117; x=1796157917; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ul/eaXDe8p6w/1jXk7D4O5GkkvQEdYd258eHwZDOOIs=;
        b=BCn08jhD6dcYbL56FcmbIIqgSM3gcFwqBKX9r6iUjsIpRs4WjR+nWaRsTDMQXV5nvf
         0kFxr/r4fBMk843u4DR3ThQfMWFDWQXi85yEKZOwQpFqeJFrfokTeb3yGCpaJXJEKRHD
         qi6uzJcqiK1gwuwHOty1ibHtqyAUbAcGoTpb2nvCRwR/qx1ua29ambFTT2LJ67u/1dqp
         jRZtngHp/I4LBrn5n5iV3/TyL6e97093+e4xAL8+WsEQPCH5S7WtTfYO0li5xffoWl8u
         WwKAPyTNxUqObsAl26U8ceWbBAMG1kPhocd05VVev/25Km61QfRwcUIzr/sHXiFfQ/4D
         UiEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795553117; x=1796157917;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ul/eaXDe8p6w/1jXk7D4O5GkkvQEdYd258eHwZDOOIs=;
        b=JYC2uPosSLIzw7U2VcLRsdLdFCxcCALjI5NWMICDcaM44BDtd0sOU5G2JxQU/2EI4R
         uVY4tQxDyaiFsegBWAiC9cXYxk6pishM8XJhzKdSrHKEd1lrMylA7eSGQLuMsFRomyUp
         b/76wWUcbfldIvvwFm58FF4YtT8U0bBLZKRBntjOuUacAyTNU+DObo1vf0IkJ+xPkpIk
         QWhjvRPqE/qtjPKMZvRzbUgf4noFmoomXtf3QrQtW6nYsFweXCJS8dLGFFTfCbRnMGvR
         KM1qYxPm6TTn3owu15pp8pQqsCr1JajcIgDDQllzwhRIqD37N5ZW7eChOeiTqYBP+kpP
         Rdyw==
X-Forwarded-Encrypted: i=1; AL+hErFWT9XW0RsKQtxvYN3onhuij7Do+a3c1dTdMFk9ml8C1MIXbuayyTeuDYAT2CoN8l4u0iD5ivTXLH6QZzLa63ksSTk=@vger.kernel.org
X-Gm-Message-State: APuU4Z9EucVV7p9T4zeDbruwToYkOdQV7MJQPrMLvNslSBSX1hCy35pt
	QelWlIaJX+xjfOuBOpWKdXcgNUMpLnXgG0kyQ4SpngGMhSmNCggNieEkU41LTmR2wkcGRTst9RV
	QB5XAHdeRG8MONijzX0i0YUx0rFgiTTE=
X-Gm-Gg: AZFdTZeF4Yust6zaLmGrAdWHyL3dNJcdgp6rvg5vx/2eN7vsVylU6e4mpkVvgebDNM5
	1/jY8i2wEDsZCHuuijH+llL/WPLA3ImDZePuyGCpfD5+5z41oRmTtRxcnhWX5/sEVR+Sxfe8mFu
	Fs4/Fu0SFKsZD2BXGDuBQYMu6/YBj9EG5hBXEsrdxvuiTYxgiOQJQZ19kQjSSXfT7H1d3a14e6j
	WpH3S424NWHQhNwvdRIbAxHXEaJTjmaj8in4Ks01px/XNVCnfVqiaTwLHfL/KSlwR7t0dhQrTUJ
	Nj+r5IMi5bfcBxJHuLkAIoiHw55PYpggfWi0JNVzJGdw68MflIMaWizePaz2V3bNZEu20CA/K9V
	n9JVa6EqidjnVbsOEy8DdGSxzY/5IDQCrZ7HVzCLQiR6n5Sh81LRCHTLrLTNSoCyNXeKg7fU519
	et5X0Rheesc8CV+6Gzjw==
X-Received: by 2002:a05:6000:188b:b0:4af:e519:ccd7 with SMTP id
 ffacd0b85a97d-4afe519cf33mr19369322f8f.3.1795553116730; Tue, 24 Nov 2026
 12:45:16 -0800 (PST)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261124091252.567037-1-thnkslprpt@gmail.com>
In-Reply-To: <20261124091252.567037-1-thnkslprpt@gmail.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 24 Nov 2026 12:45:05 -0800
X-Gm-Features: Aa3M54oO4ObFmmKWLKbGgp6jmNEjafbKXGnZR5o2jDkMklXDyCwW4aie0WGn2gQ
Message-ID: <CAEf4BzbfJtEfZtzScW4Gy2UM+7fCV2stzNX19T03fYcYN09wPQ@mail.gmail.com>
Subject: Re: [PATCH v2] uprobes: avoid postponing return-probe SRCU lease expiration
To: Avi Weiss <thnkslprpt@gmail.com>
Cc: mhiramat@kernel.org, oleg@redhat.com, peterz@infradead.org, 
	andrii@kernel.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 24, 2026 at 1:13=E2=80=AFAM Avi Weiss <thnkslprpt@gmail.com> wr=
ote:
>
> prepare_uretprobe() reprograms the per-task return-instance timer on ever=
y
> successfully installed return probe. If a traced outer function remains
> active while nested traced calls arrive more frequently than the timeout,
> the shared timer keeps moving forward and the outer instance can hold its
> SRCU read-side lease indefinitely. This delays unrelated synchronous upro=
be
> unregister operations that wait for the same SRCU grace period.
>
> Keep the first pending expiry by arming the per-task timer only when it i=
s
> not pending. prepare_uretprobe() is the only rearming producer for the
> current task's timer. Order return-instance publication before the pendin=
g
> check, and order the timer core's detach before the callback reads the
> return-instance list. These full barriers prevent both sides from missing
> an instance at the expiry boundary.
>
> Fixes: dd1a7567784e ("uprobes: SRCU-protect uretprobe lifetime (with time=
out)")
> Signed-off-by: Avi Weiss <thnkslprpt@gmail.com>
> ---
> v2:
>  - use timer_pending() and add_timer() for the per-task single producer
>  - explain the actual store/load ordering for the full barriers
>
>  kernel/events/uprobes.c | 18 +++++++++++++++++-
>  1 file changed, 17 insertions(+), 1 deletion(-)
>

LGTM

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index caf444762a27..838e0080ae1b 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2052,6 +2052,13 @@ static void ri_timer(struct timer_list *timer)
>          */
>         raw_write_seqcount_begin(&utask->ri_seqcount);
>
> +       /*
> +        * expire_timers() calls detach_timer() before invoking us.
> +        * Order its pending-state store before loading return_instances.
> +        * A publisher that saw the timer pending must be visible here.
> +        */
> +       smp_mb();
> +
>         for_each_ret_instance_rcu(ri, utask->return_instances)
>                 hprobe_expire(&ri->hprobe, false);
>
> @@ -2304,7 +2311,16 @@ static void prepare_uretprobe(struct uprobe *uprob=
e, struct pt_regs *regs,
>         ri->next =3D utask->return_instances;
>         rcu_assign_pointer(utask->return_instances, ri);
>
> -       mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
> +       /*
> +        * Order the return-instance store before timer_pending() loads
> +        * the pending state. Either the callback sees this instance or
> +        * we rearm the timer.
> +        */
> +       smp_mb();
> +       if (!timer_pending(&utask->ri_timer)) {
> +               utask->ri_timer.expires =3D jiffies + RI_TIMER_PERIOD;
> +               add_timer(&utask->ri_timer);
> +       }
>
>         return;
>  free:
>
> base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
