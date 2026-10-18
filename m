Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C0A47ACDA
	for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 11:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792322503; cv=pass; b=B5lZW42YxcUQzu1tJ5GVwKfh1KU2pmzwOXYLL0bC9bMO9432etTFJbl4yOK9KDgailQtXWYTse6rsdMK0lTlhXqBERqzmpdr4bUUr3iMtHA9ZzLUYPEbxMEVYvGPQDy51q+Dyh6lNb9l0lwgQ/2kjCOdQPopXWLDLgBCeexk7tU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792322503; c=relaxed/simple;
	bh=6HVJA1CilQEoae2ePMD3zaqAFtAvSpqKqWYCEyEwCOg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=A8TU6HbPuzIL078nPI747hSc0ZIgTCt/cWc49MvfJRpj6WQjNvLm2qm6BHxUFh4ClYZh1W866A1XiKrP3ymkPIj/vsLWqH8Ys6/OyyShTDPtAvwwH3vLQOL8Xz2IZYicJ1mSQ9SYc+DPaib8KTcD80n5d54CdOupX2HECGxNZrs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HS0TL9Wx; arc=pass smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HS0TL9Wx"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-8b09e07e149so8606107b3.1
        for <linux-trace-kernel@vger.kernel.org>; Sun, 18 Oct 2026 04:21:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792322500; cv=none;
        d=google.com; s=arc-20260327;
        b=SRhwAExINzR1WT6b37SH8ByUuTVnlFRtjpURyom0rTQz8cE22lvGRUH0VgY4wMUSzh
         oMzB101dHModKZjRaPXy4ffnmIobNaQyKkT481EB1Lnv2wofLx4iuXOy4YX6WssdfUsq
         ITXOjkSyNhb2w7dxHLBPcLeZtwfmf6mbgrGmcil177udFt95AcB4pisE1PpyKKkl/5AU
         jRFheCRT1CSvTikW1t0JC/LB/WcQfE/Vr9uxPh2JmFk7gyXvqupnA9AB6UEnlQvBOZ2Q
         ZtFnKgs/PuBmJowHUlXwiq8MwNDbfcBhEwve8sqZuHPPgRTBDCnHxHOpRu2k01/2cb2v
         h21g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6HVJA1CilQEoae2ePMD3zaqAFtAvSpqKqWYCEyEwCOg=;
        fh=v9fyNe/mQgxlNRMz4zfiJPmiFbQDSWCXyWZEe0c4GIA=;
        b=qEjgJnU5I9D4fFE6YttZ8mqSUh3SHl3NdTkyASwsBIMP1NfPnN1Aw16Qdp89HhTFMP
         80N7oxUGgMjt0OP6YcFgd7Ft/1D1dtUWs/xPoYCyaefvaqh70U3e9EjvLJOLovjPJ9GT
         0medx0+suoXZmcckX1S2MzjpnUAiySz4IVTCdODG9cBaMjJK42kvuSqbXV/uov3up3mc
         7rEl/3/Eve8MbzraWrtJWZBXXBsD5slGVkiugarDTd68scT85kSCE8eTDfpR38tWfd1g
         arfHlegh27XBdn9dIl/FOnrcrsuQWIRBFPwsnL7wusLH/4MDBoNOUKecR8uD2/6yuqe6
         DB0w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792322500; x=1792927300; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6HVJA1CilQEoae2ePMD3zaqAFtAvSpqKqWYCEyEwCOg=;
        b=HS0TL9WxHN/q+rpoIkp4W5iBZcg+0SqDBnXs4XUW66vo/4pU+E352AA94RbgNIp7XH
         fBJKqdO3q18uCq+LcUTx0Kuc4m20xm3BXJW7LZM1CuIKmvX0cLZL0ujnBry1Ft1Y+wp6
         E6sMIdwSq0ZiKNIUWofgH0E5XkUgkwty+evpSmPNQoOBQxDJBd4zr4ZzAf1h0Uqk3NGI
         ysIptz5FHA3fyiTty1LkHsltq1aWYlEd+GjLqeSPXVoK3gaTGWpdW72Jgr8+VeYNShdx
         Y4EdydSg3PHRO9slz0YQFWzJtBAHVya1602h5ORVW3DfSg2y6rlPusyfYlmcrpieoWr4
         cjfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792322500; x=1792927300;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6HVJA1CilQEoae2ePMD3zaqAFtAvSpqKqWYCEyEwCOg=;
        b=ySWMmx6puWAQT9pu84sn33gwMqk3gMEn6+F6EIJK5xQKcS8HL6fxKmlGgLcwOZ8YWn
         0lLomTW3UnKPaSnsMclJcijEYqO3F16beHNISwIUvcswS8+lTrJLO5vSnARm1sUDI68E
         L9gkPLHU5FTCFMTxk0boYVPAPMDB+ULLWPvf/syZT8oTXn3oPxhVPBWApi10sO/uqVRO
         6XA2b9rTsdrlaqcFd5+/AZ2F2hg5jHyGrhLSnoQNXF4DcVXgy+ditWimdijDzDtRQGPz
         tQ7PSflAVIMsP+50p1chz0uvasngmY8cztirh6h/T0S3RdJK3gx6nNK+tu35wzRleeuZ
         ICEw==
