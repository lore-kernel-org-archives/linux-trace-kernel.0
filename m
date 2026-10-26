Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793055393;
	b=TtbXokuA4L6hnS+18YjNQMmc0WugYDSwCk9BeJNko+r4lrz1IkK5IckYeaikGhGxBK+X
	 1DKlcREKRnSRLYsli3xZEU/sFawReBjPlKC9d8KtXsNClXyi8skoQC2DHL5VwFHye/LRV
	 nk39BsxO02wAClHki2gl8iOjj53ux0Omo68+hCQPLKhPzmj8wvQWiG3maHnFmR65ppufy
	 KbfIADcS9hYy4AS7KeXfRfobMtWI1hQomEnKYy/B25cEepwDoVHn2fni429K85EZQabTc
	 66H8wuRm9Rq6JB5HKQYJgsatWGJNNYTCRpW+uHmqqMRAtw5OHm8rAVUGkAwF/sgZDWg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793055393;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
	b=eWu6dGi66zMlM2lPlKYCIrJSqfoNT/pa1PZWM69LpK0zC7Vf7HBQ1KxZCTt0Y8kLlvd3
	 L3Nnq5OjQYKL4rsYG4/BvfODAOgFkW9yVL69jpEm8wfj1oAPufqtnts1wHSmTOUjtMwKs
	 IsZwJihp9RepvnADPIgb3egGZWAEjW78PbNbMEGg2FPnLvWXpViSPnAg1PAZOrp6bfsj0
	 o4tLnId1beo7trxHwPJB5KCfhoqPuFHhCoEFUbs7MHMuTxxHjvnpYwm924iBLXMh0zR18
	 EapNemwXHQwvEVEF6YBHegxjieWOQvqTjy90jEKgFRR3N54XMGNrneL0ne5r10Lqj+Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.42
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D5FB606A326
	for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 22:56:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D5FB606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20251104 header.b=s8grGiR3
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-c418e215671so458893766b.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 26 Oct 2026 15:56:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1793055391; cv=none;
        d=google.com; s=arc-20260327;
        b=YZVA+uGLPdK6eHDxpdfkkkPf9mcDhrYlf3bkyNP2Ykck/DL8GpCJypINIp3HFHpb0j
         9Dx6elXY5rY9b9O4uLQ49Xg1ZIMdVZbFR29rjUUe9dD8jka84qhUnIbj9IkTTA+6wllR
         6uvXAvOFANnoApMhkIhQo7SGqtM61FUXS5TIka0mjAYFpUjRjdIJiqTg6Y5OHIunxt7N
         AMvS2Ayy0tLHERbGexMVPLPwCQVDLe3be7reMiNgJuAHKcGLxjvPeAmhntP76jlrMSUe
         mMBOFTsXhcHqyn9MxPVfo4brNtSnarbVaX6c6tqf5Z0ZjWWBKgreJrXTw9JTNWVcy41I
         eKJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        fh=6XkmGMtTeVyK5o2txzzOZNk3yLbuV3ECRKni5qWY14M=;
        b=qDFjEVOJLFpgu48v6yB3ud6Kbl0dnWLrlxLs0X8VFr6o59SuTQMmLQZarrKeI7g8lr
         +n5+eOyrESxPea/RhXfvmByQbgn2tY9c0LmOEG6hhwNQ7UfPiaGIdWMJqHarIVyptiSV
         pzvILozo2k1AYuG0TluvVssiJna2xvs/R+xHZcirpu4W/Vi7IWrO7GgdeKYjkCmQYcsO
         SmwrCy/w3FLpYiak5bzRmH4t5VJ6uOT/VqIcnbWhi0epybeHaFpzqMiESZYYibJl5+nr
         4eE1YxB7pkBCqlVHEvuSu/nayA3rUgIhzbdtJO2s20dUqX841byfuKyU9FZRArKbABqb
         dzoQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1793055391; x=1793660191; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=s8grGiR3jmOk9ry50/nEnZjaxWjWOPyppi2m4MHQTMfb5el8k0obk5/UMSWfPsQmIM
         HPtLzsEa12OcSsVXiRmiCNw+UUDDo1UYyS6DiU9bwXoKmoGF82ns9DjJzrfs9pJWdjkT
         dIxIeAf/R+LNQl/XTj1bdocyLOLlTkNfh75pW2KuZcZpn6JGMaXwZms8i83nnm2msMhG
         qxuIapSALuC5I4z0EKwNizZvGG6PaVYwrsYFc03clQ+zaffY9Yi7+Rd9DeVq8TqQMsPo
         mOa9KjkQgAnBHYiQJzjduIMO8ab1In9zxpTDESz20wql691IHa3z4eYMgIiR+VfFmdpS
         4rSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793055391; x=1793660191;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=qh7+bL2tt7/pVu5eSjikO++61ieI9Cj5ZNr8SJkHxX4=;
        b=lKcafJiwsUWPKo87XPQyJ2zMbSwSPyom+QXe6Hgo2kATDCtqnoatMY8+VtnXGrALM6
         UypdnEoyqcB2jm7heI/uf4V96dwtu3AiAnqoGPYApAPUTdv4bvrMoo3WO3On7MMCWyUm
         GDRX1G64/kGLnZW4X1QyuYnx1anKt1eid46b+TBh9msvaDCkNNJA4rsYl6ygUeTxnXKb
         yzGjd+QRozaJiAE/uLYAj+N64cnvAs3pKbLpDasePVP7AYVHUda8glLPuRN1b40tZw/u
         cBa6urCB5BOz5Y5QRP5+TkYxRMMd0vsTPKv7Lp9kUa0BRHkF0PuDNBtIJ2SsCYipwNuu
         crjA==
