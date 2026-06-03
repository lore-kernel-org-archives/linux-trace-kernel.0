Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E91138D3EE
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 22:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780526528; cv=pass; b=BCSjxG50LJmNXcE75JlNHtdCb7hc3BSPxbeKNe1glgtrT5OHG3eCcInyw8MBC0PYybde9o4qKuJOu268ORe4HWfX+ANrCyW1vWSMm/I571jcAqhZwhjIB5PkKxFizn+Bu1jaO0Zg/z1EumA1OgGS8NNnNkzD+o9IHQc4XlRKxrg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780526528; c=relaxed/simple;
	bh=mlfM9AEMvcEfxPBVJ7L7dsmWt64ZgjO4Ruo7lQhMZqI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a+xhP0z3sQSAIoBlUiEieicf2gFByPzULGPQ839cmltLi4vIXpLr+uILMOsJPaqlaE+EVBDBwIDXOFQCXKReW4FpO1DqIqbSVQusr2Cmnm1DWj/hjhVCTa2Rhqmn1mICWdawNlXMIVfY2DmQX7tXU2PfG4/mS1KV8L/FuapPDiI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mSqZg/he; arc=pass smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mSqZg/he"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-bec2ddee9bbso8237066b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 03 Jun 2026 15:42:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780526526; cv=none;
        d=google.com; s=arc-20240605;
        b=GMuzUp+sHpuVZOtKHOuUMuDMnHUa5dd3dByYqkCR1jBMgTtphbKOENpf1chmwq+O1m
         Li/yX7wBiQX25hvSW9/NxjNjQE7fPhOhBZ+Gds/6o+3M1uIdyR2zh73ahKOoiYmM9MIM
         SZXRae/JxPkLDequpzKkFuGDP/sGeli15kMZVAeDZdjm+OlC6xOLxdEbsDEJOs5LJnnQ
         XkZxVwVmPNjx5Kn9YsMmWJat2zBYKNfPJQsFnASbCgiqzskxjEuBdylFakmzBa10Zgc6
         aQdAPIu9VNLxw1f7oXphwEhEVDX/WSs0IILgtK0xBcokv+JEuFAT+U1o5Rz8PHM25Jyp
         lRcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pwVbCGWyVitlFmHdRUWGc0ezDR+78ZvpePoMrndDp5k=;
        fh=85olQeE/3ILWH7k3i49jkiv8Nz7oFW9Q+XH1c4T9dCQ=;
        b=OE5GarREQEQc56ha/+B6D3FDO8udJrOudIEfySfXbMCDrZKIEb19OmnHQ/deLpNQMT
         +ACuyx4Ec+Q9UEZ6S9tIVPUgaJz9KjQHBhWmI3639CCwkff9z9874zok+JPP91995xRR
         KZKSLBqg2eFDWcx4yPLURPICEGAlnNVBy2Tlc1vuOIZFLabWXs0LctiUXrXXz30B7cAQ
         yM32zCvpUigXOmU7GPgVK7c64S9aflD8zmqb0hCBPAGs+8Y59Dfp9PuIoQev6XSJ4TLY
         RD8HeXEIlUjlnsbN9Vca1Q0z/VQ9PbcW5+feiK+9My33gBzQJGrvTaIgDzmNhC5MgtN+
         FI7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780526526; x=1781131326; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pwVbCGWyVitlFmHdRUWGc0ezDR+78ZvpePoMrndDp5k=;
        b=mSqZg/heWp6aSiHv5nyKPeWQr8YV7o07T3FdO5ah8eWu6Zctjt99Z9o3TNszwXjHdM
         ysIbW0c9RISSVBiYSoE9/r8K3SH6erB3Rw4GbHnMkescY0FtwoyBaji9FOzouDLMgal7
         4rLg8INWFvkFvNpbr0Q8S9GsCn0Za5Dcrlme/RtPHx4uhhwccc1XL52X4tBKoTeNugOv
         RxgBxxUmgGTdAx+dGoIar92t+lJ+Ag2hdkwQ9UzWJghRlvdL+R6d81Ha5BFcsR3mx2wz
         R8Wk5a/EJdokO3ocITh0vTFbtn/fOZtzdcQ1RE3jFRzvnBUZz23pMC9vQppi/zDQai7g
         bDEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780526526; x=1781131326;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pwVbCGWyVitlFmHdRUWGc0ezDR+78ZvpePoMrndDp5k=;
        b=Ks2rzdSdhzDN9hDCE5NX8q5P2dFL/RYlR3BB7oEdHIxBUziKU0LiV9JenkaANZxrLL
         CimnorBVXXSykHm85yp9YZ7nTRaVG/CVkk0qD7hB39DorlFzqrcO/92XCpsXVgclheic
         CI8u/7uHLoql8x/U0nb3hLim6pXmWxr1ZQpASzytTrOhvDQY1uY08rzzcU8XzUuJQGFd
         D4kT7+GoKdB3ArCGGr8e9qkllegYuuMqgI0xgr+Om38dBPzr0JtRa21v5ZaHy0Js4c8U
         P4Bv4VtFezQwgDyLAPts6XmtghM6dRcIxjYwDVkd9DYGmWClD4zynqw9lJzRktogtHA5
         BfIw==
