Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C808384CCA
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 19:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.173
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787601262; cv=pass; b=dFyNfWq89+cgDEqXJoyfLA72MsnvyvytD7O0CW5iY7VHiIpTm4ZD5uKm07qpYOkh1lqOyl6WVUVSZCHM2zvWe/oa4D9wF16D0V6TV6Jt4RfgFXXKWRPfFjUlFxm+dNZhRx7SSv/NoP1Tq6LrfddjxgbtOD1mlqq8PwGtwOCBC38=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787601262; c=relaxed/simple;
	bh=7uEPvNkh0wPywyUSpf8tg+GQKzcygTjCuvJr9dww0+c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LP2NkTGwHjgY7Y3puss4PkBHk/A7SvhrlyVt8AQwimE9IhbF3aF4r1yzTR2fdGi9gGG4ox74uIQ1km4Jk+v7gqXHmUDKb+iN3KY6NdLYnwOLuoXh6Tj2hF6VdYIIttRks2Hb1wALs5AUrYPBYxZ3j128GVrTT5kpb3D42r/9BTk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GIxu89K5; arc=pass smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GIxu89K5"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-84faf87d19dso3841682b3a.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Aug 2026 12:54:21 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787601261; cv=none;
        d=google.com; s=arc-20260327;
        b=aGrA0d4nZUBRFkmMnQZ2AJo7aeIwZUcGmulTPjJCJzr3UWs6cezOEwp9n2qs4MeCSO
         yFZERxeUwOyO7/IzQiK0P/ke0FgT6Pq9r9wLxS7glarCab6DMfwj8LbALv2sb4KN7lEI
         fabaEybDRkg9SSUuKnTP6IKKYsglA54HNoc8w1tjukuQFhHXs5Dl2Aufvbe/u5GW89gT
         gKH/2p8SXxERXF1LlDA48eqAAqHU3/WLztxhPv6VNsm9B/kdhSGLTk/yhXy2/9IV9/pT
         Rw4Nt1nrpdqaSWrIEDbr1h09rX1mHsH9DPjTcJT5eXwDhRmt4es+hpXnQ0/kTwoHV8YA
         wYpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=b+Q50ekDC9b+VMm0CXhjeVN+dTm/g3kpzzvFfKOXcMA=;
        fh=+WNTMpQfvkRor1SkihobMk91Ph8imhP5EImsB5SBxy0=;
        b=Q6fUXHkTQAgsnvcFQMK1QEDGdXLB2EW6DrEufqIgVelJRxM1BICJ1ccr7IJJnxXaYZ
         JDpyAKSdDICJdgW/FT988CLkssC9j95OETBaouT3fJzk8uTW+AzLm3m4LTnBDU9b2H0C
         +PMv448S2T55AK1G3HyFbo5JyjMYj3rA/0ExUaKgrK6Ep9v78stJEtpKef8f8bW1FNxr
         moVFd6ICQKKSo+MrNNd7QA0NFQOBMKhaxj4mw7Y21I/8JLYOrJHzpWD61iGpRCzaFca0
         178gB9oJ0PRjzEjyWEMZqFBxslJ7iyLiefVaxv8VdF036d+H90d5cwj1WRncCoeXFBm8
         /40g==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787601261; x=1788206061; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=b+Q50ekDC9b+VMm0CXhjeVN+dTm/g3kpzzvFfKOXcMA=;
        b=GIxu89K5zRaFr4r/t0Qp6nlWfhp9Hq/iRzRLmUZmC8J9uJmB61qsHgQDMnrRdaTpb3
         Nap4qzPZc9EffIhvGbHUkhUI2dvcA4mNpr20w2KvN/wCd2i9STVRzNBdbR221ZNcfbIP
         +JsBjgnfaUwN+2Y4rj9D7iPJ7wPIpCI/yqfNle5GHGakyxbQJgzCucxJWIa4gBkpk+Bo
         7LywM9aUxoNQonoENDeRRhZ8qo7R/0isETw/d30XdlOGemgdNoDzluSQCtRgwyUrs/Eu
         MmKfbflmsckFgKBNSCdREpD6J9g1U/DbM+4rsJAEpzbRISMiOdighQt02yU8qRLqK+Gg
         pT9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787601261; x=1788206061;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=b+Q50ekDC9b+VMm0CXhjeVN+dTm/g3kpzzvFfKOXcMA=;
        b=XnTsa6Ql4VHSg+ZcQSaILZAiP48dlmA8c7pIm3tuN6icaUikJ0rJXb1zQLfuiW8pHq
         T6u0CuPenIUmux+Tz284SNcYEBKIJ2cCMSDu6mNiTeFPcOad8fHyYArf4dDzfyoUXV1o
         27mm7I+cUqX5Ib3H7rNukhghkMqL7/Z5WFIGHJNaY8MkRHiYuVm8clCMHud0zUAlKVyb
         0xH4BRjwgqWbWOzPreSZxD6czA4JjalrXAU5cesrRNJ0V2ejpSiZtiJvzohTaxwsaxuA
         EU9iLxo7DXBt1hKVStAr+JNarbHTUcxW9IwcXvaFBIfRo8C9RQofS99LKz3XnLa5NdSv
         GmPA==
X-Forwarded-Encrypted: i=1; AHgh+RrOgOrHHgfoOPOqY6mrxf+kHCFxLPQl0AkA6xjlRiXL2hUc+mlqiS1jEggpfkeWKsu6XmENfgUjCyImYy16dtU5IZo=@vger.kernel.org
X-Gm-Message-State: AFuF++kAJXgIVWZgWmdJ6rgXDC71kzrR5M83vzWdE9gdnWEFTTcKm6K9
	hoqgUcn/kr9XA2rDAcB0jDIV+B/Q3QHCjO/+TD/6o867Et8fpTHLjWhHcrfBGT0TzGp0nAd+Kbs
	TezKmNjbXfE+MkjvZr9Kws5C9iUq5ez8=
