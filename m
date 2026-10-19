Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64B314D98EB
	for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792406594; cv=none; b=O7raXZNSBowIMWADdYkEiWxyDi/YeN18JCDycmDJGdb/P7ZVosobCvcVTzKXymavlC2LnLTnDqQll6LQdJ5mJ2NauPx8cNvp/ONZt/U/pYe9kuMgi8YN4u/izJnz5IwpGenKgZFcbGiH+Md2u9KlzUwic/fT61hehfgu6rSaFu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792406594; c=relaxed/simple;
	bh=uYkeqd5tBLFGk1jwj1eJ0IFGnUKsublCpH2CcRrIi/E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=raKoWJaRAKPeM/d0D2o+5cdktF54EmRCT/q7jmQMjhInTiVOLrEq4MoiYc3bZP8YhcxJC3uqQC5EjG/W2d6CMCTcBYsl5UVvFNC0+bDtwSFjfZsga6yGSX1LjpKXzfWMcmWAG7mF002bBSb7TVWS7rTGH0afN6NK3Yc3SxiacvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jSqSaF7I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jSqSaF7I"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792406592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=uYkeqd5tBLFGk1jwj1eJ0IFGnUKsublCpH2CcRrIi/E=;
	b=jSqSaF7I6xtud/SCvsD9zC8kVyxmsDoLrlwBUSjcuF0wPEjLzGtRpPeyUkEaPruZwW5kKI
	LyOkgziFn0sihGN5MGgvlZ6GQ8+q6INpnZe9XdHfQfKQhdP5RikaSXSt59Z2ZB5PbA8mcp
	4eQIQZ6qI/rRDmniUzyYo5aWIMOw+H4=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-adjZrLosPsuPcdIoW18U7g-1; Mon, 19 Oct 2026 10:43:11 +0000
X-MC-Unique: adjZrLosPsuPcdIoW18U7g-1
X-Mimecast-MFC-AGG-ID: adjZrLosPsuPcdIoW18U7g_1792406590
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4a1dec05668so11512245e9.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 19 Oct 2026 03:43:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792406590; x=1793011390;
        h=mime-version:user-agent:content-transfer-encoding:content-type
         :autocrypt:references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=uYkeqd5tBLFGk1jwj1eJ0IFGnUKsublCpH2CcRrIi/E=;
        b=E+I0e39KefgJNCniA65KbKTs9zRjrO3ns0n00PTpUgpqamAfDBRzCZOI+eWBtgi8+B
         XfaPu1GqlSeD9ObWlrCxd6POpCeq95ThcyLRJYJzrd1/Z1ryXKbhwsBzIcO8y4VaH32a
         LCOeDTRZjKpbwwQmUmA3RKK36zQKRezTW4/VH7TJDL4BF7omnX7g8lzD/PghHIZQ0QVk
         NAccrDjhKngF/3SDHMjOZH1LAX1NNa2Vi7RDM4z5H+/0pmiccZqepXjPro/yJDlpIVyI
         mWC9hvL0S0cl0MQ25DllmryLSlS5Y/HvgAWy3RMCwwRiKaOZzZnFGdp9Etn7oIP5F0kz
         GYdQ==
X-Forwarded-Encrypted: i=1; AKwUvBxCJssoTD8O6sGrcCCRLj6ZdMxbDK6wUXpk1d9GUiIs3Uv1NBuniQpzCrnc2L41z+kGHFmPmhxh3u2Ftoq2FU1fNn0=@vger.kernel.org
X-Gm-Message-State: AFq9FYJd0rwzsrnRYBnAuwtXozV+051ayir1eH+i1JEE45MpcBdjN1sC
	udHTQ5X8+zBwW68a/+Q7sd0UQMlI+NoiWThcXoUn/mlfjcSJaxSyxrHPERbbOdmgvcjEKXy4VId
	1CiCSy/nFvKFgrNxDA9YzANsW2uGyIzxjyu3+DYMUc4Y/98s0wTBLrIeudQZ645wS7XENwDcfPw
	==
X-Gm-Gg: AYBFou2qK0DYxp6g+IvrQn5AJus/AAHN0IysqZtH9JO+e8wNGRSWspZZ3nqWmegD+sG
	7LVhZTons3pX0jmXqfLawqccaYB3XJDHuHYYIO1w90HMIqHXHtCsPmcAV724lj/HVpB3iyOHT/h
	Ob4Bg2KZsKfOvbIcKJL7TA9+WUwalOBB6WrxFi8OhYW/UHbrjSE7iMyYu/J8HZvN2pF+b8R1GpI
	mikS3ETvD2VFl4cyEGAQ9kECUGV23+MdPszi7uSJAIgarHiZcnev+xvsnwDBFs4wStE9WnvcnlQ
	Ag4QqIcPPZwELUTD7I5BOyUNCEnLiHjjIEZi5hqnSfY9axaHOqPQ05JGFAmpz/Ws0oLghVXlGbi
	f7VBZEYnu/J+xFT3hxij261gSMA==
