Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C685C322C90
	for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 10:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755600409; cv=none; b=WXwGPlJwM6P6dEI3hTsyX1Nkj30akpuBylcWkibhFPOwwcpfd9g9n0bqp7H9KMe+HbETzvPe6wb2d8hh6Kz9fgwwIzmFvhEFNHPaF6IkFc4P/D1le74cX3LAXOAB2x9wbbnwKjoBo2JKeAJR4TSWY8vdWtoVwUc0+AwAltTDGsI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755600409; c=relaxed/simple;
	bh=r4B/ot7MjRShDSDDd6YR/OaaVYlu09mqe1Jx2xzI1IY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUpaVljv7XkxNYcVE68fcnP95yiKVzDW9mu7qAwDnQnk7SCpav98wKyXa3kMgHPpaPfFvaGwx8FceFUnfnZPye1ynSWqcPe78RQ9i+bWLEXWKQHzM/6m2RNsVs8vDiw8xRziS1D6/+nYZTG5UGRUab1dIgbvQ8gv+fKVdrkGN5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JPqEo3dl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPqEo3dl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1755600406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=r4B/ot7MjRShDSDDd6YR/OaaVYlu09mqe1Jx2xzI1IY=;
	b=JPqEo3dldohjjQ8KsvvBIr9cSa7VxlonFvkukRV9Hidi0di7vCGJ9tnBUGUr7lOCxGbiyn
	pY42n3lNNOs9R/ryeFH1taQ8zbAShUsvYXV0dILQNKxTjYCnwY7dtTFC9ufR91XaCenTdc
	P09NR+CuWmj1aM9xnamF8XWNOP5QQVc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-MNvM01wEPqyb4KqkmYwxNg-1; Tue, 19 Aug 2025 06:46:45 -0400
X-MC-Unique: MNvM01wEPqyb4KqkmYwxNg-1
X-Mimecast-MFC-AGG-ID: MNvM01wEPqyb4KqkmYwxNg_1755600405
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7e8704ea619so1520510585a.1
        for <linux-trace-kernel@vger.kernel.org>; Tue, 19 Aug 2025 03:46:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755600405; x=1756205205;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ya9rYpVnEq1bqrzAsmHksoTnC8P3FflAlqr+wlwGFI4=;
        b=d1HyhK1m4fyeNfZCeXIjyJTf7C4AxQ+FXZW9PMcnnY7V5Tzncb/ZumW8p9ipj5oNVZ
         W/VqvKrqI3RLHKXrhUBNDBBHTe8qhQ0w6NIXp8AkK1ab4c5Tyu3Gq5kcHOJVbOT7PkxN
         4q9d2KEw1sbz497pSOvMkICki54pDQcWeoiSxbaJzB9pBC9MkKDu7ZUxCcX4R+vlIoL7
         U51i1lA6RkS92X6rsvAFHPff73k252MiQplQcAFuI1OnFKcFQbHmKMj8Xy4xG3zq1GTZ
         enS8GI6ZsLS4V6l4Ml+YIG2GNm7XVPrs6r5kOLyefBYmvr7GnA52B6YStR0MxfyRQl7z
         IJwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUarxbrTF08PetVi+eVeEEOnfYN3oHMks/tIaJe5X7GH+7P6h1YrOcEUCJDacymz1SBQgkZRZVcArAsUIQXqK4blxQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiIKj/4zpD5Fu3FMSRHrVHdcdj71RLp4fc5bRiTpsfic554k1q
	OsgOMr+NDiKCYKDjS9btVj1zjubbWKcGoAorY+YU9WC9LpJkGBr0QAUkp5BXIfB9Wl5GMBQ9Q0M
	qO8BaQYVhDzNf5k9xe/6gbpNEzpGOPXXC4Cd7qtvLj1QXyDsNVrcxFCQkUAqNmxbjPbnh/MTU+Q
	==
X-Gm-Gg: ASbGncsnvgx95e7obtgOjHpHRX7JCqgrAL+maXZ3WbyGLdRLTBguJhJnnriTdfMQ05g
	v2YngqdhFvuILAcLPASnh8dy6gFl/8zQGT4sXWE0/ajDFZbRtd3oslP6kwDHR96Si0mu5zcf9HY
	A7aIh4+aifuDXzjbbkAM9ZO9IvSBZe4ZXwa77uLUrNro/QaVlvxYovy7TsMFtlvPh4MQmTguICg
	A5Gtf0/LTGnk88O8Z4k7BEVX2w66fz0hn+LlXUoqcZ+h2f96z4ww1YUjV4utEnL8dNyTpwQ4GTV
	Eg6JuQMHuoC084INbMl5YNM1kBDSAD/EfTiFSyEe2QLytNe5z9zQ4kHQlSc085BUyA==
