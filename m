Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5ED29CB47
	for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Jun 2025 13:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749561620; cv=none; b=VXUrj/Sy6vdRG/n5yJNT8VrnTtyM6ClZuO3KNzc3GoUQVXMeZVtUApcAih0/KRWq/laerNM+BqaTJ2q4C2a6BxyGrCPjXnmD2S7c60HXBcLSFwJVivwYg9bYm+8YdloZ4d6JNZ4652ueKZl9+ekarEgfD32CfU7EKreqWOWZbCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749561620; c=relaxed/simple;
	bh=qzzc5DCoAcIaeikSdzSa259cJC4u3xC7tNvnS5Slg30=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VfbuZpEwfAhPvLZHloJZ7Zz9iKJZIdkTcG5YbO6DiEj+xF6O7JEhX6J2o+3cXp1TM1niZDQmjD97vB52PgkQzu9YPCRVv4uQOD2gvFCPe+T31UESo6XWAKnzb0+N2CdMaKQ7ofTz4xJK7g5YCenVOEA89aWOCGUzfk1Zp1dHJgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hEU8Lcge; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hEU8Lcge"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-525da75d902so1726751e0c.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 10 Jun 2025 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1749561617; x=1750166417; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gZpc6ShDMIguyoLzrE2gDcOvoD7GyxTSGJrFmyx1kNk=;
        b=hEU8LcgeiOKhM0zztYOaHu+N8VDpylQop+kAclEuxVokaQ3whZvJWhKZJ/2ol3TRXr
         Dn4n2GgYAW1xZFghpEtLQv6ROwWkFV1+KX6/tjlw5MvByBoxD7djr/kk3pGkPvyoYDLA
         nn0kNQgMeYnSzk1BU2Sen6xjv+0/0SD3Ytw3bEE6UB/PrTxXvdspUhG4KyT7ieT8J78y
         uVqXuvNDuo9EMlLydNwQ9rds4/glpFGud3xURf2c1fhnI/s7TdadCsT2v/ygWcBfy16Y
         relWjtqfbn2ZUhpeq193an1yOR4NWQE8flkxWCFxKYjQqi1EXwm1IQsPsw1USF8rOCbX
         LBnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749561617; x=1750166417;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gZpc6ShDMIguyoLzrE2gDcOvoD7GyxTSGJrFmyx1kNk=;
        b=rt/DU6y68QluBcqqy+i7sOLW4DI2FyGrkoSuXFCY2ko1ADEwqd+CK/5Lk0Ch24lM/l
         sLiOduZcqTgUDLhv0zCKrXfhAH+Upam3sw3jKrwJQges+y1MhBK0v6vDuWLUtjycyJzT
         ONnlolHmaDRrRUH09VBYvsckxo9lTFCU59toc72dPpVIzAwHQjnBmhy79adHltP5YXWX
         79QxlWHWOW20hFyQfdHmULEiaL6roBiyIqcHUjMNMpd1F4igUcIbkFyXd7UJbggOGPcN
         J7pin6YAMXb6cal9UGeO47TbRZjxghSzWpsihq07FEAln8W8vsqhKO9wPxmBF6x3taRo
         EoPg==
X-Forwarded-Encrypted: i=1; AJvYcCVFWV6gyBYgrJg9ybU+73/nAo+4BnHADh0zTWjKKhswacLFrcxB6O09YF8/tMBwRNPYL3qhbmKwBysGmkXMR/PDbYU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznPfQntOcR87t1pMJJ7l/j1PlUeT+RbaMBajxhH4BtS+ljj6Ey
	Zoo1A5jAPUBaFL+JgJzrEY49lk/VIw5EqDPylfsd2ZviYCCJIkV/TWouIPEC7ZOYIVvIwC4EsrG
	GM8UBmSahg6AkSgqAoerYJ+eF94sWg7DIBEmWopFkbQ==
X-Gm-Gg: ASbGncsiZHDsrOavK8UoA6UVkvtWUl8drdTQofHKweyYd7kRHIg2MhpvGWny7JV11D/
	JVVNJt+D030K84GRT5r/fF4RalAG8FnoKjuDqmcH5VvyvA6Wm0StmFBW3x4IUc0jubXczqu6nIE
	oFQjI4gykBLZ28CxIyS6gnAlEI9t3M++9hm1a6R+y5JgzD2RIKyNiBiKee2rdlCFKaM7HMdKb0y
	kTB
X-Google-Smtp-Source: AGHT+IHMI/FdvpE92ey/O2UI14Kt6Ab9260AKNkDqME8TgaB7i25twBEgbkhIf7ze+mH0CT5+tZPBnDay7CvDFbyeso=
X-Received: by 2002:a05:6122:30ac:b0:520:4996:7d2a with SMTP id
 71dfb90a1353d-53114b2fc7amr1423311e0c.10.1749561617207; Tue, 10 Jun 2025
 06:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CA+G9fYsLu0roY3DV=tKyqP7FEKbOEETRvTDhnpPxJGbA=Cg+4w@mail.gmail.com>
 <20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
