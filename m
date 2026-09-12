Received: from mail-oi2-f13.google.com (mail-oi2-f13.google.com [74.125.231.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3201A27FB37
	for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 17:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.231.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789233535; cv=none; b=FmFxKVLahpdjqVt7y9Ey7cV6iSTSK6JQ5Ej1mgueyZ9PvWsTbqhYjhVSBwjNHeGLljwIukvVZLY7AP17delsPjWR6n7QVU0GB/SBFlw6eTNoOINdYeau0PfZKhrs5ef3yTHWjpiPznsRqY12n30UdtarzjgjWljM9FzMW0kaKhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789233535; c=relaxed/simple;
	bh=jBtZBjDlT8Qi3VYpNIp72jmf1UAXzlM9TkhK/45vnWc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=M7i+B/Tqoh7t0Chs2D/87wvIUW/4ohFAaoJDy0OZMoBslKlp45z32HhiXs2ElvUSkYrdLHGkjn7lrDhMdGG0XIjh4+/jGNAIH3eSGuwkmavK33lj16mV0Q24rR98phsYAIykvie/q/2/aQgbeqoE0uT3k6T7LAbR73CCIjHHKR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LLufjg9t; arc=none smtp.client-ip=74.125.231.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LLufjg9t"
Received: by mail-oi2-f13.google.com with SMTP id 5614622812f47-4b37a3ed715so463740b6e.3
        for <linux-trace-kernel@vger.kernel.org>; Sat, 12 Sep 2026 10:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789233531; x=1789838331; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=M1c6suOtzZ2rRuH1TXxQJyOcddxpg3oryXf9dCc4tZI=;
        b=LLufjg9tkDHfboL43zM8EhB8/3TC5sqvSGrfLsnHpXY5oKIZhyLB12Mpf/1tRBn0Qt
         aUTmkwDr6K1fXlg42wE3St71lnXgY16DGhmZZsHQvWDX2pFVJrt5xBash1IGri8ujw+K
         Dos33rufshNrGVyoXmhoAMIEpr8fIqzOJFk56h7oRwrJuSCYgqjWRXrzK1ZwBBeWgsiL
         mr9G3buIXNvAzpRm2IDzqETuhVXtEVWc5aDnZYcYd8lkAR3CX8wWFuJv8SBGHhH90wdt
         z0lgJu+7pvtMQKcaKQ+3nUEpjKi4ykmWxRmG4eJoqROjAOq8cGeK8F7PH7wAPuFFmXFw
         9uoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789233531; x=1789838331;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-type:content-transfer-encoding:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=M1c6suOtzZ2rRuH1TXxQJyOcddxpg3oryXf9dCc4tZI=;
        b=YI9TPNePnj944iS4P1iUsjYg6JqMcgAuC2CYsTEBu1p2vsoEpmaQYVU5oLy3U2LpiG
         W8vWGZtDIvswknhQ+2gqqyoh1gls4SRjY6OO9Y/kh8NfJ0kf3JDqDaFu3pSagj7ZNMQE
         pNdW6ndiC1KAiUrpdL2kPyUWti4ZCSEfBoGCMHBFQSyHrdGO3/8yHdZQir/xLAZsqfoT
         bcg8Rn1K6hKHJjuLyq8zYu+WBXlBx1cFG7+mngXwjJ2vAb+BMXqKka6cCAeWwCggBzGZ
         5xAb6T26oorC5/qR4NrIH3/ePy9NfuL3jwy5dF7cXsh2gXO6YI9OJD66f0ERPu9Uwswn
         BeGw==
X-Forwarded-Encrypted: i=1; AKwUvBw+ACZ4WpzVnfXdwFCgKgMpiMMlZKno046TBMjUuvbETJZnZ7jAGd4hUznuAmzmnip8UM+LRixGOLy+/O6NtNptAyc=@vger.kernel.org
X-Gm-Message-State: AFuF++lSt0oKKVYxKgavnjCkbK8Qqj+tZS5iwE3qrDpMeff426uhVOpp
	CzO2p/KmcRm9oTBsIdYeI3M93nm7fEUYg4NXNQmjmchKLxaXeBqz/eFv
X-Gm-Gg: AYBFou35qfAORRIVRjkXToXi5DJB+sQDEUSdZ3RTvehbbW1ih1EkQOjOBETyaipC5Om
	3Q2NAOSkodTf5YQTBNfQomh1NWRAeSnLkeq+GjN74KyuZFE0666cL9HxuUy/MWeXup4lxcv2oRA
	PTzgeUMm4bqibdAccARExwjYK0n3Q3pG2srMJdP02q4iLTtr+d5m6+88DNmITHHaceE0a56r9ER
	uDgfgQarH61+n5KI5tK7vrMlVJAj4fi0s4zXcwJ8fqx/RDWDTOfhNdoZr0qn9Nh78rgo1ieF1JV
	QsdkrdvKw9LYNvzl0BHB9wrfhbnG0PxQxkMiCGqBQp1D33HFQB9sQ/a6gvbce2WiRTD6JPcfiOl
	uVG2tN3cqLsSbOrnDIj8zcqd2grbfNgTLSoodQUmts/GPUvfnSUQtK2N/5F21DLARN3SFaMGxDN
	plxvcH1dKAKHSLAnwQqlr43oVbMRahpE9tYuWXdIAVSSK8q8RpRAdlQHr1Ma4bhPii/kVT9MtyU
	JP0xgBhehM88p1zbc64MURt+si6+FGXsytaZ5WblMgunPwydkOLZ9uB7xY+yRRhlA==
X-Received: by 2002:a05:6808:3503:b0:4b3:8323:8cd8 with SMTP id 5614622812f47-4c4a751294bmr2617971b6e.5.1789233530981;
        Sat, 12 Sep 2026 10:18:50 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:72::])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4c3315b19afsm5495263b6e.10.2026.09.12.10.18.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Sep 2026 10:18:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 12 Sep 2026 10:18:48 -0700
