Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B7913B9937
	for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 14:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778596882; cv=pass; b=rv7Esn4wlGoa1BE5mQtzyfHzECglebEY3FkoiIossgLgVOSYq3Tvdi214k3jlHIN4ZKmzdGcp3b/DuR5zLmnALHrBu2BI52i2QY+afAj6CssDDfqrQjEhzcMXe4njQKC2qA+mZ70FWsaX2gzLia7X7dBOunOTQ78Ok4aGf9BRWI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778596882; c=relaxed/simple;
	bh=/kK+SYFZbQfHlHtJQt+GnZtvnbVIaEjZEeKgf6iU3Qg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GhUOtHjrgv9lGe81RL5RsGQX3MC4fiFcUbgIzmpD7ygMZEDQd7rXAmqfsSLqGM3ltYsK9MjxMFlYB/9WAPov3IzvLGaxKTwpMvIf9d5VVpTfYBWQI2NWpQl7KYZQ+DUXvQM/Ady+2UdSJOqNrcfTyH2a3H0S2YKGOly1CMncjKY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aQDVXSYo; arc=pass smtp.client-ip=209.85.128.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aQDVXSYo"
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-7bf0b47d2f1so53397897b3.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 12 May 2026 07:41:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778596880; cv=none;
        d=google.com; s=arc-20240605;
        b=Euku4LqnmuUphrl/VTqgbAAkYfUlX3aH0qgutVEPhudG3gcrfWQXH3MptcHA+FDmsA
         Zxo3I+3750egfB5HFre855FzQaSFCjtGrCmzeiowpQJRHXPpuNiSAtnvsLSzgGVPUudN
         l1FAoVpx4ul/LqIAbdMXjPoJtCGVDS/VzcG1UyOQkSnoKXD/8J9dIUAQuiCyqDkVrsEn
         fcI68ORfGz1HN12fR4ZoAak81Imoj2eFpZvlRKrpKtUl+lPlv0M/H+y5W1gxuTEkb1IW
         3AwfDdotzmTA6f4Qa+Bnsx+Y5pEMwojGGEXu8hbL2w272FQEZad9RSyGGs2mKZKaOQ+a
         d3TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xoAjv0/amh7zysOWyF7MD3lX+XAQWWCeEONUYmHrIv4=;
        fh=LUsMICiHQoP0S9gLg0GzSTUPYNdDcv9DQ4kCWkeHijI=;
        b=YWDn2d8/5lWcaB9cys8Gw4BSOG9JJBdO8F5uUbt7q/oAWcVT0iTTkAny5ASdC7BphR
         FXiHY8mZR5jsXEP9o0oI/I9DGlHvIsm5rlEuSgszqVUsUBMxQFRapXTayCQBr8oPl5+e
         l63V+fjcWiqJVWsI0cdXTSsm9NWatXVwSmqX6CFyPErHt1AHwaxcGL9JLMaV2w1T7vQL
         I0t/xSzqJrWmskHZm/0J7uxC4tEyz1hewfjKOvFdnqRlNvoE/BiEozJNRg3xmQPxzR6z
         esLb0ZCPR6ys5SeGzH+EpPy01AmgtfVv2rDtyJ8D0AMenO5yatrjHpb2qDjyuaW83pj8
         HGZw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778596880; x=1779201680; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xoAjv0/amh7zysOWyF7MD3lX+XAQWWCeEONUYmHrIv4=;
        b=aQDVXSYosoa10TIFClxw8c4iWvYA/S3aMS2yqpvaLGVwuDkT912cLgtconTLWmdfSH
         8+wQOiyU+M5d2OsC4rm9MmoMBzTtKUhm1xScDbiGlfFljmLciACn/gtD2VHGJh4sC8IJ
         vebsni/0Dj1+tA6aFOf3LoOR00d9utZNzaOpUdKe4WVlV4ggmahwo/sFp1kNf5gj3pGT
         DeaQG/lKS1WH+3T9BQ7sdqOHUIpVqPPBcdpo6Ac8b4IGuewY9Yj5MShdRw9HJ6TAK+yo
         fjyeFeDGq3UYoZMbS53f6VpvtcL0cbMYYk+Tg1+UCxILLMhqK2F6SnZY0Tg3xLLN/+So
         nNqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778596880; x=1779201680;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xoAjv0/amh7zysOWyF7MD3lX+XAQWWCeEONUYmHrIv4=;
        b=V4VdpyeEzf4GMFKBSPq4kbyTLb2Gzo6U3o4//xktqvhLbN1ykdZ/P1yzezSfCNLglZ
         LNC4fmZvv+KZy4MquMZUJEXyWnBBKiSmD7k/CeyFfg/TEQNLNIVZLOA8wByDs5A3SMxW
         4gJuY2lCuz6mzXYANIpbozTjDeWIXhXVHg+7HxeFaLV4THp7747IsgWS5/hrYGx++02/
         AOPXlmI4gq0H12i+rfSFm7oAPYsg0y3wG3l0QA0k/BW8G67B29tXjBDzNcrgcgniwfjB
         yV6uc9Yy6WaZ7oYoG1KhRb4MYmMEgZv9+GZt8iFIwBFX4BfcIOgeqwz+He0VImebm2RA
         IzWw==
