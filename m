Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5EB1217727
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 07:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745566551; cv=none; b=VJJj/5jRiRBBAkwyCmHgifPm2PFNr5zMLNARMZ1MdTWpjncbbIfApp/6Z1J7KTMqYM0I3lct0zTs9CjBLRfMvFx6E3JpnEmVf4j+J7lWcHr0g2j2hY89ElYfZarxfD+JfnuySPVa6V2joP9iyqAMIE7bDrs5mQM2jEevBNquqQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745566551; c=relaxed/simple;
	bh=EH+D9lSGOhF/hguyipj8JqOxJBhPEfdWB7/GOI5WqcE=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=gfvS1Ok/v0LAly30W1L2frsbrjngq1sI88pOeFSS1fMjisZ8k2Q+oPevpU4rG8jQ+wSqAvwqHoI95Z6CaN6yR0NW33w5wKiJjNtCozLlDLYgsTRsFdp4sMKYp1/QUUlx7j53VvVddWGvSPfOLPU3rl4iIb+2K43en6ASHfNeqgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h6SLVOGd; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h6SLVOGd"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1745566547;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EH+D9lSGOhF/hguyipj8JqOxJBhPEfdWB7/GOI5WqcE=;
	b=h6SLVOGdNEQnofzrlXu76ozsamObI+8C2Hi4IPT/zwhIY2yoLW1kxEWzb0g0JQ2nC1J3rU
	fo9n7OwkzljLfVoiyfqG5D+RJYAtmA5Zv880xFoFIO+5qSehS8gtSQ8rVArrTyk27cmJna
	WmnVcEJzt5pR2tnh5YQrC8C4tZj1pKA=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-677-XxRwuDK4NhuYuwHgfNER7w-1; Fri, 25 Apr 2025 03:35:46 -0400
X-MC-Unique: XxRwuDK4NhuYuwHgfNER7w-1
X-Mimecast-MFC-AGG-ID: XxRwuDK4NhuYuwHgfNER7w_1745566545
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-39131851046so626165f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Apr 2025 00:35:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1745566545; x=1746171345;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EH+D9lSGOhF/hguyipj8JqOxJBhPEfdWB7/GOI5WqcE=;
        b=o4HRBrwY9+/58fe3brDsahJetSyQwn8LbeCy8cdO8IbOtMeqnyMYGN1GYMDwYLCQaB
         dNup7hwLFbiYypL9vMwMpQGR0fvtJxEUXFX4SrjzyYOJLhQurEm7eGy/M+TCmqpbOBgf
         +8zV+IZwU0M1PBcG5y+jaGLCOgy/1QbiPpGhb3ihL7ApsTU+IhqqDEL4E/Eagdtr49nE
         jXlkp6QHoNuMo+iiOTdsbb3fRBk3VJilFJlzdxqzYTmc4SiRFdugxEFd36oYu9pfNiXz
         6TNGavkrNBMMlS//OwQM4y1F79BmhPXsmgQS36gwrzQZb1Y1+GRJMM+pThG99mID6Fkk
         B2ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX07QE62L07ydf5kBZs9ORx/haAg4ZHQjYj0tfC7IDzwFPOShC2nwf/HiJ00N4UBW1pScziLlTHpT5OziSY55RHBLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBntZNxIk2n2DWPEWhoo6f9BijsTVS4Bt822mCJhdbjIKCLk8Q
	ac5Jcod4GCwbIOo7S1V4TpXaBpwIBtLZFcidhmgUXg09ekMX0r8I2IyMmuL9yUqLpX/HpmTW7Z5
	5oWQSXcaAxSPhGU/jbvdedN0KGoNY7vnUtssb245djiDHEFinciw9F/+v7zJYLfiLw6759w==
X-Gm-Gg: ASbGnctvGrk+NYWQWJ1I36HohTCmUvUwlDD44Us2xyzwJY584AuZ6BqMOoAysvyMrCU
	BUqls2ic40zs5ey1rnl/XDM9SjARNJ9cayWraU0QTmMmbacD5hrp5Cfe9CtHKKlI1hPgSWQIO5M
	ISvUjVQtAXllLq6Wm+1FqRQCrZm7KMnNUkZgRPIf0jgAfzXy3J7z6GKBzLbGwxnEyLmL1dwPXlb
	Lz/P/F64G+IYNabfb0x0VQPPy3uZZuStOPq/IUPp2gpcsh3CAIp4amKuFucYQ8yR2o1Ue2zy3YC
	zd13z4nJ
X-Received: by 2002:a05:6000:2509:b0:391:4999:778b with SMTP id ffacd0b85a97d-3a074e3c881mr700976f8f.28.1745566545124;
        Fri, 25 Apr 2025 00:35:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF56OpQfoua286mTOa+U42MZKB4dFNRABTjE6tLeWjmt3iIAY8Bb2eajNfgYiyu3veG9cpclw==
X-Received: by 2002:a05:6000:2509:b0:391:4999:778b with SMTP id ffacd0b85a97d-3a074e3c881mr700924f8f.28.1745566543755;
        Fri, 25 Apr 2025 00:35:43 -0700 (PDT)
