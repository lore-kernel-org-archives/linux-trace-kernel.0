Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FE681A681B;
	Sun, 27 Sep 2026 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790502944; cv=none; b=nKHam2QD3NohJ44JpctWcUJs8WH31dDaIdCLy4IUYWVk1MlOg3Pq7hJuQL2LTJFTaKPDR7JLxTlTXFB3HXJWpMHahJOaCElGL2nbJIRedFlmj80Lw30zP1RrQfSBh5G+Mj0aNkDyGbNKDCsgTFoDzA2zFsXwzW3NcIMBCXlsNGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790502944; c=relaxed/simple;
	bh=j4xLFZmxRtdDRExS+6QQZLH9FfJegXa9OO1j8FgVCl4=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=uhbmMax5jJWgGOFQ75zF+DCHVgul2ylL2ZLcrkKnabD7V8rRNSy7U5VDmb6b3xGvhIm2REin1DCQJxTVM/waVquidK0d4EH8tbriAUP95HJAyWkgJ2mzSPPTZWiucdJaD1FuCVuHdF/ZKQY3sO1LJ5SYkz1TF+IIA68ruiei8oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LlZ7ceB9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LlZ7ceB9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 000721F000FF;
	Sun, 27 Sep 2026 09:55:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790502943;
	bh=Fbrt4JsYtg95Fhr7PV1N68XV16aKV/q+OrPsT/SI2WY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=LlZ7ceB9VJgxelpIblPyuaLWtjx/FSq39J65Z0zeAbTzgjfWdx7OBbQrlu8/AW8Fd
	 8M8UvJUTnX5sJMyNmXkRTtrGLvcwy0WzLnLN+OBkurjM5zSAIynD1b+Ns1gYPxL4Zz
	 HgKn5Q8tnwRylwssAL6tWTWIT6vYGs/w7DRg/+sIwk3ssDDi0mbmAuJX/0GureVImm
	 ijkHuVQXfYSyBda65lXB+JU/v3tZY6pPrXfeqFbO5sl4AajDyDwLfOGrgShA7FSGSK
	 jo1XNYKuwWMnrF/TMgTMX1AdQ2nf1AYOBVyAyyyIW4lV+ON+TJVwzmcNvZp96ivU6W
	 SxXt1Q56J4Psw==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 11:55:39 +0200
Message-Id: <DLQ0BIYP96RN.Z0L5I17RQMRQ@kernel.org>
Subject: Re: [PATCH v2 2/2] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Johan Hovold"
 <johan@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>, "Bradley Morgan"
 <brads@mainlining.org>, "Thierry Reding" <thierry.reding@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-trace-kernel@vger.kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1790495516.git.u.kleine-koenig@baylibre.com>
 <01d7a085e56b860e83b65c96ff3dd86c4498804b.1790495516.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <01d7a085e56b860e83b65c96ff3dd86c4498804b.1790495516.git.u.kleine-koenig@baylibre.com>

On Sun Sep 27, 2026 at 10:03 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
> userspace manually messes with devices and drivers") introduced a taint
> for usage of bind/unbind sysfs files that manually trigger driver probe
> and remove respectively.
>
> For drivers that do their resource management correctly (which is also
> needed for module unloading) bind and unbind for matching devices are
> not critical operations. The thing that makes bind and unbind unsafe is
> that drivers can be forced on devices that originally don't match using
> driver_override. The result is that e.g. of_device_get_match_data()
> returns NULL despite all .of_match_table entries having a non-NULL
> .driver_data member which yields a NULL pointer exception for several
> drivers. And given that after setting a driver_override a manual bind is
> only one way a driver can be bound to an unexpected device, a separate
> taint for such an override is justified.
>
> Reviewed-by: Bradley Morgan <brads@mainlining.org>
> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Suggested-by: Danilo Krummrich <dakr@kernel.org>
Link: https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kernel=
.org/

> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index c51ad96d4de4..7d5dc016a457 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -513,6 +513,7 @@ static ssize_t driver_override_store(struct device *d=
ev,
>  {
>  	int ret;
> =20
> +	add_taint_module(NULL, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>  	ret =3D __device_set_driver_override(dev, buf, count);

There are buses (such as SPI) which unfortunately have to call
__device_set_driver_override() directly.

I think it would be better to move the taint into __device_set_driver_overr=
ide()
and properly document the purpose of __device_set_driver_override().

It only exists as SPI and AP are a bit special; both print "\n" when
driver_override is not set, whereas all other buses (and thus the driver-co=
re)
produce "(null)\n" in this case. I.e. it should never get any new users.

Thanks,
Danilo
