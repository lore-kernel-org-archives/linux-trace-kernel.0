Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE581D5174
	for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 09:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787908290; cv=none; b=J53BCGBOUoOOqwmIwUKjMTLBJe8E0W52yOGXl+lpK7kNL9H5R9nxybj6v2HOoW3hp5l1CO1XL+ACYpXDgqaubt6uwLVficuCpQH6QXI8TeyaeW8lpew+EnebvQIdtVWhDMSn+FtzcKQntQRVCHWQ6giOgQmLlwl3aWUXqsKv1pI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787908290; c=relaxed/simple;
	bh=b+U7cn3LNu1FGedTPUHLANBYiG3eYn6urU4+klMFDHQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJKI1L1TmBzttqS/UTNHPnzh29is7c64A9h2ptW71t/65tC9FB3fMC79HXFGbXKVePbpSdGBe/Csj2VYOIOKiuFuaise/6lLKb+YezBTzBz7Vo2q+79N+WRZPVFiyV5eJu4+hlDhR1q5W+SxmAvCTy29BSBwF1V3j6egaeUgUW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H9vhs879; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H9vhs879"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1787908282;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=25XtApuwq2ZA1dZbUX/V4qJUq3my+EOfLECzRLiAZaY=;
	b=H9vhs879ERM7xpbpgZlq+yjs1esDS8zoo9HWqLK7zwXWGGCEzvER2YE+3mKuvCI6wrFpnj
	Lq0RK7M2O3cCDSAtqwG7AsA6PFl77tl2leQAKgCCwnmEUW+8jUkpXL6q0Z8mtI+k2UFRp/
	eS/HuYLAoPZadHV4f7D7amdTtvzZixk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-U3_ATndiP8iBF27AtunyUA-1; Fri, 28 Aug 2026 05:11:21 -0400
X-MC-Unique: U3_ATndiP8iBF27AtunyUA-1
X-Mimecast-MFC-AGG-ID: U3_ATndiP8iBF27AtunyUA_1787908280
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-c15e6109f9aso54509666b.2
        for <linux-trace-kernel@vger.kernel.org>; Fri, 28 Aug 2026 02:11:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787908280; x=1788513080;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=0aZFpNchYrZ7qGeMx+NpApsSK+QHS5XaUKDDTkM8vuM=;
        b=g4e7rN1DfNuH3xmENXHPQuCxkjz1Yqp4CTMoqQ0X9GBxvKkcevt6Q0LqUwzrEy+/1F
         iNNUfblKXV8Z7SQpTcq9C0xayJYnvH3ME/zjmn/KvZrztmZpS+/59scE+B8cDqg5bqmM
         GdfcM4u+dh6fkvMSIza/7THElkWbCXJjv6Z0N8FtQOxCFQKhCEPyPR7rlYc1pD6SKqaF
         m0lqEjtJZLQ52Q/MbuoF+KHZQQIB1y0shp4FiBtlDDyuMPr++nJ8VQBIzJw2bKmyWt90
         KGOIarZccr1fMJrwmYNrvvF3PzL/at7DM0lfvneId3i45kLzvIQuJ3hiPaQcvHJABgA6
         L47g==
X-Forwarded-Encrypted: i=1; AHgh+Rqgu4a5r5fUDM6ZathXm11HnvNwZtztv6ZODzBwCysQEwrTgvme6raiAyqxX+6YyFx4ufMYKwvILZG+2N0zH+5eEFk=@vger.kernel.org
X-Gm-Message-State: AFuF++mPnLl70XoZTEWUt6kSRagfcMngEXlUjbO2eyfozaTj+3O4APGH
	BVGHeaiScwkR28fgh5XArRgqJpyXqiZ/lDTU/rLaCfgznf9HVBH+1K5au1lgXO4qjCA9ilWWOK2
	yffFDUZWSRVreKsydclehDHclFHOljlbafBlZ1BOJgzOfw2VXlxsXwCu4nTYL2VMmHpumAqEfMg
	==
X-Gm-Gg: AR+sD12B5dFWey/sKUg2pPlZveLye8jqdvW107lICKlwPuencnFslcBjzhhQaPE0qI7
	7i4txvmjvSJ0RK1M3mCQIpHUC/VyP0ZRzSy+roEK3UoaPiqzrsOPIDI1+jDrIHGQL9CZ6066Dpe
	MA0G1yFGCqNB3y/O5r/Y/n3JY2rswimOQ08KBlEsZQr9mIHY2luJreQK/ms8YaBnGjv/cBFVAeV
	Zy+3ihI6HP4pY/R5kMuq7MvX8X+Nc5/SXRv4MXPCEwezPxDOBWr737kgkuetVGIZuBto8kbqGy9
	g9foy6C+kEh0+m05g7c2r85ZwZmoXxjBonH+8hoRhofF6UKS68aGBqZ74SqEttRDlFTh0vuldaj
	uaEnj4vbRXeTqxD6xOVkycOONivy8aqglBXdfJ+SYoKF/EKX9JRfGjNuiCVD2phLXquZ0ww==
