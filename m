Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362397;
	b=YFA1sHJslg3D21+9/wyhwfCrC/oY3S8IG4DGQ5/Jcxe/cLI4hxTbcLT3HkG+ra2qDnX9
	 /BHgbs5lIYTxPhuHavq9af087tuyItRSyBAwSYqCAVYepZTskG8WZNhZ1nBKwIq+i6OU4
	 hthNdrkfIxKBPIDxThhwvdyLruhklMAmpE0fSWl5Al42tp+Q9io31U9O7aZkHrcec7wQo
	 GE0W9HDzHwjmOnDL9c42eFedTyk3ZwlvQa6btqniqznjPVp1kcDhuBdCZzBoakIV4Lgf2
	 6yAnzAgcCKP3ejM43lsUAxv1l6IZBi26BeWLX9AwbxQuc5bN/z62Ik9oKr0SIU/Sk+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362397;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dmVHxG1GtdEPSKN6PpqEzxIrLNE5uPRF+L/rSJvJ1bk=;
	b=HEf8/58CKKST8IDYxWmaIh5Y4GqldURpvgf+IeKWl4gKdBES26tUt00dioAHi4X6Thbk
	 oWkdNoEKYWsX7Wub8nJsvEfc8UoPpXutZ61QHHoZfySNV2sIeLIQQpWbEcfAxadA3zoa0
	 QwSqwXRmvkuoOq9T2tAeHVqM/jc7No/5XiRCokbd7XWLlE71XzWrDEMwae+UTotcl4m0g
	 nNLl6M+B0BptTOGgeMuZyIkuKa4xaNJIx2kU4GrSbEmXuLimpiaYr1hXHrJT0dkv124W7
	 B3RiPToon+ux4FdqcNLruU+avEIbCRqXcIzSQ5btFF016++NuU9182o/7htUA3poYkA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXLBwNNZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B1D9606A320
	for <linux-trace-kernel@vger.kernel.org>; Wed, 11 Nov 2026 01:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AXLBwNNZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AF181F0089F;
	Wed, 11 Nov 2026 01:59:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794362396;
	bh=dmVHxG1GtdEPSKN6PpqEzxIrLNE5uPRF+L/rSJvJ1bk=;
	h=From:Subject:Reply-To:To:In-Reply-To:References:Date;
	b=AXLBwNNZBo1l8bmJE1El12+SfVCiW6mkizP5Ax0QufsBlBAbi0qrtfvLOTz6kQ4e5
	 JLcpD0hEA1ZH0pzpmKyEP/eRrlRy3KQuah5gp0do8nGKrny7VSw01EVNPdagmPnT9J
	 5LbT/e/l2XeQCaMW73BYPWPumk2u06eFK0NyuAKdwx/Xjtajx3idrOulcR2FspEJNC
	 x6jvI0tMISSEXMDPEwD77AXBir+gKeHmtX1m5UGufBIlXMbGtrD/qfZu8oduhtWH+H
	 M2/nlyhVP6OH6foZdxyz7yPShftbsdVpoz1ECGk0gSyiIUa2DuLQTgdNatNK7EN2jw
	 c4Ekxk7yYLmWw==
Message-ID: <sashiko-outbox-208063@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] ASoC: Intel: Remove unused sst_ipc_inbox_rdata
 tracepoint
Reply-To: sashiko-reviews@lists.linux.dev
To: "Temitope obabi" <obabitemitope765@gmail.com>, linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261110132013.732-1-obabitemitope765@gmail.com>
References: <20261110132013.732-1-obabitemitope765@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 11 Nov 2026 01:59:56 +0000
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
- [Low] ASoC: Intel: incomplete removal of unused intel-sst.h tracepoint
  header
--

commit 47a1bdb679fab28a368c73c42b9adeadd92a9bea
Author: Temitope obabi <obabitemitope765@gmail.com>

> ASoC: Intel: Remove unused sst_ipc_inbox_rdata tracepoint
>
> The sst_ipc_inbox_rdata tracepoint has had no callers since commit
> 970d299b0a0a ("ASoC: Intel: Remove unused code") removed the last one.
>
> Tracepoints that are defined take up around 5K each, even if they are
> not used. Remove this unused tracepoint.
>
> Fixes: 970d299b0a0a ("ASoC: Intel: Remove unused code")
> Signed-off-by: Temitope obabi <obabitemitope765@gmail.com>

> diff --git a/include/trace/events/intel-sst.h b/include/trace/events/inte=
l-sst.h
> index 0416e91f81817..ae7c269b0824f 100644
> --- a/include/trace/events/intel-sst.h
> +++ b/include/trace/events/intel-sst.h
> @@ -69,14 +69,6 @@ DECLARE_EVENT_CLASS(sst_ipc_mailbox,
>  		(unsigned int)__entry->offset, (unsigned int)__entry->val)
>  );
> =20
> -DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_inbox_rdata,
> -
> -	TP_PROTO(unsigned int offset, unsigned int val),
> -
> -	TP_ARGS(offset, val)
> -
> -);
> -
>  DEFINE_EVENT(sst_ipc_mailbox, sst_ipc_inbox_wdata,
> =20
>  	TP_PROTO(unsigned int offset, unsigned int val),

[Severity: Low]
Should the entire include/trace/events/intel-sst.h header be removed
instead of just sst_ipc_inbox_rdata?

Commit 970d299b0a0a ("ASoC: Intel: Remove unused code") deleted
sound/soc/intel/common/sst-dsp.c, which was the only file in the tree that
defined CREATE_TRACE_POINTS and included trace/events/intel-sst.h.  The
remaining nine DEFINE_EVENT definitions and three DECLARE_EVENT_CLASS
definitions in this header also have no callers.  Because no translation
unit includes trace/events/intel-sst.h, none of these tracepoints are
compiled into the kernel image or consume memory, so the commit message
claim and the Fixes: tag are also inaccurate for this cleanup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110132013.732-=
1-obabitemitope765@gmail.com?part=3D1
