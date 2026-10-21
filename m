Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792625896;
	b=zIUuta8PJFyc6LOACSB0ePSCNEZIMRu0y09QM3Jnx9ywd5//7c2hFdvWKSb4GYhpBG2O
	 i53SckcF4ga0x7Y9cJqfXH2C0gNSCvWd8dHrSDG34JAnmu58o1YvrZSDrX3cDinB+rlCh
	 3t8EiVFTXVnQOsCc+e2/NjL5GjvDl7L73vh3aqiGBBJEYrX6tvhrjhAjIhH0Mz555V56f
	 u5aTFAYfL1o/nxugCrcuU0xdHvBoauty7M6VTLr8yjFAhuC7BIYLUU8I18HWAhqZ3Vnd1
	 RyUdHLy51w6b/Fuvj75XVQgOOp+ICt1xAqJCYLg2PYHP5VuSuSCwWsqyxgwFa+Zi/IA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792625896;
	h=Received:DKIM-Signature:Received:X-Gm-Message-State:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:
	 X-Gmail-Original-Message-ID:X-Gm-Features:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding;
	bh=XKZAiKGbiib5zp4TSw/Q6LRpir6OwzmcI8NEHPK6cRM=;
	b=0Y3CH8ckFZZJ4GgGYKGGOK2CjFUJTXwYm5fMBgB80bt02xBJCpxrzTdFJ4nWZQ+iEVaD
	 cdJr9xCVNPoTMlnlM5jq+nBuVaJkGOZ4vaOqitBU9l8hQwh13mAw5KNLMzC1t6Y9qK7zN
	 0vTJ0Cssr/hpf1tYmKj3D/joGdeGIkIhahfU0NKe/pA6NygLWS6k8HtMnOhi2mr27j0K2
	 eurf105uNCp9V/HQVjfVlerzHpAS47qsnudCtb4GFMnYWSNPZRGU3EUWLXffswDEnTAuP
	 5F33t8brZPHXSa+25kcBWz8PJlfWZgDV+6qjeQDMj5a6q64gZR69uGQQUzDwpMtzRCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGYp4snV;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17BBA606A319
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 23:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KGYp4snV
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA6A1F000C1
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 23:38:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792625895;
	bh=XKZAiKGbiib5zp4TSw/Q6LRpir6OwzmcI8NEHPK6cRM=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=KGYp4snVpc4yppC4iml3i3sp7pRhIseUpDUnYR8eATwzd8SipbIiHhph7hyXGcg5H
	 tn0/PJY7fsIscM6xoxoZMiej5nnPuVHLQJZOFkuf5R8e+ziDticUXclb3pF6plANJ/
	 S1r1XabELzW/cJ8NgoaDJxvmjU29XBaCLQQhQEmbqCF0K1qXb55awSgWp1PmEdSXwq
	 Z4Fu4GHHPNMAsbUGD2HCX7MioWaxZQfWzg+NAnxQ8uO22A0V29ojtMqsPOewOmMG6d
	 kMhe7ENpnVrVa5h9PY2D/320UDmb9/wCbx5yYt3DrYn94DVV039yhj7u0zE/XCVdO6
	 ZX/mMb7ytMAfQ==
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-93f079a63b8so130708485a.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Oct 2026 16:38:15 -0700 (PDT)
X-Gm-Message-State: AFq9FYICKtHpgjKnnvGElj+DY8MfnDZZjgwpYdp0CdZ7g50Qpz5MRfA6
	556Qoan2UNxtc3bldlgx44J4KgJGVBf1DLbt4iywe4xDgNDQdhvnrwxZvVPZYIrYqcqb8n7ETYF
	I1bhZruZtL0tYJN6d6cinIpBgp0YNjP0=
X-Received: by 2002:a05:620a:601a:b0:93e:5daa:67a4 with SMTP id
 af79cd13be357-93f57f0a0d9mr727720585a.29.1792625895221; Wed, 21 Oct 2026
 16:38:15 -0700 (PDT)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261021222255.3124940-1-song@kernel.org> <sashiko-outbox-180771@kernel.org>
