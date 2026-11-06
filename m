Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989302;
	b=3Mfz0WK627dLt6qJqH9VA39oWRyBA0dSVJ34dESXftId5wak0h57qkjSKc1TSumVBC1E
	 M0760k8+WbLP7Y6ILLnuBOdfs9AUv8Pq1iosT1b0Qr0lgZ6n4rZ6fiX7VAIV13i7dQPnT
	 oVq/MofPJiZRKYyJn6iB5zeZPQBsrGVTJlGDIaLzxdGsSWvLIj2kxxWJCpSN92lP9KmIe
	 wVmIIpGHmqE0K3iQfovWIKA5AAgWpKLybgGSBElnq9asw+y7vxwND+XzM4bcXxC90wxhG
	 Tc9f4A7fZoDCYMRupmO2fTwkftiIthKMHpLcVoJdKtNhaggL9F863iNesKyoUNi953g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989302;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aHmhjP5qG9gg2pGlj946ka5/BaStKcdztGsacXcb1m0=;
	b=NpullDBcRBjIgFGTETnTioIJ2fFKbzY0zl8hOE2cHVmhcl6P9lisJ+q+FNI51XwLW8Cm
	 0eu3twL0frz3iGQotEmi24Rkzi8Z7OjPdCG0mLEv7qMYSyQHJ0x4b+sHKNEGnjlT+l7w8
	 cToJ3Vpe13CMspGShWly1yqsJhH6dNZa4353ZW5/P95tuk1Zdd8qcwjQrUNGjfyU6YoIE
	 0JC/kNxJwWTywe2GUKq2mTPt+eR+La4/yjHKdbSrFwGjuYGorN9AAIylQ0iLN6Zbe9SOy
	 vqlkHi1vDSt2W3x6jLL+84+ydv7mnGDqr7kVFPIqLY5jU2n0vppJx8xUJE01Lo43CeQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8Bf9tdx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D555606A32C
	for <linux-trace-kernel@vger.kernel.org>; Fri,  6 Nov 2026 18:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=a8Bf9tdx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C480E1F0089F;
	Fri,  6 Nov 2026 18:21:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989302;
	bh=aHmhjP5qG9gg2pGlj946ka5/BaStKcdztGsacXcb1m0=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=a8Bf9tdxAmOAKYAMkm2YqMAiobfapowQAglH9vuEyt8HK0OsU6ZIy/pryNytc+Wqy
	 7HXrLMeM2F9cC9wF94V0wYuCtkBoKg5i/r9wYiXVq+EnD4w+d0GvEP/Y6Jq5PUDIIj
	 iivbbz+ha1Q2S2L9OaoyumfZ9IFZsNjJDvd54T1i8FBi9Ddo6lww7PVJzXHEpxKY7D
	 Bc7nRPjplgtvQhEqeMuUgE7cvzARfVkAsXi4j/urnwD3bh9x6m1F8AC6SQNEBc9Sgq
	 /QfYtdwWoAEMUVSJLe6OEEjzRAXoP8fuJjIcdGwIEAfQy1ECEBVMQnevkKiYhPZkhR
	 oSxcsIlEQ1tqQ==
Message-ID: <sashiko-outbox-202014@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 02/21] tracing/remotes: Release tracefs,eventfs on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261106180657.2460376-3-vdonnefort@google.com>
References: <20261106180657.2460376-1-vdonnefort@google.com>
 <20261106180657.2460376-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:21:41 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] tracing/remotes: NULL deref in trace_remote_init_eventfs()
  under lockdown
- [Low] tracing/remotes: missing Fixes trailers for
  trace_remote_register() leaks
--

commit 02468907e3da178a9b587aedf4931ee736d0fcda
Author: Vincent Donnefort <vdonnefort@google.com>

> tracing/remotes: Release tracefs,eventfs on registration failure
>
> In trace_remote_register(), if registration of events or the init
> callback fails, the created tracefs and eventfs directories are leaked.
>
> Release the entire eventfs and tracefs hierarchy on trace_remote
> registration failure.
>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

[Severity: Low]
This fixes resource leaks on the trace_remote_register() error paths.
Should it include Fixes: tags for the commits that introduced them:

  Fixes: 072529158e60 ("tracing: Add events to trace remotes")
  Fixes: bf2ba0f8ca1a ("tracing: Add init callback to trace remotes")

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index e8cbbd01964df..10091ff9d42ab 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> @@ -1374,35 +1395,37 @@ static int trace_remote_init_eventfs(const char *=
remote_name, struct trace_remot
>  			.callback	=3D remote_event_callback,
>  		}
>  	};
> -	bool eventfs_create =3D false;
> +	struct eventfs_inode *eventfs_root, *eventfs_subdir, *e;
> =20
> -	if (!eventfs) {
> -		eventfs =3D eventfs_create_events_dir("events", remote->dentry, dir_en=
tries,
> -						    ARRAY_SIZE(dir_entries), remote);
> -		if (IS_ERR(eventfs))
> -			return PTR_ERR(eventfs);
> +	eventfs_root =3D remote->eventfs_root;
> +	eventfs_subdir =3D remote->eventfs_subdir;
> +	if (!eventfs_root) {
> +		eventfs_root =3D eventfs_create_events_dir("events", remote->dentry, d=
ir_entries,
> +							 ARRAY_SIZE(dir_entries), remote);
> +		if (IS_ERR(eventfs_root))
> +			return PTR_ERR(eventfs_root);
> =20
>  		/*
>  		 * Create similar hierarchy as local events even if a single system is=
 supported at
>  		 * the moment
>  		 */
> -		eventfs =3D eventfs_create_dir(remote_name, eventfs, NULL, 0, NULL);
> -		if (IS_ERR(eventfs))
> -			return PTR_ERR(eventfs);
> -
> -		remote->eventfs =3D eventfs;
> -		eventfs_create =3D true;
> +		eventfs_subdir =3D eventfs_create_dir(remote_name, eventfs_root, NULL,=
 0, NULL);
> +		if (IS_ERR(eventfs_subdir)) {
> +			eventfs_remove_events_dir(eventfs_root);
> +			return PTR_ERR(eventfs_subdir);
> +		}
>  	}

[Severity: Medium]
Can this dereference a NULL eventfs_root in eventfs_remove_events_dir() if
kernel lockdown becomes active between trace_remote_init_tracefs() and
trace_remote_init_eventfs()?

When security_locked_down(LOCKDOWN_TRACEFS) is true,
eventfs_create_events_dir() returns NULL rather than an ERR_PTR.
IS_ERR(eventfs_root) does not catch NULL, so eventfs_create_dir() is called
with a NULL parent and returns ERR_PTR(-EINVAL).  The new cleanup path then
passes eventfs_root =3D=3D NULL to eventfs_remove_events_dir(), which
unconditionally dereferences it in get_root_inode().

Checking IS_ERR_OR_NULL(eventfs_root) or !eventfs_root after
eventfs_create_events_dir() would avoid this regression.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106180657.2460=
376-1-vdonnefort@google.com?part=3D2
