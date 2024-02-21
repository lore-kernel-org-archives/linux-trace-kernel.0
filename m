Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 803443BB4C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708551067; cv=none; b=iYHhOUp+1WdJMxMYfRbTG8+CAuxUfD28CJvg9f1JDep3x9TZZh2+W+A0H0op1zuVeWXSWislN+CcKOAEhjZFTorfdNLyOuzKI8NmzUNA1S0A+ryRSfoWDcOJRwRYoAMbzQG7z7dcCXEgWYz/TLJ+wN7yjV1uY8OroCy87jYBbQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708551067; c=relaxed/simple;
	bh=vkGTScK5M6Sthovdj0M+72XV5UMq/lWO1wwEeMwIR1o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CvLaaBbmTZhLRl0nj2UY68kQNsTapqNHbztLjCJJGIX+wXdk+DOyyJtQFN19HtVPJHLkFndJCRC/rYMCzQqsVDmOD4bIBfS0HDWPqiaVatPIAavbTuVuI1Bx1CIOW1v8qSAubUeF5Mtry9mj5AUa6CLXxWnAcpulvKoumwekgn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Okuurdc1; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Okuurdc1"
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so5263223b6e.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:31:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708551064; x=1709155864; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gyDvZIu7lyAMZr8iHtIW9gaK0zzbqkQ/ZarxVd+kbsw=;
        b=Okuurdc17ebSBJG7qhyTr9oJhy3C7On7Xn1CRRLP73dXm9Zd0IoaeRPZn2T/m4A/1p
         fO9vrZn8w9av70NWsDAuxnn8+HTGjTgpRIYYzJDrM85LDjhZp4L1ovNig38AntgOeL+G
         Ddfj7XnTRf3qU7qcKuliJqUR4HBwWk+zm+cEHDoR1M3wdM/qwiN86MZ/EyMMPrHOrEHi
         lVuQba0mQRqnpNllwCbTvbgdbL7h5trOZq8qh7A7XdGBAeL0gqrpRarm+BunqoaJ3MgE
         gSRULSoqJGwFwdW7nQFa/kAHrb0tA4OFkNCVIHflzk7pgtZvsmcpd4gn/a9q35wu6De4
         /ajw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708551064; x=1709155864;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gyDvZIu7lyAMZr8iHtIW9gaK0zzbqkQ/ZarxVd+kbsw=;
        b=sG7dhNN6KD6nTcBQf0mCAhBXR2vPZdah9DC4rRUyaakxdlHgL0p8/Xmvddw3QJOt6c
         RS4pzGTVoz6bfL8uKkCNZheM8hx6dpI4ruCOX9PtkiyqpZrlwISfl9702Vp+6essko9T
         sKavjsKCrcJYIn2i+U7fqKGCMrr5H1EHWl/2RQaDgyBG1SiY9ky/wlLP9efpf3M36U6B
         tl8f7VxvkAl+OySW/f9osIqNm4GyEVefwOtKiIwc/LXgEHH6fIwKYJPxjP93LNvqsU0T
         KBxY6yKEX3LL0YdaEvwkyFDO8FxzV/dGZa5EdjaU33jDmDQTnOdi/w1I3+5Vj6X+9Tgp
         tS+A==
X-Forwarded-Encrypted: i=1; AJvYcCWLuy5dFY7x99mCENWDzPjtgiR0zLUymI6g+WJiDSIQDOP6miI6vJHcAV/XJBmOGUc9TYoURTD6pFNGHrZZcarqqvXprhJoAiqySTCfnBEDaHzl
X-Gm-Message-State: AOJu0YywaBX56IG66abcjQPM4cxp3g0WocxNF9SKHlklq0Gx+0MBE5Sd
	/CKaBCmDdntUTwK7VyzJoNjQuFPf9q5pgkVkmDzLHi1ZvtGyFcYomKhqmyftMXrEpgxLUu4h8X0
	Fu+gRiUmMz9RKltcjQttdSbEvsaDOB3TasnVu
