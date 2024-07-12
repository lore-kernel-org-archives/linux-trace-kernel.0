Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FF2715E83;
	Fri, 12 Jul 2024 04:57:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720760278; cv=none; b=FDDEqjjfvqv/nEObbclCqJN9Ldpld7G23O7fwc/5wFYHDssLMZ+KBbwJTi1c4xrcYJrbbToc4na4mTIMYjxNx1BcIhNYMp2pOEzMfj27N/cmV6BqurNAI1AqXklERssVFFz7I5uNb72Vz2yJAnck1HPrT+92XtDSyOMrfg3g97Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720760278; c=relaxed/simple;
	bh=XF/ip4QNMmObtpMNy5uwbrxVBFm5W7dTrDLY8KaJIIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=oFiNufLszvN3IaR25A0Ma3koAaJGdS8mXZaR2ovKP0yO+qI/mGTxyAQRkmiB7dY/yE3lekjCHBbxAGDF5sOJYs6qen7p8Tu7g23JYJlM9hYdpqkbhcMg/AE1zEu9bM0+zpr1160lPP+fyb29gHq2omhziCJnDJ14CRxsL7RRk3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jzak3L1Y; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jzak3L1Y"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-70b09cb7776so1346932b3a.1;
        Thu, 11 Jul 2024 21:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720760276; x=1721365076; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cgc5qzxw5wK05hMWCEUdBVLXJ0/WrgFO139zlUvcUS4=;
        b=Jzak3L1YcQe8kkaiizbvwRu/GquP85GqYgi9sRoQtUTL0lnTrbWo06VqhRPsvR4MQ0
         kKvOsrsMgTvF5mjb0RneheQjiIFdyp6x1SRatVEyG/S261OF/kqqWlCGVknoWOnc9Knr
         nZkZire9M26Z8Rg6PexeBxFe1sZCLe58D/MZSh4ihbAJE2xk5ouV86m5VPglywX3+P3X
         zJJ/5RA49cdye2GbrW9TPan2EKIQu5QQQcD0GZAlYRN7pTCC3kHf/w3VIsujcFj1EqB/
         9tf48fJXmm4N6gALddpJYV9kC5Ej3GQ+2Szp6QVaD7ylLZX3h5e2OWIXIJzh1jtaVr04
         UkTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720760276; x=1721365076;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cgc5qzxw5wK05hMWCEUdBVLXJ0/WrgFO139zlUvcUS4=;
        b=eO17Z8PNG75OURJkMB8/gyyaqaPHVbu7ochY1QFvFjTZgD4VSVzim3lhpE5fBuabZV
         EEfRHATDSgBiWGQuhdcnMCBv4ML0SKKzZ/vDBu/K0VXQnP3g5peiDb3s/mKHZTxt11BZ
         8Okl9uq31JNoKO/SXl24XY5ohm6Z8Wc+LLVcSxnUmc+mT0rR8/I5HowHn10zrsRiYUnr
         zKcSy3kABXHssRUgcGcaOke458l7jpeujunc7qACdQ+sK3Of8PzLfgNyjLA59AJxvL6G
         xYOGF1cBgEwNS1GRM7R+HiZVylSwSVbVN0zsEGYAw8GM8rD7vcq35AqbmMO0GZYgxh19
         70dw==
X-Forwarded-Encrypted: i=1; AJvYcCW9Wp0Z6T4F4+wjyFcThx0DxLRFf+NFDDud/rDapcFeBo1XSOpTYmg2nxlI9wF96pXERxW/gsDFH/m/GoI/XcOBZRh5kHwuHV0oWMP8rMtP2uUhEEbnNsW2SvtL8BOJVOSfgAkKVilqH/KsB0Pl2dUk
X-Gm-Message-State: AOJu0YxETB4IGHBYWYPC4jxc8yqujjURv+f/5BNqkCrdohpT4xNQAIrb
	ubyimj+VSpqqFfNA3ExwcG5S2nWWM2QbTjzDYwCcTlrC3AxL4y3QYYMrjD2cJV4tOPu04XSRSYV
	p6Qt78HqTgOZwddf4UuNwzlyfyjk=
