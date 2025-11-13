Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E439FC141
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763002890; cv=none; b=oNm4FiBfhvavS1BQ4hobF2QxbOx6OsNuZSBh53Yi26NYFygl6DlzglroQTHmW/KWcF1l+tbbtE8KGlIFFRbzFVDavjU/bWO1vOfURPMH7uWDvdW4MJiMmMu8hZHCFGkf+3uflUKBp39sqxVYVD/SryccEBURlJRINkXktxXdtxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763002890; c=relaxed/simple;
	bh=riAoIAc2yL5Vl9hNdlMoJBT+uEg726i5oaGUDTMw5xE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=J04R8lpAHQbRyqsXJcQQWvmi8k9NpqgL6PcqxsoxCjfA/fd2NUOtmExoV5NReAP6iLa2ZKTj8CaPmA9UwBMQiOrpJhsCXLdllMh3kDrfBw76t56R95Rp1Y2rJhgbiVMZNTMF5LB0pufvWtiNTgoPCwAHaddLb1VQOApne6S3O9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mkCUdcRi; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mkCUdcRi"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b729a941e35so38710566b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 19:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763002887; x=1763607687; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEATRhgiS5kmf7TsY+sM60sKbeTcryXMuiahgCBYVys=;
        b=mkCUdcRifvIW3bokb1T5gAblrasOkRc9TTmXDCd1/xKtja7AZnrfbQTTdQpOU2q1fw
         QCs7EmzDTVkiFOaAIW5+O9CbMHYqh58NstX02gDB+sczNCRF/uaBkfNWGRPz7oPGQWjV
         cFLjPuhJKOQ1ebk3aePDVUeHyYEbAPt8j3CPWrR5u7t/zILk5vZU0fb028ylXlbTfZSt
         x+I1VcGZD5wswa3s5OhNbDzCXJXEtxKxszkIEdF27ZVDYJV85ntBBKiebCqbgwjbDPMv
         0qTo3FZpSeUMCVHVqPlwrmWx/5xK/t5ts+vAtJ64802URDse4awXpmUCTI6Xx4liCgEm
         mNMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763002887; x=1763607687;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JEATRhgiS5kmf7TsY+sM60sKbeTcryXMuiahgCBYVys=;
        b=Yo5Mqsv/9yKGMRzrB7CN1AFGmU31rmaZNQQt1qgwxf/yaeW7m3MyY3O23tpGAFYMyo
         HJUpqOCqEZe+/PvG3AK5rq8ITfDNK35e5Gn7dsqx5aMcgSjJFiHZV39oGQknNYwfZPtS
         3ZMcZFSW/juM02IxB7u5iSWOt1oco9K0/bop1SihRI+B4ld4yd1OC4ZNiznGHZHDoQAY
         y3vKYOrTK0CfqLBtlMSesTwabNFtzNJ30pxRsAm/aDd549QHgo+InfCk1i0gOFP/Vu9k
         4amuVvqAO8YZckVmNilqe6pdC+A2J4XsVH+IIEvJ207bWFJlqzNYoPreZvTshpSG8TeR
         mgUA==
X-Forwarded-Encrypted: i=1; AJvYcCXjLbuzaqN2jfJfVOGN0mR3G1GMvgZSUhBRyOeFu+zWGLCrBCPJDYqP4fHtN45ysM08aycdlfgh9AqxncwrvkM3GqA=@vger.kernel.org
X-Gm-Message-State: AOJu0YzZTVVRk4bmTnTEHJdBRmzjt0o3/VJ+pfaP9F3UVD70IL9D8C6I
	81xd1SKMsJb3SpBzsYoEW968YwmzixdqiXVYw/iIRbM8SZ30txsokadVp8HszRV5RkLe3z5Ziz9
	b2fy1A4Tci62AoAypqWsxz4RajbHue2paIbZ2mOH4BQ==
X-Gm-Gg: ASbGncsw4wllIP9L6m1W/DuzGF8rIh7EzL0ncREt8MhONDUPUd7xCai/mUn3WraqPzN
	8wDF1cettGXvc4l399v2+8x5FFv9za7y0DBkGeV09rIdb3UUOhBczmOMAYZFAxwyzGxVRY9D7sM
	SEi9nD0zJjcyqJI0kkcG/qdMvQVxjAIlW+JIxSb8UAEvTvNE38FYu5RgmX/GBF5TCaP0ISjYJQr
	7C6HmXkgqVoLya137WkL3OZ3smL3MtrcKvNKDW33MQEzVsVN/Ygj0cpfQzvPw==