In-Reply-To: <sashiko-outbox-180771@kernel.org>
From: Song Liu <song@kernel.org>
Date: Wed, 21 Oct 2026 16:38:03 -0700
X-Gmail-Original-Message-ID: <CAPhsuW5BhxAUC=OE=mjZ32vtYpsGM2WYw6bKTXF5GrTDh8CiSA@mail.gmail.com>
X-Gm-Features: AclHuK_CkLDvphCAJPCC_oZ2GWHVamkqhlYW3dwZFYCLJHlJKYBN8UaCaDlSLYA
Message-ID: <CAPhsuW5BhxAUC=OE=mjZ32vtYpsGM2WYw6bKTXF5GrTDh8CiSA@mail.gmail.com>
Subject: Re: [PATCH] compiler_types: Do not mark inline functions notrace
To: sashiko-reviews@lists.linux.dev
Cc: linux-trace-kernel@vger.kernel.org, live-patching@vger.kernel.org, 
	rostedt@goodmis.org, mhiramat@kernel.org, mark.rutland@arm.com, 
	kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 21, 2026 at 4:09=E2=80=AFPM <sashiko-bot@kernel.org> wrote:
>
> Thank you for your contribution! Sashiko AI review found 5 potential issu=
e(s) to consider:
> - [Critical] x86/paravirt: removing notrace from inline instruments pv_op=
s and resume
> - [High] tracing: removing notrace from inline breaks ftrace recursion pr=
otection
> - [High] rcu: srcu_read_lock_fast_notrace() and tracepoints lose notrace =
attribute
> - [High] bpf: removing notrace from inline exposes trampoline helpers to =
fentry
> - [High] entry: removing notrace from inline instruments unvalidated entr=
y helpers

Wow. I didn't expect this from Sashiko.

> --
>
> commit 1eb6626c4a5ab70e5858a8a8f1c9edfca235db57
> Author: Song Liu <song@kernel.org>
>
> compiler_types: Do not mark inline functions notrace
>
> This commit removes the notrace attribute from the inline macro definitio=
n
> in include/linux/compiler_types.h so that inline functions emitted
> out-of-line by the compiler can be traced by ftrace, attached to via BPF
> fentry/fexit, and livepatched.
>
> > diff --git a/include/linux/compiler_types.h b/include/linux/compiler_ty=
pes.h
> > index c5921f1390079..ea7f2a928b4da 100644
> > --- a/include/linux/compiler_types.h
> > +++ b/include/linux/compiler_types.h
> > @@ -230,9 +230,8 @@ struct ftrace_likely_data {
> >   * externally visible function. This makes extern inline behave as per=
 gnu89
> >   * semantics rather than c99. This prevents multiple symbol definition=
 errors
> >   * of extern inline functions at link time.
> > - * A lot of inline functions can cause havoc with function tracing.
> >   */
> > -#define inline inline __gnu_inline __inline_maybe_unused notrace
> > +#define inline inline __gnu_inline __inline_maybe_unused
> >
> >  /*
> >   * gcc provides both __inline__ and __inline as alternate spellings of
>
> [Severity: Critical]
> Could removing notrace from inline cause a triple-fault during x86 suspen=
d
> resume, secondary CPU bringup, or kexec when function tracing or call-dep=
th
> tracking is active?
>
> In include/linux/compiler_attributes.h, __always_inline expands to inline=
:
>
>     #define __always_inline inline __attribute__((__always_inline__))

I wonder whether we need __always_inline to be notrace, and whether
this resolves any of these concerns.

Thanks,
Song

>
> Because __always_inline only inherits notrace through inline, removing
> notrace here strips notrace from both inline and __always_inline function=
s
> whenever their address is taken and the compiler emits an out-of-line cop=
y.
>

[...]
