Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ADB2A8C1
	for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 10:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753956854; cv=none; b=N8Uh1BBun4Tj7DHP8rG3QLsLWBH+zVhEAJOiYovKBTsRhbTBP/fuv5Uqv32snuW5ePdRmVWDMmOyZdA1ejMMWgw1nmgmrzm2bRpCSX4stWEBrdXYdG0gemBeMWsB9KzFVzmVY+IxjnujmZHRhtbsQOmzdm3cft2JyYQeGekyUL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753956854; c=relaxed/simple;
	bh=QZoWBl3T0TycXy/pqm4y9tnGoZ3jS1+iI8pn4rcZWBg=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ws0ltP4myemKMx5QB8zwsS4OPjfBgFqc2TrRwmMWWhEmFactDHXL9vbkdnsqdafjH16pMWQG885aD9TX/gkBX3UKsIfRpxoL+ZKQ11qijjxtgx8xMeC2LyzrQWwI7ccuYeEX+53aaEnus1A/KJWHP/FYFKCbP43VV8EXqamLvmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CRC4KVXM; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CRC4KVXM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753956851;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=QZoWBl3T0TycXy/pqm4y9tnGoZ3jS1+iI8pn4rcZWBg=;
	b=CRC4KVXMz6EjiJqJe0WRgx2wZC64LCeY9seKK0EFYsrIqn20ePWvpKbeIL/7HzOfjLqxTs
	0AOgcgZj7Ayx1qnMLtbQG5zDaCaU43IK7MfxFPrJMzygokz0+EiE7YRVtur4iZ8MU4Dq4F
	BTdQdV5qZafeCAcF+gGW9AlSSK/YQEU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-528-OnZOIqzmNNmSVGsgu1i4kA-1; Thu, 31 Jul 2025 06:14:08 -0400
X-MC-Unique: OnZOIqzmNNmSVGsgu1i4kA-1
X-Mimecast-MFC-AGG-ID: OnZOIqzmNNmSVGsgu1i4kA_1753956847
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3b81e16c17dso185001f8f.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 31 Jul 2025 03:14:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753956847; x=1754561647;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8+Updhps2Tis0Qkn63kABOeQ6kuHwuPfHE7bAxmojdA=;
        b=rfx9JC0h/rX3HCABmCCry0RfRIugHpum+XN85G7X7pVov1w88Rw11gZ7C1peQLs80E
         9KGaSof4IXikvRKYJlWV1EAVsPKkYHZZwX0PpvPeN8jPj6rsBq5YL+IIphEWbcHJM2Oz
         zbQXVCGOox+2fDutsVTeuYlpX5q0FxZrulRmp4jf5IeEptXTcre20oSColy5lC7BO561
         nrsTMyBQDqdZUITnQkScB5Wxm13F7kJFtL2u3vfRco+GM19LdyQZXXWVDcwXY8MT+9SC
         8DG1gT290yI4SmLQnrAuvFRglqGxSRWOVnauiKUEgPusYAS6Wo7su7I1wnEVbT668V7s
         8D5A==
X-Forwarded-Encrypted: i=1; AJvYcCW4pk6YMhcHBU1mHeScLYz9uiiJ3GL4ThAGKgmXX4xW9M917Uttn2Nrtw8QPBSIL7TDajuYq3onn0PbP1NhbZrkYRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyqi8G2TOrpzA6ia9y7GjNofuLgztfir9qsc9caaCnhdqMDCi/5
	gLNaGI8Lulh4P3AOL1f/SvRaA64PkikyjNS4lW5N9U1bV3ZmHJ2W8mTK07CYNoP1UBC/jWfeRzJ
	j5wd0y2NdcPPK6hMjIATyTAVjswiFwWvxAQHVpZCY5Gmol3U3mU0ccVK5VSDkkRM5y7EEbg/fIw
	==
