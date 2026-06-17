Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8818544CADF
	for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 16:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781712882; cv=none; b=afquGD2bTxdBWJwfrNNcpFU4S8N/tNRkpqbXM1VIAVRsjYat79VlpdvK0dSPDW7kQSmWwd3Gu408qwnjbkRd4JAzLbgcpXI5jEOgu8vjBxrxIY1GGLkXLwCPi4NOaI2bDNaPPPmYBWYiNXVE3mIckL1ZWlKKNtj2I/WJyxPfh+A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781712882; c=relaxed/simple;
	bh=CcP751lFJjX1ZP29fTmSaaIFSkAsoDmAg36EJIRXHA0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f0hg3HgT1mtgWa723uZHq/9jRaffED2g1iRJyw3GWnRDCfel5mZXUlV0ecczKltElvT6LjRHkA1sz7EmIKHbenFJxzhOaYwhgB+RZ3I3I9PCx4MoG1huij1K13eTWE2DM5IEkwiWULjt6lH3OQ6xONzKxRt+keuHzMikHo062zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=K5v4sPB4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="K5v4sPB4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781712873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CcP751lFJjX1ZP29fTmSaaIFSkAsoDmAg36EJIRXHA0=;
	b=K5v4sPB4rTfqgNxSQMZR93aWj+woChdnE31IemJOpX+KGkzjEWQ6oADm7jeti+urqGfCl1
	3iLSsgisZZPfgGFOcoJMOm/7iIr3H9n8dP1Wj9mh07eDPGoJ+SBAjw+eUlRGiXqDhJ76kp
	MrEVcgm29+tuhEVdS+IOMXLdIijRJW8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-408-I7nr7KYvNGWR26CEeQ5f8g-1; Wed, 17 Jun 2026 12:14:32 -0400
X-MC-Unique: I7nr7KYvNGWR26CEeQ5f8g-1
X-Mimecast-MFC-AGG-ID: I7nr7KYvNGWR26CEeQ5f8g_1781712871
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-46315372c3eso9730f8f.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 17 Jun 2026 09:14:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781712871; x=1782317671;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CcP751lFJjX1ZP29fTmSaaIFSkAsoDmAg36EJIRXHA0=;
        b=q4xrkF1VvMJZz706OiZgU9PmCJwX2GKBEJ8e32eG7hr2+Vq0TAF2Yq+eXkp3z3LvLx
         2mSLxrxSShEno7Vk53CDHYYCezWNJMwfC7+JkpVg5SI7WeXU27yflUoUunEao4CtyjkP
         7KiPSYP+RRw/TRhUi3y6vXC6FvVra0PguXCKVA6bbL0NJ+/nvQgNmX1e/0haCn972Trh
         cLkK7u2OqHjK+tb4t8J3mj7xuxtOCdPnDekCbTvd6Gd3SnDNZvm+mE3lg+1YKrV9GaHK
         1laFu3gzpl+Yjd2iPEHftKCqBbdw4QrQhu0TCrbAuTTr+JfxC7APeVHLuMKzs0lzd8pV
         v5yg==
X-Gm-Message-State: AOJu0YwHXwuwUNrU0gWiJUNHQMjPOkBuKOJC66SBydmSAFrQ6y+fnk+Y
	LIZkDhQIWxIoiijWzgSMZH/boruWm+hY6S2hgrEG71mZLvykv2qIkbFD+vsBFe7fuwHwBFcOfk5
	Ib1zvqIZCJiJ9q//bzJ9TYLZi1ae6jMQbwMFC9K8VMvv68b1uRDwZ8IuPsqB5Gs1wQog04sxJ/w
	==
X-Gm-Gg: Acq92OEyMLE1hFYKuuGLo1peZC879ErgxJ4IaL5Dp4WX0R+idRd0aOHC+/BtLEvjI3g
	2I0vqkcgh+nK5L5hTUVyGWf76Bclvv0DPMwiXb6B3Y/0npj/QBfHz3q1cK7dRYvXdjINkKy0hut
	akPi6NwBoXcFDtmSXLzdytZIh96DVRyuMF3ri8xlxhMsDxdciAmX+pxv/xZQRIO9LR64rGQV4VB
	L+aJ0B426PTMyyW0c2ThFVdg4ukVzSrEnQdNPjDiFKPPFNr4R+UtclNHD8pNQYBn2axk7CekuW1
	lan1NUNwua4hLWMNrnIWk54uONBYRW6T8u311QFofSEv6b/ZU69+PZB90dOi7pO+jlfBmsDwWrC
	W2t9a80NKCNCX+eQ=
X-Received: by 2002:a05:600c:1e0f:b0:490:e5c1:b88d with SMTP id 5b1f17b1804b1-492333babfbmr86664105e9.1.1781712870826;
        Wed, 17 Jun 2026 09:14:30 -0700 (PDT)
X-Received: by 2002:a05:600c:1e0f:b0:490:e5c1:b88d with SMTP id 5b1f17b1804b1-492333babfbmr86663565e9.1.1781712870373;
        Wed, 17 Jun 2026 09:14:30 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4922fa510e7sm208072825e9.7.2026.06.17.09.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Jun 2026 09:14:29 -0700 (PDT)
Message-ID: <011cf25d84525949547299c9fc179e7dfa33018e.camel@redhat.com>
Subject: Re: [PATCH 0/3] rv/reactors: fix lockdep warning and add KUnit tests
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>, wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Wed, 17 Jun 2026 18:14:27 +0200
In-Reply-To: <874ij16u6i.fsf@yellow.woof>
References: <cover.1781541556.git.wen.yang@linux.dev>
	 <2bcfa0bda551c0e1ba137b728dbe7886ff5c2579.camel@redhat.com>
	 <874ij16u6i.fsf@yellow.woof>
User-Agent: Evolution 3.60.2 (3.60.2-1.fc44)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: TIy7TLg2jZUFnEoJJ3kgnojb1jrtwvCHxf0fzIze0IY_1781712871
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2026-06-17 at 17:52 +0200, Nam Cao wrote:
> Gabriele Monaco <gmonaco@redhat.com> writes:
> > Are those tests supposed to trigger this issue though? Under what
> > configuration?
> >=20
> > I reverted the lockdep fix and run the tests in vng on both x86_64
> > and arm64, both preempt_rt and not but I see no splat.
> > Repeating the tests multiple times from debugfs also didn't seem to
> > help. Both machines were relatively large (128 and 48 CPUs).
> >=20
> > The config was the bare vng one with kunit built-in, lockdep and
> > the reactors tests.
> >=20
> > What am I missing?
>=20
> I haven't tried to reproduce it, but seems quite rare. From the look
> of it, adding some delay into the reactor function should make the
> issue more easily reproducible.

Yeah the tests should be doing that, but even increasing the delay
didn't help. I should probably try on physical machines to have more
likely interrupts but at least the tick should be running.