X-Received: by 2002:a17:907:3cd3:b0:c1c:4a80:30c4 with SMTP id a640c23a62f3a-c25571814b2mr394157666b.11.1787908279713;
        Fri, 28 Aug 2026 02:11:19 -0700 (PDT)
X-Received: by 2002:a17:907:3cd3:b0:c1c:4a80:30c4 with SMTP id a640c23a62f3a-c25571814b2mr394151866b.11.1787908279114;
        Fri, 28 Aug 2026 02:11:19 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c255ee285b9sm57943666b.24.2026.08.28.02.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2026 02:11:18 -0700 (PDT)
Message-ID: <3783236cfa6496939c10555977e904daeeb774ff.camel@redhat.com>
Subject: Re: [PATCH v6 6/9] rv: Add tlob hybrid automaton monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Fri, 28 Aug 2026 11:11:17 +0200
In-Reply-To: <d8eb57e037881da2187c84fb9c8499f3acf04fb3.1787243842.git.wen.yang@linux.dev>
References: <cover.1787243842.git.wen.yang@linux.dev>
	 <d8eb57e037881da2187c84fb9c8499f3acf04fb3.1787243842.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: fiUwY-qJywuOoGRVOMRYCe5iMz7y2KjP4Y2E_d1Gcpw_1787908280
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2026-08-21 at 00:45 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> +
> +Description
> +-----------
> +
> +The tlob monitor tracks per-task elapsed wall-clock time (CLOCK_MONOTONI=
C,
> +spanning running, waiting, and sleeping states) and reports a violation =
when
> +the monitored task exceeds a configurable per-invocation budget threshol=
d.
> +
> +The monitor implements a four-state hybrid automaton with a single clock
> +environment variable ``clk_elapsed``.=C2=A0 The clock invariant
> +``clk_elapsed < BUDGET_NS()`` is active in the ``running``, ``waiting``,=
 and
> +``sleeping`` states (``stopped`` has no invariant, hence no timer); when=
 it
> +is violated the HA timer fires and the framework emits ``error_env_tlob`=
`
> +then calls ``da_monitor_reset()`` automatically::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (initial)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +----------=
----+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--------=
--+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=
=A0 running=C2=A0=C2=A0=C2=A0 | --------> |=C2=A0 stopped |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |->+--------------+ <--------=
 +----------+
> +=C2=A0=C2=A0 switch_in=C2=A0 preempt=C2=A0 sleep

This triggered my OCD ;)
Please fix the arrow waiting -> running:

+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +------------=
--+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +----------=
+
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0+->|=C2=A0=C2=A0 running=
=C2=A0=C2=A0=C2=A0 | --------> |=C2=A0 stopped |
+=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |  +--------------+ <-------- +=
----------+
+=C2=A0=C2=A0 switch_in=C2=A0 preempt=C2=A0 sleep

> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------+=C2=A0 +---------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | waiting |=C2=A0 | sleeping|
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +---------+=C2=A0 +---------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ^=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0 wakeup=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 +------------+
> +
> +=C2=A0 A fourth state, ``stopped``, has no clock invariant (hence no tim=
er).
> +=C2=A0 ``running`` reaches it on ``stop`` (``tlob_stop_task()``, window =
ended,
> +=C2=A0 per-task state parked rather than freed) and returns to ``running=
`` on
> +=C2=A0 ``start`` (``tlob_start_task()`` restarting the same task's parke=
d
> +=C2=A0 window).

So you define a pseudo-state "parked" that is essentially stopped but
after monitoring started (we allocated) and before the task exits (we
deallocate), is that right?
It looks kind of like an implementation detail rather than something
related to your model: there isn't any parked state in the model and you
don't need one.
If you really want the concept of parked to explain how you handle
allocation, perhaps you could make it clear in the code only.
For instance (if I got it right) when describing the
tlob_task_state->stopping you could say: tasks with this flag set are
"parked" until deallocation.