X-Google-Smtp-Source: AGHT+IEhUhDkt66n6cxjD34Fw35zUwqDifoLaz7jA6badzlFNFlqmDdNTPKxPAQTTzy2Ts0a6EcJNxYMERmMqotiO9c=
X-Received: by 2002:a17:906:4794:b0:b73:42df:27a with SMTP id
 a640c23a62f3a-b7342df0b7emr268831666b.1.1763002887148; Wed, 12 Nov 2025
 19:01:27 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112034333.2901601-1-dolinux.peng@gmail.com>
 <CAErzpms8oRkqJhxk1R6LMUq1GeZT3TqkPOm2yRAfY1ph_F2YNw@mail.gmail.com>
 <20251112103804.4a43591a@gandalf.local.home> <CAErzpmt8Dsq3f6ZUvtmc25hvy0NH6uRxBHPSxeZhkFfzkdJ04g@mail.gmail.com>
 <20251112210236.07deb6b2@gandalf.local.home> <CAErzpmsn-uys3VdchF_CKBPUQT+328wtaKnbufoDi-o9x7eHaA@mail.gmail.com>
In-Reply-To: <CAErzpmsn-uys3VdchF_CKBPUQT+328wtaKnbufoDi-o9x7eHaA@mail.gmail.com>
From: Donglin Peng <dolinux.peng@gmail.com>
Date: Thu, 13 Nov 2025 11:01:15 +0800
X-Gm-Features: AWmQ_bnbpmkYVcoYsxhHFpslTZMFhAk5pt6sig5ZUuQRqgDODtwWdSkCbYapRMA
Message-ID: <CAErzpmuPY3_b9LCdeG_8H4hCm_r+4rhzxfwVf04H0jnxBdE5nQ@mail.gmail.com>
Subject: Re: [PATCH v3 RESEND] function_graph: Enable funcgraph-args and
 funcgraph-retaddr to work simultaneously
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Donglin Peng <pengdonglin@xiaomi.com>, 
	Sven Schnelle <svens@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 10:38=E2=80=AFAM Donglin Peng <dolinux.peng@gmail.c=
om> wrote:
>
> On Thu, Nov 13, 2025 at 10:02=E2=80=AFAM Steven Rostedt <rostedt@goodmis.=
org> wrote:
> >
> > On Thu, 13 Nov 2025 09:48:52 +0800
> > Donglin Peng <dolinux.peng@gmail.com> wrote:
> >
> > > I noticed that when funcgraph-args is enabled, it registers
> > > trace_graph_entry_args
> > > to replace trace_graph_entry. The only difference is whether a valid
> > > fregs pointer
> > > is passed.
> > >
> > > To reduce overhead, I propose consolidating the two entry functions. =
We could
> > > maintain only trace_graph_entry and pass the fregs parameter to graph=
_entry.
> > > Within __graph_entry, we can then conditionally record arguments base=
d on
> > > 'TRACE_GRAPH_ARGS && !!fregs'.
> >
> > What overhead are you reducing?  Why add a branch statement in a critic=
al path?
>
> Thanks. During testing, I found that enabling funcgraph-args incurs signi=
ficant
> overhead (344ms) compared to other trace options (near-zero).
>
> # time echo 1 > options/funcgraph-retaddr
>
> real    0m0.000s
> user    0m0.000s
> sys     0m0.000s
>
> # time  echo 1 > options/funcgraph-args
>
> real    0m0.344s
> user    0m0.000s
> sys     0m0.344s
>
> So I thought it may need to be optimized.
>
> >
> > The graph_entry() should not be looking at the flags argument. It's cal=
led
> > by *every function*. Also note, I recently fixed the flags to be per
> > instance and not global. Which means testing the flags would require
> > indirection lookups.
>
> Thanks, I agree and it indeed introduces extra branch instruction and
> may introduce more overhead when using indirection lookups.

Is it necessary to do the same thing for funcgraph-retaddr considering
that it checks the global tracer_flags in the graph_entry?

>
> >
> > -- Steve
