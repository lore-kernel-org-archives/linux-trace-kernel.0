Received: from mail-qk2-f40.google.com (mail-qk2-f40.google.com [74.125.230.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C44614315A
	for <linux-trace-kernel@vger.kernel.org>; Tue, 29 Sep 2026 01:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.230.232
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790644856; cv=pass; b=Hhx9VS5pCHGOYiqKzRQnGt1yKcolcujYELXMmQmHTR6J/n5CPDpzZb00bROGs+MyJH3s70iNI+fjjqgldl4X+Wr1UFZtMmh2p3uqYYiNlQXA3wHylf0lKwo0EUTzCRtVfMF23BHo4oMmEUAdIu+oTQrAZJQxihMAT3prqzdYcW4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790644856; c=relaxed/simple;
	bh=FUpC5+QICGEEQMitDGZ4kUhvLc8mbh2N6lFIAyT1Fgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=C2CA7/5jcrd4vjotV7UFFzNB2MARjBqKITsjlrV0KW/dI6WBE6NxON2kymW8rq+Gwnw4kRJPQupjDOF/bEhJ2Sdzeizlya8i+pO/hlrQbWggFFW205coYEtqGAICyiTVcV3aLtDeGufhgMh9VDJfKH3xzJRTZFFF/V9qZ2fkNpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NG75XCff; arc=pass smtp.client-ip=74.125.230.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NG75XCff"
Received: by mail-qk2-f40.google.com with SMTP id af79cd13be357-93c5a24e868so298292785a.2
        for <linux-trace-kernel@vger.kernel.org>; Mon, 28 Sep 2026 18:20:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790644854; cv=none;
        d=google.com; s=arc-20260327;
        b=PjzgAs9UWesvKITikwTa1Rd2iQzgwGPLIQ4SWF6wQ6S/Ua8Z1Edjes+T/15KikvY39
         lUvlII4yecRpKA8TDGIvUOl489f3q77Hfj/Y+aLurcf2G/FuVtDcbisTS1YopsWuLLYn
         7vXu2zFkG0Mtt3OrHXkvy3cmOB1R/dn6Ii9pAO4AltFI3gDGR44ofeQLtQoEkd1p8boa
         I9uF3u0EoekOSowbGth5I9QZek6QyIyq7H+aoD4MdtmNvJxdSWLtIcj/hKhOzh+IjUTu
         Zp9YG7GY3kb4q2ywfNkTmQsraMS1CbVg29F3MgZqLlrKsbRgLEUSj72prWp778IIkUUk
         oYCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d4qa5JgZpWpXAOARMRbQJDt6dJ/0X4FjiQ4MUTrDE2Q=;
        fh=SYKxnBZ63YE1IjqMrtZQlFKtoqq+0o/zOVjTElt6yfc=;
        b=a4Ug5urfMdXD0WQN1GVMmVmCjcGxjdDlWhKMCIWsIt1YXaqDbIgdff5A+0u50NGxv0
         K2Gua5lXdNaYH8DATuDSokiQZCMPwqx5Q24Z/zjcMginBRk1gf8j3QUviFVU0KAPFNs3
         uSCZTSCv7HMlrHqJPbpeOlXt015dwk+jZyjEEa2frRNtTj87TE8Cgmk6oDaRqT0ZkQYw
         OAffZcVbg5oXG/QvO0x5d0nrwq9lVwmwkcWNYNm9pajB0z7SulJd7IkdWFfc12g0/tHv
         jClUFOWP+0Dbg5r/Z6dApHOFH+FJc9g/qyWiLczdsLhmY+U6jbi2fjnRmXA0TfByZo1F
         35OA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790644854; x=1791249654; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=d4qa5JgZpWpXAOARMRbQJDt6dJ/0X4FjiQ4MUTrDE2Q=;
        b=NG75XCffMF2eowdU4w2VaWTafhg/25KDIk5L0uLDnzmHuc0qVfEZhEPScbwUilj46e
         jks3aAC/u1CYnoGySbiZM0Gk4Yg+ImreniXIgfK+ROChaBhzD8OXyqr/5we265raiXEh
         jmDQE3D6ljo/4J0nqEEq7g9Ma/DhUeSoBRvnXHkoimBqXjymsKK2fLow8PV4Q7CSdeqp
         OjBgGwBFJc0VjKwEEeonXq+eEOOkQa6LlcoCJ49ptH2/zo9bSKfaGroIXcCF7UULDauR
         FaZifgetWURXLIoxdgH1fNRbXFmX2OsNp/cXLXcCZDDGH2PuHodSNL4iVxCKJb/hw0nx
         vggQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790644854; x=1791249654;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=d4qa5JgZpWpXAOARMRbQJDt6dJ/0X4FjiQ4MUTrDE2Q=;
        b=SXCaNKYf2rQIoxqtemavrtJ1nzxiksK416V7ksOIOyf/3vnRByDt0PbUHVhGtX3sT+
         gLwvYTPMJoCjr10UhwOoH4nAY7rFglvEhHmzK33+n8QNjlnghLYwq7/VZ/2uxQ2SxmJq
         E/VjboaOl1GKxGkceuNSWSHIYiOHv/9a7lZ8M0vnyi+YH1iTyWw9FGzSUtwoFluT0ZGU
         b49kS1xfFB8jJkN/gAPslfjCd6ZtZUaiFlWUy5hMfkwTa+P+kfZAZdQAOk925jkbK9tO
         psMSFiDsN+yAL3bVZEw8Yb+mkiDm2yRwSCYFZI+HB/BBFU7ilva9Yi4HP7yekpCsBUHQ
         eGhg==
X-Forwarded-Encrypted: i=1; AKwUvBxSsXwW1dPVpu1jrN4vYJ633s2Tm2/YTP1OXntN0xutJUzTlLCJ7uQt+cdSKeNOSy8AZr9hrKgmuVz9rZKcll9sNcY=@vger.kernel.org
X-Gm-Message-State: AFuF++nbBPgKmbZk8Kpnm8jJp9u/ARXgzKEV/+jXB5kbIBikjXCmAzmp
	HlStsae5+SFDLQipaHk69U4H9+lZxziejRVfPr9sILB/KNvix6jrl9JT4ltiHf3El3EuRkFYsbm
	8TeohTr8PHAbfv/ueFNu61NltBVwyP1M=
X-Gm-Gg: AYBFou39rvOr2w6j4jGN+zNfBmgihwhkoG137OlSXwwgnbzEYRX4bXcsxINBCyhuFYI
	yJP6VTNV8zb190Rd6jpOp32jT0pUH4YQtvH8bqsvsRrZJf0Oaj2+/ldvOzymaB/CSMW31kpFXEt
	sw24rocFwlA1JgDIgMs9dOt9WdY8LakPO+GCSQhKTMXXNa9VE4Wf+4OKoZLm/KEABE6qzzNf7VF
	u4a1vjPvcjns5ffDU44PTEWj1q1SNmq6wzGjNvzrhr/z8JCsC5F2frqbmHmf/HlLEggpIR6YLWJ
	DLVU0Y5gfVJQ92iBNERvV3GVrGcWvFO/zvMNgngGjTq2YjyXgPt7s6SB2NSqCI4BaTlJNlKwG3h
	BqQgWWsKpB2JbYbok9W8EFbBdp195ZX+IBXLT3IRj8Fgl6J77X22UZPOUDqsLBAKshBH86zHNYU
	y90yqK78ffNGOP9qlJHOAYzAQN5LAveySFkDuwx0bjYDce8g==
X-Received: by 2002:a05:620a:a2d2:10b0:93c:6904:9644 with SMTP id
 af79cd13be357-93c69049a34mr969668385a.35.1790644853648; Mon, 28 Sep 2026
 18:20:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260928084125.67104-1-jain.sm@gmail.com> <20260928084125.67104-2-jain.sm@gmail.com>
 <20260928154405.fc2e650ef162f53d9d8e4d0a@linux-foundation.org>
In-Reply-To: <20260928154405.fc2e650ef162f53d9d8e4d0a@linux-foundation.org>
From: shashank Jain <jain.sm@gmail.com>
Date: Tue, 29 Sep 2026 06:50:42 +0530
X-Gm-Features: AclHuK-1e-bdOuxfqw6H9UrngACtzd7nUALd3x8Klgl8IctbgrLNlxx76j-HZ0U
Message-ID: <CA+FWx==P553i1Og3KBXzkf4N=DWxUO5b0nZFEO_=y6=NWLC-4Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] objpool: keep objpool_push() correct when a push from
 NMI nests in it
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Matt Wu <wuqiang.matt@bytedance.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Thanks for looking at it.

On Tue, 29 Sep 2026 Andrew Morton wrote:
> This code can run in NMI?

Yes: on the rethook architectures a kretprobe on a function that also
runs in NMI context (for example one that perf calls from the PMU NMI
handler on x86) takes and recycles instances in NMI context, so
objpool_push() can run in NMI and nest in another push on the same CPU.

> Calling WARN_ON from NMI sounds quite sketchy [...] perhaps this is a
> chance to address it.

Agreed. With the in-order publish a nested push can no longer trigger
that sanity check, so for v2 I'd add a patch that drops the
WARN_ON_ONCE() from the push path (or skips it in_nmi()). Masami, would
you prefer one of these?

> Sashiko liked [1/2] but had a lot to say about the test module

v2 reworks the test: cleanup actions so an assertion failure or a
timeout can't leak or use freed memory, the threads are stopped before
the test returns, and release/acquire for the flags.

Shashank

On Tue, Sep 29, 2026 at 4:14=E2=80=AFAM Andrew Morton <akpm@linux-foundatio=
n.org> wrote:
>
> On Mon, 28 Sep 2026 14:11:24 +0530 Shashank Mohan Jain <jain.sm@gmail.com=
> wrote:
>
> > objpool_push() adds an object to the slot of the local CPU with
> > interrupts disabled. It reserves an entry with a cmpxchg() on
> > slot->tail, writes the entry, and publishes it with
> > smp_store_release(&slot->last, tail + 1).
> >
> > A push from NMI context can still interrupt it and push to the same
> > slot. kretprobes may run in NMI context since commit e03b4a084ea6
> > ("kprobes: Remove NMI context check"). At the time, kretprobe instances
> > came from a CAS-based lockless freelist, which tolerates that. Commit
> > 4bbd93455659 ("kprobes: kretprobe scalability improvement") moved
> > kretprobes and rethook to objpool.
> >
> > With rethook, rethook_trampoline_handler() recycles instances with
> > objpool_push() after the user handler has run, when no kprobe is marked
> > running anymore; rethook_flush_task() does the same. An NMI that arrive=
s
> > during such a push and runs a function probed by the same kretprobe tak=
es
> > an instance in pre_handler_kretprobe(), and when the function returns
> > inside the NMI, pushes it back to the same slot. This needs a kretprobe
> > on a function that runs both in NMI context and outside it, for instanc=
e
> > one that perf calls from the PMU NMI handler on x86. Before v6.14, fpro=
be
> > also used rethook and could push from NMI the same way, with one pool
> > shared by all functions of an fprobe.
> >
> > ...
> >
> > Publish the entries in order instead:
>
> Thanks.
>
> > --- a/include/linux/objpool.h
> > +++ b/include/linux/objpool.h
> > @@ -193,19 +193,40 @@ __objpool_try_add_slot(void *obj, struct objpool_=
head *pool, int cpu)
> >       struct objpool_slot *slot =3D pool->cpu_slots[cpu];
> >       uint32_t head, tail;
> >
> > -     /* loading tail and head as a local snapshot, tail first */
> > +     /*
> > +      * Only the local CPU pushes to its slot, with irqs disabled, but=
 a
> > +      * push from NMI context (a kretprobe'd function returning in NMI=
)
> > +      * can interrupt this one at any point.
> > +      */
> >       tail =3D READ_ONCE(slot->tail);
> > +     while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1))
> > +             ;
> >
> > -     do {
> > -             head =3D READ_ONCE(slot->head);
> > -             /* fault caught: something must be wrong */
> > -             WARN_ON_ONCE(tail - head > pool->nr_objs);
> > -     } while (!try_cmpxchg_acquire(&slot->tail, &tail, tail + 1));
> > +     /*
> > +      * fault caught: something must be wrong.  Read head only after t=
he
> > +      * reservation: a nested push and a pop on another CPU could have
> > +      * moved head past an older snapshot of tail.
> > +      */
> > +     head =3D READ_ONCE(slot->head);
> > +     WARN_ON_ONCE(tail - head > pool->nr_objs);
>
> This code can run in NMI?
>
> Calling WARN_ON from NMI sounds quite sketchy - the warning handler
> does all sorts of stuff.  I see this is pre-existing but perhaps this
> is a chance to address it.
>
> Sashiko liked [1/2] but had a lot to say about the test module:
>         https://sashiko.dev/#/patchset/20260928084125.67104-1-jain.sm@gma=
il.com
