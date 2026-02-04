Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0332318EC5
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Feb 2026 19:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.215.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770231922; cv=pass; b=tUYrZ6FIOzWoyP4SPDpbkM6XrSNI6tz1yyRvCWWCWtl5C1mwXvO919U/p/OVOpMPJjm4VatOiMZogmMFjbSZa3TGYvuWUTtg3uWtIWGxFeo3KoX8wVNDQ89/tMuShF1vR0hycoS17qM/4uXcUqADxdZJ44uGRz8jf7NoczqH1dw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770231922; c=relaxed/simple;
	bh=SLv+i/uowOZdIzzgD53bs7FT7DHh4IXtUrkqJZYulLM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O6qDQkAf2E7RCNRR5FnqkJ7w22LDiXCl/P+5Vfe5LUV1D30SaND7LauQT10Am20JwSlaL/7oF6dIXIdIagSmvBjb9PKxqHesn/HOHS31cL5t0SbnREsmBkfNhKWbv7GVLjOWCytJXjlHIOgIGfSTiu3Ge6JZjHPgV8XeaQ6hBdA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OeuiKjby; arc=pass smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OeuiKjby"
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-bde0f62464cso21044a12.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 04 Feb 2026 11:05:22 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770231922; cv=none;
        d=google.com; s=arc-20240605;
        b=PgKpiUnUcL5EJBKKxZpseN8HfrJil8O8iMVL62XdGQ5+zEyoiBC+tmm/z41hse0SM2
         Q6x+jTYQCwzEj56vvLM5a751gVwidC84jj1boO2oJU+V0PDQOMpshqhMVOx2jze+Bm9/
         9wYEsMf5Y8SWsck7zlaluVOZQ6RGZINR17LHn2RpYGU6fcksNOejNBsKy0hOSnQk63vA
         AVbWwoDKM/F3PtnDFsDu1DhE0HlaPicAB/YntlCeoeOB3HcB+qijUezYGDLW4Nb8U2nV
         jBTkZ3kdGGpCctl3Fx0mZNGp9JE52OIgMod72+pdl2m99DdIiw5OuDMDd4NJOLDH/zsb
         oZHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MzwGZHzRP4UEU2ZnVmONLCtGE+i75cYH0c1sOGrN9zk=;
        fh=JlSkLh39f6V0CYYrojLoHaBhzyLce37sqS/l6a1aJ9I=;
        b=Bhaan/Dwn0ps0ZUmI/bU75rS2+bREnQejXTzxpwQbl8NGjJ8jxlCn8XcNusUtSUzch
         puvX/3YLQgqMR5Urqir5VCXzey/g/UEARhMXRTsRITy31EW1eeL5G/8FYW60LTas3gpA
         dPlzvjd6DHAJ/zVPQggJP4m1CilwRaLYE7Kh6pBGgE/AwSrM/TrN14gmd91SmEe/U+Pj
         7yumZ+L8GoLThC77gza0Pjqsbw06Zd+c/afClh0t2LcEwBKXPqCGX292NJ7Tq0Yco1yB
         xNbtoEs6bDIWvqfeZT8YqGQlT1xfu7vqEIwFy5hlSGas0JgsH9V7jrcxR0cmOosQWwhM
         JmJA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770231922; x=1770836722; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MzwGZHzRP4UEU2ZnVmONLCtGE+i75cYH0c1sOGrN9zk=;
        b=OeuiKjbyvSsC+LGnZirfM8e4eZuAKhDwxTdwOQSTNwLjbl/1ISFyQAv8I8aPt6w4la
         lld6B39YyhH7Us6rHfqXOXtbrt1wTCjBO1y/6mPQZ6m1NzhJR+Px6KHLb6fS14FO/GCb
         9yNYAdUncyxVAk0WZRIM4HkB0nQvwqPY0jTvYunORi0PFXJRm+NmyaLkYC88xsktM0US
         vyg7H926z2kDAVo4lybni+wesNUhFvOBlvo4HUj0I1KaYTKX3cpXod0LGsuo97c4848J
         Cqrddy0epK6RC9QwnVBO7POtS3E42pTaibiFzpLnpD6xJnaMW4N14yei8vatuIC86UW9
         QLXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770231922; x=1770836722;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MzwGZHzRP4UEU2ZnVmONLCtGE+i75cYH0c1sOGrN9zk=;
        b=xSBbxKl0+ho0DXKgNR7kJ0Uu0/jGqa7rMfzCAD8J9mvS4C/ZGgHwumXId8JwWRY2KP
         Cx/8fYYsFKqRjC8SRoamwlTT7xR3tksspHyYDypGsDPFDl9nxNLXO2iH8Tab2T6/8y5A
         uS2/lbQLJAI+ozj0WbBo9YLAn2WVixUaZV8RnlaONDpLJkFfdsRAsmAy5jYp0F2Jf0bK
         04Q60BD8e5klNWZNh3fiwwUZJc41gh7f2V3oWtzo8XMGG9WeETTeURg+RFEkv2FZ1Zvq
         nmHBBNQQIMotV4EzQj6Qi/DZM9h7WuiyfRX7oqitqIYbeiEGQRGbpB9VxK1mByRhG2oH
         ar0Q==
