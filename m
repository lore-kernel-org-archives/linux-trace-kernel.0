Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A9363A16B1
	for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 08:19:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776068374; cv=none; b=Ik3D3Ls5x56FIPOlCxGnofKTkePAd4j9Tq7mnsBU5ZT2pwcA6AQkkoREJOhDtT2oH/AOaTBXh3LJCx+FA8PtFgmBizikwSnwGE5vOLMaRuI69bBmDQgDrLHIZaFhK8rrM53RQREeqXG5gfWxH5hebKMzg1bFclnromk60Vwn6lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776068374; c=relaxed/simple;
	bh=92rFWZ2OdDuDconbRE121eDTTE8XekXYDYjBAhXQKlE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=g5b0TkKzD1zLkFT259DDROqw5GRc2L3Q/fWKBoqkXMnydCJjiLYlAILinwXoKKIcSHDxsvXizks+j+INPiGcsuKsHqlpxb0ypsG2JtcZU7T5YPGY0+5CWucgNIgpJr3Ysj+2esCTVp3dmfKdboMYBNtOG2YhYXHGxyxOEOHQRMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OxprIKeJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OxprIKeJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776068368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=CxD99/W3IUmJQGcZ9/fwuVAP6oMx9c371kp8dGUrCZ4=;
	b=OxprIKeJDcP13ILtfNaYnnV82nwLdzpENf05pYAnEGSEGaIDluHWhFLPSB40pcLJj31muc
	Enhmbgl0QBKM1uUNt6XdjCy/SeaDKZhIvYnQHzceqX4YjacLSjV+W9dOkyORQX8iMgeMX8
	jVfN9+OU5jCZJg38eiBMtEgxXnduOvw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-466-uAGO48eHOl2cXDRNDwf31w-1; Mon, 13 Apr 2026 04:19:26 -0400
X-MC-Unique: uAGO48eHOl2cXDRNDwf31w-1
X-Mimecast-MFC-AGG-ID: uAGO48eHOl2cXDRNDwf31w_1776068365
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-43d7c6d58c8so314669f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 13 Apr 2026 01:19:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776068365; x=1776673165;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NcrSdL+6/tRRW05NAZ6inc2WHBwAEQDecnXM8gaacXk=;
        b=mxTtW0J6wmsDZ5sfMZwDIf+DHxxk3Zi07ar0EfaQQ1duMgT+uOYN1xDNgAuraYr3ce
         xvUeNCD9eQ9GxiKehPXPeB6l8VweYSf/sz1ZWJjgQ69aNoUhPcVecSKHtmLyf6j16sK2
         f/+Dd/1NPuY/6OpDgfzFuMVgyg++1u8nH4t+fDkw3zMfL0580n7wcuMXPtszLwD1ZDhP
         mLqE12KyoFFuFHnk5vmQ0/QJgQgo357dWvBNwUVQ/7nbeW58YHXtxjdhZgxsgOTbMFHM
         +x6LqZYb5AZMSS2htE2fo9P/XwWiHz8GF0h1S8JNDpWr5diJF1Nz/fcFEFsXpo70Pnrp
         8JtA==
X-Forwarded-Encrypted: i=1; AFNElJ++aJ89ps4iOzQ35bl/5S7mYI/zwZQVUfm1u3S7Uykm3hBhdL1hcqfu55IEuwoERILKVcqe+yWoiQ5KcT8WHo/82Ac=@vger.kernel.org
X-Gm-Message-State: AOJu0YxV12yUxjawgyLWjBo8dbXsSxIEwfpBS/9dfs7tXWyeJKqPtWof
	OqDo+t/nMbcKPYPhWpr8awiPKF2t6vlVNS3AOLyebA/4F1HQ8vfZxfARna7eN79GFIo6DaRpP0+
	3pcQVYCknGlbe/NYI2Mz12buqJQx0cYGpRqDCk1IsCzH2jwH+NdvYHPMlJfcXTXi9Vse4Jlly4w
	==
X-Gm-Gg: AeBDieuyVUXDaetIGJfZqJo0z6yum+t7YhOl7m/LLQxRoYP1lFrlPe7bkZTrJdDqCWS
	Nsrl1Zl51+7M8wi/yVRpcfboVjMl1NvBBoaGbT8EKnCIzHVW2zzhuXFqiy10wf6jLMQgZ+mNTJA
	Bk8vHRS7tyGvfZgg26jIuN3HXYUdwd3CEWgfc1NiHjxKoD6CT/+M2Bu70iW2tCGzhfwGN7rcvbG
	4rYOgd2qGkLWn0d0DBf3E2UWFV6v1BxzBeasE6VhPLv2aAD3+xOFf3g+tPBYSLD7rllcJ23YseP
	D4uGYmqCiJQM+3u8In3s6ZIIR87wAqlR/zaRQ70Iy4R9wT1uWhWGmStInx4/nniW9Vi4DNMv6nT
	IIZO9JMGLYyKog8LCHraeoFilSCPncFHEzc63PoiL2i3YnoYATP0Y1tkJk3uDtW/CCmWy1dSQAn
	aBrKHFOCU3EgYdMZQ=
X-Received: by 2002:a5d:64c4:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-43d6427bac4mr15843320f8f.9.1776068363154;
        Mon, 13 Apr 2026 01:19:23 -0700 (PDT)
X-Received: by 2002:a5d:64c4:0:b0:43b:498f:dceb with SMTP id ffacd0b85a97d-43d6427bac4mr15843051f8f.9.1776068359558;
        Mon, 13 Apr 2026 01:19:19 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (212-8-243-115.hosted-by-worldstream.net. [212.8.243.115])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d762decf6sm15365087f8f.8.2026.04.13.01.19.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Apr 2026 01:19:18 -0700 (PDT)
Message-ID: <74a624434b59c00f9407909b8696f041536d9418.camel@redhat.com>
Subject: Re: [RFC PATCH 2/4] rv/tlob: Add tlob deterministic automaton
 monitor
From: Gabriele Monaco <gmonaco@redhat.com>
To: wen.yang@linux.dev
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 13 Apr 2026 10:19:17 +0200
In-Reply-To: <ccf53a89b3b65e5728403dc097fde94ac2591d98.1776020428.git.wen.yang@linux.dev>
References: <cover.1776020428.git.wen.yang@linux.dev>
	 <ccf53a89b3b65e5728403dc097fde94ac2591d98.1776020428.git.wen.yang@linux.dev>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: PL2fMwbQoboZZqKQoPPdzPjXx-itZKcuFGH9NtoChGY_1776068365
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2026-04-13 at 03:27 +0800, wen.yang@linux.dev wrote:
> From: Wen Yang <wen.yang@linux.dev>
>=20
> Add the tlob (task latency over budget) RV monitor. tlob tracks the
> monotonic elapsed time (CLOCK_MONOTONIC) of a marked per-task code
> path, including time off-CPU, and fires a per-task hrtimer when the
> elapsed time exceeds a configurable budget.
>=20
> Three-state DA (unmonitored/on_cpu/off_cpu) driven by trace_start,
> switch_in/out, and budget_expired events. Per-task state lives in a
> fixed-size hash table (TLOB_MAX_MONITORED slots) with RCU-deferred
> free.
>=20
> Two userspace interfaces:
> =C2=A0- tracefs: uprobe pair registration via the monitor file using the
> =C2=A0=C2=A0 format "pid:threshold_us:offset_start:offset_stop:binary_pat=
h"
> =C2=A0- /dev/rv ioctls (CONFIG_RV_CHARDEV): TLOB_IOCTL_TRACE_START /
> =C2=A0=C2=A0 TRACE_STOP; TRACE_STOP returns -EOVERFLOW on violation
>=20
> Each /dev/rv fd has a per-fd mmap ring buffer (physically contiguous
> pages). A control page (struct tlob_mmap_page) at offset 0 exposes
> head/tail/dropped for lockless userspace reads; struct tlob_event
> records follow at data_offset. Drop-new policy on overflow.
>=20
> UAPI: include/uapi/linux/rv.h (tlob_start_args, tlob_event,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_mmap_page, ioctl numbers), monitor_tl=
ob.rst,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ioctl-number.rst (RV_IOC_MAGIC=3D0xB9).
>=20

I'm not fully grasping all the requirements for the monitors yet, but I see=
 you
are reimplementing a lot of functionality in the monitor itself rather than
within RV, let's see if we can consolidate some of them:

 * you're using timer expirations, can we do it with timed automata? [1]
 * RV automata usually don't have an /unmonitored/ state, your trace_start =
event
would  be the start condition (da_event_start) and the monitor will get non=
-
running at each violation (it calls da_monitor_reset() automatically), all
setup/cleanup logic should be handled implicitly within RV. I believe that =
would
also save you that ugly trace_event_tlob() redefinition.
 * you're maintaining a local hash table for each task_struct, that could u=
se
the per-object monitors [2] where your "object" is in fact your struct,
allocated when you start the monitor with all appropriate fields and indexe=
d by
pid
 * you are handling violations manually, considering timed automata trigger=
 a
full fledged violation on timeouts, can you use the RV-way (error tracepoin=
ts or
reactors only)? Do you need the additional reporting within the
tracepoint/ioctl? Cannot the userspace consumer desume all those from other
events and let RV do just the monitoring?
 * I like the uprobe thing, we could probably move all that to a common hel=
per
once we figure out how to make it generic.

Note: [1] and [2] didn't reach upstream yet, but should reach linux-next so=
on.

Thanks,
Gabriele

[1] -
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commi=
t/?h=3Drv/for-next&id=3Df5587d1b6ec938afb2f74fe399a68020d66923e4
[2] -
https://git.kernel.org/pub/scm/linux/kernel/git/trace/linux-trace.git/commi=
t/?h=3Drv/for-next&id=3Dda282bf7fadb095ee0a40c32ff0126429c769b45

> Signed-off-by: Wen Yang <wen.yang@linux.dev>
> ---
> =C2=A0Documentation/trace/rv/index.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0Documentation/trace/rv/monitor_tlob.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 381 +++++++
> =C2=A0.../userspace-api/ioctl/ioctl-number.rst=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0 |=C2=A0=C2=A0 1 +
> =C2=A0include/uapi/linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 | 181 ++++
> =C2=A0kernel/trace/rv/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 |=C2=A0 17 +
> =C2=A0kernel/trace/rv/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0 2 +
> =C2=A0kernel/trace/rv/monitors/tlob/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 |=C2=A0 51 +
> =C2=A0kernel/trace/rv/monitors/tlob/tlob.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 986 ++++++++++++++++++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 145 +++
> =C2=A0kernel/trace/rv/monitors/tlob/tlob_trace.h=C2=A0=C2=A0=C2=A0 |=C2=
=A0 42 +
> =C2=A0kernel/trace/rv/rv.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 4 +
> =C2=A0kernel/trace/rv/rv_dev.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 602 +++++++++++
> =C2=A0kernel/trace/rv/rv_trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |=C2=A0 50 +
> =C2=A013 files changed, 2463 insertions(+)
> =C2=A0create mode 100644 Documentation/trace/rv/monitor_tlob.rst
> =C2=A0create mode 100644 include/uapi/linux/rv.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/Kconfig
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob.c
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob.h
> =C2=A0create mode 100644 kernel/trace/rv/monitors/tlob/tlob_trace.h
> =C2=A0create mode 100644 kernel/trace/rv/rv_dev.c
>=20
> diff --git a/Documentation/trace/rv/index.rst
> b/Documentation/trace/rv/index.rst
> index a2812ac5c..4f2bfaf38 100644
> --- a/Documentation/trace/rv/index.rst
> +++ b/Documentation/trace/rv/index.rst
> @@ -15,3 +15,4 @@ Runtime Verification
> =C2=A0=C2=A0=C2=A0 monitor_wwnr.rst
> =C2=A0=C2=A0=C2=A0 monitor_sched.rst
> =C2=A0=C2=A0=C2=A0 monitor_rtapp.rst
> +=C2=A0=C2=A0 monitor_tlob.rst
> diff --git a/Documentation/trace/rv/monitor_tlob.rst
> b/Documentation/trace/rv/monitor_tlob.rst
> new file mode 100644
> index 000000000..d498e9894
> --- /dev/null
> +++ b/Documentation/trace/rv/monitor_tlob.rst
> @@ -0,0 +1,381 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +Monitor tlob
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +
> +- Name: tlob - task latency over budget
> +- Type: per-task deterministic automaton
> +- Author: Wen Yang <wen.yang@linux.dev>
> +
> +Description
> +-----------
> +
> +The tlob monitor tracks per-task elapsed time (CLOCK_MONOTONIC, includin=
g
> +both on-CPU and off-CPU time) and reports a violation when the monitored
> +task exceeds a configurable latency budget threshold.
> +
> +The monitor implements a three-state deterministic automaton::
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | (initial)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--------------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-------> | unmon=
itored=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--------------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 trace_start
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 v
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--------------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 on_cpu=C2=A0=C2=A0=C2=A0=C2=
=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +--------------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 switch_ou=
t|=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | trace_stop / budget_ex=
pired
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 +--------=
------+=C2=A0 (unmonitored)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 |=C2=A0=
=C2=A0 off_cpu=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 +--------=
------+
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0 | switch_in| trace_stop / budget_expired
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0=C2=
=A0=C2=A0 v=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 v
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 (on_cpu)=
=C2=A0 (unmonitored)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 +-- trace_stop (f=
rom on_cpu or off_cpu)
> +
> +=C2=A0 Key transitions:
> +=C2=A0=C2=A0=C2=A0 unmonitored=C2=A0=C2=A0 --(trace_start)-->=C2=A0=C2=
=A0 on_cpu
> +=C2=A0=C2=A0=C2=A0 on_cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --(s=
witch_out)-->=C2=A0=C2=A0=C2=A0 off_cpu
> +=C2=A0=C2=A0=C2=A0 off_cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --(switch=
_in)-->=C2=A0=C2=A0=C2=A0=C2=A0 on_cpu
> +=C2=A0=C2=A0=C2=A0 on_cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --(t=
race_stop)-->=C2=A0=C2=A0=C2=A0 unmonitored
> +=C2=A0=C2=A0=C2=A0 off_cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --(trace_=
stop)-->=C2=A0=C2=A0=C2=A0 unmonitored
> +=C2=A0=C2=A0=C2=A0 on_cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --(b=
udget_expired)-> unmonitored=C2=A0=C2=A0 [violation]
> +=C2=A0=C2=A0=C2=A0 off_cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 --(budget=
_expired)-> unmonitored=C2=A0=C2=A0 [violation]
> +
> +=C2=A0 sched_wakeup self-loops in on_cpu and unmonitored; switch_out and
> +=C2=A0 sched_wakeup self-loop in off_cpu.=C2=A0 budget_expired is fired =
by the one-shot
> hrtimer; it always
> +=C2=A0 transitions to unmonitored regardless of whether the task is on-C=
PU
> +=C2=A0 or off-CPU when the timer fires.
> +
> +State Descriptions
> +------------------
> +
> +- **unmonitored**: Task is not being traced.=C2=A0 Scheduling events
> +=C2=A0 (``switch_in``, ``switch_out``, ``sched_wakeup``) are silently
> +=C2=A0 ignored (self-loop).=C2=A0 The monitor waits for a ``trace_start`=
` event
> +=C2=A0 to begin a new observation window.
> +
> +- **on_cpu**: Task is running on the CPU with the deadline timer armed.
> +=C2=A0 A one-shot hrtimer was set for ``threshold_us`` microseconds at
> +=C2=A0 ``trace_start`` time.=C2=A0 A ``switch_out`` event transitions to
> +=C2=A0 ``off_cpu``; the hrtimer keeps running (off-CPU time counts towar=
d
> +=C2=A0 the budget).=C2=A0 A ``trace_stop`` cancels the timer and returns=
 to
