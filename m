Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6671CBE87
	for <linux-trace-kernel@vger.kernel.org>; Sat,  1 Feb 2025 23:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738451917; cv=none; b=Q+v+Oz5zI0fkA5mK6ymUyUqAEpdkCL6NyVFyz7ziIHbudjXtqtynX1uMxfpLtwn5Cz5js/emBjPkrz2Pk7mb4tAZile/gRnNhM8ofGNUUp1L/uisrVP0HtKuI39CqfJmlNK8CjKyU/+JMlCAG9qGi4i4Yfb61myvYJEAfQCw6V0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738451917; c=relaxed/simple;
	bh=px3hVcznrT6Balh2mpqYyF108IlrjUXg4nFHrLhwroE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XgF+bEFtiyNaPY05+5OqlvNBV9iWPRdIrLTAVGVJO4DOL1q7wwu/mwLvpObm3DQOSfvedpGexHo5Ju3vsiciMj+X5nQ65ipO2Wt1A2gR7VFLs6VhYJbAvPBvLf0rXU6Uo9mvrQF4N6WPjd0ma9Qt2e6vbJ1/JBDeaI0ucpJr92c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=dMGAn1PY; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="dMGAn1PY"
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-aaecf50578eso643616566b.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 01 Feb 2025 15:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1738451913; x=1739056713; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SZLpGznw6NX+7xYT926JUOJVSOGgi/nOeg57L4kVIH0=;
        b=dMGAn1PYGQJu5WYkeVBHS2hu18mp5qobOSG2+WOT1/A41O72ShidxIAS2TL0SJZU0L
         +fBXqppQwWZ3C56XK/jlYScp+4GEEu9QKAcwdM54+w3Jgt6h2zCcMvBt0GcXgPwgR787
         vb57wBkAJM6JqRSqIhYDTHenwRU5YiF8GO4Ks=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738451913; x=1739056713;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SZLpGznw6NX+7xYT926JUOJVSOGgi/nOeg57L4kVIH0=;
        b=cB54kIIrRVqsJJfprXGOQ4h8IjO04vYKI2Y+qPhR5UPqKdOpT6dZGt7z6UbHqHm+OI
         SD0HOjHdnBdgpHMiugZLwi2NjrqBFOPabO3ax9jgVnTvYAecCq48DV6IDHy/NDFjbPfG
         Ngal3+FmjhnZtETzOalyv5AAtwVZwIlFFMunTPHZdy2vjEp+6Mw89cbT3z3GvYgozbYn
         ldMgLtKIB1SJTBvg/pzsb6LOQjeoEK9YR1uafVrlxIibNlzWnkoVnc4K8KFIscerewgx
         jiA8Ev/uXReTwr8fRMCFaXpHvtgNReFqWajcp/kegzTOoaElS0m2IBb6HIjfCO0jwvoC
         qd0Q==
X-Forwarded-Encrypted: i=1; AJvYcCUvZ52aDEQY+V0euARCfjHDivf8tb3Fk5wwF3Osi7SlD6DbUVf5ltwvoohRCXPyBOyFVm1YJgifs1B29wcFlaJydI4=@vger.kernel.org
X-Gm-Message-State: AOJu0YywhLFG5ZlaIHyL0edxJTavHEyakxiiu2DFmapIf1eO+XsNTaeM
	1/JEZoi4FcojgjcZJpRCeY37FDnBxmp+jO+q6SbVH1DRkBoIrgJCR22LCBT1GhfRJhEIthtyW6b
	FG44=
X-Gm-Gg: ASbGncuAr309U6Jjs2+A5Hu1z788+AD6qTzUCUHQnST5ih64+ucvu9p4kHgLZmvXdV1
	b93tLdnaur7hySSj3kDaT9VPwnvVTQsLoR7qVipULpNAiwjIuH7qsguzkXKcyQ4WafSFvyDhCWa
	l4Uv2vNXmPg/w/SlQYeGBAexL3zt3m23zkfQpNsKQ0vzpGKcy2RqxWTJ4Oj+fyLncQH1z7uyOS8
	AnKrlCtpByMt/ZnIBMPWHnomx2zcQuoSYIcAZ+05E/xx1tVQIChMBfKRDTRskKh+mf185E+tqnP
	Lh0SrHc2Nsfqb+aGU+gby154l5GwDVOkHUA98UM39X+vHkIFeKqjZ2//1PJyNp2/aQ==
