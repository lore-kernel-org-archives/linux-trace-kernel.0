Received: from mail-vs1-f50.google.com (mail-vs1-f50.google.com [209.85.217.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0A71586CB
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Feb 2024 17:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708624790; cv=none; b=OrH6h7MWeyTh2w8+uF02azpOux7CenFjmqrfCYdnaFA5IfXF6cZ1P9h02kdGD+VGwwdW0Edhwabwxi2RvdOh+8euyzBog09uwaMwlh+mLFBW5yQjrW7dD6g/z+OMTCTBEhaBpwuVpD0WGVu0uAw9g704vUGk0tQlNn1hRDJdLxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708624790; c=relaxed/simple;
	bh=fvwsKYe0sii5hYFlzMGzO5Ryz+nnM+pKugmbYqz/abQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EDiuvUSPeRfpHTKf4boZd24R5v1UkVaxxzV+XyBgX2GZaK+gyptxnPekf62BHo/uhEfJnk/KMy80w6N1y2RiGea+LeO58qrUg4YhPtxTBmtZ4XyoaT0AO3RBL1rUGNtz6Q5fgaB9G6v67Cxzso6A5By8KXHoHeOpt4EJ92KKyiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=KtqvEuLS; arc=none smtp.client-ip=209.85.217.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KtqvEuLS"
Received: by mail-vs1-f50.google.com with SMTP id ada2fe7eead31-470455b5352so983315137.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:59:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708624788; x=1709229588; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lAfh0deUlctQewLM9rYvzLmpV0jruOlVqgBOdUhaXcI=;
        b=KtqvEuLS+5Ie6g8HMyfv9ed1jJ2/tAIsuOpR/xsv5o2LIrQLEeCNLIZr9uXntaniX1
         HfnrBAYU0qbtCLjMV/M3c/XLwQiYXEsxgCbpXsqbS3F/UhJgoeNmPtguinTWC6IgJbPU
         +zEfwyk+ttsMuyUFk5TYaB99eGQ2tahZ8ZMhW3zB0YB7gp709vF1mGitR5jLpCmAx2UH
         tH0LpZ0xpW1JlFDsc78HcN+jjBjy+D/zwz8BLj+KgB0NsDxVjVsDBqPwVCRiVsi21MlI
         dJW7icCfhwyBIPzkQBJbZaSvPCQdkvjWRk/e74fi6yBbYe1tQ3GLNWCQEP2TCVtyZl8l
         cMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708624788; x=1709229588;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lAfh0deUlctQewLM9rYvzLmpV0jruOlVqgBOdUhaXcI=;
        b=ftL4IpLTxvmGz+T+jhjnmq+KrkA59XAG53kQOe8zJJ4jM52w3gEWVDPZ2OJDJZgret
         WycggePCsCGw8lo8bSfCMnjKiOyhWMNj6uhG63F/fgJOKLLSPYT5yXOmBqZqrsmzRJSp
         HRjP4idMBhzWr8e2wZaRYnLSWlnqHPfq1WLx73BZcLAX7TTY0/J5B/x/P01BDgOqvQhl
         Hvx7Rwy4b99kqSXSQNCOoKkP53HEM2xfIBOr0kzd5YNyZtepyopxmO4AbZdIcM6TFuq0
         xPsMe6cUweWjFPo8b0teTimPThKLtTWv/qH9TcT9xv18jqbvSr9bujM/ljMCi70EdhKv
         DBLQ==
X-Forwarded-Encrypted: i=1; AJvYcCVY47JZ0hDReSqBBjR4QwfL1djpRUd6JaFRz89r/w2KLMzeQ7zGklw1hJ6ZDAdGTWbLzARxFZyL5M8fe9BoobjMMTeo9f0fR9+T7cKYywYS1MYv
X-Gm-Message-State: AOJu0Yzio+7c8bcgvxg6efIiynNi4QGvNLjbqe8sg6TQLAxHXWoVg2rC
	q94Z6gjNG5hyjnBhMAJ2kSKWvkCqR7RQqQJq7K/7O6k2iHsbPqgH4CFE/0qSw0BCnLYxg7QJ/wA
	7hyLila4Z6geFBwhlvzgmp/N/lH+gyf8uw7QsMkxC0sF05m4pf2TL
X-Google-Smtp-Source: AGHT+IFAcQHAiZ1fQ8mfYjH9A8yIg25e7KdgVRcZ1st9GcOueJ6vRhI4a0/vUzUq8j3sQqvTbwrNpNPCpjk0U2FyxTo=
X-Received: by 2002:a67:fbd3:0:b0:470:5fdd:d5c with SMTP id
 o19-20020a67fbd3000000b004705fdd0d5cmr12228729vsr.31.1708624787593; Thu, 22
 Feb 2024 09:59:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111210539.636607-1-carlosgalo@google.com>
 <ZdWshXSoLthv6J6b@tiehlicka> <CABtOLR+gpU2BYxcGCCqccZGcRDF337z3JJ=7nvC47ANHmS1tNA@mail.gmail.com>
 <ZddXLGdJ0QDZTvJS@tiehlicka>
In-Reply-To: <ZddXLGdJ0QDZTvJS@tiehlicka>
From: Carlos Galo <carlosgalo@google.com>
Date: Thu, 22 Feb 2024 09:59:34 -0800
Message-ID: <CABtOLR+G6jyfV_7YUabJnmt=oN12fzPHB7viq9fTJb44wtefiw@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Update mark_victim tracepoints fields
To: Michal Hocko <mhocko@suse.com>
Cc: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com, 
	android-mm@google.com, kernel-team@android.com, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 22, 2024 at 6:16=E2=80=AFAM Michal Hocko <mhocko@suse.com> wrot=
e:
>
> On Wed 21-02-24 13:30:51, Carlos Galo wrote:
> > On Tue, Feb 20, 2024 at 11:55=E2=80=AFPM Michal Hocko <mhocko@suse.com>=
 wrote:
> > >
> > > Hi,
> > > sorry I have missed this before.
> > >
> > > On Thu 11-01-24 21:05:30, Carlos Galo wrote:
> > > > The current implementation of the mark_victim tracepoint provides o=
nly
> > > > the process ID (pid) of the victim process. This limitation poses
> > > > challenges for userspace tools that need additional information
> > > > about the OOM victim. The association between pid and the additiona=
l
> > > > data may be lost after the kill, making it difficult for userspace =
to
> > > > correlate the OOM event with the specific process.
> > >
> > > You are correct that post OOM all per-process information is lost. On
> > > the other hand we do dump all this information to the kernel log. Cou=
ld
> > > you explain why that is not suitable for your purpose?
> >
> > Userspace tools often need real-time visibility into OOM situations
> > for userspace intervention. Our use case involves utilizing BPF
> > programs, along with BPF ring buffers, to provide OOM notification to
> > userspace. Parsing kernel logs would be significant overhead as
> > opposed to the event based BPF approach.
>
> Please put that into the changelog.

Will do.

> > > > In order to mitigate this limitation, add the following fields:
> > > >
> > > > - UID
> > > >    In Android each installed application has a unique UID. Includin=
g
> > > >    the `uid` assists in correlating OOM events with specific apps.
> > > >
> > > > - Process Name (comm)
> > > >    Enables identification of the affected process.
> > > >
> > > > - OOM Score
> > > >    Allows userspace to get additional insights of the relative kill
> > > >    priority of the OOM victim.
> > >
> > > What is the oom score useful for?
> > >
> > The OOM score provides us a measure of the victim's importance. On the
> > android side, it allows us to identify if top or foreground apps are
> > killed, which have user perceptible impact.
>
> But the value on its own (wihtout knowing scores of other tasks) doesn't
> really tell you anything, does it?

Android uses the OOM adj_score ranges  to categorize app state
(foreground, background, ...). I'll resend a v3 with the commit text
updated to include details about this.

> > > Is there any reason to provide a different information from the one
> > > reported to the kernel log?
> > > __oom_kill_process:
> > > pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, fi=
le-rss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
> > >                 message, task_pid_nr(victim), victim->comm, K(mm->tot=
al_vm),
> > >                 K(get_mm_counter(mm, MM_ANONPAGES)),
> > >                 K(get_mm_counter(mm, MM_FILEPAGES)),
> > >                 K(get_mm_counter(mm, MM_SHMEMPAGES)),
> > >                 from_kuid(&init_user_ns, task_uid(victim)),
> > >                 mm_pgtables_bytes(mm) >> 10, victim->signal->oom_scor=
e_adj);
> > >
> >
> > We added these fields we need (UID, process name, and OOM score), but
> > we're open to adding the others if you prefer that for consistency
> > with the kernel log.
>
> yes, I think the consistency would be better here. For one it reports
> numbers which can tell quite a lot about the killed victim. It is a
> superset of what you already asking for. With a notable exception of the
> oom_score which is really dubious without a wider context.

Sounds good, I'll resend a v3 that includes these fields as well.

Thanks,
Carlos

> --
> Michal Hocko
> SUSE Labs
