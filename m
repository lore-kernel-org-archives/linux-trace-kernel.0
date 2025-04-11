Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3C027C851
	for <linux-trace-kernel@vger.kernel.org>; Fri, 11 Apr 2025 06:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744351762; cv=none; b=o4ioMKngXikeQFRKdGZnXlGl/GRpWscGuvWy8VHdCMeFQcFAzMkNbntu5hyUnFymlVmozAJUCuV8Mocvm7LJqS4mQNnsZnC0h0vArXi6YYVpWAz1renKz6qVD288m0qP5JxVQBMEMRibWf3iOPEgAqPO0XuVjVyTNs9lYyvddnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744351762; c=relaxed/simple;
	bh=7xOe7YLJ+c1S1TE+g9wyRgV50RVmHxdWRr0nrRyzvB4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Wp6rLEnSYAjwx3xxRGZkTbpt6PJ1H2zVkbt0uA6HwEMiX06IXd7wmdI87VI2p/GIum8t8qfMNldqUYhrn4eNgQuvV3cC7RKHZD3IoYSIIGeJlM9DgFbobHHPHfboR2/1w9cRC629Ut8kEFm+4VhS4kG0zCld+61KuY+WcTrGVuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZDL8y9Dp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZDL8y9Dp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1744351757;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=7xOe7YLJ+c1S1TE+g9wyRgV50RVmHxdWRr0nrRyzvB4=;
	b=ZDL8y9Dp8T3gb8CaME4MQCwaxJKu8ZOmzw0EDOJOS73BdZ9TiYenp7IwyP9bFomwTHCOB7
	/WRBqT7Js5wXqpuqBGBwVm2zWz9GGKOOjDDz3KNDg47O5QfELz5PtR+Gwm0JREwT1AZTFJ
	fPs6I0Rk2ImwwBxGRZ4220eQp3x8MiE=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-9v6Mz1MYOkuJikA3vVCeCQ-1; Fri, 11 Apr 2025 02:09:15 -0400
X-MC-Unique: 9v6Mz1MYOkuJikA3vVCeCQ-1
X-Mimecast-MFC-AGG-ID: 9v6Mz1MYOkuJikA3vVCeCQ_1744351755
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-ac2a113c5d8so113555266b.1
        for <linux-trace-kernel@vger.kernel.org>; Thu, 10 Apr 2025 23:09:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744351755; x=1744956555;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bduNq/HDxv96vZuLWz4nrmlejiXvLwQ3iviE7jW85Lw=;
        b=B8fbNczm5SbbnWptd0C+Ek6d1tppraCf9Ze/lN4QOGEBB7CU6I2GC6aE60lhEYd7IA
         JkXpWIpyTbzhxnim7iSupXyv4UPMvbGAS3oLxcXZvXlTGgXgxE7hMDKEpwQF2l1aHaFr
         OT7ZGMO7FFmrge4CzKhiGG07Z4mA/fVUy4NyBdCqiHZS25jwWiJbbf68YgqgqqAk6G3A
         Kaeie+127Z90x16FNRYN4rk8s/qq9rSloZOLsaVNN3/fr6G9RkWBVPgy83Tbt1Vsxcn8
         lCB8yQReyRjv2+OG9mJrvjX8dENQn+Pvfe+1J7397CLe3OGhNC11VLVT4yIEnVgdqEoy
         CQYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXiE5u5jm3pAIlapKVuzVhHC/NbXbBa8Tx3J/bkd+HerMsC2KOKXfaJz1++3H1lEN+nAlKCiLA1wOkqgD2juGifa1A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzcmRzqpcSJKvocDWQnBEe8WpmBO6n1wgvdjiLzQdde8jf6SOoh
	3qWOgguH8hVaaB/enclMZHCfrpZtYDf6WxNUDyrRS9QTkc9zPpjR7CoeQW5hfP9V4lazyZvvHfj
	XNLDjywf6GvnyKOiIzDHqsOXMzFTu0iNIVsYrfJaQHToTkJXr5/xLheYLXn71pqK+t00tmg==