> +=C2=A0 ``unmonitored`` (normal completion).=C2=A0 If the hrtimer fires
> +=C2=A0 (``budget_expired``) the violation is recorded and the automaton
> +=C2=A0 transitions to ``unmonitored``.
> +
> +- **off_cpu**: Task was preempted or blocked.=C2=A0 The one-shot hrtimer
> +=C2=A0 continues to run.=C2=A0 A ``switch_in`` event returns to ``on_cpu=
``.
> +=C2=A0 A ``trace_stop`` cancels the timer and returns to ``unmonitored``=
.
> +=C2=A0 If the hrtimer fires (``budget_expired``) while the task is off-C=
PU,
> +=C2=A0 the violation is recorded and the automaton transitions to
> +=C2=A0 ``unmonitored``.
> +
> +Rationale
> +---------
> +
> +The per-task latency budget threshold allows operators to express timing
> +requirements in microseconds and receive an immediate ftrace event when =
a
> +task exceeds its budget.=C2=A0 This is useful for real-time tasks
> +(``SCHED_FIFO`` / ``SCHED_DEADLINE``) where total elapsed time must
> +remain within a known bound.
> +
> +Each task has an independent threshold, so up to ``TLOB_MAX_MONITORED``
> +(64) tasks with different timing requirements can be monitored
> +simultaneously.
> +
> +On threshold violation the automaton records a ``tlob_budget_exceeded``
> +ftrace event carrying the final on-CPU / off-CPU time breakdown, but doe=
s
> +not kill or throttle the task.=C2=A0 Monitoring can be restarted by issu=
ing a
> +new ``trace_start`` event (or a new ``TLOB_IOCTL_TRACE_START`` ioctl).
> +
> +A per-task one-shot hrtimer is armed at ``trace_start`` for exactly
> +``threshold_us`` microseconds.=C2=A0 It fires at most once per monitorin=
g
> +window, performs an O(1) hash lookup, records the violation, and injects
> +the ``budget_expired`` event into the DA.=C2=A0 When ``CONFIG_RV_MON_TLO=
B``
> +is not set there is zero runtime cost.
> +
> +Usage
> +-----
> +
> +tracefs interface (uprobe-based external monitoring)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +The ``monitor`` tracefs file allows any privileged user to instrument an
> +unmodified binary via uprobes, without changing its source code.=C2=A0 W=
rite a
> +four-field record to attach two plain entry uprobes: one at
> +``offset_start`` fires ``tlob_start_task()`` and one at ``offset_stop``
> +fires ``tlob_stop_task()``, so the latency budget covers exactly the cod=
e
> +region between the two offsets::
> +
> +=C2=A0 threshold_us:offset_start:offset_stop:binary_path
> +
> +``binary_path`` comes last so it may freely contain ``:`` (e.g. paths
> +inside a container namespace).
> +
> +The uprobes fire for every task that executes the probed instruction in
> +the binary, consistent with the native uprobe semantics.=C2=A0 All tasks=
 that
> +execute the code region get independent per-task monitoring slots.
> +
> +Using two plain entry uprobes (rather than a uretprobe for the stop) mea=
ns
> +that a mistyped offset can never corrupt the call stack; the worst outco=
me
> +of a bad ``offset_stop`` is a missed stop that causes the hrtimer to fir=
e
> +and report a budget violation.
> +
> +Example=C2=A0 --=C2=A0 monitor a code region in ``/usr/bin/myapp`` with =
a 5 ms
> +budget, where the region starts at offset 0x12a0 and ends at 0x12f0::
> +
> +=C2=A0 echo 1 > /sys/kernel/tracing/rv/monitors/tlob/enable
> +
> +=C2=A0 # Bind uprobes: start probe starts the clock, stop probe stops it
> +=C2=A0 echo "5000:0x12a0:0x12f0:/usr/bin/myapp" \
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > /sys/kernel/tracing/rv/monitors/tlob/mo=
nitor
> +
> +=C2=A0 # Remove the uprobe binding for this code region
> +=C2=A0 echo "-0x12a0:/usr/bin/myapp" >
> /sys/kernel/tracing/rv/monitors/tlob/monitor
> +
> +=C2=A0 # List registered uprobe bindings (mirrors the write format)
> +=C2=A0 cat /sys/kernel/tracing/rv/monitors/tlob/monitor
> +=C2=A0 # -> 5000:0x12a0:0x12f0:/usr/bin/myapp
> +
> +=C2=A0 # Read violations from the trace buffer
> +=C2=A0 cat /sys/kernel/tracing/trace
> +
> +Up to ``TLOB_MAX_MONITORED`` tasks may be monitored simultaneously.
> +
> +The offsets can be obtained with ``nm`` or ``readelf``::
> +
> +=C2=A0 nm -n /usr/bin/myapp | grep my_function
> +=C2=A0 # -> 0000000000012a0 T my_function
> +
> +=C2=A0 readelf -s /usr/bin/myapp | grep my_function
> +=C2=A0 # -> 42: 0000000000012a0=C2=A0 336 FUNC GLOBAL DEFAULT=C2=A0 13 m=
y_function
> +
> +=C2=A0 # offset_start =3D 0x12a0 (function entry)
> +=C2=A0 # offset_stop=C2=A0 =3D 0x12a0 + 0x50 =3D 0x12f0 (or any instruct=
ion before return)
> +
> +Notes:
> +
> +- The uprobes fire for every task that executes the probed instruction,
> +=C2=A0 so concurrent calls from different threads each get independent
> +=C2=A0 monitoring slots.
> +- ``offset_stop`` need not be a function return; it can be any instructi=
on
> +=C2=A0 within the region.=C2=A0 If the stop probe is never reached (e.g.=
 early exit
> +=C2=A0 path bypasses it), the hrtimer fires and a budget violation is re=
ported.
> +- Each ``(binary_path, offset_start)`` pair may only be registered once.
> +=C2=A0 A second write with the same ``offset_start`` for the same binary=
 is
> +=C2=A0 rejected with ``-EEXIST``.=C2=A0 Two entry uprobes at the same ad=
dress would
> +=C2=A0 both fire for every task, causing ``tlob_start_task()`` to be cal=
led
> +=C2=A0 twice; the second call would silently fail with ``-EEXIST`` and t=
he
> +=C2=A0 second binding's threshold would never take effect.=C2=A0 Differe=
nt code
> +=C2=A0 regions that share the same ``offset_stop`` (common exit point) a=
re
> +=C2=A0 explicitly allowed.
> +- The uprobe binding is removed when ``-offset_start:binary_path`` is
> +=C2=A0 written to ``monitor``, or when the monitor is disabled.
> +- The ``tag`` field in every ``tlob_budget_exceeded`` event is
> +=C2=A0 automatically set to ``offset_start`` for the tracefs path, so
> +=C2=A0 violation events for different code regions are immediately
> +=C2=A0 distinguishable even when ``threshold_us`` values are identical.
> +
> +ftrace ring buffer (budget violation events)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +When a monitored task exceeds its latency budget the hrtimer fires,
> +records the violation, and emits a single ``tlob_budget_exceeded`` event
> +into the ftrace ring buffer.=C2=A0 **Nothing is written to the ftrace ri=
ng
> +buffer while the task is within budget.**
> +
> +The event carries the on-CPU / off-CPU time breakdown so that root-cause
> +analysis (CPU-bound vs. scheduling / I/O overrun) is immediate::
> +
> +=C2=A0 cat /sys/kernel/tracing/trace
> +
> +Example output::
> +
> +=C2=A0 myapp-1234 [003] .... 12345.678: tlob_budget_exceeded: \
> +=C2=A0=C2=A0=C2=A0 myapp[1234]: budget exceeded threshold=3D5000 \
> +=C2=A0=C2=A0=C2=A0 on_cpu=3D820 off_cpu=3D4500 switches=3D3 state=3Doff_=
cpu tag=3D0x00000000000012a0
> +
> +Field descriptions:
> +
> +``threshold``
> +=C2=A0 Configured latency budget in microseconds.
> +
> +``on_cpu``
> +=C2=A0 Cumulative on-CPU time since ``trace_start``, in microseconds.
> +
> +``off_cpu``
> +=C2=A0 Cumulative off-CPU (scheduling + I/O wait) time since ``trace_sta=
rt``,
> +=C2=A0 in microseconds.
> +
> +``switches``
> +=C2=A0 Number of times the task was scheduled out during this window.
> +
> +``state``
> +=C2=A0 DA state when the hrtimer fired: ``on_cpu`` means the task was ex=
ecuting
> +=C2=A0 when the budget expired (CPU-bound overrun); ``off_cpu`` means th=
e task
> +=C2=A0 was preempted or blocked (scheduling / I/O overrun).
> +
> +``tag``
> +=C2=A0 Opaque 64-bit cookie supplied by the caller via ``tlob_start_args=
.tag``
> +=C2=A0 (ioctl path) or automatically set to ``offset_start`` (tracefs up=
robe
> +=C2=A0 path).=C2=A0 Use it to distinguish violations from different code=
 regions
> +=C2=A0 monitored by the same thread.=C2=A0 Zero when not set.
> +
> +To capture violations in a file::
> +
> +=C2=A0 trace-cmd record -e tlob_budget_exceeded &
> +=C2=A0 # ... run workload ...
> +=C2=A0 trace-cmd report
> +
> +/dev/rv ioctl interface (self-instrumentation)
> +~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> +
> +Tasks can self-instrument their own code paths via the ``/dev/rv`` misc
> +device (requires ``CONFIG_RV_CHARDEV``).=C2=A0 The kernel key is
> +``task_struct``; multiple threads sharing a single fd each get their own
> +independent monitoring slot.
> +
> +**Synchronous mode**=C2=A0 --=C2=A0 the calling thread checks its own re=
sult::
> +
> +=C2=A0 int fd =3D open("/dev/rv", O_RDWR);
> +
> +=C2=A0 struct tlob_start_args args =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .threshold_us =3D 50000,=C2=A0=C2=A0 /* 5=
0 ms */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tag=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D 0,=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* optional; =
0 =3D don't care */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .notify_fd=C2=A0=C2=A0=C2=A0 =3D -1,=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* no fd notification */
> +=C2=A0 };
> +=C2=A0 ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
> +
> +=C2=A0 /* ... code path under observation ... */
> +
> +=C2=A0 int ret =3D ioctl(fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +=C2=A0 /* ret =3D=3D 0:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 within budget=C2=A0 */
> +=C2=A0 /* ret =3D=3D -EOVERFLOW: budget exceeded */
> +
> +=C2=A0 close(fd);
> +
> +**Asynchronous mode**=C2=A0 --=C2=A0 a dedicated monitor thread receives=
 violation
> +records via ``read()`` on a shared fd, decoupling the observation from
> +the critical path::
> +
> +=C2=A0 /* Monitor thread: open a dedicated fd. */
> +=C2=A0 int monitor_fd =3D open("/dev/rv", O_RDWR);
> +
> +=C2=A0 /* Worker thread: set notify_fd =3D monitor_fd in TRACE_START arg=
s. */
> +=C2=A0 int work_fd =3D open("/dev/rv", O_RDWR);
> +=C2=A0 struct tlob_start_args args =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .threshold_us =3D 10000,=C2=A0=C2=A0 /* 1=
0 ms */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .tag=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0 =3D REGION_A,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .notify_fd=C2=A0=C2=A0=C2=A0 =3D monitor_=
fd,
> +=C2=A0 };
> +=C2=A0 ioctl(work_fd, TLOB_IOCTL_TRACE_START, &args);
> +=C2=A0 /* ... critical section ... */
> +=C2=A0 ioctl(work_fd, TLOB_IOCTL_TRACE_STOP, NULL);
> +
> +=C2=A0 /* Monitor thread: blocking read() returns one or more tlob_event=
 records.
> */
> +=C2=A0 struct tlob_event ntfs[8];
> +=C2=A0 ssize_t n =3D read(monitor_fd, ntfs, sizeof(ntfs));
> +=C2=A0 for (int i =3D 0; i < n / sizeof(struct tlob_event); i++) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct tlob_event *ntf =3D &ntfs[i];
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 printf("tid=3D%u tag=3D0x%llx exceeded bu=
dget=3D%llu us "
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 "(on_cpu=3D%llu off_cpu=3D%llu switches=3D%u state=3D%s)\n",
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ntf->tid, ntf->tag, ntf->threshold_us,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ntf->on_cpu_us, ntf->off_cpu_us, ntf->switches,
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 ntf->state ? "on_cpu" : "off_cpu");
> +=C2=A0 }
> +
> +**mmap ring buffer**=C2=A0 --=C2=A0 zero-copy consumption of violation e=
vents::
> +
> +=C2=A0 int fd =3D open("/dev/rv", O_RDWR);
> +=C2=A0 struct tlob_start_args args =3D {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .threshold_us =3D 1000,=C2=A0=C2=A0 /* 1 =
ms */
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .notify_fd=C2=A0=C2=A0=C2=A0 =3D fd,=C2=
=A0=C2=A0=C2=A0=C2=A0 /* push violations to own ring buffer */
> +=C2=A0 };
> +=C2=A0 ioctl(fd, TLOB_IOCTL_TRACE_START, &args);
> +
> +=C2=A0 /* Map the ring: one control page + capacity data records. */
> +=C2=A0 size_t pagesize =3D sysconf(_SC_PAGESIZE);
> +=C2=A0 size_t cap =3D 64;=C2=A0=C2=A0 /* read from page->capacity after =
mmap */
> +=C2=A0 size_t len =3D pagesize + cap * sizeof(struct tlob_event);
> +=C2=A0 void *map =3D mmap(NULL, len, PROT_READ | PROT_WRITE, MAP_SHARED,=
 fd, 0);
> +
> +=C2=A0 struct tlob_mmap_page *page =3D map;
> +=C2=A0 struct tlob_event *data =3D
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 (struct tlob_event *)((char *)map + page-=
>data_offset);
> +
> +=C2=A0 /* Consumer loop: poll for events, read without copying. */
> +=C2=A0 while (1) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 poll(&(struct pollfd){fd, POLLIN, 0}, 1, =
-1);
> +
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t head =3D __atomic_load_n(&page->=
data_head, __ATOMIC_ACQUIRE);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 uint32_t tail =3D page->data_tail;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 while (tail !=3D head) {
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle(&data[tail=
 & (page->capacity - 1)]);
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tail++;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __atomic_store_n(&page->data_tail, tail, =
__ATOMIC_RELEASE);
> +=C2=A0 }
> +
> +Note: ``read()`` and ``mmap()`` share the same ring and ``data_tail``
> +cursor.=C2=A0 Do not use both simultaneously on the same fd.
> +
> +``tlob_event`` fields:
> +
> +``tid``
> +=C2=A0 Thread ID (``task_pid_vnr``) of the violating task.
> +
> +``threshold_us``
> +=C2=A0 Budget that was exceeded, in microseconds.
> +
> +``on_cpu_us``
> +=C2=A0 Cumulative on-CPU time at violation time, in microseconds.
> +
> +``off_cpu_us``
> +=C2=A0 Cumulative off-CPU time at violation time, in microseconds.
> +
> +``switches``
> +=C2=A0 Number of context switches since ``TRACE_START``.
> +
> +``state``
> +=C2=A0 1 =3D timer fired while task was on-CPU; 0 =3D timer fired while =
off-CPU.
> +
> +``tag``
> +=C2=A0 Cookie from ``tlob_start_args.tag``; for the tracefs uprobe path =
this
> +=C2=A0 equals ``offset_start``.=C2=A0 Zero when not set.
> +
> +tracefs files
> +-------------
> +
> +The following files are created under
> +``/sys/kernel/tracing/rv/monitors/tlob/``:
> +
> +``enable`` (rw)
> +=C2=A0 Write ``1`` to enable the monitor; write ``0`` to disable it and
> +=C2=A0 stop all currently monitored tasks.
> +
> +``desc`` (ro)
> +=C2=A0 Human-readable description of the monitor.
> +
> +``monitor`` (rw)
> +=C2=A0 Write ``threshold_us:offset_start:offset_stop:binary_path`` to bi=
nd two
> +=C2=A0 plain entry uprobes in *binary_path*.=C2=A0 The uprobe at *offset=
_start* fires
> +=C2=A0 ``tlob_start_task()``; the uprobe at *offset_stop* fires
> +=C2=A0 ``tlob_stop_task()``.=C2=A0 Returns ``-EEXIST`` if a binding with=
 the same
