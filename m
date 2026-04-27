Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C46DE26A1A4
	for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 09:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777282352; cv=none; b=i5nR0nHHbHRWZouZIMy2l9OnHCp2PdbC1Ky32hLknIn3rvE7xKVDJwS7fn1IlX/qrhH/tVsjfFnYcDx+M1v73BZ2ncoSO42kREzHQntJoIC2+Hxq5h7OH4DUf806croAByh+a0eYmpy6JUsIDYFOw4XqsG4WeGDczeG/dIpP50Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777282352; c=relaxed/simple;
	bh=U3q/Um40fvA5e7ATbbuWMzPyKm4I3ETK+9Ld3tGVs9w=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AXlNFZQgKISr+rrcwYFxibpOhe2reZHPPWAZ1Gb7NsF7VJKWkQt0UGx7SFDp6ytUVhiiCx7rMGe2IqJTz4w2QmUrpFNw7PXj2BFoaFs7vw0GA9UMEWThQLPYYX/g2Xh4YBnaF3g45EQLhSYSTK+PllW7oWsHFOgu1IbA5TgtNl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FJghJitc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FJghJitc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777282349;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U3q/Um40fvA5e7ATbbuWMzPyKm4I3ETK+9Ld3tGVs9w=;
	b=FJghJitcVn5TsZsDL5Lz2Z2IbPjDgZcWn/EMD7dZboTexC2xmaZWX7k6wSWKlOtx4hQW2L
	cQnAfzm5supD7yYaOsM38wPbjuZzrz3bxv05rJ6X4xZBIFxSGClWIcb6Nv/ORdhm+MwS9X
	LXVq3sb7YIcpwE8NmTKbJqnawrtscmU=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-619-uzJ7B8mIPPaRUX7S2ouuCg-1; Mon, 27 Apr 2026 05:32:28 -0400
X-MC-Unique: uzJ7B8mIPPaRUX7S2ouuCg-1
X-Mimecast-MFC-AGG-ID: uzJ7B8mIPPaRUX7S2ouuCg_1777282348
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8eaee67d1afso760663185a.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 27 Apr 2026 02:32:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777282348; x=1777887148;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DZgJ8cDpzqz4seiWnL8vet6Bd8LTiDArtz8YZYnTyjA=;
        b=XCXcsVubNGkJ8a5QHq7FP2Yi6JtjEpSAGP+rT9xMfD3Slb3PqR31MXNxWocXRJz9Sv
         HmFg3DkQzFEXmzMhInNKZmNQhWwvEDLpJ+7foSV/9RSV83X5x5TdjTYIs133TPTdLKK9
         Aoy1VviWCRqGlbRbuW+jZGcxagRd20dDfoSYFDm4EGP2hX+odJCaxJXczSE9/7jl8g1C
         6kpmDm2KYr1EOVgvSMmTlCg7AYNxyexp/bP7yHo5gRABz8nKD7wlABbyIgBlaC3MMPQI
         5Z3P1frBvBYh+bpmbgoKLvxOV8jIl7ActYhP8D90zXUQhQP9OHkXNvaDm4xg3IVHyE3I
         kTtQ==
X-Forwarded-Encrypted: i=1; AFNElJ/uskVKPYu453XKgRaPs82Fmj9EEZYxc3jUQPB8cwJ3ZoezXX4/gAdJh10o1huWpDzis25pArTAtNlAVPiJ/CW/KkI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxEmoat8IQRfdTNjEeBoDoicODIXkfPYGZ8cAGklEwtpaI/BbuS
	cucFrZSMy2rFw6nbyJu3pzjsLLPg8pePZqfBWBl5vrClXV2tWe+PksPow93LzNu7H8aZ+wsynnY
	uCqi3zHmsIl0yiBC1ugYeoxBfiG00gcRJRz4casenk2wH72uFDKYvDS8tFhfxhMv+MtMw9xqrQg
	==
X-Gm-Gg: AeBDieuGYQj/QOerDoAZWT84EmjDstdMKh4lVB+ahyQCSJ6aUI9IGY8H52rVvsFYoTC
	y2vJ3WI9Kc9BrIYJDH4eWhjLkzTqZEhmR+M750JU/bqDs8Z/Ahz2igbrLz7JvW22oqlz3AZ0iGj
	v8OPtvjbtbhvHIDs8VwsLIjxgpzdR+BR7OTbrPOkgbBXxeL+9m1y8a5N+BTDQXYbP2ymwdt7Vmg
	6gAllECqVMKutC1T+eQcPs6gh9ByD3f9ff8NXkggaUDIMGqUA/EyULXa5vATh1s66tkUUD4Jv5l
	92M6U8WCGFdpuUGRovmoP7XtMoLRQD9XhON+oFyD5hSw+QeQX+KwQlEDTZgqOjSsbnWXEXwZc9W
	gQ945kCFUZkRYkbOxnp+bvc62fZ5ZzpCgV/gU
