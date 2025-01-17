Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 923801F76DF
	for <linux-trace-kernel@vger.kernel.org>; Fri, 17 Jan 2025 06:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737097139; cv=none; b=LPJMqRQKFBHGji39hxvvoUMqx0WGQAvRn2C2XxpA52TWqMkeiKx9VpQM3ydgONsAF//oFgzgImj+xV+ySuzvg7VbZIAUf5C1+bwgrZqNgiGcPBg1p37YNLvgHx/tVryiDPRCQkOBRM6Ug69B1rnJ8AmjAVCXXoNkXVvTYkRKJsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737097139; c=relaxed/simple;
	bh=BKXLxWJZswuJlSZ7XSJt5/n48k9bZkCSELwfhut2jEo=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cDzOeSLAGy2a9K0XMA/jbVhb3YkKZ31q4wMJ3ZOumnesdnsIwskP9GtfKjVSMv9vCQQh5bhgpMtTp9vVqRqxTHkJmbIzzA0aMH769m/d519XRyWl8RYKNHvjDBPG1gGDZxpV6IvDlyJSjtfQBQo5Lkn46oanpD/0ydwr88ZUXuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jEI1E7PK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jEI1E7PK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1737097136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=BKXLxWJZswuJlSZ7XSJt5/n48k9bZkCSELwfhut2jEo=;
	b=jEI1E7PKJ7IxZmrIcGiV1MTz6btECfFKcw3CvgiRU5pqwUNwzSvKIR/b34E2itVA0K8t7v
	f0NFs+hPXb0qhMEb5uqWh7G2ChOWBJzibs+fhRL6z/UYJBLhX0gUs+VBe61m2mOrklDNi0
	jHBbJj5Y7t99pjgAn0uwbixMaMzLP8o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-640-hJ1ggNFHN7KpyiS0VnRF5A-1; Fri, 17 Jan 2025 01:58:54 -0500
X-MC-Unique: hJ1ggNFHN7KpyiS0VnRF5A-1
X-Mimecast-MFC-AGG-ID: hJ1ggNFHN7KpyiS0VnRF5A
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-38a684a0971so748198f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Thu, 16 Jan 2025 22:58:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737097133; x=1737701933;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5n/fTj3Tj01ayx0L2xKfRrCdONvQcFHXl2LZLkl0XMA=;
        b=k0BX7t1RR9n+J2nSP/RqqO6Vg9/phR0ch7U1lKfRa1lTn/24YkncPPh5B1Z4k8WlV8
         gSJxFtPUV9ULkzUfO89hghfexkp8iJtP+VAKxSN0evyqC5SuLfMAKsx0CtVAgzGCWj1x
         qglE6Coz4/yrxj/1aKZaGgdDjHLa4Akv8nGhnq9AqkNFciJWM68+2ppYLDLZWMILbRK6
         THGQFgo+pwQEH7+JRLgGCFLHNw3KhnihnmSYZ8i71xo4lx3lCCwp/BCXW8MWeh8VvhqZ
         H5C5NmTfPQeZe0JlEi2LYcSjQLfRyWIyCKi6vIxX4uJSJE2ssNV//ZwPAJZ9RPkSGMdl
         l+QQ==
X-Gm-Message-State: AOJu0Yy+0wv0GVIWEvqwIoUKlSEfD1pQSE+hEmFNy3Tk8vk9q7FTXSvh
	Gvi5CojdEoeSAP9TPgsPo9lJDwTjaIn7PrAzsDyvurH9kKCkF7Ccusje8nz00Lh/ddFQxhD3oXq
	SfZJj8/fie639Zk9t5oF+n4sldMZbevOpuv9cNu3DauU+oiEd8wEajdMwdrxhCX4QZERgrA==