> +
> +=C2=A0 Key transitions:
> +=C2=A0=C2=A0=C2=A0 running=C2=A0 --(sleep)------> sleeping=C2=A0=C2=A0 (=
task blocks waiting for a resource)
> +=C2=A0=C2=A0=C2=A0 running=C2=A0 --(preempt)----> waiting=C2=A0=C2=A0=C2=
=A0 (task preempted, back in runqueue)
> +=C2=A0=C2=A0=C2=A0 sleeping --(wakeup)-----> waiting=C2=A0=C2=A0=C2=A0 (=
resource available, enters
> runqueue)
> +=C2=A0=C2=A0=C2=A0 waiting=C2=A0 --(switch_in)--> running=C2=A0=C2=A0=C2=
=A0 (scheduler picks task, back on CPU)
> +=C2=A0=C2=A0=C2=A0 running=C2=A0 --(stop)-------> stopped=C2=A0=C2=A0=C2=
=A0 (tlob_stop_task(): window ended,
> parked)
> +=C2=A0=C2=A0=C2=A0 stopped=C2=A0 --(start)------> running=C2=A0=C2=A0=C2=
=A0 (tlob_start_task(): window
> restarted)
> +
> +=C2=A0 ``tlob_start_task()`` calls ``da_handle_start_run_event(task->pid=
, ws,
> start_tlob)``.
> +=C2=A0 The ``start_tlob`` edge goes ``stopped`` -> ``running`` for both =
a fresh
> +=C2=A0 allocation (the initial state is ``stopped``) and a parked window=
's
> restart;
> +=C2=A0 there is no ``start`` self-loop on ``running`` (a running task's =
START is
> +=C2=A0 rejected with ``-EALREADY``).=C2=A0 The transition triggers
> ``ha_setup_invariants()``,
> +=C2=A0 which anchors ``clk_elapsed`` and arms the budget timer automatic=
ally.
> +=C2=A0 ``tlob_stop_task()`` cancels the HA timer synchronously
> +=C2=A0 via ``ha_cancel_timer_sync()``, then dispatches the ``stop_tlob``=
 event
> +=C2=A0 (running -> stopped) instead of resetting the monitor: the per-ta=
sk state
> +=C2=A0 is parked, not freed, so a later ``tlob_start_task()`` call for t=
he same
> +=C2=A0 task can restart it without reallocating.=C2=A0 Final teardown (t=
ask exit,
> +=C2=A0 uprobe unbind, or monitor disable) is what actually calls
> +=C2=A0 ``da_monitor_reset()`` and frees the state.

All allocation or broadly implementation details don't belong here. I
believe it's already clear from the model, but you may still stress that a
task can start another measuring window after the previous was stopped.

Being general about implementation in your documentation saves you some
headache while keeping that in sync (and I believe AIs make this problem
worse, by the way).

...
> +Kernel API
> +----------
> +
> +``tlob_start_task`` and ``tlob_stop_task`` are the implementation-level
> +functions called by the uprobe entry/exit handlers; the interface is
> +driven from userspace.
> +
> +.. kernel-doc:: kernel/trace/rv/monitors/tlob/tlob.c
> +=C2=A0=C2=A0 :functions: tlob_start_task tlob_stop_task

I remember mentioning this, there's no real kernel API, those functions
aren't exported nor meant to be called by anyone besides the model. I
would remove this section altogether.

...
> +++ b/kernel/trace/rv/monitors/tlob/Kconfig
> @@ -0,0 +1,12 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_TLOB
> +=09bool "tlob monitor"
> +=09depends on RV && UPROBES && HIGH_RES_TIMERS
> +=09select HA_MON_EVENTS_ID
> +=09select RV_UPROBE
> +=09help
> +=09=C2=A0 Enable the tlob (task latency over budget) hybrid-automaton RV
> +=09=C2=A0 monitor.=C2=A0 tlob tracks per-task elapsed wall-clock time ac=
ross a
> +=09=C2=A0 user-delimited code section and emits error_env_tlob when the

emits a violation when...

