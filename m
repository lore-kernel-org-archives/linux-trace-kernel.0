Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC458528F
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Sep 2024 16:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725898900; cv=none; b=Vurk7FpPOGdG64t2n3k8jQalKGrWwlav8U4ltQ07dHnwBZP+2wSjC+IQNKNX/2ZsM04JyPIq99n8gmnHLm/Jdb3591vuY+1PHhyYMk28umxvSltt/1WQOh69rx2emDJJBw0lLZX+3TvnJ3hfVDDn9fOuMygsy3h1liFAT345yQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725898900; c=relaxed/simple;
	bh=uuq0C4U5f/Bzf4EsN7Tau2CdpeRDI0QD/ltRYC5QK+8=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=fJXT2pjD7OPoZ1f2kwxWTnw8yUEADCOH1amjYJjPJ3SRkEhrBR2D+z9iSOWVkkwUFUgsGOu9SNNjHJDIm2Us9eYr2LP8uN7C6O1pVeZxzEXhD8u8gkHT3fY8lhGFcJgMs/I+Y3Wn58ZPoZciRXPR+RvMwtMUHynVLlZ/vRnJ/+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=UPZ+WiDk; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="UPZ+WiDk"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1725898896;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Da/Nmr/FA0UMU9mIgOfNoroXS/egxOOczdI7Qzrbo0=;
	b=UPZ+WiDk2adEvDlHYo0VjAS3mDtR5RMrhbr+gTui0l2b/8KgntyFWv94zYT/Io0zjW3C4a
	LQDV0UHzLhU5gKSVwdTHDcAb3R45Zw38uOzb0V5iE9r8iMATYr91bdJdTn97BT6Dev3KVr
	+MjwdlEjWNR04MK6xkM4OAzxVtSEmqo=
Date: Mon, 09 Sep 2024 16:21:33 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <4aeb59e2ea195542458b069be4afb5e2c53c8b55@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v2] ftrace: Get the true parent ip for function tracer
To: "Masami Hiramatsu" <mhiramat@kernel.org>
Cc: rostedt@goodmis.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com
In-Reply-To: <20240910001326.87f27e6b312f1d956cf352a2@kernel.org>
References: <20240821233021.2785584-1-jeff.xie@linux.dev>
 <20240910001326.87f27e6b312f1d956cf352a2@kernel.org>
X-Migadu-Flow: FLOW_OUT

September 9, 2024 at 11:13 PM, "Masami Hiramatsu" <mhiramat@kernel.org> w=
rote:

Hi Masami,


>=20
>=20On Thu, 22 Aug 2024 07:30:21 +0800
>=20
>=20Jeff Xie <jeff.xie@linux.dev> wrote:
>=20
>=20>=20
>=20> Currently, when using both function tracer and function graph simul=
taneously,
> >=20
>=20>  it is found that function tracer sometimes captures a fake parent =
ip(return_to_handler)
> >=20
>=20>  instead of the true parent ip.
> >=20
>=20>=20=20
>=20>=20
>=20>  This issue is easy to reproduce. Below are my reproduction steps:
> >=20
>=20>=20=20
>=20>=20
>=20>  jeff-labs:~/bin # ./trace-net.sh
> >=20
>=20>=20=20
>=20>=20
>=20>  jeff-labs:~/bin # cat /sys/kernel/debug/tracing/instances/foo/trac=
e | grep return_to_handler
> >=20
>=20>  trace-net.sh-405 [001] ...2. 31.859501: avc_has_perm+0x4/0x190 <-r=
eturn_to_handler+0x0/0x40
> >=20
>=20>  trace-net.sh-405 [001] ...2. 31.859503: simple_setattr+0x4/0x70 <-=
return_to_handler+0x0/0x40
> >=20
>=20>  trace-net.sh-405 [001] ...2. 31.859503: truncate_pagecache+0x4/0x6=
0 <-return_to_handler+0x0/0x40
> >=20
>=20>  trace-net.sh-405 [001] ...2. 31.859505: unmap_mapping_range+0x4/0x=
140 <-return_to_handler+0x0/0x40
> >=20
>=20>  trace-net.sh-405 [001] ...3. 31.859508: _raw_spin_unlock+0x4/0x30 =
<-return_to_handler+0x0/0x40
> >=20
>=20>  [...]
> >=20
>=20
> Can you also add=20

