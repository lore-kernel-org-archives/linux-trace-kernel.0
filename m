Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795534664;
	b=mOtSpkprC0cfYuweX+E7CJTiLOvDmzU1VpIEuuJPHHFljd3BCMGWCXPzqxK8KChLvQQv
	 YgoBCuKWZnEuIu7g+LD2bIwhdAi2bq5g3OAmo/x+OQ0qxlJ/qOPf/2bVoEeHwm1+A2v8N
	 Xa7jokxD0rnYxA4fvVwwZX+L9I/pgJwyGSXKlIC3L1gAS8cBJhzJ2PW8h8XMOvE7tyCwq
	 HqnBFHuefheI4PKdYkqbgdzFBRDL6BMxWC+4CxiAp0kiGJsgCp8zSpDKPDFczobpxv1o7
	 ihY1Qmbf7+eOTfqoKhNG4aMSjtKg19VSCy7cEccKDluE+5Vl+oGCBeY8Kvr4k6cydDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795534664;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=+32k9Hf4zeGsyvS52B5FpmIYGyKPiAuii+eDViumiis=;
	b=cmyvg+EFLerQCrViTHQn4QV4BN012kcNvEE7MdbXRC5nHGaUs6ZDQIKi9SRKC+bAndvc
	 ozVR4Nut50r0scHPDC3LnGjxHtYcEepsPhr9ZMYC2+prGp/36KwB2lRgXmpVAUUBBNV99
	 Q/NmoAmNDyfMRwnoyBjbY0Vg1+QyNycMA0CvApluFxlit4yEfiA+etg0gcF4oPvc9215j
	 9vz1Gdh69E6df30umSMRNTkQ0duLDw+HCgIBHk3tMeJA0YkTO4wW3zFMye0hJdQS2TX6d
	 K+m5CY2029ctjvrefJEjOg142pLX5JS55rdUdv2Y1uuGIIq9hks3ggQalYxzZH+96vA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLfcv5PH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A5D606A33E
	for <linux-trace-kernel@vger.kernel.org>; Tue, 24 Nov 2026 15:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DLfcv5PH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218DF1F000F2;
	Tue, 24 Nov 2026 15:37:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795534664;
	bh=+32k9Hf4zeGsyvS52B5FpmIYGyKPiAuii+eDViumiis=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=DLfcv5PHVv9m0uxOa0aYXgxPYgdiLYA7F8WxueAXlog8GRtb3rA+3UMpQzgEi8U9E
	 YNlQmfTW7JDz7Ddw3nT/dVmNp2zS3B0yCSYrKP/pr1osD6Da7qu6etWGxfl+B3Z1BR
	 o4LESZGpR0lKhFtwN15IKzozZ4P+vZ/75os/cB8CFE+PecHRN2RAu3Y2MLjU6j5lKk
	 Bc/URPS9YPwuHtFWdeE2Y0ZEqJKrzwQfr21UjTcK+z0dGz50fHbD2+yi0bORuYGums
	 WVghHtqS6cjkwM1DZFwkRZ2Y/TPvW5gsfppS3BShkMG6mfAjvU+tAdQ8s5gJe7Jf5t
	 vKfzI4skqPZSA==
Message-ID: <sashiko-outbox-231428@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v9 02/21] tracing/remotes: Release tracefs,eventfs on
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Vincent Donnefort" <vdonnefort@google.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261124152845.2233401-3-vdonnefort@google.com>
References: <20261124152845.2233401-1-vdonnefort@google.com>
 <20261124152845.2233401-3-vdonnefort@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 15:37:43 +0000
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] tracing/remotes: missing Fixes trailers for
  trace_remote_register() leaks
--

commit 2df3cdec0ae59289a28563a98eef48f985945fda
Author: Vincent Donnefort <vdonnefort@google.com>

> tracing/remotes: Release tracefs,eventfs on registration failure
>
> In trace_remote_register(), if registration of events or the init
> callback fails, the created tracefs and eventfs directories are leaked.
>
> Release the entire eventfs and tracefs hierarchy on trace_remote
> registration failure.
>
> Signed-off-by: Vincent Donnefort <vdonnefort@google.com>

[Severity: Low]
This fixes resource leaks on the event registration and init callback
error paths in trace_remote_register().  Should this include:

  Fixes: 072529158e60 ("tracing: Add events to trace remotes")
  Fixes: bf2ba0f8ca1a ("tracing: Add init callback to trace remotes")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124152845.2233=
401-1-vdonnefort@google.com?part=3D2
