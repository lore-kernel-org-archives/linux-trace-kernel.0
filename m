Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61AB9233148
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 15:09:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752678592; cv=none; b=iJGA6yxXNJg0pma+coM4UJP7OV8a5VuxS1nJcbWTYVinyugBvgS3ntNL32KD7xpQR5G/eX3m2GGxzC1mU3itX46wXlw7uMRD2gaatMOP0PyIRgOAHL/9SkvAzzP1bD4MAuoqMEUdKZZRrDW/FNZufRUIHEsNWx8KpIPVl6/BxMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752678592; c=relaxed/simple;
	bh=64J9ckrYWsYKtc4CtYsoILnHYb8g4vUVJpysmTKfTag=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ef9yjfNXrxSJha2n2ke7rms0hKnItBLgR7NKOmRkiTSJHdKzNyFtYYS2NmBOpwWqCmzyBF/PgJOeSmqEtHyVz+MPiQHkTQWSooS5NkolkH4fctARSI8YDgUDp/8hzVTyLfzBCo6MpB6mMQ+DMZLBo0GmG9xwIz8U8/Ptf4vOi6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KtMNtrOz; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KtMNtrOz"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752678589;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=64J9ckrYWsYKtc4CtYsoILnHYb8g4vUVJpysmTKfTag=;
	b=KtMNtrOzo1THqzGrdgVi3lQD+6tdJwiip8OWabcNnR83xrS8LipmBQ9Nhc3nhsdyc2vpZf
	jqqB+783CGEzSFf9raqkNNqsCPu1KJREe/dfpXlbPBOt+F/VlzMRJg+ifD3HPCcFO99HtH
	HZ42rKD4zXSxLS/aheKLtyqfQGyYoJM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-hlKbl0VfNZWRfbbUIfu09w-1; Wed, 16 Jul 2025 11:09:47 -0400
X-MC-Unique: hlKbl0VfNZWRfbbUIfu09w-1
X-Mimecast-MFC-AGG-ID: hlKbl0VfNZWRfbbUIfu09w_1752678587
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a50816ccc6so4132363f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:09:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752678586; x=1753283386;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s60Sp6skjO7MztEg1NVdWh+PMYIugCHc0j0VBqr0PaY=;
        b=PqzbKwhpaufYkpwCUyPWeESr6lGTv4JvVOc8BfA5iw6eHijhzQH/jnSgeiMhbPRi6R
         TUR1Qt7qQCEzS2tqlQKkdNNUeoeEJlfUR1Gb7xMH3PcOmqrrhLugirVd2t53HlfL49w7
         riJozpiLvoc/pMvBbvoeQEcgmYnieYX/Aur+5VGuznB6K+Y8TtR02S6vhsja98lS41qV
         csUaLLy6mSO5MPukpuPiIU/4e6/vM8hBS+BLqG8obyKYShzGmd/XKkIjnP3UWL0Su7G1
         Y96ee96y+eaZ3pKi6PO3bzQShlUsPL9h2l9NFosK28xg17tDa+FsxbESuY7vIXFmZlkh
         KYjw==
X-Forwarded-Encrypted: i=1; AJvYcCXX9m1Kr9a1gsSB36r9qSCTSlTblKJQQeLEz/jcU7RRY9zFShGq2OVJV6y6M+q5q39aHWmG6QDVGeCHxPzUUDw+KHY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxvGozs9TT1UkjqwY1sILW30TQMT5+pEsovXPeYw5wPIeqbBlYJ
	xzE63wM5m7qh1NEENjQWJnX44Ul5C28mKetIAMSTBjmfWWuoEjXOL7mmI3UhNx8qTt1YwmLrpnb
	opdGbVLyI445txKxwCAOcCdEJ0N1OtvYfUoq+KvSSGMpeP5mw/JKua9swCI/njFAiJ40Ng6rw/A
	==