X-Forwarded-Encrypted: i=1; AKwUvBzfZPaxWNyi2mWBca4LEQq/ebnJhxFEqogEpLN+biB4DgTVXIV644D1ng/xXru9GDOPnifChAqjfil5oNhRvRVjmCg=@vger.kernel.org
X-Gm-Message-State: AFq9FYLo4itSDwiYKdvhWwfQYMsQTAgOrk5S6GxV5eas2m8Tp3w/afFb
	2l8pHYQR/CeT9XGZJ8Cj03VlBcpekVVfntLhFzTKxhwU1gMKCCfely7QKXFwlgyVjXprR9kTZxi
	eIF81hCcKAmOpmbZDQKDblXH82J5LM1ozoRe+6F92
X-Gm-Gg: AYBFou01CxcCeF7DQ9Ey6FpRiNEZs73JiqHiIhOaTZNft8oZ1k+wKWEZMJ5fRTzB1ft
	srohPAF2Dq05YtXIh4V1KxkD/O3bdABalGsAui3Kj84ye30PVqmYd0EgtiBqFETANpDG/T8H/jg
	rFr4xtiFp5hcgXIQR8OJeb1FPyUciYIFvmENO3ldZZ5Ue7RZ+ZWYrETgIWRB41ApHLRbW+JHhaD
	Fkcbpirb4Tkj8ukNaklmt+GVKtummiQVr4aqBzAQTzgYbb3tAwt/70V72y5mziaicTfUJOx2Qsr
	SWNNXgaUid8B3yyk3DGT+x4yOoxhyIKi53fAZlW1dPtqQW82hJf/gep3eFtnE+hXlw1r0L2pliO
	0fRgeQgTKrvjiNoCXJTCK3RLaiM9bYArqF48EfbLUEISmv47oQxSAHZ6Cw8W+pYYQGXSQ6Iw8gk
	3c7VhGw3wCFHdro5dNR9E4u0vCHyFWdxEtWJONIDYM0+k1cretddGE358fummh54dHPepIUoLJU
	ojEP/5C
X-Received: by 2002:a17:906:9c8a:b0:c2e:7da8:f54f with SMTP id
 a640c23a62f3a-c46bde874d7mr911731866b.38.1793055390933; Mon, 26 Oct 2026
 15:56:30 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261026215226.3713941-5-jthoughton@google.com> <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
In-Reply-To: <bce97570ea9665a2f83216d4dfd7ab7ce17d54aa777f761c3d12db430ba21bb9@mail.kernel.org>
From: James Houghton <jthoughton@google.com>
Date: Mon, 26 Oct 2026 15:55:53 -0700
X-Gm-Features: AclHuK_4pEIR4EnpfJkK690R4CHqdS4wt-7zneGKcf5MW03i114xuH5q5kcZiJk
Message-ID: <CADrL8HXeYRC8w7F7e_6ZXK6MHd6FRepN_zD632j0JPjNUDrLZw@mail.gmail.com>
Subject: Re: [RFC PATCH 04/10] stacktrace: Don't unwind the user stack without
 an mm
