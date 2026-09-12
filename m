Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8177F3254B0
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 23:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.214.182
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789257555; cv=pass; b=MdUuQcKA5jb63q2CBa2d0hg/qWuvneBMReZzmquVxFmm5Rxl5kqe7pS/DUGadmbGq7jXFnjNWmWLflo+86n8ZLU6WWQdoiwzN2LOP2iiQ9//+3QJPa4w8raU1SeWUBeSqswM9m8yaNmBOO53AY2XYAtTTNksTyOzpcNqKnIwexk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789257555; c=relaxed/simple;
	bh=dt+UOPr8bzn5MsHDJfwrcRsGr6ZoVZ8m7l97MMZFyLU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=r5jENxwjlR6YgU+OsICipFd7YsiJSLgi3E05vqu4DABmofAyQKhITGKL979JMaOcg2RKWNzPxpbypQvR8FxCnTZQvkXuLAwPTXndVJA/fQIz2g3Mslkg3QI8+0DoFKM99Tar0CL8qo8J0PZS33VPDuiIHmvnkNpCH7oKw5wxjSQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IlQwZYyE; arc=pass smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IlQwZYyE"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2db858d60e0so19607855ad.0
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 16:59:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789257554; cv=none;
        d=google.com; s=arc-20260327;
        b=mYKTWWawCmsizTc81reH3VtbvESoZRtDNlP5zdgbpculgfYqnDmXYo8sg7jHrZcPje
         +XD0+VZ3v83WImZf7kx9elkMrj1nCBxgpsJU+4c5eJJBtUmdXCH+ar7tjYOtOiYtyahn
         S8oQ5A42eXQFk36NnVeNOvvk1gP2tDkkDpzAQ8lN8iYgtb7INfrjZMzt25hGA1S6JdTR
         4jekuroxjyxnUcPOqx4gXA8vCrbxCj4D54NoCeI3wVLg1+Lukq4vb25BX6HKmFsJFpiL
         kStLOalqXzh4UcU48W5sC0qlIBoxUi+cCM8i9wPnKJx9z+neiIrMkGcOTm+EfquOltYn
         ISEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        fh=ueRupSDhHOxkK4AJvdEiPXxIBmjH3DZXvve7v24H94Y=;
        b=ZnQreShlOw7ewZ2Dh1G05wJvkjo6W+EuvbBHoo1L8Pgd9IBEjq8lXte/NENft2cGav
         lDwxiNaQCLFETPQIEQieYrM5U+zotHOtL/yfUfIfAuvNsAt+nbcW8eqUaD++Yeyq6QLY
         lIquaaUpJWJTy/Gyj+ngfK71pWJncv8qFaP1c3SeWYJ1m2tt8ZD5Y7XrcQzphRUbMTP4
         5QmFxFao96lX8WeKGMg+U+i6xXw6dNQSbS1qPO8NJS7APssE12v1n6c+OrUnmvFo167c
         DmNM7LGQzW8lKgS5FRv8FPPs4coyLHocFdq2xzkRQqIU7sfP0jGtwxJybdO/ZxH2BjYp
         IjbA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789257554; x=1789862354; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        b=IlQwZYyE/8yZzLZtyPkuaMtWb6HkEiD6XnatVU8c83PI8R9DX8iLQUoHnZsBbe6djx
         E1k07ys8/Z3jFjiHc/K4EK6Cn1mxl5op8ZFLFT7B2tLSktYtwjrbc8aDt7tCPfys6OgM
         /SYBleTCd/zLzgBnTDSiZ3WaJpZpVqwNXXqsy5gl3z78KNTvfeWI6yI/3lzgkzrmPVxx
         mFGv2FslrofS90KLOHrV6jobrBCBfKwa3KQpRAi5LPtzlQ6bN9jz5m4/B8MXjHcwdSKg
         uE+5gY30FI2BTWO0/iQyy4u07F3d1fOWih8iAnVdmhqtO26vfLegZUHnj4BgYg2vJuvp
         +7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789257554; x=1789862354;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=5whm1ZGtSD6d9UTQoSVGX4pAamqW3MhbLVJJEUPVUGg=;
        b=sA9uomXZsJOZAGesk6sOKcGsJsjIG15dF8DnEgTRiyEwWzEUlsgnVXs2JE0Bgt6sP5
         1rnazhcDyXVokNk+d266XV0vziEP2qAkp48paetG4iobxDz5cWjeJv8QatZZBFFcNGlS
         AMN0GSHygaCP1vIUhNnW5DvRHZkbxhoXBn/GfH/Gr9KOhDEYIxplqRJmUsFaRMxuWq4H
         DnSEAAsDVCIMk9d19A0n3ghgxncm1zLSN/21KQD5MaREiH02Af9WO0V8UdArrv+66Vvw
         QTZy/ynVMkQQlgTyaqBLb+h2kwRStD6Z9a/EVIWkEoSkXRgav0RBFyIydsOMR7req2FA
         tYiQ==
X-Forwarded-Encrypted: i=1; AKwUvBzLAA1iKIiLOWKx3bATNW8iCQz0O+Y3cpUmJ77pws5sMQ6vt1MsGtEUpW5eUMo/NZtgY2pGJ/bgm2h2TmBZTfJ2xno=@vger.kernel.org
X-Gm-Message-State: AFuF++m9MqX3Cg6Nd3Z+rhGLSRMpe0qFNO/g0E+t4YWoK9CZONoBk79p
	/MnLHmXlnIvbM47Jp7diQGXBN9EsBj4lAc+SeHsPZGOZi1WyNACM9IDSl/VInEfbTyv3JIwlXjc
	r+4hhwbU3yXcQn/ft6G8hepwS5alaP5E=
