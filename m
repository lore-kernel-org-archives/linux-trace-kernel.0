Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80F33EC814
	for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 17:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792085771; cv=pass; b=IkJnxbp97hv/F8Idua8yYdyyMcZHAOA4z9fonIreeGU65/AepA1e1kT8O6Tpd7HJ+0v7PnOmi5ufclgKkwQrby2tKCi299cLvbUJGCrpQZ3VcrKHackijwIZUdTxqjA+oqtgg4BpUqjVe3ta4sMLOpeQqEf0zpSPTgalY/PK6PQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792085771; c=relaxed/simple;
	bh=dm9d8Wo7phCvR235TygduRlnGSKE1I/4rDerIX3YHQA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ph4KBFA9pGhT+9vZiA1XCYT3HzbzxPKFTXsmzt4Gqq/45DnrV8O+wd04EcKQpsc9jn91A/3qErD3L/fpB1MVHJZclGY93/SbGN0KpVk75YYCZFnAqyaRqkE5c+LtYbBQtRKbK9/v6khaUaISrGDJBBmF+bCJ1Ep0Dg4mpYM7BMo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mo8arRBp; arc=pass smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mo8arRBp"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-8ad98c3fb15so46787117b3.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 15 Oct 2026 10:36:01 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792085760; cv=none;
        d=google.com; s=arc-20260327;
        b=mKDH2NzmnhH1+ZFfEbqbfe7c05Fca8APQryJ3sORkFQI/F34hyDN5jGx/W/lK/clLj
         5jBJiN/XQtuFQjprNKoxsouMnBUQb8byLF8OfekKJV8lQcNGCL0x+8WLb6DAjQN+JqC7
         PyepywwEl9wP8/yQuAe8o78LLXlXpWUMHVgMQGzVJauLB404Q4Yd3PZ6bAYUsyvPAmz8
         5DmVB+tK0x+2w6WpuMRLWY/gZ4eUlLIA+2rXkr88frgKXKCaq4v5vo6VXxakiqWW8286
         D9Rg+748I7heAwisp8JDiHx9Pq6L6VHfMrDxAqxGBMDRfkcZNdtCNWUWYLF76bY+P0Je
         8cNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dm9d8Wo7phCvR235TygduRlnGSKE1I/4rDerIX3YHQA=;
        fh=uytpOGEkQPlDcp6wmMj5gJUzPbGoAWnLa4YT2gFfqcM=;
        b=kx4Lr5HOHznz1dTa7GI4fujMS8FUbc5BBS5oNK4EEEXwKDjo6TwpBIBAv1w19At3WR
         jl7rQYIHGuwlq+mOnJwTKqL18Rj6MbBkxzMqB0/Tvw6tdOj+biwf1St7YL6uVTzc/iCs
         nJOcY4KmnaHFULD9acut/ZI6lDYPRYIzIEaB+PGHY+nvaCgpzJ1wWfRvlT4eXlBd6ZGW
         MIe3O4CwNYikfd4bxH9RPrx4WVeYhDGzYm629ID69aqhLgf3BDeNxmlmLHYKKcLVUcd6
         B4dzLAGhjYqLFl9No22DG90G92/N7tkUv1+CDlt6IlqMSOR8ekX8uzwmNYyiZDXTbVdb
         TuDg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792085760; x=1792690560; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=dm9d8Wo7phCvR235TygduRlnGSKE1I/4rDerIX3YHQA=;
        b=mo8arRBp4Jfh8UYILGXLhAkhdCrikPAbVWDzvUQdlrPr9kRMJ+rOlkSQinqRO2b8nL
         +e2KPo6L+7Bai4X08Cuo9O/xYjaGTbxmLN0UWftL//2sniRJOg4ZGE7DEO/7Ho01feEf
         C2omtWjh6qpp3AcY2gJUWgwXcly0Gay26bbA53nAVsz8jetkb/G9CR/IN/Hw8eXiJLFI
         22Dz2/eFy0/BeNakjEv4ZbzYCQgvar7v7rPZDPIbkEp8I49SdH44E11KF1W+cKgpRBS9
         YpBjY7m9svi0Mbd6/JP9lnWAO+vv0GL9ZxbaedyhuuhDTihZjmcZhNWZ2SWJgTy0pgc+
         Oxrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792085760; x=1792690560;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dm9d8Wo7phCvR235TygduRlnGSKE1I/4rDerIX3YHQA=;
        b=ofBcSqm7t4lyiCGBI+zkgngHoEEaV9MUe6MHZdxfFbBs3UHpcskBUQDXFtHmgF7L6e
         hUcKNz+bOebopVNwWvE8RGN06ESBuMjLmkBi14oWw3pIM3YYrxpCGP9KfpNvbNYpqBR0
         8Dd97IHESxPv/dY2JlSeEW5CALPoij+S9Iz2Llp5PIXebbPlo/LXdyglefqO3P7SOHKK
         1dfWpHth0Rm+ZaN1GovYjkh6ssadIXksyIpvcK4aPmcsQh39yctzo8zMVoFTCBywAKgP
         kchTDoQ+/tqcSgWvZafbRDfB5nwv/bvbn7wtcei7tuFSQ7qvHFynlbkK0w17fpkjyoBJ
         N3hg==
