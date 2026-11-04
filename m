Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793785148;
	b=fdnsZLnz0BgkwJnP4L2inYFqpQHnVqKl/9476dj60JYz6qZrs7lvBna/NYEt/fik/T9V
	 XsBpseK0cgQG6R7bY6nfeaeiR9eM5x/vMwZGe6fi9bD8zxWI0nftUwsAe9wep/QuMFF+j
	 +9xh50mHi/33cMtEklzPRkVMpi1iF3ky3WM047g09pxFaVYPIHq+7787taNEsqtsiHu2X
	 FtPOIOKxNSkqnv8cr3CB6R0d+ClEllsgXYi08lNOpdbpCzZCMgn7IAmDrfelyDt5J4ERQ
	 WGT67mqBWkIx/E3nOddMGUs5GZ3p9aFuJxp5JKnl5tWPFThx9Pa50IzkqyyOJJ9Ty/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793785148;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MJV9+cPTtmqT+ERvAUlD1ow1B1vhqphHRU0ZKg5DZMU=;
	b=SGxOHr8fx7aGmyRJnGU2V/hk0H0hZdi+ilO0cU4PnoydS/1vTYQvaCDJOt7yEs/K3Sr7
	 E6WiN6fwwicO0F5D7C17WopvyNTHlDKiMJuC4flcea3LVsBA/U40hCv+RfpNRPKNGOt97
	 W95KwMXrrLEZJOJes3+5MDAI3r9R/XLXYBI6O8qNK7gBhG/TLMAuf6NaBZm7ICEAyz5ic
	 iMfvPjArosssfeQx8rlGW2eGNJ2zxRfUFgwWYEZYcS+mGKN3Gn5Xe98WskjKUIFnmzza4
	 S/4P/HNHbV6hmMoq2ujmzPiNksTnV+wCOF/sxXiP+86N4AStUDXVixoRS4VK09LqdZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+54kQR+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D20CE606A333
	for <linux-trace-kernel@vger.kernel.org>; Wed,  4 Nov 2026 09:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+54kQR+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 453F71F0093A;
	Wed,  4 Nov 2026 09:39:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793785147;
	bh=MJV9+cPTtmqT+ERvAUlD1ow1B1vhqphHRU0ZKg5DZMU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+54kQR+jAY8iStIEwiTPYUktk5vMVSTj0ypud3IpwehIe7PfeQF5rLUwDgmF4sKi
	 VnGOqjDafvZ4v6P68fA3kWyBEwqs3+me+Xlg+G9juMqXaCpDB5LNBTnW0q/DG2E/8d
	 S7qYqkX5iSrKIgBrO4Iv0K4Lpt0zrzYgXgGpJCbbFK5g0v0NmDfxS6WRukmf94oy+T
	 uywJV9y0beUoL+sVit6l+pIkKgnwZKla8AvnEwbKRUOamHRKBPtmn/LefT/w0j8K8/
	 FydJaa4mZXuTIFzNA7/OcXxTGxp5Do2nRuw5KjicaJsEtSBDVImVveNRZfqbPosUVy
	 IZi5g3uYPSy0A==
Message-ID: <sashiko-outbox-196976@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 5/6] tools/rv: Parse the mixed enable state of
 containers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Wei Li" <liwei1412@hotmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <CY8PR19MB700974075298C61A1DB70C3EB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
References: <CY8PR19MB70098BF493A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
 <CY8PR19MB700974075298C61A1DB70C3EB7682@CY8PR19MB7009.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 09:39:06 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] tools/rv: ikm_run_monitor() still treats mixed-state container a=
s enabled
--

commit 46a912d6c838892960e060f3a3369c5f213319f7
Author: Wei Li <liwei391@huawei.com>

tools/rv: Parse the mixed enable state of containers

This commit updates __ikm_read_enable() to parse the "X" mixed enable state
of containers as 2 and displays such containers as [MIX] in rv list.

> diff --git a/tools/verification/rv/src/in_kernel.c b/tools/verification/r=
v/src/in_kernel.c
> index e6dea4040f8f4..0f2e9f1eca51f 100644
> --- a/tools/verification/rv/src/in_kernel.c
> +++ b/tools/verification/rv/src/in_kernel.c
> @@ -29,21 +29,38 @@ static char *config_reactor;
>   *
>   * __does not log errors.
>   *
> - * Returns the current status, or -1 if the monitor does not exist,
> - * __hence not logging errors.
> + * Returns 0 if disabled, 1 if enabled, 2 if a container with children
> + * in mixed states, or -1 if the monitor does not exist, __hence not
> + * logging errors.
>   */
>  static int __ikm_read_enable(char *monitor_name)
>  {
>  	char path[MAX_PATH];
> -	long long enabled;
> -	int retval;
> +	char *buffer;
> +	int enabled;
> =20
>  	snprintf(path, MAX_PATH, "rv/monitors/%s/enable", monitor_name);
> =20
> -	retval =3D tracefs_instance_file_read_number(NULL, path, &enabled);
> -	if (retval < 0)
> +	buffer =3D tracefs_instance_file_read(NULL, path, NULL);
> +	if (!buffer)
>  		return -1;
> =20
> +	switch (buffer[0]) {
> +	case '0':
> +		enabled =3D 0;
> +		break;
> +	case '1':
> +		enabled =3D 1;
> +		break;
> +	case 'X':
> +		enabled =3D 2;
> +		break;
> +	default:
> +		enabled =3D -1;
> +	}
> +
> +	free(buffer);
> +
>  	return enabled;
>  }

[Severity: Medium]
The commit message notes that rv fails to start a container in a mixed state
because rv mon takes the return value of __ikm_read_enable() as a true value
and reports a spurious "already enabled" message.

However, in tools/verification/rv/src/in_kernel.c, ikm_run_monitor() still
checks for any non-zero return value from __ikm_read_enable():

	retval =3D __ikm_read_enable(full_name);
	if (retval) {
		err_msg("ikm: monitor %s (in-kernel) is already enabled\n", nested_name);
		return -1;
	}

When a container has children in mixed states, __ikm_read_enable() now
returns 2, which is still non-zero (as is -1 on read errors). Won't
ikm_run_monitor() still treat a mixed-state container as already enabled and
refuse to start it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/CY8PR19MB70098BF493=
A3B67418C7B9ABB7682@CY8PR19MB7009.namprd19.prod.outlook.com?part=3D5
