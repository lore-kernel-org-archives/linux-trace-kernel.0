Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ACF7211472
	for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 12:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739278492; cv=none; b=a3zukJzRVqIMsxyf11TZiUaf7lpBqMjAMcPvQH3gNdL9AgG+dly8CwVNpWA3EfvSyvLFuA4WUpbFrLfPk+7Wmn8+xAxNYZw0zr70KLS+R0cqjWi8I6uGeYx2Zx56++aEzY/Sy2CQmzagnmONmwTiTqsmUBuVS0hlXZn4aTF7uAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739278492; c=relaxed/simple;
	bh=9/PlZZ087KepjRQHJ3VVHaEYdxb4zzSBZ6SoPrn3umY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PepUgNDuvsCZ5eKBunJXJERfsw7H3pAXq00U9Zs66GuyXchuVyYHY5CQK803eAyc+fVxXfC+2iGF12bUsoBsuZkMzvYrU+JRHqCcRw44BWVoydTMVwhXrHlZhtPtCffspBWfO7Dt1yvdyZp1B91uxLOLKtIFhD83Tu9MH+2FUlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=E6F47hIs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E6F47hIs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739278489;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=fKSs+sLqCcJjgSUWDlfYHoF40v2TZb/Swx/+NmEL0Eo=;
	b=E6F47hIsB10bECQBFgSG0pFuQryoIMXfAkdU4GA8D7hbptIkPySQfKU0rZFJCHeqvNECLK
	5BKU33N7NaQWK/1o44Ze9RvF6DTZytRAMpNU2iMzP6OzTHyh9OfBatNfLNN4cxoNAEfyh1
	IiWY+EWzs+5P3kinTfnffZjMXtvHUwQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-395-TLwl_6N-Oyyoxw0QOU1bUg-1; Tue, 11 Feb 2025 07:54:48 -0500
X-MC-Unique: TLwl_6N-Oyyoxw0QOU1bUg-1
X-Mimecast-MFC-AGG-ID: TLwl_6N-Oyyoxw0QOU1bUg
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-43935bcec0aso22885675e9.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 11 Feb 2025 04:54:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739278487; x=1739883287;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fKSs+sLqCcJjgSUWDlfYHoF40v2TZb/Swx/+NmEL0Eo=;
        b=TosQzS8368ndnN1f3VNDwOSBp8KZThfDt+3V5PRaM3NDeRMS2W9ZVgN/wD5Rys5yOd
         /MVfE71vMyg6Rg+HabE5yXzryrKAly1HirthS4mq1Gj7A9IcjgjfQd/PrxhVbhJrXmB7
         QqiIgAtg8f9pI+E5e+VTrx0kFhrDf/XTU8U/8q6bCD/+TZ4xzSlJjKwwv4EdtD/eJldc
         t+C3J0xobzouyRvO8wEUhI/pSVdNmWR6EAxlNKIclttp1MtYRmVpVEwL9UcvujC+asQF
         CzLuGiWukPa43N+XLjAONGO/uqKoFVaP5mQ9GksQPJchdo2HxdR99c2kyY67E5Bh7Cxo
         CLsQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxzsYAsxakDKUgIAs9AGHu9C5XtD4BEUGy1TpvhW4AG0qqk+bnWDsRv2bBhQVUbPAfH3kyRC5Joi0RhHViy6tCwYg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw9vPTXBjcXY8IyyF5Lkb0o0CTw/MDe1NjAIgvgSTms7Uxn/0LF
	h+/R507LjSpIlnThSB2YhVEz3F6NiV2jPrZkQyIQI1FhnX9mGN+aQP/XcfiFVzAVtz7QKJsd6Ag
	LJdDxSnxoAH+MwkW3xvsTxEXgd47B4SzdAwGeaYQmS2uQG7Gm4A/RuIf4gzLajM93pK3zcA==