X-Gm-Gg: ASbGncuMdtULw7KpmhkojRezZnvaGPJ/ygTJaT2Qpkw/FwhUo5l2Xkm2k00TNnSNsus
	ves9cz3VboBsztsn78iezLJQCcrC2sBsNslOYuAhvAVKQaZBEhBB7eb9t4DoXgxKc84CNISYROl
	SG7AM7kvvo5A6kVnFrfkf/xflK+fGHJBevRT//sAYnOCjaauxCNidA5qoyGP69uV90Bg9Qrnxju
	ZhUGFaoPpr7+AgU55KSp13dnbIqDLNvy+1rDbHmFQSjC/qlMkvleO5KXDDFZPJBeesntQjWNQBQ
	bntxbjoBZmCtCp3fQ5bwt6bpJJY9OOCbtrVMc9U=
X-Received: by 2002:a17:906:f1d1:b0:aca:d649:72ea with SMTP id a640c23a62f3a-acad6497352mr59422466b.34.1744351754783;
        Thu, 10 Apr 2025 23:09:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGx5COGNoO1BzAij6r3Tq85m1WsO99uIIPdBpPpSn6yEkwUnzsBHgs3C0kwKICd4VlbxAtivw==
X-Received: by 2002:a17:906:f1d1:b0:aca:d649:72ea with SMTP id a640c23a62f3a-acad6497352mr59420366b.34.1744351754388;
        Thu, 10 Apr 2025 23:09:14 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.30])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-acaa1be941asm393302666b.54.2025.04.10.23.09.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Apr 2025 23:09:14 -0700 (PDT)
Message-ID: <360fe1770511702e35081e950bf2a362a4c092a8.camel@redhat.com>
Subject: Re: [RFC PATCH 7/9] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>
Date: Fri, 11 Apr 2025 08:09:12 +0200
In-Reply-To: <20250411045225.gP4DqmFt@linutronix.de>
References: <20250404084512.98552-11-gmonaco@redhat.com>
	 <20250404084512.98552-18-gmonaco@redhat.com>
	 <20250411045225.gP4DqmFt@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: Fz1FpTq4hb_deieSKiie-Rv-2i6JPbZlno9pP0UHg64_1744351755
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-04-11 at 06:52 +0200, Nam Cao wrote:
> On Fri, Apr 04, 2025 at 10:45:20AM +0200, Gabriele Monaco wrote:
> > DA monitor can be accessed from multiple cores simultaneously, this
> > is
> > likely, for instance when dealing with per-task monitors reacting
> > on
> > events that do not always occur on the CPU where the task is
> > running.
> > This can cause race conditions where two events change the next
> > state
> > and we see inconsistent values. E.g.:
> >=20
> > =C2=A0 [62] event_srs: 27: sleepable x sched_wakeup -> running (final)
> > =C2=A0 [63] event_srs: 27: sleepable x sched_set_state_sleepable ->
> > sleepable
> > =C2=A0 [63] error_srs: 27: event sched_switch_suspend not expected in
> > the state running
> >=20
> > In this case the monitor fails because the event on CPU 62 wins
> > against
> > the one on CPU 63, although the correct state should have been
> > sleepable, since the task get suspended.
> >=20
> > Detect if the current state was modified by using try_cmpxchg while
> > storing the next value. If it was, try again reading the current
> > state.
> > After a maximum number of failed retries, react as if it was an
> > error
> > with invalid current state (we cannot determine it).
> >=20
> > Monitors where this type of condition can occur must be able to
> > account
> > for racing events in any possible order, as we cannot know the
> > winner.
>=20
> Is locking not simpler? I understand raw_spin_lock() doesn't work
> because
> it steps on some tracepoints. But how about adding something like
> raw_spin_lock_notrace()?

It is probably simpler, but I think it would require also to disable
interrupts (some events occur in interrupt context), I'm not sure the
introduced overhead is going to be worth it in the fast path, but
that's kinda what I wanted to learn in this RFC ;)

>=20
> static inline bool raw_spin_lock_notrace(raw_spinlock_t *lock)
> {
> =09preempt_disable_notrace(); //probably not required,
> tracepoint handlers do this already
>=20
> =09if (!do_raw_spin_trylock(lock))
> =09=09do_raw_spin_lock(lock);
> }
>=20
> My LTL series theoretically also has this problem, but I have never
> got it
> during testing yet. We should use the same solution for both DA and
> LTL.

Yes totally, on the long run we might get some common utilities for
this kind of things that aren't too monitor specific. But for now I
wouldn't worry too much.

>=20
> Also, can you please Cc me in your RV patches?
>=20

Right.. will do!

Thanks for your feedback,
Gabriele

