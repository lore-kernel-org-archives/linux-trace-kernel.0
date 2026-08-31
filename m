Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 608143C661A;
	Mon, 31 Aug 2026 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788173853; cv=none; b=VSydqz98B8rc/2/nCxLhuY13T+9toouMQm0/iJsqK/TgAn8NYkOb2znlCpdz5D5z5G0vMx+gTehExvMF7VsgyDYs3d8hM3+pF7eNHzIvF59JwKbjo2GBdy4sBdoRtm3i3OCmsxKIbKAcrN0eK5FgpmAl9fvQI+7+ejoOafsjT4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788173853; c=relaxed/simple;
	bh=6hKulcsmkGXoPQi1Sfy1k1PBmROJVwUUXLqTnA4KjzY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=g/U0NuzYBdRauieCqlUD8kSQrx3wLBQ7s9arThIk6/NQ+qMw7R9yXYSQb4anqKhSXCRRpPKr9HP/BawXmDrqlK4/KND6C2VEw5O9b3YDYMnFvv4M92rZUDocRNWd1bggJOjkJpHBl5u5t48wF4llkfIAnRHmTpLFGSaEbC7ST+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hbEIJ+8E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hbEIJ+8E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB3881F000E9;
	Mon, 31 Aug 2026 10:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788173852;
	bh=vrfzqR96K6YzbP13qthFbDqueG9yGDiFYSK7+qiT6Sw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hbEIJ+8Eu70vrOd2Z7MbJDH/wGH8e81GpnX87z3x3cRIi9M5YNC4/bYfPoyFeSA9s
	 FsUB1BKFDxinYYUceBAq6qssGlMsw0LayGshFMNDJPctCrekW4BLxg/sdWU74QMogA
	 4utdlEdCRUsUUpFOY86PYbPuZsHFP2jbZMLxF0KVHTCKiO8UkitHhVla02F4366HLF
	 p0vo+KdBk7lezu1O9RPWI0+r3t2F3E0alSc6/chQhZWH92kj95M7aoG6TWR1zyV30Q
	 VktNwvM+qCDVStHUPBx7Sj/+KNtkPX0dANkP+m0IllajNEQK/Y/ejgxAjBBgjWvoN/
	 5xwB+a1o3hClg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] module: pull out add_taint_module() to be public
Reply-To: sashiko-reviews@lists.linux.dev
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-modules@vger.kernel.org
In-Reply-To: <20260831-bind_taint-v2-1-1082d631213b@linuxfoundation.org>
References: <20260831-bind_taint-v2-0-1082d631213b@linuxfoundation.org>
 <20260831-bind_taint-v2-1-1082d631213b@linuxfoundation.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:57:30 +0000
Message-Id: <20260831105731.CB3881F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Syntax error in the !CONFIG_MODULES fallback definition of add_tain=
t_module().
--

commit e590786e5c6c86656ecff2a254d3a27b11cc2eb2
Author: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

module: pull out add_taint_module() to be public

This commit makes add_taint_module() global so that other kernel code can=20
call it. When loadable modules are disabled, it defaults to a direct call=20
to add_taint().

> diff --git a/include/linux/module.h b/include/linux/module.h
> --- a/include/linux/module.h
> +++ b/include/linux/module.h

[ ... ]

> @@ -877,6 +881,12 @@ static inline bool module_is_coming(struct module *m=
od)
>  static inline void module_for_each_mod(int(*func)(struct module *mod, vo=
id *data), void *data)
>  {
>  }
> +
> +static inline void add_taint_module(struct module *mod, unsigned flag,
> +				    enum lockdep_ok, lockdep_ok)

[Severity: Low]
Does this introduce a syntax error for !CONFIG_MODULES builds?

It appears there is a comma instead of a space between the type and the=20
variable name in the parameter list (enum lockdep_ok, lockdep_ok). This=20
will cause a build failure when configuring the kernel with CONFIG_MODULES=
=3Dn.

> +{
> +	add_taint(flag, lockdep_ok);
> +}
>  #endif /* CONFIG_MODULES */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-bind_taint=
-v2-0-1082d631213b@linuxfoundation.org?part=3D1