> +=09=C2=A0 elapsed time exceeds a configurable per-invocation budget.
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> new file mode 100644
> index 000000000000..08b1bee884cc
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
...
> +struct tlob_task_state {
> +=09struct task_struct=09*task;=09=09/* via get_task_struct */
> +=09u64=09=09=09threshold_ns;=09/* budget in nanoseconds */
> +
> +=09/*
> +=09 * Per-window: 1 =3D this window ended (stop or timer expiry).=C2=A0 =
Blocks
> +=09 * timer re-arm in ha_setup_invariants(); cleared on restart.
> +=09 */
> +=09atomic_t=09=09stopping;
> +
> +=09/*
> +=09 * Per-task, one-shot: final teardown has claimed this slot; never
> +=09 * reset (a window can end and restart, the task cannot).=C2=A0 atomi=
c_t
> +=09 * so cmpxchg is well-defined on every arch.
> +=09 */
> +=09atomic_t=09=09destroying;
> +
> +=09bool=09=09=09budget_exceeded;
> +
> +=09/*
> +=09 * Opaque owner: the binding that started this task.=C2=A0 Set once o=
n
> +=09 * fresh allocation (NULL for callers with no binding), cleared by
> +=09 * tlob_unbind_reap() for an active task whose binding is removed.
> +=09 * Immutable elsewhere.=C2=A0 Protected by tlob_ws_lock.
> +=09 */
> +=09void=09=09=09*binding;

Does this really need to be opaque? You're casting it anyway so I don't
see why it can't be a struct tlob_uprobe_binding * to begin with.

> +=09/*
> +=09 * Linked into binding->started_list for the whole lifetime (not just
> +=09 * while parked) so unbind reaping finds parked and active tasks.
> +=09 * Protected by tlob_ws_lock.
> +=09 */
> +=09struct list_head=09started_node;
> +
> +=09/* Serialises accs_ns[]; held briefly (hardirq-safe). */
> +=09raw_spinlock_t=09=09entry_lock;
> +=09u64=09=09=09accs_ns[TLOB_ACC_MAX]; /* per-state elapsed
> ns */
> +=09ktime_t=09=09=09last_ts;
> +
> +=09struct rcu_head=09=09rcu;
> +};
...
> +
> +/*
> + * Unlink ws from its binding's started_list before returning it to the =
pool.
> + * ws->binding is left stale: the next tlob_ws_alloc() memsets it, and t=
he
> + * restart path checks destroying first.=C2=A0 Idempotent (list_del_init=
 no-op).
> + */
> +static inline void tlob_detach_from_binding(struct tlob_task_state *ws)
> +{
> +=09if (!ws->binding)
> +=09=09return;

Should you access also the binding field under the lock?
And perhaps be set to NULL also here?

> +=09guard(spinlock)(&tlob_ws_lock);
> +=09list_del_init(&ws->started_node);
> +}
...
> +
> +/**
> + * tlob_start_task - begin monitoring @task with budget @threshold_ns ns=
.
> + * @task:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Task to monito=
r; may be current or another task.
> + * @threshold_ns: Budget in ns, in [1000, TLOB_MAX_THRESHOLD_NS].
> + * @binding:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opaque owner, recorded on fre=
sh allocation and checked for
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 an exact match on restart; NULL for callers that neve=
r
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 restart a parked window.
> + *
> + * Allocates a fresh entry if @task has none, or restarts a parked entry=
 in
> + * place when @binding matches (see tlob.dot: "start" fires from both
> + * running and stopped).
> + *
> + * Returns 0, -ENODEV, -ERANGE, -EALREADY, -ESRCH, or -ENOSPC (fresh sta=
rt
> + * past pool capacity).
> + */
> +static int tlob_start_task(struct task_struct *task, u64 threshold_ns, v=
oid
> *binding)
> +{
> +=09struct tlob_task_state *ws;
> +
> +=09if (!da_monitor_enabled())
> +=09=09return -ENODEV;
> +
> +=09if (threshold_ns < TLOB_MIN_THRESHOLD_NS ||
> +=09=C2=A0=C2=A0=C2=A0 threshold_ns > TLOB_MAX_THRESHOLD_NS)
> +=09=09return -ERANGE;
> +
> +=09/* Serialise duplicate-check + pool-slot claim; see tlob_ws_lock. */
> +=09guard(spinlock)(&tlob_ws_lock);
> +
> +=09/*
> +=09 * da_get_target_by_id() uses hash_for_each_possible_rcu(), which
> +=09 * requires an RCU read-side critical section.
> +=09 */
> +=09scoped_guard(rcu) {
> +=09=09ws =3D da_get_target_by_id(task->pid);
> +=09=09if (ws) {
> +=09=09=09if (!atomic_read(&ws->stopping))
> +=09=09=09=09return -EALREADY;
> +=09=09=09if (atomic_read(&ws->destroying))
> +=09=09=09=09return -ESRCH;
> +=09=09=09/*
> +=09=09=09 * Exact match only.=C2=A0 An orphaned parked ws (binding
> +=09=09=09 * cleared while active, then parked) is not adopted:
> +=09=09=09 * that would need re-linking into the new binding's
> +=09=09=09 * started_list.=C2=A0 Accepted gap; the slot is reclaimed
> +=09=09=09 * at task exit.
> +=09=09=09 */
> +=09=09=09if (ws->binding !=3D binding)
> +=09=09=09=09return -EALREADY;
> +
> +=09=09=09/* Restart in place: same slot, hash entry, task ref,
> list node. */
> +=09=09=09ws->threshold_ns =3D threshold_ns;
> +=09=09=09WRITE_ONCE(ws->budget_exceeded, false);
> +=09=09=09memset(ws->accs_ns, 0, sizeof(ws->accs_ns));
> +=09=09=09ws->last_ts =3D ktime_get();
> +
> +=09=09=09/*
> +=09=09=09 * Keep stopping set: __tlob_acc() gates out sched
> +=09=09=09 * events until ha_setup_invariants() clears it after
> +=09=09=09 * the state is running_tlob.=C2=A0 Clearing here would
> let
> +=09=09=09 * events hit stopped_tlob (INVALID transitions).
> +=09=09=09 */
> +
> +=09=09=09/* Only failure here: monitor disabled since the
> check above. */
> +=09=09=09if (!da_handle_start_run_event(task->pid, ws,
> start_tlob))
> +=09=09=09=09return -ENODEV;
> +=09=09=09return 0;
> +=09=09}
> +=09}
> +
> +=09ws =3D tlob_ws_alloc();
> +=09if (!ws)
> +=09=09return -ENOSPC;
> +
> +=09ws->task =3D task;
> +=09get_task_struct(task);
> +=09ws->threshold_ns =3D threshold_ns;
> +=09ws->last_ts =3D ktime_get();
> +=09raw_spin_lock_init(&ws->entry_lock);
> +=09ws->binding =3D binding;
> +=09if (binding)
> +=09=09list_add_tail(&ws->started_node,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &((struct tlob_uprobe_binding *)=
binding)-
> >started_list);

Why do you add to the list and then remove if start failed? Is the
binding needed when the model does it's job?
Cannot you just do all that after only if the start passed?

Also, can binding really be NULL ?

> +
> +=09/* Dispatch failed (pool exhausted or monitor disabled): unwind the
> slot. */
> +=09if (!da_handle_start_run_event(task->pid, ws, start_tlob)) {
> +=09=09if (binding)
> +=09=09=09list_del_init(&ws->started_node);
> +=09=09/* stopping=3D1 short-circuits the reset hook; destroy before
> freeing ws. */
> +=09=09atomic_set(&ws->stopping, 1);
> +=09=09da_destroy_storage(task->pid);
> +=09=09put_task_struct(task);
> +=09=09tlob_ws_direct_return(ws);
> +=09=09return -ENOSPC;
> +=09}
> +
> +=09return 0;
> +}
> +
> +/**
> + * tlob_stop_task - end the current monitoring window for @task.
> + * @task: Task to stop.
> + * @binding: Opaque owner; must match ws->binding to end a normal (uprob=
e)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 window.=
=C2=A0 NULL (task exit) skips the check.
> + *
> + * Ends the window (dispatches "stop") but does NOT free the entry: it s=
tays
> + * parked so a later tlob_start_task() can restart it.=C2=A0 Call
> + * tlob_destroy_task() once @task will never restart.
> + *
> + * cmpxchg on stopping (0->1) under RCU claims ownership; the winner can=
cels
> + * the timer synchronously.
> + *
> + * Returns 0, -EOVERFLOW (budget exceeded), -ESRCH (not monitored),
> + * -EAGAIN (window already ended), or -EALREADY (owned by another bindin=
g).
> + */
> +static int tlob_stop_task(struct task_struct *task, void *binding)
> +{
> +=09struct ha_monitor *ha_mon;
> +=09struct tlob_task_state *ws;
> +=09bool budget_exceeded;
> +
> +=09scoped_guard(rcu) {
> +=09=09ha_mon =3D ha_get_monitor(task->pid, NULL);
> +=09=09if (!ha_mon)
> +=09=09=09return -ESRCH;
> +
> +=09=09ws =3D ha_get_target(ha_mon);
> +=09=09if (WARN_ON_ONCE(!ws))
> +=09=09=09return -ESRCH;
> +
> +=09=09/* Only the binding that opened the window may end it; NULL
> +=09=09 * (task exit) skips the check.=C2=A0 Symmetric with the restart
> +=09=09 * check in tlob_start_task(). */

The format of this comment is wrong (break the line after /* on
multi-line comments).

> +=09=09if (binding && ws->binding !=3D binding)
> +=09=09=09return -EALREADY;
> +
> +=09=09/* cmpxchg (0->1) claims the window under RCU; _release pairs
> +=09=09 * with the acquire in ha_setup_invariants(). */

Same here and probably somewhere else, please check around.

> +=09=09if (atomic_cmpxchg_release(&ws->stopping, 0, 1) !=3D 0)
> +=09=09=09return -EAGAIN;
> +
> +=09=09/*
> +=09=09 * ws may be destroyed concurrently (unbind -> call_rcu), so
> +=09=09 * keep its access under RCU; dispatch re-looks-up under RCU.
> +=09=09 */

This is the correct format.
Although I wonder: if we need a multi-line comment on each line, aren't
we perhaps overdoing it? cmpxchg (0->1) is documented at the function
level, it's probably enough to leave it there.

Also this specific comment has little to do with the lines that come
after. Prefer function level documentation where possible.
If a function is very large (and you're convinced that's fine),
you can document some non-trivial steps as brief as possible.

> +=09=09ha_cancel_timer_sync(ha_mon);
> +=09=09budget_exceeded =3D READ_ONCE(ws->budget_exceeded);
> +=09}
> +
> +=09/* running -> stopped: no reset or destroy, the entry stays parked.
> */
> +=09da_handle_event(task->pid, NULL, stop_tlob);
> +
> +=09return budget_exceeded ? -EOVERFLOW : 0;
> +}
> +
> +/*
> + * tlob_destroy_task - final teardown for @task's entry: frees the pool =
slot,

Double line break after the : and continue with the long description.
It's fine not writing a full-blown kernel-doc, but you can do better
here (exactly like you do in tlob_unbind_reap).

> + * drops the task_struct ref, removes the hash entry, whether active or
> parked.
> + * Idempotent via the destroying cmpxchg (same pattern as
> tlob_extra_cleanup()).
> + * Callers must end the window first (see handle_sched_process_exit()).
> + */
> +static void tlob_destroy_task(struct task_struct *task)
> +{
> +=09struct ha_monitor *ha_mon;
> +=09struct tlob_task_state *ws;
> +
> +=09scoped_guard(rcu) {
> +=09=09ha_mon =3D ha_get_monitor(task->pid, NULL);
> +=09=09if (!ha_mon)
> +=09=09=09return;
> +=09=09ws =3D ha_get_target(ha_mon);
> +=09=09if (WARN_ON_ONCE(!ws))
> +=09=09=09return;
> +=09=09if (atomic_cmpxchg_release(&ws->destroying, 0, 1) !=3D 0)
> +=09=09=09return;
> +=09}
> +
> +=09tlob_detach_from_binding(ws);
> +
> +=09/* Force the window ended: @task may never have reached STOP or a
> timer. */
> +=09atomic_set(&ws->stopping, 1);
> +=09ha_cancel_timer_sync(ha_mon);
> +
> +=09scoped_guard(rcu) {
> +=09=09da_monitor_reset(&ha_mon->da_mon);
> +=09}
> +=09da_destroy_storage(task->pid);
> +
> +=09put_task_struct(ws->task);
> +=09call_rcu(&ws->rcu, tlob_ws_return_cb);
> +}
> +
> +static int tlob_uprobe_entry_handler(struct uprobe_consumer *self,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data)
> +{
> +=09struct tlob_uprobe_binding *b =3D
> +=09=09container_of(self, struct tlob_uprobe_binding,
> start_probe.uc);
> +
> +=09tlob_start_task(current, b->threshold_ns, b);
> +=09return 0;
> +}
> +
> +static int tlob_uprobe_stop_handler(struct uprobe_consumer *self,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data)
> +{
> +=09struct tlob_uprobe_binding *b =3D
> +=09=09container_of(self, struct tlob_uprobe_binding,
> stop_probe.uc);
> +
> +=09tlob_stop_task(current, b);
> +=09return 0;
> +}
> +
> +/*
> + * Register start + stop entry uprobes for a binding.
> + * Called with tlob_uprobe_mutex held.
> + */
> +static int tlob_add_uprobe(u64 threshold_ns, const char *binpath,
> +=09=09=09=C2=A0=C2=A0 loff_t offset_start, loff_t offset_stop)
> +{
> +=09struct tlob_uprobe_binding *tmp_b;
> +=09char pathbuf[TLOB_MAX_PATH];
> +=09struct inode *inode;
> +=09struct path path __free(path_put) =3D {};
> +=09char *canon;
> +=09int ret;
> +
> +=09if (binpath[0] !=3D '/')
> +=09=09return -EINVAL;
> +
> +=09struct tlob_uprobe_binding *b __free(kfree) =3D kzalloc_obj(*b,
> GFP_KERNEL);
> +=09if (!b)
> +=09=09return -ENOMEM;
> +
> +=09b->threshold_ns =3D threshold_ns;
> +=09b->offset_start =3D offset_start;
> +=09b->offset_stop=C2=A0 =3D offset_stop;
> +=09INIT_LIST_HEAD(&b->started_list);
> +
> +=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &path);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (!d_is_reg(path.dentry))
> +=09=09return -EINVAL;
> +
> +=09inode =3D d_real_inode(path.dentry);
> +
> +=09/* Reject duplicate start offset for the same binary inode. */
> +=09list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
> +=09=09if (tmp_b->offset_start =3D=3D offset_start &&
> +=09=09=C2=A0=C2=A0=C2=A0 rv_uprobe_is_registered(&tmp_b->start_probe) &&
> +=09=09=C2=A0=C2=A0=C2=A0 d_real_inode(tmp_b->start_probe.path.dentry) =
=3D=3D inode)
> +=09=09=09return -EEXIST;
> +=09}
> +
> +=09canon =3D d_path(&path, pathbuf, sizeof(pathbuf));
> +=09if (IS_ERR(canon))
> +=09=09return PTR_ERR(canon);
> +=09strscpy(b->binpath, canon, sizeof(b->binpath));
> +
> +=09b->start_probe.uc.handler =3D tlob_uprobe_entry_handler;
> +=09ret =3D rv_uprobe_register(b->binpath, offset_start, &b->start_probe)=
;
> +=09if (ret)
> +=09=09return ret;
> +
> +=09b->stop_probe.uc.handler =3D tlob_uprobe_stop_handler;
> +=09ret =3D rv_uprobe_register(b->binpath, offset_stop, &b->stop_probe);
> +=09if (ret) {
> +=09=09rv_uprobe_unregister(&b->start_probe);
> +=09=09return ret;
> +=09}
> +
> +=09/* NOT "b =3D no_free_ptr(b)": the re-assignment would free the live
> node. */