X-Google-Smtp-Source: AGHT+IFDHZ9RGUQoczr7OyvmRUqS5vJd/3X/ROqSBB7vuRL/rfdIURQecldPr1bzedPCROt8nfEKyw==
X-Received: by 2002:a17:907:97c5:b0:ab6:b8dc:824f with SMTP id a640c23a62f3a-ab6cfdd6db3mr1972048866b.37.1738451913377;
        Sat, 01 Feb 2025 15:18:33 -0800 (PST)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com. [209.85.208.52])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab6e49ff719sm493168966b.114.2025.02.01.15.18.32
        for <linux-trace-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Feb 2025 15:18:32 -0800 (PST)
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5dc82e38c10so3881054a12.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 01 Feb 2025 15:18:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUdZK6O57LdjXLv3CGj+YSmGiJz0wiXxRJfP28euRY/Q2WdAwIqx2vzz/5XE8iXivEt3U2P3HSeP4dQBNwiOZQWRLg=@vger.kernel.org
X-Received: by 2002:a05:6402:3511:b0:5d3:d7b0:b834 with SMTP id
 4fb4d7f45d1cf-5dc5efbdc80mr17093042a12.1.1738451912012; Sat, 01 Feb 2025
 15:18:32 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250131225837.972218232@goodmis.org> <20250131225942.365475324@goodmis.org>
 <e83ce086-b55f-431a-a499-f83a434b70db@efficios.com> <20250201180810.1faf4906@batman.local.home>
In-Reply-To: <20250201180810.1faf4906@batman.local.home>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sat, 1 Feb 2025 15:18:15 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
X-Gm-Features: AWEUYZmCClD8GCIsriJ_eXSqgwv6IsNbs7qWhVjH3BZVbVBbtFnqEYYSxzE1ZZ4
Message-ID: <CAHk-=wgTWVF6+dKPff-mhVwngFwBu_G9+fwOTF2Ds+YPj3xkeQ@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/2] sched: Extended scheduler time slice
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, 
	Peter Zijlstra <peterz@infradead.org>, Ankur Arora <ankur.a.arora@oracle.com>, linux-mm@kvack.org, 
	x86@kernel.org, akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, willy@infradead.org, mgorman@suse.de, 
	jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com, 
	boris.ostrovsky@oracle.com, konrad.wilk@oracle.com, jgross@suse.com, 
	andrew.cooper3@citrix.com, Joel Fernandes <joel@joelfernandes.org>, 
	Vineeth Pillai <vineethrp@google.com>, Suleiman Souhlal <suleiman@google.com>, 
	Ingo Molnar <mingo@kernel.org>, Clark Williams <clark.williams@gmail.com>, bigeasy@linutronix.de, 
	daniel.wagner@suse.com, joseph.salisbury@oracle.com, broonie@gmail.com
Content-Type: text/plain; charset="UTF-8"

On Sat, 1 Feb 2025 at 15:08, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> No it doesn't need to be yield. That just seemed like the obvious
> system call to use. But any system call would force a schedule. We
> could just optimize yield() though.

No, "optimizing" yield is not on the table.

Why? Because it has *semantics* that people depend on because it has
historical meaning. Things like "move the process to the end of the
scheduling queue of that priority".

That may sound like a good thing, but it's ABSOLUTELY NOT what you
should actually do unless you know *exactly* what the system behavior
is.

For example, maybe the reason the kernel set NEED_RESCHED_LAZY is that
a higher-priority process is ready to run. You haven't used up your
time slice yet, but something more important needs the CPU.

If you call "sched_yield()", sure, you'll run that higher priority
thing. So far so good.

But you *also* are literally telling the scheduler to put you at the
back of the queue, despite the fact that maybe you are still in line
to be run for *your* priority level. So now your performance will
absolutely suck, because you just told the scheduler that you are not
important, and other processes in your priority level should get
priority.

So no. "yield()" does not mean "just reschedule". It rally means
"yield my position in the scheduling queue".

You are literally better off using absolutely *ANY* other system call.

The fact that you are confused about this kind of very basic issue
does imply that this patch should absolutely be handled by somebody
who knows the scheduler better.

               Linus
