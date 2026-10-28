Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793199059;
	b=rBe69GE9Avzp4voU+6hHVAVgc9Is/CPVl63oSYXp7LyUhORTAEQ/tIxpzJwd9m+iSjfb
	 m6PXT46Pgdj9+MymEQEQNZsQ01D7GN71P4o7T2zzNv0gVfrTOupj3zvwxAp+oqmkRSTsl
	 m0FziGPFb/TiDhl5kE9k/qpXkNOTC5iXQKVByMUzl1XN1HuUl5n4+1V1MXR78SqrYCMbf
	 iJY5VNKCIX0bZtAqfm2rxl/ZhY6uevARvAPW9IQHE3/ron1QaGhgMIh3FKacXzYUYCk62
	 dFTLspTnRq2AsQXCbbGk6YnP9eLGFOJtnz/Xl8FGtNA4GSjeU2cr+UHqumvMpwgN9CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793199059;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=8g9t7ALU7n+7VW9gQDZGowaF3x6SIEajb/2Mc6wiGZg=;
	b=l6bHIx3yYrPz2yuS04IE9Tu80fsS5sGsblP9jpujfAKtlbC1pwaCzu+bIqe4MbIYg61U
	 KJnb5ezOGTKeiLG+Qzd0ceKkk7kruXzuDn2+rMjDczJJ7rzVgwipfq+s1W6Y2MP4vwNnu
	 2J1mIRHWFyWiNU8VUvcqOwuIs8W6wySQ5toGK09YXhpOAtotX2euGMjwHkYpr8RiKWPj8
	 NEX4BNU3wJ1qrRMC8sbzAAsX4I/eaz/IUTRpOZiUstspKCHwQIITmjxzmGB/vpWGwn5EE
	 twxlqhug9280QAjSBYYl5LX3xxO/dH8qA0FuhFDavGe8s16ogy9vib6L5rNbNC/DqFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	arc=none smtp.remote-ip=209.85.128.53
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AF36606A323
	for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 14:50:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1AF36606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4a35d5d4a20so11798215e9.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 28 Oct 2026 07:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793199047; x=1793803847; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8g9t7ALU7n+7VW9gQDZGowaF3x6SIEajb/2Mc6wiGZg=;
        b=ZHI+PnMYUO4N11z48C45pvIZIJWpMQLYtqa/tXxi4VJPtckafE2C8vZsmMqf8WSay0
         WkP8vzXw7KUTk+v36CyGXajDZqG5by6+RXck/9D3EACNfx4yeyKYYQCGbZWVuUnG8rUY
         5qLQe1LGWxfOMYFobc3VGIHrV+AV15yetvd7tYKfqNhVaNLNUnVgOeygrUQUPRbwHDiW
         lcID/IWXFCzR53WbNv/a/lMfGMt8NtxMv4qhxOQ+gXhSRnRitG8FLFKqq0+vRsgTDT10
         G8Oqf0Udam7YRK2gHQ+5l/UpMXkarOzmpwiZriOVr29JvpcbNa84+vP5mTUlSdzwCT8R
         2qnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793199047; x=1793803847;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8g9t7ALU7n+7VW9gQDZGowaF3x6SIEajb/2Mc6wiGZg=;
        b=g/YqpyFByuHO6oULeyyRF2aojHz0h+ZOo0G8zyCbFfcy4rcFqMNCCaQ9xa/f/xmt69
         B4cCYsFK38Mm7r48I3IoZfH794jE/SbHTZBOMvxPpDOPkvejSmhsg76mAjO5i4Fndc3V
         fXN+sHyYafNMemRGApK4/aSOhJ6sQRxf0ZNO+cR9rRXAkrclSkbd4xeIWY276d2GxcLL
         Qaw8OjUZB9al6CAI8k5itQB4DBg2ofAjQgvVKZ7bJwwEGUMq9xpRUc9/9fm1G+s59a4N
         Yi1dtwtY0CT+DQqCPax1cX1WAVCbQzz91DAvzZPhNniJe0HED5qO5QNtWmwTVGtO9CxX
         m5/A==
X-Forwarded-Encrypted: i=1; AKwUvBzXlVTTjTYsM21ZMAAumQTGBGggn1zUT7BTWxQYFYEP9bU4KMp48ufPQs6GY2zmoOc5lndRakDw5eCnTBvzyDcPw/E=@vger.kernel.org
X-Gm-Message-State: AFq9FYIorZu2Qmwh3u63un6uHSy14OWHxAtDjVNY15ZH4I9LNVbzr7kZ
	52qmTN178Z0qISTIKMHvTmymQflzBeK+tuLkDzb/lGuL/qQ1+83gRHPs6bnCnlROZ28=
