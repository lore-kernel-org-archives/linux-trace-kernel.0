Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038B226A0A7
	for <linux-trace-kernel@vger.kernel.org>; Wed,  1 Oct 2025 16:39:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759336784; cv=none; b=Azy+iW7FVwJMGlWXxT9g0w8ZdvM8FV5SS7hySXQ0K6hlRR0eVvCnjE8C3eHj7w9rf4TPc+0LKP+zKaojkFkYI7BpEbqybS0aJedSs0DcIM7V0CfbeseOi7xE7MDQf78B0fEGDdeaDPdezLtPMEEAzOX2xLGEa89GnNpv2b0sSOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759336784; c=relaxed/simple;
	bh=5pOEezS/qP6F4jEWoeOm7Fz3N7TCVGrsBiLzB3qwz1w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qDu+phQiC1ul3HObycKtZz0lT1OcDYFhWteKRxMn6TdV4mVlJhuBFEnUomIYNMyQDHzr8Ozi2lYTJ3cwh77hI6l/ykY97E+pnoHcN1Dw+hTKGCSPPgP/LVraABMYQHeGmcewr6IR2Vjbg4FcBgp1ZkJ0pcq51i5Rsw/KM0X2n9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LVaUbinE; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LVaUbinE"
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-3324523dfb2so136876a91.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 01 Oct 2025 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759336782; x=1759941582; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RmGKlN/jBsVenanHceP4S7aQlFVvNQtOwGJQtiqwWbA=;
        b=LVaUbinEuK4XM9JBMP2MiBggPrSFpDlqa1rFmwMq79/y5Mse9lUi5GCYJ5Ag3oqV+q
         iyfZ/sKixrbEpRWGx4d+1xq+7NWAzgKwvWOoG0AP8hmSCXR0GtEm7PkLWxtQsH/wo2T1
         ZY1wuvPwuihxocXt27fu6e+wNI48FTpXtE6QhAIv8TNZFtawES2WKj7LXk2l+nkMDZHW
         YOkcVOFUr7MJji4vN7g5g+8p3Se/MCLg+BRr02S0DprzdSBT641P0YAV+30AYtHsUnfK
         Wri1ogMSLCXK1cpBpvs4GaO4sHfuktCXpR/iwWXUWD7g3t40h1oKlO+DHsOf7FRHfNwp
         zSaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759336782; x=1759941582;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RmGKlN/jBsVenanHceP4S7aQlFVvNQtOwGJQtiqwWbA=;
        b=Qzj9XYsYpwMAZ7cMXd54SwcckStR+CzT8tKHUmeorZZq9ck8GwrG6ta5iB5DhiOeyN
         qbFQ2lEyywfF5bH75FzSM8e5kyspu4gH2ddytfsgswUmz6ijNLF/DgNAEOpwexC6eXJL
         Y/j187gvB/T+Z9Hf2Btu3mg2o1bjsyBKAroSAVugiXPQRbh0L8jbcFpSCF2p/yAKYQLD
         R3HoIll4hxKfVBnQxslRHHA359DVMtOmpzYeR0sbaR0fpL/K83Km5PB3iyfaLilGMSag
         ZeK2Yr4iGmk/3cP8IgsGkMKsNDyoGetnhUNcH9Ebb1jsrPKli/JfuIf9BRQRbl1fAyj8
         Chqw==
X-Forwarded-Encrypted: i=1; AJvYcCUyc0SDg49QJZXc2wSgovzk19y2GOMo6YrDCzAXLdJQ2j4IxO8WMxNqjkhp5q2rfxE8IfjmJFqTOciQriKKwaExEzA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAt58H3x3xYKQqW7GAmZq6yaS6jhTqL5loADKbSEiy98LpPIdo
	h2MdWiMRcKC1GwyDkw1cMh1wJTwiPGNuC1N87Ea3sx32NquWbcoXmvv43f7GoGOkV8cdveAuPg8
	kWSQ/WhredObhut9AAR9bhbAaLTZlWNg=
X-Gm-Gg: ASbGncvlONA7syPKxyEfcxxD7/dsb+gK4zgP2Na0TFE+xxI+HKBJ57TSoKfXgB9Ad/j
	2MrfnM5K6AHMIdDbd8MX3cmlp/3TsGg2gtcmdCf+QyJneCGVREkPexm5sk4RQR79abUSMObx+jh
	cHKDDfUBHbVSCZgIU6kkuaQVl4LKVxTI6OptsYeBz9XtvSJHRaLRtBDznx4HOvspD9E4mQD/Aly
	F7DxGlsFT2Ekft/rlK9/RvRnn4E0GgMO5YySx+1KU/dQKg=
X-Google-Smtp-Source: AGHT+IE9y4z9vj8j7yKhBcDb2apGorlG7PINT4jHURs+aWjIj8z/pwVAMIEXfRoJqNuQ3Mw/cwz7seK+Az+n+Pf6vm4=
X-Received: by 2002:a17:90b:1e0e:b0:330:7a11:f111 with SMTP id
 98e67ed59e1d1-339a6f84d53mr4930805a91.35.1759336781992; Wed, 01 Oct 2025
 09:39:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251001132449.178759-1-jolsa@kernel.org>
In-Reply-To: <20251001132449.178759-1-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 1 Oct 2025 09:39:27 -0700
X-Gm-Features: AS18NWBXWfduYxqUtnH1tABDYMsrbfqkNZtEA8ABmNwPyaBnTu4oL0vq-aat2Hk
Message-ID: <CAEf4BzYMDgo2JQEkV7e6rnX1Jwu4QMFdqEsnRcxL2J0ukLxU=Q@mail.gmail.com>
Subject: Re: [PATCH] uprobe: Move arch_uprobe_optimize right after handlers execution
To: Jiri Olsa <jolsa@kernel.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
	Andrii Nakryiko <andrii@kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	x86@kernel.org, Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Alan Maguire <alan.maguire@oracle.com>, David Laight <David.Laight@aculab.com>, 
	=?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <thomas@t-8ch.de>, 
	Ingo Molnar <mingo@kernel.org>, Jann Horn <jannh@google.com>, Alejandro Colomar <alx@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 1, 2025 at 6:25=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> It's less confusing to optimize uprobe right after handlers execution
> and before we do the check for changed ip register to avoid situations
> where changed ip register would skip uprobe optimization.
>
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

makes sense

Acked-by: Andrii Nakryiko <andrii@kernel.org>

> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 5dcf927310fd..c14ec27b976d 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2765,6 +2765,9 @@ static void handle_swbp(struct pt_regs *regs)
>
>         handler_chain(uprobe, regs);
>
> +       /* Try to optimize after first hit. */
> +       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> +
>         /*
>          * If user decided to take execution elsewhere, it makes little s=
ense
>          * to execute the original instruction, so let's skip it.
> @@ -2772,9 +2775,6 @@ static void handle_swbp(struct pt_regs *regs)
>         if (instruction_pointer(regs) !=3D bp_vaddr)
>                 goto out;
>
> -       /* Try to optimize after first hit. */
> -       arch_uprobe_optimize(&uprobe->arch, bp_vaddr);
> -
>         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>                 goto out;
>
> --
> 2.51.0
>