X-Gm-Gg: ASbGnctTw3Nbfcxn8rRMGv4H6hhuCkmDxz9lbsGnRgh07cMqytzvoTwRSdxvSc0GFs/
	B5NXP17dp7/kqDjW0mdGilhRq/hv4yfu/AzXAYLPKkTeGM5h32ZE7toTvGzvQwheYnQRJIsi8RN
	1QqIhbYFKPE4+ie3yEL8C+3ZYXZS0l5/i9ZPOQjQ5bl9r7/LmdozlHb/CG3bTzA1WaZi23lhBhJ
	W7XDdrRjk0q2GynE4DDDZR8oOSmyhepeBgYTSRZ/WJoD3pBLLPRB2urs/eeShK5MHddw5LDG5TP
	/xc6lzoBwYIYGSwKDPwNdWEZwmwEb7I=
X-Received: by 2002:a5d:5f87:0:b0:38d:d299:7097 with SMTP id ffacd0b85a97d-38dd29972c0mr10618815f8f.5.1739278487461;
        Tue, 11 Feb 2025 04:54:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZp1ePHnPvWuNhJt0biLJza5EiNgPbgTOxahfwLR6Xs5KoKVIGtLRIa46r3e5LWR4vGc3NdA==
X-Received: by 2002:a5d:5f87:0:b0:38d:d299:7097 with SMTP id ffacd0b85a97d-38dd29972c0mr10618792f8f.5.1739278487013;
        Tue, 11 Feb 2025 04:54:47 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38dcd8213f2sm11734502f8f.67.2025.02.11.04.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 04:54:46 -0800 (PST)
Message-ID: <56aad1c92224c624f7404c4ef6076a6ec7299b13.camel@redhat.com>
Subject: Re: [PATCH v1 03/11] sched: Add sched tracepoints for RV task model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, Ingo
 Molnar <mingo@redhat.com>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Juri Lelli <juri.lelli@redhat.com>
