Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 577C332E2D3
	for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 22:29:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758061748; cv=none; b=bJKnhhhknX4MfhIcCeEYtp5y+Bq9IoE9Vm8Gy3U1ftGvoDu8uRnR5vvUtjX9HHLs1ysvMESmw7dcAYkNRCdfMy/d8JG2QBBsaECj0Wy1oJKUJn5kwLqAI4jlasvCi3sWftzZhCh422HhZ1qnxLHuz8317Xo6IXnyYdKsaOzGY2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758061748; c=relaxed/simple;
	bh=GQRiMPLso4udFX4CB+sEYglBh5mmBczyDU9O0TBC65U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F8Aw3xlPO39b3djebjZDvosTa64aso5LqIBUzXCunBbc2ly6ZAqJ5P1fA+GDhJlAcEPocMwRydNkIPqAoHm7lY26QpMGo4vzgacMQ/NbhsSJAIh7SXHinPjMJOdfnJ4ZfO977b9OWZN2R0Hw4MCYBsZghXyjltdKg9oY1iV4Tnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WSHnxAnm; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WSHnxAnm"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-b54b3cafdcaso3062778a12.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 16 Sep 2025 15:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758061747; x=1758666547; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4WprOe5/M+42SgMOPYQkTmIUA2Q1389Nu0dnK2gJe/0=;
        b=WSHnxAnmisQm9BwcqNhUrEh1Mb18UqZhLC3Umb/0KOoNk8zxCMQifaExiwN0eon23A
         6lPiKFE+EL6UHzah3cpzGfV51V0swQiDYDNmnY+LAxMwkxFK4tpl20gQpSvBWmxG9JdN
         mDFORNM6fZgmxVwdu42iY3Zc66DUXGMdTG8WxJXfVOEPUfLDbkqpbs81bKymEOo5a5N2
         xkNsEys5ihXe2SDfxFiD2XK534u0I0ctuCcy/DzYpD0kAOEh13lIpLbvxE9rXBrRTLwy
         BD9HVs4UeRVjX+0LNyEoN5aKvpEZq2hjo5nKlUJE4XLfohE5vroCKiCbCfoRPwFsuyav
         ex6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758061747; x=1758666547;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4WprOe5/M+42SgMOPYQkTmIUA2Q1389Nu0dnK2gJe/0=;
        b=CfaLxAO16SLp/XeFYsx7LqlbInadolf+6sIZv5IGKWL2+wOtaWS9Xhso7dSQsTNGW6
         OdLpWquxYps2Js6EJAXhBVgQHRu5gWCJSfjNA6TWJciLZZJD/EpJwVJ00KDLIQDABJRe
         7Dd/LpyMxePZMXV/CtnLcLlzPG8q9BsG6RxipvrMyLBZuFFrRR9wZQnwWG3oZQEYyyjM
         kr+1cKcjZNaonrDSYANz19eGKmo49Uf77IJ7d6NnkfpvVr440PFhIPGzqXGw4IMYZxMa
         8EohQH7C/qH7VHnC6P8DqjqSe8nSCQVjAEdU8+3WL1eI44TQ+rbYnVNUa1Nnr7ES6yg9
         sj8w==
X-Forwarded-Encrypted: i=1; AJvYcCXRiYJRmnSpnDbfveSb+8TYubkuW2Hz8XfxujLfzzpNYjhZRd/hKVBRpHlIDuyStWr5IvZfjBTybcRTekyCs5vY3Oc=@vger.kernel.org
X-Gm-Message-State: AOJu0YztuPVbf8CJqqPSf+Nkc2FQyNNxUGoX6EsWfJ98ET+Am/9z7aiu
	LEBiGSFZ9s8qJ/tgxPyXKTUgdiM/ly4fbC7S1WIJ1AkEXT4ziSVUqVfqQ/Chqpkj2izzMLJvR4K
	qJLs8QD7r3zQr1mCfh/pnRH9PxwwTJHY=
X-Gm-Gg: ASbGncvFMd7kw8gqGeTXnTdMjmDuFbrrFXS+yuUpoC6yrlyyE6Xx0fIYKLbmYjAvjkV
	HGpP2v/fLZyS3FU7RpCHb7ak0aSQgeEqK1pO38HjsdAsBX8N10b499A0nrA7flnZCeUCoagNNZZ
	bEDHf8q3e5PesMA1aI/8D00syfsrJg5rjh4yp650D2NwKHWqyB2Szq7BP+CnrqoP/XLxmEgPA9a
	cHWHZ3RrqehaYZyETTS/WE=
X-Google-Smtp-Source: AGHT+IHBOnFSbfOjCWswssFIXUYknwoi8bxg+YaSZ0NlMLbN3Szk7M4gcBk+o1k+eZZc+Hhru+MlV+o4dEFHedKtN1s=
X-Received: by 2002:a17:903:2410:b0:24c:9a51:9a33 with SMTP id
 d9443c01a7336-25d24e9df3dmr201990295ad.22.1758061746563; Tue, 16 Sep 2025
 15:29:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250916215301.664963-1-jolsa@kernel.org> <20250916215301.664963-3-jolsa@kernel.org>
In-Reply-To: <20250916215301.664963-3-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Tue, 16 Sep 2025 15:28:52 -0700
X-Gm-Features: AS18NWDXq8G0jhAXIKx9oMvchpwy_wkQP4mw4ZzusEgUYtrbuckohtBJ2yrw2Bw
Message-ID: <CAEf4BzYTJcq=Kk6W9Gz90gM=mw2fS2T-QBurUhdjBNinReDSjQ@mail.gmail.com>
Subject: Re: [PATCHv4 bpf-next 2/6] uprobe: Do not emulate/sstep original
 instruction when ip is changed
To: Jiri Olsa <jolsa@kernel.org>, Ingo Molnar <mingo@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>
Cc: Oleg Nesterov <oleg@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, x86@kernel.org, 
	Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>, 
	John Fastabend <john.fastabend@gmail.com>, Hao Luo <haoluo@google.com>, 
	Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 16, 2025 at 2:53=E2=80=AFPM Jiri Olsa <jolsa@kernel.org> wrote:
>
> If uprobe handler changes instruction pointer we still execute single
> step) or emulate the original instruction and increment the (new) ip
> with its length.
>
> This makes the new instruction pointer bogus and application will
> likely crash on illegal instruction execution.
>
> If user decided to take execution elsewhere, it makes little sense
> to execute the original instruction, so let's skip it.
>
> Acked-by: Oleg Nesterov <oleg@redhat.com>
> Acked-by: Andrii Nakryiko <andrii@kernel.org>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  kernel/events/uprobes.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
> index 7ca1940607bd..2b32c32bcb77 100644
> --- a/kernel/events/uprobes.c
> +++ b/kernel/events/uprobes.c
> @@ -2741,6 +2741,13 @@ static void handle_swbp(struct pt_regs *regs)
>
>         handler_chain(uprobe, regs);
>
> +       /*
> +        * If user decided to take execution elsewhere, it makes little s=
ense
> +        * to execute the original instruction, so let's skip it.
> +        */
> +       if (instruction_pointer(regs) !=3D bp_vaddr)
> +               goto out;
> +

Peter, Ingo,

Are you guys ok with us routing this through the bpf-next tree? We'll
have a tiny conflict because in perf/core branch there is
arch_uprobe_optimize() call added after handler_chain(), so git merge
will be a bit confused, probably. But it should be trivially
resolvable.

>         if (arch_uprobe_skip_sstep(&uprobe->arch, regs))
>                 goto out;
>
> --
> 2.51.0
>
