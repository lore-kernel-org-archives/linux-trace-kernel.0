Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A54C8F
	for <linux-trace-kernel@vger.kernel.org>; Thu,  6 Feb 2025 03:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738811251; cv=none; b=kqh0frTfoMX92xyPVoorEFgxTnw5H4tmVShV3jC7T/A8x3Itd3JpAHNnh6xt7kRGwB8UGXO93FUiZ+DAxEoKdJAcPS8FBbCoUoPvBNGkRL225pE7sTIHmFbjTGHsM2ta4lRxGc4QykElEfjCZXV/sp6XLVu6MR6CprjKnxiHIyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738811251; c=relaxed/simple;
	bh=UqOK+e5E92IqGb9eNeZnxGAAfSi4hG39f2eWfTD1/9U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tLC7gQ1G5aHH2NYGkBOGBVZB9vjidd5nB0IcWc10D731GXnJZgzYCDexwHuWHMCaMB3m9UDaIj9cZIxUj2hslgdiFcMasLn1g86ejiJg6pe6ylxSZQdDf+jJnJN7AASosZpQZSrxvO4svVen/XK9p6fgzfB+RO7Tsnx8UZ4vDN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org; spf=pass smtp.mailfrom=joelfernandes.org; dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b=p6j2u56A; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=joelfernandes.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="p6j2u56A"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-38db570a639so194361f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 05 Feb 2025 19:07:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1738811248; x=1739416048; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0X8Qu1oJSGxAxKqVwaotR6zN8wjOFVNqLjZMWyUans=;
        b=p6j2u56ASoGgsAZixSR6wUypMCP/gduV9ZDB9WIe0Uqw18Q/VxQTrcqiVCXGS5Qpgz
         X3PD6+u2f65UzeyIOGjTw+DihLTNqFyov4sSqV8Suu+RnD7qcQIA+airfP0QUpDSpMuU
         Lv4oMxqXiZwKnPFWV+4pIleeYjcfyhJolPBRk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738811248; x=1739416048;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=d0X8Qu1oJSGxAxKqVwaotR6zN8wjOFVNqLjZMWyUans=;
        b=wjUP1cCGy70ro8c/iQQ28GWbXr0/2tExEKX9kXfFPq42p5SIzwiE6M+CwTLBmSvp8q
         zg29eXHv235l0ED25JGuWU86pBTI+rs93SVnHdtfs/nVC8KIo+WEDsbjliX91r0L5mks
         amoUh6AsnByKLfrvx5Iudil75Dhh22ClyDYrqcyuxFCcuTfAKUQ8/RAPwHHRYqhzsx1T
         +XadS2js1BKZcnu+v0klBs/UPnPWzqtDqwTpaUUCCcanvXmqPVONJ00ZGFIyiZnqG6od
         7hraeyy9XFZimG4Jlla+B2i851BNQ6AjvZL/tc6Kzg4tVkO3o7QOYeESpTuvWp+bHcS6
         bIFg==
X-Forwarded-Encrypted: i=1; AJvYcCV0LssfaLU7sJhzXlbnSsNEoTySFFmeEvVINkoqNjP6g/TnRkGgV2j3y8BcUXBs1KMfMUJTBWdMwsN0Z2Rt951dm04=@vger.kernel.org
X-Gm-Message-State: AOJu0YxcywQFQmI9sbeC3gBB/6kztpiHFJ7PFSa6kp613sAFs3MSVEMO
	4zbJhipwDg3bFr3XSoal1XAOqfZSyrJ0CdLjohmm1ak0zPOD0Wnzq7ESgJ59g1uk3H6x1hIbdBV
	+FsH8Bobm5EXgIkF02n+aQoZArFkWJko2XZxEVA==
X-Gm-Gg: ASbGncsN2i3uMjk2TjTWVTUWNk11kOAIJOLX33osysxGeEgzNFu76drfCVfVkSosJQM
	YBKeMqblecFtO3X9M78QESdzbLG6AF+hy7WtEh+gsitE5TiUriVcb5Oi2GVd8eJ5mv2klZ5xjjQ
	==
