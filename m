Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22072BE7AC;
	Fri, 15 Aug 2025 06:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755240906; cv=none; b=D1a+22nA7X9XcySZPIwgahT2dEqhmMW6eU9fXHb4bp/xCWPG3OXwgI9TJsK55jZfMe8obpAzKu2M/3pn2l+akwc9Q2w/v6Qxf2qQ0qmB8azVrNMXRFTvrh/i/2Vs04t+wbUuP7/KBmFU3osiMIxFuKnGKxLHq60dZbmI7AWniGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755240906; c=relaxed/simple;
	bh=09O8iHCFCc9FeSzQNIAgrWWzvUvhP9zVo7akTxtlO9I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OWXPXEsQQ5CBB4x0aBIkG07CDh+ql6+kMSoDAcjkUwLFdn22pYgxQPPAyPRHHZa0tK6XdYTGyPclpEUXBdQZ2jqNOZ8qNh6MR08uLi8ozlwJzb2i+rq5s3l1R+1RSdg4ORBHtmH8cqBfovSgxmxl0YwY8TTjClsRNp4YqluTXKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dblyjfjk; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dblyjfjk"
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-7e87061d120so175195885a.2;
        Thu, 14 Aug 2025 23:55:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755240904; x=1755845704; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2Lg6KLMGFx8dXvnhjBDp9/6fMroiB5ppBoQnq73tIYw=;
        b=dblyjfjk/KipKUN3ihQuc8X0z5iLUxXvked6Ai/GAXu8W0QcPvLaq0iD28Dbmcxikr
         3hPC2x4PRA745RZrXtAZ4jkI45WdssVj9wLFf+5CfvrYZdEJj/KUxOcFhTP+CndVmeOH
         pni+C2TnRrDL3OmstcdFjVpJqmTmtMocHfNwy42DSYsPf3rwM8a32Rxa+9RzpAsuhIMy
         Vae/9nAGz2fSFKTnRCojkEe92PRCu/qovCXXvhr4935VYx6qROx0MS4TrJgYWSah6wJa
         /vB4ZRGmd6dGYmH43Zmrn++5bH8l9F4IdOyUObFFeLeGKcY+HWsxv4bkd/0l0hJqkPHm
         mlyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755240904; x=1755845704;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2Lg6KLMGFx8dXvnhjBDp9/6fMroiB5ppBoQnq73tIYw=;
        b=SNBlfkI77JAnZG2mDz9OoFUh8Xm7lN6t1mtUIid2VOPkmQR1o7w+ltaq7piWISNcRB
         azmf5VCoj8tXA4EGhcg39x3/KoyORFLESE11yV8Bs0ZswVVrml8Jv4fT+I4gTUiNwhHy
         NgHw7WTe9AK5O++tYYx8wqQUE43qUwvC4KwlTPFSbHJLdRlbphkbDVHL83gah81a/035
         FUbti/kqp1jilSL/yzyDY+Y6Tvv4PA18IYdt0qVhZHc/sltMlBMFlep0Tgg0555fZJBT
         qPfUfTnnFmEZEtEkHT3UT81X1YiM0B2uF5PwB/kMGWT7AJ6WBnridi7asirYa+6JmO5t
         JKEw==
X-Forwarded-Encrypted: i=1; AJvYcCV5G9Td/ROPtnq+qVKbCO/UVGsPm2+qBwnBtyDd78OSbhQd9bSh5NBBXrHFsopx1jau36YLWidrxICVx4I=@vger.kernel.org, AJvYcCXxzHiliMSdJddnws3anThS1LRsc2r82ayx/Sn4vd2FD2TU4kaD9WruiIpL2eV4hsTEWED9JlK4vWW0z2fS2jgb9zxK@vger.kernel.org
X-Gm-Message-State: AOJu0YxX/4zp9qgBXJy2B/8LqTpvzmnmNTCn/XFoyLS0LtnAVhRaU1qb
	wYCWDDRyYAVFa8xiMYVOXtj3jxJaDG9BS7b0pFWNd2XyQpbIVp8Z6xlua2hXcyQwjgdQlpFcvxh
	opL00EnD3eI9WtohmHLKVi4ESvr4Ysj8=
