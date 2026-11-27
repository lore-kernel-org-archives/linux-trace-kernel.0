Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795792266;
	b=ULySbtJQ3ySxlmXNQKFx/zDItgk//JgzyfirIh6bLBmM2uZl1fYE/5lVEZQpO/erlPqk
	 gt1Wkeae+sSO+5Jjruj3MGkf7k7H5palocYYiXsIesJoLcvq5nXjV3DTcrUHQCJrIQ3xi
	 eYgnJ5OjUON1/Aip0DWoW1R2Nml1iYgeF4mCzwhdK4qUuBTpqed/Kz6IJzC5VMMRwcOqJ
	 GvUVpo+CW2OPT2TDN54tBJIsI9RxTv2mQ4b9JO+hKAPgBrX4CJ0rh/IBDpJpJysnkcZ9z
	 7K53y6bOB5n6SjefRNEXl+p5df0EcxcSz7b+o4u2feWbJGulG6wRHASVnfMWDuEiGpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795792266;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=8uX5IooKwTnwk7L5O4VKisImlvv7mTHG1V1iBIN1KTU=;
	b=5ECioB20ALFYw4YlJrlCZsw1xmWXWqXsU48v062XAAQQjVPWzXj89HDCCHjTlzfobKu9
	 74ARFlW5THufvfcEquORinmEKifASYNuYdI44B1Rb1Okd74eGtfaNFGcEwKkzD2X1i5Ls
	 XcMr+Fh4RwGWzCZV3i9+ncMzhVtiiyDWU/x4QtPyV/LvTwifhzd4ney5z5hiuJeX/N11L
	 qBM6l3dePMoAWHLpLc7upEDUZHjbAau41Sk1QQT7Z7AfSKf1CnUVFTEAzuqAxhnLUV3SS
	 +Wngx1PkFPephEgalt9WksVl+4dgyrZjgz1nz3ITz9Tf3DtauhyuVbmSODVoYB36QXA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8LIvOBt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B133D606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=J8LIvOBt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 041461F00898;
	Fri, 27 Nov 2026 15:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795792266;
	bh=8uX5IooKwTnwk7L5O4VKisImlvv7mTHG1V1iBIN1KTU=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=J8LIvOBtNEPJqv3oUxJRIuChmr0WRf5u9lftJ67EZ7ty8I+VfRDKLMhyMXMnf9LWl
	 4dtSyTZ1xeDZtoj+SOerz3P9QBdWYVFeitDSob6RcPYmaorvy/PZ68XVPwyoQLpuMu
	 L0/HDVYXFJyFSvvUJhPWlAeyN2fdHpFWTTSneUU5Seq+B9GOgRWGoS2VFApdLhLD9p
	 ci/NMUDuXtWtg5Kd1wniLgUVTVDuj7tBEAqVhUc3i68SkbHZzRaYxjbYCjocboo46J
	 j+yTOkaknS7qigCCYQY2zEh73Y6ykgZJ2jU2GNmWb4gtCpwwPU2kO+FyeKGIHjKs1H
	 Zcl6jHKWMWMrQ==
Message-ID: <sashiko-outbox-237682@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 2/5] bootconfig: Support stacked initrd bootconfigs
 and bootconfig= selection
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261127144614.61194-3-mhiramat@kernel.org>
References: <20261127144614.61194-1-mhiramat@kernel.org>
 <20261127144614.61194-3-mhiramat@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:11:05 +0000
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
- [Medium] bootconfig: unmatched bootconfig=3D selector bypasses
  CONFIG_BOOT_CONFIG_FORCE
- [Low] bootconfig: wrong config blamed for unclosed brace in
  xbc_parse_tree()
--

commit d486115d0ecb79c7d4d59dbde4c3a203ebf39848
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

bootconfig: Support stacked initrd bootconfigs and bootconfig=3D selection

This commit adds support for unpacking up to 32 stacked bootconfig trailers
from an initrd image and selecting which entries to merge via the
bootconfig=3D kernel command-line parameter.

