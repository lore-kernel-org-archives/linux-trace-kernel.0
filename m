Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD3823F076E
	for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 20:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368116; cv=none; b=R+PdlJyLfGXmO2eXUIt6BvRCxla9lYmp5E8jgCWa3G3s5mQ6JGfV+7LbsOERSAtDvdwAYHQ1HMEuT6j5hHz7Jj3+UZCRWfRF65rxNtxeTWQLVcCPuhNaOdgPxW4W7Vag+sB22is4yGqH+9ET7Rs0W7Fm7GVK4viU4W6MqAxANCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368116; c=relaxed/simple;
	bh=OISNyxqYsyIJjvZpwj+5Ey+JOQREWF6pIQkZttrSuig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O4m5Am8LfcxmOcwCZLzteDC9ScYmCGXw/GcwqI0MTEuUGFGzwRef5IIfGluLZFcb2GucIqFtiYwzR7bRo2nkklaXqGfXNYnpUMQMIkvSJKezVgu60FwR0GzG6jOZIL9OI8OwTTSDNDUPXHgGCk2vxI0eor8MAirJWKWZ2LHXb0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=hG3VJJAs; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="hG3VJJAs"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d3931so10543815e9.3
        for <linux-trace-kernel@vger.kernel.org>; Fri, 25 Sep 2026 13:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1790368112; x=1790972912; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MPkKdQ6kZcjzNVQGvFMHY0E0nhE5dpwirKpR+Cx91W8=;
        b=hG3VJJAsJ30UNP8lJTNh6xEDuDRn1fzq/5fQKkwFX/dWFaIbQq6nC3lEJXuSBQCkBn
         Leer7XCbz963/pqJ0flZNHYImaTE6gDFwJC2D2QLm4TEbXxKAzZwbnQTtY8zh4HI4fIq
         704EI3MqGWU1ynBiENE9SSv/Mr5/3GALQsdNyR96Ayp9WgMehdeEmYMWD0O9H6UHUGWL
         /L3yc8msyPn4rNT5Fu/eoJSA27970PgKv4BA1Z5pJDDTG+av1XaIkbsx5rRjPh+JKDXY
         D3F2KPox9JFNgBO4Y0uT9MmM+q8OASopkK6vajZLMNyKP17zlOSYkUAVUbztkVUONkw/
         WYNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790368112; x=1790972912;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MPkKdQ6kZcjzNVQGvFMHY0E0nhE5dpwirKpR+Cx91W8=;
        b=s4DVU4BYw1Qt/eNqgqarJo/fZpheWscb7/zdj7DzW/CL+n2ddRk9AkGJuyq5k8uiXN
         7fKbc+5KHmBlDsPsKPlBR2PK8Spaj+ONEvKbsZ9myqoYb8oOkxKV+AewB9bCXUJcPUgq
         JzH7+2rGyfinPrDM/phviq+NHN16uKA6mhjv6OjL87Vn4AkwsetSAZu1cGI5J6tUAtMu
         UXZyDiQHFYYkPFoufLTE39iRj/DHc1b/viAWY76MzQzVU5Ku4vp+SukP5/41PwJFLrsq
         R5lxKfp6hzJthrLQqz3++5wDXIRA0QOaODAxZ6iAzzGdLr3fYsRWd81cWXr823GjGWIw
         M5fg==
X-Forwarded-Encrypted: i=1; AKwUvBwugDhZawlpXKADF+JfB8UksEYunMAEdTEQixi/bgjXoHWnfe439P8IeSOKeNk0OelQg2oWyxhZomcKWA/hMr5icNQ=@vger.kernel.org
X-Gm-Message-State: AFuF++nzHQV3hg6VnOgSxfRtnSNzws9PwjDpc1dNV2SK3khrKJ8wle1s
	SW+kkRY8mQr34ERA07zOPp6vKp81ZS9CkjbalFSveJaSa5HXJMTbu3XoT1UomwZUNm0=
