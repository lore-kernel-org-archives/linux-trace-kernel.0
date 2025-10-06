Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FE532D9496
	for <linux-trace-kernel@vger.kernel.org>; Mon,  6 Oct 2025 15:54:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759766095; cv=none; b=CwdobjwT9ntp3AV0s+nBqsajLAkw1l9t8fjl/4o/ED6SrI5/snOoPtuRjW6cSe8sAY2KFWsU30+GvYnB14XcUFAMJvKuWxNq2DLProeIYS6Shc1V9jQjDNXSEmr3zBvjAwRaWHPj3Y4SLh4+E7Qt20ylQQlML9TRBACgExOkUZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759766095; c=relaxed/simple;
	bh=ZcD3YSDruTtmdcT3ms/DE/HqLMS5aB7VpQstYxj3dp8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P1s5wpBIyyXreYt4HixGRcHbpeehH5eqB9YfC5eSJa+JLXmr8E/6kspwYLe03gOqqw9ZcqxP4ecaFjqlHy0g2H/WThrNAZkBTRu73K0mjciJCSYuOFHIWCH64qdIWbjCZfpkWUZXI57HfjkwnKdJOQ3wXoqRSgpUz255nhbXeIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RICEYkXm; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RICEYkXm"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1759766092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qy/ecUJmRFYFgz464tm8Fz5sRcPWVG7N5wX8mxc+LHM=;
	b=RICEYkXmqvlMqK81T3dPMOMy1MGzEUKf05EUevjhBQl8VfmT2FeYD7He2O11kZ/TF712pS
	8jRlOUynOdjvKaoBAU/+GglshgtlHUsXO5Qf83EzXwUer6sKP/kQ/jCqmVGwKx9EB8x14d
	1mmUDawTzY5kEY8Ag9MDrLSGa73KhEs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-311-CbNHtVMIMOOeXnXQsdVZHg-1; Mon, 06 Oct 2025 11:54:46 -0400
X-MC-Unique: CbNHtVMIMOOeXnXQsdVZHg-1
X-Mimecast-MFC-AGG-ID: CbNHtVMIMOOeXnXQsdVZHg_1759766086
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-4e576157d54so81787131cf.1
        for <linux-trace-kernel@vger.kernel.org>; Mon, 06 Oct 2025 08:54:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759766086; x=1760370886;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=O29nBnuJdm1Dd2mtkKVi5j87G2aDHgLgWODowi64nXE=;
        b=i3oM7q26N+aiBpFt8PZj9WnuWA0isBAQ72Q86a3z8qCrFp9f0y94l1T7u3cJO1olwM
         +hAD3iDHwSzzTpQVrQZ2LkbAgpbGpgX/54S7vDJs36gGEVtuQVBRDj75oYZo+bCOuPt+
         owZ1W9ER0mhjyqpmLsYcIDcfMNnSQX28ef2cHsDs3JMfTN+jglZIScGSzPmxVGprg3/s
         FrRSR8+urI02LSSiDSlfryGUJdhwi2Ae3g7VUwXiNFlCZCIZRM/8cmb+wDOnax/xOWDI
         7gVuWkevF3YLJ9ZlRFKEgr76oqoUTWpeTuqd9pe7sCIjdUWFh2WwQC3q5sni4csLa11k
         yBWA==
X-Forwarded-Encrypted: i=1; AJvYcCU989y54ggKrlFrNZu2KaqanPh1VnSNBQ3DkZSLcLwekYhe7WvLWFBmWV+tHzPu6qQ85IEMCqeJof9JlOBjMIykHig=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywue7PwxZ/Krpwuazz5HTjyA1x3zSZnW/NV0YHYslgH4y2TaASj
	V7EcaV0jMs03CtZSdhee2AaPoS7KdpWc7KadbhSFKg2QL+yEZI5uddEt7GnyFClUmhEte1VCJsZ
	sY9B1fVsiSbpUWJ5EeNpuNzyNNkMsA6G/3kO0aBXK67y4L4ytgV0wKSnlOehzvw0t+nCWvS9M7g
	==
X-Gm-Gg: ASbGncvkFmMn/jfZK1Y8hy9N3+pEruXM68oAikVxKFtUUiweOK0Xr1HGP7PWxSR1US8
	9uoQ2YuWG77gizUarlNsryBPBzE0z+ofnVxffBnKF2SnDpLoca8TvcwrpIUyUcTLEItIbsr335y
	NQNrXJbo3ipX5uuSlUrkVwW3mGftT+UJc1o/uu/M6gRE3dCj+yJvCeUd6JOCEOdVF4D+tsufLIj
	6yD3N8iZe7xotwDkg5++GcxiQmpu6uj9lgjYTYxKjzcngNg0tLKZ5AkfA1Ga2RS+WnCFnP4J9oG
	etOkH2szJrKGvYSu97Upb1IeboSSKtknNeK/4YnLRh4r7/nyoyw3CkO+/I541oP6Oyk6NVCPHjE
	9EA==