X-Gm-Gg: ASbGncsEYDPkiKCK3k1ht5uVq23MfLqi85wmMaJip7Mp+JT73kvkHnNSZHm/mjhk+1R
	/W40Mx3b777uFrH5X1mrrozrEhWdzoi9/Nq7mRwp5x3TC62Ya05sD+EU/PKN3F2xRiq8592iZGr
	Z57S78Gk7/cd5PPeDnnHn0ozTWk5ArNm9vZX3kjuxCm/ondAECmHefOczZDJ1+w+GjWPI86Ai5g
	+Tjf7K/CDeSB9kGq5kZ9xsIe4gp9Z2q0nyOQdVCLeT6bnQqnfLkP7ynmRz+cJwHeBC6tuikd7pQ
	tBWarsc=
X-Received: by 2002:adf:e607:0:b0:38b:d765:7046 with SMTP id ffacd0b85a97d-38bf56855dbmr1001750f8f.33.1737097133581;
        Thu, 16 Jan 2025 22:58:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEKZ8zJMii74BWgge3O0M2SkI75Dpm4IBiH6Ebs0htAVM/pajgVAzCYW6RHojYxyGYKNoKAyg==
X-Received: by 2002:adf:e607:0:b0:38b:d765:7046 with SMTP id ffacd0b85a97d-38bf56855dbmr1001736f8f.33.1737097133114;
        Thu, 16 Jan 2025 22:58:53 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-437c7499821sm83118445e9.2.2025.01.16.22.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2025 22:58:52 -0800 (PST)
Message-ID: <fa78c382c1aee2acba2aac11b01ee511414af2dc.camel@redhat.com>
Subject: Re: [PATCH 5/5] rtla/timerlat_top: Abort event processing on second
 signal
From: Gabriele Monaco <gmonaco@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>
Date: Fri, 17 Jan 2025 07:58:50 +0100
In-Reply-To: <20250116144931.649593-6-tglozar@redhat.com>
References: <20250116144931.649593-1-tglozar@redhat.com>
	 <20250116144931.649593-6-tglozar@redhat.com>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: t64jxXxrMCxXvhqbFCYaQQQls8M6_YGs6uOwKikCJuA_1737097134
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-01-16 at 15:49 +0100, Tomas Glozar wrote:
> Apply the changes from the previous patch also to timerlat-top.
>=20
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
> =C2=A0tools/tracing/rtla/src/timerlat_top.c | 8 ++++++++
> =C2=A01 file changed, 8 insertions(+)
>=20
> diff --git a/tools/tracing/rtla/src/timerlat_top.c
> b/tools/tracing/rtla/src/timerlat_top.c
> index d21a21053917..d358cd39f360 100644
> --- a/tools/tracing/rtla/src/timerlat_top.c
> +++ b/tools/tracing/rtla/src/timerlat_top.c
> @@ -903,6 +903,14 @@ static int stop_tracing;
> =C2=A0static struct trace_instance *top_inst =3D NULL;
> =C2=A0static void stop_top(int sig)
> =C2=A0{
> +=09if (stop_tracing) {
> +=09=09/*
> +=09=09 * Stop requested twice in a row; abort event
> processing and
> +=09=09 * exit immediately
> +=09=09 */
> +=09=09tracefs_iterate_stop(top_inst->inst);
> +=09=09return;
> +=09}
> =C2=A0=09stop_tracing =3D 1;
> =C2=A0=09if (top_inst)
> =C2=A0=09=09trace_instance_stop(top_inst);

I confirm the patchset works as expected on a 128 cores machine.
That is like the machine where the problem was first observed: run
timerlat with -p 100 and it would hang.

Now running it with -d terminates (a bit) after the expiration of the
timer with a sane report, sending a SIGINT terminates it too and
sending 2 SIGINT terminates it almost instantaneously.=09

This works on both timerlat top and hist, with both -u and -k .
The report only gets printed in the end (as if -q was passed), but
these patches are not meant to fix that.

Tested-by: Gabriele Monaco <gmonaco@redhat.com>

