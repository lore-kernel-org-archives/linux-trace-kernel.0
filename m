Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B2C7328253
	for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 14:45:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766414747; cv=none; b=boJ/0qRIG8Xcn9eq123tY2kQ6IZHzII0ZKSDEZ8vVEA3ckzX/zHFWAnxY3vx/WTbWQ8QTQiz+3e/6weIP+QL3rDGgFUW+ZYeqGTx1CNCedgPgmDD2bVidvArlIdBeO1ZA/fosiS68oqSCXZgNaXZEVlu2aax7W9upVUbyrobb5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766414747; c=relaxed/simple;
	bh=mq3Lq8sxs3JAWF9439sUZ282BxN/eqYUPbbBpwwlj3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rswBl4geMjqFqPn0QXsKvdlIXjOuYFUjI+uZe5HBq/7CWoZlxwyVKXaHL2ZYkG6VvY5hdYu4RdLnuqGqKmpQ/Hiz/0Kxs99lrOl3hswLWvl47ewPbofiU1hA0+g7zCeK7qvqSkzjzmQm+/ZjL72V2qYlfelFJaHj3h6TaH+kywc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Cep3Ug8J; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Cep3Ug8J"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1766414744;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=mq3Lq8sxs3JAWF9439sUZ282BxN/eqYUPbbBpwwlj3E=;
	b=Cep3Ug8JsbV58T2YUWL5dMHhV5GICzIWEb5bWQmAhu/hhxDl2O8zmC9VGrWJNTPelAoLvc
	GsKySmujA5DqtH3/yW8f52PHT+7xn+XHPpaRsD6/l9MIwsxssQJJ09n1rKLYdbUmQBkykg
	SJ/Tkwe263M40EwM9DWe4xJKUgjW6sw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-hUQJdTmgPI6cXGzrg28M_g-1; Mon, 22 Dec 2025 09:45:39 -0500
X-MC-Unique: hUQJdTmgPI6cXGzrg28M_g-1
X-Mimecast-MFC-AGG-ID: hUQJdTmgPI6cXGzrg28M_g_1766414739
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42fd46385c0so2151963f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 22 Dec 2025 06:45:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766414739; x=1767019539;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mq3Lq8sxs3JAWF9439sUZ282BxN/eqYUPbbBpwwlj3E=;
        b=RZrJ8xbBfNppO4VdFJD2fNODfsZ2T8ebgImZlQPRHqPdDxtBXP0TIGcCbjp1hXZQ/3
         OZNBC3iL7cltr23mEUmNmuLbHlI3M1avKRD7336bbHIagrn2fCPDTAZD0Tv8YkEkdAzq
         +KEvHm6/Ll46Cs1q9Rp9dw+uGaAyg1sQ/3I0AQJBc+cm0sorY3SNQkSWT58YemaqiaSH
         OK4zMJKGJewQ7c/f126i4l494boNVV5PrZdEMgzyv3uPPMYCP9RdfNbwswjVhcp0fIHB
         o8O3fcTA2Cb4hJmz8AqtdSBzaI+PI78v2mF9QA3oX17y+cULM0/cTyZIQCBb8Kc5kqNY
         YWVA==
X-Forwarded-Encrypted: i=1; AJvYcCVfRMJoJ/wSP0Oh9O13rSDeVp0h2N+XxQMiqxdfV4FxhwbzteGh+H42OJ/UZyhUveQYceys7x8HLC7Z5FjO4JvatwY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzGSObHm4g/jnX0LF5rqAqcNLN+7su4t/lLH3E1+he+WB3wNAn9
	bM5UyWb2NHW6zsm5bXX7s2CH3oKKc0eNpADU72BmME01nlbsg4TlIHrzP5RtawDK2oXoCTJhkIW
	jXR5J7KjEnN0OETdDmznx0cg2xj0XGdHK3e8EeNZp3+kqNg1kViWXL98coVFX+6zDGssgH43Uqg
	==
X-Gm-Gg: AY/fxX6oBFMFmkFx9Z9MVYGQZi+4nWGjqhhi5oETSQ2s/dxtAfBLz0G+0VvxTCYl0uj
	uQT+Et/nZBre8v1m5YADp93x65Q8fVcdJpd3J2LpC7HiqG1Yq6uzidxMMDsQjM8L8mBprdhg3o1
	OMqjoshz4OVGA+UlFjpkVC0RdmaW6k5ov2YlLjkSC93jTAZ4yT3e52CL60+TfFtIIFgBMkFuz6g
	PlN+UfAvLvnQtmQLMaln2YdE1czw0sYpKr5K6nMv4JHBkPlSJSapG/kRIxZzimRWWERI28AeK8E
	nqp5L+PxWoMzu5UeJ/vZHfkpxZeV66bagFlwKcq0LeXMYuwMu7qVB4CYEKw75QcmlQrHYv3NMfe
	t3j89EBW/odGa9loxPRxxY0JREGVQzdis8TYhA10p1a1c9WgPfz14OYpDFwvBtQRYM1SZXU03o7
	OVv+SnpQaA
X-Received: by 2002:a05:6000:1970:b0:432:5b81:48b with SMTP id ffacd0b85a97d-4325b8109e2mr5619128f8f.61.1766414738607;
        Mon, 22 Dec 2025 06:45:38 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFbLHw0fD46qNSTX57uR+znJQOS0DV63sf9w/x+8+0Lv2iDhD5E7JuxXcEwrDZcNmKVaq16ig==
X-Received: by 2002:a05:6000:1970:b0:432:5b81:48b with SMTP id ffacd0b85a97d-4325b8109e2mr5619112f8f.61.1766414738236;
        Mon, 22 Dec 2025 06:45:38 -0800 (PST)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb (185-132-178-103.hosted-by-worldstream.net. [185.132.178.103])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea830fesm22620468f8f.20.2025.12.22.06.45.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Dec 2025 06:45:37 -0800 (PST)
Message-ID: <1c86695dc26202d2cfafdb636d32c47a8c3d6b15.camel@redhat.com>
Subject: Re: [PATCH v3 01/13] rv: Unify DA event handling functions across
 monitor types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Mon, 22 Dec 2025 15:45:36 +0100
In-Reply-To: <871pksk3cg.fsf@yellow.woof>
References: <20251205131621.135513-1-gmonaco@redhat.com>
	 <20251205131621.135513-2-gmonaco@redhat.com> <871pksk3cg.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: s1pofUsyrXsV8vl_ZwLlfNZPFzlqNGinZbS5MWu5v2M_1766414739
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-12-18 at 08:04 +0700, Nam Cao wrote:
> I think this overexplains. I would just explain the "WHY", then the
> general idea how the patch solves the problem. Let the diff speaks for
> the rest.
>=20
> Perhaps something like:
>=20
> =C2=A0=C2=A0=C2=A0 The DA event handling functions are mostly duplicated =
for
> =C2=A0=C2=A0=C2=A0 differerent monitor types, because per-task monitors' =
functions
> =C2=A0=C2=A0=C2=A0 require a task_struct parameter while the others do no=
t.
>=20
> =C2=A0=C2=A0=C2=A0 Unify the functions, handle the difference by always p=
assing a
> =C2=A0=C2=A0=C2=A0 da_id_type which is the task's pid for per-task monito=
r but is
> =C2=A0=C2=A0=C2=A0 ignored for the other types.
>=20

Good point, I'll squeeze it.
Thanks,
Gabriele

> Regardless:
>=20
> Reviewed-by: Nam Cao <namcao@linutronix.de>
>=20
> Nam

