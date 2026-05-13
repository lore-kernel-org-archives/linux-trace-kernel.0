Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E900D3659FD
	for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 09:35:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778664910; cv=none; b=dk06Z8wSbkcgspTGg4R5cXT5vwes/SdlBG7FVJbdqqhrZn0J9Jl/AttGroyTIfjOjQIaWfeKDmHq484MLjeYozW2qtrMVXuVFK70j9iIvmzN6xJKgKq0LvS/VgfvClbaNHNev2xlOw1/T4+4O2mVUD6zKT2bchqYNc6Rkzrm8F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778664910; c=relaxed/simple;
	bh=v2TKsJ9g6yqynpmNmF6iTE1gweYzKODzAgklF4MSXqc=;
	h=From:Date:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KgcJfcj1To2EwOJTDGpDNnMZs5+uqdVcQJ0l4v3T4nyW3Zn/MmLbO6TDSAMtQXrDnBf88YblVr57W1kZGlTwl0LIEQ6g1bRrSpwWNlGrB6D+kfpGMUf4EJ1S8pdV+VNXJNv5TeFRT17LVcJNVsx9QlkGbEKhy8b6xBiinPymVqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OKsB9J0G; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OKsB9J0G"
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-444826c16ffso5594211f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 13 May 2026 02:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778664907; x=1779269707; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uHpDb7RVxLFe2jhd0K3eMWmK7Bsx9xHAwjTVhvNRpAc=;
        b=OKsB9J0G2uBMR0PAmwxxNnnxHucNsB+Ij1i3OWBpWyg/odQ+v3gJuYEn4bdAHvqNtF
         CkljrdRSxv6nWcsjVkChXpMoqs8sStM6k599j312zOCq9K16jGOWqMUw4hCM1fVD+rb3
         kxV+i4QieXhAGwVV/x8RcInYVAPFijCvZmT1NsVa/kOAiFmLzcAzWcGmBc6I0SteNyxQ
         G+ZIgirTpTeMqwszq0QYOT7EUYeWsc6CTPkuitsbmTuCJhYoPVkd0Tt/8HIgZ7dYlGH5
         GYGoMHQPKyXgmgrLbAgDwVqTjAm+F4SKTu6XXp2yrpFRk2c+BrL1CMhEKH8Czg9WDdsk
         otjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778664907; x=1779269707;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uHpDb7RVxLFe2jhd0K3eMWmK7Bsx9xHAwjTVhvNRpAc=;
        b=SlqMdyZmGy1zqFRInjEz/UOgwCs1OpC572cee8gYSkeTyW+WAejoCP7XHy2/nF9dFn
         dJm0qkIr2bfl/XEak2NXOYvae7cyquDwpnRcl7PAwQ0Ua4INjfwnnndCyxPZ9m5ud45d
         wDE/Azkjfgv9Bg4lSWOKbkKODHAmEAhn9ZZ6w0auu0RQsdQisim31V35YFSIxzwHza7x
         JKXOQ5AjH9WgTeCLS2n0UZujA2wsMRluZiUfKEF0SlgpUaLeMceZPYPx0x8PSDYRPzEm
         uiiCZq9diZvYpaUdF9HsG21MmvjEZsqLnV7odfx85p3T4zqhpbIhVaOab+uIOgnZ48YP
         cZ8A==
X-Forwarded-Encrypted: i=1; AFNElJ9S+MmNAknHy6zUQJLu89nLVtq9azNJfZROhX3EfoCPTvX2eD99g+MF5hkyBa8Gv/EKO0GW9k/X9PpmlDd5io8veRs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzfCdMeHWnDWPZHOPGNDpN/TfGwURqXa42VtPMBb/l8BwT4FrX+
	tnxvpR3R0Ih4FXXWwbZ6XqJkIKP8M7X+J9ViSyiE5lwrkXsHLFtZ0+Vl