X-Received: by 2002:a05:620a:17a3:b0:7e8:34b0:6e07 with SMTP id af79cd13be357-7e9f330d21emr238066085a.7.1755600404734;
        Tue, 19 Aug 2025 03:46:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGePi7pyFUeDcLopu06z03bZieJKd0N149MulemJ5fyts6v+HbKw6uGpTSN7vDff4vEX0HHQw==
X-Received: by 2002:a05:620a:17a3:b0:7e8:34b0:6e07 with SMTP id af79cd13be357-7e9f330d21emr238063685a.7.1755600404307;
        Tue, 19 Aug 2025 03:46:44 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-70ba95cd49asm66838496d6.76.2025.08.19.03.46.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Aug 2025 03:46:44 -0700 (PDT)
Message-ID: <2e4ee3715146262df549b177ed6534129b827f09.camel@redhat.com>
Subject: Re: [RFC PATCH 11/17] Documentation/rv: Add documentation about
 hybrid automata
From: Gabriele Monaco <gmonaco@redhat.com>
To: Juri Lelli <juri.lelli@redhat.com>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Corbet	 <corbet@lwn.net>, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org,  Nam Cao <namcao@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>,  Clark Williams
 <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Tue, 19 Aug 2025 12:46:40 +0200
In-Reply-To: <aKRAeOakjiwmgML_@jlelli-thinkpadt14gen4.remote.csb>
References: <20250814150809.140739-1-gmonaco@redhat.com>
	 <20250814150809.140739-12-gmonaco@redhat.com>
	 <aKQ7iaSb9GGUtuCZ@jlelli-thinkpadt14gen4.remote.csb>
	 <aKRAeOakjiwmgML_@jlelli-thinkpadt14gen4.remote.csb>
Autocrypt: addr=gmonaco@redhat.com; prefer-encrypt=mutual;
 keydata=mDMEZuK5YxYJKwYBBAHaRw8BAQdAmJ3dM9Sz6/Hodu33Qrf8QH2bNeNbOikqYtxWFLVm0
 1a0JEdhYnJpZWxlIE1vbmFjbyA8Z21vbmFjb0ByZWRoYXQuY29tPoiZBBMWCgBBFiEEysoR+AuB3R
 Zwp6j270psSVh4TfIFAmbiuWMCGwMFCQWjmoAFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgk
 Q70psSVh4TfJzZgD/TXjnqCyqaZH/Y2w+YVbvm93WX2eqBqiVZ6VEjTuGNs8A/iPrKbzdWC7AicnK
 xyhmqeUWOzFx5P43S1E1dhsrLWgP
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zD8kH2OHUL8MKH00ruWUEGcNvy47QO0ZUdI0bqFPe1w_1755600405
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Tue, 2025-08-19 at 11:14 +0200, Juri Lelli wrote:
> On 19/08/25 10:53, Juri Lelli wrote:
> > Hi!
> >=20
> > On 14/08/25 17:08, Gabriele Monaco wrote:
>=20
> ...
>=20
> > > +=C2=A0 static bool verify_constraint(enum states curr_state, enum
> > > events event,
> > > +=09=09=09=09 enum states next_state)
> > > +=C2=A0 {
> > > +=09bool res =3D true;
> > > +
> > > +=09/* Validate guards as part of f */
> > > +=09if (curr_state =3D=3D enqueued && event =3D=3D sched_switch_in)
> > > +=09=09res =3D get_env(clk) < threshold;
> > > +=09else if (curr_state =3D=3D dequeued && event =3D=3D
> > > sched_wakeup)
> > > +=09=09reset_env(clk);
> > > +
> > > +=09/* Validate invariants in i */
> > > +=09if (next_state =3D=3D curr_state)
> > > +=09=09return res;
> > > +=09if (next_state =3D=3D enqueued && res)
> > > +=09=09start_timer(clk, threshold);
> >=20
> > So, then the timer callback checks the invariant and possibly
> > reports failure?
>=20
> Ah, OK. The 'standard' ha_monitor_timer_callback just reports failure
> (react) in case the timer fires. Which makes sense as at that point
> the invariant is broken. Maybe add some wording to highlight this?

Yeah indeed. That isn't even the 'standard' one as it isn't explicitly
configurable, but yes, at the expiration the invariant is already false
(I currently don't support AND/OR conditions in there).

I should make all this process clear, especially that those state
constraints are the only ones arming a timer and leaving the state
after that expiration (if the callback didn't run) or going through the
expiration itself implies a failure.

Thanks for pointing it out!
Gabriele

