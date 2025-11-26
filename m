Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0370828D83F
	for <linux-trace-kernel@vger.kernel.org>; Wed, 26 Nov 2025 07:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764142070; cv=none; b=ktsa0sSTssiOwkWW3+8l4DZ49aya5LN9iV2G1vbv2diV0aRbQbHx4BfaZ36VfJaE/t7w6zvjY+oO6PlsWPwGpoJjtrBWZKZqy8neENMaVlhEmD2Gncir0b/ap6sFYmQaPQIL841lTDXWVBzGq/r4t5+kGlhP97laPHBS2Uc1WnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764142070; c=relaxed/simple;
	bh=0APT5HLkJcaN0fc0vbHueBaJVzGMvnMVhoOd2dCH1Qk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aUCWd2l+O8A4R36JIbYPkF2mudDcBnLN/rp0OpTa82/Z5Ed6j3I6tiwjHi7DxrS/vmGsl+Sq0zo2gACxW8ujTeS/qO+0cIjnTEm4nrCucjpaYYrItj2mk7m1sp76oiKRSlbfZDb7tNIFpxet5M/OCe6M8YHSHn0IytF1wr1ZrAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BSkRNqJO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BSkRNqJO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764142067;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=0APT5HLkJcaN0fc0vbHueBaJVzGMvnMVhoOd2dCH1Qk=;
	b=BSkRNqJOKXQLUgR0ucYKhcRystKnvYR1YEXIncEwQVpq87fwxI7tD/rXCB/Ug0ida+9n0U
	BnFzYNoPijB1ePkewn1QRnLJKcNvhDuf/zWTQySiBNnZoDLvnK6SxQbsUVkG9tTM8ogdw3
	ZNskq6ynlBMm9K+0SOi9D6x2JUWZWso=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-537-uSyjCQ7kPNqrRmFmu-H8dQ-1; Wed, 26 Nov 2025 02:27:45 -0500
X-MC-Unique: uSyjCQ7kPNqrRmFmu-H8dQ-1
X-Mimecast-MFC-AGG-ID: uSyjCQ7kPNqrRmFmu-H8dQ_1764142064
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42b2b9c7ab6so3206243f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Nov 2025 23:27:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764142064; x=1764746864;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nco9kMQ0naw+QFTHGhGkEUiJ6x4Fn+gAQnbkM+gldhA=;
        b=kcNek9gi3PtmR07VuwMa6TZRKbrebbXRjVWnzFowhCbM3lZZi/leyFODktH0Cv6PIn
         YyXMIDsX1ZnhyfejIQYntPE3psov1Hfy4zZpCrHygyzeaGmN2mP4Y39TCWd1MRIjR2LV
         p3pJNQHlofbcbJZKPCWyhT2ICpBKO8Uy0VXeiksb16VKSE+L+8eW5SRYEqJvwYJJNTrp
         2TveykSmAyXaLmmQc5C5OCXPWs8m+lmQEU234BLOj5HMqK5/HgG/yXK17d8fdY+pX/nj
         4XGC/GLjvpKw6O6uY+MM0aghKfp3DSFPIeAJpGM6WJBqh5cJTErhKqPf3u0VZfj/CdK8
         8IhA==
X-Forwarded-Encrypted: i=1; AJvYcCU4mjkkYBCmtvZzyGq0F5mWyDM6sAINpRTOgA9WQ8rDm0QdBnl7qmO2AEelbZDhfv85+0FFaoYgYilSbeeosr7yIuE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhJ4biVp5UVgBApFLxhNc60zsvAPonwu5+UaSjr4nqB/9EJ8kr
	NFsqwnm+3xkxSah9PLDajnt+FcC0Zuzw3jkMYyWGRqJNrp67Mvhp4eMzOg+IDWdoTZixpjwbFR1
	LQsGDNs7AJUJEHAWSCWgVGkSKnwnD+o0vO8JazWy+wFcIJ6XqKPA6zCKRNto/L7eUO1/odexwLA
	==