X-Received: by 2002:a05:600c:8b25:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a1d75f987dmr194763855e9.12.1792406587578;
        Mon, 19 Oct 2026 03:43:07 -0700 (PDT)
X-Received: by 2002:a05:600c:8b25:b0:49f:fe39:5bc8 with SMTP id 5b1f17b1804b1-4a1d75f987dmr194763415e9.12.1792406587234;
        Mon, 19 Oct 2026 03:43:07 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([195.174.134.4])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1bd91c55bsm314719595e9.0.2026.10.19.03.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Oct 2026 03:43:06 -0700 (PDT)
Message-ID: <8580176d216258e9008c344e0529509117dcc18b.camel@redhat.com>
Subject: Re: [PATCH v2 10/15] tools/rv: Add BPF monitors
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>
Cc: John Ogness <john.ogness@linutronix.de>, Alexei Starovoitov
	 <alexei.starovoitov@gmail.com>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, bpf@vger.kernel.org, Steven Rostedt
	 <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>, Wen Yang
	 <wen.yang@linux.dev>, Tobias Schaffner <tobias.schaffner@siemens.com>, 
 Viktor Malik <vmalik@redhat.com>
Date: Mon, 19 Oct 2026 12:43:05 +0200
In-Reply-To: <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
References: <20261001152042.124445-1-gmonaco@redhat.com>
	 <20261001152042.124445-11-gmonaco@redhat.com>
	 <DLXSI4BSRE5F.1TLKCBUAGNDFQ@gmail.com>
	 <b1fb01e1c58893795dd4be346f233d39fe653aaa.camel@redhat.com>
	 <DM6H7SK4YZ7A.F0MM6C0I77OR@gmail.com>
	 <878q3xtptq.fsf@jogness.linutronix.de>
	 <8B3FF026-6159-48CF-8FEA-AF2FACD2E4EB@redhat.com>
	 <87bj8s8ih9.fsf@jogness.linutronix.de>
	 <DM78SVMBI2XW.2XHVC67VON48A@gmail.com>
	 <87v770uuyr.fsf@jogness.linutronix.de>
	 <DM7I2PYHNKXE.3AYY3N1HATXLW@gmail.com>
	 <87ik2zryzo.fsf@jogness.linutronix.de>
	 <0055967d4571e7c8549dfa476fa6b15b93013701.camel@redhat.com>
	 <CAP4=nvR2i092924zszA8Qh0UUYnwXfAsa+7KjPe-NpwC+bbLXw@mail.gmail.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.60.2 (3.60.2-2.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZegSvgPOst5Xjak1ap4_3oHDDlLkWCK4WGSWZ-qLZIM_1792406590
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

> Since commit ac5a72ea5c89 ("bpf: Use dedicated bpf_trace_printk event
> instead of trace_printk()"), bpf_trace_printk() does not use
> trace_printk(). Rather, it is recorded as a separate ftrace event that
> has to be enabled, in
> /sys/kernel/tracing/events/bpf_trace/bpf_trace_printk, for each
> instance that wants to trace it, and using it does not print any
> warnings into dmesg.
>=20
> The BPF documentation says otherwise [1]:

Thanks Tomas! I noticed the banner was not displayed and I was puzzled. You
saved me an LLM iteration that would have probably be puzzled by the commen=
t
too..

> One disadvantage of using bpf_trace_printk() for RV violation
> reporting is that the event will be caught by every instance that
> enables bpf_trace_printk() and does not explicitly filter rv out.

Yes, that should somewhat be mitigated by the glob filter, though events ar=
e
still generated.

> I can imagine an RV-specific trace event for that, however, it would
> require a separate kfunc to generate it, and ideally also distinct
> labeling of a BPF program eligible to call that kfunc. The "rv"
> userspace tool could then iterate over these labels so the user knows
> which violation events can be expected to occur on the system.

That'd work too. It's what I initially envisioned but=C2=A0I'm not sure a k=
func
producing a tracepoint is something BPF folks would really like (and techni=
cally
any other unrelated BPF program could call that, unless there's some access
control mechanism I'm not aware of).

Not sure how much it matters in practice against the glob filter, it probab=
ly
really depends on the other bpf_printk users (and a mildly better usability=
).

Gabriele

