Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 929701FF7D7
	for <linux-trace-kernel@vger.kernel.org>; Tue,  7 Oct 2025 18:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759861189; cv=none; b=ZZ+C25SAzOvpjXjRSA2FaJjIIf2484UK3rQ0csZjvL/CO9Ss0aXyFj1i328mZmxuY393cE76TSeLOAs8e/jQ9XCC3MpRkXfIlxCDiblPwYV7eDFnR2Oc+7G3mPcT2AqYXuTYjBQ5khrj19rbtuZ/fdecNsbLZFXR0yk+2qKgckY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759861189; c=relaxed/simple;
	bh=IVqEvsVTUvX2jwOw2TI5EYYaO5oPHB99rIwU+g37kOU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hXsG+S9bT4me62ZJWhrpzM/+LZJKmxTYjCTQzJtsHcGVYkZCQ/sqJVSbMxuINRootOUS6qecA+nWJj4WF74W4LBWIStuzgmSLOiU2Nr0gqL0I+SdVyBcPkAa/9Vz3lbvEGyhQacpG+ZyvQBPX81zHmAvbTyDMi6K2CH6H+3Bo4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AOfahSZX; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AOfahSZX"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-71d603a9cfaso71075677b3.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 07 Oct 2025 11:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1759861186; x=1760465986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QpRN8feqqsElTzLcm8W2XosrV9uz7ywy4cSoDnu6iQU=;
        b=AOfahSZX/OVO/qiBtcbWKTd23P7v6SJ+YQcWyRIcgwOERZuZerVpFkTo44CGuGBCoI
         He7yWgbx3v9VtvSA1jlvpeGHsRtyaU3NIn4u8vmKbj3JhnWpykTOR9FE26T83kvq97Ur
         m5p6D8gss2UcEI6I0DtKkkVsLwHTJF/mHyUWp7WaUmtpkLmVxNmkXzOjvwGUN1ntPAos
         /OKPrt0PqidGP7PSaoV62EZxvop9Ro1r1BpUC0So+yfpC/iPyNpaCU3f7+z0sAI1UPRi
         5o3SbK/rJ1FwFEEBQjc3Mr1CkHfVt2H8tzmYT5G4qCkggaT+Fw7xyEPViOymvTFk2tF3
         +3Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759861186; x=1760465986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QpRN8feqqsElTzLcm8W2XosrV9uz7ywy4cSoDnu6iQU=;
        b=PWuoeaYO5+hMtlL8sd41mW0eA9etZpEmpOA+U2jjifHcupolrogkccu+x89arj6hvX
         fBSU0K13RzOsL2yIPH+vvVHwz/cnfggO1BVSP7eol53F3iledDyZX47n0njGzhBN9enQ
         T3iEvhxa9swgYbuUS63Sz/ZVey502NhCwC/Li8o1NVeeF4SI5+BdXyUoC28XZtfHwplH
         s3fzC2eLWQiJaIyeKWOlouWGL8xx9KmCn7uKYYTri0rM22ccKXc7QlPSzmJ9d4U9PPWR
         GZq4LUy8FlhkU9H7KGpMMCZxtf+9W7/O/TwuQoNaRoMGoh3Waby7XiAo9X/ErvRPh1h8
         wIIg==
X-Forwarded-Encrypted: i=1; AJvYcCXuRk41flQSWDiPQ2Jyp/cMKenw4jLDFdGe3jwO5Eda+Km0yPCs+wBBANcms6ftboI3GNByyC5YQQnRIsL1u1WFCjk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUiTck5596+w26ABhI3UBAQR7M8GhLpqQbY2EnDqppjDO+WMV9
	sVSGrQkvJFk67sRGFYE+BnvyGzBStSBn9ni1PQhQyFl4audufCyjhseDOqzdoe/obujUdaWgwkW
	Z+77I2igJePfNzcwUG8DjKISaLQQpVMk7/4FLSNQE
X-Gm-Gg: ASbGncthmGvOdx//LxUO9IE5Xoo+TN7HzEowoYqiWp2dZcu8iK5labcZ52EY6Ictpkh
	VdL9dMz27Bv/gwTnNxS1r6LbAqKRt5xsNYKds36XKA3RCRufcpMYALGViW740wvV1McXr1WRdmS
	HWG/PbLW/i3YWc28EaXPYhxbSGU0SsE0pQFks4N19tlp1XLUdr0iwknDr4UR04+JqdAVicfy/xt
	zQA7TQBQXMz2qS8zp3KWDSoSMk32QaDh2GGuk1lKH9kBGqG+i6FiRm0OJ4P7/nHDKsnjeV1LQL6
	cezLi/MSZD6Nlw==
X-Google-Smtp-Source: AGHT+IHmnWRPd1ss0ygaevLRNtl5Gxq2B+MPydv3Ris/6UTKaORAxfSjZgrqGsCx7T5ydjyxJGnOiVeVkgDs6SCCIy8=
X-Received: by 2002:a53:bd52:0:b0:636:5bf:2e30 with SMTP id
 956f58d0204a3-63ccb8dba95mr426506d50.38.1759861186047; Tue, 07 Oct 2025
 11:19:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007003417.3470979-2-runpinglai@google.com> <20251006221043.07cdb0fd@gandalf.local.home>
