Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CDF2E7165
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Mar 2026 02:00:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773626428; cv=pass; b=F9T5ASpk1vO4DbQ8kLF7NMUx4z4QR7+WusHw/0y7d0+Fo92pzlds70q0kxUD57gkZreEHp43XgZSp3bJ4xi5eBHrOnNwpASQHWzXai+vlsFfj7jxBkQNfFu/19AyTkqL/qHXkleCCx8hFgWT+04/3/SXknkmA/j6O1SBbqYWnE8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773626428; c=relaxed/simple;
	bh=pNpF/NWhnamL4nSDmUYfNu3BmUMCj47CvcpclhRylTM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s3tkQsEvVr/3Yn4m3J/iEm8fWeplQMX5rF812u6BjC+8CaBjFWx2hGZBHzvOM725oOzqqJscIDotZOtKoxTXSmLuEGl1REwULitQOYUoHmXhf01BJpuVEZBg+YrgqSbUJRDv9sOY3LgKYSLF0tUCl7dCho3hbRc+0jtvZVj+3hM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gt1trbfZ; arc=pass smtp.client-ip=209.85.160.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gt1trbfZ"
Received: by mail-qt1-f176.google.com with SMTP id d75a77b69052e-50915e14cf6so32280431cf.3
        for <linux-trace-kernel@vger.kernel.org>; Sun, 15 Mar 2026 19:00:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773626426; cv=none;
        d=google.com; s=arc-20240605;
        b=BkvcJbEgni0d0jwj8dWzoBcZmMJRLqc/PZrlo0zrPS6uH+789waivfcBMSp7zPXyUj
         +plVv86Un2M6Ypk+9gRfMsaeWp/iH3TscRNlxZhRWQQUWYrHceBV5ouPgadx9Qm2OuTS
         LyaLPHqxxgvKrrEJk0zUL2T5Ya+NvG1JlKzWYquEMoM5f2bEuMqQJS77ahyF6QBQnDDc
         fv3pxLwvCSrxwCkvjCZH1Je4uqHD5KpyWEp8pqD9KO3Xj0tiI8/awYFN0xh9IqGRoubh
         mKuiBsnt9KcCQ/F6jPpMN2aDhToiyBjjKq1cRfOQmLTINuoEctrlk5kXYs78KwGt0V/t
         hYIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6nROnbva2mIoIjRpoWyeMLuW48XcoRdlHO+Qz8e1hbc=;
        fh=IscZ+RmAdkICNBorjdA1eNfc7nUTK9WLi+0PVFnkV9E=;
        b=QrCn9V10qXf5M/FEh3bvIHTEKUkRYPJwHMcbWYaVxpfbHBftNvFdyog6qi0vWEMFky
         xyrvCidsTlkl9MqUHDepOXfDsfWVfDoQ6RkWg0frVal9W6rqbQ6jx4yLEWMN3jgz5C8B
         BR2e6/4RhNP3PV1WvfxdBWhf2PnHpI0OBSPRSUqE+aHMZJhGW/mIce8ufcbL1X9fxcRh
         BrOTa1qMRxHcNekTsEZ4HlS7T7v59wNRDs4mVBG8ggHTf+jqc6LXChjZbdDeJkfFXN9u
         5Z1FGo6Aw4pApISR4BGCyn0GPhz2kMrSPhI1ZK0AwXocYsuNxuOPfE25wcYdsC501/0U
         HAWg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773626426; x=1774231226; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6nROnbva2mIoIjRpoWyeMLuW48XcoRdlHO+Qz8e1hbc=;
        b=gt1trbfZi9WFdGInFXIp41jUgiPwR7M4yplhHu4ZBsslXEelGYWcLD9KNCShyjvB1h
         lK57/tFS9NsTlwdGLz9krtuHhMBYVxg3BAbVLFkAs6IJkZReyLxH/XA+qMudPa/AG08J
         fY5Htw/xhOyjE/56ww+l7Lq+9Wp8N3Qwzh46dmvUJ/Eysb76fFTxePGf/Jtjff1a+IiV
         5AnDHecDafujHxuQjcc7WadEkrWmrMZmevApbvoq0r3Lr9TgZPW15p+8J3hP2l4lRQFg
         4ii08D2/nf56gfQ2vd3KDI4LkKi+grtDkFL9LxqhzWTyl9qi4/E9HEz5+C31mvjYKqSl
         VZ7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773626426; x=1774231226;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6nROnbva2mIoIjRpoWyeMLuW48XcoRdlHO+Qz8e1hbc=;
        b=EjTbeqaVn30GC4Kbro+pqa6sV5t1q9X0GgrQM4Zk+RWKDPIxt0a+m49JNaNGa4q5FQ
         dVe0mVS5SKMQJaRp7FbyRtAj+GL6DHvvte3fAAQt9JjKP80D1iyK31HTeB0AQjEbtI5n
         Cwfw0RyvhXo7RG6EZULsJOgRqAEpBZzxomeEaRoVd4AbG8EoI7agwa4JXqmuBtfd/pfB
         N/HqUoPnCYyOqp2SrLv9gJuNzSAu2oUPslkyWHXuOBjIQ6ym3sZl8Ydr1An963DxZTcw
         6/GzYl9maNO9iTj6zIF6Uv3rhit8tVK+zI7k7RKbJD9n42Nz2LchxN5Vm06UUeBvEKXa
         lV+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUR0XVlQkjtHgH6/sonbRWJus+l//g9PiDzmX7FZqnAGTrbKgjAw8YxDNFaHR8NsSlP9j35CPR3fQKzGhJwJMR/MAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkT/HZxHuHhy8VJaGynu8287b7KxrdLGHyUclY7ockYIo3101e
	wzSrMF9No92L+ZNl18Qwj4RascZn4FB+eYm6hOTmZiKhjwZNLsN249WBvocBgA5HiRRmFZbftvO
	zcnarrJw9qEcrvkz+eEzP00/NIKjletY=
