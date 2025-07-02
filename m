Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 630652ECEB1
	for <linux-trace-kernel@vger.kernel.org>; Wed,  2 Jul 2025 18:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751480517; cv=none; b=XDcRWuY1GckC0QW5ireHbsOwTZknB8z+seb29+scTGNptb/HW4sSgdwlNEGOVgDw6m5yYYbEKopvqDWLBq/JNPpWi+W9fYTjy+VpptbZrRcvcXwLRyF2L5QUcVSSS1jdtzNNAQmxnD44V59tOD9c9xeC+f0LP+QefHbBs4/kG+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751480517; c=relaxed/simple;
	bh=8dPL6cewj+QXiDVpMgLbkUYfzccaNgbPuZ9A+ZlbtD8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ayzAm8U9EIcvT+jvl2yghqo+G5818X84zOS4ESdndGaeNlib5ShjMrk0RCimdvXYDDXXSB2OA6j+FNx0pf5kgmqvm5sjK2s5/zJut4+0s6NmbnqC6eU3qPJyvWy91sRe5p1IjKEYQ5tq5qKcTPM7r012AzXz9lAU/+SjlfyI8UQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=ft/YCqpO; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="ft/YCqpO"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0de0c03e9so1083452166b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 11:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1751480513; x=1752085313; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gAzEH7Ab5cAtbqr3Xp/qBBT6LGjJFnrqCTGw1ULOX9I=;
        b=ft/YCqpO0FXHmQ+DZb14BXdPk+Yx/t5+rI0YwNA3RvujJAVMwTfI6u+5MQ1o1cX6VT
         YbpeQ3Dg+XauhGKR1IdzsknmbPBMoCYt20eYyUiVvnupxPFy8hA4hVyHILp0AsPMlJng
         rhiIFIowUh5zVWZyuMtJ8DSCYa+vTvFhUlNXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751480513; x=1752085313;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gAzEH7Ab5cAtbqr3Xp/qBBT6LGjJFnrqCTGw1ULOX9I=;
        b=YpMQfgMjg/lcwCTTvpF6aKzRA7F61Q9qH8g+0VoynU84V54h+nrUvqCR8f2P3ON0n7
         hvy+l9kIex6DDRI8NQ0cl751AlbFlWQqdJ7SV/dgCoY8puVBTgYhscncOfXxFwdyylVt
         Yg2kKLsFFS4xff38zVUUtDUj8GerjsImDwrQWne9l2iiYjVYXq2s+PgH2BE7dCOKJ+xi
         8EQqlMTeW26PXqPmqbsEkPLCm2tZIjtaaMvuxWrcCNyEOpkNr30oUaYGzVXmEKjeJewa
         zuJb/Hehjxic6sXm0okMKsUJW2hXRndYoeh9XkCOcy60X1x/HKQBhku3k5Uvha3+1/Sg
         Ts4A==
X-Forwarded-Encrypted: i=1; AJvYcCVpzC89ZBJqapfhnYF5D/aMuF+d58agLw1PZ4d1zYnH4DhRgKSkAPPNiOdbx93l/+vYEi4w0XYlgNi9h/hu6PyR6Zc=@vger.kernel.org
X-Gm-Message-State: AOJu0YyZZ6HRiSjo+HWoZOUylzFMTD2mJvbasTlIRZiI2ta9JYXetQdQ
	b8737NRDe4rR5UbGl0mazRh27onGOXiJ6wpYUz7aoEYZpDpGNYf+WInWn0vzeq9UG2aUjQfUDdN
	vPj9IvhVedQ==
X-Gm-Gg: ASbGncsTD795hbY6lGvNBbqDLp5J+AWbGRMdbm3ZK7qXdBOVl9i+TLDzGsMkPRKgZPz
	Yav/sg2TY7xbrNljQyTWbkXB+EX9Dx+yqqd7L3/wWApZQY0jzIaZsWj+UTSGsqVqdO3/1mq8MUZ
	m/zDQuKwXor7j+WnNVp2gkCJmotj1OxMgqKq5tWwWa2jIMQm3eaA+C3reGkfD1kfkj3YpNtKPkj
	+91NxOKOpyjS+1inD5LnjNyvz0kzS6BNsXv2XD7pU6lpH4/bIXUMmEQB+APRCPv5cesIznyvMnt
	mZKF1iFOktsM0NEZIvIh7/u2uDtP+iirQeiH4587oPtOD+39sUCOE4KqE2te17S99vzhitgABos
	oVJaoOQ6YujK/5LbGHqCQiT9WxmurgdC8taeM
