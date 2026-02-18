Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD3392F12DB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Feb 2026 16:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771433913; cv=pass; b=sG197enURUdpQTKlKfwlUXlwQmYKSBLUEVNltUTDw6MRiP+i6HST8o7dAZBreX8rqekuj1y9YvsaLyKMoovTJ/IsLvDUjcV6cWh3xFke97NEFflgNAkBnshFMLuFdDNRY6r7zgMUNRoIusm27N76a4+B68D4vVcirJmIhner3DI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771433913; c=relaxed/simple;
	bh=jajZKfDSGu49VB3lIo9/IdQJEo9/rlHOlV9X28L1Z24=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PeHNTIBsQsLSocUt+n+mfcG/7Y5+YVL2FWUw7KlkE/tlJsJ7hSKiN3Rp61isMNcamFFyOGXe/6FlSEe8kSSuGcydVCCVQ/vJK/wJD2mnubQtdUfPgq/uYYQzep40advEybw6oAl/vYBlALMdrtI3e1+0LIWt5BOUUspACJokl1Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mBHzJcni; arc=pass smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mBHzJcni"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b8f86167d39so15373766b.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Feb 2026 08:58:32 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771433911; cv=none;
        d=google.com; s=arc-20240605;
        b=gU8iSIZQjUmg+v1gPKeAXAAAdlHJmuhTX89eHwL01zsUehXSjj1MYS/PAloxfvqA0U
         iRNSf98MB5IyH7RD5Xw2xSIDLfSieqKfi4K7hf5IFE+vJEmujUkFcAjNAWreQQrSXshm
         4f3NT2Il+YxvhWJVRA8UayylBWqZyOMQDFsWdpXru9KcygcDdV46SdGvi80CMa5g24f6
         VHpF/3wggG7qNcg2qS+BqplDZ3Sh3DKcBTqAvARGC/9gzGo1HSjS5Qr19B36A+pO5SeU
         zyTgkRRSnzQgP5L2R5U+JYNE/qU68UJ8whSHc7+6EaHYOC7zHTTnVGo/zOvqtQYMK+62
         EY6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jajZKfDSGu49VB3lIo9/IdQJEo9/rlHOlV9X28L1Z24=;
        fh=oHO61crPImOh+YFngcg/rFOVZhoxqMNCCQPivmrq5wI=;
        b=Mr48Z+/NW2c7ze1/Jdl6zLTqOlrjqqEYb1UmRwBzesUB/XchjUiBj7J0uA9qaftCdM
         0/KTAjfrCTeaoufgCxSdkLIiYcorDQVi6Drvv3CJszyC7l8p7NGkKxGAn/6M2V19FvnH
         2bcyd8jC08O55/N+3gyB9wz+ApyDRmQEyFaUvy2Wj/u+zOWqQ2Cab10fOQJSXtij9zLo
         21K1zmYu4vZ74L84k/qK+X2tnQol9sErjxuBVPnUeWBfcBkGt+OL6Bk72b0v0HCxe3mI
         tCAmmv4741LaeCu4tuuNhKoV0n68le9Y+G1fhnAmVHf8pKqMbPL6K5PLkaNkmANInGFp
         qELg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771433911; x=1772038711; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jajZKfDSGu49VB3lIo9/IdQJEo9/rlHOlV9X28L1Z24=;
        b=mBHzJcnipNPZEeo/VSFxUIbYF3kCTKwz6OBmRmsWRHp6tC6PD6J/jJ8zeCP679+010
         QNpX4BccpLTT6/2faxiN+tkuI7plX8en8qH1vKJFXbCRIkaZ6ddqFKjBPapS36ZY4Z+S
         FePo8X9Gh+YVfdp6QkJl0+Nky6f9i1xoY4TDGEmuAj/ClOMXuIqpiQ8OTVhs0TVROEph
         lQqT+bidu/UaKBzys35o2YxCA2QBdYWZAw9VMf4/hA2YGeao7D2eRpK0+57mnhljvZ32
         xHXysq4Z9FTTTSVGDVuIa3k2KrAji6OKdS7eqAHv2lPQPudtZ3bkTTInrdJYsOxRsbdR
         0I7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771433911; x=1772038711;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jajZKfDSGu49VB3lIo9/IdQJEo9/rlHOlV9X28L1Z24=;
        b=FkPv336J3HEgrouQDVU3tt8F827MnHWoA/hL3SN6jJIEEFK8QJwjceU0QfAgMVhwZr
         sP7x9QvXn177f16KSghzZ+v6P0lzSjbFS2XI0Esqfu/qm1yCXy1p8J2NlYDI8EbtVYnT
         3VVdMBB8Y1Xp8nuP+NAgfijr54xAfKd78Bj703JhKPE55gWpdmY8nzf6OUCe+6pl5NlD
         VG/ct3YSi6yQJpFrXDht5YSd2vBGNjO3GBiHqYmZohZfY5fmn0iTLROKGiHOGAnyNBKO
         lfgH8JZuyCRwyc0sshtEAwLqnTIdUJ0eh2ZLAxbciVBBe2jddZBLQzds152UG6epKKlY
         wPLw==