This comment feels like an AI tried the wrong way to use no_free_ptr and
left it not to make the same mistake again, we don't need it.

> +=09list_add_tail(&no_free_ptr(b)->list, &tlob_uprobe_list);
> +=09return 0;
> +}
> +
> +/*
> + * tlob_unbind_reap - detach every task @b started, destroy the parked o=
nes.
> + *
> + * Caller must have unregistered @b's uprobes and called rv_uprobe_sync(=
):
> + * no start/stop can then be in flight for @b, so started_list is safe t=
o
> + * walk.=C2=A0 Active tasks are detached (binding cleared) and left runn=
ing,
> + * matching unbind behaviour today; parked tasks are destroyed, or their
> + * pool slot leaks until the task next exits.
> + */
> +static void tlob_unbind_reap(struct tlob_uprobe_binding *b)
> +{
> +=09struct tlob_task_state *ws, *tmp;
> +=09LIST_HEAD(to_destroy);
> +
> +=09scoped_guard(spinlock, &tlob_ws_lock) {
> +=09=09list_for_each_entry_safe(ws, tmp, &b->started_list,
> started_node) {
> +=09=09=09list_del_init(&ws->started_node);
> +=09=09=09ws->binding =3D NULL;
> +=09=09=09if (atomic_read(&ws->stopping))
> +=09=09=09=09list_add_tail(&ws->started_node,
> &to_destroy);
> +=09=09}
> +=09}
> +
> +=09list_for_each_entry_safe(ws, tmp, &to_destroy, started_node) {
> +=09=09list_del_init(&ws->started_node);
> +=09=09tlob_destroy_task(ws->task);
> +=09}
> +}
> +
> +static int tlob_remove_uprobe_by_key(loff_t offset_start, const char
> *binpath)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp;
> +=09struct path remove_path;
> +=09struct inode *inode;
> +=09int ret;
> +
> +=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &remove_path);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09inode =3D d_real_inode(remove_path.dentry);
> +
> +=09ret =3D -ENOENT;
> +=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
> +=09=09if (b->offset_start !=3D offset_start)
> +=09=09=09continue;
> +=09=09if (d_real_inode(b->start_probe.path.dentry) !=3D inode)
> +=09=09=09continue;
> +=09=09list_del(&b->list);
> +=09=09/*
> +=09=09 * rv_uprobe_sync() may sleep; list_del() already made the
> +=09=09 * binding invisible to new readers.
> +=09=09 */
> +=09=09rv_uprobe_unregister_nosync(&b->start_probe);
> +=09=09rv_uprobe_unregister_nosync(&b->stop_probe);
> +=09=09rv_uprobe_sync();
> +=09=09tlob_unbind_reap(b);
> +=09=09path_put(&b->start_probe.path);
> +=09=09path_put(&b->stop_probe.path);
> +=09=09kfree(b);
> +=09=09ret =3D 0;
> +=09=09break;
> +=09}
> +
> +=09path_put(&remove_path);