X-Received: by 2002:a05:620a:4555:b0:8f0:a3f8:fb2d with SMTP id af79cd13be357-8f0a3f914f3mr2890305285a.2.1777282347852;
        Mon, 27 Apr 2026 02:32:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4555:b0:8f0:a3f8:fb2d with SMTP id af79cd13be357-8f0a3f914f3mr2890302385a.2.1777282347355;
        Mon, 27 Apr 2026 02:32:27 -0700 (PDT)
Received: from [192.168.1.167] ([185.168.96.228])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8ee67115aeasm1746799885a.44.2026.04.27.02.32.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2026 02:32:26 -0700 (PDT)
Message-ID: <9baaa22d80fdd2dc7a15d2db9318a921b7d661bb.camel@redhat.com>
Subject: Re: [PATCH 1/1] tools/rv: ensure monitor name and desc are
 NUL-terminated
From: Gabriele Monaco <gmonaco@redhat.com>
To: unknownbbqrx <dev@unknownbbqr.xyz>
Cc: rostedt@goodmis.org, linux-trace-kernel@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Mon, 27 Apr 2026 11:32:23 +0200
In-Reply-To: <dc9ea036-de62-4e1f-be63-8e14d675bcca@smtp-relay.sendinblue.com>
References: <dc9ea036-de62-4e1f-be63-8e14d675bcca@smtp-relay.sendinblue.com>
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DdMCPP48nsqwi7X0uV4crBYzsw5y90SNWdYFJQuWRfY_1777282348
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, 2026-04-23 at 17:19 +0300, unknownbbqrx wrote:
>=20
> ikm_fill_monitor_definition() copies monitor name and description
> with
> strncpy(), but does not guarantee NUL termination when source strings
> are
> equal to or longer than the destination buffers.
>=20
> Clamp copies to sizeof(dst) - 1 and explicitly append '\0' for both
> fields
> to keep them safe for later string operations.

Hi,

thanks for the fix!
Looks good to me.

Reviewed-by: Gabriele Monaco <gmonaco@redhat.com>
Fixes: 6d60f89691fc9 ("tools/rv: Add in-kernel monitor interface")

On a side note, you sent 2 patches and you apparently sent them both
twice (did you issue git send-email twice? They seem equivalent to me),
next time you could merge them in the same series, just preparing them
in the same branch and passing them all to git format-patch/send-email
[1]. In general you'd also add a cover letter, can be very simple in
this case.
That's usually tidier and easier to apply for maintainers/reviewers.
(You can ignore it this time)

Also add the Fixes: tag if you're fixing something (e.g. a potential
buffer overflow in this case), I did it for you now but you can find
the commit you're fixing using git blame.

[1] -
https://www.kernel.org/doc/html/latest/process/submitting-patches.html

>=20
> Signed-off-by: unknownbbqrx <dev@unknownbbqr.xyz>
> ---
> =C2=A0tools/verification/rv/src/in_kernel.c | 7 ++++---
> =C2=A01 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/tools/verification/rv/src/in_kernel.c
> b/tools/verification/rv/src/in_kernel.c
> index 4bb746ea6..d32453824 100644
> --- a/tools/verification/rv/src/in_kernel.c
> +++ b/tools/verification/rv/src/in_kernel.c
> @@ -215,10 +215,11 @@ static int ikm_fill_monitor_definition(char
> *name, struct monitor *ikm, char *co
> =C2=A0=09=09return -1;
> =C2=A0=09}
> =C2=A0
> -=09strncpy(ikm->name, nested_name, MAX_DA_NAME_LEN);
> +=09strncpy(ikm->name, nested_name, sizeof(ikm->name) - 1);
> +=09ikm->name[sizeof(ikm->name) - 1] =3D '\0';
> =C2=A0=09ikm->enabled =3D enabled;
> -=09strncpy(ikm->desc, desc, MAX_DESCRIPTION);
> -
> +=09strncpy(ikm->desc, desc, sizeof(ikm->desc) - 1);
> +=09ikm->desc[sizeof(ikm->desc) - 1] =3D '\0';
> =C2=A0=09free(desc);
> =C2=A0
> =C2=A0=09return 0;