X-Received: by 2002:a05:622a:4a14:b0:4de:e0:de78 with SMTP id d75a77b69052e-4e576b09856mr179817101cf.71.1759766085844;
        Mon, 06 Oct 2025 08:54:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEIkw89j8ytLrtstbciVHTMITKqTFOIhKtXwbXqgefktZrwuyNarF/iEuUpfQ4eAp4zAHtsQQ==
X-Received: by 2002:a05:622a:4a14:b0:4de:e0:de78 with SMTP id d75a77b69052e-4e576b09856mr179816741cf.71.1759766085398;
        Mon, 06 Oct 2025 08:54:45 -0700 (PDT)
Received: from crwood-thinkpadp16vgen1.minnmso.csb ([2601:447:c680:2b50:ee6f:85c2:7e3e:ee98])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-87771129478sm1234469985a.1.2025.10.06.08.54.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Oct 2025 08:54:45 -0700 (PDT)
Message-ID: <7359e1e99d715e19db1b1c9e45d28f0c12f0f44e.camel@redhat.com>
Subject: Re: [PATCH 2/2] rtla/tests: Extend action tests to 5s
From: Crystal Wood <crwood@redhat.com>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel	
 <linux-trace-kernel@vger.kernel.org>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Wander Lairson Costa	 <wander@redhat.com>
Date: Mon, 06 Oct 2025 10:54:43 -0500
In-Reply-To: <20251006142616.136296-2-tglozar@redhat.com>
References: <20251006142616.136296-1-tglozar@redhat.com>
	 <20251006142616.136296-2-tglozar@redhat.com>
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: SaGgGDCnlwAeRg303jZ9ZhG79RiAU_GOnXvIw7WmoUE_1759766086
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2025-10-06 at 16:26 +0200, Tomas Glozar wrote:
> In non-BPF mode, it takes up to 1 second for RTLA to notice that tracing
> has been stopped. That means that action tests cannot have a 1 second
> duration, as the SIGALRM will be racing with the threshold overflow.
>=20
> Previously, non-BPF mode actions were buggy and always executed
> the action, even when stopping on duration or SIGINT, preventing
> this issue from manifesting. Now that this has been fixed, the tests
> have become flaky, and this has to be adjusted.
>=20
> Fixes: 4e26f84abfb ("rtla/tests: Add tests for actions")
> Fixes: 05b7e10687c ("tools/rtla: Add remaining support for osnoise action=
s")
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> ---
>  tools/tracing/rtla/tests/osnoise.t  | 4 ++--
>  tools/tracing/rtla/tests/timerlat.t | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/tools/tracing/rtla/tests/osnoise.t b/tools/tracing/rtla/test=
s/osnoise.t
> index e3c89d45a6bb..08196443fef1 100644
> --- a/tools/tracing/rtla/tests/osnoise.t
> +++ b/tools/tracing/rtla/tests/osnoise.t
> @@ -39,9 +39,9 @@ check "hist stop at failed action" \
>  check "top stop at failed action" \
>  =09"timerlat top -T 2 --on-threshold shell,command=3D'echo -n abc; false=
' --on-threshold shell,command=3D'echo -n defgh'" 2 "^abc" "defgh"
>  check "hist with continue" \
> -=09"osnoise hist -S 2 -d 1s --on-threshold shell,command=3D'echo TestOut=
put' --on-threshold continue" 0 "^TestOutput$"
> +=09"osnoise hist -S 2 -d 5s --on-threshold shell,command=3D'echo TestOut=
put' --on-threshold continue" 0 "^TestOutput$"
>  check "top with continue" \
> -=09"osnoise top -q -S 2 -d 1s --on-threshold shell,command=3D'echo TestO=
utput' --on-threshold continue" 0 "^TestOutput$"
> +=09"osnoise top -q -S 2 -d 5s --on-threshold shell,command=3D'echo TestO=
utput' --on-threshold continue" 0 "^TestOutput$"

Not related to this patch other than noticing it via quoted context, but
I spent about a minute trying to figure out why "top stop at failed
action" uses -T instead of -S here, before noticing that it's also
invoking timerlat. :-P

-Crystal