X-Google-Smtp-Source: AGHT+IEpKR3kJmsU9TVLtgB9MXdbtHvoCpVsUn6AnxuCMB/VxaXzzK4mN2jGbeRANsBCbz55vWMUTA==
X-Received: by 2002:a17:906:478b:b0:ae0:da2d:44b9 with SMTP id a640c23a62f3a-ae3c2b12acemr426302066b.7.1751480513305;
        Wed, 02 Jul 2025 11:21:53 -0700 (PDT)
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com. [209.85.208.45])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ae35363b464sm1111041066b.1.2025.07.02.11.21.51
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Jul 2025 11:21:52 -0700 (PDT)
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-60c4f796446so12116969a12.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 02 Jul 2025 11:21:51 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVV4TpGUYQYHFkMGUbQYha3khkyNNAkB7r/p77NVM5ZHkMhFgduWOBET7jKekA+tt3uTnMNH+R15kEsE50I23f5Gvs=@vger.kernel.org
X-Received: by 2002:a05:6402:270d:b0:60c:5268:5587 with SMTP id
 4fb4d7f45d1cf-60e5362ef3emr2951767a12.29.1751480511414; Wed, 02 Jul 2025
 11:21:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250701005321.942306427@goodmis.org> <20250701005451.571473750@goodmis.org>
 <20250702163609.GR1613200@noisy.programming.kicks-ass.net>
 <20250702124216.4668826a@batman.local.home> <CAHk-=wiXjrvif6ZdunRV3OT0YTrY=5Oiw1xU_F1L93iGLGUdhQ@mail.gmail.com>
 <20250702132605.6c79c1ec@batman.local.home> <20250702134850.254cec76@batman.local.home>
In-Reply-To: <20250702134850.254cec76@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 2 Jul 2025 11:21:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
X-Gm-Features: Ac12FXxdVtdafV1DjZUKNDDMmbhEtpMMqjKmEMhutyb6_ij-Rv8l7HBE6kdoJJ4
Message-ID: <CAHk-=wiU6aox6-QqrUY1AaBq87EsFuFa6q2w40PJkhKMEX213w@mail.gmail.com>
Subject: Re: [PATCH v12 06/14] unwind_user/deferred: Add deferred unwinding interface
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Josh Poimboeuf <jpoimboe@kernel.org>, Ingo Molnar <mingo@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Namhyung Kim <namhyung@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, 
	Andrii Nakryiko <andrii@kernel.org>, Indu Bhagat <indu.bhagat@oracle.com>, 
	"Jose E. Marchesi" <jemarch@gnu.org>, Beau Belgrave <beaub@linux.microsoft.com>, 
	Jens Remus <jremus@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Florian Weimer <fweimer@redhat.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 2 Jul 2025 at 10:49, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> To still be able to use a 32 bit cmpxchg (for racing with an NMI), we
> could break this number up into two 32 bit words. One with the CPU that
> it was created on, and one with the per_cpu counter:

Do you actually even need a cpu number at all?

If this is per-thread, maybe just a per-thread counter would be good?
And you already *have* that per-thread thing, in
'current->unwind_info'.

And the work is using task_work, so the worker callback is also per-thread.

Also, is racing with NMI even a thing for the sequence number? I would
expect that the only thing that NMI would race with is the 'pending'
field, not the sequence number.

IOW, I think the logic could be

 - check 'pending' non-atomically, just because it's cheap

 - do a try_cmpxchg() on pending to actually deal with nmi races

Actually, there are no SMP issues, just instruction atomicity - so a
'local_try_cmpxchg() would be sufficient, but that's a 'long' not a
'u32' ;^(

 - now you are exclusive for that thread, you're done, no more need
for any atomic counter or percpu things

And then the next step is to just say "pending is the low bit of the
id word" and having a separate 31-bit counter that gets incremented by
"get_cookie()".

So then you end up with something like

  // New name for 'get_timestamp()'
  get_current_cookie() { return current->unwind_info.cookie; }
  // New name for 'get_cookie()':
  // 31-bit counter by just leaving bit #0 alone
  get_new_cookie() { current->unwind_info.cookie += 2; }

and then unwind_deferred_request() would do something like

  unwind_deferred_request()
  {
        int old, new;

        if (current->unwind_info.id)
                return 1;

        guard(irqsave)();
        // For NMI, if we race with 'get_new_cookie()'
        // we don't care if we get the old or the new one
        old = 0; new = get_current_cookie() | 1;
        if (!try_cmpxchg(&current->unwind_info.id, &old, new))
                return 1;
        .. now schedule the thing with that cookie set.

Hmm?

But I didn't actually look at the users, so maybe I'm missing some
reason why you want to have a separate per-cpu value.

Or maybe I missed something else entirely, and the above is complete
garbage and the ramblings of a insane mind.

It happens.

Off to get more coffee.

             Linus