X-Forwarded-Encrypted: i=1; AJvYcCUrbFT1uf48YiJDOPGE5811BlxvYCetu6fAZdEi2Xwgk+GMJjRYOauNSnJcg/JetR1OrEhgme2c+IlBUI7R1AVYliI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzr8wUPNPLqaGneHuF3kVIKuhDZ0NxKXr+9PwtiDYW26wCjZUdT
	uZQUPyjII6G8hHWRf6tTvyaCC6etZRENzuf7gvOMfjftsffO1GhX49+Z3Nnlqx2RaKj8tdoulZl
	yV+UwpXLu3zsYs7FywVuQU4IW7POPmyQ=
X-Gm-Gg: AZuq6aIrcj8qhu3d2ZnH5UydfPmeLD4cRRCP/h2u7u15hy6xtoyuWOuZWLn8ACuOqmW
	vNLUUfQ6Hg7KhMWPv15/4yMr7bnft/K9YoK03eaBeZx579O2X4iYiPLRJwZzr83XIpGFyX0HMMv
	KS7p+6MP9ROSapDD8osnhipC7mo47tiwOgAyDSAjhD2iRierkVhPrL4yB8JmL0HyuWWC+iuh2Lx
	oOyTJikihvpuy47PY+walyI6Mft09ZXgaj6762VGZdHWYzIcuU13eE9IaKFhpwRLqrqZI7EnnJ3
	EDxbAXfrgcNmR2mAeuE=
X-Received: by 2002:a17:906:dc93:b0:b77:1b05:a081 with SMTP id
 a640c23a62f3a-b903db5accfmr156343166b.27.1771433910831; Wed, 18 Feb 2026
 08:58:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260218144735.24307-1-ellyesparza8@gmail.com>
 <0c5396b5-f084-4ade-adc9-029037031eea@intel.com> <20260218105204.3af7251e@gandalf.local.home>
In-Reply-To: <20260218105204.3af7251e@gandalf.local.home>
From: ellyndra <ellyesparza8@gmail.com>
Date: Wed, 18 Feb 2026 13:58:18 -0300
X-Gm-Features: AaiRm51mjRF9l01xwRQ62hqpcDrYqWkyoW9316OzxNot5sR8KAeO4o9_E6I-62E
Message-ID: <CAJchtERmtk5BVFABRs7ytadY5KThFMDbtFUXE_pQYkEK9fxAjQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] x86: Prevent syscall hooking
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org, luto@kernel.org, 
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	Naveen N Rao <naveen@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
	Masami Hiramatsu <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org, 
	Kees Cook <kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 18, 2026 at 12:52=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Wed, 18 Feb 2026 07:18:25 -0800
> Dave Hansen <dave.hansen@intel.com> wrote:
>
> > ... adding kprobes folks and Kees to cc
> >
> > On 2/18/26 06:47, Elly I. Esparza wrote:
> > > Kprobes can be used by rootkits to find the address of x64_sys_call()=
,
> > > x32_sys_call() and ia32_sys_call(). This in turn allows for the rootk=
its
> > > to find an specific syscall handler and hook it.
> > >
> > > Add x64_sys_call(), x32_sys_call() and ia32_sys_call() to the kprobes
> > > blacklist.
> > I'm an occasional, but not super regular kprobes user. Is this going to
> > hurt folks who are legitimately probing the syscall dispatch functions?
> >
> > I'm a bit worried that the rootkits will just move on to something else
> > and this will become a never ending game of whack-a-mole where half the
> > kernel needs NOKPROBE_SYMBOL(). ;)
>
> Honesty, if you are worried about this, just run LOCKDOWN on tracing, and
> prevent *ALL* kprobes. Because yes, there's a 1000 ways to get this
> information once you have kprobes enabled and have root access. This patc=
h
> is hurting legitimate debugging of running systems more than it is limiti=
ng
> rootkits from hacking the kernel.
>
> In other words, this is causing more harm than good.
>
> Because, I do hook these functions a lot, and this will definitely put a
> cramp into my debugging of running systems if this gets applied.
>
> noinstr has already hurt debugging NO_HZ_FULL to track when userspace goe=
s
> into the kernel. Because now it's much more difficult to trace the latenc=
y
> the kernel causes a task.
>
> -- Steve

Fair, thanks for the quick responses.