X-Gm-Gg: AYBFou3YEM681L8QQwMukb59EzO8NklPiIlFsjxXwVUjJak/2CiH8v8ZrL2TguQuVxi
	4MSqdHB1812CeYbsPDw0SJOUpnkxQw9D2OBUbHemA34a/lh+ytCRYr3RTX+M1Owg6M/z2GheYVD
	yDtRsL0umZp8EcAV7acesOM5Pb3HzNLtu3aQ4tWqGRNnrDHj/Y0ISXS941vnrO+Ukm9kNfSgF+s
	ebCvBaGfVPiRIFDfNx8OO/nPqI3yDX/TOa5P3FHtb0dFL05BHZ1cYBB39y4Ig5F+451v1R4UPAC
	PwuQv4VsXOiPk2x9CgzNkO1IjmHeWlu8WWyt8LOPDFGOym0Q4bM8gmiMH0ZCLiH/LSSP0hxuF5d
	VhllSpVwwg6la/LhyAURj/MFVkU4wDfW52mvFE28=
X-Received: by 2002:a17:903:1ac6:b0:2db:331b:e187 with SMTP id
 d9443c01a7336-2dd2a1e0a15mr200200855ad.8.1789257553733; Sat, 12 Sep 2026
 16:59:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com>
 <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com>
 <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com> <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>
 <DLDICNLENSRI.2R6EJ0ZFJE45T@gmail.com> <8c51a669-eb6b-455b-a829-b537da5209f8@paulmck-laptop>
 <DLDLDGTSBHA0.32TYNBSKKPFXH@gmail.com> <8fbfb3fc-cf5d-4dfb-b144-bc021faa13ff@paulmck-laptop>
In-Reply-To: <8fbfb3fc-cf5d-4dfb-b144-bc021faa13ff@paulmck-laptop>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Sat, 12 Sep 2026 16:59:02 -0700
X-Gm-Features: AcwNN1V04v_YLyVyvshDjEX_boeHQmR-dgrTXGEZk0Tlq9YUUBiA7_5E2kzlt5Y
Message-ID: <CAADnVQLQs-+-cu2R3QrHppcxOQt9m7Hi+grr4fOnw8m73kQn0Q@mail.gmail.com>
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Josef Bacik <josef@toxicpanda.com>, Frederic Weisbecker <frederic@kernel.org>, 
	Neeraj Upadhyay <neeraj.upadhyay@kernel.org>, Joel Fernandes <joelagnelf@nvidia.com>, 
	Boqun Feng <boqun@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Jiri Olsa <jolsa@kernel.org>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Andrii Nakryiko <andrii@kernel.org>, X86 ML <x86@kernel.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Puranjay Mohan <puranjay@kernel.org>, Xu Kuohai <xukuohai@huaweicloud.com>, 
	Andy Lutomirski <luto@kernel.org>, Josh Triplett <josh@joshtriplett.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Lai Jiangshan <jiangshanlai@gmail.com>, Zqiang <qiang.zhang@linux.dev>, 
	Juergen Gross <jgross@suse.com>, Luis Chamberlain <mcgrof@kernel.org>, 
	Ihor Solodrai <ihor.solodrai@linux.dev>, LKML <linux-kernel@vger.kernel.org>, 
	rcu@vger.kernel.org, linux-trace-kernel <linux-trace-kernel@vger.kernel.org>, 
	bpf <bpf@vger.kernel.org>, 
	linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Sep 12, 2026 at 3:28=E2=80=AFPM Paul E. McKenney <paulmck@kernel.or=
g> wrote:
>
> On Sat, Sep 12, 2026 at 12:40:55PM -0700, Alexei Starovoitov wrote:
> > On Sat Sep 12, 2026 at 11:03 AM PDT, Paul E. McKenney wrote:
> > >
> > > In the old kernels, yes, we have current->trc_reader_nesting++.
> > > In the newer kernels, Tasks Trace RCU is instead implemented in terms
> > > of SRCU-fast, which instead increments per-CPU counters.  Which among
> > > other thins is a bit faster and does not need to hook into the schedu=
ler.
> >
> > old kernels? I'm confused.
> > rcu_read_lock_trace() in bpf-next is doing t->trc_reader_nesting++
> > and then calls __srcu_read_lock_fast().
> >
> > Are you talking about some RCU branch that you target for next merge wi=
ndow?
>
> No, I was thinking of rcu_read_lock_tasks_trace(), forgetting that
> rcu_read_lock_trace() is still used.  (For good reason, just be clear.)
> Your comments are quite correct for rcu_read_lock_trace().
>
> Hmmm...  Josep's using t->trc_reader_nesting would break for
> partially overlapping RCU Tasks and rcu_read_lock_trace() readers.
>
> But yes, your #5 makes sense:  Deprecate RCU Tasks, upgrade RCU Tasks
> Trace to check for preemption from within trampolines, and move RCU
> Tasks users over to the rcu_read_lock_trace() variant of RCU Tasks Trace.
> (Or am I still missing your point?)

Pretty much. This way bpf trampoline stays as-is. No extra overhead there.
rcu tasks users (faultable tracepoints and what else ? )
switch to rcu_read_lock_trace().
The only difference for faultable tracepoints is
extra t->trc_reader_nesting++.

I have studied the rest of the patches in the series,
so this proposal can be completely off the mark.