X-Forwarded-Encrypted: i=1; AJvYcCXEwFmznzQFS2SOVFCZMLbEIMDghuxNU66b7g43qdYFB20IIl9z1wlJMNki4DFoRRkojKDEIFwbWbowGZ+uezpn5vs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwsmZuZR5zigIeSQbd+1/GHUSueetIqJR7Ttpl8SStPIi4qBWYy
	Z8RAcs0LkUxR0PItEpvQyZhATCiXEfbNsc6rSwfpTF/VTsSOiX/qYZ+W3SsA9XGXOUHc0G90OYV
	xFbSFBUoPOiy0VajofIZ27ckR8pj5B7A=
X-Gm-Gg: AZuq6aKdncNixWpA5ceDr+gYazO//QqPtqvVtFZQjWybE+WIWAeoXYiNVIr9nJky89I
	hxZSCa6Qp1PTQ4GzqClnwrFpsXPgIdWP4qHkpm8vMJ7nhnMRX7pTA9d0QG43x/iUz2YpJEp1vWP
	UZuMYwxRxiO2VE5L85qTf38BuB70zoyUlsxptWos7lDCmHWhFzAVEdWjaMYASYBx0ZvJWDC7P/Y
	2HRPM51acAeP83R8darruaqWcSGGQifrWwm3N9PR+MYryef6JvZJyXZiSZdHsLoLdVSicboFrA5
	9rtw6NvqfCVoY8rMVHUZnw==
X-Received: by 2002:a17:90b:2f90:b0:352:f2a6:334 with SMTP id
 98e67ed59e1d1-35487102a6bmr3735022a91.16.1770231921980; Wed, 04 Feb 2026
 11:05:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260203093819.2105105-1-jolsa@kernel.org> <20260203093819.2105105-8-jolsa@kernel.org>
In-Reply-To: <20260203093819.2105105-8-jolsa@kernel.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 4 Feb 2026 11:05:09 -0800
X-Gm-Features: AZwV_QgaQpMZ0tpIpyAEJ87GlKt-GPSr2xmV-LTtnAWWeELD4WudclagqaBx5gg
Message-ID: <CAEf4BzYsE3W8QvtKBOZZWGudFjXJ-_szUZOejT-Ab5v72Sei+A@mail.gmail.com>
Subject: Re: [RFC bpf-next 07/12] bpf: Add support to create tracing multi link
To: Jiri Olsa <jolsa@kernel.org>
Cc: Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Martin KaFai Lau <kafai@fb.com>, Eduard Zingerman <eddyz87@gmail.com>, Song Liu <songliubraving@fb.com>, 
	Yonghong Song <yhs@fb.com>, Menglong Dong <menglong8.dong@gmail.com>, 
	Steven Rostedt <rostedt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 3, 2026 at 1:39=E2=80=AFAM Jiri Olsa <jolsa@kernel.org> wrote:
>
> Adding new link to allow to attach program to multiple function
> BTF IDs. The link is represented by struct bpf_tracing_multi_link.
>
> To configure the link, new fields are added to bpf_attr::link_create
> to pass array of BTF IDs;
>
>   struct {
>       __aligned_u64   btf_ids;        /* addresses to attach */
>       __u32           btf_ids_cnt;    /* addresses count */

cookies suspiciously missing?

>   } tracing_multi;
>
> Each BTF ID represents function (BTF_KIND_FUNC) that the link will
> attach bpf program to.
>
> We use previously added bpf_trampoline_multi_attach/detach functions
> to attach/detach the link.
>
> Signed-off-by: Jiri Olsa <jolsa@kernel.org>
> ---
>  include/linux/trace_events.h   |   6 ++
>  include/uapi/linux/bpf.h       |   5 ++
>  kernel/bpf/syscall.c           |   2 +
>  kernel/trace/bpf_trace.c       | 105 +++++++++++++++++++++++++++++++++
>  tools/include/uapi/linux/bpf.h |   5 ++
>  5 files changed, 123 insertions(+)
>

[...]
