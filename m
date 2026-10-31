Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793470588;
	b=vyVhbaiLzFltSLunWnPYa5bZDadST9Phi0zBqBgYw4APJaJff9q9/6ohor7IlvQCuwrj
	 /kho8TFkVEyulY9YhH6Og90FhDiMF/LVd3DfxXpHVSsPV8iPlEwuMS/kyXsw0ye3bpjr2
	 /UpqKDfZRcxKEocRERar/uJQF6YA8Jh7IDMs7TROpjIk2/7OT6rDEP0139mUJKMaOH1wB
	 a6qLKoUgKhp+IGpx+rwmrEb8ECbanCr9g3NdDGo5tgi2DmauIcL0ciF0i2UVa9ql2Aw5+
	 RYVUAa0blY59tg6HT2S0FJhPA5FOuNiY8nlvHv8wikD9e0j2g+QWRv2+CFSfgiCfbzA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793470588;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=afMXuEDXpayCaZMJPBoiIlpnPxCbqzejcEwUz+g4BjI=;
	b=RzBODm1deIaH9Vouwli8W3FCaHtyX50+QPnx6ZK9CNEvRZVu8QvMg4mA5lMg8jiHM2Ab
	 jwPBp/LerkvZlqeUkVH+3xskonuBQEz00pQbqROQtR8rzVoT/BKuSNEm+XyO7udAo+hiV
	 M4oDIBzGmr8dQ+1LKlqdKy90Yw1zFrRVcN9fnxVdcT3wJeZOlOIPZcuWtm4Rp7O4qgPlm
	 tqhxWF7itojwZ2Fg00w5yHIUmdP+1GPI4BmVVXPQbEX5meiRzaf0p7eF58hrp4zSxrC/a
	 BrMk+ZqlU5KCnQcRxt8Or3nZusTTCVK7zM0EWBPw8QfHPXfHneypHdU6+aJ+xuyqXQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8wPDI8p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCBC606A31A
	for <linux-trace-kernel@vger.kernel.org>; Sat, 31 Oct 2026 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l8wPDI8p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD9B1F000C1;
	Sat, 31 Oct 2026 18:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793470588;
	bh=afMXuEDXpayCaZMJPBoiIlpnPxCbqzejcEwUz+g4BjI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l8wPDI8pje2KEGshewvliTtl/nU2i7EyxLkbPELhXWwpkxAGH6dHr7JEzWfG1tSHY
	 1wpgypEOYKAB0omfGYswoiYYwMga4gT4yqK8E9MN4gYe1NpDFJXuaUhBjZIqCKtNnD
	 eHvZiaATsJRTmcro5iEueV+BWj0L0y2x2mjKYIHjpqnVwzjdL8c1UnAoBnRckeTTd4
	 qbxBamlB9OQmHA/kbYKHVV1pzH52sG86tcqDzmO2eID+Et6Vq/Et2i5Wj587Zkeodp
	 qwifduTbz1W1YcnZO41VTe8u7h5ahxqrXkdi3H5mPQzaJMvduOOGnorjZjLYhkhuDV
	 rgw3uycOUfAAA==
Message-ID: <sashiko-outbox-192090@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] ftrace: Complete subops teardown on shutdown failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Weiming Shi" <bestswngs@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261031175213.704021-1-bestswngs@gmail.com>
References: <20261031175213.704021-1-bestswngs@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 18:16:27 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] ftrace: register_ftrace_graph() rollback enables direct mode on st=
ale hashes
- [High] ftrace: UAF in ftrace_shutdown_subops() freeing manager hashes wit=
hout RCU
- [High] ftrace: UAF of subop and filter hashes after ftrace_shutdown_subop=
s() error
- [Medium] ftrace: ftrace_startup_subops() merges new subop into stale mana=
ger hashes
--

commit 1d6a2634131e25d978349313b44d8bb9b5af4677
Author: Weiming Shi <bestswngs@gmail.com>

ftrace: Complete subops teardown on shutdown failure

This commit updates ftrace_shutdown_subops() and function graph registration
to always detach subops when shutdown begins, keeping conservative manager
hashes and disabling direct graph dispatch when hash updates fail.