X-Gm-Gg: ASbGncuwocd3aC8saFhkzxGLjcJViA1R73wY15AISVBKy9Yn7nM4mDwrtu94vMc8DDD
	WvSrQKfkIXzwiAaYEwjPt58AuvwGlNsAdLrAuDtpkGqrcfRNCSHZLjr+MwizlDO2uDrhyKhUSIH
	c7XjWFL/SP203x544Xb39F0dqG37HqftS8Eet1UC7YaqsxjxM/12gkD0kG+uucCE29c5gzjQqPf
	TIDKjNW
X-Google-Smtp-Source: AGHT+IGYI6ILTmAXzXLkiCqprBRzYPxqp9bdmDzEQwq5O/vzmfeQ5EnNuuwwuFaM4Xzr8819ou+efflkjKPGqc4TWp4=
X-Received: by 2002:a05:620a:4044:b0:7e8:3a80:f5f8 with SMTP id
 af79cd13be357-7e87e0961b4mr113536385a.45.1755240903675; Thu, 14 Aug 2025
 23:55:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250814070719.865-1-xuewen.yan@unisoc.com> <20250814135501.GD115258@cmpxchg.org>
In-Reply-To: <20250814135501.GD115258@cmpxchg.org>
From: Xuewen Yan <xuewen.yan94@gmail.com>
Date: Fri, 15 Aug 2025 14:54:52 +0800
X-Gm-Features: Ac12FXx4tnqtPh1o32IWFaMxt5bNWUPOpDIjUGINTHUGjQyxrCLoS5CIQ8nCWoQ
Message-ID: <CAB8ipk_wAg5UWDyjNV8MYQu6FRocw9sD7YM4rnBs_Ee6yupNWw@mail.gmail.com>
Subject: Re: [RFC PATCH] sched: psi: Add psi events trace point
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Xuewen Yan <xuewen.yan@unisoc.com>, rostedt@goodmis.org, surenb@google.com, 
	peterz@infradead.org, mingo@redhat.com, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, juri.lelli@redhat.com, 
	vincent.guittot@linaro.org, dietmar.eggemann@arm.com, bsegall@google.com, 
	andrii@kernel.org, vschneid@redhat.com, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, yuming.han@unisoc.com, ke.wang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

Thanks for the reply:)

On Thu, Aug 14, 2025 at 9:55=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org=
> wrote:
>
> On Thu, Aug 14, 2025 at 03:07:19PM +0800, Xuewen Yan wrote:
> > Add trace point to psi triggers. This is useful to
> > observe the psi events in the kernel space.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
>
> Can you elaborate on a situation in which you would use this?

In the Android system, lmkd will kill processes by monitoring the
pressure of psi,
but lmkd may enter the UN state for some reasons, and be unable to
kill the process in time, resulting in OOM.

This hook can be used to detect psi just like lmkd, if lmkd was blocked,
the kernel could kill processes to avoid the occurrence of OOM.

Thanks!
BR

>
> > ---
> >  include/trace/events/sched.h | 5 +++++
> >  kernel/sched/psi.c           | 2 ++
> >  2 files changed, 7 insertions(+)
> >
> > diff --git a/include/trace/events/sched.h b/include/trace/events/sched.=
h
> > index 7b2645b50e78..c23cb2bc76fd 100644
> > --- a/include/trace/events/sched.h
> > +++ b/include/trace/events/sched.h
> > @@ -896,6 +896,11 @@ DECLARE_TRACE(sched_set_need_resched,
> >       TP_PROTO(struct task_struct *tsk, int cpu, int tif),
> >       TP_ARGS(tsk, cpu, tif));
> >
> > +struct psi_trigger *t
>
> Missing ;

sorry for missing this, would add it later...

>
> > +DECLARE_TRACE(psi_event,
> > +     TP_PROTO(struct psi_trigger *t),
> > +     TP_ARGS(t));
> > +
> >  #endif /* _TRACE_SCHED_H */
> >
> >  /* This part must be outside protection */
