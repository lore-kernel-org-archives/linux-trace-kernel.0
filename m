Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D44082BDC34
	for <linux-trace-kernel@vger.kernel.org>; Fri,  7 Nov 2025 13:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762520926; cv=none; b=b5y6x1ZfFuCu5Nlgp4zTzrFmkdBoSPic5Z+B4qWIMt9k9J6FTTXzIcib5U9RvR9XlchxkcR4CG/1+EB8Xfe2xGBtKoESpnjUUUj/VNN/FVk5oLv1vDZlKnBrI5SEryvQZ9JPPmLE1SACwQEW7+ReOOdP6Cw5ja1xWtsTYOjG9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762520926; c=relaxed/simple;
	bh=OWiEd8XbPv8RdYmPKuplSxpJVZGnRYjpmY5XLgep+8c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=n9wghAN7vEWHtetF9ra7Fk6D5JnNvQUaxzQp2KqF+x5fJ0oQVyxJYjDQR0BVBx7+Hf0sma+VB8QTC8HsVVLnA0o4ls+kCnA3NYTTpI6jKV3Q/ZzI0ipNclez3KrqUs7fvwavnVDIjBSVGBJxkRSNpQBfueIF91NxqD0Eg+eTw9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=BupN8VM9; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="BupN8VM9"
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-64080ccf749so1243912a12.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 07 Nov 2025 05:08:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1762520923; x=1763125723; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C1ywOlu3fOSK5EDS/96Lv9KyExdYs4hdjZJBrhwyZV0=;
        b=BupN8VM9+coHpMkoRAxsJOTc5Rp4vj4FXlg+/oDipm87kfldmi9RZo4b2Ib1OXVSQb
         E2avwPk3CHm88DmnhQAv6bB2WJFQqU6BDKEdzvMfoLwAuKNpCbsiiN3DCQPUN1NRVCjh
         qa5SMJQh27m+8e1VL9EkmxPaPO3eoqVCvdfqGQAxswXjGAk2wGZTI1El88FuMAw+N1RX
         y7CrHujXk5aTA1cbkBVPZvvHKXeXc5fWp8ezWBQXzi2LEC6MG2molG4R2me7EBjYz+qd
         37ej3/IY4jqzfUZqZCfTDlIM71qH9EDqJPxhXEEobynZdXxUrlnI5xUq8r8T67mmoevH
         os+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762520923; x=1763125723;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1ywOlu3fOSK5EDS/96Lv9KyExdYs4hdjZJBrhwyZV0=;
        b=JgiJ7P79BxzbJSccIz+l32zbtZyg1bUog/bnEiUwxV40R2Q3ayAFWk04rcsqiCCT0Y
         gmr9cp+AgJWIQAr2IvNjgKhXjJj4dQgsWnqWCTSAYXbbRk5dP3p6X8mKJreHuteZcbiq
         +0ke7dBrP+ztvc6cTjk678mXjQqtddsltSOG6GMU88eoIqaE39kCiwlHt70h7wgkE6p0
         3PcEOuDrN4hpBIoXKIh3PcjpM5XpLIQRNFrQHsUU935oQfQo4maPrgkdR6lmnwkLOGRY
         zxvS+Sc6Ic+fkKxLAAIrIeewGrQk3NIcYUjWbd6yEQbiTG/v1ogHefoG47kGhxd1StQc
         YcKg==
X-Forwarded-Encrypted: i=1; AJvYcCUMuIFNylEVVIzZBxx8DDPv2aEb9yhK0izjyTttMAtPXvANHU+4b0c52t6bWy/9isznH1e9ttN8qizlUNr9sQzsef0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjYsPOsgZJJqfGrhg0JfFBlyJ5vBbAmN894Q40no3vx0vkbF+9
	ZfthcYp6YrcAi+DYMfJesxnG834Vx4N5JvOdc8t+UOedl2MrrjVs3o6KM1o8k+Xbtkk=
X-Gm-Gg: ASbGncuk/rORi7XeSeRZ0hvz+rA28Q1l0rQrHV2ceRrtdU50y0ALXrbVfNlec1gsCBF
	ubPVQR3oIZdDJ1UVtztpzG4+p63fVdPLNpQdhDA3wy0BgdZ/Y9YMS3ovrnJpn2i7KDUvb3GW9Fo
	r+BZVMxgybrMgYSLEn63ptuRoJABWvoqLmvRYXIxg+HSySaYeGqr+1v0iglHIQcVZ3ZkX9ZPQbV
	LB71YxAa1oJe2haRz3jb7UjI5O8ESeCHR65Sw5uPlVRUWyIYtijoCyxe9DotCQt7bV6dvQ8qptf
	vxihVTknYIYsBfjWBk2/QMgp0PCbcpUg0KvuS9UgnEhU0z6FgISwMoRORtSbOBBr/h1nyZoj3S2
	mFxy/ZEVlyuw24dQdXxypmnzLhlQj+kXPYG2+k2DFMoVHBx4HU86d9e2z43Uj55e2yh3Jd76eGp
	DFXvn0SBoTy72xKw==
X-Google-Smtp-Source: AGHT+IEouSTBDMcG/tchDfHpDvHcGOn021q8OTyah/7d7vm3vufHhiqKNCiTpyQWqwWHE044VaVj4Q==
X-Received: by 2002:a05:6402:90a:b0:640:9b11:5d65 with SMTP id 4fb4d7f45d1cf-6413f061d7fmr2900743a12.24.1762520923128;
        Fri, 07 Nov 2025 05:08:43 -0800 (PST)
