Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC111F583B
	for <linux-trace-kernel@vger.kernel.org>; Tue,  4 Mar 2025 08:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741075462; cv=none; b=AvPqb9Jd4OmlzdW1aIYiZt4QeGyA1ugpYNGAt6S7B0pXqmIJEOdUg5zON4HbtMN2x1zqqHywfp4ziDtbFBd3b/yXu5PzleKb2Co9usZEGg6y9yMoZGcUghANBzZr6cCSJ0v6prQukTmHoH8DxjjD9Z8b7H31cWRwhC6SuD7PoUA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741075462; c=relaxed/simple;
	bh=sAzTUkskqFANm/ZL5XzhKxmHu1rE7O5U8eewvrLoL4o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SyxophRR9Nlx/ecoMBEVCNVpaMbyPnnhh1ezvwlhdLYPucpl69meHpclgeI5kgLPOlpzWiRUikPF8+VA4RJSCY8k0iopJV43l+Pk+wro0Ew7RVpIeifxabsiH0gP54PWOMRNKU/ScBrAAQ6bytt3oG2KPyL0PMOWmx2z2Jb+1oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PE46XIde; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PE46XIde"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1741075458;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAzTUkskqFANm/ZL5XzhKxmHu1rE7O5U8eewvrLoL4o=;
	b=PE46XIdeRzaI2cGRXREYG4ytTQqr9+sSJAZhhxjMOnhjJ9hnM0MSrX84k4R8C7mlCqI7mV
	C6sB1wWfNm0TJCU7l/afOfzQ2cj++3OtlOofEt6QZ21xlB03ssO5HXJp0hxhyV20hv24C5
	vtRgsgh1A9pqUJ7rcbi+pYyywGAvLdU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-261-lCKCEY5NOvygwM3TLMyNIg-1; Tue, 04 Mar 2025 03:04:07 -0500
X-MC-Unique: lCKCEY5NOvygwM3TLMyNIg-1
X-Mimecast-MFC-AGG-ID: lCKCEY5NOvygwM3TLMyNIg_1741075447
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-abf748e5f18so220915166b.0
        for <linux-trace-kernel@vger.kernel.org>; Tue, 04 Mar 2025 00:04:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741075447; x=1741680247;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sAzTUkskqFANm/ZL5XzhKxmHu1rE7O5U8eewvrLoL4o=;
        b=Ju6zQsOxMKYO1cJ/UMQrMnsMAlAEe4Fl54oYFvFQk5fS+c8+vel5kaiUZfkHKYyt/b
         glxuf3K4H5vI4A62XzirkqIkBW5B+CwjPMjO9M+L0nf4D/Zg/X3CSUCvzFSHuYQNKFxg
         7P74/pwUeZaHq7l5VgvtHDubCVIyptLCy71aAsjqMZYI5ums4uQG/zRNYtGhqz2TqpYK
         rOry6nKVXcPc32Mo52fAMThdcel39VqDKg0BN2Fl/Mx4jNXqIe9oDXSU5f7eaFVoyWHp
         EkLQmgdMsvfFBsxrIvSRXLorj1Fz1dyun5L49LkFwogX9TiD+AvZTrNPxuCu4VjTO1Tc
         Wx+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWOliEOcB3crcZKwq13eSxqka7JUmBgY/wUoTucejVQlJwqSOY2Zc2TX2NGSkGLIC15Y+0c/m3LbKA9zdbiSGgrgGI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIenHmgIdayLPGGVnSIi+fSieCrnfqsVTMFpZMn4u/kHhm88XN
	U49WbqaFMK4uHkeV9e8vu4hnfYLtdX+Mskd9f3d6TWFwdib6Y6GsjcAN/xpfUXeYIfFNKcEPwMk
	1eES99ANjgFOnaxaQ6tIv8iEWuUfdhD7CejEWixmTcUZI4SkQaT/7KpjEL7/jojtW3xwzfT6E/I
	hwSQ/U7Fe7nEtfy0udvrLdhYB0HzaDmCeN79D7biSstChn
X-Gm-Gg: ASbGncvfEI9rpdV4cPIYr7EKU6Fca+tyeN5Ay1eKa9anmUl0wSyszXP0xj5ZBf/y0b3
	m1wK2We9R+KviXykqkoNSuZhfxrj05QJNQTzFv2hBxMruyJyW6o0Omj4PnN6Y2JlDeWX4s5r3
X-Received: by 2002:a17:906:f5a7:b0:abf:5778:f93e with SMTP id a640c23a62f3a-ac1f11e1e49mr196575166b.20.1741075446664;
        Tue, 04 Mar 2025 00:04:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGMlvQhJSMa3o5MDPkih10cYTXXoBgWdsfMBlBzK4PZOMAtrxmS3ejEm6Rb9oGBns3LDIQ87ekx3ly/gV77Hao=
X-Received: by 2002:a17:906:f5a7:b0:abf:5778:f93e with SMTP id
 a640c23a62f3a-ac1f11e1e49mr196573466b.20.1741075446350; Tue, 04 Mar 2025
 00:04:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250127170251.744751-1-costa.shul@redhat.com>
 <20250227200623.60f20571@gandalf.local.home> <CAP4=nvQXaFmemBeW8U3U9zTMK0gVYvp23gfq_6ALsBJPTXt9Uw@mail.gmail.com>
 <CADDUTFwyMt5zFqWeKXXiECOeqeyZ46fJcc4-ff=rjccsMDHKSQ@mail.gmail.com>
In-Reply-To: <CADDUTFwyMt5zFqWeKXXiECOeqeyZ46fJcc4-ff=rjccsMDHKSQ@mail.gmail.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Tue, 4 Mar 2025 09:03:55 +0100
X-Gm-Features: AQ5f1Jp8s1Qa4Hjbj_2ILgoonOOrXdtSK1KX8J9VpSATDK0_36Dw6hYizV0UtBI
Message-ID: <CAP4=nvRtY+kEzxW9Lj2uSYZuFhuESbYs3yj0oq6resyuWVHjjQ@mail.gmail.com>
Subject: Re: [PATCH v1] rtla: Save trace when option `--trace` is specified
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: JX75Z2R0HEjTmKZJtqUHWbXUk3TRhmsU1U8WX_D_09Y_1741075447
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

po 3. 3. 2025 v 16:55 odes=C3=ADlatel Costa Shulyupin <costa.shul@redhat.co=
m> napsal:
>
> Actually trace collection can be performed using just trace-cmd start,
> trace-cmd stop, and trace-cmd extract.
>

Yes, but that does not necessarily mean we cannot add it to rtla, too;
we already do that e.g. for event histograms, which you could also
replace with trace-cmd. It has the benefit of synchronizing the
start/stop of the trace collection with the osnoise/timerlat tracer.

Tomas

