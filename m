Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370BB34C826
	for <linux-trace-kernel@vger.kernel.org>; Mon,  4 May 2026 08:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777885164; cv=none; b=tsnJCPfAxGrv055jgq51vFqWip0XqjnYpsBSRFVf5IxMDcvEBpngndy9+B76ysIPqQwHlTMIWuKMQa/YlcqUc++KgA1QUP5YWAfz81eA9Sce2dSaUaSpq+rAKXPD4EIn7fsX/O65O0bpnr6h7fyMEqQ3ma/729pndUZx4z8/b54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777885164; c=relaxed/simple;
	bh=dEhNXKwTJpY44w1jN3+6NZdIzztWaYU4GnzJVkjkj6g=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=DLOTwDrOUlTpSzr5z7SORApccf8sIOAbondkgvDLc+aS47fL/cL+TkzdZHNR4wsTih0UD79OiZMPFQf16RwF4GjBg5iN306VWbKTeLSZRQwdADSCiZnsusHHLIa0hlDhXpug3dXHyH7HdYqbirxhfJyI2hhKrZ6wLzc+/jHqoBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b=KVTfDGAJ; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20251104.gappssmtp.com header.i=@baylibre-com.20251104.gappssmtp.com header.b="KVTfDGAJ"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-449e96a8a80so2098483f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Mon, 04 May 2026 01:59:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20251104.gappssmtp.com; s=20251104; t=1777885159; x=1778489959; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IDsf9M2K7rO2aXaQIcn1G0mSaPsSRX7OpLrKH4YUyEg=;
        b=KVTfDGAJWr5BB59jyqnTdPfKZpOhqQoGpC7uWhhoVu8OlyqCKdICPyN47StcFKS5VZ
         y45VqdWXX3snGhgpdoodLm6ECSu99O2FTgm93HSYkOpm86bgikicdQfLCjEFSzo40Hcf
         ZfFw02FtbwJzv1kA/DXfDqYj79p6dwD1if9rt9MudQejm74zMn7xv30H0M5oDznuX1ik
         ahBe4iv/HBODGIHQSooegwYC3a0IS2/eN8Py9X6HF3rlKZo/dVtZ3ja/UNfRAbqcJSmZ
         EWUDbmTwVI03po9TcChrrzuzvn2UFDZvrfVZ+inafsY9Zc4N5cO5m+FThFpC6vjW64zW
         6I4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777885159; x=1778489959;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IDsf9M2K7rO2aXaQIcn1G0mSaPsSRX7OpLrKH4YUyEg=;
        b=nJ3pWtbWmVzsuOCiVLAPL0KAwI/G+FJG0LJgNr7FfVW+vu3SbA1GbEnPLtPQbKA33i
         2TCei9SUFnRweHkS3Z+ki9+CasuESfr4LxsUxzCHIYIle/grttQ4CAAOT5jjuVNyQkgH
         hMOrVlWc6nuTMmMvADBwJbmfpLA+gwJM2wdI46AxQBxZn5u9QJB1HZJZyN6ksC0mOJxT
         N7niso6jt6mOp5VPWTxvinzDUXl3N2ENyAi4ejTsBIfzpM+7myNgkOtpxopGyiBmDs+Y
         +F0mpWI8PLnpwQ3yOUmZfpm5Yim0lKxCylv0jTjjwFe+hru4kCOtLCLJwRKU40Dclc2j
         3pxg==
X-Forwarded-Encrypted: i=1; AFNElJ9/dq9q6cHLIU2MV2ad4jyNGRRtOX1xsmJhF/eUfDhLAwfsubep/HMWQhcC0O7ZdIgPCASjpGMHCF/gFOyt6+iYQj4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1cHtFbr6oMkJvuvlyoEjB2jEIyDlZBNe040KvA0yn5khyBHjL
	rqvGLEuBwIk64Th4NcqSRMn64VVb19VShSw6Z5VrpvfxgRRMOTMn0RKV6zwHvS7o4rs=