> diff --git a/kernel/trace/fgraph.c b/kernel/trace/fgraph.c
> index ed455b53513be..1a8e092ec3cf0 100644
> --- a/kernel/trace/fgraph.c
> +++ b/kernel/trace/fgraph.c

[ ... ]

> @@ -1406,16 +1420,24 @@ int register_ftrace_graph(struct fgraph_ops *gops)
>  	gops->ops.flags |=3D FTRACE_OPS_FL_GRAPH;
> =20
>  	ret =3D ftrace_startup_subops(&graph_ops, &gops->ops, command);
> -	if (!ret)
> +	if (!ret) {
>  		fgraph_array[i] =3D gops;
> +		if (ftrace_graph_active =3D=3D 1)
> +			ftrace_graph_enable_direct(true, gops);
> +	}
> =20
>  error:
>  	if (ret) {
>  		ftrace_graph_active--;
> +		gops->ops.flags &=3D ~FTRACE_OPS_FL_GRAPH;
>  		gops->saved_func =3D NULL;
>  		fgraph_lru_release_index(i);
> -		if (!ftrace_graph_active)
> +		if (ftrace_graph_active =3D=3D 1) {
> +			ftrace_graph_enable_direct(true, NULL);

[Severity: High]
Can this error rollback in register_ftrace_graph() re-enable direct dispatch
while graph_ops.func_hash still holds stale conservative hashes?

Suppose ftrace_graph_active is 1, and a prior unregister_ftrace_graph() fai=
led
in ftrace_shutdown_subops() (or ftrace_hash_move_and_update_subops() failed=
),
leaving graph_ops.func_hash as a conservative superset with fgraph_do_direct
disabled so function_graph_enter_regs() falls back to checking
ftrace_ops_test(&gops->ops, func, NULL).

If a subsequent register_ftrace_graph() increments ftrace_graph_active from=
 1
to 2 and then fails in ftrace_startup_subops() (for example, if
add_next_hash() or ftrace_update_ops() returns -ENOMEM), this error path
decrements ftrace_graph_active back to 1 and unconditionally calls
ftrace_graph_enable_direct(true, NULL).

With fgraph_do_direct enabled against the wider graph_ops.func_hash, won't
function_graph_enter_regs() take the static_branch_likely(&fgraph_do_direct)
fast path and invoke the remaining gops->entryfunc on functions outside its
filter without calling ftrace_ops_test()?

> diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
> index c7d74b33d36de..b63bb90da9326 100644
> --- a/kernel/trace/ftrace.c
> +++ b/kernel/trace/ftrace.c

[ ... ]

> @@ -3732,36 +3737,45 @@ int ftrace_shutdown_subops(struct ftrace_ops *ops=
, struct ftrace_ops *subops, in
>  	if (list_empty(&ops->subop_list)) {
>  		/* Last one, just disable the current ops */
> =20
> -		ret =3D ftrace_shutdown(ops, command);
> +		if (unlikely(ftrace_disabled))
> +			ret =3D -ENODEV;
> +		else
> +			ret =3D ftrace_shutdown(ops, command);
>  		if (ret < 0) {
> -			list_add(&subops->list, &ops->subop_list);
> -			return ret;
> +			bool enabled =3D ops->flags & FTRACE_OPS_FL_ENABLED;
> +
> +			FTRACE_WARN_ON_ONCE(!ftrace_disabled);
> +			remove_ftrace_ops(&ftrace_ops_list, ops);
> +			if (enabled && ftrace_start_up > 0)
> +				ftrace_start_up--;
> +			ops->flags &=3D ~(FTRACE_OPS_FL_ENABLED |
> +					FTRACE_OPS_FL_ADDING |
> +					FTRACE_OPS_FL_REMOVING);
> +			ops->func =3D ops->saved_func;
>  		}
> =20
> -		subops->flags &=3D ~FTRACE_OPS_FL_ENABLED;
> -
>  		free_ftrace_hash(ops->func_hash->filter_hash);
>  		free_ftrace_hash(ops->func_hash->notrace_hash);
>  		ops->func_hash->filter_hash =3D EMPTY_HASH;
>  		ops->func_hash->notrace_hash =3D EMPTY_HASH;

[Severity: High]
When ftrace_disabled is set or ftrace_shutdown() fails, can freeing
ops->func_hash->filter_hash and ops->func_hash->notrace_hash here cause a
use-after-free in ftrace_ops_test()?

When ftrace_shutdown() does not run ftrace_run_update_code(), patched calls=
ites
remain active and can still invoke __ftrace_ops_list_func() ->
ftrace_ops_test(), which reads ops->func_hash->filter_hash and
ops->func_hash->notrace_hash under preempt_disable().

Here, ftrace_shutdown_subops() removes ops from ftrace_ops_list without
calling update_ftrace_function() or waiting for an RCU grace period, and ca=
lls
synchronous free_ftrace_hash() before resetting filter_hash and notrace_hash
to EMPTY_HASH. Should the pointers be assigned to EMPTY_HASH first and the =
old
hashes retired via free_ftrace_hash_rcu() (or after proper synchronization)?

> +		goto out;
> +	}
> =20
> -		return 0;
> +	if (unlikely(ftrace_disabled)) {
> +		ret =3D -ENODEV;
> +		goto out;
>  	}
> =20
>  	/* Rebuild the hashes without subops */
>  	ret =3D rebuild_hashes(&filter_hash, &notrace_hash, ops);
>  	if (ret < 0)
> -		return ret;
> +		goto out;
> =20
>  	ret =3D ftrace_update_ops(ops, filter_hash, notrace_hash);
> -	if (ret < 0) {
> -		list_add(&subops->list, &ops->subop_list);
> -	} else {
> -		subops->flags &=3D ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
> -		subops->managed =3D NULL;
> -	}
> +
> +out:
> +	subops->flags &=3D ~(FTRACE_OPS_FL_ENABLED | FTRACE_OPS_FL_SUBOP);
> +	subops->managed =3D NULL;

[Severity: High]
Does detaching subops and clearing FTRACE_OPS_FL_ENABLED on error here allow
callers to free subops and its filter hashes while other CPUs are still usi=
ng
them?

In unregister_ftrace_graph():

    fgraph_array[gops->idx] =3D &fgraph_stub;
    ftrace_graph_active--;
    ...
    ret =3D ftrace_shutdown_subops(&graph_ops, &gops->ops, command);

On the normal success path, ftrace_shutdown_subops() calls ftrace_shutdown()
or ftrace_update_ops(), which runs ftrace_run_update_code() and synchronizes
across CPUs before unregister_ftrace_graph() returns.

However, if rebuild_hashes() or ftrace_update_ops() fails (or ftrace_disabl=
ed
is set), ftrace_shutdown_subops() now jumps to out, clears
FTRACE_OPS_FL_ENABLED, and returns without any cross-CPU synchronization
having occurred after fgraph_array[gops->idx] was set to &fgraph_stub.

Callers such as __fprobe_graph_unregister() and
ftrace_destroy_function_files() immediately follow unregister_ftrace_graph()
with ftrace_free_filter(&gops->ops) (which synchronously kfrees filter_hash
and notrace_hash once FTRACE_OPS_FL_ENABLED is cleared) or kfree(tr->gops).
Can a concurrent CPU that loaded gops from fgraph_array[] in
function_graph_enter_regs() or __ftrace_return_to_handler() just before it =
was
replaced with &fgraph_stub suffer a use-after-free?

[Severity: Medium]
Also, when rebuild_hashes() or ftrace_update_ops() fails while other subops
remain on ops->subop_list, subops is unlinked from ops->subop_list while
ops->func_hash keeps the old conservative hashes.

If another subop is later registered via ftrace_startup_subops() while
ops->subop_list is still non-empty:

    ret =3D add_next_hash(&filter_hash, &notrace_hash, ops->func_hash, subo=
ps->func_hash);

Because ftrace_startup_subops() merges subops->func_hash into ops->func_hash
via add_next_hash() rather than rebuilding from ops->subop_list via
rebuild_hashes(), won't the stale entries from the previously detached subop
be permanently carried forward into the new manager hashes?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261031175213.7040=
21-1-bestswngs@gmail.com?part=3D1