X-Forwarded-Encrypted: i=1; AKwUvByGTyqyV7KaSRfJxnSm79m2aO8IYVmlxlmlpkXgyTAwbdTFfRjFq3DlrrNngf5SdEDzlSCle4uh8r+CIn1Ub/PrxgY=@vger.kernel.org
X-Gm-Message-State: AFq9FYKfARV8CbP58bmV//qIzOAcF5SThnewPjb2nbUahvZwUSxg2VjK
	eCdHed8FgGW6Yp1o3NCNnRlRLuLBqemUdkS+ZwP81jgTRn2t2zLnipVVjKeKShm/qmcRkLVGtYB
	7zonENtSSaXSfroxwgPQxk4Uf9KjvNadV2WdqfWk=
X-Gm-Gg: AYBFou0Af0Zs1V1EhQqCnOSnnhN2ppX+cGNLMToknPvX0K8B8MswUUz4cPicsCUwVWP
	roOOOnzyKAoflzD325Zer52wkOK/tCxR9ikp2Cp7A2oCW10KFzipEzTmxuFEltD+3iLa36bjIrv
	7VJCAApWIr2fXhS8abY7U5a91fM7HFc2nvsTWgx7VQvoGWoDN5T7fYncpbNwu3TMS0EXFo936WI
	GYJZW8F1m52QlIkE8xiDbAcqYQOXdo2RY5LEBh/mjHU+n2k7std93lc6cOPRGPlgs9EjdApObA+
	jJVcjdBkfKIjOlciHdBY2ZPZy9eKTydNwrTq6UYEWiInDawjNVr8zSk=
X-Received: by 2002:a05:690c:e3cd:b0:8b0:dc4d:941d with SMTP id
 00721157ae682-8b0dc4d98f3mr6640397b3.37.1792085760499; Thu, 15 Oct 2026
 10:36:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260830-tlb_tracepoint-v2-1-e3c88c24df5b@gmail.com>
 <ar_Rathmoj2aP-H7@xhacker> <CALsPMBOYQbro2gZTQR=DSUowmVDs9kujH4ua2UzCoHAQrncuiw@mail.gmail.com>
 <asm95GdbmMpc81p3@xhacker> <CALsPMBPMHc7q-YZvqLLYDSr5RfLmDRwBSq-TFeB8Fc8bPBjQGg@mail.gmail.com>
 <as8NpaT0g9Tsl6PS@xhacker> <CALsPMBOdy4ZDWfnkYokUFuB3UYPV27wTUpBCZaxLWEV10ZuS=A@mail.gmail.com>
 <atAROTefufggiFPO@xhacker> <atBWGQ2iWpm2VKcY@xhacker> <CALsPMBPNKsnSAczyVm3LFFQjwRg8eiGgpB2hJN19iipRZ0mASA@mail.gmail.com>
In-Reply-To: <CALsPMBPNKsnSAczyVm3LFFQjwRg8eiGgpB2hJN19iipRZ0mASA@mail.gmail.com>
From: Roman Storozhenko <romeusmeister@gmail.com>
Date: Thu, 15 Oct 2026 19:35:49 +0200
X-Gm-Features: AclHuK-wBT1gio8L_jkhM1aKzScEpjwEXurLQrG7VqNt3Zx9orkwjzcjHQwTcig
Message-ID: <CALsPMBOfqDuCqCdODvJc05CFVda5pMsixOOTXyvjyDO2=DnWYw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: mm: Trace TLB flush path selection
To: Jisheng Zhang <jszhang@kernel.org>
Cc: Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	=?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@ventanamicro.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 15, 2026 at 7:08=E2=80=AFPM Roman Storozhenko
<romeusmeister@gmail.com> wrote:
>
> On Thu, Oct 15, 2026 at 6:47=E2=80=AFAM Jisheng Zhang <jszhang@kernel.org=
> wrote:
> >
> > On Thu, Oct 15, 2026 at 07:33:13AM +0800, Jisheng Zhang wrote:
> > > On Wed, Oct 14, 2026 at 05:58:42PM +0200, Roman Storozhenko wrote:
> > > I think you misunderstood something. A riscv platform uses either
> > > SBI RFENCE or IPI for tlb shootdown, and won't change. So you can
> > > know whether the system is SBI RFENCE powered or IPI powered by
> > > cat /proc/interrupts. It's much simpler.
> >
> > Aha, I missed aclint sswi case, if sswi, no explict /proc/interrupts
> > difference between sswi and traditonal plic. However, whether TLB is
> > powered by SBI RFENCE or IPI can still be known by checking
> > "providing IPIs using SBI IPI extension" in dmesg.
>
> Thanks, I see your point now.
>
> I was treating SBI RFENCE vs the Linux cross-CPU path as part of the
> per-request selection, but with the current implementation
> riscv_sbi_for_rfence is effectively a system-wide choice established
> during initialization.
>
> I reworked the patch in v3 based on your feedback. The tracepoint no
> longer reports the local/SBI RFENCE/cross-CPU implementation path.
> Instead, it describes the semantic TLB invalidation request itself,
> including the range, stride, ASID, target CPU mask and request scope.
>
> I still think there is value in exposing this information as one
> semantic event. The individual pieces can be reconstructed with dynamic
> tracing, but having them together makes it straightforward to analyze
> the distribution and characteristics of TLB invalidations across a
> workload without depending on the current implementation details.
>
> The v3 patch is here:
>
> https://lore.kernel.org/all/20261015-tlb_tracepoint-v3-1-eef305a3bb63@gma=
il.com/
>
> Thanks for pointing out the distinction. It helped simplify the event
> and make its abstraction clearer.

And quick v4, where I removed unnecessary cleaning for checkpatch:
https://lore.kernel.org/all/20261015-tlb_tracepoint-v4-1-f238a2bd8f7e@gmail=
.com/

>
> --
> Kind regards,
> Roman 'Hedin' Storozhenko



--=20
Kind regards,
Roman 'Hedin' Storozhenko
