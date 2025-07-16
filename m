Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552762857E2
	for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 08:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752656392; cv=none; b=nfPH+9iG3czGuVc7yX8T0Chs/U4TSAPz8ReW2iqjELwtbJW8cK+vqEddRri1Rsp2K9sOwQlJpSgkyomI8Gr1uvEQ7F9JKuFXa+fQSX8jyXBjYXWo0CUBQNHuqVqvv3I3kiNtyDCwJutVSTIKc+lrntcEtLRMKjcDUmbIs/C+Vro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752656392; c=relaxed/simple;
	bh=rYiazEuw3scjsu8vgivyrSqTbYtX4ZfFIDqZ6D7u1m8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hF0aJfpEBeUqLh2bXNBqyZX0jlI0NwumsWuI1JIXUYhshrXn2PGbFOAdnft2dhyd/6zh9a0RojjyAiSr849lTvmq1gh21QUp01rOj4nyQJ8nev9W8VXjb1062NSRjO41wkw2l7v8P/A1wdbLOTLFbRGEK77eA8GTxk8jFlwr0Q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=KNIbr+GN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="KNIbr+GN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1752656390;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=rYiazEuw3scjsu8vgivyrSqTbYtX4ZfFIDqZ6D7u1m8=;
	b=KNIbr+GNaaOWfNToA6UArZBpkqayNpewOefffu/jkHUszEJFOMn49KlnncLffaYmTYfibm
	OokT+NukEr/0Do08TyXMtOJp2rKx/LmFttVyKOUvwHCsWwAitZB7vUGjZ88AOMR8O8U6eY
	FwU98VfynXqDDtFb2b5iFlcuFxpToBc=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-610-LaCJapV-MKaIEAvMDy2Omg-1; Wed, 16 Jul 2025 04:59:48 -0400
X-MC-Unique: LaCJapV-MKaIEAvMDy2Omg-1
X-Mimecast-MFC-AGG-ID: LaCJapV-MKaIEAvMDy2Omg_1752656387
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-455ea9cb0beso39527155e9.0
        for <linux-trace-kernel@vger.kernel.org>; Wed, 16 Jul 2025 01:59:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752656387; x=1753261187;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rYiazEuw3scjsu8vgivyrSqTbYtX4ZfFIDqZ6D7u1m8=;
        b=kxfBV67LyO4avpumZMEVDlYZvzTRuKV4ho3hqBRL3bZGxiIR0S6mv1LLTtgrD2Q0D4
         2SW8k4gxxtD8475wCNpdbMURnnbGbfJsJM+9syte7FMVRaPgKcFZ8+8U6ONQ/QffwdIm
         /MrPd8atkxMy4Wmo4amXRz9ne12OsBx2rl18Sc5uayHVEvbeIhX/Qg58MUxSQ9RpyooD
         Wj3ROJu1uDNeInbbappv4QaCrCAiOICwffzOxQ6LHuM3K9Y7fCAG/kbyGSzlUPkYCJYm
         nepi+MvNcQPV9x5ifpRAbJZfc1lftK9BwRgreUmo61yKG891d9L/QIWiAxOfy4G4P8Wt
         eWxw==
X-Forwarded-Encrypted: i=1; AJvYcCU10dTWndUgChLbIGrTQBij3vWHwBlNPjj92DgzVxv4jDjHiZOsPCLrBjRa/cEk054X5cIsKWGuwqSvDgSg3b4R+x0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pqPrlT0ohlO4i/WBaQNoffss/6xpkOLE9iZSIk0ykkuftn1U
	rohxdm3tk3bCEZQLUAYyeF7Opt4fJu1s7Tbe9Tntzy9f678tWgO7sC+FPx5IJsSVT9Nxt1s+GD8
	+T8+eTR2f+HkIK2+QqR2oR1okKWRdZydrSDp1YL/SmT5T0d8IFIqO62xICjdItUa/GTeTeT9NKQ
	==
X-Gm-Gg: ASbGnctTS/lEE5449iPe1OJxenQ8jnIoQLpHg0t8NdLX2HW57qKXZVoBCrUoiuja/3z
	foc8U9HBeoJ8YqRPJXkAOyNLm8fGj+aTo6P/AsF6HBMxoPBYhIJocD65VIeSCoWmTKZoIaJ6ife
	eJvM+7E1IvkZ7ZVK3KsOW+jJYYwbLs66j/fSRoz9SBtgV7VnWvCnH/xD4scNhQqptOkAq23cOxv
	eOpqSIPNFsBrtDERIrSR24tKLvyffHmqqUaL6fWLILjavlT0fDaYp6bh4p9ygW/Mxj1csB3MRm8
	Cq/17WLLRhq3ILEmYgQ9A2DjCrxKUhqMMfSFO6I9IeH88nqEbMA7lU3rU5uXR4HUiw==
X-Received: by 2002:a05:600c:5486:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-4562e39b9a1mr20121725e9.16.1752656387490;
        Wed, 16 Jul 2025 01:59:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGvh4XGqgjiXRNpbWt+0e4yPX9fyRdtuorAJBNJIz/t3WeV48Yv6FM74WTtdQhrUxK0tGt86A==
X-Received: by 2002:a05:600c:5486:b0:453:2066:4a26 with SMTP id 5b1f17b1804b1-4562e39b9a1mr20121435e9.16.1752656387029;
        Wed, 16 Jul 2025 01:59:47 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b5e8e0dbddsm17513367f8f.63.2025.07.16.01.59.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jul 2025 01:59:46 -0700 (PDT)
Message-ID: <37bc7ab78b03f4e794a5466d9cc0a1e187e1ae72.camel@redhat.com>
Subject: Re: [PATCH v3 11/17] rv: Retry when da monitor detects race
 conditions
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-trace-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Tomas Glozar <tglozar@redhat.com>, Juri
 Lelli <jlelli@redhat.com>,  Clark Williams <williams@redhat.com>, John
 Kacur <jkacur@redhat.com>
Date: Wed, 16 Jul 2025 10:59:44 +0200
In-Reply-To: <20250716084520._QLbd5AY@linutronix.de>
References: <20250715071434.22508-1-gmonaco@redhat.com>
	 <20250715071434.22508-12-gmonaco@redhat.com>
	 <20250715152322.Os4lDq_B@linutronix.de>
	 <e2f4f8d372612cd61689b91562e73677599d08de.camel@redhat.com>
	 <20250716082712.L9z_ptHK@linutronix.de>
	 <f7028488e9d820848955de87ead3ec619fe5dbec.camel@redhat.com>
	 <20250716084520._QLbd5AY@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: j0G-SRlqoG6JQRcXomZ3hYUjbxQrHbOdQvbxhTV5NoE_1752656387
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable



On Wed, 2025-07-16 at 10:45 +0200, Nam Cao wrote:
> On Wed, Jul 16, 2025 at 10:38:11AM +0200, Gabriele Monaco wrote:
> > Yes you can, but I wouldn't do so silently.
>=20
> Why not? The absolute worst that we get, is the rare case where a bug
> appears at the exact same time. In that case, we would get a false
> negative.
>=20
> And I think that is really really rare.

Well, we wouldn't even know how rare it is because we don't track it!

It may be a harmless note but might also be a design flaw in the
monitor, so it should be possible to understand when it happens.

> Yes, if you really want to emit some sort of warning here, it should
> be
> absolutely clear that the monitor itself is having a hiccup, not the
> monitored kernel.

Yeah totally, not saying that other errors reported in the wild are
going to be necessarily the kernel's fault though ;)
But let's keep these cases separate going forward nonetheless.

Thanks,
Gabriele

