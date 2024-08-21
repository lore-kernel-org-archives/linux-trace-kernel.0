Received: from out-184.mta0.migadu.com (out-184.mta0.migadu.com [91.218.175.184])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B5E18C348
	for <linux-trace-kernel@vger.kernel.org>; Wed, 21 Aug 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.184
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724249779; cv=none; b=OnmWPfjoZDUfssr71Hwy2mvlCdpKjRfxXAB4stEaAkUKEjOAED/1QcfTcRoMXVrNda2/7bsrHyKE0nCu8HU6U9smbGN9OsCxhe1atsE3ki6snwG3IJtArl2Z7ZbTYGaqhT6PsWoPuzPqyCom+NMGc1YNtgxKvtSzrVsMxbt83rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724249779; c=relaxed/simple;
	bh=yCpg8BpOwa/jCwR3LkBxKWRWK+9VGoy6jnZROBl4YTM=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=k9b3VAO3vGt1w3k9hfDBvjok/P2/IMQtrr4591ZOeAvx/MuqxcDmA/8ATVwiTDqRAbpsxorHknzvqJWBG00+Kv2i7s/1of6cY/o4FO76Z+0w3j2DPgkmrafMR1eRULLo2WiL8LUG4ZQTP6JBN+z9eEFE9HVA79UAwEbDPT1x3UY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=PkDGuclh; arc=none smtp.client-ip=91.218.175.184
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="PkDGuclh"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1724249774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=H8CajDEUelu2H+xKX1V61lrtD26SNXje96Ahzio0DC0=;
	b=PkDGuclhnc58W/gfudUwFlCU7pv+9K73cikbVHmNYrYOeWRjQFc/HCbX5a0WsYhZY5NF6u
	sCVnD9+oG8+/N9b4CCSgsXD1ub0ub3avtxG0swngHEUR8QKQVltIIdBfhbf4JFZunf+K82
	pC+1GWSzSTjBHvCfZPUtL8W6eFjG4O4=
Date: Wed, 21 Aug 2024 14:16:12 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <ef273629d92e108ad166faf1f4abccac6cda461a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH] ftrace: Get the true parent ip for function tracer
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com
In-Reply-To: <20240821095910.1888d7fa@gandalf.local.home>
References: <20240821132755.2766674-1-jeff.xie@linux.dev>
 <20240821095910.1888d7fa@gandalf.local.home>
X-Migadu-Flow: FLOW_OUT

August 21, 2024 at 9:59 PM, "Steven Rostedt" <rostedt@goodmis.org> wrote:


Hi Steven,


>=20
>=20On Wed, 21 Aug 2024 21:27:55 +0800
>=20
>=20Jeff Xie <jeff.xie@linux.dev> wrote:
>=20
>=20Hi Jeff,
>=20
>=20Thanks for the patch.
>=20
>=20>=20
>=20> Signed-off-by: Jeff Xie <jeff.xie@linux.dev>
> >=20
>=20>  ---
> >=20
>=20>  kernel/trace/trace_functions.c | 18 ++++++++++++++++++
> >=20
>=20>  1 file changed, 18 insertions(+)
> >=20
>=20>=20=20
>=20>=20
>=20>  diff --git a/kernel/trace/trace_functions.c b/kernel/trace/trace_f=
unctions.c
> >=20
>=20>  index 3b0cea37e029..273b8c7eeb2d 100644
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
>=20>  +static unsigned long
> >=20
>=20>  +function_get_true_parent_ip(unsigned long parent_ip, struct ftrac=
e_regs *fregs)
> >=20
>=20
> I wonder if we should make this inline, or even __always_inline, as thi=
s
>=20
>=20will be called in a very hot path, and I want to make sure that the
>=20
>=20compiler always inlines it. It likely should, but we should also give=
 the
>=20
>=20compiler a hint that it should.


Yes, Thank you for your suggestion. It is indeed a very hot path,=20
and=20I will add __always_inline in the next version.


>=20
>=20-- Steve
>=20
>=20>=20
>=20> +{
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
>=20>  +
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
> >
>
