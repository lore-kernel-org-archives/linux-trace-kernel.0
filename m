Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795791739;
	b=Zy0QOwh3g+3C+YXvhxAwwVMVDJMJ867erd+T9YOOMBTsI9Z+EEleL+VYY6cozmvvPhuv
	 M0r6wO79QydXkurT2BPfCiX0MUdgFrvDv6dSltoASzwFJ+o+ODtk2H11bEYOjGH2Koc7G
	 kNwhcGuWcUvB2uaQjiBG1gHh4utsty9oDRzjn01YALK2VWHjkRHfWp4WMQN28UrZYzg7c
	 hhLECXHU3yAaFyBfgHVDVp/bM6L+t6fVHFUWoXfpZP3CXEToXVGD9Q/o8UeveG3wFBy6G
	 l3R7pF5OfmMEAqLy2WV0BgjCS2A3VQGyjNYNFdm53HFWxfLn1m7hbFGtla2BCA6vYjg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795791739;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dMOdHJqD8f2DX0k2c/3C9DzsiE29S4B99vTMeGwDCHo=;
	b=COULkDiTepPYY1nkA81+Ld5K53kUYXt3P4qY2/wa4HFMMDuLRHBu2C+pumeGSdc6x0PQ
	 mY66TDFMNslT9tQSzl70JflCBpGoQWCpW+GSZr+I8VAaupls25BVUeD59e1Z6qUes0ssK
	 sxUBgUi6JZ56qwCK65cwBzmv9sksraIfNLgKb5HABm7LNFQp1IpZyZajR9X/Xclqergqn
	 5SgxQ2kNlysp/aGbp3WVRAJzZ72AuhX4xgx3P7u4L1x26QFPM9Yjrkx5LwZm+9/7KrYFq
	 rG2rhvfv9urRppnzYzuK0otNB8rn2yq6NVsS5EYF5OPPTg7xNpt5uzq84zfjx4BJC2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsYZCkqd;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F57A606A31C
	for <linux-trace-kernel@vger.kernel.org>; Fri, 27 Nov 2026 15:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NsYZCkqd
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DAE1F000C1;
	Fri, 27 Nov 2026 15:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795791739;
	bh=dMOdHJqD8f2DX0k2c/3C9DzsiE29S4B99vTMeGwDCHo=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=NsYZCkqd6WpIM5IzoLKutlrV10TfmghOA+C45Sp4eJ2T8ykuMfmwdfZOC9DgnpZDq
	 DMOHF4PfxsrwVW1YzaetySggfqH7rZwMxhk+NZkGm12zYM7TqUSBFnzbCE+6EyTekS
	 zpLIhp6C9rDjnZUIIuVeGF2knpYj3jmYRit8gfvVFGKQFjT3rNIljF9eS7EqPyVugn
	 bm0jnbjNju3Oolaa/v+OwEs2BYYJykq8Uev+g81O+ze78oIYoA+ZbV1EBWx9cBDH2f
	 kZw3gz7HSk4FlJQV53YaUUDwB5SRVT6K80Le3QbJRJ/b1OKfyCh7dYlni2JQMBQB1I
	 cRKsNn/DtRHUQ==
Message-ID: <sashiko-outbox-237662@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH 1/5] bootconfig: Add multi-config ID helpers and
 xbc_init_configs() support
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261127144614.61194-2-mhiramat@kernel.org>
References: <20261127144614.61194-1-mhiramat@kernel.org>
 <20261127144614.61194-2-mhiramat@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 15:02:18 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] bootconfig: unclosed brace on reused key misattributed in
  xbc_init_configs()
--

commit 9ef6591953493a8a81a45580cc486a9c5b6fe288
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

bootconfig: Add multi-config ID helpers and xbc_init_configs() support

This commit adds helpers for parsing and selecting named bootconfig blocks
and introduces xbc_init_configs() to concatenate and parse multiple enabled
configs into a single XBC tree.

> diff --git a/lib/bootconfig.c b/lib/bootconfig.c
> index 9ae9a215b1da3..fe27e72c9ee54 100644
> --- a/lib/bootconfig.c
> +++ b/lib/bootconfig.c
[ ... ]
> @@ -1134,12 +1129,219 @@ static int __init xbc_parse_tree(void)
>  	} while (!ret);
> =20
>  	if (!ret) {
> -		while (p < xbc_data + xbc_data_size - 1 && *p =3D=3D '\0')
> +		while (p < data + size && *p =3D=3D '\0')
>  			p++;
> -		if (p < xbc_data + xbc_data_size - 1)
> +		if (p < data + size)
>  			ret =3D xbc_parse_error("Unexpected data after null character", p);
>  	}
> =20
> +	if (!ret && brace_index) {
> +		n =3D &xbc_nodes[open_brace[brace_index - 1]];
> +		ret =3D xbc_parse_error("Brace is not closed",
> +				      xbc_node_get_data(n));
> +	}
> +
>  	return ret;
>  }

[Severity: Medium]
Can an unclosed brace in a later config be misattributed to an earlier
config in xbc_init_configs()?

When a subsequent config reopens a key that was already defined in an
earlier config (for example, top-level "kernel {") and omits the closing
brace, __xbc_add_key() reuses the existing struct xbc_node from the
earlier config without updating node->data:

lib/bootconfig.c:__xbc_add_key() {
	...
	node =3D find_match_node(node, data);
	if (node) {
		last_parent =3D node;
	} else {
	...
}

Because xbc_node_get_data(n) still points into the earlier config's slice
of xbc_data, xbc_parse_error() sets xbc_err_pos to an offset within that
earlier slice.  The error-mapping loop in xbc_init_configs() then reports
the earlier config's index in *err_idx and its offset in *epos instead of
blaming the config that left the brace unclosed.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127144614.6119=
4-1-mhiramat@kernel.org?part=3D1
