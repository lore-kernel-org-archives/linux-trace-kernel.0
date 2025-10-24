Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 295FF207A22
	for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 09:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761297637; cv=none; b=PP9S1SOP+A0DIFmpLnOCDAn7WOcXg+VSARHEHynvJLZMfzpFP/zMMEPLhHPk1SyRA8OghurkpV6wmqn2ZKonVMkUlFsg0CQHm6K872IfFx842IIM570K1JVf8GU9HMIodXGktUOByekLl/Qe7jMJbp1mUrXHvUibdbg0vLFu2s0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761297637; c=relaxed/simple;
	bh=KRYLOMYrQ3kyftsmR2kiak9aO8LPXyN+XNVOuRc41dY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZBCfzFPAzEOdf/LvR+bCVHuRSdF0hRIJXo9txYeAUsX+onDgT/K0uGfqYLV526CUeYHfnmISvE0APZe0gQnR6ADAPs0aOiQzDrjKhQEuqIuz/wczt1G7s03y00oIARP77HCjbueqVLEWNZM9imMr4cK6GoVJ31JlgIxKoEZb8wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BjUxcFk1; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BjUxcFk1"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761297635;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KRYLOMYrQ3kyftsmR2kiak9aO8LPXyN+XNVOuRc41dY=;
	b=BjUxcFk1YByUiwbMMaATMl0JbLinKT6N2RU6VJ3AEg5lc6WJnM6d6p/YuUxRLN8qSPqTXv
	tth0r3ozsdyJqPuWkjypnrd9AKPfULV4rdI64Cdl7Yd2Qoh8UKbmWYJnrGkTpC8jMLeJws
	lVzaTdpb+1XUxM9b4Nd2mpc1Q4luRiY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-moFfL20vMjOpivV_E8Ipow-1; Fri, 24 Oct 2025 05:20:33 -0400
X-MC-Unique: moFfL20vMjOpivV_E8Ipow-1
X-Mimecast-MFC-AGG-ID: moFfL20vMjOpivV_E8Ipow_1761297632
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-426d4f59cbcso2016176f8f.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 24 Oct 2025 02:20:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761297632; x=1761902432;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KRYLOMYrQ3kyftsmR2kiak9aO8LPXyN+XNVOuRc41dY=;
        b=ib1reewSSxH130V1fjSA8JSo75SzCzkM5aOkngbVx04C4WMQ8o4CoPjDeBQqVX4yaa
         MQoD/fha/2lVnGGYhCEGuwviZ9vX+Vm7W41xIhY9+x/6ZU48Kxe0EmI/8u2KdU1EiIAM
         E8ObC26FaGuqwakSdKxM/RME/1BxHDUbhI6uPFTwsWvset5MErtE+boSfvd8nvmF8NgZ
         KyZSHtvfZEpY6ydkfmNQMLk3LMMp+As8VaMMae+lOD54XglbI208fl675v36m3J0pA5v
         NURKKRYG4GM9Ora7OUUBizDVfersOo5sC9j7OkV028GzrxN4+CxE91YaEYoWRYaq5wfs
         b38Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIXBivWJ2t3Ldg/zSqDzns7zLpRbHZKtjAPxjDVSd7j9iTf0JLUY5UGNXW/h9QxVUGVdRU+lsi3zcUen6b83oQ1is=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/V/8DxEi7A1W9s/qP9i8eb2f9gQd/vLFk3u12AE3+I98xO44f
	2TlWvsEgFpORFYPv1eD0H+EWtLHJHZ+2n3RJ99QnL6fTJ6sIH/s6Ue0hl2Kb3bGUuSb55ZN9kvb
	YMNwJOObAcRHB914UdLgDniMwmPLGTGZwfLGyQvqQ4lo+s+8r9KgrQGMvoXRFWBLmGbsml1ysOQ
	==
X-Gm-Gg: ASbGncs2F7Jw+1OppkaRx2uouYxghxr3i4aBFKBJJT9+jFa6JDRJ6Ndm1XreaCBmrIQ
	vzfLxdlarKvdt29PkkpY1c3jcWGqw0hlFetZ/wvZJAoTcc+lCJwZZLZmTAsUIAxSLxFQHGxAR8p
	VFpmynTQOD9XYHgBve2mn75P/6+84hTLQcwBcYt2MA/YBTq4hrKE1PbhYSL1Zn73j6uOGzWOXKw
	bz2Hv6B0rbC5WLJS3Yfoc/w9jkAcAWzFXR7aNIUYDkDr7epU9mFAKjR0yfTlAWwJBYqdryVTAIG
	Yg71Qj2BMDdteRLey+8SHJUYe94Ld8MN6PXdUJTvVReyVl7que5XOtKOXjgqACbFFqDzOrLWAtD
	JIADpFCV8GdfI87bYNEf8CXJb
X-Received: by 2002:a05:6000:2209:b0:427:67b:b385 with SMTP id ffacd0b85a97d-4298f5284e0mr1475121f8f.11.1761297632388;
        Fri, 24 Oct 2025 02:20:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IENJCKEMSHznuwRnoZo8gIjMg1xMxlZlosiTdgr3BzAFIk2sdQW9RZpNtz+ul6TzEjTgkBYBw==
X-Received: by 2002:a05:6000:2209:b0:427:67b:b385 with SMTP id ffacd0b85a97d-4298f5284e0mr1475098f8f.11.1761297632034;
        Fri, 24 Oct 2025 02:20:32 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429898ccd88sm9981862f8f.36.2025.10.24.02.20.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 02:20:31 -0700 (PDT)
Message-ID: <89c01961393210e3623b6d556e722f145d6cd557.camel@redhat.com>
Subject: Re: [PATCH v2 18/20] rv: Add support for per-object monitors in
 DA/HA
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, linux-trace-kernel@vger.kernel.org
Cc: Tomas Glozar <tglozar@redhat.com>, Juri Lelli <jlelli@redhat.com>, Clark
 Williams <williams@redhat.com>, John Kacur <jkacur@redhat.com>
Date: Fri, 24 Oct 2025 11:20:30 +0200
In-Reply-To: <87bjlxokvx.fsf@yellow.woof>
References: <20250919140954.104920-1-gmonaco@redhat.com>
	 <20250919140954.104920-19-gmonaco@redhat.com> <87plag1nb6.fsf@yellow.woof>
	 <866f10440f9edde8acd34e5a5d2965719ae5d723.camel@redhat.com>
	 <87bjlxokvx.fsf@yellow.woof>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: HCSyU2wuqG7NSN1y9zJmeCiKSWHx7SV3KngVk-BUMl4_1761297632
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-10-23 at 14:36 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Ignoring the vagueness of the name, the two implementations of this hoo=
k are
> > to call an allocation (yes, always conditionally) or just assign the ta=
rget
> > to a pre-allocated storage.
> > Your suggestion of da_monitor_prepare_storage might fit both descriptio=
ns.
>=20
> Now that I have grasped (or at least I think so) the patches, it is not
> that important to me anymore. But still, having function names which
> precisely describe what they do would help new people understand the code=
.

Agree, I'm going to use more meaningful function names. Apparently the
kmalloc_nolock is still getting lockdep complain on RT kernels so I'm going=
 to
keep this skip-preallocation logic as it is, hopefully just clearer.

Thanks,
Gabriele