X-Gm-Gg: ASbGncuCo0ztVOQhO1IobOZy5IOx3wLVbZEtDvHqY7O6Y+zz9c6YiS6w4DUFDszfIrN
	4kizQgmieCA41aaVFv5Qh2U5YA47r0iKGf8yDHfRd5ydoOERecIDaC/pBvQf5lJbU2UkfTc6P8z
	LJM+mquqP2J3CjWlbxXQQw/uhHLk+0o4XwLqa0kqRUe95Vcf4oGUkAi9QnAQl0nvDYmbP8oSifx
	/uVxcgz88DeJkS3Iio60/PHY34P6giY0sZauyKFEnQRAvkw3ihvusMcQjkC4at2pDZulCz9CpPA
	1OzbXJgFx0sDOw5yK9QPyuANasDslDhohuVoQC+GFFQhwDnKmVfODLfnW6nD+gNeTrK5kSfIC2Q
	pSZbUGJlOsNjlqpcEjnUBjfFMCZJBQE2lClg=
X-Received: by 2002:a05:6000:2003:b0:427:6a3:e72f with SMTP id ffacd0b85a97d-42cc1d0cfadmr18247874f8f.34.1764142064251;
        Tue, 25 Nov 2025 23:27:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOqX3PELwvIZ+Vb1AbVC110j9OqoH953u64KiUDbJZ8vWSBYF7n3Xf4475WzmzUwsPtoAG5A==
X-Received: by 2002:a05:6000:2003:b0:427:6a3:e72f with SMTP id ffacd0b85a97d-42cc1d0cfadmr18247854f8f.34.1764142063906;
        Tue, 25 Nov 2025 23:27:43 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.35])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fd8d97sm38236674f8f.42.2025.11.25.23.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 23:27:43 -0800 (PST)
Message-ID: <e4838dd91f14024222eef8e705f2b1ae7945bb80.camel@redhat.com>
Subject: Re: [PATCH v2 1/2] rv: Convert to use lock guard
From: Gabriele Monaco <gmonaco@redhat.com>
To: Steven Rostedt <rostedt@goodmis.org>, Nam Cao <namcao@linutronix.de>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
	 <mathieu.desnoyers@efficios.com>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Wed, 26 Nov 2025 08:27:42 +0100
In-Reply-To: <20251125145736.48c3ed9d@gandalf.local.home>
References: <cover.1763370183.git.namcao@linutronix.de>
		<dbefeb868093c40d4b29fd6b57294a6aa011b719.1763370183.git.namcao@linutronix.de>
	 <20251125145736.48c3ed9d@gandalf.local.home>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.1 (3.58.1-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AKpGU6OuTPIv4BWEqMcpJjptrNCSsKq1dlEF6KcHhqs_1764142064
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-11-25 at 14:57 -0500, Steven Rostedt wrote:
> On Mon, 17 Nov 2025 09:06:02 +0000
> Nam Cao <namcao@linutronix.de> wrote:
>=20
> > @@ -644,13 +640,11 @@ static ssize_t enabled_monitors_write(struct file
> > *filp, const char __user *user
> > =C2=A0=09=09else
> > =C2=A0=09=09=09retval =3D rv_disable_monitor(mon);
> > =C2=A0
> > -=09=09if (!retval)
> > -=09=09=09retval =3D count;
> > -
> > -=09=09break;
> > +=09=09if (retval)
> > +=09=09=09return retval;
> > +=09=09return count;
>=20
> No biggy, but I wonder if this would look better as:
>=20
> =09=09return retval ? : count;
>=20

Tried both patches and they look fine to me.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>

Nam, feel free to send an updated version if you want to apply Steve's
suggestion or keep the patch like this.

Steve, this is the only remaining change before the merge window, unless yo=
u
prefer to keep it for the next round, I'm going to send a small pull reques=
ts
with those two patches alone.

Thanks,
Gabriele

> -- Steve
>=20
> > =C2=A0=09}
> > =C2=A0
> > -=09mutex_unlock(&rv_interface_lock);
> > =C2=A0=09return retval;
> > =C2=A0}
> > =C2=A0

