Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4F1537F007
	for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 12:22:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782476557; cv=none; b=VbZlmSTkBX959txIy+waX1joMw0pdBWcL680IITV2AInwawH+akFvLSEQ/GY7S7EK/OuI0NnTyZq6ddliRL6W7ungxnX6IWeVbAk3MNuL52G0LkUj7N0wb5StFk8tvXdONgMM2XEpXFrjud4GVOSIWoh/M951tZkqaFkwAZK3N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782476557; c=relaxed/simple;
	bh=nIF0AvizhZHg6U0DlNrZEnzgxmmqoGWz+IEZkbOSdXE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LumVbfUKkpnzY2FzKNTbnlo1DYOBSDu5onsOCzGttRAMekr8+rLj41NZs10kD2v9fwv3mDpsafNsXVoN4FaU8Y7Wn/k1a2qnXL6DzZUG4ww4hBl+jUvoaf9I64Yv/lft+Z/UnYAnSS3iRhsCG/PGL7/KYxwC7jf/jl8U6afi9mU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fMpOrrG3; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fMpOrrG3"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782476555;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WgoDtrSWLoYqVxaCeqVOjWhvXTB+ctdfxV83KyGF1OY=;
	b=fMpOrrG3cmMbif18Y5SSvb+6vnvxtAZuKzbMhWt8gGeGpERK6uYNx97LmI6pLssBKnHMhv
	ALGYJbi2uq165waPGbI921DSTJkZWv4Yzt76hiWgpDyue0sGK53ueNkOXS8L0vIab3tn1k
	RxJPyhHyADC1yKaWd0m+zQOFqWNKI0E=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-15GtYIyBNkag60Kiu8JuDw-1; Fri, 26 Jun 2026 08:22:34 -0400
X-MC-Unique: 15GtYIyBNkag60Kiu8JuDw-1
X-Mimecast-MFC-AGG-ID: 15GtYIyBNkag60Kiu8JuDw_1782476553
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-6960fb32b74so858793a12.1
        for <linux-trace-kernel@vger.kernel.org>; Fri, 26 Jun 2026 05:22:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782476553; x=1783081353;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=WgoDtrSWLoYqVxaCeqVOjWhvXTB+ctdfxV83KyGF1OY=;
        b=hLRgjwF4byEvGlnens035cQe44EU3RjAHLaajWk8yrkIczJsrGOpdWuyDXMCcy6qIF
         ojjksoLi9rhLFHdSoA1RQob2ind7VfepLKkm/SfwIZuxldQt4jDdyu9PvzXJqDfZUUS0
         RK5ja+EXF0xeP47YhpViUiJoe02fCsum80U5T61CFR+lrAImh2l3x+4zSwh6250Iz6Ch
         AkvXb/bZTJieUsKz5WUTKxTQ/zc5iTRGYXU2wevKXbIyKROpT81Vr/we9OqmGTvkmpop
         kZa2B5B7bYWXtFYkQWY+Im0z9Fv0lFljaWvtrKzq+jhCCETXrkZnUrNNnSyAY7a0dKjW
         BMag==
X-Gm-Message-State: AOJu0YyX8+1OqRYNMCPJNZqsmelBJB4LMWFyypq4Z66rnq66OaE7NRV/
	BBeL3jv/nAUtCII5ARsqCZWqcjCxpH8MzeTRXK4JwscK6uYII8QMDXPNbvxM3QR4IfAszQ+dRDX
	Etdg2CFQyBwtMOyVUxzdmEQvjz6dQuXuewA10Se2ECypz2CLLaoX+s6b54NMvUVEy+pHUytjnt6
	TULayVg4l8KhpTwhJ7mdr3X8sQO5YXU/lky6eVGVGrAdgsgSFB
X-Gm-Gg: AfdE7cntu+0xGAxi+z1nscIhsZI2Pzf/rJXdAOrpJllcXKKvGCJBXO4ls1QpNdV+xKx
	WSyVbZ8B02fi9q1zJQqg1wrJDMexPcS0GYqidvOw6LfXb2Cn09G92TcNcuVkexOf4ccR205Hrgs
	wkYqRMx/Y6b6LeYDHjp7G6tWa9jw0QlhfqOe8EWWnkRfVCb/eZflEkFgEA0FxuKW3FSwQ=
X-Received: by 2002:a17:907:8692:b0:c05:3c55:ee86 with SMTP id a640c23a62f3a-c120616a8b1mr478580466b.46.1782476553051;
        Fri, 26 Jun 2026 05:22:33 -0700 (PDT)
X-Received: by 2002:a17:907:8692:b0:c05:3c55:ee86 with SMTP id
 a640c23a62f3a-c120616a8b1mr478578366b.46.1782476552611; Fri, 26 Jun 2026
 05:22:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602155210.60439-1-jkacur@redhat.com>
In-Reply-To: <20260602155210.60439-1-jkacur@redhat.com>
From: Tomas Glozar <tglozar@redhat.com>
Date: Fri, 26 Jun 2026 14:22:21 +0200
X-Gm-Features: AVVi8CduXgIEji_4_krADpLwcf0GZXVXC0o0RwWbDkemV2-Zkp41NaB9-2AZWgA
Message-ID: <CAP4=nvRzzrR=0BFxjV7byxK5gPSBOG-4q9RYAar+SMJs17AkCw@mail.gmail.com>
Subject: Re: [PATCH 0/2] rtla: Add tests for option parsing with attached arguments
To: John Kacur <jkacur@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>, 
	linux-kernel@vger.kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: UGv9uwH4_e-D2BhbHztJYKCkb6JNPQvOXz56pewcZeI_1782476553
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 2. 6. 2026 v 17:52 odes=C3=ADlatel John Kacur <jkacur@redhat.com> n=
apsal:
>
> Note: Patch 1/2 is a resend of the timerlat hist tests sent previously.
> Patch 2/2 adds tests for the remaining rtla commands.
>

Ah, this confused me. I saw cover letters, 1/2, and 2/2 with almost
the same title and content, and wondered what was going on.

> Signed-off-by: John Kacur <jkacur@redhat.com>
>
> John Kacur (2):
>   rtla/timerlat: Add tests for option parsing with attached arguments
>   rtla: Add tests for option parsing with attached arguments
>
>  tools/tracing/rtla/tests/hwnoise.t  | 10 ++++++++++
>  tools/tracing/rtla/tests/osnoise.t  | 18 ++++++++++++++++++
>  tools/tracing/rtla/tests/timerlat.t | 18 ++++++++++++++++++

This should be either one patch, or three patches (hwnoise, osnoise,
timerlat); especially timerlat top and timerlat hist should not be
split between two commits, as the tests are in the same file. Also,
identical tests for both top and hist should use check_top_hist or
check_top_q_hist, see commit c15c55c01e48 ("rtla/tests: Cover both top
and hist tools where possible").

Anyway, I don't think this needs runtime tests. CLI unit tests (well,
actually more like integration tests, as RTLA design doesn't have
proper isolated unit tests) in tools/tracing/rtla/tests/unit/*_cli.c
should be able to fully cover this, with the benefit of being much
faster and not requiring root or any kernel features. Do you have any
concerns that cannot be covered by unit testing?

>  3 files changed, 46 insertions(+)
>
> --
> 2.54.0
>

Tomas

