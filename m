Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF2428C00D
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 May 2025 13:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747921427; cv=none; b=aXMTJ/maVQR3tSYC/z69uKvq7IDK3sKdC3Icj8ukNPttxs+T/ahbm6kwxgXuTtglxjSxuP/L6RJQKpdJkdqtoVuK7fBC3qo8FwFr+Xb6H365Qp0jVku5QFP07AbsZm1OMOLI8e1xji6/ezySUzGaAXCnOIxY/2kM9YH6IY27L5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747921427; c=relaxed/simple;
	bh=A+7j37YM8CLHuf4M8TE4bEC4Qqh65RglyR9XdNxjmCg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D2lrJm5IqfQ9UJVx4G5B/D39ghO52XJRz+7aVJ7IVfxKmcmVyZW45Uox2bD0EEyOfAWFJy6MMwLJvwESfwd+AX6JYF3yyC3oxwn2G25lmPR4LNM8cNHfmT4nCqfttFUyWv13A9Y3m1+aSAlmsGmB6oV25dHkYZN1FFBGQbhWDlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PodTTlox; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PodTTlox"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747921425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ki4PGz9MoGwpt59sUdcbcs5elurUJNkygM0DwmzXjgk=;
	b=PodTTloxL3VrLYWwuDDUFzY0jK0BukBQotLbCdzHMAxxVND0iyxRTg+r+3m4Wc8V79mCrn
	078IXCh4H/w8LuEAFlFqAp/Y2vNVMmnU+N74wbrS2dX8ev9OIIL6GZo1M1Ww/GKyLf8QtL
	RO9cfuZtnCLP3EAbR5c2P7gzjl3dchc=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-UQnJGvjxODGWfthrauUdSA-1; Thu, 22 May 2025 09:43:42 -0400
X-MC-Unique: UQnJGvjxODGWfthrauUdSA-1
X-Mimecast-MFC-AGG-ID: UQnJGvjxODGWfthrauUdSA_1747921421
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-601f918c628so5066176a12.3
        for <linux-trace-kernel@vger.kernel.org>; Thu, 22 May 2025 06:43:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747921421; x=1748526221;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ki4PGz9MoGwpt59sUdcbcs5elurUJNkygM0DwmzXjgk=;
        b=WWPzvX1r2SpFmTD0iY1ItcfUnUbvYi4UWKlT8zIikKImpztjCn3OY6lsz/4DWrCo1M
         asrXLqAIyvYy8UatOegvGvEAR7Z6YOzFsAH5Ii6BhT3q0qzQn1eMGqalb51w3ZjTpTqH
         OD5xD/sKUAViE4cODcXg6mDemaG4Sm5HXvqJ2NEjDILbzfGX/enM6kCR0pv7FPMRufwr
         WSZ5Rz51//5Vd4GgbXlDvKZkYrbeWCR1pezYLnMeJKMUgmNLhT3NYthavRydqgVTqmjB
         nqslSwQT4rTUIhamyppqdLmj6hW0pAml8lK+soBYWBFz+jSEO9GV2ugqxTKWcEpl93xc
         CoDw==
X-Forwarded-Encrypted: i=1; AJvYcCX6Avab3mkJWBwftZbYRlF5eKRyCZwXNTy1swAb8rsVQ2a4DYFMquoTVEl3guajYm1ztjywO98FD8N282jOQUqAR/g=@vger.kernel.org
X-Gm-Message-State: AOJu0YyracO72TLDs9khU+42cZjKGqm7a6FVttMZ6pneOBuh6ZVKA7BY
	NdepPFR27sMb8hZ681qh0F0ExEDuSqlStV20Ncs2Quyb/dlrWHmzA68zf9l6omuFchyKKjKR6yi
	Drmkne/AFlNhJ9jOpqbbw8vsebGX9Oe8/HtEDfNIscRKUjHNRY2XRPC19WIWqRI9PwkfYcvg7/0
	haC4sgIjr8+Kfjnh54eNSnRu2qAqgQT2kEeRM4AByTyKfzjs0g
X-Gm-Gg: ASbGncsx9mCeI0mONT+Qfl+8kwD2bGrdbqB6ZEynh92YZWMoPGZBv8s9J93/5MFyxcE
	ATJ5TMT9rpbusuLJLtFmuVrpZapvDJXMEOs5lNPDMmCkVo47raAg5T/HtNJ5r46dZ1mE=
X-Received: by 2002:a17:907:d0c:b0:ad2:24e5:27c9 with SMTP id a640c23a62f3a-ad536dce79fmr1894668866b.44.1747921420845;
        Thu, 22 May 2025 06:43:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFApJlcKWeBv+I/SZdgDY/l7/3GBrRjoB1/uHm1DvRsrdhnUNEd+PLOFGC7roeOx4o5yrW+a52CQxM2LWr2/4k=
X-Received: by 2002:a17:907:d0c:b0:ad2:24e5:27c9 with SMTP id
 a640c23a62f3a-ad536dce79fmr1894667766b.44.1747921420478; Thu, 22 May 2025
 06:43:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250515162133.29507-1-costa.shul@redhat.com>
In-Reply-To: <20250515162133.29507-1-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Thu, 22 May 2025 15:43:28 +0200
X-Gm-Features: AX0GCFt-etal4vUs3hVowp4ARgqzJUvnCHub4_m7VLxKDnkkY-r7AMpHp_xdrdw
Message-ID: <CAP4=nvR06=j8WpNbHay60_f3bNtYD+0yHdvzEnm3O+7oT6BZww@mail.gmail.com>
Subject: Re: [PATCH v3] rtla: Set distinctive exit value for failed tests
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>, John Kacur <jkacur@redhat.com>, 
	Daniel Bristot de Oliveira <bristot@kernel.org>, "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>, 
	Eder Zulian <ezulian@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
	Gabriele Monaco <gmonaco@redhat.com>, Jan Stancek <jstancek@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yxVoAFbnXkHHkeKks9VYJ7fbPjyhWHX_G_iHNwlL9cs_1747921421
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 15. 5. 2025 v 18:35 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> Add documentation
> - update Documentation/tools/rtla/common_appendix.rst.
>   add SPDX-License-Identifier
>   add section 'EXIT STATUS'
> - include common_appendix.rst into
>   Documentation/tools/rtla/rtla-timerlat-hist.rst - the only file of
>   rtla-*.rst still without common_appendix.rst.

Those are three distinct changes that should be in three separate
Documentation patches, and not together with the code change.

Tomas