Was=20there more you intended to say after this?

>=20
>=20>=20
>=20> The following is my simple trace script:
> >=20
>=20>=20=20
>=20>=20
>=20>  <snip>
> >=20
>=20>  jeff-labs:~/bin # cat ./trace-net.sh
> >=20
>=20>  TRACE_PATH=3D"/sys/kernel/debug/tracing"
> >=20
>=20>=20=20
>=20>=20
>=20>  set_events() {
> >=20
>=20>  echo 1 > $1/events/net/enable
> >=20
>=20>  echo 1 > $1/events/tcp/enable
> >=20
>=20>  echo 1 > $1/events/sock/enable
> >=20
>=20>  echo 1 > $1/events/napi/enable
> >=20
>=20>  echo 1 > $1/events/fib/enable
> >=20
>=20>  echo 1 > $1/events/neigh/enable
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  set_events ${TRACE_PATH}
> >=20
>=20>  echo 1 > ${TRACE_PATH}/options/sym-offset
> >=20
>=20>  echo 1 > ${TRACE_PATH}/options/funcgraph-tail
> >=20
>=20>  echo 1 > ${TRACE_PATH}/options/funcgraph-proc
> >=20
>=20>  echo 1 > ${TRACE_PATH}/options/funcgraph-abstime
> >=20
>=20>=20=20
>=20>=20
>=20>  echo 'tcp_orphan*' > ${TRACE_PATH}/set_ftrace_notrace
> >=20
>=20>  echo function_graph > ${TRACE_PATH}/current_tracer
> >=20
>=20>=20=20
>=20>=20
>=20>  INSTANCE_FOO=3D${TRACE_PATH}/instances/foo
> >=20
>=20>  if [ ! -e $INSTANCE_FOO ]; then
> >=20
>=20>  mkdir ${INSTANCE_FOO}
> >=20
>=20>  fi
> >=20
>=20>  set_events ${INSTANCE_FOO}
> >=20
>=20>  echo 1 > ${INSTANCE_FOO}/options/sym-offset
> >=20
>=20>  echo 'tcp_orphan*' > ${INSTANCE_FOO}/set_ftrace_notrace
> >=20
>=20>  echo function > ${INSTANCE_FOO}/current_tracer
> >=20
>=20>=20=20
>=20>=20
>=20>  echo 1 > ${TRACE_PATH}/tracing_on
> >=20
>=20>  echo 1 > ${INSTANCE_FOO}/tracing_on
> >=20
>=20>=20=20
>=20>=20
>=20>  echo > ${TRACE_PATH}/trace
> >=20
>=20>  echo > ${INSTANCE_FOO}/trace
> >=20
>=20>  </snip>
> >=20
>=20>=20=20
>=20>=20
>=20>  Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  v2:
> >=20
>=20>  - Adding __always_inline to function_get_true_parent_ip suggested =
by Steve
> >=20
>=20>=20=20
>=20>=20
>=20>  kernel/trace/trace_functions.c | 18 ++++++++++++++++++
> >=20
>=20>  1 file changed, 18 insertions(+)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_f=
unctions.c
> >=20
>=20>  index 3b0cea37e029..d989e927c898 100644
> >=20
>=20>  --- a/kernel/trace/trace_functions.c
> >=20
>=20>  +++ b/kernel/trace/trace_functions.c
> >=20
>=20>  @@ -176,6 +176,19 @@ static void function_trace_start(struct trace=
_array *tr)
> >=20
>=20>  tracing_reset_online_cpus(&tr->array_buffer);
> >=20
>=20>  }
> >=20
>=20>=20=20
>=20>=20
>=20>  +static __always_inline unsigned long
> >=20
>=20>  +function_get_true_parent_ip(unsigned long parent_ip, struct ftrac=
e_regs *fregs)
> >=20
>=20>  +{
> >=20
>=20>  + unsigned long true_parent_ip;
> >=20
>=20>  + int idx =3D 0;
> >=20
>=20>  +
> >=20
>=20>  + true_parent_ip =3D parent_ip;
> >=20
>=20>  + if (unlikely(parent_ip =3D=3D (unsigned long)&return_to_handler)=
)
> >=20
>=20>  + true_parent_ip =3D ftrace_graph_ret_addr(current, &idx, parent_i=
p,
> >=20
>=20>  + (unsigned long *)fregs->regs.sp);
> >=20
>=20>  + return true_parent_ip;
> >=20
>=20>  +}
> >=20
>=20
> Can this work without CONFIG_FUNCTION_GRAPH_TRACER? Maybe it cause a bu=
ild error
>=20
>=20because return_to_handler is not defined.
>=20
>=20Could you check it?