Just for consistency I would use __free(path_put) also for this. But you
don't have to if you prefer this way.

> +=09return ret;
> +}
...
> +/*
> + * Parse "p PATH:OFFSET_START OFFSET_STOP threshold=3DNS".
> + * PATH may contain ':'; the last ':' separates path from offset.
> + * Returns 0, -EINVAL, or -ERANGE.
> + */
> +VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 char **path_out,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 loff_t *start_out, loff_t
> *stop_out)

These VISIBLE_IF_KUNIT stuff are left from the previous implementation
and removed from the KUnit patch, they shouldn't be here.

> +{
> +=09unsigned long long thr =3D 0, stop_val =3D 0;
> +=09long long start_val;
> +=09char *p, *path_token, *token, *colon;
> +=09bool got_stop =3D false, got_thr =3D false;
> +=09int n;
> +
> +=09/* Must start with "p " */
> +=09if (buf[0] !=3D 'p' || buf[1] !=3D ' ')
> +=09=09return -EINVAL;
> +
> +=09p =3D buf + 2;
> +=09while (*p =3D=3D ' ')
> +=09=09p++;
> +
> +=09/* First space-delimited token is PATH:OFFSET_START */
> +=09path_token =3D strsep(&p, " \t");
> +=09if (!path_token || !*path_token)
> +=09=09return -EINVAL;
> +
> +=09/* Split at last ':' to handle paths that contain ':'. */
> +=09colon =3D strrchr(path_token, ':');
> +=09if (!colon || colon - path_token < 2)
> +=09=09return -EINVAL;
> +=09*colon =3D '\0';
> +
> +=09if (path_token[0] !=3D '/')
> +=09=09return -EINVAL;
> +
> +=09n =3D 0;
> +=09if (sscanf(colon + 1, "%lli%n", &start_val, &n) !=3D 1 || n =3D=3D 0)
> +=09=09return -EINVAL;
> +=09if (start_val < 0)
> +=09=09return -EINVAL;
> +
> +=09/* Remaining tokens: OFFSET_STOP threshold=3DNS */
> +=09while (p && (token =3D strsep(&p, " \t")) !=3D NULL) {
> +=09=09if (!*token)
> +=09=09=09continue;
> +=09=09if (strncmp(token, "threshold=3D", 10) =3D=3D 0) {
> +=09=09=09if (kstrtoull(token + 10, 0, &thr))
> +=09=09=09=09return -EINVAL;
> +=09=09=09if (thr < TLOB_MIN_THRESHOLD_NS || thr >
> TLOB_MAX_THRESHOLD_NS)
> +=09=09=09=09return -ERANGE;
> +=09=09=09got_thr =3D true;
> +=09=09} else if (!got_stop) {
> +=09=09=09long long sv;
> +
> +=09=09=09n =3D 0;
> +=09=09=09if (sscanf(token, "%lli%n", &sv, &n) !=3D 1 || n =3D=3D 0)
> +=09=09=09=09return -EINVAL;
> +=09=09=09if (sv < 0)
> +=09=09=09=09return -EINVAL;
> +=09=09=09stop_val =3D (unsigned long long)sv;
> +=09=09=09got_stop =3D true;
> +=09=09} else {
> +=09=09=09return -EINVAL;
> +=09=09}
> +=09}
> +
> +=09if (!got_stop || !got_thr)
> +=09=09return -EINVAL;
> +=09if (start_val =3D=3D (long long)stop_val)
> +=09=09return -EINVAL;
> +
> +=09*thr_out=C2=A0=C2=A0 =3D thr;
> +=09*path_out=C2=A0 =3D path_token;
> +=09*start_out =3D (loff_t)start_val;
> +=09*stop_out=C2=A0 =3D (loff_t)stop_val;
> +=09return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_parse_uprobe_line);

