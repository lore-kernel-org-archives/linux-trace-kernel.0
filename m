Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 084D039020C
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:25:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551905; cv=none; b=JzR7lQKAZqEo2EHn+DR4FkUDgHqrtiRLodLxMyM1ZH50ZxZ6j0TfTYx40/nqdLFb96yGiK9Mpp64T5sz77cfWkxm7LCoyOZEroQkwW0wQxm2BoNQRbh2AbIHT+oRrAAFMca94Fw5jq3fd0Lq7iAXZHgHIF8tx4nLPykyTJPWSN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551905; c=relaxed/simple;
	bh=rFMl85qJmcHjjGeAgxWcY6kB9vl960BAGwGsi5M7O2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cV1+Zkxj3jU9bHopT6U7xGcTx2TB5UNeVB3ySnwW6GsoiHqvYOnIQmUhNuH7JWt76+FIkr75AAeTVRiJ8RCIL6RwBYumQ2OyZ9ttZtPE7RrBfNTDMh7MjpfFTYy7SiBIrJvtGVPenzDBoAm+V1J8AYewfe/lATqpjsGs5OH4tVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H6RkPJgu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H6RkPJgu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A4FC1F000E9;
	Wed, 12 Aug 2026 16:25:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551903;
	bh=qwDQIVD4fUgnGGiOUZd+vCDyZDqOmS/CfqAfXm2FdnU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=H6RkPJguDKfcpnT4IaC3ODJ1e0pAitum59pcZWuT/xgeEem/jDZMi2u51/AvPgPzo
	 Dg8ynVVS1QE7ft22vQtP4Pzci76qAE/QGdOapdteWtQlcJPATmIR26800IzvZDGIQH
	 1l8cBv5FAAhPf2XTA9bB9Y4+Edu9TpxdjvcogEzLO03mqIysKnX84rwPVB2JiSqAjZ
	 nv8VK4N5nbg18LbIiDbYUzpOOlyjulrPIcsRIoR4EhErhb791rpg1DnvqjMT6+NMHd
	 IBQYmS5i0VGBbtMSPRUPFIg6W5LQeaCiHHu7AnNtWlRozHn3PcNsJGeET8Sn+jHW8A
	 IGXzm19uoYu2g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 02/18] tracing/remotes: Release tracefs,eventfs on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-3-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:25:03 +0000
Message-Id: <20260812162503.6A4FC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Expanding the global `trace_remotes_lock` over the external driver=
 callback `cbs->init()` introduces a severe risk of deadlocks and priority =
inversion.

Pre-existing issues:
- [Critical] A Time-Of-Check to Time-Of-Use race condition between `trace_r=
emote_tracefs_open()` and concurrent unregistration leads to a Use-After-Fr=
ee.
--

--- Patch [2]: [PATCH v5 02/18] tracing/remotes: Release tracefs,eventfs on=
 registration failure ---
commit 70ddc6ce63b80a301a72ec3efb7683b32447865f
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Release tracefs,eventfs on registration failure
   =20
In trace_remote_register(), if registration of events or the init
callback fails, the created tracefs and eventfs directories are leaked.
Release the entire eventfs and tracefs hierarchy on trace_remote
registration failure.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> index ce2d517183b79..0384277070b9e 100644
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c

[ ... ]

> @@ -972,10 +990,9 @@ static int trace_remote_register_events(const char *=
remote_name, struct trace_re
>  int trace_remote_register(const char *name, struct trace_remote_callback=
s *cbs, void *priv,
>  			  struct remote_event *events, size_t nr_events)
>  {
> -	struct trace_remote *remote;
> +	struct trace_remote *remote __free(kfree) =3D kzalloc_obj(*remote);
>  	int ret;
> =20
> -	remote =3D kzalloc_obj(*remote);
>  	if (!remote)
>  		return -ENOMEM;
> =20
> @@ -986,13 +1003,15 @@ int trace_remote_register(const char *name, struct=
 trace_remote_callbacks *cbs,
>  	mutex_init(&remote->lock);
>  	init_rwsem(&remote->reader_lock);
> =20
> -	if (trace_remote_init_tracefs(name, remote)) {
> -		kfree(remote);
> -		return -ENOMEM;
> -	}
> +	guard(mutex)(&trace_remotes_lock);
> +
> +	ret =3D trace_remote_init_tracefs(name, remote);
> +	if (ret)
> +		return ret;
> =20
>  	ret =3D trace_remote_register_events(name, remote, events, nr_events);
>  	if (ret) {
> +		trace_remote_remove_tracefs(remote);
>  		pr_err("Failed to register events for trace remote '%s' (%d)\n",
>  		       name, ret);
>  		return ret;
> @@ -1000,13 +1019,16 @@ int trace_remote_register(const char *name, struc=
t trace_remote_callbacks *cbs,
> =20
>  	ret =3D cbs->init ? cbs->init(remote->dentry, priv) : 0;

[Severity: High]
Does holding the global trace_remotes_lock while calling the external init()
callback introduce a risk of deadlocks?

Because trace_remotes_lock was acquired via guard(mutex) earlier in this
function, calling an opaque external callback with this global subsystem lo=
ck
held establishes an inverted lock dependency.

If the teardown path of the external driver takes its own locks before
unregistering the trace remote, could this result in an ABBA deadlock?

>  	if (ret) {
> +		trace_remote_unregister_events(remote);
> +		trace_remote_remove_tracefs(remote);
>  		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);
> -	} else {
> -		guard(mutex)(&trace_remotes_lock);
> -		list_add(&remote->node, &trace_remotes);
>  	}
> =20
> -	return ret;
> +	list_add(&remote->node, &trace_remotes);
> +	retain_and_null_ptr(remote);
> +
> +	return 0;
>  }

[Severity: Critical]
This is a pre-existing issue, but is there a race condition between
trace_remote_tracefs_open() and concurrent unregistration?

In trace_remote_tracefs_open(), the code checks if the remote object exists
in the global trace_remotes list:

kernel/trace/trace_remote.c:trace_remote_tracefs_open() {
    ...
    guard(mutex)(&trace_remotes_lock);

    /* i_private is either a struct trace_remote or a struct remote_event */
    list_for_each_entry(r, &trace_remotes, node) {
        if (r =3D=3D i_private)
            return 0;
    ...
}

However, the lock is dropped on return without incrementing the object's
reference count.

Then in trace_open(), the unprotected remote pointer is dereferenced:

kernel/trace/trace_remote.c:trace_open() {
    ...
    ret =3D trace_remote_tracefs_open(inode, filp);
    if (ret)
        return ret;

    if (!(filp->f_mode & FMODE_READ))
        return 0;
    ...
    guard(mutex)(&remote->lock);
    ...
}

If a concurrent unregistration acquires trace_remotes_lock, removes the
remote, and frees it after trace_remote_tracefs_open() returns but before
trace_open() acquires remote->lock, will this result in a use-after-free
regression?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D2