X-Gm-Gg: AYBFou3C3q1OE+GpmLbEzLnfoGp6mlp8hftOli8THw7QgsZJNuP1NZ22dmEXMCa+gcc
	26OrdwB+AjKenfNAwsWV9IPL5Lnd422HjUDbhFBVIRDJmEOEi8upmbZNHB8QM03Ee3vcGArX3BJ
	x4OBze6p+aDDKdK2wqCFXmQO/gHlancDiflz2LhLwzq4ZL0w6Min0eGU11D8k97R//5mxjWuqbB
	q//IHal6uQxvywKR19/rP5McOHXYvouwPLrG2n7RXj/fheWeYtTdmVo8HaFFDui0BOzXyN5F4K9
	QBXw2fbpSW0hJu0XgadXte7BKJ9VAb7Yzm7AMW7u3vS3AjqYweKQgWhlV//3r1W7+SGPcoXbnSx
	a8yiXsqtZ0ZLWVxkl0AK0875JAMwI2ByMf6J1JFtJbSIfrSrtAhgVP9RkeMlMW9aBiTuDTbM1zQ
	YFRavFIDNwm/fJZyevc8mt5TITjv9hs9JqrwJI4TcGWVyi+n3DSFuQzFnDZ6fZF6VKv/nYOj+k4
	YtJL7Duit3JPzFZH0uA7R7O+uH0SiuKMvrtRA9VhlNgRq/mju9uu4pu5nVXvsQTk2aS1YryLpFv
	GfXtsGvL8KHiAZa2e0fvY83ITZvQjWTlShE=
X-Received: by 2002:a05:600c:3510:b0:4a4:7a8d:c436 with SMTP id 5b1f17b1804b1-4a96667dd75mr52332595e9.11.1793199047357;
        Wed, 28 Oct 2026 07:50:47 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a97cebf858sm57250745e9.12.2026.10.28.07.50.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2026 07:50:46 -0700 (PDT)
Date: Wed, 28 Oct 2026 15:50:44 +0100
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, Alex Williamson <alex@shazbot.org>, 
	Armin Wolf <W_Armin@gmx.de>, David Lechner <dlechner@baylibre.com>, 
	Danilo Krummrich <dakr@kernel.org>, Luis Chamberlain <mcgrof@kernel.org>, 
	Petr Pavlu <petr.pavlu@suse.com>, Daniel Gomez <da.gomez@kernel.org>, 
	Sami Tolvanen <samitolvanen@google.com>, Aaron Tomlin <atomlin@atomlin.com>, 
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>, 
	Randy Dunlap <rdunlap@infradead.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Bradley Morgan <brads@mainlining.org>, 
	Aleksandr Nogikh <nogikh@google.com>, linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-usb@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org, Johan Hovold <johan@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Thierry Reding <thierry.reding@kernel.org>
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
Message-ID: <auILBqh9Ccv7ztid@monoceros>
References: <defb3953-7516-437e-b70b-d57de55b91bf@baylibre.com>
 <9bd3a34b-5e98-4038-80d6-da2c3b1948dd@gmx.de>
 <2026092321-province-yearly-44aa@gregkh>
 <arOfHEsGGglNse7T@monoceros>
 <2026092348-victory-erased-0e5a@gregkh>
 <20261023181326.0dc2f7ed@shazbot.org>
 <2026102437-vista-unsoiled-b089@gregkh>
 <at34UOuYv3NtX36R@monoceros>
 <20261026225950.GD1685504@ziepe.ca>
 <2026102849-turkey-series-ac07@gregkh>
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
	protocol="application/pgp-signature"; boundary="dvdgfsb6jpiy7bdt"
Content-Disposition: inline
In-Reply-To: <2026102849-turkey-series-ac07@gregkh>


--dvdgfsb6jpiy7bdt
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v4 0/3] driver core: add TAINT_FORCED_BIND for when
 userspace manually messes with devices and drivers
MIME-Version: 1.0

On Wed, Oct 28, 2026 at 02:45:18PM +0100, Greg Kroah-Hartman wrote:
> On Mon, Oct 26, 2026 at 07:59:50PM -0300, Jason Gunthorpe wrote:
> > On Sun, Oct 25, 2026 at 01:48:04PM +0100, Uwe Kleine-K=F6nig wrote:
> >=20
> > > The more I think about this taint, the more I believe the commit shou=
ld
> > > be reverted and replaced by a some stop gaps for driver_override. (Be=
 it
> > > a taint or better yet
> > > https://lore.kernel.org/all/0f7446324f6a0c8f0153d6532d92a6eeecd6a308.=
1790612298.git.u.kleine-koenig@baylibre.com/
> > > .)
> >=20
> > I also think this patch is way too broad and should be reverted until
> > something better is designed.
>=20
> Fair enough, I've sent a revert for now, will get it merged before -rc1
> is out.

\o/, thanks

> I'll rework this for a later release, thanks.

Please look at the series behind the link above before investing time
here. I think most of the ideas are already implemented there. If you
voice your preferences there, I can rework accordingly and rebase on top
of your revert.

Best regards
Uwe

--dvdgfsb6jpiy7bdt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmriC7gACgkQj4D7WH0S
/k7RWwf/cwXDsUHX0jhgjipjJFi1+cjW14UhDdlEnrd0BnzhDhCcWYdtX4Jokju7
CvB5Oiyfrbzutn6NGqwDb2r6lwabIE+FUkSwqOYBh0v9DeYZc09PyetAJUrJc1P+
ykWQcL5z1tPk5gkQDnk/OMUtvZXVwgH9T+CJaYjJ1zX5KQEqpM1iA0orv6blUtcV
QoHhDAdbFR9S/jZ/4rdCfk08awpvM3VqeV4VW0n2VR/QwFLZ7NS45TRo8EZdRHiI
enU/kyx10Vep14yRZmuVr3Xw5rdSN+ylwbNFFKzSLcL/Vz00iyhlIOgvlsS2wy69
vU6dhHVeUJVTb8Y8hxbTBePHR0MSsQ==
=kVFg
-----END PGP SIGNATURE-----

--dvdgfsb6jpiy7bdt--
