Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFD00346ACC
	for <linux-trace-kernel@vger.kernel.org>; Sun,  3 May 2026 05:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777785245; cv=pass; b=dOr1qdDkzQaFtfhEax/+0j6HI2lU1CjPfhQT3jwvhvftD8THbUaDVWwDLCOqAEta5ugQBSg1iox2PzGyEGz/R3S/R7dOfG23FnsmT6UG584eyyRszZ4pBZksLLhPwAznk1DrB1g6/3GoO12JjBPnzozrDs9RUJlKE7SC9cG2T6o=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777785245; c=relaxed/simple;
	bh=Bgg6tRIruHZPLNbPdn4Lx9Egym+DaQ0OL37BLC4LLNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=T0WSXRV51397ahJUszyPgKMypR/iXtRX9Bz4i3dybx1UFML3286WiMM++Y7LAqRJxOToTB5p6GYUEeRLKusukVT7ln/StUmCnjZaUN9bsvUZsMOJWpxiR42c8B9lfHPRtPoRPt3y5eHUymzNgMbNLmF23vkokECiafRD900pvQg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n56N02sv; arc=pass smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n56N02sv"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7bd5dde63dbso27306507b3.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 02 May 2026 22:14:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777785242; cv=none;
        d=google.com; s=arc-20240605;
        b=g0zL47qICYV2skpy+QXAMQiKqf3MM0YszK3zYCOrLOaquflGrL6gejmudZrTPeuHTw
         /JYA+WdFTmiwIa02vIgOYw7F9/7KNX5Skgi6Hr06RlvZHb9eHSauCKsZAIVl7ybl53W8
         bdTuepBDNiMSSKqL6DpP1p+BExTpBNjnzQqc63GNft28949+ivkFa6Y/VihvPROzX4lS
         01PreJmI45cwqSdLdcm8A/MxpqffzF6cx0CRoUiwii5b5nOk7jST/W+Vyi/u94HLMmpK
         /9idHa5uIkoz2j+hXbDKLZ9oaQHL+/LDx+SkJxtnqRfi8ocxn0xSkWlhID6RNXvBlbRI
         zR6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=zdcGJAM8jBlmLda8jFwuK8SYIvIOeidaOnoqCWXbNc8=;
        fh=d4chD/Pcgy18Rg+OqswoHMOl3vEjdoEMtpp4ZETKupY=;
        b=lCTGx53mes2EaVA3MDeO42SorHWJCBjlwpFuasAx5RzGHWpYrQLFiXWFwEqgrBPitO
         aVkRnejw4X3AeYV40+ZkqoVNYJXNN00ZS2jI9NzOYefxklwjTURLBVpPLRI7JiI7bTlp
         f+qN7Ec5aiBpg3tgldAo/N9GBX6IwY2OWJ6i7agFTv6jUCz+eLJ856KMOEfMJh2MvQwK
         3Xa2qZScz/UjiMRmIO2lenSxxWAlzu+PUNNhPfmL1XRmCwlKmdbofphE2MAADTKM2uK4
         S+JAvi/wEKHMCGjJ6zk++BL+bn+4957ziAdvNLOy4E8jFQ97g4XrlfYSEKTcwl5p/nF3
         Vf7A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777785242; x=1778390042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zdcGJAM8jBlmLda8jFwuK8SYIvIOeidaOnoqCWXbNc8=;
        b=n56N02svaLVEkuXKSURdyLtwh1ajI7G22Ud1EveZ3FsN+ADYXaGntY1aUlS0EBg2Ul
         aP+/3MWvgA0xksIkv4JcE1QMbOciHc65gYlD0fE0+9F5kHGxWhznefbI1wh5ky/mrr6g
         Gl+uO50aIXhIupcw8Fe9h/AYdEHL3whB3lX2mXlT2/fsLqmr4jA3QgsD/tp219ftMAC3
         WrIUCkmKtsvw/1Ba1gPvS9jIXRROiiN6qYhGjFTY+l3mbArz+toXHGCxFjV8STaLsIIn
         iDSUrYUsMAioBAkHOyJNl2tzoK83ffW1QmYJhtPYngTWRisF21SJChFSHQYNRPvQrcNE
         rgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777785242; x=1778390042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zdcGJAM8jBlmLda8jFwuK8SYIvIOeidaOnoqCWXbNc8=;
        b=El3EGciJ+JNj5Wr/Czw41Lp56npPDE82wi5ICZs5ToKggzAmTsjtE6Lr/XaBjgFifT
         XaZ5548+og0wsH4a4YXADGQhdEvXL6plSqjxPDSKGFQSFNZD9ah3PRuvylMPxMsEjMLB
         wYz9KLWoww8tKctilzExvXkkZJO0j/ujK5fMEYTKHbjjKKMGcgdC9OwTxm8TKZe9J31z
         SVn7ItSMbHkBwIFuXOdDyPkStySuL1nZssUF+5y2YVVca8fvt4iZ7PmovMgKj36jUkYG
         NXQ4763BUtgTISSA2pT8a8o3U98Zd0BYz+J5yQQwoZCg4hDHjL3Vnrg2p5rUONyrMNMU
         mnTA==
