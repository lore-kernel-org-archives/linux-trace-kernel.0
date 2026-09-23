Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com [74.125.225.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD62443E44
	for <linux-trace-kernel@vger.kernel.org>; Wed, 23 Sep 2026 06:29:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790144961; cv=none; b=p+fQ+/Q96WQjtvcUoIsZ9SVN0nvqDPKpxDdB/5Hl5iTjZUlXvxSKSzyfYKkfsML1vjKpfETQW12M0wtXRGVQcsJQ8EnKWjzgsp8VwjNGaI9SzzlmXR6uTMsMB8zbBhfDU5oimMJ/Gi+M/aiheCG4tCrDCyFRDVm53Prc+TDYVJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790144961; c=relaxed/simple;
	bh=2P1/Y+7yd2b38wkBtdBMXr+oehxAhkxnhsbRjMjb8Ls=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p1Tm0kJMSy/km+WLeuXdqOfgnE6UlR0XqHPCdLxxiS2K0NF19J7aqrB3xA2cvIHPBtfisbuYg9ydIQ0fsQf+q/v2j6Radu+GjH2IbL3tV30QxZYv0dQmVvjRz4HtCnB1M0IbBsarLOVlDG+mQbqV75JiCNL//0IFP8Lru+Sxjtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=l6od56IM; arc=none smtp.client-ip=74.125.225.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="l6od56IM"
Received: by mail-wr2-f12.google.com with SMTP id ffacd0b85a97d-4834977ae75so413105f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Tue, 22 Sep 2026 23:29:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790144951; x=1790749751; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IqBBUCm9D3kcAtSAGWx9YPoXXMR7IIvhwpg10TQoYm0=;
        b=l6od56IMX74BNqnz4bkTqVsvT7TD24l1V6scX5Gxcm2Ba0nNYt0lyH968epWiozZQX
         EsQfZEgGNgKa0yumSDHHGtbh8TtcstcLd5rpQkOdGDWJkWOyuZIcy/H2MCD6N2ngdeDZ
         D/PhGynIR4UpFG+LQ8pifR7209dFV43U2wYIe/4iRiwA8zT6D4Co7F7cvdCcrzLoKfag
         qM2CyIdWDF8xgmhzsXgYmW7faTWr8aoPqrM309n+jxkHx9OSAiKmmHs3cDYNYM2Ch4GP
         68kPpsY7cGyX8SGtVyBqRGxz/405HuON/8+PfuCz7oz61mKOwSo9+KhIQPNeHvN8q9n3
         RUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790144951; x=1790749751;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IqBBUCm9D3kcAtSAGWx9YPoXXMR7IIvhwpg10TQoYm0=;
        b=SKtIeNbaf1/U7tgJkeo+sTudcc2iHspdxZZg99aZqrsc591R2OOOgUQEKE0pvv8MT3
         fCJyEoKErm1O9nQJfOIChBfZzOnKrn7XGIpCy36jbuHQi6QV5znsXg548mStuGJj0Evh
         JJavHTUM75ESO7kEX/C2+QOARlW8jcWmIJSyrv+ysSPew3EsiGIJctKaJAzLBtkLpCRy
         rSozup6HuXwDFhPaf3ws7japMxEh5SDC5PX3LBrYus+VufQgeUDFuHPiiYupCrpKhNdN
         qtQ7Gew9RC/X1qt2rS7HzMocna7lkAXbg8ZQyd/c5r0LZllxvQwr8zVwnKFwYUfDAeR4
         zFmA==
X-Forwarded-Encrypted: i=1; AKwUvBypqCaO31W5EjQODMCJPi0xQZiXOEkZolKfLVk48CJNxGTkj/LOQuoux66EDfciEXAVCKhwI8vxlqwGYL8u65uVdHs=@vger.kernel.org
X-Gm-Message-State: AFuF++nloQIGcRIj8RuRYEHIinX2xPDCdw3EHQk3OOaVpXj5PQUgwqaU
	oFiMqf867j9F8BIS4YNhW1tvbHlUCJowFYYCx8ZBiWZHS0jYDp41x8CKQ+Kbo6Acb4I=
X-Gm-Gg: AYBFou30AyfWbIqPPUGY6de4314ikq5BP4oiCjyyNXk0RywcQjn8o/KsdfrvKUD0WN9
	oUYUxi3qyKQCEngR6z64GV6i0dGL1DmjwPBriAd7MUU04ZLGSxuPcJW5KvSr96+oei7X3X/5hR5
	8GTbw/X9VWxnyCOOLDvYPBKFSCLM2Hl/wGDoyczAXNs1R/i6Ytej7jObdcHhBuf03hrExB+LEQc
	AxyffRIg1apA7ACEs1S+7aTMbe7FoURuVs5+RAKzR6OjAgH2M4xKpkI5jNv3nWCOXcfAFpV8X6D
	euAFW477d1BxbNKsUJrqXdC5r9Co5sZclNqcK4i1GurGp0h9zqLadHyOroinwk50CwZoCp4+RLU
	/g9sj9BxrMjRxvDVLvcc9cOB77MuiFYeTf9ixL6h25vB9hDrFOzkLgIJ/jr+14sa163v9d2qSez
	S/udWF0IG6ODTo2xJ0PVXPGwWDtXiURegL4zZn3VS0JspciyLrZyHXfiwjlmjxBSbf2VV1cuCaw
	8oeqkrqbHbx/4g=
X-Received: by 2002:a05:6000:40dd:b0:487:27f6:a4db with SMTP id ffacd0b85a97d-48867092e81mr2065474f8f.43.1790144951218;
        Tue, 22 Sep 2026 23:29:11 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-4886876c1fdsm4980428f8f.14.2026.09.22.23.29.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 23:29:09 -0700 (PDT)
Date: Wed, 23 Sep 2026 08:29:08 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Armin Wolf <W_Armin@gmx.de>
Cc: David Lechner <dlechner@baylibre.com>, 
	Danilo Krummrich <dakr@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <arNuIicuNMmA7E3K@monoceros>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="m4tmncbnbg4g756x"
Content-Disposition: inline
In-Reply-To: <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>


--m4tmncbnbg4g756x
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
MIME-Version: 1.0

On Tue, Sep 22, 2026 at 11:04:46PM +0200, Armin Wolf wrote:
> Am 22.09.26 um 15:40 schrieb David Lechner:
>=20
> > On 9/22/26 2:39 AM, Uwe Kleine-K=F6nig wrote:
> > > On Fri, Sep 18, 2026 at 06:39:02PM +0200, Danilo Krummrich wrote:
> > > > On Mon Sep 14, 2026 at 4:30 PM CEST, Greg Kroah-Hartman wrote:
> > > > > The ability to add and remove devices from a driver through the s=
ysfs
> > > > > "bind" and "unbind" files was created all those decades ago as a =
way
> > > > > that kernel developers can iterate faster, and provide a debuggin=
g way
> > > > > for users to attempt to add a new device to a driver without havi=
ng to
> > > > > rebuild their kernel.
> > > > >=20
> > > > > This api over the years has been abused and recently come under a=
 major
> > > > > fuzzing "attack" through tools like syzbot which decided that it =
would
> > > > > attempt to just randomly bind any driver to any type of device, c=
ausing
> > > > > loads of unneeded errors and pointless kernel patches to be gener=
ated by
> > > > > unsuspecting new developers.
> > > > >=20
> > > > > Handle all of this by adding a new taint flag, TAINT_FORCED_BIND,=
 which
> > > > > will be set on the driver if the bind/unbind sysfs files are ever
> > > > > written to.  This lets kernel developers "know" that a user is
> > > > > attempting to do something that is not normal, and as such, if the
> > > > > kernel breaks they get to keep the shiny pieces laying around on =
the
> > > > > floor.
> > > > >=20
> > > > > The flag is 'Y' which was unused, and can remembered as the user =
is
> > > > > "yeeting" the device being operated on here (thrown with force wi=
thout
> > > > > regard for the thing being thrown).
> > > > >=20
> > > > > Note, the taint flag gets set _BEFORE_ the bind/unbind callback h=
appens,
> > > > > as many times crashes/oops/warnings/failures happen within the ca=
llback,
> > > > > and the taint flag needs to be there to show what was being attem=
pted.
> > > > > If it were to be set after the callback happens, the oops report =
would
> > > > > not properly reflect what foolishness was being attempted.
> > > > >=20
> > > > > Fuzzing tools like syzbot, that doesn't have hand-crafted rules t=
o keep
> > > > > the tool from hitting bind/unbind, should be run with panic_on_ta=
int
> > > > > enabled so that they fall over and don't continue on, thinking th=
at they
> > > > > actually found a real issue.
> > > > >=20
> > > > > Userspace operations that rely on the bind/unbind files
> > > > I agree that this should be avoided.
> > > >=20
> > > > But I also think the biggest offender really is driver_override. Sp=
ecifically,
> > > > on a hot-pluggable bus a driver must be complient with the device d=
river
> > > > lifecycle rules and hence shouldn't break on bind/unbind. I think i=
t would be
> > > > nice to not taint the kernel for such busses, and only taint on dri=
ver_override,
> > > > as I think we'd still want the bug reports for such cases.
> > > >=20
> > > > But I think this is fine to leave for a follow-up.
> > > I fully agree. I'm fine and support tainting on driver_override, but
> > > bind/unbind are used occasionally in my bubble and I consider drivers
> > > not handling that properly buggy.
>=20
> I fully agree with this, drivers should correctly implement the lifecycle=
 model
> and not just break when being unbound at a improper time. Drivers sufferi=
ng from
> this can easily break this way when unloading the associated kernel modul=
e, so this
> taint is no solution.
>=20
> > In the IIO subsystem, unbind/rebind is the de-facto way to reset a wedg=
ed
> > chip.
> >=20
> > A few examples where other reset methods were reject in favor of unbind=
/bind:
> >=20
> > https://lore.kernel.org/linux-iio/20240727160216.2488ed29@jic23-huawei/
> >=20
> > 	This needs documenting as it's custom ABI. Note that we don't often
> > 	accept custom ABI. Particularly not a hook that seems to reset the
> > 	device. If you want to do that, unbind and rebind the whole drive[r]
> > 	so we are in a known state etc.
> >=20
> > https://lore.kernel.org/linux-iio/20240720163440.03c713dc@jic23-huawei/
> >=20
> > 	Firstly as stated below, we don't provide interfaces for this
> > 	because it's a heavy weight process that is most of the effort of
> > 	unbinding and rebinding the driver. So if you need to reset, do that.
> >=20
> > https://lore.kernel.org/linux-iio/20250505200609.54756520@jic23-huawei/
> >=20
> > 	The solution is to run it once at driver bind. Similar to reset
> > 	below, if the usecase needs to re do it then unbinding and rebinding
> > 	the driver reflects the fact we are taking it effectively offline
> > 	for a while.
> >=20
> I also consider bind/unbind to be an official API to interact with device=
s,
> so i want to use them in the future with the WMI subsystem.
>=20
> AFAIK the underlying reason for this series is that some drivers break wh=
en
> being bound to unsupported devices. However IMHO drivers should verify th=
at
> they support a given device inside their .probe callback, and the associa=
ted
> bus should only match devices with drivers that explicitly claim support =
for
> those devices (ignoring driver_override).
>=20
> Can we get some example bugs uncovered this way?

There is a related set of mail threads, that however are not the trigger
for Greg's effort.=20

Initially I suggested to protect the pwm-tegra driver from attaching
to unexpected devices via a check in .probe():

   https://lore.kernel.org/linux-pwm/ed943d9be3b785514e0f65a5b8c13a78aba7a0=
90.1789741839.git.u.kleine-koenig@baylibre.com/

Thierry suggested a dedicated flag in struct device_driver instead
allowing to opt out of the driver_override mechanism:

   https://lore.kernel.org/linux-pwm/20260922-driver-override-opt-out-v1-0-=
58c35ded3b83@nvidia.com/

I think Greg was motivated by syzcaller triggering various exceptions
using driver_override.

So my opinion on the right way forward is:

 - Given that there are only very few drivers that are supposed to be
   used for a driver override, there should be an opt-in (instead of the
   opt-out that Thierry suggested).

 - The changes from this thread (i.e. make usage of bind/unbind result
   in a taint) should be dropped. I wrote earlier that I'm ok with a
   taint for a usage of driver_override, but with the previous item
   implemented, I don't think that is necessary.

Best regards
Uwe

--m4tmncbnbg4g756x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmqzcbIACgkQj4D7WH0S
/k5/RAf/SE7NQiSIqLNn4DRqC5N/7ANJOhVQL7lvqZeGImpxnvizJPahFAQ5wgHr
TqvOjwfgQW2cjqr0dT1HbkBIxqhE/FQQPy/wGiSAEwVqGPoaf3NQ2+EJhFtbkW3A
UhHydl1NRAl0lJI3aDHu8yvr2fYi1JsjVoGk6bEHLa8H3g4mxV09GAmn5486tQ6N
WbofIbgRNtpIYlMN9eWRKKBBB8j/EQvMHXZwBIy05z/jru237w9UWObXjS/FhwD6
ktITAnnTBacmzUAC1u5hm2Z3lpH88/MCe014xcIal73LJ1HgVnwnjH7uaBmRrzsR
r/G6IKsL4nPw3DX9iCQvpNDM+a44MQ==
=ea/U
-----END PGP SIGNATURE-----

--m4tmncbnbg4g756x--
