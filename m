Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85093334C19
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 11:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763032418; cv=none; b=YPv5BWEyIhH0LPYxW+lpHSmD56h44et7Hl3ztpYTYuyPRHOhRx+3lzk7tWFlgb8Q4rqR5pN6ol0QgjmfdQmxwwN5jhhgJj6XfbWGoCgDHSgYee0Y1c91EPfnHrv0NhYi8vaot62nYb4qTs1RBnvPG0j1GJyiQqxbWIjiTkIvyJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763032418; c=relaxed/simple;
	bh=2nfkUFEyeTPvY9nyDt6tV6x7gYKP6WCBqWyd9cTqSH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nxc4+jFPPXiNHy1Awcvc4iWe96JuDINt+JREHng1zrszlvdC+xE/dj8vwIvYFAk8fAXUHqILQ9uTgczCVt77twawFp5fSawNEMTTly95iTh6myr1iwO+Ai82INFPVwsZdQC85C0Q1+RhSLJilgCGMRGnk0eE+s5SDu5xBHtP8KI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=it6B1BcO; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="it6B1BcO"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b734fcbf1e3so110341066b.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Nov 2025 03:13:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763032415; x=1763637215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kIw7Xm3oDNehlEieN5CtSC8W4YrmGX9W6qbpU2/TpUo=;
        b=it6B1BcOlwT+csQp4mzT4lztS3UMlTvZYho1Z+xzXsWMa035KmBnBYc+/tUbNNFpTo
         EhsXZKz8heee4+ikTnHYva8qqNU8EgUQUTgi1BBKEQgDRBiT5rR36VpzLBFvGYprMrbf
         G7ELN1PelbmNO5X3AB+KIxq1AulOdq7JI7xi7PY8opm7LClJzDaZ1A59+d2h7Rez9q0B
         uoe44DI1fPv6lvDWkW3o64pTGBoTeDWSGUWZnMqhILC83IuzrPrNRHOyYW5Q9Y0yKFLo
         b5umvjSx6AUQ8Yiwag7bYZNl61MJUq0Zcw56EayKndNZkmmG59xtX/B9SXycAL/llBoW
         Q1Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763032415; x=1763637215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=kIw7Xm3oDNehlEieN5CtSC8W4YrmGX9W6qbpU2/TpUo=;
        b=eoA2MRBgRrRhHE/N3fu27/JMIdKhgdoC0H+fjE9AK+3Pq3coQpcVq7Rimbu9FS+7Mm
         0LBnHT+YVu+S49/yXMtEWFwGRTbdwDrpkr19gCUKyEHOmQaJXl1rdiTDR/fq2gdl95wP
         uuG9loQa17iTimc0KYn809f2LxYGsPxgFb2qmHIqhvLTh23JWa9rKaLck+Vnb2qkFp8P
         PzKMbDOVWP7Gl+qEznflojFoR5wl0Ybyh+YRLg+bcdzPw1D94qBfUSc53ue5CoPXFXkn
         Uks7zlMQOJZonOFSNj+837ThzAJPiyfxXoMafJGOP+8CroZGK0ThUz14CLC7IZLcVsW8
         Tz+w==
X-Forwarded-Encrypted: i=1; AJvYcCX6hxotfGhadalxFSQBXfADB05assakKjsw8EhgyJmsSKw/q54zbLkJR//HS8b7YOfh2Ys5wUMCKeNQr0wfytrUpd0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw01eAc49WNjtSy5UbNoc1XJpJdOz1OQUlQHRTXSKA8wI+J7UuY
	fvzLZ3NpWeDWrX8kKiwO6L/gTER/f1j7kJIDow6KvSvZD35uWx/4EMR2SFAXGwZOvUv8QcT0LMN
	f7o04lqhjyXg1MQELSVv0aMyZuAdGrEA=
X-Gm-Gg: ASbGnctOENfE6MTaV8pcdF3T9iSskqF/NCGEY7WBa/buyMqsLQASmuaTUByWaK8/wU9
	ugMXDXlViXfMHDuhQrPaNZvrx4CZndUlcqT+EevEjgk7Nqymbx/AiQQlimCvrL8hDcQ2mfD6I4J
	FlEq/VmxMQ0r3dGWNMTxPByMRs4xxVq2k7u7Ibo0GIN3eWWMXeaIqJE9NC1m4NJMtFdy9MVMWAx
	wztjjF/AOclD9mxgGokEhppWd+VkRQVxI0CZgVKygsOe2MMaAjvyC7ZE7kM