X-Forwarded-Encrypted: i=1; AFNElJ+lbXOUbe/kc8Z/4fzKXgpxDyrw8Udf0Gr/lzud6OI2RaXpVmkyM0fhK8RszMcdV1IloXOptoSu50gvyPkj1g6nK7g=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbkIV9Ac2apa93srun8Bowt8Iz9FB4jyocjOLycjj6EbBdCCkx
	5i+RKJ/tNX2XgXjjCpmqeg4xB14BWhOtNCWxjclF/GfE02sp9tBn6Kk+rFqZHOr1E0ZFrqf4koJ
	rBwgVDqEVO1iRZNxNL7PYIfK+YUDMXbs=
X-Gm-Gg: AeBDiesnG0dH2M192zWZPDZXwFehocqRcnJQGn2IkQU1RVw2OWFZ1yHMljsV8SifjGZ
	l0o8eY/CMvJR8M6hmCFIMISy3bAiCv8fLpMG4r+XWCZzaK8DSN2etDHVIMWMfveA1djFfRI7iJ+
	BfJOsZR2N6XG1TbeUbaWzpciHp+SfirkeVoVWK6ykrZeunFT9vZp+dml63esNRdex/fG+/hsUHK
	+f0YLLTb0zsxQASptgbu9JhgfsAOI8g+7TIbqcF0mU/hIxnmDG4w6o2euBMffK5Ye4p6zdWzyyt
	HLG1bDGuMEL0iimriILGpUtfaI6+SrekAz1PTcoR/fH2N2r6s+EJ/2mnEQM8TM/lJxX9miOKkLi
	XzPAGvMzXjrDadh/kzg==
X-Received: by 2002:a05:690c:6d82:b0:7bd:8952:132e with SMTP id
 00721157ae682-7bd89521822mr5806557b3.3.1777785241772; Sat, 02 May 2026
 22:14:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322051838.1137822-1-kartikey406@gmail.com>
In-Reply-To: <20260322051838.1137822-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Sun, 3 May 2026 10:43:50 +0530
X-Gm-Features: AVHnY4Ly-1cUEeK9MYq7ONu9W8AXSkGhiqNuKIo0E-YsZ8okhaz5G4KdNlAZAqs
Message-ID: <CADhLXY6uKPhLHTYysPLnK+sy=ZEq-7hGN2rwbzaoHdHj7LfmGA@mail.gmail.com>
Subject: Re: [PATCH] blktrace: reject buf_size smaller than blk_io_trace
To: axboe@kernel.dk, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, 
	syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 22, 2026 at 10:48=E2=80=AFAM Deepanshu Kartikey
<kartikey406@gmail.com> wrote:
>
> blk_trace_setup() accepts any non-zero buf_size.
> If buf_size < sizeof(struct blk_io_trace), relay_reserve()
> always returns NULL and all trace events are silently dropped.
>
> Reject such values early with -EINVAL.
>
> Reported-by: syzbot+ed8bc247f231c1a48e21@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Ded8bc247f231c1a48e21
> Signed-off-by: Deepanshu Kartikey <Kartikey406@gmail.com>
> ---
>  kernel/trace/blktrace.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
> index 8cd2520b4c99..6cc7d83ed1c2 100644
> --- a/kernel/trace/blktrace.c
> +++ b/kernel/trace/blktrace.c
> @@ -773,7 +773,7 @@ int blk_trace_setup(struct request_queue *q, char *na=
me, dev_t dev,
>         if (ret)
>                 return -EFAULT;
>
> -       if (!buts.buf_size || !buts.buf_nr)
> +       if (buts.buf_size < sizeof(struct blk_io_trace) || !buts.buf_nr)
>                 return -EINVAL;
>
>         buts2 =3D (struct blk_user_trace_setup2) {
> --
> 2.43.0
>

Gentle ping on this patch . Let me know the status of this patch

Thanks