X-Google-Smtp-Source: AGHT+IFhCuN1t2tSucTEB6wYu/3LdGn6xhB9nOnrSGuYM34cTxwvwctQ7cqu4dBDoTsr5WE6bqYMaA9XqkDKEEosVBk=
X-Received: by 2002:a05:6000:2a7:b0:38d:b82a:d772 with SMTP id
 ffacd0b85a97d-38dbb3063f0mr1050674f8f.26.1738811248129; Wed, 05 Feb 2025
 19:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <EC77D83D-DD17-4CCD-9EF6-C4C39FCE16E7@oracle.com>
 <9DA1FAE6-A008-4785-BDF9-541457E29807@joelfernandes.org> <20250204220418.35949317@gandalf.local.home>
 <CAEXW_YQxTi2y_hY_e4AjLSa6RwVVLn3DPj5d4Cfewq0js-0UTA@mail.gmail.com> <20250205081635.397eacb0@gandalf.local.home>
In-Reply-To: <20250205081635.397eacb0@gandalf.local.home>
From: Joel Fernandes <joel@joelfernandes.org>
Date: Wed, 5 Feb 2025 22:07:12 -0500
X-Gm-Features: AWEUYZkwb1UDNJpqESrHKgdguvt7oY_uHNtRCVindKlblx5I3avE0g0lh8l1mXY
Message-ID: <CAEXW_YQY2zuU+XZjrYWLS860+PJno0nf9WAe1iPU=EyDkA7H4Q@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Prakash Sangappa <prakash.sangappa@oracle.com>, Peter Zijlstra <peterz@infradead.org>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ankur Arora <ankur.a.arora@oracle.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>, linux-mm@kvack.org, x86@kernel.org, 
	Andrew Morton <akpm@linux-foundation.org>, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de, 
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, 
	Boris Ostrovsky <boris.ostrovsky@oracle.com>, Konrad Wilk <konrad.wilk@oracle.com>, jgross@suse.com, 
	Andrew.Cooper3@citrix.com, Vineeth Pillai <vineethrp@google.com>, 
	Suleiman Souhlal <suleiman@google.com>, Ingo Molnar <mingo@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Clark Williams <clark.williams@gmail.com>, 
	bigeasy@linutronix.de, daniel.wagner@suse.com, 
	Joseph Salisbury <joseph.salisbury@oracle.com>, broonie@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 5, 2025 at 8:16=E2=80=AFAM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
[...]
> >
> > > And you are also OK with allowing any task to make an RT task wait lo=
nger?
> > >
> > > Putting my RT hat back on, I would definitely disable that on any sys=
tem
> > > that requires RT.
> >
> > Just so I understand, you are basically saying that you want this
> > feature only for FAIR tasks, and allowing RT tasks to extend time
> > slice might actually hurt the latency of (other) RT tasks on the
> > system right? This assumes PREEMPT_RT because the latency is 50us
> > right?
>
> RT tasks don't have a time slice. They are affected by events. An externa=
l
> interrupt coming in, or a timer going off that states something is
> happening. Perhaps we could use this for SCHED_RR or maybe even
> SCHED_DEADLINE, as those do have time slices.
>
> But if it does get used, it should only be used when the task being
> scheduled is the same SCHED_RR priority, or if SCHED_DEADLINE will not fa=
il
> its guarantees.
>

Right, it would apply still to RR/DL though...

> > In any case, if you want this to only work on FAIR tasks and not RT
> > tasks, why is that only possible to do with rseq() + LAZY preemption
> > and not Prakash's new API + all preemption modes?
> >
> > Also you can just ignore RT tasks (not that I'm saying that's a good
> > idea but..) in taskshrd_delay_resched() in that patch if you ever
> > wanted to do that.
> >
> > I just feel the RT latency thing is a non-issue AFAICS.
>
> Have you worked on any RT projects before?

Heh.. I think maybe you misunderstood my statement, I was mentioning
that I felt (similar to Peter I think) that NOT adopting this feature
generically for all tasks due to a concern of 50us latency maybe does
not make sense since poorly designed app / random hardware already
have this issue. I think the main concern discussed in this thread is
(and please CMIIW):
1. Locking down this feature to only SCHED_OTHER versus making it
generic (maybe sched_ext could also use it?).
2. Tying it to specific preemption methods which may change user mode
behavior/expectation (because LAZY is tied to preemption method).
3. Overloading the purpose of LAZY: My understanding is, the purpose
of LAZY is to let the scheduler decide if it wants to preempt based on
preemption mode. It is not based on any hint, just on the preemption
mode. I guess you are overloading LAZY by making LAZY flag also extend
userspace timeslice (versus say making the time-slice extension hint
its own thing...).

Yes, I have worked on RT projects before --  you would know better
than anyone. :-D. But admittedly, I haven't got to work much with
PREEMPT_RT systems.

 - Joel