Message-Id: <DLDICNLENSRI.2R6EJ0ZFJE45T@gmail.com>
Cc: "Josef Bacik" <josef@toxicpanda.com>, "Frederic Weisbecker"
 <frederic@kernel.org>, "Neeraj Upadhyay" <neeraj.upadhyay@kernel.org>,
 "Joel Fernandes" <joelagnelf@nvidia.com>, "Boqun Feng" <boqun@kernel.org>,
 "Thomas Gleixner" <tglx@kernel.org>, "Peter Zijlstra"
 <peterz@infradead.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mark Rutland" <mark.rutland@arm.com>,
 "Jiri Olsa" <jolsa@kernel.org>, "Alexei Starovoitov" <ast@kernel.org>,
 "Daniel Borkmann" <daniel@iogearbox.net>, "Andrii Nakryiko"
 <andrii@kernel.org>, <x86@kernel.org>, "Catalin Marinas"
 <catalin.marinas@arm.com>, "Will Deacon" <will@kernel.org>, "Puranjay
 Mohan" <puranjay@kernel.org>, "Xu Kuohai" <xukuohai@huaweicloud.com>, "Andy
 Lutomirski" <luto@kernel.org>, "Josh Triplett" <josh@joshtriplett.org>,
 "Uladzislau Rezki" <urezki@gmail.com>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, "Lai Jiangshan" <jiangshanlai@gmail.com>,
 "Zqiang" <qiang.zhang@linux.dev>, "Juergen Gross" <jgross@suse.com>, "Luis
 Chamberlain" <mcgrof@kernel.org>, "Ihor Solodrai"
 <ihor.solodrai@linux.dev>, <linux-kernel@vger.kernel.org>,
 <rcu@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <bpf@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
 <xen-devel@lists.xenproject.org>
Subject: Re: [PATCH RFC v2 08/15] bpf, x86: Maintain Tasks RCU trampoline
 nesting in the BPF trampoline
From: "Alexei Starovoitov" <alexei.starovoitov@gmail.com>
To: <paulmck@kernel.org>
X-Mailer: aerc
References: <20260911-b4-rcu-tasks-preempt-qs-v2-0-eaaa61ed2da4@toxicpanda.com> <20260911-b4-rcu-tasks-preempt-qs-v2-8-eaaa61ed2da4@toxicpanda.com> <DLD0OHX8C4ME.VNR49VC2UYH4@gmail.com> <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>
In-Reply-To: <14cb8a91-497d-49f5-aa20-c6cb8b9a27fc@paulmck-laptop>