X-Gm-Gg: AR+sD12QXY1a0yeeShwQxIEHvCkXynEAVL/QdhWAPM3vopZK9r2AZyGIffcOCh9Ovc4
	svcLKpGuRjQnJ0V4dAqnOjypQ3l8M+eba4Q8RjUfx6EJbckRLdfckjFGY0VRl0WdZXH/kdIU64a
	CLl/QnBaccnjh2cGQom1t2or8kPnYZyhhHki7OWKrldmusu3H6/+i0jYgD46rsNV41YvOZADcQi
	s0CK7R7YoPd+LCv3Xv+JBk5VZDgk59z6YrhG7ISmK/sG/HW9dEYqqJ31lh7cJlBESRXKrndnZWo
	RXUaEd+z6iTUp5+X1ykCKqHy2UBpBt1sre67fhUC78AdoTLD4QnM6cmCOn+GQly+VhIyEPRYAQQ
	uwJVRFKIFENP/V/OzHpCD1tX4HpF2Dw919V3fqEnPWg==
X-Received: by 2002:a05:6a00:f08:b0:84f:37c1:f887 with SMTP id
 d2e1a72fcca58-8520ba2ea2fmr38445574b3a.12.1787601260681; Mon, 24 Aug 2026
 12:54:20 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260822054620.452262-1-ming.jvle@gmail.com> <aosT4H14zcowzU_7@redhat.com>
 <CABbwK50esft7xj6cPWXN7iHnqW6E30w1Cg5FMmE97gJ34SqtfA@mail.gmail.com>
 <aotM6tRUHI9Bo7gW@redhat.com> <CABbwK50istUW_xnFsjCA+MMgFCuBbY-Zs3QmJU=Fg7heqKdF6A@mail.gmail.com>
 <aoxp3Rcbp3fUuqS8@redhat.com>
In-Reply-To: <aoxp3Rcbp3fUuqS8@redhat.com>
From: Andrii Nakryiko <andrii.nakryiko@gmail.com>
Date: Mon, 24 Aug 2026 12:54:06 -0700
X-Gm-Features: AcwNN1UPgMEuZCxen7PbKRMigTGKjiHrc98UZ0KYRuGhhLnIXTDbxzsARdQVrl4
Message-ID: <CAEf4BzbUQWAB0JuEdXu32v4S_zMuv4de+kYv0mcY4tDPu8CA2Q@mail.gmail.com>
Subject: Re: [PATCH] uprobes: Free utask on dup_return_instance() failure
To: Oleg Nesterov <oleg@redhat.com>
Cc: Keke Ming <ming.jvle@gmail.com>, Andrii Nakryiko <andrii@kernel.org>, Jiri Olsa <jolsa@kernel.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 24, 2026 at 8:57=E2=80=AFAM Oleg Nesterov <oleg@redhat.com> wro=
te:
>
> On 08/24, Keke Ming wrote:
> >
> > On 08/24, Oleg Nesterov wrote:
> >
> > > Hmm. It is not that I think "it is not enough", I think this is point=
less
> > > whatever we do.
> >
> > Well, I didn't mean to insist on the cleanup, I also think it may
> > be redundant. If the child is bound to exit, manually calling
> > uprobe_free_utask(t) in dup_utask() is pointless, as the normal
> > exit path will handle it.
>
> Yes, but the same is true if the child is not bound to exit... IOW,
> I still can't understand your motivation for this patch...
>
> > > But this is only the first step to cleanup
> > > this logic. I'll try to write another email tomorrow.
> >
> > Of course, I'm all ears.
>
> You have already mentioned "Option B" below ;) that is what I meant.
>
> > Here is my current understanding. One thing I am not sure about
> > is the signal semantics. If the copied uprobe state is incomplete,
> > the child should not return to user mode with that state.
>
> Perhaps... But consider
>
>         func_which_can_be_ret_probed(void)
>         {
>                 if (!fork) {
>                         printf("CHILD\n");
>                         exit(0);
>                 }
>         }
>
> > Option A:
> ...
> > ...
> > kill_child:
> >   // I was thinking about SIGKILL here because it cannot be ignored
> >   // Of course, you can correct me
> >   send_sig(SIGKILL, t, 1);
>
> force_exit_sig(SIGILL) can't be ignored too. But I am fine either way.

Current SIGILL sending is already pretty bad behavior that bites us
periodically, instead of doubling down on killing the user space
process because something about installing uprobe goes wrong, let's
think about a bit less destructive way to do this. Mark uprobe for a
particular process as defunct or "detaching it", or something along
those lines. But not just kill innocent processes.

>
> So yes, perhaps this makes sense. Although IMO this all is not that
> important; GFP_KERNEL shouldn't fail "in practice" and at least
> uprobe_copy_process() warns in this case...
>
> > Option B:
> >
> > > Note that uprobe_copy_process() warns but returns "void", too late
> > > to abort copy_process().
> >
> > Looking at copy_process(), uprobe_copy_process() is currently called
> > after the "No more failure paths" point and after the child has already
> > been made visible through the task list and pid links.
> >
> > Would the longer term fix be to move the uprobe state copy earlier,
> > before the "No more failure paths" point, and then add the needed
> > bad_fork cleanup for  p->utask?
>
> Agreed, pronably better than Option A. But in therory dup_xol_work()
> can still fail after fork().
>
> Oleg.
>
