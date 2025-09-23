Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9BE7258CF9
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 09:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758620601; cv=none; b=NHp/LHz5q+d08WZPS6yr3EIDS2ZhXiOXMtIHoAFlzTH+4mJmX9Ci5gD+UsoRAWEZaea5nocJpbwSCGFmft3L7sbtCHzLGziRURE499254maeWbwqYxtotw+VXJ/5v5rXuPsKFrjiXakPwuuPtZIvm6ikncsqmIr/GN2iQ2G1wBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758620601; c=relaxed/simple;
	bh=g/EVcz8uDvI82s1ruLcJAtX7El3t2V3I7i5nDyjqkLQ=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t94cxOZjjhgC3Pocs6ZAuxVGbRrOkn+45ycuvukn9H2q9YBJwZrI5VdhCkpzIA4qTDKg+rkrxZeNi/cLvvcy85Wzbkpb9eteR9QLcO4hy303O0zS/7lsBVnUdW62Kt1stRTi44SuPpwLC7JTrUi4kCk7Qbqg/W8v4gmH2py/Q4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dy7S9H/Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dy7S9H/Y"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758620599;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=g/EVcz8uDvI82s1ruLcJAtX7El3t2V3I7i5nDyjqkLQ=;
	b=dy7S9H/YKg1+z6wopWhzbX5vTEnq01VH2UisRH5S12uNd7hf/bX353sgF+NGWELfp4Zgn9
	bYEUJFL/wTIrBYCthe3KOKHcjqdA58vhcyhk4AWny5CGkFp3DOCxf1vgSveCm/GUzrDC42
	KHT1xUVRjuwQvp3emHn9l4KfWfpLYhU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-393-aPnLWSNBNRqXcnKQXNj3mg-1; Tue, 23 Sep 2025 05:43:17 -0400
X-MC-Unique: aPnLWSNBNRqXcnKQXNj3mg-1
X-Mimecast-MFC-AGG-ID: aPnLWSNBNRqXcnKQXNj3mg_1758620596
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso19884195e9.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 02:43:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758620596; x=1759225396;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/EVcz8uDvI82s1ruLcJAtX7El3t2V3I7i5nDyjqkLQ=;
        b=Zi5+OhOss3/28N2XEHVS5t2xYQH8qqNqkPSoqJoeT7zx7DHpQTZlFLQ15aeU3l9c0d
         FJT+2gBQNCqWyKwX1Q6aaAzh6zfl0aOLYsrECWNX4izvVaZKg/91j4WkGRRgMJaUpBBI
         W0E83gbbYdkcgwS1wAEQYO3cpryKbMNc0os+rOj3O+RjYSdg1iMtUqqGKDf8of/5TeQU
         vxD51t3Rm+HAR1pCOz5zhMtqcrsF3jkNinSwBG5LXfkzPnnK9POL+7ryENeC90MndGJu
         +tC7nuGvTaddh4GuIsuYazxanUBmyxsm+8XgsR6oWM6JM4YO6rEx5/PPZfgq8aSy0obo
         3BOA==
X-Forwarded-Encrypted: i=1; AJvYcCXtYaruraky7tQ00iqa9eibmzZpuxwpF7knUs5Mzq/2xEeLncraPbYlx/x0BW0LU8b0OWFoIcWFvDHTeyd9qqgnahk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzLJnTcRHyjkz96Y6fSQelarAIqFmF7uvR42+iKFakYJtoDLTe4
	SWBSnLjT6aqaP2meG79hAACU2UlUEnchCQJ5muARvtjgnXDB7ceuA0/M2JsgA2tuAgw2aOOaZ+N
	7urREYRIDpIf6ndoL21zMIqHqC2Sto7APoKYSKhxe8IlzdBMkthkGgXDBFZOrHEguJW9fwF2l1A
	==
X-Gm-Gg: ASbGncs2sL29I/i/6GCYwT2cYUSDSSJglWGNI8bC/2y5tse16bJ0QbFELMc+5j5o9aF
	GKvgC6r8HyLOyPrv7Br2Dm4rb07bWO3VWrpWMHf/qjY/NpKhX9HxH/6Xn/q1aLQDy0NQ2TCkVmW
	BXwea/jd5JHMTQHoxKhRxciC5+iNos6IJfThlCUrm2jOa0HoQ1nyLiLDaI4zyqAMSOpbMXE5CXv
	MvMO3APbVKDA42E3OdfaJRiA5f66y2Gq9CaB6tUNGJ45mcw5qc0ZtBc484MwUaQKBWzWB0aYStn
	cRWa9HGlq7P28Lll6H3DnlOtxYxDBofMbQ2BrNpC7iA3g5knw32oRJ+H7XjymAPrTg==
X-Received: by 2002:a05:600c:4fd4:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-46e1d988d12mr21304925e9.12.1758620596471;
        Tue, 23 Sep 2025 02:43:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJXoBtXvTd2Kf4hEtQgZIhNcJSjfgeo+qO9jd2CEytfhVkTcGIYGRMzua4UGM/hH+Xob6mIQ==
X-Received: by 2002:a05:600c:4fd4:b0:45b:7d77:b592 with SMTP id 5b1f17b1804b1-46e1d988d12mr21304705e9.12.1758620596079;
        Tue, 23 Sep 2025 02:43:16 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-402188ef7b2sm5018824f8f.34.2025.09.23.02.43.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 02:43:15 -0700 (PDT)
Message-ID: <f5836a1d3400581a6352d36474be4cc72a802342.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 11:43:14 +0200
In-Reply-To: <87v7l9r225.fsf@yellow.woof>
References: <20250806120911.989365-1-namcao@linutronix.de>
	 <20250923002004.GA2836051@ax162> <87tt0t4u19.fsf@yellow.woof>
	 <aacdcc85c9f8d3a51a85b6429646c38d4b239449.camel@redhat.com>
	 <87v7l9r225.fsf@yellow.woof>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0BrZXJuZWwub3JnPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmjKX2MCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfIQuAD+JulczTN6l7oJjyroySU55Fbjdvo52xiYYlMjPG7dCTsBAMFI7dSL5zg98I+8
 cXY1J7kyNsY6/dcipqBM4RMaxXsOtCRHYWJyaWVsZSBNb25hY28gPGdtb25hY29AcmVkaGF0LmNvb
 T6InAQTFgoARAIbAwUJBaOagAULCQgHAgIiAgYVCgkICwIEFgIDAQIeBwIXgBYhBMrKEfgLgd0WcK
 eo9u9KbElYeE3yBQJoymCyAhkBAAoJEO9KbElYeE3yjX4BAJ/ETNnlHn8OjZPT77xGmal9kbT1bC1
 7DfrYVISWV2Y1AP9HdAMhWNAvtCtN2S1beYjNybuK6IzWYcFfeOV+OBWRDQ==
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 876nsOT9qHlS6DaRY5E6TZx-6sVrbJT20TJjQR6RDJw_1758620596
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-09-23 at 10:44 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Looks reasonable, can you work on the fix?
> > I see Steve is out for conferences so this won't be too urgent.
>=20
> The fix is in my previous email.

I confirm enabled_monitors works with your fix. Feel free to post a patch a=
nd
I'll battle test it and include it.

Thanks,
Gabriele

>=20
> I am guessing your email client is hiding the diff from you ;) (among
> wrapping quoted reply, but that's not too important).
>=20
> Nam