In-Reply-To: <20250609220934.2c3ed98ba8c624fc7cb45172@kernel.org>
From: Naresh Kamboju <naresh.kamboju@linaro.org>
Date: Tue, 10 Jun 2025 18:50:05 +0530
X-Gm-Features: AX0GCFvkGYyERpnfvi80t92kHcVn7K8e2BLuuCzrI31Q2VJHbDTGtaIbo9dY_KQ
Message-ID: <CA+G9fYsoCc3DnNGoavFiBdymVpdJiEfUSEq967GgThVQW7bTPA@mail.gmail.com>
Subject: Re: next-20250605: Test regression: qemu-x86_64-compat mode ltp
 tracing Oops int3 kernel panic
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: open list <linux-kernel@vger.kernel.org>, 
	Linux trace kernel <linux-trace-kernel@vger.kernel.org>, lkft-triage@lists.linaro.org, 
	Stephen Rothwell <sfr@canb.auug.org.au>, Arnd Bergmann <arnd@arndb.de>, 
	Dan Carpenter <dan.carpenter@linaro.org>, Anders Roxell <anders.roxell@linaro.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 9 Jun 2025 at 18:39, Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Thu, 5 Jun 2025 17:12:10 +0530
> Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> > Regressions found on qemu-x86_64 with compat mode (64-bit kernel
> > running on 32-bit userspace) while running LTP tracing test suite
> > on Linux next-20250605 tag kernel.
> >
> > Regressions found on
> >  - LTP tracing
> >
> > Regression Analysis:
> >  - New regression? Yes
> >  - Reproducible? Intermittent
> >
> > Test regression: qemu-x86_64-compat mode ltp tracing Oops int3 kernel panic
> >
> > Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> >
> > ## Test log
> > ftrace-stress-test: <12>[   21.971153] /usr/local/bin/kirk[277]:
> > starting test ftrace-stress-test (ftrace_stress_test.sh 90)
> > <4>[   58.997439] Oops: int3: 0000 [#1] SMP PTI
> > <4>[   58.998089] CPU: 0 UID: 0 PID: 323 Comm: sh Not tainted
> > 6.15.0-next-20250605 #1 PREEMPT(voluntary)
> > <4>[   58.998152] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> > BIOS 1.16.3-debian-1.16.3-2 04/01/2014
> > <4>[   58.998260] RIP: 0010:_raw_spin_lock+0x5/0x50
>
> Interesting. This hits a stray int3 for ftrace on _raw_spin_lock.
>
> Here is the compiled code of _raw_spin_lock.
>
> ffffffff825daa00 <_raw_spin_lock>:
> ffffffff825daa00:       f3 0f 1e fa             endbr64
> ffffffff825daa04:       e8 47 a6 d5 fe          call   ffffffff81335050 <__fentry__>
>
> Since int3 exception happens after decoded int3 (1 byte), the RIP
> `_raw_spin_lock+0x05` is not an instruction boundary.
>
> > <4>[   58.998563] Code: 5d e9 ff 12 00 00 66 66 2e 0f 1f 84 00 00 00
> > 00 00 0f 1f 40 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3
> > 0f 1e fa 0f <1f> 44 00 00 55 48 89 e5 53 48 89 fb bf 01 00 00 00 e8 15
> > 12 e4 fe
>
> And the call is already modified back to a 5-bytes nop when we
> dump the code. Thus it may hit the intermediate int3 for transforming
> code.
>
> e8 47 a6 d5 fe
>  (first step)
> cc 47 a6 d5 fe
>  (second step)
> cc 1f 44 00 00 <- hit?
>  (third step)
> 0f 1f 44 00 00 <- handle int3
>
> It is very unlikely scenario (and I'm not sure qemu can correctly
> emulate it.) But if a CPU hits the int3 (cc) on _raw_spin_lock()+0x4
> before anoter CPU' runs third step in smp_text_poke_batch_finish(),
> and before the CPU runs smp_text_poke_int3_handler(), the CPU' runs
> the thrid step and sets text_poke_array_refs 0,
> the smp_text_poke_int3_handler() returns 0 and causes the same
> problem.
>
> <CPU0>                                  <CPU1>
>                                         Start smp_text_poke_batch_finish().
>                                         Finish second step.
> Hit int3 (*)
>                                         Finish third step.
>                                         Run smp_text_poke_sync_each_cpu().(**)
>                                         Clear text_poke_array_refs[cpu0]
> Start smp_text_poke_int3_handler()
> Failed to get text_poke_array_refs[cpu0]
> Oops: int3
>
>
> But as I said it is very unlikely, because as far as I know;
>
> (*) smp_text_poke_int3_handler() is called directly from exc_int3()
>    which is a kind of NMI, so other interrupt should not run.
> (**) In the third step, smp_text_poke_batch_finish() sends IPI for
>    sync core after removing int3. Thus any int3 exception handling
>    should be finished.
>
> Is this bug reproducible easier recently?

Yes. It is easy to reproduce.

>
> Thanks,
>
> --
> Masami Hiramatsu (Google) <mhiramat@kernel.org>

- Naresh