> +=C2=A0 *offset_start* already exists for *binary_path*.=C2=A0 Write
> +=C2=A0 ``-offset_start:binary_path`` to remove the binding.=C2=A0 Read t=
o list
> +=C2=A0 registered bindings, one
> +=C2=A0 ``threshold_us:0xoffset_start:0xoffset_stop:binary_path`` entry p=
er line.
> +
> +Specification
> +-------------
> +
> +Graphviz DOT file in tools/verification/models/tlob.dot
> diff --git a/Documentation/userspace-api/ioctl/ioctl-number.rst
> b/Documentation/userspace-api/ioctl/ioctl-number.rst
> index 331223761..8d3af68db 100644
> --- a/Documentation/userspace-api/ioctl/ioctl-number.rst
> +++ b/Documentation/userspace-api/ioctl/ioctl-number.rst
> @@ -385,6 +385,7 @@ Code=C2=A0 Seq#=C2=A0=C2=A0=C2=A0 Include
> File=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Comments
> =C2=A00xB8=C2=A0 01-02=C2=A0 uapi/misc/mrvl_cn10k_dpi.h=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> Marvell CN10K DPI driver
> =C2=A00xB8=C2=A0 all=C2=A0=C2=A0=C2=A0 uapi/linux/mshv.h=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> Microsoft Hyper-V /dev/mshv driver
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> <mailto:linux-hyperv@vger.kernel.org>
> +0xB9=C2=A0 00-3F=C2=A0 linux/rv.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0
> Runtime Verification (RV) monitors
> =C2=A00xBA=C2=A0 00-0F=C2=A0 uapi/linux/liveupdate.h=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Pasha
> Tatashin
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0
> <mailto:pasha.tatashin@soleen.com>
> =C2=A00xC0=C2=A0 00-0F=C2=A0 linux/usb/iowarrior.h
> diff --git a/include/uapi/linux/rv.h b/include/uapi/linux/rv.h
> new file mode 100644
> index 000000000..d1b96d8cd
> --- /dev/null
> +++ b/include/uapi/linux/rv.h
> @@ -0,0 +1,181 @@
> +/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
> +/*
> + * UAPI definitions for Runtime Verification (RV) monitors.
> + *
> + * All RV monitors that expose an ioctl self-instrumentation interface
> + * share the magic byte RV_IOC_MAGIC (0xB9), registered in
> + * Documentation/userspace-api/ioctl/ioctl-number.rst.
> + *
> + * A single /dev/rv misc device serves as the entry point.=C2=A0 ioctl n=
umbers
> + * encode both the monitor identity and the operation:
> + *
> + *=C2=A0=C2=A0 0x01 - 0x1F=C2=A0 tlob (task latency over budget)
> + *=C2=A0=C2=A0 0x20 - 0x3F=C2=A0 reserved for future RV monitors
> + *
> + * Usage examples and design rationale are in:
> + *=C2=A0=C2=A0 Documentation/trace/rv/monitor_tlob.rst
> + */
> +
> +#ifndef _UAPI_LINUX_RV_H
> +#define _UAPI_LINUX_RV_H
> +
> +#include <linux/ioctl.h>
> +#include <linux/types.h>
> +
> +/* Magic byte shared by all RV monitor ioctls. */
> +#define RV_IOC_MAGIC=090xB9
> +
> +/* ---------------------------------------------------------------------=
--
> + * tlob: task latency over budget monitor=C2=A0 (nr 0x01 - 0x1F)
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +/**
> + * struct tlob_start_args - arguments for TLOB_IOCTL_TRACE_START
> + * @threshold_us: Latency budget for this critical section, in microseco=
nds.
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Must be greater than zero.
> + * @tag:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Opaque 64-bit c=
ookie supplied by the caller.=C2=A0 Echoed back
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 verbatim in the tlob_budget_exceeded ftrace event and in an=
y
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 tlob_event record delivered via @notify_fd.=C2=A0 Use it to
> identify
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 which code region triggered a violation when the same threa=
d
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 monitors multiple regions sequentially.=C2=A0 Set to 0 if n=
ot
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 needed.
> + * @notify_fd:=C2=A0=C2=A0 File descriptor that will receive a tlob_even=
t record on
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 violation.=C2=A0 Must refer to an open /dev/rv fd.=C2=A0 Ma=
y equal
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 the calling fd (self-notification, useful for retrieving th=
e
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 on_cpu_us / off_cpu_us breakdown after TRACE_STOP returns
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 -EOVERFLOW).=C2=A0 Set to -1 to disable fd notification; in=
 that
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 case violations are only signalled via the TRACE_STOP retur=
n
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 value and the tlob_budget_exceeded ftrace event.
> + * @flags:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Must be 0.=C2=A0 Reserved=
 for future extensions.
> + */
> +struct tlob_start_args {
> +=09__u64 threshold_us;
> +=09__u64 tag;
> +=09__s32 notify_fd;
> +=09__u32 flags;
> +};
> +
> +/**
> + * struct tlob_event - one budget-exceeded event
> + *
> + * Consumed by read() on the notify_fd registered at TLOB_IOCTL_TRACE_ST=
ART.
> + * Each record describes a single budget exceedance for one task.
> + *
> + * @tid:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Thread ID=
 (task_pid_vnr) of the violating task.
> + * @threshold_us: Budget that was exceeded, in microseconds.
> + * @on_cpu_us:=C2=A0=C2=A0=C2=A0 Cumulative on-CPU time at violation tim=
e, in microseconds.
> + * @off_cpu_us:=C2=A0=C2=A0 Cumulative off-CPU (scheduling + I/O wait) t=
ime at
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 violation time, in microseconds.
> + * @switches:=C2=A0=C2=A0=C2=A0=C2=A0 Number of context switches since T=
RACE_START.
> + * @state:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 DA state at violati=
on: 1 =3D on_cpu, 0 =3D off_cpu.
> + * @tag:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Cookie fr=
om tlob_start_args.tag; for the tracefs uprobe
> path
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 this is the offset_start value.=C2=A0 Zero when not set.
> + */
> +struct tlob_event {
> +=09__u32 tid;
> +=09__u32 pad;
> +=09__u64 threshold_us;
> +=09__u64 on_cpu_us;
> +=09__u64 off_cpu_us;
> +=09__u32 switches;
> +=09__u32 state;=C2=A0=C2=A0 /* 1 =3D on_cpu, 0 =3D off_cpu */
> +=09__u64 tag;
> +};
> +
> +/**
> + * struct tlob_mmap_page - control page for the mmap'd violation ring bu=
ffer
> + *
> + * Mapped at offset 0 of the mmap region returned by mmap(2) on a /dev/r=
v fd.
> + * The data array of struct tlob_event records begins at offset @data_of=
fset
> + * (always one page from the mmap base; use this field rather than hard-
> coding
> + * PAGE_SIZE so the code remains correct across architectures).
> + *
> + * Ring layout:
> + *
> + *=C2=A0=C2=A0 mmap base + 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 : struct tlob_mmap_page=C2=A0 (one page)
> + *=C2=A0=C2=A0 mmap base + data_offset=C2=A0=C2=A0 : struct tlob_event[c=
apacity]
> + *
> + * The mmap length determines the ring capacity.=C2=A0 Compute it as:
> + *
> + *=C2=A0=C2=A0 raw=C2=A0=C2=A0=C2=A0 =3D sysconf(_SC_PAGESIZE) + capacit=
y * sizeof(struct tlob_event)
> + *=C2=A0=C2=A0 length =3D (raw + sysconf(_SC_PAGESIZE) - 1) & ~(sysconf(=
_SC_PAGESIZE) -
> 1)
> + *
> + * i.e. round the raw byte count up to the next page boundary before
> + * passing it to mmap(2).=C2=A0 The kernel requires a page-aligned lengt=
h.
> + * capacity must be a power of 2.=C2=A0 Read @capacity after a successfu=
l
> + * mmap(2) for the actual value.
> + *
> + * Producer/consumer ordering contract:
> + *
> + *=C2=A0=C2=A0 Kernel (producer):
> + *=C2=A0=C2=A0=C2=A0=C2=A0 data[data_head & (capacity - 1)] =3D event;
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // pairs with load-acquire in userspace:
> + *=C2=A0=C2=A0=C2=A0=C2=A0 smp_store_release(&page->data_head, data_head=
 + 1);
> + *
> + *=C2=A0=C2=A0 Userspace (consumer):
> + *=C2=A0=C2=A0=C2=A0=C2=A0 // pairs with store-release in kernel:
> + *=C2=A0=C2=A0=C2=A0=C2=A0 head =3D __atomic_load_n(&page->data_head, __=
ATOMIC_ACQUIRE);
> + *=C2=A0=C2=A0=C2=A0=C2=A0 for (tail =3D page->data_tail; tail !=3D head=
; tail++)
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 handle(&data[tail & (=
capacity - 1)]);
> + *=C2=A0=C2=A0=C2=A0=C2=A0 __atomic_store_n(&page->data_tail, tail, __AT=
OMIC_RELEASE);
> + *
> + * @data_head and @data_tail are monotonically increasing __u32 counters
> + * in units of records.=C2=A0 Unsigned 32-bit wrap-around is handled cor=
rectly
> + * by modular arithmetic; the ring is full when
> + * (data_head - data_tail) =3D=3D capacity.
> + *
> + * When the ring is full the kernel drops the incoming record and increm=
ents
> + * @dropped.=C2=A0 The consumer should check @dropped periodically to de=
tect loss.
> + *
> + * read() and mmap() share the same ring buffer.=C2=A0 Do not use both
> + * simultaneously on the same fd.
> + *
> + * @data_head:=C2=A0=C2=A0 Next write slot index.=C2=A0 Updated by the k=
ernel with
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 store-release ordering.=C2=A0 Read by userspace with load-
> acquire.
> + * @data_tail:=C2=A0=C2=A0 Next read slot index.=C2=A0 Updated by usersp=
ace.=C2=A0 Read by the
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 kernel to detect overflow.
> + * @capacity:=C2=A0=C2=A0=C2=A0 Actual ring capacity in records (power o=
f 2).=C2=A0 Written once
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 by the kernel at mmap time; read-only for userspace
> thereafter.
> + * @version:=C2=A0=C2=A0=C2=A0=C2=A0 Ring buffer ABI version; currently =
1.
> + * @data_offset: Byte offset from the mmap base to the data array.
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Always equal to sysconf(_SC_PAGESIZE) on the running kernel=
.
> + * @record_size: sizeof(struct tlob_event) as seen by the kernel.=C2=A0 =
Verify
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 this matches userspace's sizeof before indexing the array.
> + * @dropped:=C2=A0=C2=A0=C2=A0=C2=A0 Number of events dropped because th=
e ring was full.
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Monotonically increasing; read with __ATOMIC_RELAXED.
> + */
> +struct tlob_mmap_page {
> +=09__u32=C2=A0 data_head;
> +=09__u32=C2=A0 data_tail;
> +=09__u32=C2=A0 capacity;
> +=09__u32=C2=A0 version;
> +=09__u32=C2=A0 data_offset;
> +=09__u32=C2=A0 record_size;
> +=09__u64=C2=A0 dropped;
> +};
> +
> +/*
> + * TLOB_IOCTL_TRACE_START - begin monitoring the calling task.
> + *
> + * Arms a per-task hrtimer for threshold_us microseconds.=C2=A0 If args.=
notify_fd
> + * is >=3D 0, a tlob_event record is pushed into that fd's ring buffer o=
n
> + * violation in addition to the tlob_budget_exceeded ftrace event.
> + * args.notify_fd =3D=3D -1 disables fd notification.
> + *
> + * Violation records are consumed by read() on the notify_fd (blocking o=
r
> + * non-blocking depending on O_NONBLOCK).=C2=A0 On violation,
> TLOB_IOCTL_TRACE_STOP
> + * also returns -EOVERFLOW regardless of whether notify_fd is set.
> + *
> + * args.flags must be 0.
> + */
> +#define TLOB_IOCTL_TRACE_START=09=09_IOW(RV_IOC_MAGIC, 0x01, struct
> tlob_start_args)
> +
> +/*
> + * TLOB_IOCTL_TRACE_STOP - end monitoring the calling task.
> + *
> + * Returns 0 if within budget, -EOVERFLOW if the budget was exceeded.
> + */
> +#define TLOB_IOCTL_TRACE_STOP=09=09_IO(RV_IOC_MAGIC,=C2=A0 0x02)
> +
> +#endif /* _UAPI_LINUX_RV_H */
> diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
> index 5b4be87ba..227573cda 100644
> --- a/kernel/trace/rv/Kconfig
> +++ b/kernel/trace/rv/Kconfig
> @@ -65,6 +65,7 @@ source "kernel/trace/rv/monitors/pagefault/Kconfig"
> =C2=A0source "kernel/trace/rv/monitors/sleep/Kconfig"
> =C2=A0# Add new rtapp monitors here
> =C2=A0
> +source "kernel/trace/rv/monitors/tlob/Kconfig"
> =C2=A0# Add new monitors here
> =C2=A0
> =C2=A0config RV_REACTORS
> @@ -93,3 +94,19 @@ config RV_REACT_PANIC
> =C2=A0=09help
> =C2=A0=09=C2=A0 Enables the panic reactor. The panic reactor emits a prin=
tk()
> =C2=A0=09=C2=A0 message if an exception is found and panic()s the system.
> +
> +config RV_CHARDEV
> +=09bool "RV ioctl interface via /dev/rv"
> +=09depends on RV
> +=09default n
> +=09help
> +=09=C2=A0 Register a /dev/rv misc device that exposes an ioctl interface
> +=09=C2=A0 for RV monitor self-instrumentation.=C2=A0 All RV monitors sha=
re the
> +=09=C2=A0 single device node; ioctl numbers encode the monitor identity.
> +
> +=09=C2=A0 When enabled, user-space programs can open /dev/rv and use
> +=09=C2=A0 monitor-specific ioctl commands to bracket code regions they
> +=09=C2=A0 want the kernel RV subsystem to observe.
> +
> +=09=C2=A0 Say Y here if you want to use the tlob self-instrumentation
> +=09=C2=A0 ioctl interface; otherwise say N.
> diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
> index 750e4ad6f..cc3781a3b 100644
> --- a/kernel/trace/rv/Makefile
> +++ b/kernel/trace/rv/Makefile
> @@ -3,6 +3,7 @@
> =C2=A0ccflags-y +=3D -I $(src)=09=09# needed for trace events
> =C2=A0
> =C2=A0obj-$(CONFIG_RV) +=3D rv.o
> +obj-$(CONFIG_RV_CHARDEV) +=3D rv_dev.o
> =C2=A0obj-$(CONFIG_RV_MON_WIP) +=3D monitors/wip/wip.o
> =C2=A0obj-$(CONFIG_RV_MON_WWNR) +=3D monitors/wwnr/wwnr.o
> =C2=A0obj-$(CONFIG_RV_MON_SCHED) +=3D monitors/sched/sched.o
> @@ -17,6 +18,7 @@ obj-$(CONFIG_RV_MON_STS) +=3D monitors/sts/sts.o
> =C2=A0obj-$(CONFIG_RV_MON_NRP) +=3D monitors/nrp/nrp.o
> =C2=A0obj-$(CONFIG_RV_MON_SSSW) +=3D monitors/sssw/sssw.o
> =C2=A0obj-$(CONFIG_RV_MON_OPID) +=3D monitors/opid/opid.o
> +obj-$(CONFIG_RV_MON_TLOB) +=3D monitors/tlob/tlob.o
> =C2=A0# Add new monitors here
> =C2=A0obj-$(CONFIG_RV_REACTORS) +=3D rv_reactors.o
> =C2=A0obj-$(CONFIG_RV_REACT_PRINTK) +=3D reactor_printk.o
> diff --git a/kernel/trace/rv/monitors/tlob/Kconfig
> b/kernel/trace/rv/monitors/tlob/Kconfig
> new file mode 100644
> index 000000000..010237480
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/Kconfig
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +config RV_MON_TLOB
> +=09depends on RV
> +=09depends on UPROBES
> +=09select DA_MON_EVENTS_ID
> +=09bool "tlob monitor"
> +=09help
> +=09=C2=A0 Enable the tlob (task latency over budget) monitor. This monit=
or
> +=09=C2=A0 tracks the elapsed time (CLOCK_MONOTONIC) of a marked code pat=
h
> within a
> +=09=C2=A0 task (including both on-CPU and off-CPU time) and reports a
> +=09=C2=A0 violation when the elapsed time exceeds a configurable budget
> +=09=C2=A0 threshold.
> +
> +=09=C2=A0 The monitor implements a three-state deterministic automaton.
> +=09=C2=A0 States: unmonitored, on_cpu, off_cpu.
> +=09=C2=A0 Key transitions:
> +=09=C2=A0=C2=A0=C2=A0 unmonitored=C2=A0=C2=A0=C2=A0 --(trace_start)-->=
=C2=A0=C2=A0=C2=A0 on_cpu
> +=09=C2=A0=C2=A0=C2=A0 on_cpu=C2=A0=C2=A0 --(switch_out)-->=C2=A0=C2=A0=
=C2=A0=C2=A0 off_cpu
> +=09=C2=A0=C2=A0=C2=A0 off_cpu=C2=A0 --(switch_in)-->=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 on_cpu
> +=09=C2=A0=C2=A0=C2=A0 on_cpu=C2=A0=C2=A0 --(trace_stop)-->=C2=A0=C2=A0=
=C2=A0 unmonitored
> +=09=C2=A0=C2=A0=C2=A0 off_cpu=C2=A0 --(trace_stop)-->=C2=A0=C2=A0=C2=A0 =
unmonitored
> +=09=C2=A0=C2=A0=C2=A0 on_cpu=C2=A0=C2=A0 --(budget_expired)--> unmonitor=
ed
> +=09=C2=A0=C2=A0=C2=A0 off_cpu=C2=A0 --(budget_expired)--> unmonitored
> +
> +=09=C2=A0 External configuration is done via the tracefs "monitor" file:
> +=09=C2=A0=C2=A0=C2=A0 echo pid:threshold_us:binary:offset_start:offset_s=
top >
> .../rv/monitors/tlob/monitor
> +=09=C2=A0=C2=A0=C2=A0 echo -pid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 > .../rv/monitors/tlob/monitor=C2=A0 (rem=
ove
> task)
> +=09=C2=A0=C2=A0=C2=A0 cat=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
 .../rv/monitors/tlob/monitor=C2=A0 (list
> tasks)
> +
> +=09=C2=A0 The uprobe binding places two plain entry uprobes at offset_st=
art
> and
> +=09=C2=A0 offset_stop in the binary; these trigger tlob_start_task() and
> +=09=C2=A0 tlob_stop_task() respectively.=C2=A0 Using two entry uprobes (=
rather
> than a
> +=09=C2=A0 uretprobe) means that a mistyped offset can never corrupt the =
call
> +=09=C2=A0 stack; the worst outcome is a missed stop, which causes the hr=
timer
> to
> +=09=C2=A0 fire and report a budget violation.
> +
> +=09=C2=A0 Violation events are delivered via a lock-free mmap ring buffe=
r on
> +=09=C2=A0 /dev/rv (enabled by CONFIG_RV_CHARDEV).=C2=A0 The consumer mma=
p()s the
> +=09=C2=A0 device, reads records from the data array using the head/tail
> indices
> +=09=C2=A0 in the control page, and advances data_tail when done.
> +
> +=09=C2=A0 For self-instrumentation, use TLOB_IOCTL_TRACE_START /
> +=09=C2=A0 TLOB_IOCTL_TRACE_STOP via the /dev/rv misc device (enabled by
> +=09=C2=A0 CONFIG_RV_CHARDEV).
> +
> +=09=C2=A0 Up to TLOB_MAX_MONITORED tasks may be monitored simultaneously=
.
> +
> +=09=C2=A0 For further information, see:
> +=09=C2=A0=C2=A0=C2=A0 Documentation/trace/rv/monitor_tlob.rst
> +
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.c
> b/kernel/trace/rv/monitors/tlob/tlob.c
> new file mode 100644
> index 000000000..a6e474025
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.c
> @@ -0,0 +1,986 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * tlob: task latency over budget monitor
> + *
> + * Track the elapsed wall-clock time of a marked code path and detect wh=
en
> + * a monitored task exceeds its per-task latency budget.=C2=A0 CLOCK_MON=
OTONIC
> + * is used so both on-CPU and off-CPU time count toward the budget.
> + *
> + * Per-task state is maintained in a spinlock-protected hash table.=C2=
=A0 A
> + * one-shot hrtimer fires at the deadline; if the task has not called
> + * trace_stop by then, a violation is recorded.
> + *
> + * Up to TLOB_MAX_MONITORED tasks may be tracked simultaneously.
> + *
> + * Copyright (C) 2026 Wen Yang <wen.yang@linux.dev>
> + */
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/ftrace.h>
> +#include <linux/hash.h>
> +#include <linux/hrtimer.h>
> +#include <linux/kernel.h>
> +#include <linux/ktime.h>
> +#include <linux/module.h>
> +#include <linux/init.h>
> +#include <linux/namei.h>
> +#include <linux/poll.h>
> +#include <linux/rv.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/atomic.h>
> +#include <linux/rcupdate.h>
> +#include <linux/spinlock.h>
> +#include <linux/tracefs.h>
> +#include <linux/uaccess.h>
> +#include <linux/uprobes.h>
> +#include <kunit/visibility.h>
> +#include <rv/instrumentation.h>
> +
> +/* rv_interface_lock is defined in kernel/trace/rv/rv.c */
> +extern struct mutex rv_interface_lock;
> +
> +#define MODULE_NAME "tlob"
> +
> +#include <rv_trace.h>
> +#include <trace/events/sched.h>
> +
> +#define RV_MON_TYPE RV_MON_PER_TASK
> +#include "tlob.h"
> +#include <rv/da_monitor.h>
> +
> +/* Hash table size; must be a power of two. */
> +#define TLOB_HTABLE_BITS=09=096
> +#define TLOB_HTABLE_SIZE=09=09(1 << TLOB_HTABLE_BITS)
> +
> +/* Maximum binary path length for uprobe binding. */
> +#define TLOB_MAX_PATH=09=09=09256
> +
> +/* Per-task latency monitoring state. */
> +struct tlob_task_state {
> +=09struct hlist_node=09hlist;
> +=09struct task_struct=09*task;
> +=09u64=09=09=09threshold_us;
> +=09u64=09=09=09tag;
> +=09struct hrtimer=09=09deadline_timer;
> +=09int=09=09=09canceled;=09/* protected by entry_lock */
> +=09struct file=09=09*notify_file;=09/* NULL or held reference */
> +
> +=09/*
> +=09 * entry_lock serialises the mutable accounting fields below.
> +=09 * Lock order: tlob_table_lock -> entry_lock (never reverse).
> +=09 */
> +=09raw_spinlock_t=09=09entry_lock;
> +=09u64=09=09=09on_cpu_us;
> +=09u64=09=09=09off_cpu_us;
> +=09ktime_t=09=09=09last_ts;
> +=09u32=09=09=09switches;
> +=09u8=09=09=09da_state;
> +
> +=09struct rcu_head=09=09rcu;=09/* for call_rcu() teardown */
> +};
> +
> +/* Per-uprobe-binding state: a start + stop probe pair for one binary re=
gion.
> */
> +struct tlob_uprobe_binding {
> +=09struct list_head=09list;
> +=09u64=09=09=09threshold_us;
> +=09struct path=09=09path;
> +=09char=09=09=09binpath[TLOB_MAX_PATH];=09/* canonical
> path for read/remove */
> +=09loff_t=09=09=09offset_start;
> +=09loff_t=09=09=09offset_stop;
> +=09struct uprobe_consumer=09entry_uc;
> +=09struct uprobe_consumer=09stop_uc;
> +=09struct uprobe=09=09*entry_uprobe;
> +=09struct uprobe=09=09*stop_uprobe;
> +};
> +
> +/* Object pool for tlob_task_state. */
> +static struct kmem_cache *tlob_state_cache;
> +
> +/* Hash table and lock protecting table structure (insert/delete/cancele=
d).
> */
> +static struct hlist_head tlob_htable[TLOB_HTABLE_SIZE];
> +static DEFINE_RAW_SPINLOCK(tlob_table_lock);
> +static atomic_t tlob_num_monitored =3D ATOMIC_INIT(0);
> +
> +/* Uprobe binding list; protected by tlob_uprobe_mutex. */
> +static LIST_HEAD(tlob_uprobe_list);
> +static DEFINE_MUTEX(tlob_uprobe_mutex);
> +
> +/* Forward declaration */
> +static enum hrtimer_restart tlob_deadline_timer_fn(struct hrtimer *timer=
);
> +
> +/* Hash table helpers */
> +
> +static unsigned int tlob_hash_task(const struct task_struct *task)
> +{
> +=09return hash_ptr((void *)task, TLOB_HTABLE_BITS);
> +}
> +
> +/*
> + * tlob_find_rcu - look up per-task state.
> + * Must be called under rcu_read_lock() or with tlob_table_lock held.
> + */
> +static struct tlob_task_state *tlob_find_rcu(struct task_struct *task)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned int h =3D tlob_hash_task(task);
> +
> +=09hlist_for_each_entry_rcu(ws, &tlob_htable[h], hlist,
> +=09=09=09=09 lockdep_is_held(&tlob_table_lock))
> +=09=09if (ws->task =3D=3D task)
> +=09=09=09return ws;
> +=09return NULL;
> +}
> +
> +/* Allocate and initialise a new per-task state entry. */
> +static struct tlob_task_state *tlob_alloc(struct task_struct *task,
> +=09=09=09=09=09=C2=A0 u64 threshold_us, u64 tag)
> +{
> +=09struct tlob_task_state *ws;
> +
> +=09ws =3D kmem_cache_zalloc(tlob_state_cache, GFP_ATOMIC);
> +=09if (!ws)
> +=09=09return NULL;
> +
> +=09ws->task =3D task;
> +=09get_task_struct(task);
> +=09ws->threshold_us =3D threshold_us;
> +=09ws->tag =3D tag;
> +=09ws->last_ts =3D ktime_get();
> +=09ws->da_state =3D on_cpu_tlob;
> +=09raw_spin_lock_init(&ws->entry_lock);
> +=09hrtimer_setup(&ws->deadline_timer, tlob_deadline_timer_fn,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 CLOCK_MONOTONIC, HRTIMER_MODE_REL);
> +=09return ws;
> +}
> +
> +/* RCU callback: free the slab once no readers remain. */
> +static void tlob_free_rcu_slab(struct rcu_head *head)
> +{
> +=09struct tlob_task_state *ws =3D
> +=09=09container_of(head, struct tlob_task_state, rcu);
> +=09kmem_cache_free(tlob_state_cache, ws);
> +}
> +
> +/* Arm the one-shot deadline timer for threshold_us microseconds. */
> +static void tlob_arm_deadline(struct tlob_task_state *ws)
> +{
> +=09hrtimer_start(&ws->deadline_timer,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ns_to_ktime(ws->threshold_us * NSEC=
_PER_USEC),
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 HRTIMER_MODE_REL);
> +}
> +
> +/*
> + * Push a violation record into a monitor fd's ring buffer (softirq cont=
ext).
> + * Drop-new policy: discard incoming record when full.=C2=A0 smp_store_r=
elease on
> + * data_head pairs with smp_load_acquire in the consumer.
> + */
> +static void tlob_event_push(struct rv_file_priv *priv,
> +=09=09=09=C2=A0=C2=A0=C2=A0 const struct tlob_event *info)
> +{
> +=09struct tlob_ring *ring =3D &priv->ring;
> +=09unsigned long flags;
> +=09u32 head, tail;
> +
> +=09spin_lock_irqsave(&ring->lock, flags);
> +
> +=09head =3D ring->page->data_head;
> +=09tail =3D READ_ONCE(ring->page->data_tail);
> +
> +=09if (head - tail > ring->mask) {
> +=09=09/* Ring full: drop incoming record. */
> +=09=09ring->page->dropped++;
> +=09=09spin_unlock_irqrestore(&ring->lock, flags);
> +=09=09return;
> +=09}
> +
> +=09ring->data[head & ring->mask] =3D *info;
> +=09/* pairs with smp_load_acquire() in the consumer */
> +=09smp_store_release(&ring->page->data_head, head + 1);
> +
> +=09spin_unlock_irqrestore(&ring->lock, flags);
> +
> +=09wake_up_interruptible_poll(&priv->waitq, EPOLLIN | EPOLLRDNORM);
> +}
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +void tlob_event_push_kunit(struct rv_file_priv *priv,
> +=09=09=09=C2=A0 const struct tlob_event *info)
> +{
> +=09tlob_event_push(priv, info);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_event_push_kunit);
> +#endif /* CONFIG_KUNIT */
> +
> +/*
> + * Budget exceeded: remove the entry, record the violation, and inject
> + * budget_expired into the DA.
> + *
> + * Lock order: tlob_table_lock -> entry_lock.=C2=A0 tlob_stop_task() set=
s
> + * ws->canceled under both locks; if we see it here the stop path owns
> cleanup.
> + * fput/put_task_struct are done before call_rcu(); the RCU callback onl=
y
> + * reclaims the slab.
> + */
> +static enum hrtimer_restart tlob_deadline_timer_fn(struct hrtimer *timer=
)
> +{
> +=09struct tlob_task_state *ws =3D
> +=09=09container_of(timer, struct tlob_task_state, deadline_timer);
> +=09struct tlob_event info =3D {};
> +=09struct file *notify_file;
> +=09struct task_struct *task;
> +=09unsigned long flags;
> +=09/* snapshots taken under entry_lock */
> +=09u64 on_cpu_us, off_cpu_us, threshold_us, tag;
> +=09u32 switches;
> +=09bool on_cpu;
> +=09bool push_event =3D false;
> +
> +=09raw_spin_lock_irqsave(&tlob_table_lock, flags);
> +=09/* stop path sets canceled under both locks; if set it owns cleanup
> */
> +=09if (ws->canceled) {
> +=09=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +=09=09return HRTIMER_NORESTART;
> +=09}
> +
> +=09/* Finalize accounting and snapshot all fields under entry_lock. */
> +=09raw_spin_lock(&ws->entry_lock);
> +
> +=09{
> +=09=09ktime_t now =3D ktime_get();
> +=09=09u64 delta_us =3D ktime_to_us(ktime_sub(now, ws->last_ts));
> +
> +=09=09if (ws->da_state =3D=3D on_cpu_tlob)
> +=09=09=09ws->on_cpu_us +=3D delta_us;
> +=09=09else
> +=09=09=09ws->off_cpu_us +=3D delta_us;
> +=09}
> +
> +=09ws->canceled=C2=A0 =3D 1;
> +=09on_cpu_us=C2=A0=C2=A0=C2=A0=C2=A0 =3D ws->on_cpu_us;
> +=09off_cpu_us=C2=A0=C2=A0=C2=A0 =3D ws->off_cpu_us;
> +=09threshold_us=C2=A0 =3D ws->threshold_us;
> +=09tag=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D w=
s->tag;
> +=09switches=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D ws->switches;
> +=09on_cpu=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D (ws->da_state =
=3D=3D on_cpu_tlob);
> +=09notify_file=C2=A0=C2=A0 =3D ws->notify_file;
> +=09if (notify_file) {
> +=09=09info.tid=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 task_pid_vnr(ws->task);
> +=09=09info.threshold_us =3D threshold_us;
> +=09=09info.on_cpu_us=C2=A0=C2=A0=C2=A0 =3D on_cpu_us;
> +=09=09info.off_cpu_us=C2=A0=C2=A0 =3D off_cpu_us;
> +=09=09info.switches=C2=A0=C2=A0=C2=A0=C2=A0 =3D switches;
> +=09=09info.state=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D on_cpu ? =
1 : 0;
> +=09=09info.tag=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D=
 tag;
> +=09=09push_event=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D true;
> +=09}
> +
> +=09raw_spin_unlock(&ws->entry_lock);
> +
> +=09hlist_del_rcu(&ws->hlist);
> +=09atomic_dec(&tlob_num_monitored);
> +=09/*
> +=09 * Hold a reference so task remains valid across da_handle_event()
> +=09 * after we drop tlob_table_lock.
> +=09 */
> +=09task =3D ws->task;
> +=09get_task_struct(task);
> +=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +
> +=09/*
> +=09 * Both locks are now released; ws is exclusively owned (removed from
> +=09 * the hash table with canceled=3D1).=C2=A0 Emit the tracepoint and p=
ush the
> +=09 * violation record.
> +=09 */
> +=09trace_tlob_budget_exceeded(ws->task, threshold_us, on_cpu_us,
> +=09=09=09=09=C2=A0=C2=A0 off_cpu_us, switches, on_cpu, tag);
> +
> +=09if (push_event) {
> +=09=09struct rv_file_priv *priv =3D notify_file->private_data;
> +
> +=09=09if (priv)
> +=09=09=09tlob_event_push(priv, &info);
> +=09}
> +
> +=09da_handle_event(task, budget_expired_tlob);
> +
> +=09if (notify_file)
> +=09=09fput(notify_file);=09=09/* ref from fget() at
> TRACE_START */
> +=09put_task_struct(ws->task);=09=09/* ref from tlob_alloc() */
> +=09put_task_struct(task);=09=09=09/* extra ref from
> get_task_struct() above */
> +=09call_rcu(&ws->rcu, tlob_free_rcu_slab);
> +=09return HRTIMER_NORESTART;
> +}
> +
> +/* Tracepoint handlers */
> +
> +/*
> + * handle_sched_switch - advance the DA and accumulate on/off-CPU time.
> + *
> + * RCU read-side for lock-free lookup; entry_lock for per-task accountin=
g.
> + * da_handle_event() is called after rcu_read_unlock() to avoid holding =
the
> + * read-side critical section across the RV framework.
> + */
> +static void handle_sched_switch(void *data, bool preempt,
> +=09=09=09=09struct task_struct *prev,
> +=09=09=09=09struct task_struct *next,
> +=09=09=09=09unsigned int prev_state)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned long flags;
> +=09bool do_prev =3D false, do_next =3D false;
> +=09ktime_t now;
> +
> +=09rcu_read_lock();
> +
> +=09ws =3D tlob_find_rcu(prev);
> +=09if (ws) {
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09if (!ws->canceled) {
> +=09=09=09now =3D ktime_get();
> +=09=09=09ws->on_cpu_us +=3D ktime_to_us(ktime_sub(now, ws-
> >last_ts));
> +=09=09=09ws->last_ts =3D now;
> +=09=09=09ws->switches++;
> +=09=09=09ws->da_state =3D off_cpu_tlob;
> +=09=09=09do_prev =3D true;
> +=09=09}
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +=09}
> +
> +=09ws =3D tlob_find_rcu(next);
> +=09if (ws) {
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09if (!ws->canceled) {
> +=09=09=09now =3D ktime_get();
> +=09=09=09ws->off_cpu_us +=3D ktime_to_us(ktime_sub(now, ws-
> >last_ts));
> +=09=09=09ws->last_ts =3D now;
> +=09=09=09ws->da_state =3D on_cpu_tlob;
> +=09=09=09do_next =3D true;
> +=09=09}
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +=09}
> +
> +=09rcu_read_unlock();
> +
> +=09if (do_prev)
> +=09=09da_handle_event(prev, switch_out_tlob);
> +=09if (do_next)
> +=09=09da_handle_event(next, switch_in_tlob);
> +}
> +
> +static void handle_sched_wakeup(void *data, struct task_struct *p)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned long flags;
> +=09bool found =3D false;
> +
> +=09rcu_read_lock();
> +=09ws =3D tlob_find_rcu(p);
> +=09if (ws) {
> +=09=09raw_spin_lock_irqsave(&ws->entry_lock, flags);
> +=09=09found =3D !ws->canceled;
> +=09=09raw_spin_unlock_irqrestore(&ws->entry_lock, flags);
> +=09}
> +=09rcu_read_unlock();
> +
> +=09if (found)
> +=09=09da_handle_event(p, sched_wakeup_tlob);
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * Core start/stop helpers (also called from rv_dev.c)
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +/*
> + * __tlob_insert - insert @ws into the hash table and arm its deadline t=
imer.
> + *
> + * Re-checks for duplicates and capacity under tlob_table_lock; the call=
er
> + * may have done a lock-free pre-check before allocating @ws.=C2=A0 On f=
ailure @ws
> + * is freed directly (never in table, so no call_rcu needed).
> + */
> +static int __tlob_insert(struct task_struct *task, struct tlob_task_stat=
e
> *ws)
> +{
> +=09unsigned int h;
> +=09unsigned long flags;
> +
> +=09raw_spin_lock_irqsave(&tlob_table_lock, flags);
> +=09if (tlob_find_rcu(task)) {
> +=09=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +=09=09if (ws->notify_file)
> +=09=09=09fput(ws->notify_file);
> +=09=09put_task_struct(ws->task);
> +=09=09kmem_cache_free(tlob_state_cache, ws);
> +=09=09return -EEXIST;
> +=09}
> +=09if (atomic_read(&tlob_num_monitored) >=3D TLOB_MAX_MONITORED) {
> +=09=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +=09=09if (ws->notify_file)
> +=09=09=09fput(ws->notify_file);
> +=09=09put_task_struct(ws->task);
> +=09=09kmem_cache_free(tlob_state_cache, ws);
> +=09=09return -ENOSPC;
> +=09}
> +=09h =3D tlob_hash_task(task);
> +=09hlist_add_head_rcu(&ws->hlist, &tlob_htable[h]);
> +=09atomic_inc(&tlob_num_monitored);
> +=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +
> +=09da_handle_start_run_event(task, trace_start_tlob);
> +=09tlob_arm_deadline(ws);
> +=09return 0;
> +}
> +
> +/**
> + * tlob_start_task - begin monitoring @task with latency budget
> @threshold_us.
> + *
> + * @notify_file: /dev/rv fd whose ring buffer receives a tlob_event on
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 violation; caller transfers the fget() reference to tlob.c.
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 Pass NULL for synchronous mode (violations only via
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 TRACE_STOP return value and the tlob_budget_exceeded event)=
.
> + *
> + * Returns 0, -ENODEV, -EEXIST, -ENOSPC, or -ENOMEM.=C2=A0 On failure th=
e caller
> + * retains responsibility for any @notify_file reference.
> + */
> +int tlob_start_task(struct task_struct *task, u64 threshold_us,
> +=09=09=C2=A0=C2=A0=C2=A0 struct file *notify_file, u64 tag)
> +{
> +=09struct tlob_task_state *ws;
> +=09unsigned long flags;
> +
> +=09if (!tlob_state_cache)
> +=09=09return -ENODEV;
> +
> +=09if (threshold_us > (u64)KTIME_MAX / NSEC_PER_USEC)
> +=09=09return -ERANGE;
> +
> +=09/* Quick pre-check before allocation. */
> +=09raw_spin_lock_irqsave(&tlob_table_lock, flags);
> +=09if (tlob_find_rcu(task)) {
> +=09=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +=09=09return -EEXIST;
> +=09}
> +=09if (atomic_read(&tlob_num_monitored) >=3D TLOB_MAX_MONITORED) {
> +=09=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +=09=09return -ENOSPC;
> +=09}
> +=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +
> +=09ws =3D tlob_alloc(task, threshold_us, tag);
> +=09if (!ws)
> +=09=09return -ENOMEM;
> +
> +=09ws->notify_file =3D notify_file;
> +=09return __tlob_insert(task, ws);
> +}
> +EXPORT_SYMBOL_GPL(tlob_start_task);
> +
> +/**
> + * tlob_stop_task - stop monitoring @task before the deadline fires.
> + *
> + * Sets canceled under entry_lock (inside tlob_table_lock) before callin=
g
> + * hrtimer_cancel(), racing safely with the timer callback.
> + *
> + * Returns 0 if within budget, -ESRCH if the entry is gone (deadline alr=
eady
> + * fired, or TRACE_START was never called).
> + */
> +int tlob_stop_task(struct task_struct *task)
> +{
> +=09struct tlob_task_state *ws;
> +=09struct file *notify_file;
> +=09unsigned long flags;
> +
> +=09raw_spin_lock_irqsave(&tlob_table_lock, flags);
> +=09ws =3D tlob_find_rcu(task);
> +=09if (!ws) {
> +=09=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +=09=09return -ESRCH;
> +=09}
> +
> +=09/* Prevent handle_sched_switch from updating accounting after
> removal. */
> +=09raw_spin_lock(&ws->entry_lock);
> +=09ws->canceled =3D 1;
> +=09raw_spin_unlock(&ws->entry_lock);
> +
> +=09hlist_del_rcu(&ws->hlist);
> +=09atomic_dec(&tlob_num_monitored);
> +=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +
> +=09hrtimer_cancel(&ws->deadline_timer);
> +
> +=09da_handle_event(task, trace_stop_tlob);
> +
> +=09notify_file =3D ws->notify_file;
> +=09if (notify_file)
> +=09=09fput(notify_file);
> +=09put_task_struct(ws->task);
> +=09call_rcu(&ws->rcu, tlob_free_rcu_slab);
> +
> +=09return 0;
> +}
> +EXPORT_SYMBOL_GPL(tlob_stop_task);
> +
> +/* Stop monitoring all tracked tasks; called on monitor disable. */
> +static void tlob_stop_all(void)
> +{
> +=09struct tlob_task_state *batch[TLOB_MAX_MONITORED];
> +=09struct tlob_task_state *ws;
> +=09struct hlist_node *tmp;
> +=09unsigned long flags;
> +=09int n =3D 0, i;
> +
> +=09raw_spin_lock_irqsave(&tlob_table_lock, flags);
> +=09for (i =3D 0; i < TLOB_HTABLE_SIZE; i++) {
> +=09=09hlist_for_each_entry_safe(ws, tmp, &tlob_htable[i], hlist) {
> +=09=09=09raw_spin_lock(&ws->entry_lock);
> +=09=09=09ws->canceled =3D 1;
> +=09=09=09raw_spin_unlock(&ws->entry_lock);
> +=09=09=09hlist_del_rcu(&ws->hlist);
> +=09=09=09atomic_dec(&tlob_num_monitored);
> +=09=09=09if (n < TLOB_MAX_MONITORED)
> +=09=09=09=09batch[n++] =3D ws;
> +=09=09}
> +=09}
> +=09raw_spin_unlock_irqrestore(&tlob_table_lock, flags);
> +
> +=09for (i =3D 0; i < n; i++) {
> +=09=09ws =3D batch[i];
> +=09=09hrtimer_cancel(&ws->deadline_timer);
> +=09=09da_handle_event(ws->task, trace_stop_tlob);
> +=09=09if (ws->notify_file)
> +=09=09=09fput(ws->notify_file);
> +=09=09put_task_struct(ws->task);
> +=09=09call_rcu(&ws->rcu, tlob_free_rcu_slab);
> +=09}
> +}
> +
> +/* uprobe binding helpers */
> +
> +static int tlob_uprobe_entry_handler(struct uprobe_consumer *uc,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data)
> +{
> +=09struct tlob_uprobe_binding *b =3D
> +=09=09container_of(uc, struct tlob_uprobe_binding, entry_uc);
> +
> +=09tlob_start_task(current, b->threshold_us, NULL, (u64)b-
> >offset_start);
> +=09return 0;
> +}
> +
> +static int tlob_uprobe_stop_handler(struct uprobe_consumer *uc,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 struct pt_regs *regs, __u64 *data)
> +{
> +=09tlob_stop_task(current);
> +=09return 0;
> +}
> +
> +/*
> + * Register start + stop entry uprobes for a binding.
> + * Both are plain entry uprobes (no uretprobe), so a wrong offset never
> + * corrupts the call stack; the worst outcome is a missed stop (hrtimer
> + * fires and reports a budget violation).
> + * Called with tlob_uprobe_mutex held.
> + */
> +static int tlob_add_uprobe(u64 threshold_us, const char *binpath,
> +=09=09=09=C2=A0=C2=A0 loff_t offset_start, loff_t offset_stop)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp_b;
> +=09char pathbuf[TLOB_MAX_PATH];
> +=09struct inode *inode;
> +=09char *canon;
> +=09int ret;
> +
> +=09b =3D kzalloc(sizeof(*b), GFP_KERNEL);
> +=09if (!b)
> +=09=09return -ENOMEM;
> +
> +=09if (binpath[0] !=3D '/') {
> +=09=09kfree(b);
> +=09=09return -EINVAL;
> +=09}
> +
> +=09b->threshold_us =3D threshold_us;
> +=09b->offset_start =3D offset_start;
> +=09b->offset_stop=C2=A0 =3D offset_stop;
> +
> +=09ret =3D kern_path(binpath, LOOKUP_FOLLOW, &b->path);
> +=09if (ret)
> +=09=09goto err_free;
> +
> +=09if (!d_is_reg(b->path.dentry)) {
> +=09=09ret =3D -EINVAL;
> +=09=09goto err_path;
> +=09}
> +
> +=09/* Reject duplicate start offset for the same binary. */
> +=09list_for_each_entry(tmp_b, &tlob_uprobe_list, list) {
> +=09=09if (tmp_b->offset_start =3D=3D offset_start &&
> +=09=09=C2=A0=C2=A0=C2=A0 tmp_b->path.dentry =3D=3D b->path.dentry) {
> +=09=09=09ret =3D -EEXIST;
> +=09=09=09goto err_path;
> +=09=09}
> +=09}
> +
> +=09/* Store canonical path for read-back and removal matching. */
> +=09canon =3D d_path(&b->path, pathbuf, sizeof(pathbuf));
> +=09if (IS_ERR(canon)) {
> +=09=09ret =3D PTR_ERR(canon);
> +=09=09goto err_path;
> +=09}
> +=09strscpy(b->binpath, canon, sizeof(b->binpath));
> +
> +=09b->entry_uc.handler =3D tlob_uprobe_entry_handler;
> +=09b->stop_uc.handler=C2=A0 =3D tlob_uprobe_stop_handler;
> +
> +=09inode =3D d_real_inode(b->path.dentry);
> +
> +=09b->entry_uprobe =3D uprobe_register(inode, offset_start, 0, &b-
> >entry_uc);
> +=09if (IS_ERR(b->entry_uprobe)) {
> +=09=09ret =3D PTR_ERR(b->entry_uprobe);
> +=09=09b->entry_uprobe =3D NULL;
> +=09=09goto err_path;
> +=09}
> +
> +=09b->stop_uprobe =3D uprobe_register(inode, offset_stop, 0, &b->stop_uc=
);
> +=09if (IS_ERR(b->stop_uprobe)) {
> +=09=09ret =3D PTR_ERR(b->stop_uprobe);
> +=09=09b->stop_uprobe =3D NULL;
> +=09=09goto err_entry;
> +=09}
> +
> +=09list_add_tail(&b->list, &tlob_uprobe_list);
> +=09return 0;
> +
> +err_entry:
> +=09uprobe_unregister_nosync(b->entry_uprobe, &b->entry_uc);
> +=09uprobe_unregister_sync();
> +err_path:
> +=09path_put(&b->path);
> +err_free:
> +=09kfree(b);
> +=09return ret;
> +}
> +
> +/*
> + * Remove the uprobe binding for (offset_start, binpath).
> + * binpath is resolved to a dentry for comparison so symlinks are handle=
d
> + * correctly.=C2=A0 Called with tlob_uprobe_mutex held.
> + */
> +static void tlob_remove_uprobe_by_key(loff_t offset_start, const char
> *binpath)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp;
> +=09struct path remove_path;
> +
> +=09if (kern_path(binpath, LOOKUP_FOLLOW, &remove_path))
> +=09=09return;
> +
> +=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
> +=09=09if (b->offset_start !=3D offset_start)
> +=09=09=09continue;
> +=09=09if (b->path.dentry !=3D remove_path.dentry)
> +=09=09=09continue;
> +=09=09uprobe_unregister_nosync(b->entry_uprobe, &b->entry_uc);
> +=09=09uprobe_unregister_nosync(b->stop_uprobe,=C2=A0 &b->stop_uc);
> +=09=09list_del(&b->list);
> +=09=09uprobe_unregister_sync();
> +=09=09path_put(&b->path);
> +=09=09kfree(b);
> +=09=09break;
> +=09}
> +
> +=09path_put(&remove_path);
> +}
> +
> +/* Unregister all uprobe bindings; called from disable_tlob(). */
> +static void tlob_remove_all_uprobes(void)
> +{
> +=09struct tlob_uprobe_binding *b, *tmp;
> +
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09list_for_each_entry_safe(b, tmp, &tlob_uprobe_list, list) {
> +=09=09uprobe_unregister_nosync(b->entry_uprobe, &b->entry_uc);
> +=09=09uprobe_unregister_nosync(b->stop_uprobe,=C2=A0 &b->stop_uc);
> +=09=09list_del(&b->list);
> +=09=09path_put(&b->path);
> +=09=09kfree(b);
> +=09}
> +=09mutex_unlock(&tlob_uprobe_mutex);
> +=09uprobe_unregister_sync();
> +}
> +
> +/*
> + * tracefs "monitor" file
> + *
> + * Read:=C2=A0 one "threshold_us:0xoffset_start:0xoffset_stop:binary_pat=
h\n"
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 line per registered uprobe =
binding.
> + * Write: "threshold_us:offset_start:offset_stop:binary_path" - add upro=
be
> binding
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 "-offset_start:binary_path"=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 - rem=
ove uprobe
> binding
> + */
> +
> +static ssize_t tlob_monitor_read(struct file *file,
> +=09=09=09=09 char __user *ubuf,
> +=09=09=09=09 size_t count, loff_t *ppos)
> +{
> +=09/* pid(10) + threshold(20) + 2 offsets(2*18) + path(256) + delimiters
> */
> +=09const int line_sz =3D TLOB_MAX_PATH + 72;
> +=09struct tlob_uprobe_binding *b;
> +=09char *buf, *p;
> +=09int n =3D 0, buf_sz, pos =3D 0;
> +=09ssize_t ret;
> +
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09list_for_each_entry(b, &tlob_uprobe_list, list)
> +=09=09n++;
> +=09mutex_unlock(&tlob_uprobe_mutex);
> +
> +=09buf_sz =3D (n ? n : 1) * line_sz + 1;
> +=09buf =3D kmalloc(buf_sz, GFP_KERNEL);
> +=09if (!buf)
> +=09=09return -ENOMEM;
> +
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09list_for_each_entry(b, &tlob_uprobe_list, list) {
> +=09=09p =3D b->binpath;
> +=09=09pos +=3D scnprintf(buf + pos, buf_sz - pos,
> +=09=09=09=09 "%llu:0x%llx:0x%llx:%s\n",
> +=09=09=09=09 b->threshold_us,
> +=09=09=09=09 (unsigned long long)b->offset_start,
> +=09=09=09=09 (unsigned long long)b->offset_stop,
> +=09=09=09=09 p);
> +=09}
> +=09mutex_unlock(&tlob_uprobe_mutex);
> +
> +=09ret =3D simple_read_from_buffer(ubuf, count, ppos, buf, pos);
> +=09kfree(buf);
> +=09return ret;
> +}
> +
> +/*
> + * Parse "threshold_us:offset_start:offset_stop:binary_path".
> + * binary_path comes last so it may freely contain ':'.
> + * Returns 0 on success.
> + */
> +VISIBLE_IF_KUNIT int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 char **path_out,
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 loff_t *start_out, loff_t
> *stop_out)
> +{
> +=09unsigned long long thr;
> +=09long long start, stop;
> +=09int n =3D 0;
> +
> +=09/*
> +=09 * %llu : decimal-only (microseconds)
> +=09 * %lli : auto-base, accepts 0x-prefixed hex for offsets
> +=09 * %n=C2=A0=C2=A0 : records the byte offset of the first path charact=
er
> +=09 */
> +=09if (sscanf(buf, "%llu:%lli:%lli:%n", &thr, &start, &stop, &n) !=3D 3)
> +=09=09return -EINVAL;
> +=09if (thr =3D=3D 0 || n =3D=3D 0 || buf[n] =3D=3D '\0')
> +=09=09return -EINVAL;
> +=09if (start < 0 || stop < 0)
> +=09=09return -EINVAL;
> +
> +=09*thr_out=C2=A0=C2=A0 =3D thr;
> +=09*start_out =3D start;
> +=09*stop_out=C2=A0 =3D stop;
> +=09*path_out=C2=A0 =3D buf + n;
> +=09return 0;
> +}
> +
> +static ssize_t tlob_monitor_write(struct file *file,
> +=09=09=09=09=C2=A0 const char __user *ubuf,
> +=09=09=09=09=C2=A0 size_t count, loff_t *ppos)
> +{
> +=09char buf[TLOB_MAX_PATH + 64];
> +=09loff_t offset_start, offset_stop;
> +=09u64 threshold_us;
> +=09char *binpath;
> +=09int ret;
> +
> +=09if (count >=3D sizeof(buf))
> +=09=09return -EINVAL;
> +=09if (copy_from_user(buf, ubuf, count))
> +=09=09return -EFAULT;
> +=09buf[count] =3D '\0';
> +
> +=09if (count > 0 && buf[count - 1] =3D=3D '\n')
> +=09=09buf[count - 1] =3D '\0';
> +
> +=09/* Remove request: "-offset_start:binary_path" */
> +=09if (buf[0] =3D=3D '-') {
> +=09=09long long off;
> +=09=09int n =3D 0;
> +
> +=09=09if (sscanf(buf + 1, "%lli:%n", &off, &n) !=3D 1 || n =3D=3D 0)
> +=09=09=09return -EINVAL;
> +=09=09binpath =3D buf + 1 + n;
> +=09=09if (binpath[0] !=3D '/')
> +=09=09=09return -EINVAL;
> +
> +=09=09mutex_lock(&tlob_uprobe_mutex);
> +=09=09tlob_remove_uprobe_by_key((loff_t)off, binpath);
> +=09=09mutex_unlock(&tlob_uprobe_mutex);
> +
> +=09=09return (ssize_t)count;
> +=09}
> +
> +=09/*
> +=09 * Uprobe binding:
> "threshold_us:offset_start:offset_stop:binary_path"
> +=09 * binpath points into buf at the start of the path field.
> +=09 */
> +=09ret =3D tlob_parse_uprobe_line(buf, &threshold_us,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 &binpath, &offset_start, &offset_st=
op);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09mutex_lock(&tlob_uprobe_mutex);
> +=09ret =3D tlob_add_uprobe(threshold_us, binpath, offset_start,
> offset_stop);
> +=09mutex_unlock(&tlob_uprobe_mutex);
> +=09return ret ? ret : (ssize_t)count;
> +}
> +
> +static const struct file_operations tlob_monitor_fops =3D {
> +=09.open=09=3D simple_open,
> +=09.read=09=3D tlob_monitor_read,
> +=09.write=09=3D tlob_monitor_write,
> +=09.llseek=09=3D noop_llseek,
> +};
> +
> +/*
> + * __tlob_init_monitor / __tlob_destroy_monitor - called with
> rv_interface_lock
> + * held (required by da_monitor_init/destroy via
> rv_get/put_task_monitor_slot).
> + */
> +static int __tlob_init_monitor(void)
> +{
> +=09int i, retval;
> +
> +=09tlob_state_cache =3D kmem_cache_create("tlob_task_state",
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 sizeof(struct tlob_task_state),
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0 0, 0, NULL);
> +=09if (!tlob_state_cache)
> +=09=09return -ENOMEM;
> +
> +=09for (i =3D 0; i < TLOB_HTABLE_SIZE; i++)
> +=09=09INIT_HLIST_HEAD(&tlob_htable[i]);
> +=09atomic_set(&tlob_num_monitored, 0);
> +
> +=09retval =3D da_monitor_init();
> +=09if (retval) {
> +=09=09kmem_cache_destroy(tlob_state_cache);
> +=09=09tlob_state_cache =3D NULL;
> +=09=09return retval;
> +=09}
> +
> +=09rv_this.enabled =3D 1;
> +=09return 0;
> +}
> +
> +static void __tlob_destroy_monitor(void)
> +{
> +=09rv_this.enabled =3D 0;
> +=09tlob_stop_all();
> +=09tlob_remove_all_uprobes();
> +=09/*
> +=09 * Drain pending call_rcu() callbacks from tlob_stop_all() before
> +=09 * destroying the kmem_cache.
> +=09 */
> +=09synchronize_rcu();
> +=09da_monitor_destroy();
> +=09kmem_cache_destroy(tlob_state_cache);
> +=09tlob_state_cache =3D NULL;
> +}
> +
> +/*
> + * tlob_init_monitor / tlob_destroy_monitor - KUnit wrappers that acquir=
e
> + * rv_interface_lock, satisfying the lockdep_assert_held() inside
> + * rv_get/put_task_monitor_slot().
> + */
> +VISIBLE_IF_KUNIT int tlob_init_monitor(void)
> +{
> +=09int ret;
> +
> +=09mutex_lock(&rv_interface_lock);
> +=09ret =3D __tlob_init_monitor();
> +=09mutex_unlock(&rv_interface_lock);
> +=09return ret;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_init_monitor);
> +
> +VISIBLE_IF_KUNIT void tlob_destroy_monitor(void)
> +{
> +=09mutex_lock(&rv_interface_lock);
> +=09__tlob_destroy_monitor();
> +=09mutex_unlock(&rv_interface_lock);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_destroy_monitor);
> +
> +VISIBLE_IF_KUNIT int tlob_enable_hooks(void)
> +{
> +=09rv_attach_trace_probe("tlob", sched_switch, handle_sched_switch);
> +=09rv_attach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
> +=09return 0;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_enable_hooks);
> +
> +VISIBLE_IF_KUNIT void tlob_disable_hooks(void)
> +{
> +=09rv_detach_trace_probe("tlob", sched_switch, handle_sched_switch);
> +=09rv_detach_trace_probe("tlob", sched_wakeup, handle_sched_wakeup);
> +}
> +EXPORT_SYMBOL_IF_KUNIT(tlob_disable_hooks);
> +
> +/*
> + * enable_tlob / disable_tlob - called by rv_enable/disable_monitor() wh=
ich
> + * already holds rv_interface_lock; call the __ variants directly.
> + */
> +static int enable_tlob(void)
> +{
> +=09int retval;
> +
> +=09retval =3D __tlob_init_monitor();
> +=09if (retval)
> +=09=09return retval;
> +
> +=09return tlob_enable_hooks();
> +}
> +
> +static void disable_tlob(void)
> +{
> +=09tlob_disable_hooks();
> +=09__tlob_destroy_monitor();
> +}
> +
> +static struct rv_monitor rv_this =3D {
> +=09.name=09=09=3D "tlob",
> +=09.description=09=3D "Per-task latency-over-budget monitor.",
> +=09.enable=09=09=3D enable_tlob,
> +=09.disable=09=3D disable_tlob,
> +=09.reset=09=09=3D da_monitor_reset_all,
> +=09.enabled=09=3D 0,
> +};
> +
> +static int __init register_tlob(void)
> +{
> +=09int ret;
> +
> +=09ret =3D rv_register_monitor(&rv_this, NULL);
> +=09if (ret)
> +=09=09return ret;
> +
> +=09if (rv_this.root_d) {
> +=09=09tracefs_create_file("monitor", 0644, rv_this.root_d, NULL,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0 &tlob_monitor_fops);
> +=09}
> +
> +=09return 0;
> +}
> +
> +static void __exit unregister_tlob(void)
> +{
> +=09rv_unregister_monitor(&rv_this);
> +}
> +
> +module_init(register_tlob);
> +module_exit(unregister_tlob);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_AUTHOR("Wen Yang <wen.yang@linux.dev>");
> +MODULE_DESCRIPTION("tlob: task latency over budget per-task monitor.");
> diff --git a/kernel/trace/rv/monitors/tlob/tlob.h
> b/kernel/trace/rv/monitors/tlob/tlob.h
> new file mode 100644
> index 000000000..3438a6175
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob.h
> @@ -0,0 +1,145 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _RV_TLOB_H
> +#define _RV_TLOB_H
> +
> +/*
> + * C representation of the tlob automaton, generated from tlob.dot via r=
vgen
> + * and extended with tlob_start_task()/tlob_stop_task() declarations.
> + * For the format description see
> Documentation/trace/rv/deterministic_automata.rst
> + */
> +
> +#include <linux/rv.h>
> +#include <uapi/linux/rv.h>
> +
> +#define MONITOR_NAME tlob
> +
> +enum states_tlob {
> +=09unmonitored_tlob,
> +=09on_cpu_tlob,
> +=09off_cpu_tlob,
> +=09state_max_tlob,
> +};
> +
> +#define INVALID_STATE state_max_tlob
> +
> +enum events_tlob {
> +=09trace_start_tlob,
> +=09switch_in_tlob,
> +=09switch_out_tlob,
> +=09sched_wakeup_tlob,
> +=09trace_stop_tlob,
> +=09budget_expired_tlob,
> +=09event_max_tlob,
> +};
> +
> +struct automaton_tlob {
> +=09char *state_names[state_max_tlob];
> +=09char *event_names[event_max_tlob];
> +=09unsigned char function[state_max_tlob][event_max_tlob];
> +=09unsigned char initial_state;
> +=09bool final_states[state_max_tlob];
> +};
> +
> +static const struct automaton_tlob automaton_tlob =3D {
> +=09.state_names =3D {
> +=09=09"unmonitored",
> +=09=09"on_cpu",
> +=09=09"off_cpu",
> +=09},
> +=09.event_names =3D {
> +=09=09"trace_start",
> +=09=09"switch_in",
> +=09=09"switch_out",
> +=09=09"sched_wakeup",
> +=09=09"trace_stop",
> +=09=09"budget_expired",
> +=09},
> +=09.function =3D {
> +=09=09/* unmonitored */
> +=09=09{
> +=09=09=09on_cpu_tlob,=09=09/* trace_start=C2=A0=C2=A0=C2=A0 */
> +=09=09=09unmonitored_tlob,=09/* switch_in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
*/
> +=09=09=09unmonitored_tlob,=09/* switch_out=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=09=09=09unmonitored_tlob,=09/* sched_wakeup=C2=A0=C2=A0 */
> +=09=09=09INVALID_STATE,=09=09/* trace_stop=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=09=09=09INVALID_STATE,=09=09/* budget_expired */
> +=09=09},
> +=09=09/* on_cpu */
> +=09=09{
> +=09=09=09INVALID_STATE,=09=09/* trace_start=C2=A0=C2=A0=C2=A0 */
> +=09=09=09INVALID_STATE,=09=09/* switch_in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
*/
> +=09=09=09off_cpu_tlob,=09=09/* switch_out=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=09=09=09on_cpu_tlob,=09=09/* sched_wakeup=C2=A0=C2=A0 */
> +=09=09=09unmonitored_tlob,=09/* trace_stop=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=09=09=09unmonitored_tlob,=09/* budget_expired */
> +=09=09},
> +=09=09/* off_cpu */
> +=09=09{
> +=09=09=09INVALID_STATE,=09=09/* trace_start=C2=A0=C2=A0=C2=A0 */
> +=09=09=09on_cpu_tlob,=09=09/* switch_in=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=09=09=09off_cpu_tlob,=09=09/* switch_out=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=09=09=09off_cpu_tlob,=09=09/* sched_wakeup=C2=A0=C2=A0 */
> +=09=09=09unmonitored_tlob,=09/* trace_stop=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=09=09=09unmonitored_tlob,=09/* budget_expired */
> +=09=09},
> +=09},
> +=09/*
> +=09 * final_states: unmonitored is the sole accepting state.
> +=09 * Violations are recorded via ntf_push and tlob_budget_exceeded.
> +=09 */
> +=09.initial_state =3D unmonitored_tlob,
> +=09.final_states =3D { 1, 0, 0 },
> +};
> +
> +/* Exported for use by the RV ioctl layer (rv_dev.c) */
> +int tlob_start_task(struct task_struct *task, u64 threshold_us,
> +=09=09=C2=A0=C2=A0=C2=A0 struct file *notify_file, u64 tag);
> +int tlob_stop_task(struct task_struct *task);
> +
> +/* Maximum number of concurrently monitored tasks (also used by KUnit). =
*/
> +#define TLOB_MAX_MONITORED=0964U
> +
> +/*
> + * Ring buffer constants (also published in UAPI for mmap size calculati=
on).
> + */
> +#define TLOB_RING_DEFAULT_CAP=0964U=09/* records allocated at open()=C2=
=A0 */
> +#define TLOB_RING_MIN_CAP=09 8U=09/* minimum accepted by mmap()=C2=A0=C2=
=A0 */
> +#define TLOB_RING_MAX_CAP=094096U=09/* maximum accepted by mmap()=C2=A0=
=C2=A0 */
> +
> +/**
> + * struct tlob_ring - per-fd mmap-capable violation ring buffer.
> + *
> + * Allocated as a contiguous page range at rv_open() time:
> + *=C2=A0=C2=A0 page 0:=C2=A0=C2=A0=C2=A0 struct tlob_mmap_page=C2=A0 (sh=
ared with userspace)
> + *=C2=A0=C2=A0 pages 1-N: struct tlob_event[capacity]
> + */
> +struct tlob_ring {
> +=09struct tlob_mmap_page=09*page;
> +=09struct tlob_event=09*data;
> +=09u32=09=09=09 mask;
> +=09spinlock_t=09=09 lock;
> +=09unsigned long=09=09 base;
> +=09unsigned int=09=09 order;
> +};
> +
> +/**
> + * struct rv_file_priv - per-fd private data for /dev/rv.
> + */
> +struct rv_file_priv {
> +=09struct tlob_ring=09ring;
> +=09wait_queue_head_t=09waitq;
> +};
> +
> +#if IS_ENABLED(CONFIG_KUNIT)
> +int tlob_init_monitor(void);
> +void tlob_destroy_monitor(void);
> +int tlob_enable_hooks(void);
> +void tlob_disable_hooks(void);
> +void tlob_event_push_kunit(struct rv_file_priv *priv,
> +=09=09=09=C2=A0 const struct tlob_event *info);
> +int tlob_parse_uprobe_line(char *buf, u64 *thr_out,
> +=09=09=09=C2=A0=C2=A0 char **path_out,
> +=09=09=09=C2=A0=C2=A0 loff_t *start_out, loff_t *stop_out);
> +#endif /* CONFIG_KUNIT */
> +
> +#endif /* _RV_TLOB_H */
> diff --git a/kernel/trace/rv/monitors/tlob/tlob_trace.h
> b/kernel/trace/rv/monitors/tlob/tlob_trace.h
> new file mode 100644
> index 000000000..b08d67776
> --- /dev/null
> +++ b/kernel/trace/rv/monitors/tlob/tlob_trace.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +/*
> + * Snippet to be included in rv_trace.h
> + */
> +
> +#ifdef CONFIG_RV_MON_TLOB
> +/*
> + * tlob uses the generic event_da_monitor_id and error_da_monitor_id eve=
nt
> + * classes so that both event classes are instantiated.=C2=A0 This avoid=
s a
> + * -Werror=3Dunused-variable warning that the compiler emits when a
> + * DECLARE_EVENT_CLASS has no corresponding DEFINE_EVENT instance.
> + *
> + * The event_tlob tracepoint is defined here but the call-site in
> + * da_handle_event() is overridden with a no-op macro below so that no
> + * trace record is emitted on every scheduler context switch.=C2=A0 Budg=
et
> + * violations are reported via the dedicated tlob_budget_exceeded event.
> + *
> + * error_tlob IS kept active so that invalid DA transitions (programming
> + * errors) are still visible in the ftrace ring buffer for debugging.
> + */
> +DEFINE_EVENT(event_da_monitor_id, event_tlob,
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(int id, char *state, char *event, c=
har *next_state,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 bool final_state),
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(id, state, event, next_state, final_=
state));
> +
> +DEFINE_EVENT(error_da_monitor_id, error_tlob,
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_PROTO(int id, char *state, char *event),
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 TP_ARGS(id, state, event));
> +
> +/*
> + * Override the trace_event_tlob() call-site with a no-op after the
> + * DEFINE_EVENT above has satisfied the event class instantiation
> + * requirement.=C2=A0 The tracepoint symbol itself exists (and can be en=
abled
> + * via tracefs) but the automatic call from da_handle_event() is silence=
d
> + * to avoid per-context-switch ftrace noise during normal operation.
> + */
> +#undef trace_event_tlob
> +#define trace_event_tlob(id, state, event, next_state, final_state)=09\
> +=09do { (void)(id); (void)(state); (void)(event);=09=09=09\
> +=09=C2=A0=C2=A0=C2=A0=C2=A0 (void)(next_state); (void)(final_state); } w=
hile (0)
> +#endif /* CONFIG_RV_MON_TLOB */
> diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
> index ee4e68102..e754e76d5 100644
> --- a/kernel/trace/rv/rv.c
> +++ b/kernel/trace/rv/rv.c
> @@ -148,6 +148,10 @@
> =C2=A0#include <rv_trace.h>
> =C2=A0#endif
> =C2=A0
> +#ifdef CONFIG_RV_MON_TLOB
> +EXPORT_TRACEPOINT_SYMBOL_GPL(tlob_budget_exceeded);
> +#endif
> +
> =C2=A0#include "rv.h"
> =C2=A0
> =C2=A0DEFINE_MUTEX(rv_interface_lock);
> diff --git a/kernel/trace/rv/rv_dev.c b/kernel/trace/rv/rv_dev.c
> new file mode 100644
> index 000000000..a052f3203
> --- /dev/null
> +++ b/kernel/trace/rv/rv_dev.c
> @@ -0,0 +1,602 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * rv_dev.c - /dev/rv misc device for RV monitor self-instrumentation
> + *
> + * A single misc device (MISC_DYNAMIC_MINOR) serves all RV monitors.
> + * ioctl numbers encode the monitor identity:
> + *
> + *=C2=A0=C2=A0 0x01 - 0x1F=C2=A0 tlob (task latency over budget)
> + *=C2=A0=C2=A0 0x20 - 0x3F=C2=A0 reserved
> + *
> + * Each monitor exports tlob_start_task() / tlob_stop_task() which are
> + * called here.=C2=A0 The calling task is identified by current.
> + *
> + * Magic: RV_IOC_MAGIC (0xB9), defined in include/uapi/linux/rv.h
> + *
> + * Per-fd private data (rv_file_priv)
> + * ------------------------------------
> + * Every open() of /dev/rv allocates an rv_file_priv (defined in tlob.h)=
.
> + * When TLOB_IOCTL_TRACE_START is called with args.notify_fd >=3D 0, vio=
lations
> + * are pushed as tlob_event records into that fd's per-fd ring buffer
> (tlob_ring)
> + * and its poll/epoll waitqueue is woken.
> + *
> + * Consumers drain records with read() on the notify_fd; read() blocks u=
ntil
> + * at least one record is available (unless O_NONBLOCK is set).
> + *
> + * Per-thread "started" tracking (tlob_task_handle)
> + * -------------------------------------------------
> + * tlob_stop_task() returns -ESRCH in two distinct situations:
> + *
> + *=C2=A0=C2=A0 (a) The deadline timer already fired and removed the tlob=
 hash-table
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 entry before TRACE_STOP arrived -=
> budget was exceeded -> -EOVERFLOW
> + *
> + *=C2=A0=C2=A0 (b) TRACE_START was never called for this thread -> progr=
amming error
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -> -ESRCH
> + *
> + * To distinguish them, rv_dev.c maintains a lightweight hash table
> + * (tlob_handles) that records a tlob_task_handle for every task_struct =
*
> + * for which a successful TLOB_IOCTL_TRACE_START has been
> + * issued but the corresponding TLOB_IOCTL_TRACE_STOP has not yet arrive=
d.
> + *
> + * tlob_task_handle is a thin "session ticket"=C2=A0 --=C2=A0 it carries=
 only the