X-Google-Smtp-Source: AGHT+IHvFGA7lSHeo8GRvWzOeGJiPitXnORSPqfM76SMDFCtJZ8hIWpC2PXuxziMqg/v11vbGAIbG+FbSNi74bIYsiY=
X-Received: by 2002:a17:907:7e8e:b0:b73:5d8c:dd0d with SMTP id
 a640c23a62f3a-b735d8ce04amr8301266b.52.1763032414634; Thu, 13 Nov 2025
 03:13:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251113000252.1058144-1-leonylgao@gmail.com> <20251113073420.yko6jYcI@linutronix.de>
In-Reply-To: <20251113073420.yko6jYcI@linutronix.de>
From: Yongliang Gao <leonylgao@gmail.com>
Date: Thu, 13 Nov 2025 19:13:23 +0800
X-Gm-Features: AWmQ_bmPe1Dsb6l-Cx025fplW4DeFTdGrd-P4g6FieNkHhLzgmlN9OMB1pIU8i0
Message-ID: <CAJxhyqCyB3-CyDKgPtP-EoC=G9cWAYgLvse003+i2n6U4Pgv1w@mail.gmail.com>
Subject: Re: [PATCH v3] trace/pid_list: optimize pid_list->lock contention
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: rostedt@goodmis.org, mhiramat@kernel.org, mathieu.desnoyers@efficios.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	frankjpliu@tencent.com, Yongliang Gao <leonylgao@tencent.com>, 
	Huang Cun <cunhuang@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Sebastian,

Thank you for your review and the thoughtful questions.

1. Performance Data
We encountered this issue in a production environment with 288 cores
where enabling set_ftrace_pid caused system CPU usage (sys%) to
increase from 10% to over 90%. In our 92-core VM test environment:

Before patch (spinlock):
- Without filtering: cs=3D2395401/s, sys%=3D7%
- With filtering: cs=3D1828261/s, sys%=3D40%

After patch (seqlock):
- Without filtering: cs=3D2397032/s, sys%=3D6%
- With filtering: cs=3D2398922/s, sys%=3D6%

The seqlock approach eliminates the pid_list->lock contention that was
previously causing sys% to increase from 7% to 40%.

2. Reader Retry Behavior
Yes, if the write side is continuously busy, the reader might spin and
retry. However, in practice:
- Writes are infrequent (only when setting ftrace_pid filter or during
task fork/exit with function-fork enabled)
- For readers, trace_pid_list_is_set() is called on every task switch,
which can occur at a very high frequency.

3. Result Accuracy
You're correct that the result might change immediately after the
read. For trace_ignore_this_task(), we don't require absolute
accuracy. Slight race conditions (where a task might be traced or not
in borderline cases) are acceptable.

Best regards,
Yongliang

On Thu, Nov 13, 2025 at 3:34=E2=80=AFPM Sebastian Andrzej Siewior
<bigeasy@linutronix.de> wrote:
>
> On 2025-11-13 08:02:52 [+0800], Yongliang Gao wrote:
> > --- a/kernel/trace/pid_list.c
> > +++ b/kernel/trace/pid_list.c
> > @@ -138,14 +139,16 @@ bool trace_pid_list_is_set(struct trace_pid_list =
*pid_list, unsigned int pid)
> >       if (pid_split(pid, &upper1, &upper2, &lower) < 0)
> >               return false;
> >
> > -     raw_spin_lock_irqsave(&pid_list->lock, flags);
> > -     upper_chunk =3D pid_list->upper[upper1];
> > -     if (upper_chunk) {
> > -             lower_chunk =3D upper_chunk->data[upper2];
> > -             if (lower_chunk)
> > -                     ret =3D test_bit(lower, lower_chunk->data);
> > -     }
> > -     raw_spin_unlock_irqrestore(&pid_list->lock, flags);
> > +     do {
> > +             seq =3D read_seqcount_begin(&pid_list->seqcount);
> > +             ret =3D false;
> > +             upper_chunk =3D pid_list->upper[upper1];
> > +             if (upper_chunk) {
> > +                     lower_chunk =3D upper_chunk->data[upper2];
> > +                     if (lower_chunk)
> > +                             ret =3D test_bit(lower, lower_chunk->data=
);
> > +             }
> > +     } while (read_seqcount_retry(&pid_list->seqcount, seq));
>
> How is this better? Any numbers?
> If the write side is busy and the lock is handed over from one CPU to
> another then it is possible that the reader spins here and does several
> loops, right?
> And in this case, how accurate would it be? I mean the result could
> change right after the sequence here is completed because the write side
> got active again. How bad would it be if there would be no locking and
> RCU ensures that the chunks (and data) don't disappear while looking at
> it?
>
> >       return ret;
> >  }
>
> Sebastian
