Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4300E17D6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Aug 2026 02:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787709616; cv=none; b=l4WH38F73XckQZCbuoPdbxeXXDsKTxxE/9wuLX8LrKexT7MG2JEeqYbNt6GO9axk/TJIFJT+U98JelPBJnNMPTykuPYiyZz9Qhfszz4/0/Jy5x9W5h+HXG09Lszs3cp2J245knFCsLiSZzRysoBNweqLju06wQ/XysKL1kyfV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787709616; c=relaxed/simple;
	bh=vjdqqDWbG6268IlApfRv4qb6nP2zSye5qvoyuI7g2+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=VHMhHrc7ZZ9Dz5lq6RokdoGiBrjj6eOgchHj2ipMbYP9BZDKshAMWl9aztRdDHzpcjZYXriBv0AqOMXmoMWupAr3fYEnN5o8cuGLxPZzeiY5XzEmR8amLWymK0o2We/qjKrC4Q7aBwIoj3knmMKewtaBGEHNBQEljayPTE793uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZNwkLnZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZNwkLnZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBDA81F000E9;
	Wed, 26 Aug 2026 02:00:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787709615;
	bh=ASQNVN9LU8P4ngKJfHXa+QkZzjp8bWyLz0zx6y7vdns=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZNwkLnZKdxgfJz4PEfcJKR4tJr13orA5ehsn9oLArH1aF9jrGTq4zXAwv8p0JEAfS
	 lp75jWAPxW0QvggCSGPr77zy3pVJwm4qemXv31t1DwS6hM4lJdMEtUVzA4a8/5RnZu
	 uTqhtaNws/BYpaHb9KoN6gZzu/UQU7zyebq+cgt3/ldQPGex4BsKlAp5Gak7vB4o9C
	 qtH30oM7OlT5NEp+1KfNyabLmyDVVLsa0Xttj5eA/m/8m6bjFuV/Scn6EkB/D7sDMs
	 JH1oZ1nls4K8PweP/QbwTsw5TcdSnhrZ37U7S3tUAcBHaRbBs74a16XK0PfARixwa5
	 Pwc2/IrOAa3tw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] samples/ftrace: Fix kthread_stop() on ERR_PTR in
 ftrace-direct-multi-modify
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haotian Zhang" <vulab@iscas.ac.cn>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20260826015050.10772-1-vulab@iscas.ac.cn>
References: <20260826015050.10772-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 02:00:14 +0000
Message-Id: <20260826020014.EBDA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The patch fixes an invalid pointer dereference resulting from a kt=
hread_run() failure in ftrace-direct-multi-modify.c, but leaves the identic=
al vulnerability unpatched in ftrace-direct-modify.c.
--

commit 7f181703b20421e482d5701113538a5a801d8141
Author: Haotian Zhang <vulab@iscas.ac.cn>

samples/ftrace: Fix kthread_stop() on ERR_PTR in ftrace-direct-multi-modify

This commit fixes a bug in ftrace-direct-multi-modify.c where a failed
kthread_run() returns an error pointer that is later passed to kthread_stop=
()
during module unload. It adds proper error handling to unregister the direct
call and propagate the error.

> diff --git a/samples/ftrace/ftrace-direct-multi-modify.c b/samples/ftrace=
/ftrace-direct-multi-modify.c
> --- a/samples/ftrace/ftrace-direct-multi-modify.c
> +++ b/samples/ftrace/ftrace-direct-multi-modify.c
> @@ -364,9 +364,15 @@ static int __init ftrace_direct_multi_init(void)
> =20
>  	ret =3D register_ftrace_direct(&direct, my_tramp);
> =20
> -	if (!ret)
> -		simple_tsk =3D kthread_run(simple_thread, NULL, "event-sample-fn");
> -	return ret;
> +	if (ret)
> +		return ret;
> +	simple_tsk =3D kthread_run(simple_thread, NULL, "event-sample-fn");
> +	if (IS_ERR(simple_tsk)) {
> +		unregister_ftrace_direct(&direct, my_tramp, true);
> +		return PTR_ERR(simple_tsk);
> +	}
> +
> +	return 0;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does=20
samples/ftrace/ftrace-direct-modify.c also need this exact same fix?

Looking at ftrace_direct_init() in samples/ftrace/ftrace-direct-modify.c, it
contains the identical unpatched pattern:

    if (!ret)
        simple_tsk =3D kthread_run(simple_thread, NULL, "event-sample-fn");
    return ret;

If kthread_run() fails under memory pressure, it returns an ERR_PTR. Because
the preceding ret is 0, the initialization function still returns success,
causing the module to load with simple_tsk holding an error pointer.=20

When the module is unloaded, ftrace_direct_exit() will pass this ERR_PTR
directly to kthread_stop(), which can result in an invalid pointer
dereference and oops the kernel.

Should this same error handling update be applied to ftrace-direct-modify.c?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826015050.1077=
2-1-vulab@iscas.ac.cn?part=3D1
