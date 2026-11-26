Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795661289;
	b=b/6m8pUOYbGa06V4UpHJl0FUasXblNL5TAa7+VzBudF/CwlVzzzcpQnJKzmlRGE2dCIy
	 4h1eR8ObuQRLm9H5AwaVWhS8RvZegLztUQ/FA3ydObTcDUnnV5Ir2LndkF6rYz0jkmZxZ
	 g2aCRv83eaDP6szM6sdnzPxv2NO8NL0eJx70tJXHqoj1etKGO0KkOEhSxbQGM2/qQOcSx
	 xBnl5bVCpYSwEVEGG90nfclaISPlW/5PK10W98fG6+eXwrGZXDgpmwGMO8vAuC79XKK4n
	 pccRzJRL55MRHaXMt9f3i9TVhGxksvRpCadr5lOOUU4kHiEmg13XJZEDgEDJrNkgsNg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795661289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=a4UooRjr4WQIm/YSDWZVn1PRiWo1ne7R7gUpEV8Vme4=;
	b=jTp8B3PjY2ZAdr8JUsWIlvstiKEOm48qWuXuFa1TU0s567EMmzN6Vd+T0BjPf3tMWutE
	 MJrfEomlpbDHepF2g8BvFp8yvV0ly+L5dSnzKIcPcm7tIlHrpoUqC5+D3DNgd0ea/Hu/c
	 6RwvMlTmQXysRMMlM9f1nVSRgivZTUCfs+4kJbDhegypN0AZ5qvq/taQjrtzDsPauEGEq
	 47AbTFT9guYkhKtjibo7Rd4tr7fo+mMxHxGUdCN00MVwyEqXp28/eiLNBmjyiEVKIIBIp
	 qpXfW/0I+RQtYvvKomBg6NVR5rnPp2pcFBPYpM11kiPvjAQoMQQGYSVms4mzrcxpDtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="P0hskeS/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D68606A31E
	for <linux-trace-kernel@vger.kernel.org>; Thu, 26 Nov 2026 02:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P0hskeS/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68B21F000C6;
	Thu, 26 Nov 2026 02:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795661288;
	bh=a4UooRjr4WQIm/YSDWZVn1PRiWo1ne7R7gUpEV8Vme4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P0hskeS/HnCn/C59vUFzTCkqTIx1D/Q06ON2AbA1alCD9DeoGbtHtPR/BR5mR53S5
	 vDszfJ6dtwsJFQI5YXdQu3JYodYAlOTrn6F3ttSr+SKa+I5MuAgf3iOCbsNMmbTcQU
	 7OVRYu+1cLgOYHfdhPIbQAlgmuNrZJ+Xd3DdKYwAUTPB3iMlCipKx33pbUQOr2w8RD
	 lqKAnyaEwa+OgWSBvM7K/WcqCdg0yIQjFi2pU3C35EwNsDH9dC/GIp1Z28FDh9tDe6
	 kerdDp5Woxn+bC7ZaddeWUEVm9o+H/V45DTgSsYeii1SA0bVvTXgGqt4NWIIdjpbYf
	 qIdtJA0dxOYVw==
Message-ID: <sashiko-outbox-234661@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/3] arm64: Always inline raw preempt count updates
Reply-To: sashiko-reviews@lists.linux.dev
To: "Karl Mehltretter" <kmehltretter@gmail.com>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <5ba8c2a33188f43f0b1d99d6ba97c8ea2e285f94.1795631277.git.kmehltretter@gmail.com>
References: <cover.1795631277.git.kmehltretter@gmail.com>
 <5ba8c2a33188f43f0b1d99d6ba97c8ea2e285f94.1795631277.git.kmehltretter@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 02:48:08 +0000
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

commit a74839092cf53755b620bd601b786aba597286cc
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
> Reviewed-by: Hongyan Xia <hongyan.xia@transsion.com>
> Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>

[Severity: Low]
__preempt_count_add() and __preempt_count_sub() were defined as plain
static inline when arm64 stopped using include/asm-generic/preempt.h.
Should this include:

  Fixes: 396244692232 ("arm64: preempt: Provide our own implementation of a=
sm/preempt.h")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1795631277.gi=
t.kmehltretter@gmail.com?part=3D1
