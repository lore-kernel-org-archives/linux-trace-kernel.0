Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A5BE13C3CD
	for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Oct 2025 17:53:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760982809; cv=none; b=F0fEPp0rCNYWi8VABUP/I32LCZnHouKVTXogd70LvJ86NzYJP5g75STMCgjyxoAJdGmfvdoqZl8o0S+Ej3IOjifn03Z2B8wpno9X2qZNgs3mz7forvVZHALA2N1oIwKp/oiT//lCP3pawkwfsWKUMnRWaOwMXjjiqLIVhJ+m58U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760982809; c=relaxed/simple;
	bh=V3kRiDp3vGAbgzbMZzOlHpq/3CkSZTRqr/w7qVw8RIc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XOq/iSTi4QnucZD82oPsJpFndhATyNGzrmrpOgd5vAy56ipge7eWBPw4ChKJRmrwvDN4SioWhCIyfujXFNEdaXg9R+aJ+WZv7wTm2P9YgZQBqYDhM6o1Fc50Uz64HdzpLMiKU/EEel1699Z+asp2Hv8uP0uSqiPlx4oBn6L8N9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Tmmb5EYk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Tmmb5EYk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760982806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pxRCI9w0vwrChU6QN7Ie6ynLJhcqQq78vhMcRvozwhQ=;
	b=Tmmb5EYkB5IvLwTcc2KxiTWjY080qIV/sMdsYK1MVFx5b8z/vQpbXA2J03rEQOCCjQ5YsB
	60vJQQV6k/pmWSS/OJlePjOIQbu9dhYDVAHTUdg54A2TMnQtyCExiRFXSOXJLk8t/LBiff
	yKpzQpR6Ogpl6wKWyBiHAEFpZ3t4sKg=
Received: from mail-il1-f197.google.com (mail-il1-f197.google.com
 [209.85.166.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-16-5uVUVyitNQ-Nh7RWozXPaQ-1; Mon, 20 Oct 2025 13:53:24 -0400
X-MC-Unique: 5uVUVyitNQ-Nh7RWozXPaQ-1
X-Mimecast-MFC-AGG-ID: 5uVUVyitNQ-Nh7RWozXPaQ_1760982803
Received: by mail-il1-f197.google.com with SMTP id e9e14a558f8ab-430da49fb0aso40961335ab.0
        for <linux-trace-kernel@vger.kernel.org>; Mon, 20 Oct 2025 10:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760982803; x=1761587603;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pxRCI9w0vwrChU6QN7Ie6ynLJhcqQq78vhMcRvozwhQ=;
        b=SrvNdnaNOG/lZknE5COd+C821eEYgPZY05GRkuIKFBYQYvmOqn/NIytUiSDBOib4L6
         zXbq2QQs57Q1HjYK2flN91v/Iv45qaJLdeuZ2cyCdPt2IV2yrRwHWkGimtdepv7EoClJ
         7LVp5VZrc+HvxbcJS/cxzo8ZdtX5lwyZknJxiKv0O/7EDKtc0BewRt4O5LorFsntHDJI
         haOOs6/3R3h1z/1nBHZbv6zursxPvXTWDTFxGGkp0MWCSe/JxGRQZ97SsHKjrzTo8Pt9
         5BSSh+xrb4Ok6Sqlplm4ELZEipYnuOpLDNtSmSz6DwpJcijMF41fR+xPj0rns5vBUVDL
         aH8g==
X-Forwarded-Encrypted: i=1; AJvYcCUsISEUlRbLUPiI4qM27cgoyrwlDEGqY3xrXeJ8cQiJStKU1OiRHJg9hu59j+zXxUDERtZBf/n5jmTE5nKiS5wigaY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ3LN9Brd4eh2mj5hclUJ1iWvaH+FSeX+S7KfXqGm0mPJfCoT4
	DMAj+dw1Wv8caF0/7ev4Eb1gAr548fUf0Sw9EiLpKY4O2qL8F7BHK3TXKrrRS2Ear1IuKfDngiL
	RlhfgEAA6E/E6XRhrbfilgvq8W0s/bCMJKQ1CBYd46vDll7DS4eFPOemmBjFzsV3mkTIe77l+RQ
	==
X-Gm-Gg: ASbGncs7NV1v+emHpq/aPS3oCIHzLILlDRiELPCBx5W9GhNuIkliXNjiw/8ibqlQNcI
	61itVqufCurCndvtEbZ9p1yhR+9gZ6jXZaOjbUX1u6OeYDxNdRpsucEv7jw2EWXwNY7LZEGUkde
	HCeOYWZx96tH3NuY8x+NcxVA2lp95GIZKpO4d+jPLcpolr60II51eruVDqFJ3UIWdEq7FXeyHro
	ZF4G4O7tsKZ6ThM8LgkKjCPSG8hijgo1yEmR+hSeai2ZNc5dTvT26PsDFB/O6BuwueeXGokDNTM
	HpvC1KlzCO/WEHxopBQsSAEHDRLjE0l/PWR9Kf4/2cu5+gB8Mw4Se7aA1v/8orXIR34sZ9ZdDiz
	Jia5akqu3ToXRsaR72g/0p+WZ2NbU
X-Received: by 2002:a05:6e02:198c:b0:430:c461:34c1 with SMTP id e9e14a558f8ab-430c52700b2mr217742085ab.12.1760982803578;
        Mon, 20 Oct 2025 10:53:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqwALrZUWSrj+qkHQDwlvuffP7O2IVQUJ8UI8LIOpTC0/ScUChcalQi5vBXtjffr1HHB9a+Q==
X-Received: by 2002:a05:6e02:198c:b0:430:c461:34c1 with SMTP id e9e14a558f8ab-430c52700b2mr217741695ab.12.1760982803100;
        Mon, 20 Oct 2025 10:53:23 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([50.145.183.242])
        by smtp.gmail.com with ESMTPSA id 8926c6da1cb9f-5a8a976a58csm3127747173.47.2025.10.20.10.53.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 10:53:22 -0700 (PDT)
Message-ID: <c52490c9c2f682fd3c30d6f8a198be2ba408c4fe.camel@redhat.com>
Subject: Re: [PATCH 3/4] rtla/timerlat: Add example for BPF action program
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>, Arnaldo Carvalho de Melo
 <acme@kernel.org>
Date: Mon, 20 Oct 2025 12:53:21 -0500
In-Reply-To: <20251017144650.663238-4-tglozar@redhat.com>
References: <20251017144650.663238-1-tglozar@redhat.com>
	 <20251017144650.663238-4-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GfR5L4dEIMn5aC4cGpLh4tFZx3yIBb0hALF7JYljJUE_1760982803
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, 2025-10-17 at 16:46 +0200, Tomas Glozar wrote:
> Add an example BPF action program that prints the measured latency to
> the tracefs buffer via bpf_printk().
>=20
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/sample/timerlat_bpf_action.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
>  create mode 100644 tools/tracing/rtla/sample/timerlat_bpf_action.c

We should have the makefile build this, and add a test that uses it.

-Crystal