X-Gm-Gg: AeBDieuo4f6jYs1pHzhGM8rt8X+EdYPfZDxLWybjSdiBFrKVIk8Y558lx1548pMH/C2
	DgjTYjc8y2//CeI1f6/oBwx+SchE/1NiKTz1JpiXN3YvHSmfF5Eeze3UbIU/eqKgNq2LsYzsCe8
	pyBT8rTI+o8gGvSaVXsoR6npZdIJXyHDImsEoCHstKppO1CT9l3HGISZKWek1SxdJGGnIuw8UZo
	1+LAqA1yOciKz6i9c/y0uH/+aayhcYUWLLfMdP2XVGEJ/0vKrMpMcIAwm9KgwX4n98sRnyVb+lq
	Qa4t7fmsBSV/vz1GDmNuoaUjWu6kNQoT2RbZZBG7kL4lyLrkURbTejTfWAu2fL4cv+PYO7OvELp
	qhl9jrhuQrZD0DSucwzz19Gj+etNjEKhsKZLuiYY7us9IDTRFKwgGfrSj9OSx7hPExqRV4T2flp
	Caum03zoUwZz0ui6kGcOOBlPo8AQ==
X-Received: by 2002:a05:6000:2dc6:b0:43f:e99a:ff91 with SMTP id ffacd0b85a97d-44bb4538036mr13012151f8f.4.1777885159017;
        Mon, 04 May 2026 01:59:19 -0700 (PDT)
Received: from localhost ([62.246.35.158])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a8f237368sm23339485f8f.14.2026.05.04.01.59.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 01:59:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary=35a30cf5af1e13a12720f82ef798f2848d6696bf81a6e26b812c6fdf99b8;
 micalg=pgp-sha512; protocol="application/pgp-signature"
Date: Mon, 04 May 2026 10:59:10 +0200
Message-Id: <DI9ROQRRXZJI.3MUR7JAFEB02C@baylibre.com>
Cc: "Markus Schneider-Pargmann" <msp@baylibre.com>,
 <linux-trace-kernel@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tracing: probes: remove unused variable
From: "Markus Schneider-Pargmann" <msp@baylibre.com>
To: "Martin Kaiser" <martin@kaiser.cx>, "Steven Rostedt"
 <rostedt@goodmis.org>, "Masami Hiramatsu" <mhiramat@kernel.org>
X-Mailer: aerc 0.21.0-126-g9e77103592fe
References: <20260502135826.146257-1-martin@kaiser.cx>
In-Reply-To: <20260502135826.146257-1-martin@kaiser.cx>

--35a30cf5af1e13a12720f82ef798f2848d6696bf81a6e26b812c6fdf99b8
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8

On Sat May 2, 2026 at 3:57 PM CEST, Martin Kaiser wrote:
> params is always NULL in traceprobe_expand_meta_args, it can be removed.
>
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

Reviewed-by: Markus Schneider-Pargmann (The Capable Hub) <msp@baylibre.com>

Best
Markus

> ---
> Would it be better to return ERR_PTR(-EOPNOTSUPP) instead of NULL, simila=
r to
> what is done in other places where NOSUP_BTFARG is logged? This would mak=
e the
> parsing fail if $arg* is used without BTF support. At the moment, we skip=
 the
> $arg*...
>
>  kernel/trace/trace_probe.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
> index e0d3a0da26af..b627093a941e 100644
> --- a/kernel/trace/trace_probe.c
> +++ b/kernel/trace/trace_probe.c
> @@ -1729,7 +1729,6 @@ const char **traceprobe_expand_meta_args(int argc, =
const char *argv[],
>  					 int *new_argc, char *buf, int bufsize,
>  					 struct traceprobe_parse_context *ctx)
>  {
> -	const struct btf_param *params =3D NULL;
>  	int i, j, n, used, ret, args_idx =3D -1;
>  	const char **new_argv __free(kfree) =3D NULL;
> =20
> @@ -1747,7 +1746,7 @@ const char **traceprobe_expand_meta_args(int argc, =
const char *argv[],
>  		if (args_idx !=3D -1) {
>  			/* $arg* requires BTF info */
>  			trace_probe_log_err(0, NOSUP_BTFARG);
> -			return (const char **)params;
> +			return NULL;
>  		}
>  		*new_argc =3D argc;
>  		return NULL;


--35a30cf5af1e13a12720f82ef798f2848d6696bf81a6e26b812c6fdf99b8
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iKMEABYKAEsWIQSJYVVm/x+5xmOiprOFwVZpkBVKUwUCafhf3hsUgAAAAAAEAA5t
YW51MiwyLjUrMS4xMiwyLDIRHG1zcEBiYXlsaWJyZS5jb20ACgkQhcFWaZAVSlPA
zgD+P6p7zHSnQM1LXdyxRfqjN6QN4jJzqHnZB+0O2/nlJuMA/il9i2jv73MyVJ7H
SnJEW7P6DiDFi8pyQ95hDU58orMK
=jN9s
-----END PGP SIGNATURE-----

--35a30cf5af1e13a12720f82ef798f2848d6696bf81a6e26b812c6fdf99b8--
