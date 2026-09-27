Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC8E02D5937;
	Sun, 27 Sep 2026 17:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790529129; cv=none; b=ZtzvDkecQLPiNGp+n3x8UuqKKHAdiYwuGsd1gLfPOr618JFBeOUl3F+90ZzBRH3ukaqpbz3LPvqhiurWfngqJ1wxteVoxFIM3Np4PpGjNrIrrstyZnEjFtzvXXpj6ZCAMrTzdz/ecGR5mWJGv+BvlSSMuFaNGW2IW0Q5VF86pnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790529129; c=relaxed/simple;
	bh=l2rdfyuPF2zzfUOT3dDgb10HJN+CTB0CbkCjWUMcnj0=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Subject:Cc:
	 References:In-Reply-To; b=UMuQy3+JFdJtz6svL0BbKJZ7+aA1uzcGNNcr3A3tAy/puJlXs9nPccl7jwJYHhuHfhzbtWCHXrrsr+ndvvdlUUEyqymYNvkrMHgmheITRO+zqB45OTVARXWE0pl3rIgmKs3pfyOQ1BhjmK1S44g8E9f/iomdu/YVPeO+QycRHxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SuxHZEKd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SuxHZEKd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C7661F000FF;
	Sun, 27 Sep 2026 17:12:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790529128;
	bh=DN8VjDZQcUARJxOzypVnhQuk4bQIW1/LaeRVnuefdhA=;
	h=Date:To:From:Subject:Cc:References:In-Reply-To;
	b=SuxHZEKd12HuABQoVmKdtypHJaHvdUmTj8zBolY9FVMubi3Mv4FC5aFZYflwCA8Eu
	 E4eul18dJZma40f3BB2mnlNi4LZOmH5LtZ3Vpf9ND0iNt0yFNn8HcEe301H50cBUZt
	 QipMzwTxV/ZAlXnfTqrfvhnf5eEGPJl1fTL83WNoI32wY0rFIqAEVlZUnzunYOMNUe
	 PLqdJJbdDaA9w4Ly1xOmLTOYKA/3Ditrs3owQhYjRt5sPw73qzHyP0nPLaL/LjqIHI
	 soS/ofU6DplEd2PzR4cY7lxd89gVmjLP1D6ZBYUnafr29aL8jIe6riQHu0iLPH24ig
	 tsx5XvPsTIkSg==
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sun, 27 Sep 2026 19:12:04 +0200
Message-Id: <DLQ9LOHGKFWY.2L399J3OOVOCM@kernel.org>
To: "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
From: "Danilo Krummrich" <dakr@kernel.org>
Subject: Re: [PATCH v2 2/2] Add TAINT_DRIVER_OVERRIDE for usage of
 driver_override
Cc: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, "Johan
 Hovold" <johan@kernel.org>, "Aaron Tomlin" <atomlin@atomlin.com>, "Bradley
 Morgan" <brads@mainlining.org>, "Thierry Reding"
 <thierry.reding@kernel.org>, "David Lechner" <dlechner@baylibre.com>,
 "Armin Wolf" <W_Armin@gmx.de>, <linux-kernel@vger.kernel.org>,
 <driver-core@lists.linux.dev>, <linux-trace-kernel@vger.kernel.org>
References: <cover.1790495516.git.u.kleine-koenig@baylibre.com>
 <01d7a085e56b860e83b65c96ff3dd86c4498804b.1790495516.git.u.kleine-koenig@baylibre.com> <DLQ0BIYP96RN.Z0L5I17RQMRQ@kernel.org> <2026092702-negation-stoppable-b86e@gregkh>
In-Reply-To: <2026092702-negation-stoppable-b86e@gregkh>

On Sun Sep 27, 2026 at 6:50 PM CEST, Greg Kroah-Hartman wrote:
> Huh?  That feels wrong, can't we fix s390 and spi instead?  Ok, maybe
> not s390, but why is spi doing that?

Solely to preserve SPI's existing output; when driver_override is unset, SP=
I has
always printed "\n", whereas most other buses print "(null)\n".

I.e. SPI previously did

	sysfs_emit(buf, "%s\n", spi->driver_override ? : "");

now it does

	sysfs_emit(buf, "%s\n", dev->driver_override.name ?: "");

and the driver core does

	sysfs_emit(buf, "%s\n", dev->driver_override.name);

The driver-core behavior matches most other buses (except SPI and AP).
Switching SPI to it would have changed the userspace-visible value.
