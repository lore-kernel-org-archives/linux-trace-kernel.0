Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FAF314A73
	for <linux-trace-kernel@vger.kernel.org>; Wed,  3 Jun 2026 06:38:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.174
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780468701; cv=pass; b=OviyWJacig/GqEYP8zFkyCmrMt6NWnVVpvnBpYYLK9W+m0riXLT9T8L3uJ6h7An4mdYF1at5EUhUlVxhsBqvhwQVjHc1rbjPxt3GbymyqDA+m9q/djV3mOBTj53vlXPv6RjjAQ0cBDPnXr5GrKItxvRtHSm0Bbk5Hn2BbaVIP+E=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780468701; c=relaxed/simple;
	bh=/OPUnB/LfrvfW8WOhD5J2WTH80ZgHarh6yN9o5WzBmM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nB3vVUtXm1PzBAq4k7blrNMA8Q/UvBHf4oM0/rBExvwRyvHCqKXXRj5c8KXDoWZT2cszZmUOn47bF3j5Bxj7BEZNGT1Jqy89bUjRDHMA3Nrx0ji38LwnfaHRvbSk7i8mIQY0fS9ojs9fOQYYQnuINZU3IzBn6yyo8sxezTYPDXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=N6df6bRu; arc=pass smtp.client-ip=209.85.167.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="N6df6bRu"
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-48611d28204so1311150b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 02 Jun 2026 23:38:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780468699; cv=none;
        d=google.com; s=arc-20240605;
        b=dQdAGblxU5tK0bie9MnYUNwoEdMiVfAWbWcQ9sypEZGCMTihxyjU17GEjO3uT72G6C
         ivKUSH5YSFGKl7bAd/5a3T7tLAg5q9j7m53jY5f+Vq9D3nAKDd5kDI91Fcr2Qq47lE5p
         Fhhaj3TR2VJ1nYaZxYGlTyzAOAeoiCrQVXjZngRGZBDTJdbOFceCQtYoACk/H4epq5MB
         d+NPKYXUPmSCKA+AloSwgS52EBgKJagw1Gpn/kPkCkoSNfVaN8zf8tGq6UMXThm2RusS
         PAQUP4vKPp4Msmi2qKl3wA362DrI1K/3PBHfksOqr8mF7nfrdiqpyqHk6tywz4kl3Suu
         LqbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/bxMX6KQ5GY57H9DvNJJrwhgMHMAlHXler4JkrSkM+U=;
        fh=sUhSgYMdtGUTKEK4ZFZBGsinovpBWzlgJC1j2BMUb3k=;
        b=H6bUeMDMES574L2ANKD8vUnAnZ4uQEQM6XVYY/8dRumdgRWQ5yS2VBHaXjgNi04GbK
         KmM4oF8bAD3Pxse6kU+ju5AhjIsDKRohJlC1xcz6a93rNRtIbDWBjQJPxRB7NpNFS2XL
         ECB09Yc/F7Of1PYA7UDQHGFoUJWr29CJ3kTqPFcMF0g/n2gx2dSlEhUHvGJohgDV7O+l
         nqv18QrfM3O++qoM3XlaQr2tCrOWAGAsfLanKcBbqfbaIfh2BixufhrpsS5Rp/QEqCDV
         cXHjpAWmB1a0m5qylB/hK4bWd5zuNNEtCS9UleQ/Tc6kZUQg5D8la6pcfFy/RfJie7bw
         0O5g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780468699; x=1781073499; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/bxMX6KQ5GY57H9DvNJJrwhgMHMAlHXler4JkrSkM+U=;
        b=N6df6bRuqd3kq7h/+aMpORUnfGs86CY8mte1EKTPah9S8WqIYtvw7CuG/KkbXMDAzd
         S3ejcDCD3xDJ3LElVJkgsxqb+8qMHWc4W3vjHt/fNEzq2VN3ya+gDlwGx0mEBIr1YkML
         AUjzpN/pwY1i8EmphJ3JCLDuHyB3cuk7LZsFW1ZHwLzeuqGgEhghgssrnDL8HSVzwVGL
         mStSlhKQPtjqxIUX79lOj33Q4qcTzlDWqt/eHqsb5kgjSLAIaqMA0NuQM2gZMNTYn0C4
         IMQFVwKCItWySyXRNyYOg/cjcCVZKyftLIN++muiqqAwphE4UXqU6Eg6i8CP8wVs4yKe
         ermQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780468699; x=1781073499;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/bxMX6KQ5GY57H9DvNJJrwhgMHMAlHXler4JkrSkM+U=;
        b=OgxOku63Dzd8rI2tGz7hG6d4781r2Cu0iBGcaBvU4/2dRMjtdckNHayT6+dXEC0Nl+
         RIDCZaEaT2Upre6tsGJE2Mh14VJuFp6skD5hgz2LvjaMBWFoFEYeXiI2evRx9PvWt12F
         grF3IRNAnZPXhNOKjrLt8OGvk36k5rXzjLgLizMuQ9axsasMcf4AJrky08Fm6yWgJ3wn
         UFVfT2cck7/flTVJuZrSR7MmUPESG5H1bv8gI0WwJ2d15nuz0jMy7yqmVSR4mHUcL7yu
         vKwldYqSzToQ5zLI43K7oxF8CO0TqB24WSvsg5ehiTsY0FC7qOfLRJgzU0l+u51DeFtq
         eohg==