X-Gm-Gg: ASbGncsNV53dxZx1peU0fe0vQB2sIJQWLLWMKZZRHENbN5dbTA5+Y2LquiIJ9PEtzeD
	z0Pah9YrIPzukePCS++eVvqh02rEQl4PrhBWYJUYQg3p6hrj2YRcF8KK81JGobCS7s50q883g+0
	t4q3SAmh4zI0yF52bwoT/y06wCSb52JuYljVGu8QWU0x/9Vd9pzpaCyvUxSGsYoM+zPFzJu+cqX
	I7BcW2zUiZClG2B+C3OTtkaMbAbJ6AjlLYB7Z+wMfH4Ionv9d0+DsPkNpzbxXGRyQFci65vlKnq
	NzRDvi1zrIpJiseXWJAf/ht2Bcua8Zxad1rkg6+RlKLBrqIt1avUoL1r8cBXEX5J8A==
X-Received: by 2002:a05:6000:24c2:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b794fd5d30mr5137415f8f.20.1753956847011;
        Thu, 31 Jul 2025 03:14:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+UBjxbRY7BvJmpX5xfoZYctE99KGpaavtNC5flkCkpYfIj5dzBaODgml3EnIDnCnFk50qEw==
X-Received: by 2002:a05:6000:24c2:b0:3b7:930a:bb0d with SMTP id ffacd0b85a97d-3b794fd5d30mr5137381f8f.20.1753956846474;
        Thu, 31 Jul 2025 03:14:06 -0700 (PDT)
Received: from gmonaco-thinkpadt14gen3.rmtit.csb ([185.107.56.40])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3b79c453c75sm1925032f8f.41.2025.07.31.03.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Jul 2025 03:14:05 -0700 (PDT)
Message-ID: <88f589e09328b907ff2dd3e58d1fe4fcc09dbb3c.camel@redhat.com>
Subject: Re: [PATCH 1/5] rv/ltl: Prepare for other monitor types
From: Gabriele Monaco <gmonaco@redhat.com>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>,  Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Thu, 31 Jul 2025 12:14:03 +0200
In-Reply-To: <20250731092805.EjcyYi0M@linutronix.de>
References: <cover.1753879295.git.namcao@linutronix.de>
	 <0d13c61bc6e0dc82108995c9a1d140bad4082039.1753879295.git.namcao@linutronix.de>
	 <adeb68b39e8b468da685bbbf3b453f947fe2336d.camel@redhat.com>
	 <20250731092805.EjcyYi0M@linutronix.de>
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
X-Mimecast-MFC-PROC-ID: vSWs0sHqvvwqGZ2g4bsXp03JXuYlraSdSDt3tjY87eg_1753956847
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2025-07-31 at 11:28 +0200, Nam Cao wrote:
> On Thu, Jul 31, 2025 at 11:04:44AM +0200, Gabriele Monaco wrote:
> > I stole your solution to get rid of macros for the DA as well
> > (might
> > post it after this merge window or with the next changes) and I'm
> > currently running with this:
>=20
> Nice, glad you like it.
>=20
> For global monitor, you could do
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 typdef struct {} monitor_target;
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0 static monitor_target rv_global_target;
>=20

Well, implicit monitors (cpu and global for DA) don't really have a
target but I'll probably be using this for other types if necessary or
in case I'm unifying things. Which might be nice, if it didn't require
modifying all per-cpu monitors (where CPU is not passed because the
current one is assumed).

> I didn't check clang, but gcc does not emit anything for this. So
> effectively the compiled code does not have the "target" parameter.
>=20
> > diff --git a/include/linux/rv.h b/include/linux/rv.h
> > index 14410a42faef..6a7594080db1 100644
> > --- a/include/linux/rv.h
> > +++ b/include/linux/rv.h
> > @@ -13,6 +13,10 @@
> > =C2=A0#define MAX_DA_NAME_LEN=09=09=0932
> > =C2=A0#define MAX_DA_RETRY_RACING_EVENTS=093
> > =C2=A0
> > +#define RV_MON_GLOBAL=C2=A0=C2=A0 0
> > +#define RV_MON_PER_CPU=C2=A0 1
> > +#define RV_MON_PER_TASK 2
> > +
> >=20
> > The numbers don't really matter and you don't need to implement
> > all, of
> > course.
>=20
> That makes sense, will do.
>=20
> > I'm not sure how are our patches going to coordinate,
>=20
> Let's just post them. The one whose patches are not applied first
> will have to rebase. It is a trivial rebase anyway.

Sure then, git may be smart enough to see there aren't conflicts.

Thanks,
Gabriele

