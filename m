Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2270F9CF
	for <linux-trace-kernel@vger.kernel.org>; Tue,  9 Apr 2024 14:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712673989; cv=none; b=iKT1pY58ddYi/39y1i4AkjZuUIrRnM1+ZFjLZaWJBMdXtNlL7jXNs0rWix/jBb+oUByawwxQXdM5gweymI00MIaT/WUbcHyyS03j+K9aou/yu43mXn0spgfJ/d9+E1BuuOFsjs5i3QeS/C4nKkNnTGpiLwPMvtNRFOvUn41kGqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712673989; c=relaxed/simple;
	bh=JNYWxfOdBLnkcSOg7S7k0lKm6pw5ifgueS2lI62IYsQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=V13AHHgNjHn1AC+YL0BTz34TrfWFvFfj1I9gpM/7REML2MQqfUOLrvMQyNIkFSufwzgtheQqE+pj+H2lXjqY+hg2TtZxM0uxMgcXt7dck8hk/dK7wCczmvZqdgEIdAEGelK85qiU00T4QJsNb8SqAuyp+0b/s3XXiC1+ZLoyOJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=28vxQEc2; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="28vxQEc2"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-4daa68eef71so1666491e0c.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 09 Apr 2024 07:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712673987; x=1713278787; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=JGKKqyMnDxDe7Z88TFPiX7ZbsHcnXFBE7VSZEtRsFEI=;
        b=28vxQEc2TfpbRqxpk93+D041AjxSexs6rYQNsHGjjZ8SP1AfWYlIvrDbgi+HSQV+NY
         hE/csZnXhzr0uDz8wJbGZuxVlzPU3tutz+RB6QDriquBTMIkj2eS5AQvPid7Z+GAudkS
         uUo5KnnmEnv3+VRdF6XIVXQ6mleVvgpSSx9XXITKH7VS40GSIIXRLIczF2XFhkvXOVr3
         WclMHKAwcC22dGNNFI4TPb1YDaWKAX40dLh8EXQF7bXTuV5fM10wRgaWo3PGRbMpJeqv
         OkxRCEEK7iChk5QM4qFrwH/ywqEsaBuDZo4045Y+le2SbaY/fkDoldJctWdf9RzuNwzK
         /Pag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712673987; x=1713278787;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JGKKqyMnDxDe7Z88TFPiX7ZbsHcnXFBE7VSZEtRsFEI=;
        b=ZH9Dprs2gTttjbHNdeCv20G6Yr62uVfekGQaqB2fNF7gdyvUwurmApNv+3aAkktfos
         ZAL05nNkU8X/lerEgkwvVZ7/6vbrxJZ/jnAaQjdNbRkAMgAoXdaA2OLFF7qipId3yf9p
         vYdLy+QcUjh6gxmFY18EElUKPNaMZ2q/1Zr2dLyDVIgfNergUfQnCALhQUE4wCc2rBbc
         QvFr6ZreS+37pCKA8zEWkibScY+LjlJ0CRddRYrd9yXQXqxW9esw5cjTlORSrdFg4rTV
         ccL09sQKaKuyBnLa3A2lHSO2AapW0V0xf6d/sU6haVBnKbWT6AK5C/Zi63wcYSWHejuL
         kEkQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5RmUuZHD8R6LVnW6o0bYXmRso/BC+nbmwOTtkb48eJdnF/Ox4Dbk5Ri9wuVdpWwA7mktT9ao9vWSauFmTlb7iiOT7T36S+Gd+dxi30DGmtFnd
X-Gm-Message-State: AOJu0YyfYSHI4LhxpDc9N904Zd/HVs6nxQW6juT3/8CRd929H0tdj49h
	CcPcBS2g5Qq4I20PPLdm84JBPophbX9suBY3TGxUR+dXgVE2kekaN70puNjJqpE8iia0d+YAdlC
	pCo2iGE1zkdha419jCs6DDvwKZ/cAx+EJ5JH8
X-Google-Smtp-Source: AGHT+IG5ZyVYbzpi7MrZFfeuZePmTlO9Cj6SrZUQgNIArSjr/qGXL8vsPlsLH60WkxdNp2m4CZry4zLpVpcPiYwzY5k=
X-Received: by 2002:a05:6122:48a:b0:4d8:74cb:e3c2 with SMTP id
 o10-20020a056122048a00b004d874cbe3c2mr33094vkn.9.1712673986727; Tue, 09 Apr
 2024 07:46:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240408090205.3714934-1-elver@google.com> <20240409103327.7a9012fa@gandalf.local.home>
In-Reply-To: <20240409103327.7a9012fa@gandalf.local.home>
From: Marco Elver <elver@google.com>
Date: Tue, 9 Apr 2024 16:45:47 +0200
Message-ID: <CANpmjNOv=8VBvbKBQbsBdg9y2pNsfdaA-46QB53NY-Ddmq3tmA@mail.gmail.com>
Subject: Re: [PATCH] tracing: Add new_exec tracepoint
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Eric Biederman <ebiederm@xmission.com>, Kees Cook <keescook@chromium.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"

On Tue, 9 Apr 2024 at 16:31, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Mon,  8 Apr 2024 11:01:54 +0200
> Marco Elver <elver@google.com> wrote:
>
> > Add "new_exec" tracepoint, which is run right after the point of no
> > return but before the current task assumes its new exec identity.
> >
> > Unlike the tracepoint "sched_process_exec", the "new_exec" tracepoint
> > runs before flushing the old exec, i.e. while the task still has the
> > original state (such as original MM), but when the new exec either
> > succeeds or crashes (but never returns to the original exec).
> >
> > Being able to trace this event can be helpful in a number of use cases:
> >
> >   * allowing tracing eBPF programs access to the original MM on exec,
> >     before current->mm is replaced;
> >   * counting exec in the original task (via perf event);
> >   * profiling flush time ("new_exec" to "sched_process_exec").
> >
> > Example of tracing output ("new_exec" and "sched_process_exec"):
>
> How common is this? And can't you just do the same with adding a kprobe?

Our main use case would be to use this in BPF programs to become
exec-aware, where using the sched_process_exec hook is too late. This
is particularly important where the BPF program must stop inspecting
the user space's VM when the task does exec to become a new process.

kprobe (or BPF's fentry) is brittle here, because begin_new_exec()'s
permission check can still return an error which returns to the
original task without crashing. Only at the point of no return are we
guaranteed that the exec either succeeds, or the task is terminated on
failure.

I don't know if "common" is the right question here, because it's a
chicken-egg problem: no tracepoint, we give up; we have the
tracepoint, it unlocks a range of new use cases (that require robust
solution to make BPF programs exec-aware, and a tracepoint is the only
option IMHO).

Thanks,
-- Marco
