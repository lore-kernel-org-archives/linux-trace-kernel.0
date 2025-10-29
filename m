Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3BB732AAD6
	for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 11:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761736374; cv=none; b=pk5g+E3PkZilrAoeD5dIcUDPU5YKIWCbPlyU2CjJh+705FHpYDfPfviGh2y0/oKUtwE9P4YWV6rDW8xL5xCbzHjj01u7zrvXc9kDd8d3dszXSfuhi4vxlvLampJ3Ku5bz4uje2ocygivS4oriF9KPTrv1nS0QGSgjkZzWiTtE2k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761736374; c=relaxed/simple;
	bh=txYqixNO6O28xR4452cP0BY2EHTTPB9PgBzEP6ff4y8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=G6WenOsDYyO5gbGbDZiqsd3C22p+wrRurzDI9ug+ZYwkjk9KgiJzgX3OZeS3QIbgjuuZrxU/2FQdrv4vjTGzE2eMKGzbUE7I+8mxK4PbyzHINxhDPjkR3m8qHTgWkgcD/5p/E70eaLfDRPU9012gwFwvhQ9xpIEz32teUIdaUyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SUE0tBwo; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SUE0tBwo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761736371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HcF2lGOd9L3XLehT3KxyGHuSIDfXwNtuZ/zp8nK6cv4=;
	b=SUE0tBwo8mnHPjKso8NZXIrwKzR9dE1l1U/rYxA+56JE2wmkRxG4Gpj+7Lm+wyPt/46sjt
	7HGr8NefUWDqO+jBeR9s8jFsv6HT3qyId9JvZzAY6Y9Vuc0wH/SiCUJVP13+vrZY1qjQLB
	u77/J3iPciAsjevT+NtE3qQDEBLtL+8=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-87fXCCwxOHCEB-RMPa3DVQ-1; Wed, 29 Oct 2025 07:12:50 -0400
X-MC-Unique: 87fXCCwxOHCEB-RMPa3DVQ-1
X-Mimecast-MFC-AGG-ID: 87fXCCwxOHCEB-RMPa3DVQ_1761736369
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-b6d40007ea1so580428066b.3
        for <linux-trace-kernel@vger.kernel.org>; Wed, 29 Oct 2025 04:12:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761736369; x=1762341169;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HcF2lGOd9L3XLehT3KxyGHuSIDfXwNtuZ/zp8nK6cv4=;
        b=AZwth4E31bd6INWf5FQFvFV85mBi+GXUCEnQaG3zu0mRA+AnvgpR3xdCOCiHsvBHdK
         G56o3oovyr+I/L6G5F1IIXrHDMW8j2UPpnnAEOoL3k4HCNvuSeV4ZetYlFV9uX84oeKx
         tKoLtKZ2Q55jwc3LyxHJPslmOvdUdMQs0iNzPzK4GKrD3FcyMfeCHu2gZGoMXT+jg4s3
         8pxc24JM6FbUx31OeRsKLWugfMxMtqi+jtG5A4X+K7aVi6CBSqX7QPlMCjiGz/4+Y5af
         Z8SV8l9nDrk4WLUzvpeQoItffOZGZAIZF9Zbip8T30eGMAQqNTHq3RhLivPOUPuPDIIl
         UQXQ==
X-Forwarded-Encrypted: i=1; AJvYcCXqT1ooRV6NMtPFpPm5QPAWdd5+LzWs6BFMnJtXBcoshPFFSlBfM+6r1ZHcxj+tnCxebIhmz8IXoXLtn7sLRGl6hok=@vger.kernel.org
X-Gm-Message-State: AOJu0YzYuk2i6WFGFULHtF8hc0fvPVL0YiSPMNJ2YaPHiddXlaFRO+a4
	82PYCzCPy33ok3dyF/z+N5ArtdQTfayX9FeRTrPp35zLiKNHBLIOg89M5M9SiyxSmBJjDZbVUAo
	o08i3az/oR+N820f5S3Uhvo0eZNpe4+eZMSH0RPDlwI5TuYs6Yqk/cXR6lM6nN557YjVbbfeStP
	deepcnn5vbcYAUwN6O1wkJp+LiL8qYplDDHUiLZ6h6uk45BVg4
X-Gm-Gg: ASbGncvsiDgt7HUjM+itB0UD7CCOpMd1cmNc3FnrkRLiYrZTjzpPf2gUI04SY95aFzI
	6iif2einOWphEq0MHQ9zIQwX8o4lRmerRz7mXwHmO1j5lZbBPmostyFU279vS5A1YwGPNjz6KTA
	aIvsFEsdq3SvHS3m0ayXuVKfQ2ciTCZ+l4FL3AUazR/kQ6ufabotEgmNJz1Zdyb6Kt2wh+qZ2cr
	oJ8HC3+OoXCog==
X-Received: by 2002:a17:907:7f8e:b0:b6d:5c52:638d with SMTP id a640c23a62f3a-b703d2ccb05mr206470566b.6.1761736369397;
        Wed, 29 Oct 2025 04:12:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGZ4TUvAVJAh6t7ae1chMAhVBwMYOsQISU+eVER7/+hsriMK5kCCdBk10LppB1XbmdsZmpRLLCeisbkxubg9E4=
X-Received: by 2002:a17:907:7f8e:b0:b6d:5c52:638d with SMTP id
 a640c23a62f3a-b703d2ccb05mr206468966b.6.1761736369045; Wed, 29 Oct 2025
 04:12:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251002123553.389467-1-costa.shul@redhat.com> <20251002123553.389467-2-costa.shul@redhat.com>
In-Reply-To: <20251002123553.389467-2-costa.shul@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 29 Oct 2025 12:12:38 +0100
X-Gm-Features: AWmQ_bkp5cNRfZSU0z7x09yirtzGsD82ZgctqjzDcm70-9HfXgEx10dvOZAk1ts
Message-ID: <CAP4=nvRN1Svi5UxN=FxSSFH6JaKTy_nUcz0ARzbaY3-9HSh44A@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] tools/rtla: Remove unused optional option_index
To: Costa Shulyupin <costa.shul@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Crystal Wood <crwood@redhat.com>, 
	John Kacur <jkacur@redhat.com>, Eder Zulian <ezulian@redhat.com>, 
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GctwgrXqEWy_0BdjaWD8sqB10MCxW3mpSmcooQkT05k_1761736369
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C4=8Dt 2. 10. 2025 v 14:36 odes=C3=ADlatel Costa Shulyupin
<costa.shul@redhat.com> napsal:
>
> The longindex argument of getopt_long() is optional
> and tied to the unused local variable option_index.
>
> Remove it to shorten the four longest functions
> and make the code neater.
>

Yes, this is documented in the manpage:

"If longindex is not NULL, it points to a variable which is set to the
index of the long option relative to longopts."

> Signed-off-by: Costa Shulyupin <costa.shul@redhat.com>
> ---
>  tools/tracing/rtla/src/osnoise_hist.c  | 5 +----
>  tools/tracing/rtla/src/osnoise_top.c   | 5 +----
>  tools/tracing/rtla/src/timerlat_hist.c | 5 +----
>  tools/tracing/rtla/src/timerlat_top.c  | 5 +----
>  4 files changed, 4 insertions(+), 16 deletions(-)
>

Reviewed-by: Tomas Glozar <tglozar@redhat.com>

Tomas

