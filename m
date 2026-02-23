Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46C563321C7
	for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 17:36:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771868202; cv=pass; b=TdQzwT9qi6M4Q+3VDHdXp1NRBE0+yn9JqzSUtHXcKCTJCMwqZXdHV+0oZIUS8EIy46H45AauhaC5GSCkfYBHbo/37lzxIQ5sQF7H/Tq9k+DR/vtIa10Nhn3BnkrY0m1o/qPg7F9GOSddlZnA7yoMD00Auvu0BWtBppgRxSJ1v7Q=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771868202; c=relaxed/simple;
	bh=svfS4izL4CtR6CtOwfQ7zAKovDrwRwY4LcCnG72rreM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QNhVdaxgDVCIh4ql2cMHO1V1bYjhwhlx/OOnbglzd4Vc1HC0MglqWQDurPCPs8D5r7ylI8VUkS24f9z17W2+169Tm5PihMJcJStSGCw+LiZZKr1r3AJ382/xgfMajvoTMy6lx/sBONYmRQVpOki+jHoYHQuTMrjwS2Vg9K/SGUg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPZxXMEJ; arc=pass smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPZxXMEJ"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6597a7bd7d6so6154126a12.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 23 Feb 2026 09:36:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771868198; cv=none;
        d=google.com; s=arc-20240605;
        b=Xsb2JreITidHYV1TwjFQTjKVb7To2j6vEbHTq70XgxHGE77ChfKct7W+CPNlPq8VV1
         ZXgq7xN0krRGzcQOjyPnvj2yqVRo87vjQoGBF+TQ/5t87t7f7Wd16HvrK1E0W31xevKp
         fwaUxOgmzfL6uX169n2nAV9l63DqbMDXMtLSEkoRjKWsltS7ZIyu1zTw5t21IMSFVZ1Y
         uBovVN/9w66XugI3GaoMl9p0vcPEwUAArdNOFOGhJIl3D2x/qs87Tc8yA5DiegEzfo0Q
         daIQHD8we9UC+AQNi7LNlE/TCgczmsBMUtazvNItikjgwJwm/E/PaHzwqx9rwjHqUVA+
         GIpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=XE3aRuDhBpmNR3/dCAv6GjOuayZDtG3XM23vAdRzhV0=;
        fh=6vkcy/ram+mW0etbej+2Wcq4DrTBDHUFdG23gmFIwKI=;
        b=B+tCqafGZMR1xjjbp9or3g/BIlWtz4N8hiiFT0vE//JA9RTFJStQHcOftI9VO1qlBK
         2k+H1WviRhspKsfEVy6DADTNs+jPEQ8pFSvlwUAPXnGaj07jw5QPhAeVH/IUOVhDDQb4
         I/smPX6VVF3nox3e4L4C9LCPhutjPKq4kYi644ubOJZkh632XwKxE/cSMKAAvabuoqHB
         MVlXySxAnhm6cLAHHFVs0Cmwz/VK2AFBj5mXiRBQzTzWL8Qoyj0g0GuQBil6zR+nZunK
         A4x5olpPz4mi1r9RpKoNAwIC5fSln7xU11H/tftv3BKY1aBcha8+VEqANdqsKtXjmk8G
         KGtg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771868198; x=1772472998; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XE3aRuDhBpmNR3/dCAv6GjOuayZDtG3XM23vAdRzhV0=;
        b=JPZxXMEJAhCdwdjyRFlLOL2O9sXpR6xBj0lxYH5hRICcsnZ3irUI6tKnaWem9p9McT
         BPcgBnTCmU+6XrurmhndXf6V+TqfDuD54wHJqBC/8XUPnzDNPKaBw2Qy4a8RIgPG8DTA
         wYHaHL3/LSMHSCJlAHUEHPIiKcVmVieZ23/TgVQH+jAtx4YZrud2rsYBfiKRFAh8eupi
         U/DaEkl/uK5QXLK9KzPaSIi9cpjg2hf+JJpdeM8oX763xdF9MHC3opFDXkqecbGYBPrc
         N+i6jn+L0TtNY0hNkv7W2qEaYykrZylZ/ZJeqEqJ/Zrhi6RZXIs0GX36FZqiai9kHmIO
         wy9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771868198; x=1772472998;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XE3aRuDhBpmNR3/dCAv6GjOuayZDtG3XM23vAdRzhV0=;
        b=h2AtKZwGsXz+bxgA6xOUKRSgbkrfKz+RT8MCSIVk4l4x5usvLMShHVoxZXSQFTEH9I
         mNmsZGBSDzOMihUGazjma/S+8LWAu14i5d/LVZQPbj9yuNjZ0xIRX1rIy6FVFfi66Ifp
         IaQsDSwLTjCpvWgV9623OvhvvGPYGQqoPJTsaE8B8ifPEUXPXJyQyV1o+m1DYa/NkFNr
         tMivT5yFtrUSmlzVcSKifIdeUEXg5YnKEY8JlGJ9H+Iq1V5gPl3Q2GU0BRxl4C1jO/tP
         Ski1RlZ02B5JUks/4TfjnmvvKY5UhdohRmrdfV8kzNaGgkOgvQO5NqNRWyyrz/yqzHi0
         qeew==