X-Google-Smtp-Source: AGHT+IEUkeZtcyGtlaj1RFsDY8XRb2zXNgRyQzpsu3Xb7SVhQeA1Hi5KxpSqWP6IoNyOD56FgMHHOTYrBBurmIi/o8Q=
X-Received: by 2002:a05:6a21:39a:b0:1c0:f48e:a5ed with SMTP id
 adf61e73a8af0-1c29824d6d8mr10526627637.37.1720760276248; Thu, 11 Jul 2024
 21:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240711110235.098009979@infradead.org>
In-Reply-To: <20240711110235.098009979@infradead.org>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Thu, 11 Jul 2024 21:57:44 -0700
Message-ID: <CAEf4BzZ+ygwfk8FKn5AS_Ny=igvGcFzdDLE2FjcvwjCKazEWMA@mail.gmail.com>
Subject: Re: [PATCH v2 00/11] perf/uprobe: Optimize uprobes
To: Peter Zijlstra <peterz@infradead.org>, oleg@redhat.com
Cc: mingo@kernel.org, andrii@kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, rostedt@goodmis.org, mhiramat@kernel.org, 
	jolsa@kernel.org, clm@meta.com, paulmck@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 11, 2024 at 4:07=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> Hi!
>
> These patches implement the (S)RCU based proposal to optimize uprobes.
>
> On my c^Htrusty old IVB-EP -- where each (of the 40) CPU calls 'func' in =
a
> tight loop:
>
>   perf probe -x ./uprobes test=3Dfunc
>   perf stat -ae probe_uprobe:test  -- sleep 1
>
>   perf probe -x ./uprobes test=3Dfunc%return
>   perf stat -ae probe_uprobe:test__return -- sleep 1
>
> PRE:
>
>   4,038,804      probe_uprobe:test
>   2,356,275      probe_uprobe:test__return
>
> POST:
>
>   7,216,579      probe_uprobe:test
>   6,744,786      probe_uprobe:test__return
>
> (copy-paste FTW, I didn't do new numbers because the fast paths didn't ch=
ange --
>  and quick test run shows similar numbers)
>
> Patches also available here:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/peterz/queue.git perf/upr=
obes
>
>
> Changes since last time:
>  - better split with intermediate inc_not_zero()
>  - fix UPROBE_HANDLER_REMOVE
>  - restored the lost rcu_assign_pointer()
>  - avoid lockdep for uretprobe_srcu
>  - add missing put_uprobe() -> srcu_read_unlock() conversion
>  - actually initialize return_instance::has_ref
>  - a few comments
>  - things I don't remember
>
>

Hey Peter!

Thanks for the v2, I plan to look at it more thoroughly tomorrow. But
meanwhile I spent a good chunk of today to write an uprobes
stress-test, so we can validate that we are not regressing anything
(yes, I don't trust lockless code and people in general ;)

Anyways, if you'd like to use it, it's at [0]. All you should need to
build and run it is:

  $ cd examples/c
  $ make -j$(nproc) uprobe-stress
  $ sudo ./uprobe-stress -tN -aM -mP -fR


N, M, P, R are number of threads dedicated to one of four functions of
the stress test: triggering user space functions (N),
attaching/detaching various random subsets of uprobes (M), mmap()ing
parts of executable with uprobes (P), and forking the process and
triggering uprobes for a little bit (R). The idea is to test various
timings and interleavings of uprobe-related logic.

You should only need not-too-old Clang to build everything (Clang 12+
should work, I believe). But do let me know if you run into troubles.

I did run this stress test for a little while on current
bpf-next/master with no issues detected (yay!).

But then I also ran it on Linux built from perf/uprobes branch (these
patches), and after a few seconds I see that there is no more
attachment/detachment happening. Eventually I got splats, which you
can see in [1]. I used `sudo ./uprobe-stress -a10 -t5 -m5 -f3` command
to run it inside my QEMU image.

So there is still something off, hopefully this will help to debug and
hammer out any remaining kinks. Thanks!

  [0] https://github.com/libbpf/libbpf-bootstrap/commit/2f88cef90f9728ec8c7=
bee7bd48fdbcf197806c3
  [1] https://gist.github.com/anakryiko/f761690addf7aa5f08caec95fda9ef1a