Received: from pathway.suse.cz ([176.114.240.130])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6411f71394csm3968988a12.6.2025.11.07.05.08.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 05:08:42 -0800 (PST)
Date: Fri, 7 Nov 2025 14:08:40 +0100
From: Petr Mladek <pmladek@suse.com>
To: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Cc: Petr Pavlu <petr.pavlu@suse.com>, Steven Rostedt <rostedt@goodmis.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Daniel Gomez <da.gomez@kernel.org>,
	Sami Tolvanen <samitolvanen@google.com>,
	LKML <linux-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>,
	linux-modules@vger.kernel.org,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/6] kallsyms/bpf: Set module buildid in
 bpf_address_lookup()
Message-ID: <aQ3vWIqG31BgE4YD@pathway.suse.cz>
References: <20251105142319.1139183-1-pmladek@suse.com>
 <20251105142319.1139183-4-pmladek@suse.com>
 <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAADnVQ+kbQ4uwtKjD1DRCf702v0rEthy6hU4COAU9CyU53wTHg@mail.gmail.com>

On Wed 2025-11-05 18:53:23, Alexei Starovoitov wrote:
> On Wed, Nov 5, 2025 at 6:24 AM Petr Mladek <pmladek@suse.com> wrote:
> >
> > Make bpf_address_lookup() compatible with module_address_lookup()
> > and clear the pointer to @modbuildid together with @modname.
> >
> > It is not strictly needed because __sprint_symbol() reads @modbuildid
> > only when @modname is set. But better be on the safe side and make
> > the API more safe.
> >
> > Fixes: 9294523e3768 ("module: add printk formats to add module build ID to stacktraces")
> > Signed-off-by: Petr Mladek <pmladek@suse.com>
> > ---
> >  include/linux/filter.h | 15 +++++++++++----
> >  kernel/kallsyms.c      |  4 ++--
> >  2 files changed, 13 insertions(+), 6 deletions(-)
> >
> > diff --git a/include/linux/filter.h b/include/linux/filter.h
> > index f5c859b8131a..b7b95840250a 100644
> > --- a/include/linux/filter.h
> > +++ b/include/linux/filter.h
> > @@ -1362,12 +1362,18 @@ struct bpf_prog *bpf_prog_ksym_find(unsigned long addr);
> >
> >  static inline int
> >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > -                  unsigned long *off, char **modname, char *sym)
> > +                  unsigned long *off, char **modname,
> > +                  const unsigned char **modbuildid, char *sym)
> >  {
> >         int ret = __bpf_address_lookup(addr, size, off, sym);
> >
> > -       if (ret && modname)
> > -               *modname = NULL;
> > +       if (ret) {
> > +               if (modname)
> > +                       *modname = NULL;
> > +               if (modbuildid)
> > +                       *modbuildid = NULL;
> > +       }
> > +
> >         return ret;
> >  }
> >
> > @@ -1433,7 +1439,8 @@ static inline struct bpf_prog *bpf_prog_ksym_find(unsigned long addr)
> >
> >  static inline int
> >  bpf_address_lookup(unsigned long addr, unsigned long *size,
> > -                  unsigned long *off, char **modname, char *sym)
> > +                  unsigned long *off, char **modname,
> > +                  const unsigned char **modbuildid, char *sym)
> >  {
> >         return 0;
> >  }
> > diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
> > index 9455e3bb07fc..efb12b077220 100644
> > --- a/kernel/kallsyms.c
> > +++ b/kernel/kallsyms.c
> > @@ -374,8 +374,8 @@ static int kallsyms_lookup_buildid(unsigned long addr,
> >         ret = module_address_lookup(addr, symbolsize, offset,
> >                                     modname, modbuildid, namebuf);
> >         if (!ret)
> > -               ret = bpf_address_lookup(addr, symbolsize,
> > -                                        offset, modname, namebuf);
> > +               ret = bpf_address_lookup(addr, symbolsize, offset,
> > +                                        modname, modbuildid, namebuf);
> 
> The initial bpf_address_lookup() 8 years ago was trying
> to copy paste args and style of kallsyms_lookup().
> It was odd back then. This change is doubling down on the wrong thing.
> It's really odd to pass a pointer into bpf_address_lookup()
> so it zero initializes it.
> bpf ksyms are in the core kernel. They're never in modules.
> Just call __bpf_address_lookup() here and remove the wrapper.

I agree that it is ugly. It would make sense to initialize the
pointers in kallsyms_lookup_buildid and call there
__bpf_address_lookup() variant. Something like:

static int kallsyms_lookup_buildid(unsigned long addr,
			unsigned long *symbolsize,
			unsigned long *offset, char **modname,
			const unsigned char **modbuildid, char *namebuf)
{
	int ret;

	if (modname)
		*modname = NULL;
	if (modbuildid)
		*modbuildid = NULL;
	namebuf[0] = 0;
[...]
	if (!ret)
		ret = __bpf_address_lookup(addr, symbolsize, offset, namebuf);

}

As a result bpf_address_lookup() won't have any caller.
And __bpf_address_lookup() would have two callers.

It would make sense to remove bpf_address_lookup() and
rename __bpf_address_lookup() to bpf_address_lookup().

How does that sound?
Would you prefer to do this in one patch or in two steps, please?

Best Regards,
Petr