On Fri Sep 11, 2026 at 10:10 PM PDT, Paul E. McKenney wrote:
> On Fri, Sep 11, 2026 at 08:27:56PM -0700, Alexei Starovoitov wrote:
>> On Fri Sep 11, 2026 at 7:08 AM PDT, Josef Bacik wrote:
>> > Emit an increment of current->rcu_tramp_nesting once the trampoline's
>> > frame is set up and a decrement before the final register restore, so
>> > that a task preempted while running fentry/fexit/fmod_ret/LSM programs
>> > or the __bpf_tramp_enter()/__bpf_tramp_exit() glue is not treated as
>> > Tasks-RCU quiescent.  Drop the count around the call to the original
>> > function: that may run arbitrarily long without sleeping and must not =
pin
>> > a Tasks RCU grace period, and the trampoline frame above it is held by
>> > im->pcref rather than by Tasks RCU (see bpf_tramp_image_put()).  The
>> > fmod_ret early-exit branch and the ip_after_call -> ip_epilogue poke b=
oth
>> > skip the decrement/increment pair around the original call, so the cou=
nt
>> > stays balanced on every path.
>> >
>> > The sequence is "mov r11, gs:[current_task]; inc/dec dword [r11 + off]=
";
>> > r11 is scratch at every emission point and (u32)&current_task is a val=
id
>> > sign-extended %gs-absolute with the current per-CPU layout, the same f=
orm
>> > the JIT already uses for this_cpu_off.  The image is dynamically
>> > allocated text, so the instructions outside the bracketed region are
>> > covered by the irq-exit IP check.
>> >
>> > Assisted-by: LLM
>> > Signed-off-by: Josef Bacik <josef@toxicpanda.com>
>> > ---
>> >  arch/x86/net/bpf_jit_comp.c | 43 ++++++++++++++++++++++++++++++++++++=
+++++++
>> >  1 file changed, 43 insertions(+)
>> >
>> > diff --git a/arch/x86/net/bpf_jit_comp.c b/arch/x86/net/bpf_jit_comp.c
>> > index 2853e87797a7..a375c1b7bd50 100644
>> > --- a/arch/x86/net/bpf_jit_comp.c
>> > +++ b/arch/x86/net/bpf_jit_comp.c
>> > @@ -722,6 +722,31 @@ static void emit_indirect_jump(u8 **pprog, int bp=
f_reg, u8 *ip)
>> >  	*pprog =3D prog;
>> >  }
>> > =20
>> > +/*
>> > + * Tasks RCU trampoline nesting, see rcu_tasks_trampoline_enter().
>> > + *
>> > + *   mov r11, QWORD PTR gs:[current_task]
>> > + *   inc/dec DWORD PTR [r11 + offsetof(struct task_struct, rcu_tramp_=
nesting)]
>> > + *
>> > + * r11 (AUX_REG) is scratch in the trampoline at every point this is =
emitted.
>> > + */
>> > +static void emit_rcu_tasks_tramp_nesting(u8 **pprog, bool enter)
>> > +{
>> > +#ifdef CONFIG_TASKS_RCU
>> > +	u8 *prog =3D *pprog;
>> > +
>> > +	/* mov r11, gs:[abs32] */
>> > +	EMIT2(0x65, 0x4C);
>> > +	EMIT3(0x8B, 0x1C, 0x25);
>> > +	EMIT((u32)(unsigned long)&current_task, 4);
>> > +	/* inc/dec dword ptr [r11 + disp32] */
>> > +	EMIT3(0x41, 0xFF, enter ? 0x83 : 0x8B);
>> > +	EMIT(offsetof(struct task_struct, rcu_tramp_nesting), 4);
>> > +
>> > +	*pprog =3D prog;
>> > +#endif
>>=20
>> It's not a lot of overhead, but I feel it will be the death by thousand =
cuts.
>> rcu_read_lock_trace() in bpf_prog_enter_sleepable is doing the same thin=
g...
>> increamenting a variable inside current.
>> Can they be combined? Like treat current->trc_reader_nesting > 0 as
>>  current->rcu_tramp_nesting > 0 ?
>> Or replace one with the other?
>> Two current->foo++ operations look redundant.
>>=20
>> bpf trampoline is already quite heavy. I'd like to find ways to reduce
>> its overhead instead of adding more.
>
> Replace rcu_read_lock_trace() with Josef's rcu_tasks_trampoline_enter)?

If necessary...
what I don't understand why we need another rcu_tasks_trampoline_enter-like=
 counter.
Can existing rcu_read_lock_trace() current be used ?
It's already doing current->trc_reader_nesting++
so use that as a signal ?