Received: from [127.0.0.1] ([195.174.135.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4409d2ac26dsm47259565e9.21.2025.04.25.00.35.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Apr 2025 00:35:42 -0700 (PDT)
Date: Fri, 25 Apr 2025 07:35:36 +0000 (UTC)
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org,
	linux-kernel@vger.kernel.org, john.ogness@linutronix.de
Message-ID: <169b8478-1eff-46b1-a782-f0cb529330bb@redhat.com>
In-Reply-To: <20250425063456.NBE35YHR@linutronix.de>
References: <cover.1745390829.git.namcao@linutronix.de> <c23cb5ef10310f978c3f90f07c2dbb9b042e8b01.1745390829.git.namcao@linutronix.de> <c321c7350ec10f9f358695acd765d2dbd067eeb2.camel@redhat.com> <20250425063456.NBE35YHR@linutronix.de>
Subject: Re: [PATCH v4 20/22] rv: Add rtapp_sleep monitor
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Correlation-ID: <169b8478-1eff-46b1-a782-f0cb529330bb@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f_bBZHhZ3wbofJS_IQQjLUrJqrfrmKUJB6bjDTyCS4o_1745566545
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

2025-04-25T06:35:09Z Nam Cao <namcao@linutronix.de>:

> On Thu, Apr 24, 2025 at 03:55:34PM +0200, Gabriele Monaco wrote:
>> I've been playing with these monitors, code-wise they look good.
>> I tested a bit and they seem to work without many surprises by doing
>> something as simple as:
>>
>> perf stat -e rv:error_sleep stress-ng --cpu-sched 1 -t 10s
>> =C2=A0 -- shows several errors --
>
> This one is a monitor's bug.
>
> The monitor mistakenly sees the task getting woken up, *then* sees it goi=
ng
> to sleep.
>
> This is due to trace_sched_switch() being called with a stale 'prev_state=
'.
> 'prev_state' is read at the beginning of __schedule(), but
> trace_sched_switch() is invoked a bit later. Therefore if task->__state i=
s
> changed inbetween, 'prev_state' is not the value of task->__state.
>
> The monitor checks (prev_state & TASK_INTERRUPTIBLE) to determine if the
> task is going to sleep. This can be incorrect due to the race above. The
> monitor sees the task going to sleep, but actually it is just preempted.
>
> I think this also answers the race you observed with the srs monitor?
>

Yeah that could be the culprit.
Peter's fix [1] landed on next recently, I guess in a couple of days you'll=
 get it on the upstream tree and you may not see the problem.

Nevertheless, I didn't check exactly what --cpu-sched does, but I'm expecti=
ng it to do any wild thing to stress the scheduler, so it may be normal to =
have more errors than, say, --cyclic, which only runs nanosleeps.

>> perf stat -e rv:error_sleep stress-ng --prio-inv 1 --prio-inv-policy rr
>> =C2=A0 -- shows only 1 error (normal while starting the program?) --
>>
>> Not quite sound, but does it look a reasonable test to you?
>
> The above command use mutexes with priority inheritance. That is good for
> real-time. The errors are due to real-time tasks being delayed by
> waitpid().
>
> Priority inheritance can be disabled with "--prio-inv-type none". Then yo=
u
> will see lots of errors with mutexes.
>

Great, that's exactly what I wanted to know, thanks.

>> I quickly tried the same with the other monitor comparing the number of
>> errors with the page_faults generated by perf, but that didn't make too
>> much sense. Perhaps I'm doing something wrong here though (the number
>> reported by perf for page faults feels a bit too high).
>>
>> perf stat -e page-faults -e rv:error_pagefault stress-ng --cyclic 1
>
> This command run a non-real-time thread to do setup, and a cyclic real-ti=
me
> thread. The number of pagefaults of each thread would be roughly
> proportional to the code size executed by each thread. As the non-real-ti=
me
> thread's code size is bigger, it sounds reasonable that the number of
> pagefaults is greater than the number of monitor's warnings.

Mmh I guessed something like that, although numbers were a bit out of propo=
rtion (e.g. 500 page-faults and 8 errors), but again, I didn't check too ca=
refully what happens under the hood.

>>
>> Anyway, the monitor looks good to me
>>
>> =C2=A0 Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
>>
>> but it'd be nice if you have tips to share how to quickly test it (e.g.
>> without writing a custom workload).
>
> I tested the monitor on a real system. My system has some real-time audio
> processing processes (pipewire, firefox running youtube), yours also
> should.

That's a good point, also I didn't mention I was running these tests in a V=
M (virtme-ng), so the system stress is minimal and perhaps the setup trigge=
rs some different oddities (filesystems are overlays and some other things =
are set up differently from a real system).

>
> But thanks so much for testing with stress-ng. My testing didn't stress t=
he
> system enough for the above race to happen. I will give stress-ng a few
> runs before the next version.
>
> Best regards,
> Nam

Thank you for the tips!
Cheers,
Gabriele

[1] - https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/c=
ommit/?id=3D8feb053d53194382fcfb68231296fdc220497ea6

