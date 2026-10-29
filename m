Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793304161;
	b=w7mrAcKdojTU2Fbpy3emqKw7HusYQvqn09hhv7fB5hCfXIQ/tDvfJagIOOwBRSVe9Lm8
	 RiGhw1OVxxjTz0L4YOQZH0cpLG+aQHwhR36JyzKxT74YSafOtnymVaC5ZJFoFCNfqXAET
	 b/YEElG2E9d15G70ICcaAAYmoLyXD1qQeIWz7VJ6mc049FAQpLv7SoFbjAy+lf1Jm3Bmp
	 VuTxh0m9B+UxoFURoQT+hztg657TysV9OWc18O0tyjxkygK3IzkmT25F1dJTQBkWekbtc
	 hbM0mw24s/hddPlk13l2RoCMbfYMMO501P6LQfyso+TfrKcQnPngH9SGpqG3KcfwFuA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793304161;
	h=Received:DKIM-Signature:Mime-Version:Content-Transfer-Encoding:
	 Content-Type:Date:Message-Id:Subject:Cc:To:From:References:
	 In-Reply-To;
	bh=sKNMeJWdw2qagHs6y8oduiUWcmWQ/SIjrS624SwpqjQ=;
	b=DJnxi9tNUR8qWf3VfwP39tjSOOJ+7/AquKrvGP3qpnu7FS5nNuGAFUR46DP3GYWFMD7v
	 89VxU8zrGBtBelASq5Pk/v4OYrlgjEkTo3ES/Q1tVYo1g1BVP/DaArLyOzixCjjBka07f
	 XO+LVD7A5s0WI3v53g7oJyvAm/Wqu0MlKHXPjzE4mf7SjiF1gyuJz6jII+G1BZLRMnLFl
	 qKiXJzb2iklnR7ac2mhuX3s6qf1wV6JdzMML0UFr6Deqi/SfiVnKWKTrvHeN4E1o/Xg/y
	 0oVya+puNG/2+VjA8JA+oTnXU4xEppDRfJsrCkIROxf66+86DFpscMZZznlEbgRmWMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsRLMB5w;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF23C606A31E;
	Thu, 29 Oct 2026 20:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VsRLMB5w
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D8AA1F01816;
	Thu, 29 Oct 2026 20:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793304160;
	bh=sKNMeJWdw2qagHs6y8oduiUWcmWQ/SIjrS624SwpqjQ=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=VsRLMB5wvmZYa+5VNdtdt+d05/kWfB9RwrXAhoAASmnRrLoDhtfafjKrhjR6aF4MZ
	 DMlUJEviyghOn0RSav1Wk0JntdDXrgd6hVZD7v45sWPP0fm7FttULmD9zfKUkbomST
	 LeVc1foCRZd5gDUSv2dam9HGCFehyhvlCMFHzC3PYu34YHtk8ALyoWxWhtom5O3Ss6
	 xiZLCKztM+CyEfqBsGF1SNsRQOBmbqgHfU6l2/vARyVKcw1IadeORxcjWIOr46UdrC
	 OaqcDOYdr8VhKSF2XHBbeUtyeuCkZwQqyCVe3CANLstWqE7qCXPYVf5mPzEcpj0hNu
	 6YUuMAkAHMUPw==
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 29 Oct 2026 21:02:35 +0100
Message-Id: <DMHL9O0EWLKU.3F47YHYEGNURK@kernel.org>
Subject: Re: [PATCH] Revert "driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers"
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Jonathan Corbet"
 <corbet@lwn.net>, "Shuah Khan" <skhan@linuxfoundation.org>, "Randy Dunlap"
 <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, "Johan
 Hovold" <johan@kernel.org>, "Steven Rostedt" <rostedt@goodmis.org>, "Masami
 Hiramatsu" <mhiramat@kernel.org>, "Mathieu Desnoyers"
 <mathieu.desnoyers@efficios.com>, <linux-doc@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-trace-kernel@vger.kernel.org>, "Leon Romanovsky" <leon@kernel.org>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, "Michal Pecio" <michal.pecio@gmail.com>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <20261028-bind_taint-revert-v1-1-7c6b9cef30c9@linuxfoundation.org> <auODHyLrfQylISX2@monoceros>
In-Reply-To: <auODHyLrfQylISX2@monoceros>

On Thu Oct 29, 2026 at 6:39 PM CET, Uwe Kleine-K=C3=B6nig wrote:
> It's not part of commit fcbfaffee51a452cc8efcbaa3b88ec4595678424, but
> conceptually we need=20
>
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentatio=
n/admin-guide/tainted-kernels.rst
> index 3d312bc17942..fcb8b9734548 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to =
the aforementioned
>  script, but if you need something quick you can use this shell command t=
o check
>  which bits are set::
> =20
> -	$ for i in $(seq 0 20); do echo $i $(($(cat /proc/sys/kernel/tainted)>>=
$i&1));done
> +	$ for i in $(seq 0 19); do echo $i $(($(cat /proc/sys/kernel/tainted)>>=
$i&1));done
> =20
>  Table for decoding tainted state
>  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> in this change which was fixed in commit f1850e443b0e ("docs:
> admin-guide: Handle TAINT_FORCED_BIND when parsing
> /proc/sys/kernel/tainted"), but that commit shouldn't be reverted as it
> contains a simplification that we should keep.

Fixed it up, thanks!
