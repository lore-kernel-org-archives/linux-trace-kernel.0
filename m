Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E213911AA
	for <linux-trace-kernel@vger.kernel.org>; Fri,  4 Sep 2026 23:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788565748; cv=pass; b=q/KP4/4+OJUOYAlL7tqEYoP1Xo+jcZGVXBu7BcQCD6Rk3Wdh97tCUpeVEGgplU4EF1pAyqGy+a47rhr9u8qsC+K0+mndcj4qZIhCMxcCGqq7ZFbJZmr3DIVuZXb3cKWBeGrg0T6zMYRLs5YldFxgURush8t7dfCJU+WxGbIMClk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788565748; c=relaxed/simple;
	bh=Jm8vdCNfd/Ay2He2k9+eSmGx7u4UaUwDvdHSixnhBK8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ik8jNqjCdVtrtT6xnXz0ACRJJeeVyE02y2/ZRFS1LWH4X1e1WZXsY+RpVmea8idAS27kgtZ/62/X6GTQp+a3pshj0nXlu6hqFvzFm0NkwUHLpkKDq3Psl+mY1WvtxLB/+bd6tzJiq6SNAhzWQLK3iwbw3AYFIorACLCJIeFgcXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l/e9l7yX; arc=pass smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/e9l7yX"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2cc891373e0so17063545ad.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 04 Sep 2026 16:49:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788565747; cv=none;
        d=google.com; s=arc-20260327;
        b=H+NUKYPiSmFfSSc22WvXtChKUUDmM6j7UfmYYBCdPX3+v7EeWyFKual/QTu23Mqxic
         e2sAgENqFolZouiiw31XJ+WhTXS2JYHToQ3NL9tEZiPwJP0l18mtfoZYRWCLtMvyLiYA
         NF6qLCe5M7bL74z8Qa7jkgPJawhfZIaLdSzavflajHNf+L5l3ddP71+COIUF3prcELtK
         wsriSwgpJXfX8nYw60KxBHOh9N/Z20nlwa4LfMMC6jlYNydCYAe6zrX3jQvaWvZP0dj7
         9P7J6etg1OmEDBlrLHpwhesbj/TqKYbkgBUPqjDKXUTF8p3wzcNwK8EIsPDNjz2qpwmN
         b8hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Jm8vdCNfd/Ay2He2k9+eSmGx7u4UaUwDvdHSixnhBK8=;
        fh=HUEcvTaiNY/16qwjxXcwuT5eeEf9eyNOXjeqLNhCqyA=;
        b=F/XmCO+ueercC5JdChy24dcWbrpRwI4HVNn9Q5it57kFR9lV5jJyQfaqqsT1dd1SzD
         4UEtdKknQJY/BnzZ/oa39vKevXk6E2DpP864NLNpX736F+bRksseTwxRrzzMjiTavJgj
         MC+qpI7/gqbNWbjmtaE6bgnGZeCa5gCzvQmt4MC3S9hrMdnN3J/nYRKJLgdXHthumEap
         zHdOoskvfMdubG5qZ/i+O/7Qnp00rwaPPrzesPJozqA+YLvbKaw9DFKcprZ9f334V83d
         ULc9cpHlvgb3LoO3G3dVdOtWY/6BfT4IAwOW6VQ0KkMJ2t+LY6UTAmCI1moRQj2UjXvk
         zOzQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788565747; x=1789170547; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Jm8vdCNfd/Ay2He2k9+eSmGx7u4UaUwDvdHSixnhBK8=;
        b=l/e9l7yXREPCh4IL2BsYxGzRzv6HIN/7sDDrbSNI7F6L/6bMS1NVrZbSUIpQax6lKC
         6rqrckZuoo3iuktLyaE9VaUfNR/fQnLIIt7dasYIY689SklChjv5Gfwxbqp5IX2DdKm/
         Qj7hWsyu6L4r4CGfcDqWy/DlWLaFVe/v/xnLSuR/XGGGKlnUVznTnNdcwdHn6H/WmktP
         HWbHq/qSraoC8ESCLdd/gTU2qJo09nJoubgYyGnL+sxTfs0LzVuhS6hkrqtBugQgsDcy
         iM7rNOZ4eEDo29sn0uDfd7GR9FdNz/BIml5ESYp9LB+NQg18PSwMHa8kUvh/o6x49LE3
         ZCtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788565747; x=1789170547;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Jm8vdCNfd/Ay2He2k9+eSmGx7u4UaUwDvdHSixnhBK8=;
        b=Vk8l+DDQPGojVu131bJslf0SNV6ycVScvek7McdCLhse/muAUjTAgR8ZpV3WSm6psD
         iQPWbH0sYpcdX3Duucpdy30I/+pjALvfV9NjVHR54HlwgpNmF4k2/ldVdGAr0QRBFTBQ
         +GLeE8W3bLvfWLc9hJZ6ryayg148Lr/OTMqJLnmvG2FOiwED7s6lORGHw8AV0YqV3KB0
         tLiTQBwSpn2DHcSR5z3FpNXEn5bhSNnuhOWoyf2gSvYmxt8AXqJJGp8wiMLUSnuy2FQN
         djhkKXAvFZlZPPNaYbijc1/Tgx5wefIO/XR4y3qKbhrVu90pKXBjUPzvydCq8Ijlu0yU
         x0Rw==