X-Forwarded-Encrypted: i=1; AKwUvByGZ9zaMrBmscm1dxsx/JWqBWHphXgRXAOESNm0Of54H8/1baIM85Z6Lbd4hdLwW8Yd2SgT5zz8VPUjOuuNxdNBNVU=@vger.kernel.org
X-Gm-Message-State: AFq9FYKhuS+Ow8UtRIj2e5+6ICYxA9Js4jOwz0HIo58BW+FYYlQ1GkVV
	u7jiNl/fjpQU7waKxHTMVn+8sAoJC6KwYr1ezPHjlpbfCoyphl2SPqP2AmK672qcVqEa+dDSU3N
	Szcs9FXCasWoSKDUqIJqxtKJh2Kh2QDI=
X-Gm-Gg: AYBFou3AtBXKtGL/q3h24Op6AtcALkBFEzPxGETcS65/Kmlk65FFiQVZj1SHLi/fV4g
	AOVETlZr6hXTkTxlCkwQItJP+E2jtF0t4AJq05pgAv4wi2JGcaEMLE+M91bEfouLWZJku3eaAva
	iswg9uK9fp1dl6PzDdDahtZD1qUOQMvq0Zfr3XZJTpIyzDWXaw96Cg7dWZpDrQuH6WPzY9iMLYh
	D2GKSjVeWeP8gb2y6v2CmCLlk7c1J3p0448xnHUbhwTz3uTy72UlnJEe+tjsEHJnbJ6hD3zTGhQ
	SBFiyRRHDzuGc6OCArH9BRSiv4rV7+/bt1iM2qAyxswYGmb5BlI9Meo=
X-Received: by 2002:a05:690c:588a:b0:8a4:d87f:8d52 with SMTP id
 00721157ae682-8b0f207372amr11089807b3.2.1792322500464; Sun, 18 Oct 2026
 04:21:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com>
 <20261016103630.6e8fbaa5@gandalf.local.home> <CALsPMBPnp8W68tFQKCtx=kxce4bUPx=MR_NwarOmKUJgC5_EPA@mail.gmail.com>
In-Reply-To: <CALsPMBPnp8W68tFQKCtx=kxce4bUPx=MR_NwarOmKUJgC5_EPA@mail.gmail.com>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Sun, 18 Oct 2026 13:21:29 +0200
X-Gm-Features: AclHuK8cy2LSJv8imKz6jMFJVEsTHQHEoKxscGeMPDHByLswQn8-QeWvtdSi3IM
Message-ID: <CALsPMBOZjv9hdjf+ydbro5DHwuA4Uqt21ViWgLRFW9bnz5rDog@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: Trace TLB flush path selection
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Oct 17, 2026 at 3:55=E2=80=AFPM Roman Storozhenko
<romeusmeister@gmail.com> wrote:
>
> On Fri, Oct 16, 2026 at 4:36=E2=80=AFPM Steven Rostedt <rostedt@goodmis.o=
rg> wrote:
> >
> > On Sun, 30 Aug 2026 16:36:37 +0200
> > Roman 'Hedin' Storozhenko <romeusmeister@gmail.com> wrote:
> >
> > > diff --git a/include/trace/events/riscv_tlb.h b/include/trace/events/=
riscv_tlb.h
> >
> > Please do not put architecture specific events in include/trace.
> >
> > They belong in the architecture.
> >
> > See the example code in samples/trace_events/trace-events-sample.[ch]
> > as well as the Makefile there on how to put trace events in directories
> > outside of include/trace/
> >
> > Thanks,
> >
> > -- Steve
> >
>
> Hi Steve,
>
> Thanks for the review.
>
> I've moved the trace event definition to
> arch/riscv/include/asm/riscv_tlb.h in v5, following the existing
> RISC-V tracepoint convention.
>
> The updated patch is available here:
> https://lore.kernel.org/linux-riscv/20261017-tlb_tracepoint-v5-1-256fb539=
3a7f@gmail.com/
>
> Thanks for pointing this out.

Hi Steve,
I've posted v6 with an additional fix for
the alignment of the dynamically stored CPU mask.

The trace event definition remains under
arch/riscv/include/asm/riscv_tlb.h, as in v5.

The updated patch is available here:
https://lore.kernel.org/linux-riscv/20261018-tlb_tracepoint-v6-1-1447642787=
0f@gmail.com/T/#u

>
> --
> Kind regards,
> Roman 'Hedin' Storozhenko

--=20
Kind regards,
Roman 'Hedin' Storozhenko
