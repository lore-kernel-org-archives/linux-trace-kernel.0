Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02053486BB5;
	Mon, 28 Sep 2026 09:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790587027; cv=none; b=FwixRWZdFEykrndScsSGAGHtO8thzZFMa7JMiglz23Bv8Plasg8ecn+t6uXt0xkf/c+bMpch3UFZdnM3HC01c56P/3KFifD1vx3BklWeizejeCLMXFj321AiZ4ZHVEA+qBmAAJ39StzTcUZFc76OtQvb+NdlXnr2ZxcV/UFObIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790587027; c=relaxed/simple;
	bh=6sO7ds8qyqZ+4iFL0kdD45wG03lUfOoGUafdpTFcbv0=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:Subject:Cc:To:
	 References:In-Reply-To; b=JLAtfSk0CGIFSA4FzDChNraBi47odAHImm2vXiZt9ABdGdE3kMJwZhyJtcFdETskICeXWcXThtKJU/swzR62FYIwCVR5mTkXt0RNhxDsv1JQKKfwI4I1uD/+67uuRcFwL9qlX52pPCGg205Xy69e0cyGbAkQSA7goSsfZg/oDZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YZIrRx9E; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YZIrRx9E"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A66B41F000FF;
	Mon, 28 Sep 2026 09:17:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790587025;
	bh=5AxXAKzYEnGkKqEMYs8hvYzGmCUx6a3DTJTEthvbWfQ=;
	h=Date:From:Subject:Cc:To:References:In-Reply-To;
	b=YZIrRx9E01LMF42A+KE7TLUI0fTDuvZmog8HXm/N41a7DqwmDJ6HFPryoQ7JGCtbG
	 OL/zj3IsFs9CgnbYP2rVIY3NmRhDOq9eap1ovw2u8YRQHra5aqeKNb6Z2boemxbmmC
	 rwGM6rNqK1sVMPCSQQ4KuXYfN2FaVLd3VwqABvzD5SdSmURLSiPhbLhW1a5+JV9FsQ
	 6/l0Z2u3LYy1nwU7hm8qDD7jxmpmx61sDNgZLRXv3FV1w97prrEYDVkZzHqiytWihx
	 URNbpWBFGW2iBKQgN6YckC2Ilt9ur9LJe0zJ54qfKNqde6zWi8VI5Rm2zbw3qsaJfk
	 XGnAHEpQ+duSg==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 11:17:02 +0200
Message-Id: <DLQU4I3AUZXM.2D2AH1859S9EA@kernel.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Johan Hovold"
 <johan@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>, "Bradley Morgan"
 <brads@mainlining.org>, "Thierry Reding" <thierry.reding@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-trace-kernel@vger.kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
References: <cover.1790495516.git.u.kleine-koenig@baylibre.com>
 <01d7a085e56b860e83b65c96ff3dd86c4498804b.1790495516.git.u.kleine-koenig@baylibre.com> <DLQ0BIYP96RN.Z0L5I17RQMRQ@kernel.org> <DLQ0HUM8AV99.3DNY5MRA2AZSO@kernel.org> <aromsiCXLfGRRTFC@monoceros>
In-Reply-To: <aromsiCXLfGRRTFC@monoceros>

On Mon Sep 28, 2026 at 10:50 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
> On Sun, Sep 27, 2026 at 12:03:54PM +0200, Danilo Krummrich wrote:
>> On Sun Sep 27, 2026 at 11:55 AM CEST, Danilo Krummrich wrote:
>> > On Sun Sep 27, 2026 at 10:03 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
>> >> Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
>> >> userspace manually messes with devices and drivers") introduced a tai=
nt
>> >> for usage of bind/unbind sysfs files that manually trigger driver pro=
be
>> >> and remove respectively.
>> >>
>> >> For drivers that do their resource management correctly (which is als=
o
>> >> needed for module unloading) bind and unbind for matching devices are
>> >> not critical operations. The thing that makes bind and unbind unsafe =
is
>> >> that drivers can be forced on devices that originally don't match usi=
ng
>> >> driver_override. The result is that e.g. of_device_get_match_data()
>> >> returns NULL despite all .of_match_table entries having a non-NULL
>> >> .driver_data member which yields a NULL pointer exception for several
>> >> drivers. And given that after setting a driver_override a manual bind=
 is
>> >> only one way a driver can be bound to an unexpected device, a separat=
e
>> >> taint for such an override is justified.
>> >>
>> >> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>> >> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>> >> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>> >
>> > Suggested-by: Danilo Krummrich <dakr@kernel.org>
>> > Link: https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@k=
ernel.org/
>
> I came up with the idea on my own, but ok, will add that reference.

Sure, I didn't mean to suggest you couldn't have arrived at it independentl=
y. I
offered the tag because I'd proposed it in the earlier discussion and you a=
greed
with it there.

>> >> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> >> index c51ad96d4de4..7d5dc016a457 100644
>> >> --- a/drivers/base/bus.c
>> >> +++ b/drivers/base/bus.c
>> >> @@ -513,6 +513,7 @@ static ssize_t driver_override_store(struct devic=
e *dev,
>> >>  {
>> >>  	int ret;
>> >> =20
>> >> +	add_taint_module(NULL, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>> >>  	ret =3D __device_set_driver_override(dev, buf, count);
>> >
>> > There are buses (such as SPI) which unfortunately have to call
>> > __device_set_driver_override() directly.
>> >
>> > I think it would be better to move the taint into __device_set_driver_=
override()
>> > and properly document the purpose of __device_set_driver_override().
>>=20
>> Of course I meant to say to create a new forwarding function for this pu=
rpose,
>> such that we do not taint for device_set_driver_override().
>
> What is the rationale to exclude device_set_driver_override()?

It's used / abused within subsystems to hardwire stuff, which should indeed=
 be
fixed, but also doesn't justify the taint, as it is not userspace controlli=
ng
it.

> For the dynamic spi device creation I like it to trigger the taint.

Oh, there's a new usage in new_device_store() as of v7.3-rc1. I wasn't awar=
e of
this. I'd just make it call the device_set_driver_override_store() function
then, as it is exactly the same class of issue.

> For
> sound/soc/samsung/i2s.c it looks as if device_set_driver_override() is
> just the lazy way to make the created device bind and there is no reason
> to stick to normal binding. And why does it call device_attach()?
> Shouldn't that trigger automatically after platform_device_add()?
> Also in drivers/slimbus/qcom-ngd-ctrl.c the call to
> device_set_driver_override() seems redundant.
>
>> Maybe device_store_driver_override() or device_set_driver_override_store=
()?
>>=20
>> > It only exists as SPI and AP are a bit special; both print "\n" when
>> > driver_override is not set, whereas all other buses (and thus the driv=
er-core)
>> > produce "(null)\n" in this case. I.e. it should never get any new user=
s.
>
> I guess it's API and thus hardly changable, but I like "\n" better, and
> if it's only because "(null)" might be a driver name and there is no way
> to distinguish the situation after
>
> 	echo '(null)' > driver_override
>
> from the normal state.

I would have preferred "\n" too, but I don't want to mess with this uAPI. W=
hen I
implemented the driver_override generalization I looked it up (e.g. in [1])=
 and
tools seem to care about this. driverctl handles both cases, as it is bus
agnostic, but I don't know what else exists.

[1] https://gitlab.com/driverctl/driverctl/-/blob/0.121/driverctl?ref_type=
=3Dtags#L99