X-Forwarded-Encrypted: i=1; AKwUvBy0WAJPhlbAjYCdCo9zWaf5xumH5OhenyrXZe9imwl/0Gdy5E0c/cqzYrO1YoJtuUHYXsmMcQfVSIADO2BJtmOQ8gA=@vger.kernel.org
X-Gm-Message-State: AFuF++nOC6iT4/kK2CzEfVIlGEmOzSRLOHe8+MKLdJ5cwGLf6IhcwWkX
	XZgi41pLGl4Wv8ehUZ3BzlnMNlwGH/fgB771Zggxiv0ULu+AbemSAjXemOex4RIwKHKmOKuWUBA
	jm9YFThQJLW4Tij93hD7zZZ13LxTARhs=
X-Gm-Gg: AYBFou0EcSP6Xz1sfcI7ieoOntrkJyHMJKhEql4ZaB9YcXBH7YH9SlGuGGxumthtB1B
	+SCRe81a+B4pp3ll7bCOkVC5IhyO+30AtU+A/4+w86A723BymbnToZMyv8HoU4oSmurovS05m9q
	nRWLhICB6ae59oTPmh4SeHg6ojnc3kBhplOnIk4cAU4h0V9y1IJns7PKD4RBUEr7GvyW/OPFZ3/
	ERryj8AafRwq+D2GKdCXKQZGrfiIKJuZd5LjpWGtB3ESNUOWPOkgR/b/tgsTj9q0K8Dg6zpfCas
	d8jCbuxQZYldcaR1Qz7pgOzN+jCa3JRepQulvVueZ9kFvv1tCC8u0NUCpRwrmXsxVavt4abtjWo
	KE/TgIERi4Mo8fv8l65Gkrv3ixhO0
X-Received: by 2002:a17:902:f64b:b0:2da:eccf:751d with SMTP id
 d9443c01a7336-2db126b5ed0mr134284105ad.22.1788565746899; Fri, 04 Sep 2026
 16:49:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260831090524.106845-1-gmonaco@redhat.com> <87se3sakgi.fsf@yellow.woof>
 <df6e9168cb06c35e21db7f9d17cfbca6bd87005b.camel@redhat.com>
 <DL5B40CU17WD.3KD75URQZ6RRR@gmail.com> <eb3dd8158942d663ec8ad4c529eacd666c5f96d9.camel@redhat.com>
 <20260903090211.50d15220@gandalf.local.home> <CAADnVQK8e1Qp9rf1zThZxb3vr4Gc_bpo0nqpEO2LdnEwHdKokA@mail.gmail.com>
 <20260904074317.01b2c0e1@robin> <DL6O0KLPXLTA.2HJJUXQUVCP5@gmail.com>
 <20260904123108.1fa1d815@gandalf.local.home> <20260904132421.111c0279@gandalf.local.home>
 <DL6XBKITK7ZT.3RXK9YGGUYZZE@gmail.com> <20260904194620.0c7a8363@gandalf.local.home>
In-Reply-To: <20260904194620.0c7a8363@gandalf.local.home>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Fri, 4 Sep 2026 16:48:55 -0700
X-Gm-Features: AcwNN1UvoLinoXtZcq6itqX2kSBVjcDjcnqMchnOOVOg6FzMAYIbCDpQFn9LNIs
Message-ID: <CAADnVQJH1SYR_GN6gewF3w_z_Sex9HFE1T1oXkQe6+v18bDTWA@mail.gmail.com>
Subject: Re: [RFC PATCH 00/20] rv: Add support for BPF monitors
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Gabriele Monaco <gmonaco@redhat.com>, Nam Cao <namcao@linutronix.de>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, bpf <bpf@vger.kernel.org>, 
	Wen Yang <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
	Viktor Malik <vmalik@redhat.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 4, 2026 at 4:45=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Fri, 04 Sep 2026 16:34:00 -0700
> "Alexei Starovoitov" <alexei.starovoitov@gmail.com> wrote:
>
> > bpf in 2022 was surely less capable then it is today.
> > It took us 2 years of bpf core development to statisfy sched-ext demand=
s
> > and we're still adding new features for sched-ext needs.
> > If you're trully willing to remove 90% of kernel/trace/rv/ and refactor
> > it into tiny shim where all of the core pieces are bpf driven we can
> > certainly work together (like we did with sched-ext) and add whatever
> > is missing on bpf side. Then all existing monitors will become bpf prog=
rams.
> > But adding bpf as another 'monitor', sorry but hard NO.
> > If hardcoded monitors was a mistake then admit it and fix it by deletin=
g it,
> > if it's not a mistake then keep adding hardcoded monitors.
>
> Regardless of whether or not BPF can replace "hardcoded monitors" today, =
it
> wasn't a mistake back then if BPF wasn't able to do it when they were fir=
st
> being added. sched_ext wanted to use BPF for scheduling as module plugins
> were nack'd by the scheduler maintainers for a long time. BPF programs to
> handle scheduling was the work-around to that, and basically the only way
> forward. And it still required special hooks into the scheduler.
>
> The rv monitors only needed to use tracepoints for hooks. A module was th=
e
> easiest way to get there, as BPF at the time wasn't an option.
>
> If you want to use hostile language like "admit you made a mistake" then =
it
> makes it harder to collaborate.

If you're offended by the word "mistake" then ok. There is no path forward.
Keep adding hardcoded stuff.