Date: Tue, 11 Feb 2025 13:54:44 +0100
In-Reply-To: <20250211110307.GE29593@noisy.programming.kicks-ass.net>
References: <20250211074622.58590-1-gmonaco@redhat.com>
		 <20250211074622.58590-4-gmonaco@redhat.com>
		 <20250211110307.GE29593@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 1_VgUY2BzMq3c7NS9MJgGuWyDUjg2rnFEKVs5SXuCrQ_1739278487
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-02-11 at 12:03 +0100, Peter Zijlstra wrote:
> On Tue, Feb 11, 2025 at 08:46:10AM +0100, Gabriele Monaco wrote:
>=20
> > diff --git a/include/linux/sched.h b/include/linux/sched.h
> > index 9632e3318e0d6..9ff0658095240 100644
> > --- a/include/linux/sched.h
> > +++ b/include/linux/sched.h
> > @@ -46,6 +46,7 @@
> > =C2=A0#include <linux/rv.h>
> > =C2=A0#include <linux/livepatch_sched.h>
> > =C2=A0#include <linux/uidgid_types.h>
> > +#include <linux/tracepoint-defs.h>
> > =C2=A0#include <asm/kmap_size.h>
> > =C2=A0
> > =C2=A0/* task_struct member predeclarations (sorted alphabetically): */
> > @@ -186,6 +187,12 @@ struct user_event_mm;
> > =C2=A0# define debug_rtlock_wait_restore_state() do { } while (0)
> > =C2=A0#endif
> > =C2=A0
> > +#define trace_set_current_state(state_value)=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 \
> > + do {=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 \
> > + if (tracepoint_enabled(sched_set_state_tp))=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 \
> > + do_trace_set_current_state(state_value); \
> > + } while (0)
>=20
> Yeah, this is much nicer, thanks!
>=20
> > =C2=A0/*
> > =C2=A0 * set_current_state() includes a barrier so that the write of
> > current->__state
> > =C2=A0 * is correctly serialised wrt the caller's subsequent test of
> > whether to
> > @@ -226,12 +233,14 @@ struct user_event_mm;
> > =C2=A0#define __set_current_state(state_value) \
> > =C2=A0 do { \
> > =C2=A0 debug_normal_state_change((state_value)); \
> > + trace_set_current_state(state_value); \
> > =C2=A0 WRITE_ONCE(current->__state, (state_value)); \
> > =C2=A0 } while (0)
> > =C2=A0
> > =C2=A0#define set_current_state(state_value) \
> > =C2=A0 do { \
> > =C2=A0 debug_normal_state_change((state_value)); \
> > + trace_set_current_state(state_value); \
> > =C2=A0 smp_store_mb(current->__state, (state_value)); \
> > =C2=A0 } while (0)
> > =C2=A0
> > @@ -247,6 +256,7 @@ struct user_event_mm;
> > =C2=A0 \
> > =C2=A0 raw_spin_lock_irqsave(&current->pi_lock, flags); \
> > =C2=A0 debug_special_state_change((state_value)); \
> > + trace_set_current_state(state_value); \
> > =C2=A0 WRITE_ONCE(current->__state, (state_value)); \
> > =C2=A0 raw_spin_unlock_irqrestore(&current->pi_lock, flags); \
> > =C2=A0 } while (0)
> > @@ -282,6 +292,7 @@ struct user_event_mm;
> > =C2=A0 raw_spin_lock(&current->pi_lock); \
> > =C2=A0 current->saved_state =3D current->__state; \
> > =C2=A0 debug_rtlock_wait_set_state(); \
> > + trace_set_current_state(TASK_RTLOCK_WAIT); \
> > =C2=A0 WRITE_ONCE(current->__state, TASK_RTLOCK_WAIT); \
> > =C2=A0 raw_spin_unlock(&current->pi_lock); \
> > =C2=A0 } while (0);
> > @@ -291,6 +302,7 @@ struct user_event_mm;
> > =C2=A0 lockdep_assert_irqs_disabled(); \
> > =C2=A0 raw_spin_lock(&current->pi_lock); \
> > =C2=A0 debug_rtlock_wait_restore_state(); \
> > + trace_set_current_state(TASK_RUNNING); \
> > =C2=A0 WRITE_ONCE(current->__state, current->saved_state); \
> > =C2=A0 current->saved_state =3D TASK_RUNNING; \
> > =C2=A0 raw_spin_unlock(&current->pi_lock); \
>=20
>=20
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index 165c90ba64ea9..9e33728bb57e8 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -491,6 +491,15 @@ sched_core_dequeue(struct rq *rq, struct
> > task_struct *p, int flags) { }
> > =C2=A0
> > =C2=A0#endif /* CONFIG_SCHED_CORE */
> > =C2=A0
> > +/* need a wrapper since we may need to trace from modules */
> > +EXPORT_TRACEPOINT_SYMBOL(sched_set_state_tp);
>=20
> _GPL
>=20
> > +
> > +void do_trace_set_current_state(int state_value)
> > +{
> > + trace_sched_set_state_tp(current, current->__state, state_value);
>=20
> Should this be:
>=20
>  __do_trace_sched_set_state_tp() ?
>=20

Mmh, you mean avoiding the static_branch_unlikely in the helper
function, since it's supposed to be used before calling it?

I checked all references of tracepoint-defs.h's tracepoint_enabled (the
macro actually doing this static_branch_unlikely) and it seems they
never use the __do_trace_ function but only call trace_, in fact
repeating the branch.

Your suggestion seems definitely cleaner but I wonder if that can have
unwanted consequences (we are exposing a function unconditionally
calling the tracepoint) and for that reason it was preferred not to do
it in all other occurrences?

I'm not sure if saving one branch would justify the change only in this
case. Thoughts?

> > +}
> > +EXPORT_SYMBOL(do_trace_set_current_state);
>=20
> _GPL
>=20

I'm absolutely not against this change but, out of curiosity, would
that imply non-GPL modules are not going to be able to sleep going
forward? At least not using this pattern.

Thanks,
Gabriele