To: bot+bpf-ci@kernel.org
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, tglx@kernel.org, 
	peterz@infradead.org, kees@kernel.org, arnd@arndb.de, david@kernel.org, 
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, 
	surenb@google.com, mhocko@suse.com, seanjc@google.com, pbonzini@redhat.com, 
	jmattson@google.com, axboe@kernel.dk, asml.silence@gmail.com, 
	James.Bottomley@hansenpartnership.com, mkp@kernel.org, dsterba@suse.com, 
	mason@kernel.org, ast@kernel.org, daniel@iogearbox.net, 
	john.fastabend@gmail.com, jpoimboe@kernel.org, rostedt@goodmis.org, 
	mhiramat@kernel.org, mathieu.desnoyers@efficios.com, mingo@redhat.com, 
	acme@kernel.org, namhyung@kernel.org, linux-mm@kvack.org, 
	linux-fsdevel@vger.kernel.org, kvm@vger.kernel.org, io-uring@vger.kernel.org, 
	linux-scsi@vger.kernel.org, linux-btrfs@vger.kernel.org, bpf@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org, 
	linux-kernel@vger.kernel.org, andrii@kernel.org, martin.lau@kernel.org, 
	eddyz87@gmail.com, yonghong.song@linux.dev, ihor.solodrai@linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 26, 2026 at 3:30=E2=80=AFPM <bot+bpf-ci@kernel.org> wrote:
>
> > stacktrace: Don't unwind the user stack without an mm
>
> TL;DR: Commit message only: the Fixes: tag may point at the wrong commit;
> 7e8e6816c649, which dropped the !current->mm check, looks like the real
> culprit rather than 214d8ca6ee85.
>
> > stacktrace: Don't unwind the user stack without an mm
> >
> > stack_trace_save_user() only refuses to unwind the user stack of tasks
> > with PF_KTHREAD set. That doesn't cover all tasks without an mm:
> >  - A user task that has already gone through exit_mm(), e.g. when an
> >    event fires from exit_files(), exit_task_work() or the final context
> >    switch in do_exit().
> >  - PID 1 before it execs init, and usermode helper children before they
> >    exec, which are created with user_mode_thread() and don't have
> >    PF_KTHREAD set. E.g. booting with trace_options=3Duserstacktrace and
> >    an event enabled with trace_event=3D unwinds PID 1's "user stack"
> >    during initcalls.
> > With the ftrace userstacktrace option enabled, the architecture
> > unwinders then read the user stack without an mm. That access does not
> > reliably fail: the user half of the address space belongs to whatever
> > mm happens to be lazily loaded, if any, so the unwinder may read
> > another task's memory.
> > Use is_user_task() instead, which also checks current->mm, as perf
> > already does for the same reason since commit 76ed27608f7d ("perf:
> > sched: Fix perf crash with new is_user_task() helper"). This also stops
> > unwinding the user stack of PF_USER_WORKER threads, which never run in
> > user space, matching perf.
> > Fixes: 214d8ca6ee85 ("stacktrace: Provide common infrastructure")
> > Signed-off-by: James Houghton <jthoughton@google.com>
>
> Is the Fixes: tag pointing at the right commit?
>
> When 214d8ca6ee85 added the ARCH_STACKWALK version of
> stack_trace_save_user(), it guarded the unwind with:
>
>         /* Trace user stack if not a kernel thread */
>         if (!current->mm)
>                 return 0;
>
> That check already covers both cases described above (a task past exit_mm=
(),
> and PID 1 or usermode helpers before exec, which have mm =3D=3D NULL).
>
> The check was replaced by commit 7e8e6816c649 ("stacktrace: Use PF_KTHREA=
D to
> check for kernel threads"), which switched it to:
>
>         if (current->flags & PF_KTHREAD)
>                 return 0;
>
> That dropped the no-mm protection, which looks like what this patch resto=
res
> via is_user_task().
>
> Should this be:
>
>   Fixes: 7e8e6816c649 ("stacktrace: Use PF_KTHREAD to check for kernel th=
reads")

Thank you, yes that appears to be correct. Updated in v2.