X-Forwarded-Encrypted: i=1; AFNElJ/bK/zokk43oCZPWY1iWbVnt5XE5ph5Ks+6JAEHLf/VSeYkSqcVwB3xpUFx+JrX4tqM18qrqEIAlhCVk5WBx3VrjyE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyyl6Cziut9UNSryBBuvUnRyHXeoXqY5+rJUDu7hyw/+CZSODIM
	C8DbdI/0UNhJcJP9hDFDB2CE/w3HnCjuyQGu6EKWw/BbTVZrpNDvz9sG/0DaDdPGxN7khiqC6zh
	7jk3mGbch9UXaXeJ9x120Mynxn6TouAS+DL/yIJGy
X-Gm-Gg: Acq92OGNwG9uNGF/uDx7uMKTjtyM4m63XLKAENozz4sPzlyoMZawFm+aD7jlFzsJex3
	zhpkznPv2gtRW4rV55NitINS3WUScHsWyIVdDFlpkd6IhUsSD7b+TK94ExFpsde7xRgN8AxSEdm
	h1AGPhcj/P/s1if5L7fG1V3C2lZZgXcEDPcxkTJ0gRO3up36JO6ZBYvvp6atLpw6++M5FZ9PFej
	Tq56vF39u1OgZt9s5Y1HCbiqJu1w1bmCCIYkt/MTLfhYxTWkjvrcyazpOHpyqt4y8pRI/fLaLy4
	bFD9HsEYoIcqIypIcIzwR+oZYyTBVDLJjWqtNMjY5WCInXu18ZwwnJjMoijUxaxkUFx4dTKyp8O
	Odw==
X-Received: by 2002:a05:6808:4482:b0:485:7c5a:63b5 with SMTP id
 5614622812f47-4865a934c23mr1306785b6e.4.1780468698249; Tue, 02 Jun 2026
 23:38:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6a1ede7b.b4221f80.1326c5.0003.GAE@google.com> <20260602122829.4a91864f@gandalf.local.home>
 <20260603103445.236f260a3c5eafe140055761@kernel.org>
In-Reply-To: <20260603103445.236f260a3c5eafe140055761@kernel.org>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Wed, 3 Jun 2026 08:38:06 +0200
X-Gm-Features: AVHnY4JLADxEEURPZYM_ZNJnErMtbeh29sHKX-nw5HAQdr-tXn2mFkLB46g3odM
Message-ID: <CANp29Y55QBfKT=FLpn=trH5Tmxj2P_7H7yhJG_xXCbCdR3Lv_A@mail.gmail.com>
Subject: Re: [syzbot] [trace?] KASAN: use-after-free Write in ring_buffer_read_page
To: Masami Hiramatsu <mhiramat@kernel.org>, Alexander Potapenko <glider@google.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 3, 2026 at 3:34=E2=80=AFAM 'Masami Hiramatsu' via syzkaller-bug=
s
<syzkaller-bugs@googlegroups.com> wrote:
>
> On Tue, 2 Jun 2026 12:28:29 -0400
> Steven Rostedt <rostedt@goodmis.org> wrote:
>
> > On Tue, 02 Jun 2026 06:45:31 -0700
> > syzbot <syzbot+2dd9d02f60775ce5c1fb@syzkaller.appspotmail.com> wrote:
> >
> > > syzbot found the following issue on:
> > >
> > > HEAD commit:    e7ae89a0c97c Linux 7.1-rc5
> > > git tree:       upstream
> > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D16f06e2e5=
80000
> > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D58acee1ac=
5406016
> > > dashboard link: https://syzkaller.appspot.com/bug?extid=3D2dd9d02f607=
75ce5c1fb
> > > compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils f=
or Debian) 2.44
> > >
> > > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Looks like the test was doing something really weird to trigger this.
> > Without a reproducer, it's pretty much impossible to find out what
> > happened. Maybe AI could do it?
> >
>
> Does the "I don't have any reproducer for this issue yet." means
> this is not reproducible even if it runs completely same sequence
> in the console output? If so, might this be a timing related issue?
> (e.g. read v.s. write-event)

Yes, syzbot normally re-plays the sequence of last programs executed
on the crashed VM to find a reproducer, and, in many cases, they no
longer crash the kernel..

In the meanwhile, syzbot's AI bug reproduction functionality has found
a C reproducer for a KASAN crash in the kernel/trace's ring buffer,
although with a slightly different stack trace:
https://syzkaller.appspot.com/ai_job?id=3Db2620161-1632-4d4e-9314-114a8a5e7=
9ef

Cc Alexander Potapenko

>
> Thanks,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
