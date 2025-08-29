Received: from mail-yw1-f194.google.com (mail-yw1-f194.google.com [209.85.128.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39A635950;
	Fri, 29 Aug 2025 00:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756428435; cv=none; b=le027e/sap7T3g2iWfwVh5x2BxMvndO+6xUL1ox90f7rPfnlzCxI52wGroiuJNRlss2RwBYfDxNJaJnwVC4cOXATeslCSRXfBUMXnCDK19i6DbKiemeuixsAxNs93xjFQfJbK7A+OPwz2CODHX9w5XFxK0BZj1BuSeugs5CY6rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756428435; c=relaxed/simple;
	bh=oPmuy3TGat4ooWHkoK7e11Wk5LiHB8i/yOjViDSxrUw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JS0SIsye0poiiVZr/WfaO1P77WTyxJviEOlH2yMXb2nawnNPODUvcgjVK76tsgVHKi4FywFEoHZD83ytfVpgM4C3DYpI8kxogTFePyWDW+1ltmq+AEQY3azH2H/GnVctsVMEV2+LSxqF7U28gAMccKEwxslxYvKdAtvNiN1Xpzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fFOIxhJ3; arc=none smtp.client-ip=209.85.128.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fFOIxhJ3"
Received: by mail-yw1-f194.google.com with SMTP id 00721157ae682-71d60501806so12829717b3.2;
        Thu, 28 Aug 2025 17:47:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756428432; x=1757033232; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wuiyXbkz/oKZln4w17K1UpJPXhKbnq2sEqaKGCGVONo=;
        b=fFOIxhJ3FRTdUTAh+hRM9FHON4IpZk3S2BfSHgmOj0ZTRbuP5GX1n+/IVK3B8Hj5GA
         3CuDXUTz8o8GWMTPrIUqAawIe06q4tROmsPk9BtJO86ghHPohpqLnRYNBP4RR3PxdLtQ
         J4Az9P/gt4rcNM2T8RAS1/fE48iJp/cL/tnEBTfsSMtVUwvn7VdN0KmJSpBae+Y2wQ5H
         rLrrgt44CQ6mI3tITm4hlPeo6tX3UwlT6r/99nQimOoSqeObDWH28lNxigN4P1mKXoN8
         Qg836UJprN+TwdSKstnQOmFL1AGomfttsk5hmC3UbqQm0qZcwFqwdKewGOqoxEBOFmlu
         tzoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756428432; x=1757033232;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wuiyXbkz/oKZln4w17K1UpJPXhKbnq2sEqaKGCGVONo=;
        b=GrCRPMChDE/B+1NsWucULaPRRLz1rty5mhzV0slujPnVgAV+xw9AV4QK2g4CkzdtVx
         bqG0ULVfcQjPFiPxFbSbfVqKg0d7fD53pXt37qsG45jEMYmlMz2Hf3vmHJxrSN6GgEXZ
         kzuRE/+iuIBqlsx5SxLwPbY5npdByBL/tRr1hABK2dB4tXQqx1ps6PrXfuXAS5+2Rfj1
         din0JZwYV0x7tBXPo4ZYhsD2fRRXQcU1pIW+l7nceo/2UBZKomyv1fDVinXkV1D5BEpO
         UgbvaCkLvGDq6Rs6MleMlGPVhvTLc9JpIB+DfPCOrGj07+cPeJeg2yWByXaycOj42Czo
         UZ/A==
X-Forwarded-Encrypted: i=1; AJvYcCUX6ZGas94sHpfW8x73DEwHldj9fw5gY+cjy7nICFig4kj8GQ9HqZ+YmRGWyi9plvK+RFvAfTUMpEZfLX9zLiawWCuj@vger.kernel.org, AJvYcCVjeTRSrcGO9QD59zmnubjVefwQa7IZsUShItzuXI2NBLmh3Zz/QlK7uHKIaI/IuKJa2dIVuvz4OT8SIkQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcbgnmvlOxd3iLNhr00sF0j16QPZ/6CpdO/FD/GgKJ8NmLFh5W
	NrkXk0YSFQrirb2G4+VNH8J1qZHhT5Z9aqNrpbwMUaLYXv/bxxN0vQ7TaTEfUxc5ejSbJrlBvBq
	B7/M9HsWe+OhCeu6x0AfPGPjmFhPfTAo=
X-Gm-Gg: ASbGncu7EtFk0txjqLdQdt4e56eHJh29bTaK9Mh6mxVCstpF1Th3lLeyg8Qpi4ddW/w
	75MJ1xBz7auQDJdge0riI0PYRTtqaVjyI0rjXjooIyNDfXPVk+FXHXDN0GBiccS3GgEY2xJu2Y9
	mjU/Rr+FxqGp4sSWtvBO/fdmTWW7Db1sc2hUlgk1IdSuA/WDT+tRHHnme4HSykYo22x4+NtmJMq
	ELax+IpZbhwXvlblbhiPuXhZbsEYOj6
X-Google-Smtp-Source: AGHT+IFUTRuTOBbOyVGMOGyozpIKe/8z9Kms9zBBGUkwhou9GlReWWHS4I0oGgJfP0HC+5MiGifVts7hT8mQcm3Tq2w=
X-Received: by 2002:a05:690c:4507:b0:71a:300c:d17e with SMTP id
 00721157ae682-71fdc2f32c8mr320538557b3.20.1756428432558; Thu, 28 Aug 2025
 17:47:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <202508281655.54c87330-lkp@intel.com> <CADxym3aHUDGahE1S2LzaDZA4vZP637txcMzQR3_r1U00GikEUA@mail.gmail.com>
 <20250828103433.1498f8a7@gandalf.local.home>
In-Reply-To: <20250828103433.1498f8a7@gandalf.local.home>
From: Menglong Dong <menglong8.dong@gmail.com>
Date: Fri, 29 Aug 2025 08:47:01 +0800
X-Gm-Features: Ac12FXzl5_fAXXUIThWutnEuE1vHvA1GXqPeGhxPSFJPZ1LIhVHxUVfVStR-Tkg
Message-ID: <CADxym3YhwQ=2z8u2RNoEK3iM2KwafeM-aB8OAspCyOaLy+iu=g@mail.gmail.com>
Subject: Re: [linux-next:master] [tracing] dfe0d675df: WARNING:suspicious_RCU_usage
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, oe-lkp@lists.linux.dev, 
	kernel test robot <oliver.sang@intel.com>, lkp@intel.com, 
	Menglong Dong <dongml2@chinatelecom.cn>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 10:34=E2=80=AFPM Steven Rostedt <rostedt@goodmis.or=
g> wrote:
>
> On Thu, 28 Aug 2025 17:09:35 +0800
> Menglong Dong <menglong8.dong@gmail.com> wrote:
>
> > > [  354.955971][ T4652]  dump_stack_lvl+0x7c/0x90
> > > [  354.955978][ T4652]  lockdep_rcu_suspicious+0x14f/0x1c0
> > > [  354.955987][ T4652]  __rhashtable_lookup+0x1e0/0x260
> >
> > rcu_read_lock() is not needed in fprobe_entry, but
> > rcu_dereference_check() is used in rhltable_lookup(), which
> > causes this warning.
>
> Why is rcu_read_lock() not needed in fprobe_entry()?

This is how it worked previously. In ftrace_test_recursion_trylock(),
preemption will be disabled, which ensure the RCU read-side
critical section.


Thanks!
Menglong Dong

>
> -- Steve
>
> >
> > Adding rcu_read_lock() here is able to suppress this warning.
> > Maybe we need only rcu_lock_acquire(&rcu_lock_map) here,
> > but it's not a common usage. What do you think, Masami?
>