X-Forwarded-Encrypted: i=1; AFNElJ8ok59qUz91BtGBj8RDS7uIvA9x2P0s1nk9ad1oMkPVXr3oSEaMlSrYjdXw+tBs1NTGINQMrBI8UJAp5LQIkM5fJwI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwU581u05O5agvg76wagdiols5PpFomAh4SODiWKvVGyH3r01//
	eF3aAX91K39KLoifsiYfqItfZN/4gFViPV12g+BHFYYgoF8VXCgfUR6tx28hcLJD1ck8YlFdn+e
	9Urc5EISOBtxwJWMBTcXwA6YdbpCpx7Q=
X-Gm-Gg: Acq92OE1+4RMkDvZBVYqMmxFxDrzfG2tbgcEXiRibdiT103NkbOK7t2nxQIe1GwuTo4
	WwbE8hcIVapKf/ZO7yeCLnuSD7kDxK9o5A+ojcdhwk5SXEQCsOyfTC3bXhxwTt9DVeBHz2Z1xPk
	gZFAX8VIhKsOdsmVd1kPaJuFXI31e0gZ7hXxCfP0waUXTpRsJekGtqwlW9E5YMQkKeopqCE/QDb
	GMQaMhYsBCnrO4vieCt/bzt9+XG+/Z1OkVcDuRHevFWDQq/Hu5LXHwp7O6gw+m2lLmQtIp6w7J3
	wm7Aw7A=
X-Received: by 2002:a05:690c:10c:b0:79a:b440:5c77 with SMTP id
 00721157ae682-7bfb7ae2271mr182286317b3.17.1778596880470; Tue, 12 May 2026
 07:41:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260502174741.39636-1-yashsuthar983@gmail.com>
In-Reply-To: <20260502174741.39636-1-yashsuthar983@gmail.com>
From: Yash Suthar <yashsuthar983@gmail.com>
Date: Tue, 12 May 2026 20:11:08 +0530
X-Gm-Features: AVHnY4JQ3BGdJkA1rgbYKRY3xQMcepGCrkagKT_buLh_54zcQP-6QhlEL00oZC4
Message-ID: <CAPfzD4kiEMFdbK36X1_f1+Vn=v3nfvUODZJuJ40sNJ_fRr9zKA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Switch trace_recursion_record.c code over to use guard()
To: rostedt@goodmis.org
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	skhan@linuxfoundation.org, me@brighamcampbell.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Gentle ping.

Sincerely,
Yash Suthar

On Sat, May 2, 2026 at 11:17=E2=80=AFPM Yash Suthar <yashsuthar983@gmail.co=
m> wrote:
>
> Switch mutex_lock()/mutex_unlock() to guard().
> also drop the ret local variable and return directly.
>
> Signed-off-by: Yash Suthar <yashsuthar983@gmail.com>
> ---
>  kernel/trace/trace_recursion_record.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/kernel/trace/trace_recursion_record.c b/kernel/trace/trace_r=
ecursion_record.c
> index 784fe1fbb866..bac4bc844ccd 100644
> --- a/kernel/trace/trace_recursion_record.c
> +++ b/kernel/trace/trace_recursion_record.c
> @@ -180,9 +180,8 @@ static const struct seq_operations recursed_function_=
seq_ops =3D {
>
>  static int recursed_function_open(struct inode *inode, struct file *file=
)
>  {
> -       int ret =3D 0;
> +       guard(mutex)(&recursed_function_lock);
>
> -       mutex_lock(&recursed_function_lock);
>         /* If this file was opened for write, then erase contents */
>         if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC)) {
>                 /* disable updating records */
> @@ -194,10 +193,9 @@ static int recursed_function_open(struct inode *inod=
e, struct file *file)
>                 atomic_set(&nr_records, 0);
>         }
>         if (file->f_mode & FMODE_READ)
> -               ret =3D seq_open(file, &recursed_function_seq_ops);
> -       mutex_unlock(&recursed_function_lock);
> +               return seq_open(file, &recursed_function_seq_ops);
>
> -       return ret;
> +       return 0;
>  }
>
>  static ssize_t recursed_function_write(struct file *file,
> --
> 2.43.0
>
