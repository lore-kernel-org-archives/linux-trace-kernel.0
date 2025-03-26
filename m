Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B1D2940D
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Mar 2025 01:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742951248; cv=none; b=czN6YO4/I6HG2/PQ14UtvqWopgOD0QpR8RmdNcUDpQVdbl6kWbpNAFSsRDK0pEUQqPFtqDEni7e/jvyw3y18JUQLHGhpz3Rh1w7AT5WsiVw+u+Y8nvczTncFUnHZh3y+IpDNc/5bREv8hQmZeQ67GuCqjdA6HwGc+Ny6N1xLc58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742951248; c=relaxed/simple;
	bh=GB7EpVcR6NEX2lBOtj62/LJ/2M9DQsTZoztmOUYMKyc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AHbKKTG8Y7L4DU89KSkmYNq4SIimBcx4wvkyvm/G6ZefzM/igAQGb2liFpy+lTxim9u/Kbdl6+rcNIeUSRYbtr0hQpiDWQxIVkKUlqaJCZGeGGzfZLjPMNav2D1GCeoULFX5Orh8gU4BuDRgnSlAv38C7cZP/jCyNLrFRfEiMBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=k3yXd/TA; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="k3yXd/TA"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-54acc0cd458so6647041e87.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 18:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1742951244; x=1743556044; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebWObAEjDwTa1ZALP9z9XN5mnKCveRcG/gIaI1Y+RbU=;
        b=k3yXd/TAWtGzh+qyy6x9v72uxzUAZZWa5JFrg/SSglVWogakFQC9FScVGqoIcq3804
         kSgRyu2AhrPvUxgBPCA2OjSlVZMW2PeYlZmbE22J5qqKaHAspAP7sXbUM2bhmtd9PenV
         r9XsIUavf7YQyCK0q58303N1sZP8mJczhamHyZzdxB69Ir7UH0WkS9dyJcqTXO3xCnC/
         fNK/lnJEfmkxuQ0nUTWvXbH/n08Y9O1G0yx1K6/SgFlfvExgzlmbs7aJJL3sg78wSkIn
         CN0MRTXqdGF0Es1fjiEQCGYkpgppvVQM9NHPWBGJIGH6Cq59f/ypY5REyhsJ01waQ88W
         7JnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742951244; x=1743556044;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebWObAEjDwTa1ZALP9z9XN5mnKCveRcG/gIaI1Y+RbU=;
        b=JQ7FvAAiyAqnn6zXbT75xYbEvXt/XCTrogvtEYXBVfApWmz9LxVU6EriLPSOMKWH+l
         XPC0J/nEkYPjzf46bAQUNBUfH4fQXeRHDX41bjKbT7uaxAIDyEMpaGsN0Y987f3I/xyH
         8xgEDevyMbYKnvvjaP9xGAglx+QLeJ1gg/kLokCTfIbvsmQBcpn2yFwCuum+s+Mo0meL
         d6oJsQVDLUrCLzvzJZyLV2Qn9KEYdG4YVQmCANppctKs2pe5H3RK0SbogwNyPwqRE20v
         AJWpue2kkkWODw+rtuscASIMKUEvR1RorEAMM4zT8zAYUqbgA9GXuaJT2XWdcOrC6sMO
         OA4A==
X-Forwarded-Encrypted: i=1; AJvYcCWhopquThMkTykyfsG4ED3I6mfOtYHRAv6Z716sTTxBRh0qacDAg4ECva9fmCbhn74EfXFVCdit84asQUdu2Yv/nSs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNGpypGWtivxOyQLLIIFLc4wKFcKdnek2tMc80T053tv+ik4LP
	/gJ4OhrjLferGTfPELU2cRtYUNoEB3AVnZcgMFjuXCv9D3GtzAUIN6BVLbn7w5S0O8cKnuqCXTA
	6a2ZTAsIgPnsxLIi4katqMpj38vdrygkYwYN7
X-Gm-Gg: ASbGncuox0hls03grQ6vvQNExKlY0WHXdEJ3CAxGL4AbGngbs2XN+IFQBhjNuwYP3TS
	ab6LSiJUW8GiuUc2q3RIAZoJk7PbHnJUMlIrQAsbQta7+GzF/mn7PMjMqrL/Fjto1R7/Utmm/jm
	Y0XEeuzgqYyJx4I8JfCkibUq3SrIhpw581UQBmfeHZjzZynVsCD8mXq/10YN/r
