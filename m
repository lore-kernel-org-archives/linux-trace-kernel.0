Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40F329D26E;
	Sun, 27 Sep 2026 10:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790503440; cv=none; b=tBOjk05xTQb+DsoCU2mA7/bOlSmBXMKi8GTh2rrtZ9UvP04qxe1d8IGZitCSISzcJrkZms5JyiFHPm/aGatKz58FJiSDg3xRsE+DtKT0n4bT3LeE5KyCPPLrNwRqKmRIqCU4tUnOWyLd67sRDEFbK88uWZFntv17FidjrqO8DSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790503440; c=relaxed/simple;
	bh=4KGLi4gSyELeGxSkDuzjSrP89T8TGx3u4g3+Iu7u2Bg=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=h40NlHyVytuHdDokGcVbGzOCHzSAQLU4TXBMh4HSbdqk+bYdeVZZ3pGOIIYoBP/q5s9yZJ22UsGkHhNDydG2909u0aB5/tfWypp158wGjbqC2CSDfC2pqnXfBkOOHSPbaGlaF+O3wW9bKCApmoYsaj5KcozRQ606dLGAPDrt1ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fwYAqKWa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fwYAqKWa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50D4A1F000FF;
	Sun, 27 Sep 2026 10:03:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790503438;
	bh=vSAEpTH9DBndtzCbmrq/IUQLiscwjOxqMlpY9CqtZVo=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=fwYAqKWazJD73aQHbtuhcIxGbu9/F3SSGHR7G/Bv/Vlrs7CZ/5TT6xEBfQL9AOzzr
	 WPzYqW+TILeSfO6ZU1nLjjClxds6MoIxmUiaiM8wvoCi3FcQ3/JeiL6F2tgka42lBA
	 g3KfjQ2LIpXzkHwFKulXWT6KkuXfkyhFaJAuAZIJ1Lv4d3ymYkkGMCqrtTVJvFg3iG
	 SJBgFMc0OpZsWFS58yJFAgZM0idNpggMJDn4KObNgzD+L9XsyTxTuRiymSnXQh/xKa
	 1AdoxiPuKIjply4THmitca8YoOPiL6QwQeVhs+S6XjVuO9a9JTMoGwmxFS+T2WTA5x
	 Wsb2NeSHC6Tsw==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 12:03:54 +0200
Message-Id: <DLQ0HUM8AV99.3DNY5MRA2AZSO@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Johan Hovold"
 <johan@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>, "Bradley Morgan"
 <brads@mainlining.org>, "Thierry Reding" <thierry.reding@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-trace-kernel@vger.kernel.org>
References: <cover.1790495516.git.u.kleine-koenig@baylibre.com>
 <01d7a085e56b860e83b65c96ff3dd86c4498804b.1790495516.git.u.kleine-koenig@baylibre.com> <DLQ0BIYP96RN.Z0L5I17RQMRQ@kernel.org>
In-Reply-To: <DLQ0BIYP96RN.Z0L5I17RQMRQ@kernel.org>

On Sun Sep 27, 2026 at 11:55 AM CEST, Danilo Krummrich wrote:
> On Sun Sep 27, 2026 at 10:03 AM CEST, Uwe Kleine-K=C3=B6nig wrote:
>> Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
>> userspace manually messes with devices and drivers") introduced a taint
>> for usage of bind/unbind sysfs files that manually trigger driver probe
>> and remove respectively.
>>
>> For drivers that do their resource management correctly (which is also
>> needed for module unloading) bind and unbind for matching devices are
>> not critical operations. The thing that makes bind and unbind unsafe is
>> that drivers can be forced on devices that originally don't match using
>> driver_override. The result is that e.g. of_device_get_match_data()
>> returns NULL despite all .of_match_table entries having a non-NULL
>> .driver_data member which yields a NULL pointer exception for several
>> drivers. And given that after setting a driver_override a manual bind is
>> only one way a driver can be bound to an unexpected device, a separate
>> taint for such an override is justified.
>>
>> Reviewed-by: Bradley Morgan <brads@mainlining.org>
>> Reviewed-by: Armin Wolf <W_Armin@gmx.de>
>> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>
>
> Suggested-by: Danilo Krummrich <dakr@kernel.org>
> Link: https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kern=
el.org/
>
>> diff --git a/drivers/base/bus.c b/drivers/base/bus.c
>> index c51ad96d4de4..7d5dc016a457 100644
>> --- a/drivers/base/bus.c
>> +++ b/drivers/base/bus.c
>> @@ -513,6 +513,7 @@ static ssize_t driver_override_store(struct device *=
dev,
>>  {
>>  	int ret;
>> =20
>> +	add_taint_module(NULL, TAINT_DRIVER_OVERRIDE, LOCKDEP_STILL_OK);
>>  	ret =3D __device_set_driver_override(dev, buf, count);
>
> There are buses (such as SPI) which unfortunately have to call
> __device_set_driver_override() directly.
>
> I think it would be better to move the taint into __device_set_driver_ove=
rride()
> and properly document the purpose of __device_set_driver_override().

Of course I meant to say to create a new forwarding function for this purpo=
se,
such that we do not taint for device_set_driver_override().

Maybe device_store_driver_override() or device_set_driver_override_store()?

> It only exists as SPI and AP are a bit special; both print "\n" when
> driver_override is not set, whereas all other buses (and thus the driver-=
core)
> produce "(null)\n" in this case. I.e. it should never get any new users.
>
> Thanks,
> Danilo

