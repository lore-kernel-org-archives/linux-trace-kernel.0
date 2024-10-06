Received: from out-189.mta1.migadu.com (out-189.mta1.migadu.com [95.215.58.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45D42AD55
	for <linux-trace-kernel@vger.kernel.org>; Sun,  6 Oct 2024 03:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728185296; cv=none; b=WECS5AgONAeHshZ81e/ZaITmjXQnR9tM4/OKbfOOPzlB2sC6/Z0fWTPOaExfLGBlUrFuujsgbo5Fs3gvEJeweQKVtuvqxYnvx7pbzWt+H9vsUvudiDDuKx96utys07HavtxzzO0uzBeYyjHrEJxAy3GaP2hZVDA3ZJKMDK+EKA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728185296; c=relaxed/simple;
	bh=5dnxUnkPTfCQpQKGkyVKYy+e8f8pyjQtDOVPnj5Ojws=;
	h=MIME-Version:Date:Content-Type:From:Message-ID:Subject:To:Cc:
	 In-Reply-To:References; b=FJVzN1pJKLAIkRcLdzSo2tpnir6ZnjjESnMyNSGlCi0bsrNTSLXE9kXKP0IfZeR7PfoMnRIdPKjjAGUdqOcYhPWy4ierFn1MAy0TC70esW/XxTR2FuLanxhTzbFoqwajDYGj1iSzTCislu70j74I5t1rArorwhI76HJEhn+s+LI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=U9Eg/56s; arc=none smtp.client-ip=95.215.58.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="U9Eg/56s"
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1728185291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kS0fZsl5Whbpe2zbdUH52+8dlKs/U98L5gW/tvZT5H8=;
	b=U9Eg/56s3rsmKFZDP4NChsDp9O+MxZQEYIMmE8lBMIpA/ye9PDYFnzu/yhWHeJlBxIHs8F
	YsRVAWPT/K0VePxUpPybfT7wAYJYtj1E5NnJPuVleXqaE0Qmf6twRjCMReR4t7gatEjY98
	YB3DY6N/yOlejwVwJmUfsYPltIEYh7g=
Date: Sun, 06 Oct 2024 03:28:08 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: jeff.xie@linux.dev
Message-ID: <f92748848274c135f2bdb7ffce0d747dc9d77f9a@linux.dev>
TLS-Required: No
Subject: Re: [PATCH v3] ftrace: Get the true parent ip for function tracer
To: "Steven Rostedt" <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 xiehuan09@gmail.com, dolinux.peng@gmail.com, chensong_2000@189.cn
In-Reply-To: <20241005101320.766c1100@rorschach.local.home>
References: <20240910133620.19711-1-jeff.xie@linux.dev>
 <20241005101320.766c1100@rorschach.local.home>
X-Migadu-Flow: FLOW_OUT

October 5, 2024 at 10:13 PM, "Steven Rostedt" <rostedt@goodmis.org> wrote=
:



>=20
>=20On Tue, 10 Sep 2024 21:36:20 +0800
>=20
>=20Jeff Xie <jeff.xie@linux.dev> wrote:
>=20
>=20>=20
>=20> When using both function tracer and function graph simultaneously,
> >=20
>=20>  it is found that function tracer sometimes captures a fake parent =
ip
> >=20
>=20>  (return_to_handler) instead of the true parent ip.
> >=20
>=20>=20=20
>=20>=20
>=20>  This issue is easy to reproduce. Below are my reproduction steps:
> >=20
>=20>=20=20
>=20>=20
>=20>  jeff-labs:~/bin # ./trace-net.sh
> >=20
>=20
> I applied this and it failed one of my testes:
>=20
>=20On x86 32 bit:
>=20
>=20[ 668.043429] BUG: kernel NULL pointer dereference, address: 0000003c
>=20
>=20[ 668.045840] #PF: supervisor read access in kernel mode
>=20
>=20[ 668.047869] #PF: error_code(0x0000) - not-present page
>=20
>=20[ 668.049867] *pdpt =3D 000000000afad001 *pde =3D 0000000000000000=20
>=20
> [ 668.052481] Oops: Oops: 0000 [#1] PREEMPT SMP PTI
>=20
>=20[ 668.054408] CPU: 3 UID: 0 PID: 4347 Comm: cat Not tainted 6.12.0-rc=
1-test-00008-gc274c40c37e8-dirty #444
>=20
>=20[ 668.057679] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIO=
S 1.16.3-debian-1.16.3-2 04/01/2014
>=20
>=20[ 668.060944] EIP: function_trace_call+0x14b/0x1a0
>=20
>=20[ 668.062824] Code: ff b8 10 00 00 00 e9 56 ff ff ff 8d 74 26 00 e8 1=
b c7 c0 00 eb a1 2e 8d b4 26 00 00 00 00 90 8b 45 e0 8d 55 ec b9 98 9e 10=
 c7 <ff> 70 3c 89 f8 e8 eb 0a 01 00 89 45 e8 5a e9 47 ff ff ff 8b 87 ac
>=20
>=20[ 668.068726] EAX: 00000000 EBX: c1b02000 ECX: c7109e98 EDX: cab21e50
>=20
>=20[ 668.071076] ESI: fffffff7 EDI: ca828000 EBP: cab21e64 ESP: cab21e44
>=20
>=20[ 668.073425] DS: 007b ES: 007b FS: 00d8 GS: 0033 SS: 0068 EFLAGS: 00=
010246
>=20
>=20[ 668.075938] CR0: 80050033 CR2: 0000003c CR3: 091a0000 CR4: 000006f0
>=20
>=20[ 668.078331] Call Trace:
>=20
>=20[ 668.079687] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.081541] ? __die_body.cold+0x14/0x1b
>=20
>=20[ 668.083440] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.085347] ? __die+0x21/0x28
>=20
>=20[ 668.087062] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.088944] ? page_fault_oops+0x68/0x120
>=20
>=20[ 668.091245] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.093208] ? kernelmode_fixup_or_oops.constprop.0+0x58/0x70
>=20
>=20[ 668.095669] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.097574] ? __bad_area_nosemaphore.constprop.0+0x107/0x130
>=20
>=20[ 668.101278] ? ftrace_graph_caller+0x18/0x1c
>=20
>=20[ 668.103358] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.105272] ? bad_area_nosemaphore+0xf/0x20
>=20
>=20[ 668.107276] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.109279] ? do_user_addr_fault+0x20b/0x3d0
>=20
>=20[ 668.111518] ? exc_page_fault+0x5b/0x240
>=20
>=20[ 668.113474] ? pvclock_clocksource_read_nowd+0x110/0x110
>=20
>=20[ 668.115738] ? handle_exception+0x133/0x133
>=20
>=20[ 668.117689] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.119827] ? ftrace_graph_set_hash+0xbb/0x1c0
>=20
>=20[ 668.121955] ? pvclock_clocksource_read_nowd+0x110/0x110
>=20
>=20[ 668.124258] ? function_trace_call+0x14b/0x1a0
>=20
>=20[ 668.126456] ? pvclock_clocksource_read_nowd+0x110/0x110
>=20
>=20[ 668.128773] ? function_trace_call+0x14b/0x1a0
>=20
>=20[ 668.130909] ? sched_tick+0x370/0x370
>=20
>=20[ 668.134063] ? ftrace_graph_caller+0x1c/0x1c
>=20
>=20[ 668.136213] ? ftrace_stacktrace_count+0xa0/0xa0
>=20
>=20The crash happened here:
>=20
>=20static __always_inline unsigned long
>=20
>=20function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_re=
gs *fregs)
>=20
>=20{
>=20
>=20 unsigned long true_parent_ip;
>=20
>=20 int idx =3D 0;
>=20
>=20 true_parent_ip =3D parent_ip;
>=20
>=20 if (unlikely(parent_ip =3D=3D (unsigned long)&return_to_handler))
>=20
>=20 true_parent_ip =3D ftrace_graph_ret_addr(current, &idx, parent_ip, <=
<<----- CRASH
>=20
>=20 (unsigned long *)fregs->regs.sp);
>=20
>=20 return true_parent_ip;
>=20
>=20}
>=20
>=20It appears that on some archs (x86 32 bit) the function tracer can be
>=20
>=20called when "current" is not set up yet, and can crash when accessing=
 it.
