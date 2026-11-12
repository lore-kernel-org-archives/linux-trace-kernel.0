Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794473632;
	b=S6HPxFeKD6ZeHILRBrKmkliAb4gZHn8v0Y6Nt4DhYzDurdW3Iqh8JbHLJRCBCdc02jnd
	 ZkzMPotZeBhgclODjpr5Cb7N4Kxe2CqNdV08ksoHT5adsxFg8WQMm/k4H/Q7L1fH6WrzT
	 4enzrker71fbM+Xlw2j2q8Gb0X2X42UgyQuqpPA25JoHVlabdzNg/kKznUcsolEaVqeHe
	 b5/eu/VMfhMjeuypF439WNh67Z2EsOYQrQ7S1gGyR+yd4tpLupjvs7YOIm9xmYxoMNMXA
	 GVykSmKhyrbk8btHIFEzYfAyOCVBz4ScRhMIpbb0IiSKqEFUYbWCI1ObaePomLQEJEQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794473632;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UQ9emlMaFoAcvmYUlt2Pmf3nEAbWnXrl3X9dAHK4up8=;
	b=5tqqln5zUrVUnq/OC++SMwcBOtmqSLbqashRpo32hB48PCmDqjry45jbHd1EbQdEYwmO
	 9tevAGELp/jvnZJgmmuLOkf+BjpgnHwaVwzxalWPot8sjtuUc2OYbrEIG+LwLVjHHf5yC
	 Zrt0rUlN3o3AvCe+vcB7Gs7Y0boX0uEYXN7AWKX3KJuFaZwQPMQSXkLiRaIoaodulSTI5
	 I+gv6IbU0a/V4eCy0jNEPDEGanItsmlUKMaCkU4vDg/aa2iunIRWRcnRe8jQgPfOmlIkI
	 sTjuMu/YP0GQwQApCQcYyAtuqBsu0eLuOVdBJ3aHTpy3n3PG7P1c5XWiwTyeczXs6EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Cs/PRHvp";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085C3606A323
	for <linux-trace-kernel@vger.kernel.org>; Thu, 12 Nov 2026 08:53:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Cs/PRHvp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A4FC1F00A05;
	Thu, 12 Nov 2026 08:53:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794473631;
	bh=UQ9emlMaFoAcvmYUlt2Pmf3nEAbWnXrl3X9dAHK4up8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Cs/PRHvpDyHFrtQE+WvFnaVfS5k02vDlQaGg1nFzq/cMFRBVpRaYtR3qB6YPIW4eU
	 7AudSwdtejLu/ipzG62euHP4cb0vPwUfoLdPYuOLB1WParXxj3IehpT3Cqy+PnPoEi
	 7yRnjPclNqBoRkNwNyKIbjVt8CDqx6wtktpWilw9ZAfhOAzCls2B3pOaBtTX/vJAu7
	 5Dy3tcb7AeVXFe7zGcJWC3iabM0sVuATzr4xPFHk+REPrX/0c90I06dVybsyNp1a7E
	 z8gkMlkfhfcGxgc2tsVrIonC3jSDNAjS4PZB1Wo6jG+IilsYXpHGmRUNrpU/1UvTnT
	 UlxddyMCH/egQ==
Message-ID: <sashiko-outbox-210795@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] docs, kprobes: Fix bracket
Reply-To: sashiko-reviews@lists.linux.dev
To: "Manuel Ebner" <manuelebnerli@mailbox.org>
Cc: linux-trace-kernel@vger.kernel.org
In-Reply-To: <20261112085017.690228-1-manuelebnerli@mailbox.org>
References: <20261112085017.690228-1-manuelebnerli@mailbox.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 08:53:50 +0000
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
- [Low] docs, kprobes: malformed Fixes trailer in commit message
--

commit c35d77f88712122a91a1dfc589d48b23975ce7cc
Author: Manuel Ebner <manuelebnerli@mailbox.org>

> docs, kprobes: Fix bracket
>
> Remove needless ')'
>
> Fixing: a1dac767622c
> Signed-off-by: Manuel Ebner <manuelebnerli@mailbox.org>

[Severity: Low]
The "Fixing: a1dac767622c" trailer does not match the standard kernel Fixes:
format, so checkpatch and automated tooling will not parse it.  Should this
instead be:

  Fixes: a1dac767622c ("kprobes.txt: standardize document format")

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112085017.6902=
28-1-manuelebnerli@mailbox.org?part=3D1