X-Google-Smtp-Source: AGHT+IG7j3+ZxAmTcECSokeLQXuBK0cuQtwLdGeOlZvOqznQYFNFe5YbgpRUaAFW0uN3IZ6N5EAeSRZ29mohF0it6i4=
X-Received: by 2002:a05:6808:120e:b0:3c1:67d3:694 with SMTP id
 a14-20020a056808120e00b003c167d30694mr6194946oil.30.1708551064423; Wed, 21
 Feb 2024 13:31:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240111210539.636607-1-carlosgalo@google.com> <ZdWshXSoLthv6J6b@tiehlicka>
In-Reply-To: <ZdWshXSoLthv6J6b@tiehlicka>
From: Carlos Galo <carlosgalo@google.com>
Date: Wed, 21 Feb 2024 13:30:51 -0800
Message-ID: <CABtOLR+gpU2BYxcGCCqccZGcRDF337z3JJ=7nvC47ANHmS1tNA@mail.gmail.com>
Subject: Re: [PATCH v2] mm: Update mark_victim tracepoints fields
To: Michal Hocko <mhocko@suse.com>
Cc: rostedt@goodmis.org, akpm@linux-foundation.org, surenb@google.com, 
	android-mm@google.com, kernel-team@android.com, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 11:55=E2=80=AFPM Michal Hocko <mhocko@suse.com> wro=
te:
>
> Hi,
> sorry I have missed this before.
>
> On Thu 11-01-24 21:05:30, Carlos Galo wrote:
> > The current implementation of the mark_victim tracepoint provides only
> > the process ID (pid) of the victim process. This limitation poses
> > challenges for userspace tools that need additional information
> > about the OOM victim. The association between pid and the additional
> > data may be lost after the kill, making it difficult for userspace to
> > correlate the OOM event with the specific process.
>
> You are correct that post OOM all per-process information is lost. On
> the other hand we do dump all this information to the kernel log. Could
> you explain why that is not suitable for your purpose?

Userspace tools often need real-time visibility into OOM situations
for userspace intervention. Our use case involves utilizing BPF
programs, along with BPF ring buffers, to provide OOM notification to
userspace. Parsing kernel logs would be significant overhead as
opposed to the event based BPF approach.

> > In order to mitigate this limitation, add the following fields:
> >
> > - UID
> >    In Android each installed application has a unique UID. Including
> >    the `uid` assists in correlating OOM events with specific apps.
> >
> > - Process Name (comm)
> >    Enables identification of the affected process.
> >
> > - OOM Score
> >    Allows userspace to get additional insights of the relative kill
> >    priority of the OOM victim.
>
> What is the oom score useful for?
>
The OOM score provides us a measure of the victim's importance. On the
android side, it allows us to identify if top or foreground apps are
killed, which have user perceptible impact.

> Is there any reason to provide a different information from the one
> reported to the kernel log?
> __oom_kill_process:
> pr_err("%s: Killed process %d (%s) total-vm:%lukB, anon-rss:%lukB, file-r=
ss:%lukB, shmem-rss:%lukB, UID:%u pgtables:%lukB oom_score_adj:%hd\n",
>                 message, task_pid_nr(victim), victim->comm, K(mm->total_v=
m),
>                 K(get_mm_counter(mm, MM_ANONPAGES)),
>                 K(get_mm_counter(mm, MM_FILEPAGES)),
>                 K(get_mm_counter(mm, MM_SHMEMPAGES)),
>                 from_kuid(&init_user_ns, task_uid(victim)),
>                 mm_pgtables_bytes(mm) >> 10, victim->signal->oom_score_ad=
j);
>

We added these fields we need (UID, process name, and OOM score), but
we're open to adding the others if you prefer that for consistency
with the kernel log.

Thanks,
Carlos

> --
> Michal Hocko
> SUSE Labs
