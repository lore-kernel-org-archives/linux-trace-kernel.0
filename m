Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EE0352034
	for <linux-trace-kernel@vger.kernel.org>; Fri, 14 Aug 2026 12:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786711064; cv=none; b=PJEHN+pgnFOwslsQw46ZN0KFn09EyQT65rxH62gak58ZRJmsy91EtPEyFsIKecbKxTpzJfSG4+en2tr7hZ5f8GVEaeD0+uGcTLsJVjGUgE3hoH/8g6EcSR7oHpUKHMlLSur++0KV9IQtpysz6+yO7jSLorpq5JD4LiYeDvtcRI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786711064; c=relaxed/simple;
	bh=0OmI+MAlkI+VWq2EwzBjebaA/kIESUAobH4WVEIDkcQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cvo6gWV45IbigvDzgVNzwG1OEZZAQQSsZLxiY9daHkrt6nYbTnfxT18jsgU14/D6Wk9zgzro1ZkmvBc2nIEB1btCyXofLAI55ldxWYt8Rn84n6H9/gqsatUH3OjD532r+eGTxyEODcfKcqOjHxl9b5UdQUYMJKc75ECacToki7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=SwKcURKB; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="SwKcURKB"
Received: from omf19.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id D05FDA2C28;
	Fri, 14 Aug 2026 12:37:36 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf19.hostedemail.com (Postfix) with ESMTPA id 2B99A20027;
	Fri, 14 Aug 2026 12:37:35 +0000 (UTC)
Date: Fri, 14 Aug 2026 08:37:52 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: sashiko-bot@kernel.org, sashiko-reviews@lists.linux.dev,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v5 10/10] ring-buffer: Make nr_pages unsigned int
Message-ID: <20260814083752.7aae77e2@gandalf.local.home>
In-Reply-To: <an7Muwh8LgL0_v5h@google.com>
References: <20260813131152.3589632-1-vdonnefort@google.com>
	<20260813131152.3589632-11-vdonnefort@google.com>
	<20260813135526.EF9CF1F000E9@smtp.kernel.org>
	<20260813214156.64d0b21a@gandalf.local.home>
	<an7Muwh8LgL0_v5h@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 2B99A20027
X-Stat-Signature: 8p75zb7t6jihppnopfrk48pwgttu89cr
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+VLlfaWOm+dCiGI1yM2jSnIyoIJJY+E5k=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=0OmI+MAlkI+VWq2EwzBjebaA/kIESUAobH4WVEIDkcQ=; b=SwKcURKB/T9yZh/hPQrWyMyzBFwtxGBBXCTwmCrWBCm1AZfSmaKKTo7u2XmWOIr+CQrDnbnkSsWvMuwhe+xU8TGNO8gOOgDyR3LUczY59+fKYHUXIpg1K9iFXor3M4NYzxUwMZ2bS3Gjdia/3NVMe6+6+dLB14jj+voQEmuytGc=
X-HE-Tag: 1786711055-730445
X-HE-Meta: U2FsdGVkX18SvWDC2ucxESDQ8SliUj0/UJvE/Q7ByCfeR/QxfT06lWBoKhbolsPkniVoxaA4c0180TxFHGDrzFMUhMyZokmnlPINozJ/lOkMRQgLjVCqKwC/D0gwS7B97FahmGBJksOzkw/fygjBQqBC4Vl3fUY7bQnJd8CBUaeBuLfWSAlshHQu4ib3S1eM3gYnW00hQlPzjBmRArZy+V4mInyA2GPinYmKKsN2Mgj1Wu4zBgRzZD/SZ81qbM7i9HkccDgKGAM9IzGg4c/zUdj6/hsqICLjjX27iHd15LZ3dpu4NGG3SzDw9svEBIxFg6ZGGeiIDACFxTzyDZkCZuoWE/qhcYYPNIDrM5p3mA2mEAps9UcAHg==

On Fri, 14 Aug 2026 09:07:23 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> So, keeping nr_pages unsigned long everywhere but -E2BIG for the cases where we
> are limited to 32-bits, that is persistent buffers, user-mapped buffers and
> remotes?

Correct.

Thanks,

-- Steve