X-Gm-Gg: Acq92OFDwAJW7P7lsAPMmu5FsYGdRzwqfcMyCNqeQGwZ83U2Z+jUZkZA/UlUWSg7jhr
	pmxNlDGbXsYk8m051TdLo8uYEPRYlwrJMdXA+cuJfLWwKB2k8vs8jN7aXlRMxSF9KWdx9g8JBSE
	uRbdHgwePxr6D3p5gw0wbaNy8ai+RnXzgLM9mlt4ljAo3kzgW7vyoV5NMaB1jt55VezRi6Kg3aO
	TNKleaGtO5npC5fugTz8r6ha1UFK5o1KvynJKV/FlSfi6qc9TZ+LEmeza6UmpSU4j220QZStWKn
	nDOCh3xtpAFT+5W7fnJHrQh1BWW2g7KtiCiBpL6mQs6wyWR+RtSVc++Jsk8O5p12C5Kvh6lHThG
	2ZKeg8KVBdMLiXBghoWXKMgqCi7Qzi/4EAwwDsFMZ2xLQid+f+n6IAsLU1AIDtYZimw6i6omZ
X-Received: by 2002:a05:6000:1789:b0:44a:47a4:ce91 with SMTP id ffacd0b85a97d-45c5a0b17b3mr3705255f8f.25.1778664907126;
        Wed, 13 May 2026 02:35:07 -0700 (PDT)
Received: from krava ([2a02:8308:a00c:e200::e257])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45491ca383asm38154500f8f.28.2026.05.13.02.35.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 02:35:06 -0700 (PDT)
From: Jiri Olsa <olsajiri@gmail.com>
X-Google-Original-From: Jiri Olsa <jolsa@kernel.org>
Date: Wed, 13 May 2026 11:35:05 +0200
To: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Cc: Alexei Starovoitov <alexei.starovoitov@gmail.com>,
	Jiri Olsa <olsajiri@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	Oleg Nesterov <oleg@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH bpf 1/2] uprobes/x86: Fix red zone clobbering in nop5
 optimization
Message-ID: <agRFyY-iLk_7CKd_@krava>
References: <20260509003146.976844-1-andrii@kernel.org>
 <agD3xq2MUyskd7X-@krava>
 <20260512141431.a70375744fdae263bda5b722@kernel.org>
 <agNeEzjiThzmJHiP@krava>
 <CAADnVQLfgxEzpSTLhsxN2BYWpSxJ+RYku03UMfrSTi4Abu5SBw@mail.gmail.com>
 <CAEf4Bza4sqLw8GHoq+MFBgsnhiJ_s91UUrMcA-paYeBr7=bz0A@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEf4Bza4sqLw8GHoq+MFBgsnhiJ_s91UUrMcA-paYeBr7=bz0A@mail.gmail.com>

On Tue, May 12, 2026 at 12:38:34PM -0700, Andrii Nakryiko wrote:
> On Tue, May 12, 2026 at 12:27 PM Alexei Starovoitov
> <alexei.starovoitov@gmail.com> wrote:
> >
> > On Tue, May 12, 2026 at 10:07 AM Jiri Olsa <olsajiri@gmail.com> wrote:
> > >
> > > +       /*
> > > +        * We have nop10 (with first byte overwritten to int3),
> > > +        * change it to:
> > > +        *   lea 0x80(%rsp), %rsp
> > > +        *   call tramp
> > > +        *
> > > +        * The first lea instruction skips the stack redzone so the call
> > > +        * instruction can safely push return address on stack.
> > > +        */
> >
> > typo: lea -128(%rsp), %rsp

ugh, thanks

> >
> > you can also do:
> >
> > add $-128, %rsp + call tramp = 4 + 5 = 9 bytes instead of 10.
> 
> When I asked AI about this it explained that add instruction modifies
> flags, so it's not a good fit here. lea doesn't touch flags.
> 
> >
> > Initially I didn't like this approach, since we just introduced
> > usdt nop5 and now need to recompile everything again,
> > but looking at the fix it's definitely simpler than alternatives
> > and doesn't have annoying limitations.
> 
> 
> yeah, limitations are annoying, especially with those global "DO NOT
> OPTIMIZE" flags... Jiri, let's polish your version and land it?

ok, will send it out

jirka