X-Gm-Gg: ATEYQzzVm38gAQ+ppclXp85SLnZNOgotgt6ox6Nddvyk6mzlnSS4vKQZuFvnxsEdeIq
	XwpIPD0zgZFmfuEisiNwNaQJW7XViW2NVEjMBQETY+UJtiCbMXhGWT65NnmxQ2HomsBMtLAlX7f
	AIl5cBJBRJeRhNWdAkvUZVwumC2SM7LKiUlTBxhkriFKSMmKC2GBeNCagy5QWUGAwsLSMPIA/wn
	Uww/O/r3zJpFXklaCW5PaYpnwfDXoJTZBZs/pj6vuj7JXfcnWEHXjz0nvi+lE0KHK/BfeUoxrj/
	fmV4gX6S
X-Received: by 2002:a05:622a:510:b0:509:3c33:9d0d with SMTP id
 d75a77b69052e-50957b90582mr154459681cf.9.1773626425642; Sun, 15 Mar 2026
 19:00:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260306075954.4533-1-xuewen.yan@unisoc.com> <20260306100625.2211675a@gandalf.local.home>
In-Reply-To: <20260306100625.2211675a@gandalf.local.home>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Mon, 16 Mar 2026 10:00:13 +0800
X-Gm-Features: AaiRm51Yqp0v6RvqoIPE_D-FJqiix84GzkJh1OdatJh6dS3PC2XrNo0iITZueIo
Message-ID: <CAB8ipk8M=Uij65LZCbSAjJPPPsXWYY4kGBQwMm1WqJHHEb33eQ@mail.gmail.com>
Subject: Re: [PATCH V2] tracing: Revert "tracing: Remove pid in task_rename
 tracing output"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, elver@google.com, kees@kernel.org, 
	lorenzo.stoakes@oracle.com, brauner@kernel.org, 
	schuster.simon@siemens-energy.com, david@kernel.org, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	guohua.yan@unisoc.com, ke.wang@unisoc.com, jing.xia@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steven,

Unless there are any further comments, could you please help to take
this through the tracing tree?

Thanks!

On Fri, Mar 6, 2026 at 11:06=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org=
> wrote:
>
> On Fri, 6 Mar 2026 15:59:54 +0800
> Xuewen Yan <xuewen.yan@unisoc.com> wrote:
>
> > This reverts commit e3f6a42272e028c46695acc83fc7d7c42f2750ad.
> >
> > The commit says that the tracepoint only deals with the current task,
> > however the following case is not current task:
> >
> > comm_write() {
> >     p =3D get_proc_task(inode);
> >     if (!p)
> >         return -ESRCH;
> >
> >     if (same_thread_group(current, p))
> >         set_task_comm(p, buffer);
> > }
> > where set_task_comm() calls __set_task_comm() which records
> > the update of p and not current.
> >
> > So revert the patch to show pid.
> >
> > Fixes: e3f6a42272e0 ("tracing: Remove pid in task_rename tracing output=
")
> > Reported-by: Guohua Yan <guohua.yan@unisoc.com>
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
>
> -- Steve
>
> > ---
> > v2:
> > - update commit message (Steven)
> > ---
> >  include/trace/events/task.h | 7 +++++--
> >  1 file changed, 5 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/trace/events/task.h b/include/trace/events/task.h
> > index 4f0759634306..b9a129eb54d9 100644
> > --- a/include/trace/events/task.h
> > +++ b/include/trace/events/task.h
> > @@ -38,19 +38,22 @@ TRACE_EVENT(task_rename,
> >       TP_ARGS(task, comm),
> >
> >       TP_STRUCT__entry(
> > +             __field(        pid_t,  pid)
> >               __array(        char, oldcomm,  TASK_COMM_LEN)
> >               __array(        char, newcomm,  TASK_COMM_LEN)
> >               __field(        short,  oom_score_adj)
> >       ),
> >
> >       TP_fast_assign(
> > +             __entry->pid =3D task->pid;
> >               memcpy(entry->oldcomm, task->comm, TASK_COMM_LEN);
> >               strscpy(entry->newcomm, comm, TASK_COMM_LEN);
> >               __entry->oom_score_adj =3D task->signal->oom_score_adj;
> >       ),
> >
> > -     TP_printk("oldcomm=3D%s newcomm=3D%s oom_score_adj=3D%hd",
> > -               __entry->oldcomm, __entry->newcomm, __entry->oom_score_=
adj)
> > +     TP_printk("pid=3D%d oldcomm=3D%s newcomm=3D%s oom_score_adj=3D%hd=
",
> > +             __entry->pid, __entry->oldcomm,
> > +             __entry->newcomm, __entry->oom_score_adj)
> >  );
> >
> >  /**
>
