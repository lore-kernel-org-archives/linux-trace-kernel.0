Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.42
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792827178;
	b=qdESIl3UoFC3EIl0RyzjZ7FgXE0rbiXvwe6CVbqduhq5iiGLpu5iahxl/UX0M7P4Ctjo
	 nMeoeyOuel+zulH9WzDmrKPr8cW5nmj4eqhjXEP5uggH9AEDCGqMo9VKs+YCNieoSqhxO
	 SlCSCo9ydbqpenxfjPhMXWlSi3o09PwrElxgKvUH0KNuNr0O0oSVt3jlCRXaODq9hMQIj
	 YcsLBvCgNyanz5rmHw4tCuVqmMx9w3WjsKM2iNjnhbYZ6JfwhURrOHrCNDQTuRljk3+FA
	 aIKhpM4VzGgnU7Y1JW7X2q6KOa1M7HAB6L5KMZnK135eEdIFarnOiDx/Dv0TAU38dcg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792827178;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=li2QB09lPsjXluSnSfXMvObkOrNnmZZOmi28fPXekeo=;
	b=r0f8ParIqjaxHW1nqUP+7BLBsqOUey8bdkyYWJW1AKKbRS94S6gALDjNwUjg8qIaCSIa
	 48SO4tHUQTY+Y4vjojW31+Oa5dFRb1Q+YTtVhAhUeLhpOtragYgEi/DB8jeiUNVDBY+UH
	 LPTGjzFn+31hvpgZmHxOnsr/ebE15TDtomzQdxie8QOoy6EU5GDlH+DaRWO3/n08WWJ7A
	 jsxfWmlQSW3ueXLM/Iuyh3mtls86c9+FRFNHZn1ZhH0F3Zl0e4D4fBFt2CaVfB4e3v5Lz
	 SDHHfpE//75xDhlj3lTfowmSNMQpcP94os+iHyaWvA3dqcs1kmywXSszatNT2dOupLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	arc=none smtp.remote-ip=209.85.221.42
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359DA606A31B
	for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 07:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 359DA606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4d870d54so954089f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Sat, 24 Oct 2026 00:32:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1792827174; x=1793431974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=li2QB09lPsjXluSnSfXMvObkOrNnmZZOmi28fPXekeo=;
        b=bIDYtbOnPGADlrjGilR6HlFVpF/eIp31wIxr3wVKS/McxWVagsZZJcNMwIGOaDkaGh
         jPydXHn40ca3LBrlABACC/cWWoUxiiNQ6K37TuAZ9OwdOWByTtGVMcTPttbPs/rrEPpo
         lJ60v1+90zWJIUQbjPMADewT4OKMmnJWfpxYytolFHNH7DWkKldRUsZyWrhDofT7/PhB
         hnOIsKB4wTNr035cZj+SICgnq++LdGkxL98N7LJaydych2gY8QLXItAv1k93WeYHehTv
         Ds3pnjJrMgM8GsA9BuPW6XaI9nQwpsSBGPGmFcNOQnnUl7tbCIZ3e6bA8AfUd7KMXs7D
         IkNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792827174; x=1793431974;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=li2QB09lPsjXluSnSfXMvObkOrNnmZZOmi28fPXekeo=;
        b=Olx9Ji84Ex4qzv+tN1PJwwNGL1RcYrTMIH3KK704+ofFuZ+pzaEpVEdhFE67yqbeZp
         CnCssBaJb0PANA5+kNOrP42HIyM564avgTP54t3fqxy1EbXlej/5cUZoBduLwMhTE/Q1
         QX6gaVamBS9RuA9mlLtPrb3va4Vd2G4OQTMy6YyP6kp5W6XIKemcAfUVKFmH4/ewKZFj
         nNR6Nr/wseklLppzxDQ3t4enBJjFF/gDmdGV+o7wDu6oiUtqJS6BF469RqR95lo/w3SI
         K1w7qZ2PxO8QvB/oSXrkuQy54/qj4Dfzi30heVZB2dLBNfCJ5UbfKaQF92fgtJG7PaY0
         LSJQ==
X-Forwarded-Encrypted: i=1; AKwUvBx5Ws3DghSFKn2ygzi1HB49URIn6eFiPJ0Pa/e/oUXXYSPafR1LLERnTkjT3+fye6gchiSv6OB5DKtwF4uiqG+7dtM=@vger.kernel.org
X-Gm-Message-State: AFq9FYKEnqu/B2fTyj84vmeYV7aKkUG/LD4r4JpNZiJE+9wjz0EtxPge
	pb3atr5UW+3y7P6dzQQ37iwqw2O8lL0ZTANxAr2vJs0r1W4DAERtimzvBxeySfqSFaM=