Same with these.

> +
> +/*
> + * Parse "-PATH:OFFSET_START" (ftrace uprobe_events removal convention).
> + */
> +VISIBLE_IF_KUNIT int tlob_parse_remove_line(char *buf, char **path_out,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 loff_t *start_out)

And here.

> +{
> +=09char *binpath, *colon;
> +=09long long off;
> +=09int n =3D 0;
> +
> +=09if (buf[0] !=3D '-')
> +=09=09return -EINVAL;
> +=09binpath =3D buf + 1;
> +=09if (binpath[0] !=3D '/')
> +=09=09return -EINVAL;
> +=09colon =3D strrchr(binpath, ':');
> +=09if (!colon || colon - binpath < 2)
> +=09=09return -EINVAL;
> +=09*colon =3D '\0';
> +=09if (sscanf(colon + 1, "%lli%n", &off, &n) !=3D 1 || n =3D=3D 0)
> +=09=09return -EINVAL;
> +=09if (off < 0)
> +=09=09return -EINVAL;
> +=09*path_out=C2=A0 =3D binpath;
> +=09*start_out =3D (loff_t)off;
> +=09return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_parse_remove_line);

And here.

> +
> +static int tlob_create_or_delete_uprobe(char *buf)
> +{
> +=09loff_t offset_start, offset_stop;
> +=09u64 threshold_ns;
> +=09char *binpath;
> +=09int ret;
> +
> +=09if (buf[0] =3D=3D '-') {
> +=09=09ret =3D tlob_parse_remove_line(buf, &binpath, &offset_start);
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09=09mutex_lock(&tlob_uprobe_mutex);
> +=09=09ret =3D tlob_remove_uprobe_by_key(offset_start, binpath);
> +=09=09mutex_unlock(&tlob_uprobe_mutex);

It's probably more readable if you take this locks inside the functions.

I'd just put a guard (not scoped) from the first point where it seems
needed and let it be (e.g. just before list_for_each_entry_safe).
You don't need to be overly precise at the cost of readability since
this isn't a hot path.

> +=09=09return ret;
> +=09}
> +=09ret =3D tlob_parse_uprobe_line(buf, &threshold_ns, &binpath,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &offset_start, &offset_stop);
> +=09if (ret)
> +=09=09return ret;
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09ret =3D tlob_add_uprobe(threshold_ns, binpath, offset_start,
> offset_stop);
> +=09mutex_unlock(&tlob_uprobe_mutex);

Same here, you can guard-lock before list_for_each_entry.

> +=09return ret;
> +}

Implementation looks good otherwise and seems to work as far as I could
test.

Thanks,
Gabriele

