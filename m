Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794185166;
	b=iPj4w8Sc5ve0u3yz1wjAWoei9cMfLMoxI1k5grTZwmDPGAYEuSUoOjM6m74GunIVfT0M
	 KTVHrYl5X4UknRtTvB6LMuZjWhY9LJ1jZMIsawmahQ/keyVI/iTUsO/5AHRQ9tpU4lKjX
	 LkxDjpthHa0rFZ/WlRjjnxtzzG3dwIwuONsnj6zNGgP1uRzP0lT2nk7or1mUmaStOAx/n
	 FadVZhP0p+m8YvSJ0glZdJvorlKmQU1BGLciAyYDZCKT/5IyYGcE3yNJ/8mnTK+T6EKUK
	 TBedsrye0w9gdC1EmL6SgqLFpdUl5+HYwKAszw9bAkV658BA2oCabWoK89XPRMsnTMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794185166;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=CVRsGO/wjjfOw1WgM9PAQZvNbtr0VcqhmWT2c0XZ2zY=;
	b=POONV4mtfy1oBevLWP1Dle0jwt8UH7r2Siiu+8s0yr7H8y4Frjaz60ICBYquwwl/Wztf
	 3djsmcz0dgIF2prttLyMUSKl0m/8DZYhPhJZrwYydh2sdECoAi5oPUTf8kCMqW5DSmJSm
	 rHx6QolhRfbBP3/k/dOfP+3+9w5rsgXA1tI08KUGqYYIcNoyTrn8JJYIBBtZKQf6xefPt
	 GBGsCq4idwu/oJXOp9SaJvWlrQBgEL70LiGjK/iV2ASGvUvpE9/SFc2a94o0g2PjH1Orb
	 oLRThL1+rjGbiPYv/Cm78jh+OMJdL8slkJ+UiPcucqWtyJG7S88HFDVd5eKV3W/LUNQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkyxM2JY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87F2B606A31C
	for <linux-trace-kernel@vger.kernel.org>; Mon,  9 Nov 2026 00:46:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LkyxM2JY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 478AE1F0089F;
	Mon,  9 Nov 2026 00:46:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794185166;
	bh=CVRsGO/wjjfOw1WgM9PAQZvNbtr0VcqhmWT2c0XZ2zY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LkyxM2JYCw/E2z1Sb7ehWdPBlc0Bkc41pAo2iNlUrLduFahGtZAxALlx/4hVHld2e
	 nyamWFwZgzGKhbR8tcSx98QPU5v0z8bpSbzK4phkAYxDEfE6xmIhW/2Jl0BNtvTJTK
	 caiFN4khW8zHtZIGzwoX31kpIEoLK6PqaefErQWapUw6v/1T1OyPJ56kWAdyIuJNkJ
	 PAOI02/siBUZtO1Kr5tbhEVZF3jBCfHJMWpIieibjKa8MHNLO1Q5RGoqCKYepMYIoC
	 A+CquCcF10RfloNE6z0VAmdXWh6I6RRPKN2mCofMRqhwx0ROF36sbz1zm7SPog0ZAW
	 y/cR4RukSyr4Q==
Message-ID: <sashiko-outbox-204255@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/12] tracing/probes: Propagate error codes in eprobe
 and fprobe creation
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWFzYW1pIEhpcmFtYXRzdSAoR29vZ2xlKQ==?= <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <179418419198.227715.15433232608137637935.stgit@devnote2>
References: <179418408457.227715.1485179201014819821.stgit@devnote2>
 <179418419198.227715.15433232608137637935.stgit@devnote2>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 00:46:05 +0000
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
- [Low] tracing/probes: missing Fixes trailers for overwritten error
  codes
--

commit 435aff670b6c20ffbcde000e1c0b092b53b663a8
Author: Masami Hiramatsu (Google) <mhiramat@kernel.org>

> tracing/probes: Propagate error codes in eprobe and fprobe creation
>
> In __trace_eprobe_create() and trace_fprobe_create_internal(), error
> codes returned by helper and registration functions (such as -ENOMEM or
> -EEXIST) are overwritten with -EINVAL.
>
> Propagate the actual error codes to the caller.
>
> Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>

[Severity: Low]
Since this fixes overwritten error codes in __trace_eprobe_create() and
trace_fprobe_create_internal(), should it include the following Fixes:
tags?

  Fixes: 752be5c5c910 ("tracing/eprobe: Add eprobe filter support")
  Fixes: 08c9306fc2e3 ("tracing/fprobe-event: Assume fprobe is a return eve=
nt by $retval")
  Fixes: 8275637215bd ("tracing: Adopt __free() and guard() for trace_fprob=
e.c")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/179418408457.227715=
.1485179201014819821.stgit@devnote2?part=3D12