> + * task pointer and the owning file descriptor.=C2=A0 The heavy per-task=
 state
> + * (hrtimer, DA state, threshold) lives in tlob_task_state inside tlob.c=
.
> + *
> + * The table is keyed on task_struct * (same key as tlob.c), protected
> + * by tlob_handles_lock (spinlock, irq-safe).=C2=A0 No get_task_struct()
> + * refcount is needed here because tlob.c already holds a reference for
> + * each live entry.
> + *
> + * Multiple threads may share the same fd.=C2=A0 Each thread has its own
> + * tlob_task_handle in the table, so concurrent TRACE_START / TRACE_STOP
> + * calls from different threads do not interfere.
> + *
> + * The fd release path (rv_release) calls tlob_stop_task() for every
> + * handle in tlob_handles that belongs to the closing fd, ensuring clean=
up
> + * even if the user forgets to call TRACE_STOP.
> + */
> +#include <linux/file.h>
> +#include <linux/fs.h>
> +#include <linux/gfp.h>
> +#include <linux/hash.h>
> +#include <linux/mm.h>
> +#include <linux/miscdevice.h>
> +#include <linux/module.h>
> +#include <linux/poll.h>
> +#include <linux/sched.h>
> +#include <linux/slab.h>
> +#include <linux/spinlock.h>
> +#include <linux/uaccess.h>
> +#include <uapi/linux/rv.h>
> +
> +#ifdef CONFIG_RV_MON_TLOB
> +#include "monitors/tlob/tlob.h"
> +#endif
> +
> +/* ---------------------------------------------------------------------=
--
> + * tlob_task_handle - per-thread session ticket for the ioctl interface
> + *
> + * One handle is allocated by TLOB_IOCTL_TRACE_START and freed by
> + * TLOB_IOCTL_TRACE_STOP (or by rv_release if the fd is closed).
> + *
> + * @hlist:=C2=A0 Hash-table linkage in tlob_handles (keyed on task point=
er).
> + * @task:=C2=A0=C2=A0 The monitored thread.=C2=A0 Plain pointer; no refc=
ount held here
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 because tlob.c =
holds one for the lifetime of the monitoring
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 window, which e=
ncompasses the lifetime of this handle.
> + * @file:=C2=A0=C2=A0 The /dev/rv file descriptor that issued TRACE_STAR=
T.
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Used by rv_rele=
ase() to sweep orphaned handles on close().
> + * ---------------------------------------------------------------------=
--
> + */
> +#define TLOB_HANDLES_BITS=095
> +#define TLOB_HANDLES_SIZE=09(1 << TLOB_HANDLES_BITS)
> +
> +struct tlob_task_handle {
> +=09struct hlist_node=09hlist;
> +=09struct task_struct=09*task;
> +=09struct file=09=09*file;
> +};
> +
> +static struct hlist_head tlob_handles[TLOB_HANDLES_SIZE];
> +static DEFINE_SPINLOCK(tlob_handles_lock);
> +
> +static unsigned int tlob_handle_hash(const struct task_struct *task)
> +{
> +=09return hash_ptr((void *)task, TLOB_HANDLES_BITS);
> +}
> +
> +/* Must be called with tlob_handles_lock held. */
> +static struct tlob_task_handle *
> +tlob_handle_find_locked(struct task_struct *task)
> +{
> +=09struct tlob_task_handle *h;
> +=09unsigned int slot =3D tlob_handle_hash(task);
> +
> +=09hlist_for_each_entry(h, &tlob_handles[slot], hlist) {
> +=09=09if (h->task =3D=3D task)
> +=09=09=09return h;
> +=09}
> +=09return NULL;
> +}
> +
> +/*
> + * tlob_handle_alloc - record that @task has an active monitoring sessio=
n
> + *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 opened via @file.
> + *
> + * Returns 0 on success, -EEXIST if @task already has a handle (double
> + * TRACE_START without TRACE_STOP), -ENOMEM on allocation failure.
> + */
> +static int tlob_handle_alloc(struct task_struct *task, struct file *file=
)
> +{
> +=09struct tlob_task_handle *h;
> +=09unsigned long flags;
> +=09unsigned int slot;
> +
> +=09h =3D kmalloc(sizeof(*h), GFP_KERNEL);
> +=09if (!h)
> +=09=09return -ENOMEM;
> +=09h->task =3D task;
> +=09h->file =3D file;
> +
> +=09spin_lock_irqsave(&tlob_handles_lock, flags);
> +=09if (tlob_handle_find_locked(task)) {
> +=09=09spin_unlock_irqrestore(&tlob_handles_lock, flags);
> +=09=09kfree(h);
> +=09=09return -EEXIST;
> +=09}
> +=09slot =3D tlob_handle_hash(task);
> +=09hlist_add_head(&h->hlist, &tlob_handles[slot]);
> +=09spin_unlock_irqrestore(&tlob_handles_lock, flags);
> +=09return 0;
> +}
> +
> +/*
> + * tlob_handle_free - remove the handle for @task and free it.
> + *
> + * Returns 1 if a handle existed (TRACE_START was called), 0 if not foun=
d
> + * (TRACE_START was never called for this thread).
> + */
> +static int tlob_handle_free(struct task_struct *task)
> +{
> +=09struct tlob_task_handle *h;
> +=09unsigned long flags;
> +
> +=09spin_lock_irqsave(&tlob_handles_lock, flags);
> +=09h =3D tlob_handle_find_locked(task);
> +=09if (h) {
> +=09=09hlist_del_init(&h->hlist);
> +=09=09spin_unlock_irqrestore(&tlob_handles_lock, flags);
> +=09=09kfree(h);
> +=09=09return 1;
> +=09}
> +=09spin_unlock_irqrestore(&tlob_handles_lock, flags);
> +=09return 0;
> +}
> +
> +/*
> + * tlob_handle_sweep_file - release all handles owned by @file.
> + *
> + * Called from rv_release() when the fd is closed without TRACE_STOP.
> + * Calls tlob_stop_task() for each orphaned handle to drain the tlob
> + * monitoring entries and prevent resource leaks in tlob.c.
> + *
> + * Handles are collected under the lock (short critical section), then
> + * processed outside it (tlob_stop_task() may sleep/spin internally).
> + */
> +#ifdef CONFIG_RV_MON_TLOB
> +static void tlob_handle_sweep_file(struct file *file)
> +{
> +=09struct tlob_task_handle *batch[TLOB_HANDLES_SIZE];
> +=09struct tlob_task_handle *h;
> +=09struct hlist_node *tmp;
> +=09unsigned long flags;
> +=09int i, n =3D 0;
> +
> +=09spin_lock_irqsave(&tlob_handles_lock, flags);
> +=09for (i =3D 0; i < TLOB_HANDLES_SIZE; i++) {
> +=09=09hlist_for_each_entry_safe(h, tmp, &tlob_handles[i], hlist) {
> +=09=09=09if (h->file =3D=3D file) {
> +=09=09=09=09hlist_del_init(&h->hlist);
> +=09=09=09=09batch[n++] =3D h;
> +=09=09=09}
> +=09=09}
> +=09}
> +=09spin_unlock_irqrestore(&tlob_handles_lock, flags);
> +
> +=09for (i =3D 0; i < n; i++) {
> +=09=09/*
> +=09=09 * Ignore -ESRCH: the deadline timer may have already fired
> +=09=09 * and cleaned up the tlob entry.
> +=09=09 */
> +=09=09tlob_stop_task(batch[i]->task);
> +=09=09kfree(batch[i]);
> +=09}
> +}
> +#else
> +static inline void tlob_handle_sweep_file(struct file *file) {}
> +#endif /* CONFIG_RV_MON_TLOB */
> +
> +/* ---------------------------------------------------------------------=
--
> + * Ring buffer lifecycle
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +/*
> + * tlob_ring_alloc - allocate a ring of @cap records (must be a power of=
 2).
> + *
> + * Allocates a physically contiguous block of pages:
> + *=C2=A0=C2=A0 page 0=C2=A0=C2=A0=C2=A0=C2=A0 : struct tlob_mmap_page=C2=
=A0 (control page, shared with
> userspace)
> + *=C2=A0=C2=A0 pages 1..N : struct tlob_event[cap] (data pages)
> + *
> + * Each page is marked reserved so it can be mapped to userspace via mma=
p().
> + */
> +static int tlob_ring_alloc(struct tlob_ring *ring, u32 cap)
> +{
> +=09unsigned int total =3D PAGE_SIZE + cap * sizeof(struct tlob_event);
> +=09unsigned int order =3D get_order(total);
> +=09unsigned long base;
> +=09unsigned int i;
> +
> +=09base =3D __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> +=09if (!base)
> +=09=09return -ENOMEM;
> +
> +=09for (i =3D 0; i < (1u << order); i++)
> +=09=09SetPageReserved(virt_to_page((void *)(base + i *
> PAGE_SIZE)));
> +
> +=09ring->base=C2=A0 =3D base;
> +=09ring->order =3D order;
> +=09ring->page=C2=A0 =3D (struct tlob_mmap_page *)base;
> +=09ring->data=C2=A0 =3D (struct tlob_event *)(base + PAGE_SIZE);
> +=09ring->mask=C2=A0 =3D cap - 1;
> +=09spin_lock_init(&ring->lock);
> +
> +=09ring->page->capacity=C2=A0=C2=A0=C2=A0 =3D cap;
> +=09ring->page->version=C2=A0=C2=A0=C2=A0=C2=A0 =3D 1;
> +=09ring->page->data_offset =3D PAGE_SIZE;
> +=09ring->page->record_size =3D sizeof(struct tlob_event);
> +=09return 0;
> +}
> +
> +static void tlob_ring_free(struct tlob_ring *ring)
> +{
> +=09unsigned int i;
> +
> +=09if (!ring->base)
> +=09=09return;
> +
> +=09for (i =3D 0; i < (1u << ring->order); i++)
> +=09=09ClearPageReserved(virt_to_page((void *)(ring->base + i *
> PAGE_SIZE)));
> +
> +=09free_pages(ring->base, ring->order);
> +=09ring->base =3D 0;
> +=09ring->page =3D NULL;
> +=09ring->data =3D NULL;
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * File operations
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +static int rv_open(struct inode *inode, struct file *file)
> +{
> +=09struct rv_file_priv *priv;
> +=09int ret;
> +
> +=09priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
> +=09if (!priv)
> +=09=09return -ENOMEM;
> +
> +=09ret =3D tlob_ring_alloc(&priv->ring, TLOB_RING_DEFAULT_CAP);
> +=09if (ret) {
> +=09=09kfree(priv);
> +=09=09return ret;
> +=09}
> +
> +=09init_waitqueue_head(&priv->waitq);
> +=09file->private_data =3D priv;
> +=09return 0;
> +}
> +
> +static int rv_release(struct inode *inode, struct file *file)
> +{
> +=09struct rv_file_priv *priv =3D file->private_data;
> +
> +=09tlob_handle_sweep_file(file);
> +=09tlob_ring_free(&priv->ring);
> +=09kfree(priv);
> +=09file->private_data =3D NULL;
> +=09return 0;
> +}
> +
> +static __poll_t rv_poll(struct file *file, poll_table *wait)
> +{
> +=09struct rv_file_priv *priv =3D file->private_data;
> +
> +=09if (!priv)
> +=09=09return EPOLLERR;
> +
> +=09poll_wait(file, &priv->waitq, wait);
> +
> +=09/*
> +=09 * Pairs with smp_store_release(&ring->page->data_head, ...) in
> +=09 * tlob_event_push().=C2=A0 No lock needed: head is written by the ke=
rnel
> +=09 * producer and read here; tail is written by the consumer and we
> only
> +=09 * need an approximate check for the poll fast path.
> +=09 */
> +=09if (smp_load_acquire(&priv->ring.page->data_head) !=3D
> +=09=C2=A0=C2=A0=C2=A0 READ_ONCE(priv->ring.page->data_tail))
> +=09=09return EPOLLIN | EPOLLRDNORM;
> +
> +=09return 0;
> +}
> +
> +/*
> + * rv_read - consume tlob_event violation records from this fd's ring bu=
ffer.
> + *
> + * Each read() returns a whole number of struct tlob_event records.=C2=
=A0 @count
> must
> + * be at least sizeof(struct tlob_event); partial-record sizes are rejec=
ted
> with
> + * -EINVAL.
> + *
> + * Blocking behaviour follows O_NONBLOCK on the fd:
> + *=C2=A0=C2=A0 O_NONBLOCK clear: blocks until at least one record is ava=
ilable.
> + *=C2=A0=C2=A0 O_NONBLOCK set:=C2=A0=C2=A0 returns -EAGAIN immediately i=
f the ring is empty.
> + *
> + * Returns the number of bytes copied (always a multiple of sizeof
> tlob_event),
> + * -EAGAIN if non-blocking and empty, or a negative error code.
> + *
> + * read() and mmap() share the same ring and data_tail cursor; do not us=
e
> + * both simultaneously on the same fd.
> + */
> +static ssize_t rv_read(struct file *file, char __user *buf, size_t count=
,
> +=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 loff_t *ppos)
> +{
> +=09struct rv_file_priv *priv =3D file->private_data;
> +=09struct tlob_ring *ring;
> +=09size_t rec =3D sizeof(struct tlob_event);
> +=09unsigned long irqflags;
> +=09ssize_t done =3D 0;
> +=09int ret;
> +
> +=09if (!priv)
> +=09=09return -ENODEV;
> +
> +=09ring =3D &priv->ring;
> +
> +=09if (count < rec)
> +=09=09return -EINVAL;
> +
> +=09/* Blocking path: sleep until the producer advances data_head. */
> +=09if (!(file->f_flags & O_NONBLOCK)) {
> +=09=09ret =3D wait_event_interruptible(priv->waitq,
> +=09=09=09/* pairs with smp_store_release() in the producer */
> +=09=09=09smp_load_acquire(&ring->page->data_head) !=3D
> +=09=09=09READ_ONCE(ring->page->data_tail));
> +=09=09if (ret)
> +=09=09=09return ret;
> +=09}
> +
> +=09/*
> +=09 * Drain records into the caller's buffer.=C2=A0 ring->lock serialise=
s
> +=09 * concurrent read() callers and the softirq producer.
> +=09 */
> +=09while (done + rec <=3D count) {
> +=09=09struct tlob_event record;
> +=09=09u32 head, tail;
> +
> +=09=09spin_lock_irqsave(&ring->lock, irqflags);
> +=09=09/* pairs with smp_store_release() in the producer */
> +=09=09head =3D smp_load_acquire(&ring->page->data_head);
> +=09=09tail =3D ring->page->data_tail;
> +=09=09if (head =3D=3D tail) {
> +=09=09=09spin_unlock_irqrestore(&ring->lock, irqflags);
> +=09=09=09break;
> +=09=09}
> +=09=09record =3D ring->data[tail & ring->mask];
> +=09=09WRITE_ONCE(ring->page->data_tail, tail + 1);
> +=09=09spin_unlock_irqrestore(&ring->lock, irqflags);
> +
> +=09=09if (copy_to_user(buf + done, &record, rec))
> +=09=09=09return done ? done : -EFAULT;
> +=09=09done +=3D rec;
> +=09}
> +
> +=09return done ? done : -EAGAIN;
> +}
> +
> +/*
> + * rv_mmap - map the per-fd violation ring buffer into userspace.
> + *
> + * The mmap region covers the full ring allocation:
> + *
> + *=C2=A0=C2=A0 offset 0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 : struct tlob_mmap_page=C2=A0 (control page)
> + *=C2=A0=C2=A0 offset PAGE_SIZE=C2=A0 : struct tlob_event[capacity]=C2=
=A0 (data pages)
> + *
> + * The caller must map exactly PAGE_SIZE + capacity * sizeof(struct
> tlob_event)
> + * bytes starting at offset 0 (vm_pgoff must be 0).=C2=A0 The actual cap=
acity is
> + * read from tlob_mmap_page.capacity after a successful mmap(2).
> + *
> + * Private mappings (MAP_PRIVATE) are rejected: the shared data_tail fie=
ld
> + * written by userspace must be visible to the kernel producer.
> + */
> +static int rv_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +=09struct rv_file_priv *priv =3D file->private_data;
> +=09struct tlob_ring=C2=A0=C2=A0=C2=A0 *ring;
> +=09unsigned long=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 size =3D vma-=
>vm_end - vma->vm_start;
> +=09unsigned long=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_size;
> +
> +=09if (!priv)
> +=09=09return -ENODEV;
> +
> +=09ring =3D &priv->ring;
> +
> +=09if (vma->vm_pgoff !=3D 0)
> +=09=09return -EINVAL;
> +
> +=09ring_size =3D PAGE_ALIGN(PAGE_SIZE + ((unsigned long)(ring->mask + 1)=
 *
> +=09=09=09=09=09=C2=A0=C2=A0=C2=A0 sizeof(struct tlob_event)));
> +=09if (size !=3D ring_size)
> +=09=09return -EINVAL;
> +
> +=09if (!(vma->vm_flags & VM_SHARED))
> +=09=09return -EINVAL;
> +
> +=09return remap_pfn_range(vma, vma->vm_start,
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 page_to_pfn(virt_to_page((=
void *)ring->base)),
> +=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ring_size, vma->vm_page_pr=
ot);
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * ioctl dispatcher
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +static long rv_ioctl(struct file *file, unsigned int cmd, unsigned long =
arg)
> +{
> +=09unsigned int nr =3D _IOC_NR(cmd);
> +
> +=09/*
> +=09 * Verify the magic byte so we don't accidentally handle ioctls
> +=09 * intended for a different device.
> +=09 */
> +=09if (_IOC_TYPE(cmd) !=3D RV_IOC_MAGIC)
> +=09=09return -ENOTTY;
> +
> +#ifdef CONFIG_RV_MON_TLOB
> +=09/* tlob: ioctl numbers 0x01 - 0x1F */
> +=09switch (cmd) {
> +=09case TLOB_IOCTL_TRACE_START: {
> +=09=09struct tlob_start_args args;
> +=09=09struct file *notify_file =3D NULL;
> +=09=09int ret, hret;
> +
> +=09=09if (copy_from_user(&args,
> +=09=09=09=09=C2=A0=C2=A0 (struct tlob_start_args __user *)arg,
> +=09=09=09=09=C2=A0=C2=A0 sizeof(args)))
> +=09=09=09return -EFAULT;
> +=09=09if (args.threshold_us =3D=3D 0)
> +=09=09=09return -EINVAL;
> +=09=09if (args.flags !=3D 0)
> +=09=09=09return -EINVAL;
> +
> +=09=09/*
> +=09=09 * If notify_fd >=3D 0, resolve it to a file pointer.
> +=09=09 * fget() bumps the reference count; tlob.c drops it
> +=09=09 * via fput() when the monitoring window ends.
> +=09=09 * Reject non-/dev/rv fds to prevent type confusion.
> +=09=09 */
> +=09=09if (args.notify_fd >=3D 0) {
> +=09=09=09notify_file =3D fget(args.notify_fd);
> +=09=09=09if (!notify_file)
> +=09=09=09=09return -EBADF;
> +=09=09=09if (notify_file->f_op !=3D file->f_op) {
> +=09=09=09=09fput(notify_file);
> +=09=09=09=09return -EINVAL;
> +=09=09=09}
> +=09=09}
> +
> +=09=09ret =3D tlob_start_task(current, args.threshold_us,
> +=09=09=09=09=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 notify_file, args.tag);
> +=09=09if (ret !=3D 0) {
> +=09=09=09/* tlob.c did not take ownership; drop ref. */
> +=09=09=09if (notify_file)
> +=09=09=09=09fput(notify_file);
> +=09=09=09return ret;
> +=09=09}
> +
> +=09=09/*
> +=09=09 * Record session handle.=C2=A0 Free any stale handle left by
> +=09=09 * a previous window whose deadline timer fired (timer
> +=09=09 * removes tlob_task_state but cannot touch tlob_handles).
> +=09=09 */
> +=09=09tlob_handle_free(current);
> +=09=09hret =3D tlob_handle_alloc(current, file);
> +=09=09if (hret < 0) {
> +=09=09=09tlob_stop_task(current);
> +=09=09=09return hret;
> +=09=09}
> +=09=09return 0;
> +=09}
> +=09case TLOB_IOCTL_TRACE_STOP: {
> +=09=09int had_handle;
> +=09=09int ret;
> +
> +=09=09/*
> +=09=09 * Atomically remove the session handle for current.
> +=09=09 *
> +=09=09 *=C2=A0=C2=A0 had_handle =3D=3D 0: TRACE_START was never called f=
or
> +=09=09 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 this thread -> caller b=
ug -> -ESRCH
> +=09=09 *
> +=09=09 *=C2=A0=C2=A0 had_handle =3D=3D 1: TRACE_START was called.=C2=A0 =
If
> +=09=09 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 tlob_stop_task() now re=
turns
> +=09=09 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -ESRCH, the deadline ti=
mer already
> +=09=09 *=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 fired -> budget exceede=
d -> -EOVERFLOW
> +=09=09 */
> +=09=09had_handle =3D tlob_handle_free(current);
> +=09=09if (!had_handle)
> +=09=09=09return -ESRCH;
> +
> +=09=09ret =3D tlob_stop_task(current);
> +=09=09return (ret =3D=3D -ESRCH) ? -EOVERFLOW : ret;
> +=09}
> +=09default:
> +=09=09break;
> +=09}
> +#endif /* CONFIG_RV_MON_TLOB */
> +
> +=09return -ENOTTY;
> +}
> +
> +/* ---------------------------------------------------------------------=
--
> + * Module init / exit
> + * ---------------------------------------------------------------------=
--
> + */
> +
> +static const struct file_operations rv_fops =3D {
> +=09.owner=09=09=3D THIS_MODULE,
> +=09.open=09=09=3D rv_open,
> +=09.release=09=3D rv_release,
> +=09.read=09=09=3D rv_read,
> +=09.poll=09=09=3D rv_poll,
> +=09.mmap=09=09=3D rv_mmap,
> +=09.unlocked_ioctl=09=3D rv_ioctl,
> +#ifdef CONFIG_COMPAT
> +=09.compat_ioctl=09=3D rv_ioctl,
> +#endif
> +=09.llseek=09=09=3D noop_llseek,
> +};
> +
> +/*
> + * 0666: /dev/rv is a self-instrumentation device.=C2=A0 All ioctls oper=
ate
> + * exclusively on the calling task (current); no task can monitor anothe=
r
> + * via this interface.=C2=A0 Opening the device does not grant any privi=
lege
> + * beyond observing one's own latency, so world-read/write is appropriat=
e.
> + */
> +static struct miscdevice rv_miscdev =3D {
> +=09.minor=09=3D MISC_DYNAMIC_MINOR,
> +=09.name=09=3D "rv",
> +=09.fops=09=3D &rv_fops,
> +=09.mode=09=3D 0666,
> +};
> +
> +static int __init rv_ioctl_init(void)
> +{
> +=09int i;
> +
> +=09for (i =3D 0; i < TLOB_HANDLES_SIZE; i++)
> +=09=09INIT_HLIST_HEAD(&tlob_handles[i]);
> +
> +=09return misc_register(&rv_miscdev);
> +}
> +
> +static void __exit rv_ioctl_exit(void)
> +{
> +=09misc_deregister(&rv_miscdev);
> +}
> +
> +module_init(rv_ioctl_init);
> +module_exit(rv_ioctl_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("RV ioctl interface via /dev/rv");
> diff --git a/kernel/trace/rv/rv_trace.h b/kernel/trace/rv/rv_trace.h
> index 4a6faddac..65d6c6485 100644
> --- a/kernel/trace/rv/rv_trace.h
> +++ b/kernel/trace/rv/rv_trace.h
> @@ -126,6 +126,7 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
> =C2=A0#include <monitors/snroc/snroc_trace.h>
> =C2=A0#include <monitors/nrp/nrp_trace.h>
> =C2=A0#include <monitors/sssw/sssw_trace.h>
> +#include <monitors/tlob/tlob_trace.h>
> =C2=A0// Add new monitors based on CONFIG_DA_MON_EVENTS_ID here
> =C2=A0
> =C2=A0#endif /* CONFIG_DA_MON_EVENTS_ID */
> @@ -202,6 +203,55 @@ TRACE_EVENT(rv_retries_error,
> =C2=A0=09=09__get_str(event), __get_str(name))
> =C2=A0);
> =C2=A0#endif /* CONFIG_RV_MON_MAINTENANCE_EVENTS */
> +
> +#ifdef CONFIG_RV_MON_TLOB
> +/*
> + * tlob_budget_exceeded - emitted when a monitored task exceeds its late=
ncy
> + * budget.=C2=A0 Carries the on-CPU / off-CPU time breakdown so that the=
 cause
> + * of the overrun (CPU-bound vs. scheduling/I/O latency) is immediately
> + * visible in the ftrace ring buffer without post-processing.
> + */
> +TRACE_EVENT(tlob_budget_exceeded,
> +
> +=09TP_PROTO(struct task_struct *task, u64 threshold_us,
> +=09=09 u64 on_cpu_us, u64 off_cpu_us, u32 switches,
> +=09=09 bool state_is_on_cpu, u64 tag),
> +
> +=09TP_ARGS(task, threshold_us, on_cpu_us, off_cpu_us, switches,
> +=09=09state_is_on_cpu, tag),
> +
> +=09TP_STRUCT__entry(
> +=09=09__string(comm,=09=09task->comm)
> +=09=09__field(pid_t,=09=09pid)
> +=09=09__field(u64,=09=09threshold_us)
> +=09=09__field(u64,=09=09on_cpu_us)
> +=09=09__field(u64,=09=09off_cpu_us)
> +=09=09__field(u32,=09=09switches)
> +=09=09__field(bool,=09=09state_is_on_cpu)
> +=09=09__field(u64,=09=09tag)
> +=09),
> +
> +=09TP_fast_assign(
> +=09=09__assign_str(comm);
> +=09=09__entry->pid=09=09=3D task->pid;
> +=09=09__entry->threshold_us=09=3D threshold_us;
> +=09=09__entry->on_cpu_us=09=3D on_cpu_us;
> +=09=09__entry->off_cpu_us=09=3D off_cpu_us;
> +=09=09__entry->switches=09=3D switches;
> +=09=09__entry->state_is_on_cpu =3D state_is_on_cpu;
> +=09=09__entry->tag=09=09=3D tag;
> +=09),
> +
> +=09TP_printk("%s[%d]: budget exceeded threshold=3D%llu on_cpu=3D%llu
> off_cpu=3D%llu switches=3D%u state=3D%s tag=3D0x%016llx",
> +=09=09__get_str(comm), __entry->pid,
> +=09=09__entry->threshold_us,
> +=09=09__entry->on_cpu_us, __entry->off_cpu_us,
> +=09=09__entry->switches,
> +=09=09__entry->state_is_on_cpu ? "on_cpu" : "off_cpu",
> +=09=09__entry->tag)
> +);
> +#endif /* CONFIG_RV_MON_TLOB */
> +
> =C2=A0#endif /* _TRACE_RV_H */
> =C2=A0
> =C2=A0/* This part must be outside protection */

