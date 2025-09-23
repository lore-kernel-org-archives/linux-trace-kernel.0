Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED56C302158
	for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 08:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758617631; cv=none; b=TZNKCYrDV6Kxy2Z9zdOY1bGENHZZsy7pizBcpfANXUiUYWvDvJmArk4Dj23tQokURFYl/SKxJ4l2esIYEQybwh4gkDWdp//KvNZ7nWugz9Nv8BDsddF4gv98xLTDd4pZ1RKzLcRwJJmciDWQKPxwacJvNUNRxLIsNCQf4nA6XMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758617631; c=relaxed/simple;
	bh=IDr13+9P/xyQPLKeFz5NvinsD8c35vkS685dDkOdbJw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bii+MXMDuicYXrrNGCnmUr0dYCCic1Qv8Y7d94zvxQ5P1LGWCxtkN+3aCoM0HGiUtAe1nOCUhJKDibf1btD40oFwLUIBZLvEBM2e+kUP4LuFWSq39MFr5TLOzeqGqdkivyNRl6BuQGCHfxlG1XbHN9eUFn3/q3vVgSzhFOprV9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PBNy1IWM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PBNy1IWM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1758617628;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IDr13+9P/xyQPLKeFz5NvinsD8c35vkS685dDkOdbJw=;
	b=PBNy1IWMqRl/bp9NzTDO+a1EXcuVEnPT36xRzgYGGKllR99VJeW6c2zWm2qimN09Zu9PfC
	8SUyV6vTsDBh/qsUyzx/3QYZDKpGi7I2KEDaKMrgeb6Jr9dMf46FWJwlAZ40ycqQatJLXJ
	AtW08qPG1lgVfBJRb6wlncgWo6QvXFQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-588-j3cPCK4CNbSNrt0WrKxf1w-1; Tue, 23 Sep 2025 04:53:45 -0400
X-MC-Unique: j3cPCK4CNbSNrt0WrKxf1w-1
X-Mimecast-MFC-AGG-ID: j3cPCK4CNbSNrt0WrKxf1w_1758617624
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-3f93db57449so1462018f8f.2
        for <linux-trace-kernel@vger.kernel.org>; Tue, 23 Sep 2025 01:53:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758617624; x=1759222424;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IDr13+9P/xyQPLKeFz5NvinsD8c35vkS685dDkOdbJw=;
        b=wY0XhFjYLhil48MX1zBomBqmWNjdMdkMzCds9P7FhATLgHuaVLhgxRK/xSDdNIPOJj
         9tVVtox6HEIERTZIohIpt17bj68AmWB8xBXb5akHpdvNMTGcKzwlCDgD6IUDcvgIMHD9
         ivkmY4HB7VzGLzS5d858Nz/9TY1ymPDvqk5A2tPCC6+D2nbU2PMg9PaR+EJXWhZrE2qm
         XUlIUgvMbuEyJqa6uX44cwFLK8UVE7NPuB2aX/GPosm69qMmggOPIh6gjU3RX5+jGH4H
         RpZ0qW7IQ5ShobzK5iIxmRvnJvWoIS8doPKEQEM89NPCYQnmDLc5ROw0Yp3NZA9MIU64
         XuAQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0eSqlZ/mJpUJPXfU9hHZ5JRu37E5Wa5tmIRupcVDKps+R8aIzZUveSIX+zWiwh4Wd5k/mNBOz0FCKxVwFdvku0MY=@vger.kernel.org
X-Gm-Message-State: AOJu0YweuUm/F1r9Z0XPx9gOwaSfL9hYNseZA1jCqRagfQLCgkbRUy1X
	h32VnU7+EXDdK3Dm1AZNiL3NTyADRep5zlbOQZNC3dSrmyFscGaVxQV+x39wuROEpAdQD/bheq3
	DfAei1CmNtUhgzG3YB5D7gu2mGx6LnthQ/+7QWsWv7mmwT12SgZD4hF87n/uhFhO2G12H+G8lZQ
	==
X-Gm-Gg: ASbGncslv0AzdberqRw8mImKvgA9ergrlVKUuJpKgaBkruk9DUyIyeB20yzz0RpDKQJ
	bz+yPk/vN3HSwS5o7HPu/kkcpUoBzJ0F5w+Zv9iPUdP+sKNcjK5A/CTWj8wSSzgw0mE00fVtgSQ
	P1M203luX+BzIdKjCr12Ot4ULY0ih6Vhbn5jE7SnKJeFmVVusVEe33OCsrx0oPV2TEGVf2iB46r
	XPgNlzWub5ACa+qhgSEkohzLClLOytVY9pWTOGT+jdigrnkkYaHgz9kxQ8TER1V8JPaWENuKxDt
	rcgtanGxM1H9Hl6fxc4juO2yqynMcIsapMJkMask0CEF2d7+niXgZxcLWumFoPkAqA==
X-Received: by 2002:a05:6000:24c1:b0:3ec:6259:5079 with SMTP id ffacd0b85a97d-405c3e27214mr1398852f8f.11.1758617624434;
        Tue, 23 Sep 2025 01:53:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGmNgw03Gw/qT+lIFaSEPvx1AN5x3Gsl2XUuzd0nfG3uHKwNwtw6FDXXpL2sgdZACnvgNCUMA==
X-Received: by 2002:a05:6000:24c1:b0:3ec:6259:5079 with SMTP id ffacd0b85a97d-405c3e27214mr1398830f8f.11.1758617623996;
        Tue, 23 Sep 2025 01:53:43 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.42])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3ee106fd0edsm22412244f8f.53.2025.09.23.01.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Sep 2025 01:53:43 -0700 (PDT)
Message-ID: <f073ef06d9d6b37b10a2800c91238f9da573efa2.camel@redhat.com>
Subject: Re: [PATCH] rv: Fix wrong type cast in enabled_monitors_next()
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Nathan Chancellor <nathan@kernel.org>, Steven Rostedt
 <rostedt@goodmis.org>,  Masami Hiramatsu <mhiramat@kernel.org>, Mathieu
 Desnoyers <mathieu.desnoyers@efficios.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Tue, 23 Sep 2025 10:53:41 +0200
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
X-Mimecast-MFC-PROC-ID: vQYDhiLohIxTCipanrDw9vz5GprHbZl4dCUZh-cYjmY_1758617624
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, 2025-09-23 at 10:44 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Looks reasonable, can you work on the fix?
> > I see Steve is out for conferences so this won't be too urgent.
>=20
> The fix is in my previous email.
>=20
> I am guessing your email client is hiding the diff from you ;) (among
> wrapping quoted reply, but that's not too important).

Uh, that's my brain ignoring what's under the signature, need to look for a=
n
update to that..

Going to test it.

Thanks,
Gabriele

