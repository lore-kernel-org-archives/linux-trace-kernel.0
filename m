Received: from mail-yx1-f41.google.com (mail-yx1-f41.google.com [74.125.224.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CFB032FA2B
	for <linux-trace-kernel@vger.kernel.org>; Fri, 21 Aug 2026 01:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787275225; cv=pass; b=qaaOiz7cZ8vzN5zSG5921M/6Skcw1MTHe15xrFON9JJK0JQkqdSskg3FcfPmGAWoLocArxQ6gu+O3vAjHuopMO+c9NBK5vEErc0yL+AAzviAxpmFU6ZB1Ke6TFzI31Or0VOEWFUo9nECgBqSAQMNjjgn4hj7MxvgJznuBINbcZg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787275225; c=relaxed/simple;
	bh=beEVlsUuL9o5hYoikgcqc1vZjOkeGxTIGhmngv+9k8M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LbDm5Y4zOVU4aXICl3+oCM0XJJ3uKuk7ppgmINvknnABNzI7C4lwIgDgKiVWyc9FUf73h9jCJ1Kye4QEAyHMIHGgbUW9q1LhmfpyBKnnS3062kXleewfsCBIVAfcPn5s5fPkc3sh/STi/MIG/8HkwuNvyy5lieMsfkyj7JfO33o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=StO3cSkM; arc=pass smtp.client-ip=74.125.224.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="StO3cSkM"
Received: by mail-yx1-f41.google.com with SMTP id 956f58d0204a3-66ce4a63e17so523425d50.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 20 Aug 2026 18:20:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787275221; cv=none;
        d=google.com; s=arc-20260327;
        b=U/mU1aUIPm2GWIngTiJgfSwos2NDUsqERi/agEGc2XwYbuHQb34Ya3hK4nbMZT/FtL
         LaWZUwBZba9rhbFGY0hTm/RRu/bBT5yOaDqjYy2xek49glb6HAuLckRebWOK6li5J2v7
         epEZ0Vjb45D8hk24vi0sE4J+QhrFUfjyy3pyDVCOdoRQIydfYH/bVjFh2f4JQ3uL6qeP
         mra72L1CAeWr1Q/sPe1C4wgG6wtC3AQXcVKVu7LfW6BZHh1OoiHrwcWUZ/+7nH0hUnpV
         f41Rlgt2u2sAsBkA9t0v6Ib2aK3y7P/wRyAYDVZljmiP9oupz8oLcPmL+LARpe9fq9eN
         Tylg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        fh=OAC/ZCExgFVv0Myo8Rg6v8sFN+1jASpo1WCh7Rmr7+w=;
        b=rTGa63J0GKcYSjdXlmbTqkzatZVPhY7jpvDK/yQKNdR1fWRq/u5VR8Si3QDgPh1JQu
         8bOxzjvbnnykDt3EartmYFAi9ifhvRpYkh1bS0EUD99uGzNIJlpnlEV5fnRCR3w4oF4z
         Py3k+VY692Irf1HHQDia3jlR15uviegXqEhRRozKWAa/PHaFB/gURIiZIn413dShaS0+
         hbQw/V0eXfJEJbaIgXEbA56DKDluwkq/WY7Km8TZcl5IjZrRwrqnyPqBzAx47o3b6fKG
         MI7o2W8aJGhjhrG0NujYC0b9ZLvJh3i4LO0NciVIYDblL3BQgp8v0FcxHTYSWlHtnXPB
         reiQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787275221; x=1787880021; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        b=StO3cSkMRrkerKklAjGzm32z470HVenfFB21qn/HFzuepkklYWB0MvZhgKynrNdpUC
         OmlGZdFXpNj2LptWUYYRuMGmD+T7UgvEnYMSH8Ibj4XMYCdd5h12zqCU9gBuxkyGeqzS
         PF3aja90ZJvyr7a87wja02sZTiOZUnG2msi81cXlXKFKekGHsNTv3CSGZCLPxNQZ9f4/
         jaWAgjPrpMs1bMUdz7ArUsClK38d1ycA3vGG7JMQgM1i/UrJdvQokQPaFcuuuxVC5XqS
         zkrlywmyZE8/vYyIN2n5ZSD0DboWn9+a0cm0MjbY1SNAJFTyaN1H9EGBmD5WU07lH7KQ
         R8rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787275221; x=1787880021;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Cc/ydSvi4LcaS7pHjzjdCQH2bbW529bELwQ3mNa36YE=;
        b=Nfz0o3kPQxhBeKKwaiO9rQTrqdeSuHgSP6EO11zaPs0zz/Nxol7PF5+qMTabydyaO9
         ewsr/1Z101uCw8tmcUpGj7KUyVRvSdM2zmdJHGiWG/xasJxGArKQwNxgFhXc8/aWNL0x
         VZlNOUJE/C0pu0rjFvo1lqsN7PDpo4gVW8BP8HOWm5ky9ZNttWuPmJPmbZQ4KIyQ8Qu/
         xg9p5kbGQiP5CcCqN+FaiD0HugrGv9Na0iQA8VO7UATOTWJNTRd8Q2qKIytX+y7QhK33
         kwYZl3qBSUg1cxJBGkxz+ahs/iPAmiQD20p+ODmVvYRDwUeTWbe046v9acZaL1YXVZlX
         djaw==
X-Forwarded-Encrypted: i=1; AHgh+RpBuSdGDGjvwZwc1M7+JP8H8ZraoGZbSMkTAcEcOgbr1uBNulHUU9majpu0g1Fw+0jFgEnGeqrUauO7lw30q+9InyE=@vger.kernel.org
X-Gm-Message-State: AFuF++nSuDpmh2z7gkqfW1ZNLMM+Zz2tD7xmmLMpyt1JArmc4lFJiYME
	2kA/mBhS5fvKGpHaC2a6gfOIQpWIwCoH70mOUAq1tSJBWkyFM4hLNwFrVSUYsHHSLYHsubiA06i
	THEsOiaFM5LZFSFSYp4zksac+YnwzazU=
X-Gm-Gg: AR+sD12cMmqzLN77aWBvtMXLhHXLh81gc1wseIBkdpdUpdbvCJbdQCo1c7sAOB1tzOd
	KO5C+RJ8uxZfCxHQXf0k9xxH2ArFYZn6UW/2eG245EG51JhFW+Lb6dFW7r/+ApYIMPN0COrw+no
	A7O+1+1aojY3PVg+vnVF1Nh/6a1MyRzxAkgic9jYIxYkd/385o/DkIO0QYaHYTGPIm7Lv27DbpQ
	drkYYkK2XNrCkr7ly3wIws64MRPneaMXcGZwmxLuPyCzgKyT7+x2+KsktFjwZvdxa06r+kmFf5v
	2azp6QtPGj0wqSC/PmjYMJYvh52mMUukvNOMMKeTQnU5G6dWFITanEcVqwzyQnFL8ZL6gyMjMPG
	Xv6irruADanIHyM/UWmSVrNtHy9f9BKuG6S8=
X-Received: by 2002:a05:690e:6ca:b0:66c:9d32:46f2 with SMTP id
 956f58d0204a3-66ce4b91cc5mr837296d50.54.1787275220801; Thu, 20 Aug 2026
 18:20:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260813060528.365959-1-kartikey406@gmail.com> <20260813110522.GD1246887@noisy.programming.kicks-ass.net>
In-Reply-To: <20260813110522.GD1246887@noisy.programming.kicks-ass.net>
From: Deepanshu Kartikey <kartikey406@gmail.com>
Date: Fri, 21 Aug 2026 06:50:09 +0530
X-Gm-Features: AcwNN1Xq-0u97UfSOxijlYn8NWJaauIW_R8xaQQaZYfAs9qafwmGEF-mflXoBV8
Message-ID: <CADhLXY783QR01JkL8C1sJh1tBrud-6d=fmovg8wzTqzDzE_PEw@mail.gmail.com>
Subject: Re: [PATCH v2] perf/bpf: Fix data races in BPF perf event handling
To: Peter Zijlstra <peterz@infradead.org>
Cc: mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	mark.rutland@arm.com, alexander.shishkin@linux.intel.com, jolsa@kernel.org, 
	olsajiri@gmail.com, irogers@google.com, adrian.hunter@intel.com, 
	james.clark@linaro.org, song@kernel.org, kpsingh@kernel.org, 
	mattbobrowski@google.com, ast@kernel.org, daniel@iogearbox.net, 
	andrii@kernel.org, eddyz87@gmail.com, memxor@gmail.com, martin.lau@linux.dev, 
	yonghong.song@linux.dev, emil@etsalapatis.com, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org, 
	bpf@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	syzbot+651d2774bd1d8395595f@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 13, 2026 at 4:35=E2=80=AFPM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>

> As I said yesterday, how can perf_event_detach_bpf_prog() run
> concurrently with __perf_event_overflow()? Unless you answer that, this
> patch ain't moving nowhere.
>


You are right to question this. The KCSAN report from syzbot shows the
race was detected at runtime:

I don't have evidence to prove this race condition.

> > 3. perf_event_alloc() reads parent_event->prog locklessly during
> >    fork() which can race with a concurrent detach clearing and freeing
> >    the prog, potentially causing a NULL pointer dereference or
> >    use-after-free in bpf_prog_inc(). Fix by holding bpf_event_mutex
> >    when inheriting the BPF program. Make bpf_event_mutex non-static
> >    and declare it extern in perf_event.h so it is accessible from
> >    kernel/events/core.c.
>
> This seems like a separate issue and should thus be a separate patch.

Agreed. I will split the perf_event_alloc() fix into a separate patch.

Thanks

Deepanshu