X-Google-Smtp-Source: AGHT+IH7TM3F7jlmDsLKgKzqrF23j/7sETlcRtQxbTMm204UEDEJhjFOyrdMaWA1XVoAAzd5aqRVszwqj2x01XHjlF8=
X-Received: by 2002:a05:6512:ea2:b0:544:ffbe:cd22 with SMTP id
 2adb3069b0e04-54ad6500d8fmr6121822e87.46.1742951244095; Tue, 25 Mar 2025
 18:07:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CABEuK17=Y8LsLhiHXgcr7jOp2UF3YCGkQoAyQu8gTVJ5DHPN0w@mail.gmail.com>
 <20250326001122.421996-2-s.gupta@arista.com> <2025032553-celibacy-underpaid-faeb@gregkh>
 <20250325203236.3c6a19f4@batman.local.home> <20250325203723.53d3afde@batman.local.home>
 <2025032554-compile-unlivable-0fb4@gregkh> <20250325204731.24f26003@batman.local.home>
In-Reply-To: <20250325204731.24f26003@batman.local.home>
From: Sahil Gupta <s.gupta@arista.com>
Date: Tue, 25 Mar 2025 20:07:11 -0500
X-Gm-Features: AQ5f1JotQJGJL-wOpQ-ndkNWku8ztpt_4hyBcJOSYGJ9gDDIUlBux6XX0Yi5PWc
Message-ID: <CABEuK16RdmvpbK5CpcuYrzdo_1GK-8eUkmb5x1BKk9bPcw3weA@mail.gmail.com>
Subject: Re: [PATCH 6.1 6.6 6.12 6.13] scripts/sorttable: fix ELF64 mcount_loc
 address parsing when compiling on 32-bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Greg KH <gregkh@linuxfoundation.org>, stable@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Safonov <dima@arista.com>, 
	Kevin Mitchell <kevmitch@arista.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Works for me. At least from our previous discussion, it seemed like
backporting would be laborious, which is why I offered this
alternative patch. But if we can just backport the series, then
there's no reason to not do so.

Thanks,
Sahil

On Tue, Mar 25, 2025 at 7:47=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Tue, 25 Mar 2025 20:45:00 -0400
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > On Tue, Mar 25, 2025 at 08:37:23PM -0400, Steven Rostedt wrote:
> > > On Tue, 25 Mar 2025 20:32:36 -0400
> > > Steven Rostedt <rostedt@goodmis.org> wrote:
> > >
> > > > I guess it is loosely based on 4acda8edefa1 ("scripts/sorttable: Ge=
t
> > > > start/stop_mcount_loc from ELF file directly"), which may take a bi=
t of
> > > > work to backport (or we just add everything that this commit depend=
s on).
> > >
> > > And looking at what was done, it was my rewrite of the sorttable.c co=
de.
> > >
> > > If it's OK to backport a rewrite, then we could just do that.
> > >
> > > See commits:
> > >
> > >   4f48a28b37d5 scripts/sorttable: Remove unused write functions
> > >   7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two fun=
ctions
> > >   157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
> > >   545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
> > >   200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a uni=
on
> > >   1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
> > >   67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
> > >   17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
> > >   58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sor=
ttable.c
> >
> > Backport away!
>
> Actually, I only did a git log on scripts/sorttable.c. I left out
> sorttable.h which gives me this list:
>
> $ git log --pretty=3Doneline --abbrev-commit --reverse v6.12..4acda8edefa=
1ce66d3de845f1c12745721cd14c3 scripts/sorttable.[ch]
>
> 0210d251162f scripts/sorttable: fix orc_sort_cmp() to maintain symmetry a=
nd transitivity
> 28b24394c6e9 scripts/sorttable: Remove unused macro defines
> 4f48a28b37d5 scripts/sorttable: Remove unused write functions
> 6f2c2f93a190 scripts/sorttable: Remove unneeded Elf_Rel
> 66990c003306 scripts/sorttable: Have the ORC code use the _r() functions =
to read
> 7ffc0d0819f4 scripts/sorttable: Make compare_extable() into two functions
> 157fb5b3cfd2 scripts/sorttable: Convert Elf_Ehdr to union
> 545f6cf8f4c9 scripts/sorttable: Replace Elf_Shdr Macro with a union
> 200d015e73b4 scripts/sorttable: Convert Elf_Sym MACRO over to a union
> 1dfb59a228dd scripts/sorttable: Add helper functions for Elf_Ehdr
> 67afb7f50440 scripts/sorttable: Add helper functions for Elf_Shdr
> 17bed33ac12f scripts/sorttable: Add helper functions for Elf_Sym
> 1b649e6ab8dc scripts/sorttable: Use uint64_t for mcount sorting
> 58d87678a0f4 scripts/sorttable: Move code from sorttable.h into sorttable=
.c
> 4acda8edefa1 scripts/sorttable: Get start/stop_mcount_loc from ELF file d=
irectly
>
> -- Steve
