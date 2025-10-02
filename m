Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0394B2F3C10
	for <linux-trace-kernel@vger.kernel.org>; Thu,  2 Oct 2025 10:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759399239; cv=none; b=IFRFt2JNFVzZFkNxi+5vsF6L0bbqPlgwWELyEZNXezyMVlmv/W2MepZE3ZHUt/h1u/9dNmAzmIa0PtJIIuCWHeRYSmPpM2LH1JjyK+u54qJer9uY2EVdODQlhtDbbf7ih4LjTW76yeIwFqRh+28veRZ5hAMjF7j9Vr/5lfyrafU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759399239; c=relaxed/simple;
	bh=kvBtZ5H0yMb1sHBkzmafyNsm72le/pCF3bDpS4vPEkI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BPZn+UeOfgeExcNACAk8FkotA7Yzzav466792L4VAApbGTngil6RdB9qdddKGgRRkMGLzh+m3ntMDOm5Vrq9j6G2rG7VPzXVYJV8yzPCuR9MUY3HnxWnnHHVlrZdpQDj95oi8ydlZvurJO6f37U8N+qtmPxWySDm0HMhVRlp3uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H8UCpdFs; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H8UCpdFs"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-749399349ddso11611317b3.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 02 Oct 2025 03:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759399236; x=1760004036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ggd4i7mZ/t/cf8PkCM63gkDCoT9fe+zu6ukHr28sMTA=;
        b=H8UCpdFsvnVnh0xww0trcddlM7QbbxyywG6LqOeWlMMi3EzfLWTIMiwnmRjtdN8i/O
         kABnFj/hVN0PwCcCOBdb3XVe1dduEcX6p7i4HxDO5cze09pR0yI0titTCTgyliqE9f4K
         RTzQ9AGfV0PzBxG1qisajk8d5+UQAwPRRCsi0es1aBnBEP2O8oJrhYf2gOBrrcuMcgaJ
         rSCOfxiPGYB8obpKUjBzBC0kUzCZVLF60x7oENOIQyfrZDh7aZbQMhr7oEwBKIPPvYf+
         t13bWPFX39/tIvuE7+LkWxGzwaiE1c9KS8LNUYcBvrnjCA6YJSJbnaZ9+w+EtxXp0aXV
         UbBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759399236; x=1760004036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ggd4i7mZ/t/cf8PkCM63gkDCoT9fe+zu6ukHr28sMTA=;
        b=EcH28+/h6IUgHDID5cTRajieXhO8Jg2EpnQweAwyAfRuFRUIQ0XUbhMl1LU5Acgi2P
         /509DrC20/JEhPYVNjH90pM0drtrfNWuc2Y1Jfjpk1GFKriApz1TAOFJrtiv6+tP5t2M
         c4NIA9Nhong/OqU2obHGppfgMm6zx9iSjNHBpvAtObGhj4vhhZET4JXfFtkpVQeHMGFJ
         xgiGh4273TkTpSKDv/IJGZ2s5I4yl4rD9Xl34HSDCuqXO/JAOo1Hgg+KuTJBPHmHcP3c
         xSALQWxtkpZoSubG1VjarWAJXTNGYE1yTdEAXwoij71KBulZnJ+UhhSZoly3ih+QS+Ei
         r15Q==
X-Forwarded-Encrypted: i=1; AJvYcCWEUmRDKFc+l3gYzXLeeUQ6Eg1t0nn/2S36FIbcdzysyOzUG6OJ/sk2mXPEILHfKx9oxH45QK/wQ6dAqYW4ZBmwhm0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0Dt/PEJiLazf0PDsNSfZ631CC9RU/irQ0LdmEAvPyTLi1Vm8l
	eL8BxGeg6/UR9y4bN+DBZReq4rH+EUKyAV4yPLPldNu8w8WARXZVUfjpx9+Dd1kzFqLrFemSWlR
	/fmaoYGyOBpunVQTvKuSgLn0gCIuaG3c=
X-Gm-Gg: ASbGncsW25xcDePhV2icQphqAnwlN13q+5VhM7vO+wRmJRaHmkHNfCmEa99Zg9bBcXj
	GTLoNwbJ+q+qAD5XBtkMvJcw1bkaHTxMxx5nS/ScE0qgPpSX/+MR6L4R1g2fge7ji59iGL4aKu5
	6TrheQ4oSFwxPmJcSdbAVfGUq2+CdtN16tNyeFZ2Ry6Fm6wUUvbDIHqRPLi+LQUcoKVW1T8nQ9+
	LPNoZomSS0LXSIi5DbfX2OKS8W7leg=
X-Google-Smtp-Source: AGHT+IGPjmDa+p+JXkYrK4U7Drro29gMSq+s0PLirIthnlMC8Nj4y2IUGNweizhJltL5z8aWjl8za6dOxfIgKduP+Zc=
X-Received: by 2002:a53:b789:0:b0:636:fd5:ed02 with SMTP id
 956f58d0204a3-63b6ff67009mr6288246d50.45.1759399235643; Thu, 02 Oct 2025
 03:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <175939434403.3665022.13030530757238556332.stgit@mhiramat.tok.corp.google.com>
In-Reply-To: <175939434403.3665022.13030530757238556332.stgit@mhiramat.tok.corp.google.com>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Thu, 2 Oct 2025 18:00:24 +0800
X-Gm-Features: AS18NWBjYLUQRhHxBX7o9MqHB-Y5s8B_5X81UFNPqNMaPI9zxkO2nfjXdBQVtng
Message-ID: <CADxym3Yvxs_Z6a1-EPziz79SBRsYHcaOH-CtvUhngYy3bJ71iA@mail.gmail.com>
Subject: Re: [PATCH] tracing: fprobe: Fix to init fprobe_ip_table earlier
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	oliver.sang@intel.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 2, 2025 at 4:39=E2=80=AFPM Masami Hiramatsu (Google)
<mhiramat@kernel.org> wrote:
>
> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> Since the fprobe_ip_table is used from module unloading in
> the failure path of load_module(), it must be initialized in
> the earlier timing than late_initcall(). Unless that, the
> fprobe_module_callback() will use an uninitialized spinlock of
> fprobe_ip_table.
>
> Initialize fprobe_ip_table in core_initcall which is the same
> timing as ftrace.
>
> Reported-by: kernel test robot <oliver.sang@intel.com>
> Closes: https://lore.kernel.org/oe-lkp/202509301440.be4b3631-lkp@intel.co=
m

Don't we need a Fixes tag here?

The other part of this patch is LGTM.

Reviewed-by: Menglong Dong <menglong8.dong@gmail.com>

Thanks!
Menglong Dong

> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> ---
>  kernel/trace/fprobe.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/kernel/trace/fprobe.c b/kernel/trace/fprobe.c
> index 95e43814b85b..99d83c08b9e2 100644
> --- a/kernel/trace/fprobe.c
> +++ b/kernel/trace/fprobe.c
> @@ -847,4 +847,4 @@ static int __init fprobe_initcall(void)
>         rhltable_init(&fprobe_ip_table, &fprobe_rht_params);
>         return 0;
>  }
> -late_initcall(fprobe_initcall);
> +core_initcall(fprobe_initcall);
>