X-Forwarded-Encrypted: i=1; AJvYcCW54tERwZnE51iLeqTeUnS7bHt5aqj+p5kfr6iRB2pQn7XbnAWy4ifXVrJCGEO9kNLrHngFUbm6pquj8alIeMz0RDg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpxWmkIR1D1ljxeMT84Zott9wpZRp2KcuhU+4GTpPRKcQhgVLC
	VqAXlMQYsnyk5kKT5ejFB/ibfcFP12t646vFDTUXEswjftmJfU3kS2dc0r9aP4CB5FyGk8kfuCj
	wectOG9h70iKJhbgFwmfMEjQlNzcEDIE=
X-Gm-Gg: ATEYQzxmwFGxAFTQNv0vwnDHzo0PUssAENuvxsbyW9k9DwYBpwk93llnK6U9QTqhcB/
	E583fx5vQHEqGuhIxmXjr3p2wQQzZHa90CpYHjm/K4B8+y/XzdW+Soj2+MX9mxMyhk1bp0gQnjQ
	Il/w5Ti1pvG28QTlcqOXx1ttk7F8QA9HCoXM/DJl4Alc/qyCV6uVbIxm+gMFlkZhAMjGMOhra2+
	LArZWRh/xiNobyQkE3JmsjAYMlL0qINEg4mHH7yAgBz+p0SzTORVOl6a13aU7Dq/TUiwIWTztb+
	sH/Th+d2
X-Received: by 2002:a17:906:e286:b0:b73:2b08:ac70 with SMTP id
 a640c23a62f3a-b9081bbf581mr431440366b.49.1771868198166; Mon, 23 Feb 2026
 09:36:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250407180838.42877-1-andybnac@gmail.com> <20250407180838.42877-10-andybnac@gmail.com>
 <20260221-repeal-emphatic-ddc2e9b94208@spud> <CANk7y0iTjHUBK66xx50b-eT=ssz9g0moFjOhCmipQC1SzkGs5g@mail.gmail.com>
 <20260223-respect-chaste-60c3403b5bc9@wendy> <CANk7y0jdzCeFaLVpj6-mnWiSZvv+rJF=9kgWDYF7g_rjCpiYsw@mail.gmail.com>
 <20260223-garlic-sulphuric-0c1574608d09@spud>
In-Reply-To: <20260223-garlic-sulphuric-0c1574608d09@spud>
From: Puranjay Mohan <puranjay12@gmail.com>
Date: Mon, 23 Feb 2026 17:36:24 +0000
X-Gm-Features: AaiRm52Y5X8NepG34m2dFfJzvs_KysOs_RCa-fhWauLxea9ysucuctUwLTWqJdM
Message-ID: <CANk7y0iokvWz==XQ67v3aztQ268WVmud22Y4gp-dPd4SrFhzMQ@mail.gmail.com>
Subject: Re: [PATCH v4 10/12] riscv: Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS
To: Conor Dooley <conor@kernel.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, Andy Chiu <andybnac@gmail.com>, 
	linux-riscv@lists.infradead.org, alexghiti@rivosinc.com, palmer@dabbelt.com, 
	=?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@rivosinc.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Alexandre Ghiti <alex@ghiti.fr>, Mark Rutland <mark.rutland@arm.com>, paul.walmsley@sifive.com, 
	greentime.hu@sifive.com, nick.hu@sifive.com, nylon.chen@sifive.com, 
	eric.lin@sifive.com, vicent.chen@sifive.com, zong.li@sifive.com, 
	yongxuan.wang@sifive.com, samuel.holland@sifive.com, olivia.chu@sifive.com, 
	c2232430@gmail.com, arnd@arndb.de, Sami Tolvanen <samitolvanen@google.com>, 
	Kees Cook <kees@kernel.org>, Nathan Chancellor <nathan@kernel.org>, llvm@lists.linux.dev, 
	pjw@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 23, 2026 at 4:29=E2=80=AFPM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Mon, Feb 23, 2026 at 03:41:26PM +0000, Puranjay Mohan wrote:
