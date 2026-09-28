Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C82274F55DC;
	Mon, 28 Sep 2026 21:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790632388; cv=none; b=OnrCGAZBxRTn69w7brYIJfmd1CdyF2o8vvAbY/1uhbBqZcViqmaEMssbwLxJ08VOwP8QiWMgqaGSSVt9zMwOJN2Hf2DvpszHhptpUOmt58fHKyDXcbdvRPzZOD6JojQmu+BOBfufrGBwLbF5yz+H/+7MRkzBqWpkQ/5Q0nCca+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790632388; c=relaxed/simple;
	bh=tJ+0V1mbVBn8Zwcs4tOaPLg0sZgAEuTLoqyldzfI2+I=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:Cc:To:From:
	 References:In-Reply-To; b=VOk+Bzy5cHVmTNrU4EqlVjTNMH8rwRwp5ECgqxd5OtijbUjXlh8xORkZGqkYigzywMbe6fGnLi7JlgqdfnqMoeAj1Ox7AMS0PpqhwZFqOHVYZ6ZOj20w3IY2rZN/F9WvMduPS26WVJDUllI3a8yPunXZIQss2afm0zR+CSQhnkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VRGepIkJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VRGepIkJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 364611F000FF;
	Mon, 28 Sep 2026 21:53:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790632387;
	bh=7GNggjbhsrP2PRYGVyZYr9s9G2zHY5M8Tdk8PSoFgzY=;
	h=Date:Subject:Cc:To:From:References:In-Reply-To;
	b=VRGepIkJSLhGbuR3/4mmV4dyQpNLPdRGk3z4ho38qBNC8+INbNuF4nTJ5Lazg1gLh
	 ZQlJ0JW70wLL7YokRMVNmX4H4x9vbYwMkw7E+6hmjPw51uQCgujyoqtRSBziJoO3ED
	 H94D+lV51YeEGjfrWXO1AEHHm166+LKoIguyO0xadH0PeUzqIbeNdq79UTe3yuFA0L
	 rJOfg3L9+TbW73PEaXyFx551VMI59YW7uag/TnL1ug/hAWM5WwXXKTmQNVW1ZKSquT
	 ju2PfFwQ9na4yxI+wEDGfKUtR1bYTamUib87734nlLnXAKunSFTSHNEaR1U3BSxVit
	 4OQ37XTZMKfXg==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 28 Sep 2026 23:53:03 +0200
Message-Id: <DLRA7CWTA1K4.K2BCBX8MBNHQ@kernel.org>
Subject: Re: (subset) [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Cc: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>, "Johan Hovold"
 <johan@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>, "Bradley Morgan"
 <brads@mainlining.org>, "Thierry Reding" <thierry.reding@kernel.org>,
 "David Lechner" <dlechner@baylibre.com>, "Armin Wolf" <W_Armin@gmx.de>,
 <linux-kernel@vger.kernel.org>, <driver-core@lists.linux.dev>,
 <linux-trace-kernel@vger.kernel.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
From: "Danilo Krummrich" <dakr@kernel.org>
References: <cover.1790612298.git.u.kleine-koenig@baylibre.com>
 <20260928215127.1811259-1-dakr@kernel.org>
In-Reply-To: <20260928215127.1811259-1-dakr@kernel.org>

On Mon Sep 28, 2026 at 11:51 PM CEST, Danilo Krummrich wrote:
> On Mon, 28 Sep 2026 18:46:01 +0200, Uwe Kleine-K=C3=B6nig wrote:
>> [PATCH v3 0/3] Add TAINT_DRIVER_OVERRIDE for usage of driver_override
>
> Applied, thanks!
>
>   Branch: driver-core-testing
>   Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/drive=
r-core.git
>
> [1/3] docs: admin-guide: Handle TAINT_FORCED_BIND when parsing /proc/sys/=
kernel/tainted
>       commit: f1850e443b0e
>
>       [ Fix a typo in the commit message. - Danilo ]
>
> The patch will appear in the next linux-next integration (typically withi=
n 24
> hours on weekdays).
>
> The patch is in the driver-core-testing branch and will be promoted to
> driver-core-next after validation.

I've picked this up, as this fix is independent from the rest of the series=
.

Thanks,
Danilo