In-Reply-To: <20251006221043.07cdb0fd@gandalf.local.home>
From: Runping Lai <runpinglai@google.com>
Date: Tue, 7 Oct 2025 11:19:34 -0700
X-Gm-Features: AS18NWCYZSrDjScKnxfB6EhPqKQ5Q-Y1_UuIogq3KVwEYQ9HtyLxCPJJqTTf_vU
Message-ID: <CABgk4RQwGsn4CdP0K+_7A0j7RVOiHNfoF1ESk17wEuzCea16pA@mail.gmail.com>
Subject: Re: [PATCH v1] Revert "tracing: Fix tracing_marker may trigger page
 fault during preempt_disable"
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Wattson CI <wattson-external@google.com>, kernel-team@android.com, 
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	Luo Gengkun <luogengkun@huaweicloud.com>, Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 7:08=E2=80=AFPM Steven Rostedt <rostedt@goodmis.org>=
 wrote:
>
> On Tue,  7 Oct 2025 00:34:17 +0000
> Runping Lai <runpinglai@google.com> wrote:
>
> > This reverts commit 3d62ab32df065e4a7797204a918f6489ddb8a237.
> >
> > It's observed on Pixel 6 that this commit causes a severe functional
> > regression: all user-space writes to trace_marker now fail. The write
> > does not goes through at all. The error is observed in the shell as
> > 'printf: write: Bad address'. This breaks a primary ftrace interface
> > for user-space debugging and profiling. In kernel trace file, it's
> > logged as 'tracing_mark_write: <faulted>'. After reverting this commit,
> > functionality is restored.
>
> This is very interesting. The copy is being done in an atomic context. If
> the fault had to do anything other than update a page table, it is likely
> not to do anything and return a fault.
>
> What preemption model is Pixel 6 running in? CONFIG_PREEMPT_NONE?

Hey Steve,

On Pixel6, CONFIG_PREEMPT is set. And CONFIG_PREEMPT_NONE
is not set. I'll paste the full PREEMPT configs:

~/aosp_kernel > common/scripts/extract-ikconfig
out/slider/dist/vmlinux | less | grep PREEMPT
CONFIG_PREEMPT_BUILD=3Dy
CONFIG_ARCH_HAS_PREEMPT_LAZY=3Dy
# CONFIG_PREEMPT_NONE is not set
# CONFIG_PREEMPT_VOLUNTARY is not set
CONFIG_PREEMPT=3Dy
# CONFIG_PREEMPT_LAZY is not set
# CONFIG_PREEMPT_RT is not set
CONFIG_PREEMPT_COUNT=3Dy
CONFIG_PREEMPTION=3Dy
# CONFIG_PREEMPT_DYNAMIC is not set
CONFIG_PREEMPT_RCU=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
CONFIG_HAVE_PREEMPT_DYNAMIC_KEY=3Dy
CONFIG_PREEMPT_NOTIFIERS=3Dy
# CONFIG_DEBUG_PREEMPT is not set
CONFIG_PREEMPTIRQ_TRACEPOINTS=3Dy
# CONFIG_PREEMPT_TRACER is not set
# CONFIG_PREEMPTIRQ_DELAY_TEST is not set

>
> The original code is buggy, but if this is causing a regression, then we
> likely need to do something else, like copy in a pre-allocated buffer?

Sounds like a good plan. Before the long term fix, can we please
revert this commit?

Best,
Runping

>
> -- Steve
>
>
> >
> > Signed-off-by: Runping Lai <runpinglai@google.com>
> > Reported-by: Wattson CI <wattson-external@google.com>
> > ---
> >  kernel/trace/trace.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> > index 156e7e0bf559..bb9a6284a629 100644
> > --- a/kernel/trace/trace.c
> > +++ b/kernel/trace/trace.c
> > @@ -7213,7 +7213,7 @@ static ssize_t write_marker_to_buffer(struct trac=
e_array *tr, const char __user
> >       entry =3D ring_buffer_event_data(event);
> >       entry->ip =3D ip;
> >
> > -     len =3D copy_from_user_nofault(&entry->buf, ubuf, cnt);
> > +     len =3D __copy_from_user_inatomic(&entry->buf, ubuf, cnt);
> >       if (len) {
> >               memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
> >               cnt =3D FAULTED_SIZE;
> > @@ -7310,7 +7310,7 @@ static ssize_t write_raw_marker_to_buffer(struct =
trace_array *tr,
> >
> >       entry =3D ring_buffer_event_data(event);
> >
> > -     len =3D copy_from_user_nofault(&entry->id, ubuf, cnt);
> > +     len =3D __copy_from_user_inatomic(&entry->id, ubuf, cnt);
> >       if (len) {
> >               entry->id =3D -1;
> >               memcpy(&entry->buf, FAULTED_STR, FAULTED_SIZE);
>
