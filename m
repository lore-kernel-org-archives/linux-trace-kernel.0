Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF74333AD9A
	for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 16:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762965688; cv=none; b=PWK96UXyhmryFbQfcfMsdiVW6E3PdXtV1GN0qxM9YhvAkreyovqTX8OEiS3S78pJ/yE4hi7BjtuSZF7arEadIZPx4W59qod1lX3Da9YrM7fIR1aIiEjI21v+v1qy6IQAhXBSlWCs71Yyz2HE9dn+vuSt1ikA2ugqMV6S9J6OIdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762965688; c=relaxed/simple;
	bh=a8AJGhL1VAPG262ScwQLe7whI1dlfXisT88+QPWVjEA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=c2Fu91pdxv/JCUzOCvsZ+ksqKdW1J+5KvZU0agixTGVRDh3k38e7oVkbNk5QUpni6M2sfPsorSYtult+17ms4yzvqdOAYB8P76aIAMDHOEkmSkz/uVdjHegAiYouyGZG4zAEcgd4WGUICwCctTvSjAXYagY6uCkFtpBhvBV2rOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CxoPGeSs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CxoPGeSs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1762965685;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ikdXXsrAm3HhwuEKeAkHhU7cBlMn2TwrNGMihSwPVNo=;
	b=CxoPGeSsljUKjNY1mIk6K9uaUn2mrtUB9lCFszRA8CY23z/tJ+qMxaEn3k4TNKHId1xoKT
	4t5pIo7W8W2kCST6cxWCUtO6Uc82T98Sx4dp+mSHoCSOxh/CSrJOUa5CDZSwqe7w8/cKVQ
	QLEzRqS5Zo22nWTof406rxhSBPdSZ9Q=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-6XxxF5TDM3eWocVYGRpZ6g-1; Wed, 12 Nov 2025 11:41:24 -0500
X-MC-Unique: 6XxxF5TDM3eWocVYGRpZ6g-1
X-Mimecast-MFC-AGG-ID: 6XxxF5TDM3eWocVYGRpZ6g_1762965683
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-b70be4f20deso82829466b.2
        for <linux-trace-kernel@vger.kernel.org>; Wed, 12 Nov 2025 08:41:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762965683; x=1763570483;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ikdXXsrAm3HhwuEKeAkHhU7cBlMn2TwrNGMihSwPVNo=;
        b=VyDy96wMOultz1yuoICHIaQWeUPQN2ihW/4dhzKzSjVRfA4KVZ9BVZot6jnUTtnguF
         WS9wzyiCwLijTUd//kZwr0rSCc8X50PrT939PluS+fXQJKNVyOwp6WP6KjwLUiex/829
         pno9IVqyl6tMqrUcPQkauVPEN4pHUQmPhDnWOd6fY3xdY4OwQ0FR51RRZFT/8EUfB5au
         e/N+Xy2dLg/9aaW53XYZ1Eze1KEOsUkl9TD8HcCB+4ySQzFMU/H2J0oXiqBtDW1NbUDG
         7BHkL/KpHIX3Zg6CKVL/RmCTWCHrw8le1WAWgXzehWIrVFq3Gm9d2L8eYF5m7p6YOCqL
         P4Ow==
X-Forwarded-Encrypted: i=1; AJvYcCXDzn+n3TRUO8Juw6fWP3zxoEwepHPy5qA2qiudr0jufUJFNcNcpUPFte4/Rqx4z7kJRbykchRt7RN5nxy6qCjGCqI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyf4M0C9zefGud/v5XH7iaYokrQAjfOf2+RAcrY6R61kyHzMlc7
	2ZUmLXL2WGUb+25G2g6CZcEG5FhQ6n9tw1XIDjpwLck3l8hAvzk2OpBjVtpOjMTfDsz1dzycHII
	Cb8ipooTvCoc1BLkEUd3F54x4u1NXsQCYtaqlrWaFVpR9Gn+pQ9uWDKzwK6eHeuyNG2NXSHKU3j
	u20IYrVruLVL6oZ0szr0LRxTGAY1GN9G2J8kICOkcrl/Vwtj5j
X-Gm-Gg: ASbGncuQtGKm1fTKWexe8UL9mUlfo8MRKK4sNNw+jrQAPq1uUy0dlx2k/NIvFxAfPCn
	95rX1qAAdyKI8splG+GMRjvwewAV2Ib8DhceqbQmjfgv9+VqrWRMRw55iHmjUldVqsdz31/m2u8
	Jjxu3zBQJeVIrV4hEvxHM9MTZQB2Nm9hwvk2yHU3Fw91uMqN1Ojakrj9NaAxbCtCbhqxoGUujek
	QNrFl0P5EyeQA==
X-Received: by 2002:a17:907:3ccb:b0:b3f:b7ca:26c5 with SMTP id a640c23a62f3a-b7331b26dc5mr346896766b.59.1762965683134;
        Wed, 12 Nov 2025 08:41:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHRc27NqW8+JUpvUh/cragVc2iT9XVTBXRx/J0JvT27BwmP6Bx6hZwHI5ZAmhOEOWRcd6vQa72Z36X+KnpkIc8=
X-Received: by 2002:a17:907:3ccb:b0:b3f:b7ca:26c5 with SMTP id
 a640c23a62f3a-b7331b26dc5mr346894266b.59.1762965682584; Wed, 12 Nov 2025
 08:41:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251112113556.47ec9d12@gandalf.local.home>
In-Reply-To: <20251112113556.47ec9d12@gandalf.local.home>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 12 Nov 2025 17:41:10 +0100
X-Gm-Features: AWmQ_blxXMedttQ595QdqBFXx9o1e_Sra_b48yscMGVD3xxwKAJfY9BmkO7vLyQ
Message-ID: <CAP4=nvTMknOzMeUj-bW2sdGNTP-4D1U+L-buwyXZo8et1XyY_Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: Add Tomas Glozar as a maintainer to RTLA tool
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>, Gabriele Monaco <gmonaco@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Crystal Wood <crwood@redhat.com>, 
	Linus Torvalds <torvalds@linux-foundation.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: azcPuXnQCOw1DR1rixr5_yAf6CaE3GaZpwkBFeWcIXs_1762965683
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

st 12. 11. 2025 v 17:35 odes=C3=ADlatel Steven Rostedt <rostedt@goodmis.org=
> napsal:
>
> From: Steven Rostedt <rostedt@goodmis.org>
>
> Tomas will start taking over managing the changes to the Real-time Linux
> Analysis (RTLA) tool. Make him officially one of the maintainers.
>
> Also update the RTLA entry to include the linux-kernel mailing list as
> well as list the patchwork and git repository that the patches will go
> through.
>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  MAINTAINERS | 4 ++++
>  1 file changed, 4 insertions(+)
>

Thanks.

Acked-by: Tomas Glozar <tglozar@redhat.com>

Tomas

