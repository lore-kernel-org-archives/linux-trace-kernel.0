Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1561018A922
	for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 10:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734516587; cv=none; b=SrCjxlwYcSjWfPkRGPMZ2WpAY/LQY+STkgBL28xEJAX3PiTFRhx5o+MakttG/NNYc6BoP2NKx7IHTcrS1FbyAXpNJBUPYc7YdLPaJfcdjwYSKirAz5rwYCas+GSPt99wJUjcfuLYvQZ6Jl+M0nitc/N4lCgfWYvsEQeqYnVN4Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734516587; c=relaxed/simple;
	bh=Csrxv9a7EH7N+2s4kh6SzXFQ126zo9Hhbpmfd1+kFQo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I250ib2UVG7uCZ/b5l3s8RgLUQv6qN2B/wZTebp2vXLEajgHGjiQ7TI4X/Pk/9DM99BlMNswZiIv0DjU+JbMw7nOZwEZgpICSs+QFAARKSukqvaNTfdbmYhcqLkq0Tr2NMin0Xzli8Uk4kP88mk1ky5iQq53wAAYSNXkhX+hmZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Rzg7dWhJ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Rzg7dWhJ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30034ad2ca3so53200411fa.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 18 Dec 2024 02:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1734516583; x=1735121383; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KAqAzCDyognwyG/xM1yDX03XdcVPjM9tCmZLy5NtvGY=;
        b=Rzg7dWhJvC72+qC+k7sOsRCZewKMwfgOGOTuHrx8OOeNmrwoyyN7F/D1zkhrO504od
         UsFY8SzbvGKlb9I0YmUt71g9MdhW9OgQ04SNLDaXHAmM8E/Hs+vSa9Ig52Aj/TjO/8K8
         aCAB0aQ3e8Quau2MdSqzVPb6ryNDq1rpHAGlobId0bs2ZQ9m3dfFbNq0MqJXD1vK68QX
         ssdU7Kgs48+T2XdYEcT97qoFsaOK3w7o5Uou5VQzK1UPw1OQEimcx8En1SOAlxIDMzUt
         m1gAm4bJ1D9ZSYzvqUF1mY63AYng71wuoeip9Bb4OSHpUYffD6P2C/x3vvF8MyPr9wv6
         5vqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734516583; x=1735121383;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KAqAzCDyognwyG/xM1yDX03XdcVPjM9tCmZLy5NtvGY=;
        b=bArWSet/7Ab8eQZycZgpv8Nx2AkQidBE7eg+sg2XYWmetLzNaKIAA4i15Ll0vgmQti
         0DyEx2eBlKCz9LT0njGTB7YeMNl2fysjGsgADB2IqHnfZk6Yep7v2ZJYpnaQ5wAXlwf/
         zrVkNqj4F0svkATW9meA6TJA07lJk/mC1spgI6x1lPZt/fK5l7AUTmD/JShDQ4mliMbI
         4XFb8aRl3w77rLf6maM04SeiuK2PLj3bd1Pdhij057yLG4WeGpxvKoN+TO4m+1tY8Mm5
         jQvzfHZRrCiOGFjEcm6tz6yqsAxWdCZlDCTaxAKN1Af311NSRnnT05J/4XCU4QlA/7zd
         IcFw==
X-Forwarded-Encrypted: i=1; AJvYcCUk5ioxXJxggmhGaisdmTycLunczfiJMYTAzOwNNbCqNqY4zQSTlWgN9djKnj8z2O2YgL2CLQlof2naFqtokN7UoGE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx4qNuxHB4KzmZxHu+nVhgfcSGEH0f+87rRe6FI+SlMsOS8d9FB
	Jt4S40o4Sw24nOWb/EExAPBk6oeMIySUWnymC/NOm37FEr1v6n87hM6hPYBahSBbVNgWLlcElQ9
	pMUMfSkyRFbSmjapYeLeshhmj4bSSZFxzJY0/O3WK+ZTB7laXZ6aE
X-Gm-Gg: ASbGncs3bI6UDGpbw35R2LME/kPAh++hZCC3+R2Cnh9vrv5cWGPwH9OS60i/hvFkFtd
	WZ+GygH4ijKW0JDmrKNYoSN4L2+xduiLMESExtZ/iF7jYRIfB2Vj/kWT+yYJtfZFfcPc0i3k=
X-Google-Smtp-Source: AGHT+IG2XUj0dWtcQoFrU8EiHW5ReoyP7cYaxzUVTjoNYTJHbrTces72f5cNJCGlKAPcZpKw96EQMS5sqzjExfQzp84=
X-Received: by 2002:a05:651c:2118:b0:300:25f6:9b3d with SMTP id
 38308e7fff4ca-3044daa557amr7766271fa.10.1734516582999; Wed, 18 Dec 2024
 02:09:42 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6761e9b5.050a0220.29fcd0.007b.GAE@google.com> <20241217164810.2a9bcb57@gandalf.local.home>
In-Reply-To: <20241217164810.2a9bcb57@gandalf.local.home>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Wed, 18 Dec 2024 11:09:31 +0100
Message-ID: <CACT4Y+YrQR5HQWZuWb9OrupPR0C=mvLyWcJN3ofuUyf7j-nGRA@mail.gmail.com>
Subject: Re: [syzbot] [trace?] WARNING in tracepoint_probe_unregister (3)
To: Steven Rostedt <rostedt@goodmis.org>
Cc: syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 17 Dec 2024 at 22:47, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Tue, 17 Dec 2024 13:14:29 -0800
> syzbot <syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com> wrote:
>
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    243f750a2df0 Merge tag 'gpio-fixes-for-v6.13-rc3' of git:/..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=1310a4f8580000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=99a5586995ec03b2
> > dashboard link: https://syzkaller.appspot.com/bug?extid=a1d25e53cd4a10f7f2d3
> > compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
> >
> > Unfortunately, I don't have any reproducer for this issue yet.
> >
> > Downloadable assets:
> > disk image: https://storage.googleapis.com/syzbot-assets/939c742e99e7/disk-243f750a.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/76db565b11d6/vmlinux-243f750a.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/822230eb0753/bzImage-243f750a.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the commit:
> > Reported-by: syzbot+a1d25e53cd4a10f7f2d3@syzkaller.appspotmail.com
> >
>
> BTW,
>
> If you are injecting faults and hitting bugs when you do.
>
>    PLEASE REPORT YOU ARE INJECTING FAULTS!!!
>
> It just happened that I looked at the above console output to know that.
> Without that information, this would never be solved, as the memory
> failures you are injecting are for things that are less than a page and
> would only happen when the system is dangerously low on memory.
>
> Knowing that this was caused after fault injection is critical knowledge!
>
> Without that knowledge, this can be a big waste of time for maintainers who
> will go off on wild goose chases trying to figure out what's wrong with the
> logic, when it really was simply a missed check of something that didn't
> get allocated, that would also never not get allocated unless the system
> was in dire straits.

Hi Steve,

I've filed https://github.com/google/syzkaller/issues/5621 to not lose
this request. Thanks for the feedback.
