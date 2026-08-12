Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C8F38F64E
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Aug 2026 16:31:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552273; cv=none; b=AFcLp84wdJ3Yzs54/SC/fvTYgRSKGcUN0TduQi+x16TFyiUYtW/cTTe/5CSXmTdi0T2Iq07gD5khSky2fD4XJJDIn7RbLUd0F8eB0dERKu7Y3ADgWoy1IXGP9CaZlwyYSHyXuEN4OhX8h8M4+qTNQIDjeaNtl9KFMsJZh4HBUS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552273; c=relaxed/simple;
	bh=2/eNevK/v15VTvoTGo4LBCdX9tG4S0HEqQ0maAt1uG4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VWH8kc6NEur/DNdasWxiff1TIotWsPa+a2LkHhlzjIZsr5OHdmzkqvELXUSqhDz5huZYfKu0MJA41QNN1gIykgoDJQ0Kg7rbhyYqb7Qm4byneE8HNsJ7VsCC9XKhCMvDVQCDJsP3W/HZIl8ls6whC+0i5UCCRDB33OMizPkcO5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZS2Z7Ddm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZS2Z7Ddm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 587781F000E9;
	Wed, 12 Aug 2026 16:31:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552271;
	bh=BXtlXHZ1tD7SQrXsX/Hf0RJpLVa2B5ZjJGEQnmzAsog=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZS2Z7Ddm7i72ZbiKbk/EFi0Lu6AvsCB3oEITnvmaOhHQFLTwODdlkdzFQltMX5GgT
	 NYwrHZEqcYD9wDENr4h0/0yqu+COB34OM8KaZdJw08oir3zrD7t/7EUu2m9/r6SPgS
	 edY6lMHHqK/EW054O1CVJ+/5m2QQmvyf7bSmMjWVn+Q/RVwr+x47XhRsAGNmKXoBig
	 Us6B/Tcek1DuIUNS3XXHnQ0iYqS3jS/GwGNp/AfyuPqi+5ArUZruuGQXiZFscFVhN1
	 GQQVDBg2MhN9f7S8SK0UjfAq3bUuh+eKOhuiU7pIBFoOo/3CbfNhihR4WMeP2n2Wec
	 WUAB81zNMbEPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 01/18] tracing/remotes: Gate tracefs files opening on
 trace remote registration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260812161340.2417322-2-vdonnefort@google.com>
References: <20260812161340.2417322-1-vdonnefort@google.com>
 <20260812161340.2417322-2-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:31:10 +0000
Message-Id: <20260812163111.587781F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Incomplete tracefs gating: Caller-created tracefs files bypass the=
 newly introduced `trace_remote_tracefs_open` gating, leaving them fully ac=
cessible if registration fails.
--

--- Patch [1]: [PATCH v5 01/18] tracing/remotes: Gate tracefs files opening=
 on trace remote registration ---
commit 63ef30c302e1341f240b4f5b82d4e65d421da4cf
Author: Vincent Donnefort <vdonnefort@google.com>
tracing/remotes: Gate tracefs files opening on trace remote registration

This commit adds a global list of registered trace remotes and a gating
function to prevent access to tracefs files for remotes that are being
destroyed or failed to register. Standard trace remote file operations
are wrapped to check this list before allowing open().

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
> +	} else {
> +		guard(mutex)(&trace_remotes_lock);
> +		list_add(&remote->node, &trace_remotes);
> +	}
> =20
>  	return ret;
>  }

[Severity: High]
Does this leave caller-created tracefs files exposed if cbs->init() fails?

If a remote's initialization fails halfway through, any custom tracefs files
already created by cbs->init() will leak and remain accessible. Because
trace_remote_tracefs_open() is static to trace_remote.c, the caller cannot
wrap their custom files' open() callbacks with this new gating mechanism.

For example, if KVM's hyp_trace_init_tracefs() successfully creates
a 'write_event' file but fails later, trace_remote_register() returns an
error and the remote is not added to the trace_remotes list.=20

Userspace could then open the leaked 'write_event' file, bypassing the
gating entirely, and trigger kvm_call_hyp_nvhe() against the uninitialized
hypervisor stub.

Should trace_remote_tracefs_open() be exported so that subsystems can gate
their custom files, or should the leaked files be cleaned up when
trace_remote_register() returns an error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812161340.2417=
322-1-vdonnefort@google.com?part=3D1