X-Gm-Gg: AYBFou1FrPx+C4G+GBqr5fQoCimpzT+0ESiU09caC3CfYNQ8cnFmNmwbMY8a42XNcIj
	02OyBPUHxSKhSPjuNQyC8vd/egSZwCl5vRB9h9fyKyip7OZDSIg8mgb6X08I5PH8GnAlah4mSzE
	J7lcJNTkYv3rwr8R3pZn67+wG+NBO5Swsb7CqiGoxUws29bLxxS6IeVO8VzXrVbQ8HdoNv0sJwP
	4EISFNcSQVz3PmnwtkE9r38QqXz/AQ3cQujU5U3pTNafSC8OzcMdeYc9YPvVIoFbTwB3j4hyEzc
	GhE+cZIfNAMaYNW27FkwetiTzKNoqEVuZPN0Wa+8IcvLzk+8g8+ZHc02eRzhnuSljRDaz9rTVO2
	lkv91RVfZQ3A19JCflM1bqLydM057hYO7QCBzxWpCCgfsgCYSqyuihPIn0iWh2btLsw3unGdApx
	2YLjL4a8dw++7p3j2DC4jkEJvCLyPStsDSbP7IB2qtMSGfOX8wvmuiP0JM/3VFZSoT5ehH3FoNL
	gQ=
X-Received: by 2002:a05:600c:310b:b0:49d:34:420d with SMTP id 5b1f17b1804b1-49fe66f3e61mr119387075e9.20.1790368112077;
        Fri, 25 Sep 2026 13:28:32 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:1d24:d58d:2b65:c291])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-49fe5ce4941sm172649185e9.6.2026.09.25.13.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Sep 2026 13:28:31 -0700 (PDT)
Date: Fri, 25 Sep 2026 22:28:29 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Johan Hovold <johan@kernel.org>, Aaron Tomlin <atomlin@atomlin.com>, 
	Bradley Morgan <brads@mainlining.org>, Danilo Krummrich <dakr@kernel.org>, 
	Thierry Reding <thierry.reding@kernel.org>, David Lechner <dlechner@baylibre.com>, 
	Armin Wolf <W_Armin@gmx.de>, linux-kernel@vger.kernel.org, driver-core@lists.linux.dev, 
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
Message-ID: <arbYJUnMkb8Mqbam@monoceros>
References: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="hfoj37cw2gi5ppmu"
Content-Disposition: inline
In-Reply-To: <20260925182041.1025371-2-u.kleine-koenig@baylibre.com>


--hfoj37cw2gi5ppmu
Content-Type: text/plain; protected-headers=v1; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
MIME-Version: 1.0

Hello David,

On Fri, Sep 25, 2026 at 08:20:40PM +0200, Uwe Kleine-K=C3=B6nig wrote:
> Commit fcbfaffee51a ("driver core: add TAINT_FORCED_BIND for when
> userspace manually messes with devices and drivers") introduced a taint
> for usage of bind/unbind sysfs files that manually trigger driver probe
> and remove respectively.
>=20
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
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

Sashiko found an issue in the oneline shell script, I fixed that in a
separate commit because it wasn't introduced in my patch.

Also I violated my own rule not to send patches directly before calling
it a day and so missed to squash in the build fix that Sashiko also
found =F0=9F=A4=A6.

I wait a bit before sending a v2, but if you want to take a glimpse
already on the changes I did, look at

	https://git.kernel.org/pub/scm/linux/kernel/git/ukleinek/linux.git driver_=
override-taint

Best regards
Uwe

--hfoj37cw2gi5ppmu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmq22WsACgkQj4D7WH0S
/k5wzwf/e+nKnBHFLEFkk8qt+OAiFap0dlTSMlJIBcnEpsrNDid/nI94lQcq4oyj
ow4CxnbcvYgscNLOSwlp6XaZDAcH+N0m/0E9fQSznntmfxsavFPBfFKeH7shsZUl
j2h7EDIaeVeYlTJE8wnTFqikllHmPKDly6zSCpa5vBcescFkj1XM6bsTTLawx/gU
g+waIeksx5QOyDFRbGmFZUa3wIhy+atcDO7Zn2nzh6dTkJve7XEsZ81+L2t48Dqw
TjrzRUXsAdR/R3YBn7//ejzDmLmJONXcLvdi91fgDpmDOsxlR2byDQyBba9Z5kiJ
GIkxzJVpscvwynkkeVZdv+EtSgGJ8w==
=PGxC
-----END PGP SIGNATURE-----

--hfoj37cw2gi5ppmu--