>=20
>=20So perhaps we need to add:
>=20
>=20#ifdef CONFIG_ARCH_WANTS_NO_INSTR
>=20
>=20static __always_inline unsigned long
>=20
>=20function_get_true_parent_ip(unsigned long parent_ip, struct ftrace_re=
gs *fregs)
>=20
>=20{
>=20
>=20 unsigned long true_parent_ip;
>=20
>=20 int idx =3D 0;
>=20
>=20 true_parent_ip =3D parent_ip;
>=20
>=20 if (unlikely(parent_ip =3D=3D (unsigned long)&return_to_handler))
>=20
>=20 true_parent_ip =3D ftrace_graph_ret_addr(current, &idx, parent_ip, <=
<<----- CRASH
>=20
>=20 (unsigned long *)fregs->regs.sp);
>=20
>=20 return true_parent_ip;
>=20
>=20}
>=20
>=20#else
>=20
>=20# define function_get_true_parent_ip(parent_ip, fregs) parent_ip
>=20
>=20#endif
>=20
>=20That is, if the arch has noinstr implemented, it should always be saf=
e
>=20
>=20to access current, but if not, then there's no guarantee.
>=20
>=20?

Makes sense. Thanks for the test and detailed explanation! I=E2=80=99ll s=
end a new version.

>=20
>=20-- Steve
>
