Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC6F3672A8;
	Fri, 25 Sep 2026 18:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790362755; cv=none; b=Dn3KyE1tJ6trHNS5T9LT2netkgCouYx4dMm6wD+mpWUfRU4UZ1GnmAwm2/9bibu9d2zlP3uDyleaNZvsoDpXKXgV/RnqWJs5yXN/flXONqMq+wThT6UJMlO+RamScfp+v2vQvARE/81vKW0xD76BqLUTOqr1HxctZMngCHlSEx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790362755; c=relaxed/simple;
	bh=FJObBgQrI1jG25eBNkDYUO2gHSK2S7pUqLkrPxd++LU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bVEXTTdrbnHLv3W0c8JuB03Rjx0Gjtl4/DRwCA/0BCwV0cFq0Fusz8Y5euwpijzSCu/vSBuBcRej0f8V0+S5xvhdSWR6sRCXPaP+kgCEEsGMBJ4eYeqDaCaaTY3CGCQxKxkUYJm8H1ZZaZfOVdyou0UgJoKEg4u5lHb3JrLSj7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b=SjDFlv4s; arc=none smtp.client-ip=212.227.15.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=w_armin@gmx.de header.b="SjDFlv4s"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1790362750; x=1790967550; i=w_armin@gmx.de;
	bh=XuzGkeBLHs8jweB3nO1FZM4QbU4atwtvCUcrkRM2raw=;
	h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
	 References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding:cc:content-transfer-encoding:
	 content-type:date:from:message-id:mime-version:reply-to:subject:
	 to;
	b=SjDFlv4sEf6lXn2SLtH0UmSRO/WHhx8oTI60xgBq2RUYhK3BsGCq5q5X2kRiZCHc
	 M27bJC7GzPnsGTZvbyE4gPA8JGDXCYbQEkfV9WoFwBkAcJLOyJy108arlVo24N9Tj
	 S2pq2MiyjklxZhSCpJgiUA5MCpd6+afxbxBerhDcX0rr6gSUx9wPJhge24bqPS2cU
	 gDBfR4cbYH9tqTJWvuvN2hppsJEDqjEi/8b3vRnzV7XGv6akRozMKlsmaU1LwRsNc
	 QbAS8DpmRfor51Ir9pIZQ0Y+61ZWohR15NPoUhsPMLunkyT6NQFpAQnWuL0Zpg+Cy
	 xCrnTAso3hCuls4bMA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1M1HZo-1xBq5s2UNG-0049p2; Fri, 25
 Sep 2026 20:59:10 +0200
Message-ID: <3a0eb41b-bddf-4d6c-a61d-73bc545d1a51@gmx.de>
Date: Fri, 25 Sep 2026 20:59:09 +0200
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>,
 Bradley Morgan <brads@mainlining.org>, Danilo Krummrich <dakr@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 David Lechner <dlechner@baylibre.com>, linux-kernel@vger.kernel.org,
 driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org
References: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com>
Content-Language: en-US
From: Armin Wolf <W_Armin@gmx.de>
In-Reply-To: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:cHUiZfCwmtp5RsFc8g0+2Xy3tc2tARrHHSmJQDhF5J7qBO7CmFC
 voeA5ko1aCbvz+9aUdTblYL2ejwxlw/mmrL6raLG7YK9KxJovRrPjG1M0AW4PkLXam48LZ/
 PB4eRWi6uMOZ9lp3gvG50ULU2IIYyeOQqSLvHsIIW25n0S35qCrUZ0bTfe4E1h6yK1Vxt7L
 dY4rL8xhCwkbT1cIdk7GQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OxUFdimwcys=;NADMmxDJq/n69q1dqwrOU1d1+1d
 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
 gO2CZb/nHhYO5gabGRA1XBUZnw==

Am 25.09.26 um 20:20 schrieb Uwe Kleine-K=C3=B6nig:

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
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
> ---
> Hello,
>
> I first considered to just set TAINT_FORCED_BIND when driver_override is
> written to. But IMHO it's very useful to differentiate for reported bugs
> if bind/unbind was used in combination with driver_override or not.
>
> Also if only bind/unbind was used and driver_override not, a resulting
> problem is worth fixing (opposed to what is considered for
> bind+driver_override).
>
> IMHO it would also be fine to drop TAINT_FORCED_BIND, but let time prove
> how many reports we get with TAINT_FORCED_BIND but without
> TAINT_DRIVER_OVERRIDE.
>
> Best regards
> Uwe

Good idea, lets see if TAINT_FORCED_BIND is really necessary after all.

Reviewed-by: Armin Wolf <W_Armin@gmx.de>

>
>   Documentation/admin-guide/tainted-kernels.rst | 6 +++++-
>   drivers/base/bus.c                            | 1 +
>   include/linux/panic.h                         | 3 ++-
>   include/trace/events/module.h                 | 3 ++-
>   kernel/panic.c                                | 3 ++-
>   tools/debugging/kernel-chktaint               | 8 ++++++++
>   6 files changed, 20 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/admin-guide/tainted-kernels.rst b/Documentati=
on/admin-guide/tainted-kernels.rst
> index abbf5e3dd749..75750a9533e9 100644
> --- a/Documentation/admin-guide/tainted-kernels.rst
> +++ b/Documentation/admin-guide/tainted-kernels.rst
> @@ -74,7 +74,7 @@ a particular type of taint. It's best to leave that to=
 the aforementioned