> diff --git a/init/main.c b/init/main.c
> index f147803450513..a539eb5b0cd12 100644
> --- a/init/main.c
> +++ b/init/main.c
[ ... ]
> @@ -475,16 +575,35 @@ static void __init setup_boot_config(void)
>  		return;
>  	}
> =20
> -	ret =3D xbc_init(data, size, &msg, &pos);
> +	report_bad_boot_configs(cfgs, count, total);
> +
> +	if (!bootconfig_found && IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE))
> +		cfgs[0].enabled =3D true;
> +
> +	for (i =3D 0; i < count; i++) {
> +		if (cfgs[i].enabled && cfgs[i].data) {
> +			any_enabled =3D true;
> +			break;
> +		}
> +	}
> +	if (!any_enabled)
> +		return;
> +
> +	ret =3D xbc_init_configs(cfgs, count, &msg, &pos, &err_idx);
>  	if (ret < 0) {
> -		if (pos < 0)
> +		if (err_idx >=3D 0)
> +			pr_err("Failed to parse bootconfig [%d%s%.*s]: %s at %d.\n",
> +			       err_idx, cfgs[err_idx].name_len ? ":" : "",
> +			       (int)cfgs[err_idx].name_len,
> +			       cfgs[err_idx].name, msg, pos);

[Severity: Low]
Can this blame an earlier bootconfig block when a later overlay leaves a
brace unclosed on an existing key?

When an overlay reopens a key that was already created by an earlier
block, __xbc_add_key() reuses the existing xbc_node via find_match_node()
and __xbc_open_brace() pushes that node's index onto open_brace[].  If the
brace is left unclosed at the end of the overlay, xbc_parse_tree() reports
the error at xbc_node_get_data(n):

lib/bootconfig.c:xbc_parse_tree() {
    ...
	if (!ret && brace_index) {
		n =3D &xbc_nodes[open_brace[brace_index - 1]];
		ret =3D xbc_parse_error("Brace is not closed",
				      xbc_node_get_data(n));
	}
    ...
}

Because xbc_node_get_data(n) points into the slice that first defined the
key, xbc_init_configs() maps xbc_err_pos back to that earlier block's
err_idx and byte offset.

> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index fe27e72c9ee54..44177b7c08660 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
> @@ -115,33 +115,54 @@ bool __init xbc_embedded_cmdline_applied(void)
>  }
>  #endif	/* CONFIG_CMDLINE_FROM_BOOTCONFIG */
> =20
> -/* parse_args() callback: flag when the "bootconfig" parameter is presen=
t. */
> -static int __init bootconfig_optin(char *param, char *val,
> -				   const char *unused, void *arg)
> +struct xbc_cmdline_select_ctx {
> +	struct xbc_config *cfgs;
> +	int count;
> +	bool seen;
> +	bool active;
> +	bool warn;
> +};
> +
> +/* parse_args() callback: track opt-in and update enabled bootconfig ent=
ries. */
> +static int __init xbc_cmdline_select_cb(char *param, char *val,
> +					const char *unused, void *arg)
>  {
> -	if (!strcmp(param, "bootconfig"))
> -		*(bool *)arg =3D true;
> +	struct xbc_cmdline_select_ctx *ctx =3D arg;
> +
> +	if (strcmp(param, "bootconfig"))
> +		return 0;
> +
> +	if (!val) {
> +		ctx->active =3D true;
> +	} else if (*val =3D=3D '\0') {
> +		ctx->active =3D false;
> +	} else if (*val =3D=3D '+') {
> +		if (!ctx->seen || val[1] !=3D '\0')
> +			ctx->active =3D true;
> +	} else {
> +		ctx->active =3D true;
> +	}
> +
> +	if (ctx->cfgs)
> +		__xbc_enable_configs(ctx->cfgs, ctx->count, val,
> +				     &ctx->seen, ctx->warn);
> +	else
> +		ctx->seen =3D true;
> +
>  	return 0;
>  }
[ ... ]
> +bool __init bootconfig_cmdline_requested(const char *boot_cmdline, int *=
end_offset)
> +{
> +	struct xbc_config emb =3D { .name =3D "", .name_len =3D 0, .enabled =3D=
 false };
> +	const char *data;
> +	size_t size;
> +	bool active;
> +
> +	data =3D xbc_get_embedded_bootconfig(&size);
> +	if (data && xbc_parse_id_header(data, size, &emb) < 0) {
> +		emb.name =3D "";
> +		emb.name_len =3D 0;
> +	}
> +
> +	active =3D xbc_parse_cmdline_bootconfig(boot_cmdline, &emb, 1,
> +					      end_offset, false);
> +	if (IS_ENABLED(CONFIG_BOOT_CONFIG_FORCE) && !active)
> +		return true;
> +
> +	return active && emb.enabled;
> +}

[Severity: Medium]
Does an unmatched bootconfig=3D<sel> parameter bypass
CONFIG_BOOT_CONFIG_FORCE=3Dy instead of falling back to index 0?

xbc_cmdline_select_cb() sets ctx->active =3D true for any non-empty val even
when __xbc_enable_configs() finds no matching entry and leaves every
cfgs[i].enabled set to false.  Because active (and bootconfig_found in
setup_boot_config()) is true while no config is enabled, the
CONFIG_BOOT_CONFIG_FORCE fallback (!active / !bootconfig_found) is skipped
in both bootconfig_cmdline_requested() and setup_boot_config(), so no
bootconfig is applied at all.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127144614.6119=
4-1-mhiramat@kernel.org?part=3D2