I believed I had checked it before, but I actually found a build error. I=
 will fix it. ;-)


>=20
>=20Thank you,
>=20
>=20>=20
>=20> +
> >=20
>=20>  static void
> >=20
>=20>  function_trace_call(unsigned long ip, unsigned long parent_ip,
> >=20
>=20>  struct ftrace_ops *op, struct ftrace_regs *fregs)
> >=20
>=20>  @@ -193,6 +206,8 @@ function_trace_call(unsigned long ip, unsigned=
 long parent_ip,
> >=20
>=20>  if (bit < 0)
> >=20
>=20>  return;
> >=20
>=20>=20=20
>=20>=20
>=20>  + parent_ip =3D function_get_true_parent_ip(parent_ip, fregs);
> >=20
>=20>  +
> >=20
>=20>  trace_ctx =3D tracing_gen_ctx();
> >=20
>=20>=20=20
>=20>=20
>=20>  cpu =3D smp_processor_id();
> >=20
>=20>  @@ -241,6 +256,7 @@ function_stack_trace_call(unsigned long ip, un=
signed long parent_ip,
> >=20
>=20>  * recursive protection is performed.
> >=20
>=20>  */
> >=20
>=20>  local_irq_save(flags);
> >=20
>=20>  + parent_ip =3D function_get_true_parent_ip(parent_ip, fregs);
> >=20
>=20>  cpu =3D raw_smp_processor_id();
> >=20
>=20>  data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
> >=20
>=20>  disabled =3D atomic_inc_return(&data->disabled);
> >=20
>=20>  @@ -309,6 +325,7 @@ function_no_repeats_trace_call(unsigned long i=
p, unsigned long parent_ip,
> >=20
>=20>  if (bit < 0)
> >=20
>=20>  return;
> >=20
>=20>=20=20
>=20>=20
>=20>  + parent_ip =3D function_get_true_parent_ip(parent_ip, fregs);
> >=20
>=20>  cpu =3D smp_processor_id();
> >=20
>=20>  data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
> >=20
>=20>  if (atomic_read(&data->disabled))
> >=20
>=20>  @@ -356,6 +373,7 @@ function_stack_no_repeats_trace_call(unsigned =
long ip, unsigned long parent_ip,
> >=20
>=20>  * recursive protection is performed.
> >=20
>=20>  */
> >=20
>=20>  local_irq_save(flags);
> >=20
>=20>  + parent_ip =3D function_get_true_parent_ip(parent_ip, fregs);
> >=20
>=20>  cpu =3D raw_smp_processor_id();
> >=20
>=20>  data =3D per_cpu_ptr(tr->array_buffer.data, cpu);
> >=20
>=20>  disabled =3D atomic_inc_return(&data->disabled);
> >=20
>=20>  --=20
>=20>=20
>=20>  2.34.1
> >=20
>=20
> --=20
>=20
> Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
