Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794816997;
	b=Q9YHh/xlTds3PdPKKLYYfvhd6VMud9wI0KOAYFO5YsOo7EOqV3Usk3yjdybNa5IfYDKf
	 LT/VcsmCRI4xsIpNDoXQIh3FwYd0loSk69/DxLAfWiF/uqK1rR5DWAUr+M2yF3Wd3K3+/
	 0Vg3Zt/GGAAgpCPVUq83MXeHgFmbzpUebiKNcmUsNKFh5hAZaDBTpW3sqi/Kp7kAOTkMx
	 aMYJC+jBIYMDP4Ba54vX+wuJ9rNN5W0E/iFOBZwmh2nNo6GH9IK3LKaF6areDw4jKSpdv
	 GCP/htX+FCGZd2wsGMT7x27mE92P1RCBZtXWiAwp/wjSITaCvhGfvtrTUODcqrV04jA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794816997;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=9hUh1OVjqlDe3uFL9CPqttH6iazGr+Pi3oQ98WpM1NI=;
	b=Kzs7hu5Mo1exMLJOSHNLuVm3hnLePcKnPLyE7GOT02kyRzonaBIDTvskXDyG1Vv2rBfr
	 E5SVq4Xz7muRyz3qB64hbyEcGWyqqGT4etHzIXFmuGvhSC86vliiaYhVMzLXplpzTOtwN
	 JzcwO2w0mNuMNn+jmx54taxJBQfj1FhYNJzdOeHmeLXXZDGHEARQ1/5qxxBxXtKKeonAU
	 OeVPlJ2FHOff4xKy99cRpfvD8CPNx1I4pCRSTFkE7XHjtNEgQ5gfHF71EqQPAUq3BIfUj
	 GZ8YYD/7VkVJYiOvjCvSZx8B5lwqZQ8XhzTn5b86oNywYic8aoDZ4voEpF5wJjkhAtA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhRMFc7d;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB52606A32A
	for <linux-trace-kernel@vger.kernel.org>; Mon, 16 Nov 2026 08:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FhRMFc7d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F65A1F000C4;
	Mon, 16 Nov 2026 08:16:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794816997;
	bh=9hUh1OVjqlDe3uFL9CPqttH6iazGr+Pi3oQ98WpM1NI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FhRMFc7dacTIg5cUxOelCFZWueCdQCYg7e1qAkrgFnnM1/UnR0N7tJPaf3hWEFW0G
	 I5RvLzPqHsTPDAPOkkLqr6VoFdJzRZ6LmbgKuDoDl+RTPdNzj/ALX1FWv2yfo5rQRs
	 1a1WxEFGmfu55zHxIk4cZh21tXBPbJow63DDr5oFrvXDLKr1H86cW416+UaQNcolBR
	 99UZECJWJ45vucsywvCE8mGCDwMMZDoaiqcJ0H3BPqwlyzE+19+P8ZHUq443EuqEoJ
	 CwpikZGQ0Cp5jEY6JM4mR1XwJ6k2bY2IhKRk3DX5NjCK+p/IkPaDpuoxrfe9gDkxhV
	 7iAsot/wUwZxg==
Message-ID: <sashiko-outbox-216519@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/3] arm64: Always inline raw preempt count updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <23dc25d010cfeb8eddde12be5212fd73bf1cd5c4.1794814699.git.kmehltretter@gmail.com>
References: <cover.1794814699.git.kmehltretter@gmail.com>
 <23dc25d010cfeb8eddde12be5212fd73bf1cd5c4.1794814699.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 08:16:37 +0000
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
- [Low] arm64: preempt: missing Fixes trailer for commit 396244692232
--

commit 0e970117f0bbc0e074b2a0e827bc00ba6204a7cc
Author: Hongyan Xia <hongyan.xia@transsion.com>

> arm64: Always inline raw preempt count updates
>
> Raw preempt count updates can be emitted out of line by the compiler.
> For a noinstr caller, that puts the update in ordinary instrumentable
> text. Force __preempt_count_add() and __preempt_count_sub() inline so
> their code stays in the caller's section.
>
> Link: https://lore.kernel.org/all/c3a90368dd6c096af9d918e036a27728696fb8a=
4.1786603168.git.hongyan.xia@transsion.com/
> Signed-off-by: Hongyan Xia <hongyan.xia@transsion.com>
> [kmehltretter: split out the arm64 preempt.h hunk and rewrite the changel=
og]
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

[Severity: Low]
__preempt_count_add() and __preempt_count_sub() were defined as plain
static inline when arm64 stopped using asm-generic/preempt.h.  Should this
include:

  Fixes: 396244692232 ("arm64: preempt: Provide our own implementation of a=
sm/preempt.h")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1794814699.gi=
t.kmehltretter@gmail.com?part=3D1