X-Gm-Gg: AYBFou28OHdqNxtIJWix2D2pVPd0U83SX7PkU4BWm/5FHfO9Ad20EprrIRlFp0gO2NA
	JDUBBS77BH6/3O0NJmOgQmBj9WhpkYn1AYIjtNHTVEauRc1b2aAjxQ3vEaPKZ3QK5Oc/zN2mdO3
	bGrZ/dmdp+UnRlENa8TDc9OpAUdTo/s1l+k2wa8LNl6CbSHx7LAC8ek99EvHM0Q065YuczO9/sp
	N9MDaL80SJXIQGyXERpZlHGKPDpLrS5PARnY3FW5ha34iLiHnxK+Tl+LbDewX6wnzTGtckaY4Tc
	a0COf2DGFaWw72Om0mQ0aW7NcxOqr0zUPOlQeXydBYQHJccOeeixyZquPhdq4n3X9tWR5BlrFIj
	nQgQEyLk1NjBuycVOxM9tilC5Ua2llttB86lNbj3NcDRkMXBOPdM3/LNN8Jt9avTz/K1RNYG0Qj
	uhqWtaV0ZB2kbhUVBCfiQ7XR1Dm5Ul17hpFEVbx+SsFYrJa3i6u5wI3QXvEnvVOFRfmI0oUGsUR
	PRzuexNF/Tu/7SGOEUAtp2r2yJ9aRVx1RvQJViG12GsuDHAbQlzVqdNqTBuyd9Gb8tDvkdI6J2A
	hldCF7TsPGLjEf40UENDnf17gjO6FjGDP0w=
X-Received: by 2002:a05:6000:40e1:b0:48e:932:aefa with SMTP id ffacd0b85a97d-48e3eb9263fmr1987532f8f.26.1792827174053;
        Sat, 24 Oct 2026 00:32:54 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ecd35c2sm2752126f8f.39.2026.10.24.00.32.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 00:32:53 -0700 (PDT)
Date: Sat, 24 Oct 2026 09:32:51 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alex Williamson <alex@shazbot.org>, Armin Wolf <W_Armin@gmx.de>, 
	David Lechner <dlechner@baylibre.com>, Danilo Krummrich <dakr@kernel.org>, 
	Luis Chamberlain <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, 
	Daniel Gomez <da.gomez@kernel.org>, Sami Tolvanen <samitolvanen@google.com>, 
	Aaron Tomlin <atomlin@atomlin.com>, Jonathan Corbet <corbet@lwn.net>, 
	Shuah Khan <skhan@linuxfoundation.org>, Randy Dunlap <rdunlap@infradead.org>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Bradley Morgan <brads@mainlining.org>, Aleksandr Nogikh <nogikh@google.com>, 
	linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-usb@vger.kernel.org, driver-core@lists.linux.dev, linux-trace-kernel@vger.kernel.org, 
	Johan Hovold <johan@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Thierry Reding <thierry.reding@kernel.org>, Jason Gunthorpe <jgg@ziepe.ca>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <atxdQ4vfh-b6GD0B@monoceros>
References: <20260914-bind_taint-v4-0-eadf8a090903@linuxfoundation.org>
 <DLIL9H50MALI.3JROXYEEUM3KU@kernel.org>
 <arIvG0nx4LXG9nlW@monoceros>
 <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="snd5d5o342ief275"
Content-Disposition: inline
In-Reply-To: <2026102437-vista-unsoiled-b089@gregkh>


--snd5d5o342ief275
Content-Type: text/plain; protected-headers=v1; charset=us-ascii
Content-Disposition: inline
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
MIME-Version: 1.0

Hello Greg,

On Sat, Oct 24, 2026 at 06:56:34AM +0200, Greg Kroah-Hartman wrote:
> We have real problems with random "bind/unbind" attempts that this taint
> is here to help resolve as it was creating hundreds of false-positive
> bug reports on developers all across the tree now that the fuzzers
> decided to think this was a valid action to take.  Without this taint,
> people were being forced to add hacks to all drivers for this which is
> not an acceptable solution.

Why is it false positive? IMHO unless it involves a driver_override it
is a bug to fix. So have you considered tainting on driver_override
instead of bind/unbind? You did, I'm sure because several peoplel voiced
that approach already, but unless I missed something, you didn't share
your thoughts about it yet.

https://lore.kernel.org/all/cover.1790612298.git.u.kleine-koenig@baylibre.com/
would be a suitable thread to share your opinion.

Best regards
Uwe

--snd5d5o342ief275
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmrcXyAACgkQj4D7WH0S
/k6DIAf8DAU1k1OUjt0oOb7bxXYD1+h/zw0y3dtkGS8G+zRTS/qzzPPjfmqRP0h9
J5L7m6Y88ojmkEkaTuZykFHJjTD0oRB1HPOJTgCW6xGNMm2ZWeh0nTUKgD9H5GY7
w2HgqDafsFSbrwjrivGi8AGwp3WErwD0r+kOCr0MrPDA9d4RxztnKRXgDPP79VFz
52dVyEVot3hTvhqxMfO0yLVcwGhQaO5VnfAGO3zqb7oOJoL3MzMUVk3Qo8NuSz6R
zP04L1Pg9uTjUgCUKeKGGkzd/2+nMfGXjUGnId1rwsRI7WfBXP4t0r6JIOZsSNIY
RuU/lvGyyvYfTEwZjc1S5kWfcRrIdw==
=5xdK
-----END PGP SIGNATURE-----

--snd5d5o342ief275--
