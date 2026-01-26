Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168352E8DEC;
	Mon, 26 Jan 2026 21:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769463466; cv=none; b=TpyNyd6Ng5E0ZGIx1GYteEXjeUoadNdjXYNUURorz93P4ITiUq1KVIGVYVbAq/uyUVwuRybRrS2k4XktkpCyPZYVjf36KmFiLBeIEAhbQRz8zBDwjRxs6UfNfmSwZLqoRQAS8JNu7+IcBejC2YeMr7F5+2kKjzdbiDwap35ZPew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769463466; c=relaxed/simple;
	bh=380o3UtdDWXFwWwyY4OkjR9Du4Yahq4wZNQHOFFLgXY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aM/gVEA71JicO4SrWniPqUjW48V9pNGEP59Pd6tnQGQJQllKkj6IxugvgThtY/VOVeIVMluROYOx9OckC+IPnCAIy4R5DAQOKXoYpTomDGo9RsPjcMdhASSG8OujngxGcSsJZW87iy/TBaPtsiQ+p5YbBszOf8OBwYH9jXmeCt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bvik/EI/; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bvik/EI/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68BE6C116C6;
	Mon, 26 Jan 2026 21:37:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769463465;
	bh=380o3UtdDWXFwWwyY4OkjR9Du4Yahq4wZNQHOFFLgXY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=bvik/EI/12nb0gDsm4R+KZdx9TQLbQG2LSN7Bd+h/kAv/8DuFtVZZ/97pN0Cl1W4K
	 YVEXgwVppTDGVrpYbLJ6kC5nqLc/0T23CeWT5cqmQ4A45ZWRVaYWjp2aZ9s363/piX
	 TofxprYgIk12dmlF1d5ZbE3PZvigRUK8Cw7V1r3uOpe8SrxriuUxvdQUZ9Wz7jXtFJ
	 GzAMDwMJEjzOyU3ubH41jngj6risAmiLKWV1EcI1u1jYUuwRjxOK7MCpdvaib9XFBt
	 bsD4CJBjp4CFXYO1PdNeDBcwrXu63Tr9UcBEYocJRyy/TnjtvL/zlosRjCJVW2zeBr
	 Zgfy7AvKBg8AQ==
Message-ID: <651c277f8bfc1892f99fd038236fafaec23e8203.camel@kernel.org>
Subject: Re: [PATCH] tracing: Up the hist stacktrace size from 16 to 31
From: Tom Zanussi <zanussi@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,  Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>
Date: Mon, 26 Jan 2026 15:37:44 -0600
In-Reply-To: <20260123105415.2be26bf4@gandalf.local.home>
References: <20260123105415.2be26bf4@gandalf.local.home>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.3-0ubuntu1.1 
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Steve,

On Fri, 2026-01-23 at 10:54 -0500, Steven Rostedt wrote:
> From: Steven Rostedt <rostedt@goodmis.org>
>=20
> Recording stacktraces is very useful, but the size of 16 deep is very
> restrictive. For example, in seeing where tasks schedule out in a non
> running state, the following can be used:
>=20
> =C2=A0~# cd /sys/kernel/tracing
> =C2=A0~# echo 'hist:keys=3Dcommon_stacktrace:vals=3Dhitcount if prev_stat=
e & 3' > events/sched/sched_switch/trigger
> =C2=A0~# cat events/sched/sched_switch/hist
> [..]
> { common_stacktrace:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 __schedule+0xdc0/0x1860
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 schedule+0x27/0xd0
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 schedule_timeout+0xb5/0x=
100
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 wait_for_completion+0x8a=
/0x140
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_buf_iowait+0x20/0xd0=
 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_buf_read_map+0x103/0=
x250 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_trans_read_buf_map+0=
x161/0x310 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_btree_read_buf_block=
+0xa0/0x120 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_btree_lookup_get_blo=
ck+0xa3/0x1e0 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_btree_lookup+0xea/0x=
530 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_alloc_fixup_trees+0x=
72/0x570 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_alloc_ag_vextent_siz=
e+0x67f/0x800 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_alloc_vextent_iterat=
e_ags.constprop.0+0x52/0x230 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_alloc_vextent_start_=
ag+0x9d/0x1b0 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_bmap_btalloc+0x2af/0=
x680 [xfs]
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xfs_bmapi_allocate+0xdb/=
0x2c0 [xfs]
> } hitcount:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1
> [..]
>=20
> The above stops at 16 functions where knowing more would be useful. As th=
e
> allocated storage for stacks is the same for strings, and that size is 25=
6
> bytes, there is a lot of space not being used for stacktraces.
>=20
> =C2=A016 * 8 =3D 128
>=20
> Up the size to 31 (it requires the last slot to be zero, so it can't be 3=
2).
>=20

Yeah, it can't be 32 because of the extra slot needed for saving the
number of elements. If the stacktrace doesn't take up the full 31
elements, it writes a 0 after the last one to mark the end; if it fills
it up, the 0 isn't written since the size of the array is known.=20

> Also change the BUILD_BUG_ON() to allow the size of the stacktrace storag=
e
> to be equal to the max size. It already accounts for the empty slot via
> a "+ 1":
>=20
> =C2=A0 BUILD_BUG_ON((HIST_STACKTRACE_DEPTH + 1) * sizeof(long) >=3D STR_V=
AR_LEN_MAX);
>=20
> Change that from ">=3D" to just ">", as now they are equal.
>=20
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>

The patch itself looks good to me, thanks!

Reviewed-by: Tom Zanussi <zanussi@kernel.org>

> ---
> =C2=A0kernel/trace/trace.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 2 +-
> =C2=A0kernel/trace/trace_events_hist.c | 2 +-
> =C2=A02 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
> index 8888fc9335b6..69e7defba6c6 100644
> --- a/kernel/trace/trace.h
> +++ b/kernel/trace/trace.h
> @@ -128,7 +128,7 @@ enum trace_type {
> =C2=A0
> =C2=A0#define FAULT_STRING "(fault)"
> =C2=A0
> -#define HIST_STACKTRACE_DEPTH	16
> +#define HIST_STACKTRACE_DEPTH	31
> =C2=A0#define HIST_STACKTRACE_SIZE	(HIST_STACKTRACE_DEPTH * sizeof(unsign=
ed long))
> =C2=A0#define HIST_STACKTRACE_SKIP	5
> =C2=A0
> diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events=
_hist.c
> index 24441b30a1a4..dfb7c4754bf8 100644
> --- a/kernel/trace/trace_events_hist.c
> +++ b/kernel/trace/trace_events_hist.c
> @@ -3154,7 +3154,7 @@ static inline void __update_field_vars(struct traci=
ng_map_elt *elt,
> =C2=A0	u64 var_val;
> =C2=A0
> =C2=A0	/* Make sure stacktrace can fit in the string variable length */
> -	BUILD_BUG_ON((HIST_STACKTRACE_DEPTH + 1) * sizeof(long) >=3D STR_VAR_LE=
N_MAX);
> +	BUILD_BUG_ON((HIST_STACKTRACE_DEPTH + 1) * sizeof(long) > STR_VAR_LEN_M=
AX);
> =C2=A0
> =C2=A0	for (i =3D 0, j =3D field_var_str_start; i < n_field_vars; i++) {
> =C2=A0		struct field_var *field_var =3D field_vars[i];

