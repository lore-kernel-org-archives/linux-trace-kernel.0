Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93CE43EC82D
	for <linux-trace-kernel@vger.kernel.org>; Mon, 17 Aug 2026 14:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786975745; cv=none; b=Qr3Amk2wpa4lajCuLtk47L9L8sT3Mt8x9V0Ha09fqiuhaaM8gEhLJziH+UzVdl1rxq6toF1mS2ce/6Qyzc1BCxqJMtI/J2XkNpCLvADW8BZLVb+T81yXQ9n8WB/YdG08ofpYn0UxSNCFN4DkKRH/JRXqVJPtVr2uaeGywHv7yww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786975745; c=relaxed/simple;
	bh=YxI15CVQBIOP0sgvi9swj34VW1zzhGFYDi7YoBYzqow=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VHeAogedxjjwzK7yIU2UWAmZ4sgqe74P+HlvrC2Ke2d+Qw6WO7sPpq39whIZ8qrI0Re3i5vc8jwCCqhYc5aJ2Z56LOuNMCnhW2G36QIwIYGSpttyBO8RKDTJhX6JUAidfV/70fZsfj5402Oh0glhuzRl/hihBNJ1MQmadjkE+9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iZo+R4TO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iZo+R4TO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA76D1F00A3A;
	Mon, 17 Aug 2026 14:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786975743;
	bh=w0KGaMWFwZHJPhKhPzhHym3ld32+sil6HH7GZK7MdkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iZo+R4TOZu1iI3n3WJZ93Ma7p1lSsF754bQho238IT8MJI/DYsGSs6X9Q2lg7BLCd
	 kRf22rRvpM3nu/lWbGUtd/Gwfni14EqHHGDDWU+noPlo55o9E/RQ4bkV7cOzFDLu2/
	 LSfMk4ObQDIwnrq7vVhkctt9emlPISKGQjYJ2ZXPOBiRh8WZaGJ11im6tzc0slT2bF
	 UJ3jtkCiL2w/2BhvsR7rSwERZRJatqOFVkFRQBA7fJ8RWBK19/eGd2pwRD8Rs7rQLi
	 QW/jKT21cPmmxDHiI7fbOAETVXjj3oicXp2xKICFTm1E5dyy5GfdfjKmDpzt/NyUjA
	 AAB2mn9gCJt8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 01/18] tracing/remotes: Gate tracefs files opening on
 trace remote registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260817135517.3919534-2-vdonnefort@google.com>
References: <20260817135517.3919534-1-vdonnefort@google.com>
 <20260817135517.3919534-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 14:09:02 +0000
Message-Id: <20260817140902.EA76D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Error paths in `trace_remote_register()` leak the dynamically al=
located `trace_remote` object and tracefs directories when initialization f=
ails.
--

--- Patch [1]: [PATCH v6 01/18] tracing/remotes: Gate tracefs files opening=
 on trace remote registration ---
commit cea65090c9ee422e607003e731a26fe505c23e56
Author: Vincent Donnefort <vdonnefort@google.com>

tracing/remotes: Gate tracefs files opening on trace remote registration

This patch adds a global list to track registered trace remotes, preventing
users from accessing tracefs files for remotes that are about to be
destroyed. Tracefs open operations are now gated based on whether the
remote is present in this list.

> diff --git a/kernel/trace/trace_remote.c b/kernel/trace/trace_remote.c
> --- a/kernel/trace/trace_remote.c
> +++ b/kernel/trace/trace_remote.c
[ ... ]
> @@ -932,8 +999,12 @@ int trace_remote_register(const char *name, struct t=
race_remote_callbacks *cbs,
>  	}
> =20
>  	ret =3D cbs->init ? cbs->init(remote->dentry, priv) : 0;
> -	if (ret)
> +	if (ret) {
>  		pr_err("Init failed for trace remote '%s' (%d)\n", name, ret);

[Severity: Medium]
This is a pre-existing issue, but does this error path leak the dynamically
allocated trace_remote object and its tracefs directories?

If cbs->init() or an earlier step like trace_remote_register_events() fails,
the function returns an error code without cleaning up the remote pointer or
calling tracefs_remove(remote->dentry). Will this prevent the remote from
being re-registered later due to tracefs naming collisions?

> +	} else {
> +		guard(mutex)(&trace_remotes_lock);
> +		list_add(&remote->node, &trace_remotes);
> +	}
> =20
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817135517.3919=
534-1-vdonnefort@google.com?part=3D1