X-Gm-Gg: ASbGncso9Uq938uYv9QW611DBPpdRWYJcBoCxA/LZHi4JUGfxNtuoXo9iBf1CdSURzv
	WHkXW3PhyplhxYmi5OPPhm6OLO8zJurZUM5jcwX1l4t4GPpele+9kadS6ScKxxbeua4aN3iF/UX
	lZVRho1Kmw5rJraselmA2MeTF+33o4vgG8Zxbs/f9NMWpAEQQtcgUeFGpZQZooqFJC255tMcuHw
	fmHZ+xpscAL1Hr+n+oaju6KItRFFB6eq5+Si3bD5HFMYC1FYA9LOQkG8zSzfkG3cVEVCQWzZiTK
	6IbVS7f4kbwW217JEASLm6ndNPfC5k6lGkbbnHCxv3SnNWEXebZe7B9I2Ux9Ujhr8g==
X-Received: by 2002:a5d:5f4e:0:b0:3b5:e6c0:1678 with SMTP id ffacd0b85a97d-3b60e52451dmr2476736f8f.45.1752678586310;
        Wed, 16 Jul 2025 08:09:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF8tq87kRXSdlB+5Kbof387zmqH3pRO5qbk4swo5Gnn+EKJzZUxNtFjV0EHj+7pRXCTD5Wz/A==
X-Received: by 2002:a5d:5f4e:0:b0:3b5:e6c0:1678 with SMTP id ffacd0b85a97d-3b60e52451dmr2476719f8f.45.1752678585835;
        Wed, 16 Jul 2025 08:09:45 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8dc2147sm18242526f8f.32.2025.07.16.08.09.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 08:09:45 -0700 (PDT)
Message-ID: <cbb840b204f7de7e6304bc811e9c629eb0f77486.camel@redhat.com>
Subject: Re: [PATCH v3 12/17] sched: Adapt sched tracepoints for RV task
 model
From: Gabriele Monaco <gmonaco@redhat.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Steven
 Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	linux-trace-kernel@vger.kernel.org, Nam Cao <namcao@linutronix.de>, Tomas
 Glozar	 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams	 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 17:09:43 +0200
In-Reply-To: <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-13-gmonaco@redhat.com>
	 <20250716123832.GW1613200@noisy.programming.kicks-ass.net>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: hb_qXCvX0T_GAUsaUHHgKrIb7rnuSzfNsjR0aisHQ38_1752678587
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2025-07-16 at 14:38 +0200, Peter Zijlstra wrote:
> On Tue, Jul 15, 2025 at 09:14:29AM +0200, Gabriele Monaco wrote:
> > Add the following tracepoints:
> > * sched_set_need_resched(tsk, cpu, tif)
> > =C2=A0=C2=A0=C2=A0 Called when a task is set the need resched [lazy] fl=
ag
> > * sched_switch_vain(preempt, tsk, tsk_state)
> > =C2=A0=C2=A0=C2=A0 Called when a task is selected again during __schedu=
le
> > =C2=A0=C2=A0=C2=A0 i.e. prev =3D=3D next =3D=3D tsk : no real context s=
witch
>=20
> > @@ -6592,6 +6598,7 @@ static bool try_to_block_task(struct rq *rq,
> > struct task_struct *p,
> > =C2=A0=09int flags =3D DEQUEUE_NOCLOCK;
> > =C2=A0
> > =C2=A0=09if (signal_pending_state(task_state, p)) {
> > +=09=09trace_sched_set_state_tp(p, TASK_RUNNING, true);
> > =C2=A0=09=09WRITE_ONCE(p->__state, TASK_RUNNING);
> > =C2=A0=09=09*task_state_p =3D TASK_RUNNING;
> > =C2=A0=09=09return false;
>=20
> I'm confused on the purpose of this. How does this relate to say the
> wakeup in signal_wake_up_state() ?

Also this adds more context: models like sssw (in this series) expect
that, after a task is set to sleepable, it either goes to sleep or is
woken up/set to runnable.

In this specific case, the task is set to runnable without tracing it,
so the model doesn't know what happened, since it may not see a wakeup
after that (the task is already runnable).

Now I'm not sure if there are other events that we are guaranteed to
see to reconstruct this specific case (at some point we should see the
signal, I assume).
This just simplified things as that is the only state change that was
not traced.

Am I missing anything obvious here?

Thanks,
Gabriele

