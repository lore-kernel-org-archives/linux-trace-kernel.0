Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D26A63EBF23
	for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 08:47:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774946854; cv=pass; b=al7UOaugF/OlrrCrTIWmmZSpbSloRZKagvmS7j88Eh/1mzPxtrCr0KkD0EWGKG1huY/9lUmdsJ0EbISP/G31LH41I1Sw7dptlVIdOalY8l6plriHdRPZqt0412R96Or2dHbxdgNSlEm7rvHH5kdmBguPqcuD1rAErnvZqkGNtmM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774946854; c=relaxed/simple;
	bh=kuNCn6wOxoa1SQOTgaIh18ujsN9G9V2IoPBJSzgxPLs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DJPePQxKPOq7CAhUkCP3zfNYPvOcPSYdYiN2xhtdGx/bXf6wCkqkdrnk6CsUKEOXp/1aPfw71qKYNrihEEblevm6UHQTQci9PP9GDG454k1EOvEhRISwNGLyX5iChvwzMIvrClmBAyye1gCXf/rv7GhzFxOFI5GdNb/MUNw/JTw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ht6npZ4D; arc=pass smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ht6npZ4D"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-650221149e2so2899389d50.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 31 Mar 2026 01:47:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774946851; cv=none;
        d=google.com; s=arc-20240605;
        b=A6kMPpFg071bsLFsT143K/ksU4kWVPJp+iU2b6djmZtffx6SS6w+sbD0Ps/wRZmrKs
         ZRBy+BthloJSVxMF9B8htJaOfEbazv0NPrCPfzb8YeCzH79J1b9VmUk3MWrL5wIzLQWW
         L2WVxq+1xDpx9Kvvpe6R0gTYMDNJg9DXk88745mT4s4T2bj+IyCcPMD5s9K2xLNb4SXY
         4HzEzSESpNjhAeQ5xYtrMGMpaxBZXyWH3X0alwcEM5g+cWaZR2nppObUdkgPb9qw+hTZ
         +bZxaep4u21+Py60Tfm3Zt9grXpnepM3ZZGboCskxmLl5zGD3/G18nGN+UdkuH7+y2ib
         HNcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=sOnUXSfoLr9p4W8JWwSlMQ/IRgYhKp2a6+ozlc4iWLA=;
        fh=3WFSikOsXH7iaahpmjYb+0N8cM29ghA05A2rqlq7wPs=;
        b=TYZcfUBSVbt2nyavnWcomqJ8T0CuYyjqYA4si/iBuqf4OycnQxwOfrTbqA81ZJMUbd
         C8oqQGVChDE9eRRnk8Qtou+GsSjUuxD8N4NfwkMy55ZK+nFD46hVQQaItg6qxYNhg36A
         93Clwcsvy/RRBx9Uv9YAWkVKmY/gy77yetvG1wZqWL72H1nRL4QYM7vTwjGOIj3YU+vV
         sK3l2wnUM0nIHB2JTADlcEBg6SZQSsVzOUF7MaKZ0zZVn8IGXmDxWsMOFGLxD6Dv0QrC
         8MJM9ZRT1ZxMAqbq+QHWcoVRFMl2sZHNRpV3J031zpIoAAEZxPO40BjmSVD3LOxZg/Sg
         673w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774946851; x=1775551651; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sOnUXSfoLr9p4W8JWwSlMQ/IRgYhKp2a6+ozlc4iWLA=;
        b=ht6npZ4DgwZJKiOi44gz46F35QF2fEthsLCzEUAUVAYpoLFPl+cq3NE4Ix4zoTd0OJ
         hT05y5NUuTQzv8Q/TDvphpo7b5lHT/DEsT8Vpsq8VeKWAJnmwa5x4relEaeno3uTYsGr
         dOEU7avYj37yh4Pr3O47asLSngiH+UB9SbFuRw3jfXDycXTYILc+GzDWhq5NsDaCoWX8
         zzbbKdTCFs07IWvyPB6coVICgOcMc0PeSRqxQCsM5WsiXYf2enyYQXnCB8EXwpQMrs+p
         Tw150HZKaez5lfZcFSQZlk0UHO2TG4Llt589wk3WasWmwhImhG59axyxH6tlWNQ18aXN
         v1Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774946851; x=1775551651;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=sOnUXSfoLr9p4W8JWwSlMQ/IRgYhKp2a6+ozlc4iWLA=;
        b=bnA+57bT2U0tYcCCAn0HIujM0OKlgpkGrxeu+lDk7x6GmtsMjlcnpbEPblP/HynlZm
         a3TnenvSeARRyMfHrlLAT6/OzZXxdoL66KQym/j4nOyjLCtFjcnrxaPO7NCJtpJzokec
         /gJQuoFObrKZ74opwCGPpbDxLc0ap1SSYf+72TNZmgMp7OAHT/LkKQOZJnLOHhSgvmp7
         pPRsBAcNtXhC0D07L7HBTOVCGQ0YLfm+JgGn7t20eL1C4P1ZE+baZpHtxHhxKS7Pm1VH
         hmajAJzHpETYTOgQIZKsb+l0oDZfRR/7bia06Rk9toyNqdt4zDrYiGNDEfUZje0ct5YN
         elaQ==
X-Forwarded-Encrypted: i=1; AJvYcCV63dus043sMVyI25l3recRYht98cxJdlH0mN73OmC9bH9UfZ5+e+khMFctHGC0plSh2Apz6pqu3wOgtkKhnTCrbZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxplsFtBHkaKsj3kOSXeiGByMtAxgBRzAY70aga4sl0JstNjq2a
	bKg4JFFmisHr7ZEbZfqYucKx8hlF80rm2s6E4kyPK8AtUKt3GzyWYOAEbe8h40T+hA2MLtoa/15
	oFulpP9lSAZjExf6K5o9B/TQSsVhoh4Y=
X-Gm-Gg: ATEYQzw3AD8e1q0xZaZIr8aAHe/jNqhspdQmf55cNnNTvbYlF/UQlXmUnL7PvZfJfj0
	/SlK2q4KJ6u4XF6YJltrxhg3xYvd9/OgDwHjemHWpm+7JtfoPqf09XtP3iiQsmiJN99pDGxDlKl
	WklSK06/77CeXgN+tw0fBF/aRQqes9Zk/N3puanKs08kYJoBNgnbHEW/1s6yN+5Wv6UIEpCw8f9
	Zc9yriaqpH3Emd9Y+iQXNT5Yx+l/6ZrXjA1q+Ly2O/HUeCfm7bkoQWZAM+jk1nZuw+KwrulWzPo
	FNVrnvnQhH+bqsQtQd5utG7aIuV/1GwNJErWPj9cmnhhyzQ8rOZvOyaRjiyHpRykbQ6bq6xg
X-Received: by 2002:a05:690c:6e83:b0:798:704e:9d7e with SMTP id
 00721157ae682-79bde084586mr145117167b3.52.1774946850880; Tue, 31 Mar 2026
 01:47:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260322051838.1137822-1-kartikey406@gmail.com>
In-Reply-To: <20260322051838.1137822-1-kartikey406@gmail.com>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Tue, 31 Mar 2026 14:17:19 +0530
X-Gm-Features: AQROBzBf8oZ8e-K8DIlKCcMfIXnkjsysbUo_OLg-fzEEorcrxoKDOF6fkk-JJHY
Message-ID: <CADhLXY5_TRgWvA3PwfpoPB=4RiZ3Ujqtcpu8LMDBcU9Rj=roVA@mail.gmail.com>
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

Gentle ping on this patch . Let me know if anything else required

Thanks