X-Forwarded-Encrypted: i=1; AFNElJ9z54Jo+uj6cotqx4dzrZaZjsw6S+c9dXKxpEh1IBE7h/30VdiqrleKtrdT1viqul5DeZWFsuD2EBb34jyLwinMXsA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxm4HSO1FZQcOJXBQabwwj2JdqnnlUKFD2vRrTDWmzJZb4vZeb0
	gYtjWgRuaW/KpL1KzCrat+WotyQszp7tX0w72TI2BUL3Dt259ZBAIPTBzLYvExoXLvZzHQwiRU3
	eXQYVOOSQPmQC9fLEUmnGtuaPyY44YhZRNuX1
X-Gm-Gg: Acq92OFj77wmWkmfwYS3+jc6yIWqzxb0eWyyHP+WSP1TRp49G+pDsscHAuVeolvH3Ed
	QSjOmnfMsmHuvNT7JTM+SXtEhok/F+i7CYUxGEJNs7a1mpzqVQo1TcrqQcCwB02xEqBCIuipL+Q
	EucX3OzD/XfnqJ6B47UuL+6/jtU9x2WoDhQdaXBmAwelLCO7mfv9psgsjta27ATREaBplgE/ppD
	Zc8AOtvA9BH91iW8xnHWsj2xr4weYKLSJ29TPj2UVN0Su+ZWODnKttawNw2BSzjNkJ85t5fcI4z
	zfHu/4yOzTTYbY61zHR31mYVEIlp
X-Received: by 2002:a17:906:30d4:b0:bf1:6366:f8c4 with SMTP id
 a640c23a62f3a-bf1637645abmr130076766b.15.1780526525532; Wed, 03 Jun 2026
 15:42:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260518-generic_tracepoint-v2-0-b755a5cf67bb@meta.com>
 <20260518-generic_tracepoint-v2-2-b755a5cf67bb@meta.com> <eed59d12-969f-4135-a84b-4965743692cd@gmail.com>
 <20260526215741.1e5b3e42@fedora>
In-Reply-To: <20260526215741.1e5b3e42@fedora>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Wed, 3 Jun 2026 15:41:50 -0700
X-Gm-Features: AVHnY4JO84lm1Jm4LRIslikLFJmoC8aT5bml0xtrkTJBA4XifWgRoPCj9tn2DeY
Message-ID: <CAEf4BzY5MTGJyys369qDS3b63-tKq3okCpFMqUdfzy0dXk7vLg@mail.gmail.com>
Subject: Re: [PATCH bpf-next v2 2/3] tracing: Expose tracepoint BTF ids via tracefs
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mykyta Yatsenko <mykyta.yatsenko5@gmail.com>, bpf@vger.kernel.org, 
	Mykyta Yatsenko <yatsenko@meta.com>, linux-trace-kernel@vger.kernel.org, 
	Andrii Nakryiko <andrii@kernel.org>, Alexei Starovoitov <ast@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, May 26, 2026 at 6:57=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 26 May 2026 11:07:56 +0100
> Mykyta Yatsenko <mykyta.yatsenko5@gmail.com> wrote:
>
> > Hi Steven,
> >
> > Gentle ping on this patch from the series.
> >
> > Since this part touches tracing, I=E2=80=99d appreciate your thoughts o=
n the
> > tracing changes whenever you have a chance.
> >
>
> Hi,
>
> I've been looking at this and was wondering if there are ways to not
> extend the trace_event_class structure. It's added for most trace
> events (actually each DECLARE_EVENT_CLASS). Although when things like
> BTF is enabled, this is a very small amount of extra memory.
>
> I haven't been ignoring this. I've just been thinking about other
> approaches, but haven't come up with anything. Of course, I haven't
> been spending that much time on it, as I've been focused on other
> things.

Just in theory, what alternative would there be besides having one
extra pointer in trace_event_class struct? Some sort of lookup by name
or something? E.g., if we know "call" part at runtime for any given
tracepoint for

.btf_ids                =3D __bpf_trace_btf_ids_##call,

we can probably lookup symbol from kallsyms and fetch BTF IDs that way
without extending the struct?

FWIW, this type info for tracepoints (classic and raw both) are very
useful, because right now one needs to do a bunch of work (subject to
break due to kernel type/name changes, etc) to find this, and for
various generic tracing tooling this type information is actually a
necessity to be useful.

That's just to say that it would be great to have this in some form of
shape, so please help getting this into acceptable form, thanks!

>
> -- Steve