>   script, but if you need something quick you can use this shell command=
 to check
>   which bits are set::
>  =20
> -	$ for i in $(seq 20); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tain=
ted)>>($i-1)&1));done
> +	$ for i in $(seq 21); do echo $(($i-1)) $(($(cat /proc/sys/kernel/tain=
ted)>>($i-1)&1));done
>  =20
>   Table for decoding tainted state
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> @@ -103,6 +103,7 @@ Bit  Log  Number   Reason that got the kernel tainte=
d
>    18  _/N   262144  an in-kernel test has been run
>    19  _/J   524288  userspace used a mutating debug operation in fwctl
>    20  _/Y  1048576  device was manually bound or unbound from a driver
> + 21  _/Z  2097152  a driver was forced on a non-matching device
>   =3D=3D=3D  =3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D  =3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>  =20
>   Note: The character ``_`` is representing a blank in this table to mak=
e reading
> @@ -193,3 +194,6 @@ More detailed explanation for tainting
>  =20
>    20) ``Y`` If userspace wrote to the `bind` or `unbind` sysfs files an=
d
>        successfully bound or removed a device from a driver.
> +
> + 21) ``Z`` If userspace wrote to a `driver_override` sysfs file opening=
 the gate
> +     for unexpected driver binding.
> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
> index c51ad96d4de4..6e91210aab45 100644
> --- a/drivers/base/bus.c
> +++ b/drivers/base/bus.c
> @@ -513,6 +513,7 @@ static ssize_t driver_override_store(struct device *=
dev,
>   {
>   	int ret;
>  =20
> +	add_taint_module(drv->owner, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>   	ret =3D __device_set_driver_override(dev, buf, count);
>   	if (ret)
>   		return ret;
> diff --git a/include/linux/panic.h b/include/linux/panic.h
> index 23976b1dfdb6..e6e24d8afcf7 100644
> --- a/include/linux/panic.h
> +++ b/include/linux/panic.h
> @@ -90,7 +90,8 @@ static inline void set_arch_panic_timeout(int timeout,=
 int arch_default_timeout)
>   #define TAINT_TEST			18
>   #define TAINT_FWCTL			19
>   #define TAINT_FORCED_BIND		20
> -#define TAINT_FLAGS_COUNT		21
> +#define TAINT_DRIVER_OVERRIDE		21
> +#define TAINT_FLAGS_COUNT		22
>   #define TAINT_FLAGS_MAX			((1UL << TAINT_FLAGS_COUNT) - 1)
>  =20
>   struct taint_flag {
> diff --git a/include/trace/events/module.h b/include/trace/events/module=
.h
> index 19df3e39bba4..c7cdb1f53bc6 100644
> --- a/include/trace/events/module.h
> +++ b/include/trace/events/module.h
> @@ -27,7 +27,8 @@ struct module;
>   	{ (1UL << TAINT_FORCED_MODULE),		"F" },		\
>   	{ (1UL << TAINT_CRAP),			"C" },		\
>   	{ (1UL << TAINT_UNSIGNED_MODULE),	"E" },		\
> -	{ (1UL << TAINT_FORCED_BIND),		"Y" })
> +	{ (1UL << TAINT_FORCED_BIND),		"Y" },		\
> +	{ (1UL << TAINT_DRIVER_OVERRIDE),	"Z" })
>  =20
>   TRACE_EVENT(module_load,
>  =20
> diff --git a/kernel/panic.c b/kernel/panic.c
> index b824b68fcb08..f5476a61f6f3 100644
> --- a/kernel/panic.c
> +++ b/kernel/panic.c
> @@ -826,6 +826,7 @@ const struct taint_flag taint_flags[TAINT_FLAGS_COUN=
T] =3D {
>   	TAINT_FLAG(TEST,			'N', ' '),
>   	TAINT_FLAG(FWCTL,			'J', ' '),
>   	TAINT_FLAG(FORCED_BIND,			'Y', ' '),
> +	TAINT_FLAG(DRIVER_OVERRIDE,		'Z', ' '),
>   };
>  =20
>   #undef TAINT_FLAG
> @@ -862,7 +863,7 @@ static void print_tainted_seq(struct seq_buf *s, boo=
l verbose)
>    * exact size is allocated dynamically; the initial buffer remains
>    * as a fallback if allocation fails.
>    *
> - * The verbose taint string currently requires up to 344 characters.
> + * The verbose taint string currently requires up to 364 characters.
>    */
>   #define INIT_TAINT_BUF_MAX 370
>  =20
> diff --git a/tools/debugging/kernel-chktaint b/tools/debugging/kernel-ch=
ktaint
> index d8628be37214..14d8febd6b16 100755
> --- a/tools/debugging/kernel-chktaint
> +++ b/tools/debugging/kernel-chktaint
> @@ -219,6 +219,14 @@ else
>   	addout "Y"
>   	echo " * device was manually bound or unbound from a driver (#20)"
>   fi
> +
> +T=3D`expr $T / 2`
> +if [ `expr $T % 2` -eq 0 ]; then
> +	addout " "
> +else
> +	addout "Z"
> +	echo " * a driver was forced on a non-matching device (#21)"
> +fi
>   echo "Raw taint value as int/string: $taint/'$out'"
>  =20
>   # report on any tainted loadable modules