> > On Mon, Feb 23, 2026 at 3:28=E2=80=AFPM Conor Dooley <conor.dooley@micr=
ochip.com> wrote:
> > >
> > > On Mon, Feb 23, 2026 at 03:18:17PM +0000, Puranjay Mohan wrote:
> > > > On Sat, Feb 21, 2026 at 12:15=E2=80=AFPM Conor Dooley <conor@kernel=
.org> wrote:
> > > > >
> > > > > Hey,
> > > > >
> > > > > On Tue, Apr 08, 2025 at 02:08:34AM +0800, Andy Chiu wrote:
> > > > > > From: Puranjay Mohan <puranjay12@gmail.com>
> > > > > >
> > > > > > This patch enables support for DYNAMIC_FTRACE_WITH_CALL_OPS on =
RISC-V.
> > > > > > This allows each ftrace callsite to provide an ftrace_ops to th=
e common
> > > > > > ftrace trampoline, allowing each callsite to invoke distinct tr=
acer
> > > > > > functions without the need to fall back to list processing or t=
o
> > > > > > allocate custom trampolines for each callsite. This significant=
ly speeds
> > > > > > up cases where multiple distinct trace functions are used and c=
allsites
> > > > > > are mostly traced by a single tracer.
>
> > > > > >
> > > > > > Signed-off-by: Puranjay Mohan <puranjay12@gmail.com>
> > > > > >
> > > > > > [update kconfig, asm, refactor]
> > > > > >
> > > > > > Signed-off-by: Andy Chiu <andybnac@gmail.com>
> > > > > > Tested-by: Bj=C3=B6rn T=C3=B6pel <bjorn@rivosinc.com>
> > > > >
> > > > > I bisected a boot failure to this commit [c217157bcd1df ("riscv:
> > > > > Implement HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS")] yesterday, that ap=
pears
> > > > > to be affecting all LLVM versions that I currently have installed=
. From
> > > > > some initial testing of Kconfig options, it looks like the issue =
is
> > > > > CFI_CLANG related because when I disable CFI_CLANG things work on=
ce
> > > > > more. Since this option depends on !CFI_CLANG, but is def_bool y,=
 I
> > > > > modified Kconfig to force disable it at all times and tested
> > > > > !DYNAMIC_FTRACE_WITH_CALL_OPS && !CFG_CLANG, which did boot.
> > > > >
> > > > > I dunno anything about what's going on in this patch, but so litt=
le in
> > > > > it relates to having DYNAMIC_FTRACE_WITH_CALL_OPS, that I was abl=
e to
> > > > > figure out that the problem is -fpatchable-function-entry=3D8,4
> > > > >
> > > >
> > > > DYNAMIC_FTRACE_WITH_CALL_OPS can't work together with CFI_CLANG.
> > > >
> > > > arm64 has:
> > > >
> > > > select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS \
> > > > if (DYNAMIC_FTRACE_WITH_ARGS && !CFI && \
> > > >    (CC_IS_CLANG || !CC_OPTIMIZE_FOR_SIZE))
> > > >
> > > > would need something similar for riscv if not already done.
> > >
> > >
> > > I think you've misunderstood my email. We already have:
> > >
> > >         select HAVE_DYNAMIC_FTRACE_WITH_CALL_OPS if (DYNAMIC_FTRACE_W=
ITH_ARGS && !CFI)
> > >
> > > The problem is that the patch broke using CFI_CLANG, due to the
> > > fpatchable-function-entry change.
> >
> >
> > Yeah, sorry I did not see the patch,
> > the original one I sent had:
> >
> > +ifeq ($(CONFIG_DYNAMIC_FTRACE_WITH_CALL_OPS), y)
> > +ifeq ($(CONFIG_RISCV_ISA_C),y)
> > + CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D8,4
> > +else
> > + CC_FLAGS_FTRACE :=3D -fpatchable-function-entry=3D4,2
> > +endif
> > +else
> >
> >
> > The basic Idea is that we can't put nops before the function entry
> > when using CFI_CLANG, because they both interfere with each other.
> >
> > the fix should be something like:
>
> Ye, this is what Nathan and I both did locally, give or take. I just
> wasn't sure if this was actually correct to do or if it was just
> papering over an issue with our CFI support. Do you want to send this as
> a patch?

Yes, I will send a patch with fixes tag.

Thanks,
Puranjay
