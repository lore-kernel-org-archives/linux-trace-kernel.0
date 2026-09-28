Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A991F427C;
	Mon, 28 Sep 2026 17:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790615718; cv=none; b=lnnpMPzgISDY8wS9wLwQBLMcK44ux7TrgWKzHLBs4zwCdJ7C6+P9Xckzba5PcW9OmXZBM/JGlo3I+G/zbdFMCXC5XvX0ytvJGSVOveXdLvzws9HcviLTd+WBP5vSfp6QHH0Wfr4n4NvE8NTCADRtRK9xTLyHe6M9My+gqZi+yas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790615718; c=relaxed/simple;
	bh=qQ2LR/9f8UMs3zllYihv6dnst1HW4XOLUBZavG4K210=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=e+RuvjuOrtvVdGTDrZxUtapO6ajFOfVVgIlJ+jU+AUrRIUGZrHqk0eCjGSUGfunTAc0uQbyJ3mEPARqR4RGPKpEKZe6G22jvTk8EvKfq3IE5hQ3lbBxJP2ruLTFgsuPmE2r+OAKCpj5xOExQqBBfbMoTPLoyzBmUM+o8OIOqfM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bkOvZWFW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bkOvZWFW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 924841F000FF;
	Mon, 28 Sep 2026 17:15:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790615716;
	bh=qQ2LR/9f8UMs3zllYihv6dnst1HW4XOLUBZavG4K210=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=bkOvZWFWjc/sTyX8rQkj63kGUBZ81dQArvJRyu4iFNnLXN1QYQ3s8e0dBcBWMLy3x
	 V4vhw/lvHGDyjpj5z9qIP7lykzd5sG0T0lcs30miO+z9iI9YcK+/fVonUMIzo1wKF3
	 bnAN/XQFT5pCHLJCYCZUWxBb3cRxzCNVlB06QuiVlvroFiSCESqDWqEUgIQZAeAh2y
	 tsQ0elSnWNrLgWur/K4NlpC8/TwLV0PdLtyRt/Qwum/a7Nelhh6MXzKwIXmtMip9Xr
	 3iNAblQg63B/Xt273KXsAVtSV9A5DEZ7aw5uRjYE+v5EDFSAs66UV64BmoQ5xUQQqe
	 g9ZZ0kdSsl5bA==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 19:15:12 +0200
Message-Id: <DLR4AMFM8QZ2.36R6G0LD9D53Q@kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Johan Hovold"
 <johan@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>, "Bradley Morgan"
 <brads@mainlining.org>, "Thierry Reding" <thierry.reding@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-trace-kernel@vger.kernel.org>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
In-Reply-To: <cover.1790612298.git.u.kleine-koenig@baylibre.com>

On Mon Sep 28, 2026 at 6:46 PM CEST, Uwe Kleine-K=C3=B6nig wrote:
> Note that different to Danilo's suggestion I don't differentiate between
> driver_overrides setup in userspace and those setup in kernel space.
> IMHO all are bad and there are alternatives for the legitimate cases.

I agree that the implementation - i.e. (ab)using driver override - the affe=
cted
subsystems have chosen is wrong.

But, there is a difference between picking the wrong implementation and bei=
ng
semantically wrong to a point that we need to taint the kernel.

So, yes this should be cleaned up, but we should not taint the kernel for
otherwise correct code. Otherwise we could as well taint the kernel for eve=
ry
other abuse of an API.

> I think applying this complete patch set and keeping fcbfaffee51a ("drive=
r
> core: add TAINT_FORCED_BIND for when userspace manually messes with devic=
es and
> drivers") is too much, so this series serves mainly as discussion ground =
for
> choosing a sane way to prevent fuzzing results of only mild interest and =
stop
> patch sets harding drivers for driver_override handling.
> My preference would be to revert (or drop) fcbfaffee51a and then only
> apply patch #3. Maybe also keep patch #2 to taint if
> "allow_driver_override" is provided.

Agreed, but as mentioned in [1], I think it is also reasonable to only keep
TAINT_FORCED_BIND for buses that do not support hotplug in the first place.

[1] https://lore.kernel.org/driver-core/DLIL9H50MALI.3JROXYEEUM3KU@kernel.o=
rg/
