Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86E68142E83;
	Mon,  3 Nov 2025 23:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762212935; cv=none; b=S32SGGmF232yrexyX9IDD19D93rVrtMFWcXJtL5Hv4LEJgkdBLKxvfNVL7dgtzBvQ9S92v6H0XVU2lwlzF1cOiPXN3Y/4H71J13lDSZ9pA7TaTGK5mFgG+O861vPjQIlW/KLXHHAMpJHTGWnTJa4jLaeBf8P7nFu7iw8ILK2Zog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762212935; c=relaxed/simple;
	bh=8q5djkQgi9ATG594fdKrpiHqqoFLfmBs6o2tSOJKmrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TT2TJc5+hhlKxhxUwvaV4x3Yg725nObae5F2EKbjZv92k3uWrtmIC7A1sFegBB4ZSlx9IBqWfEfKvDVddR4hr3RIeRrQP2PTZaQAoNBPlNXDPv4ByfFLGkBVptuUtHslDu5OAY4acyxVqG5AtiJ2YQzTl/u2n4k+CGT287Pegl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=miw76KJz; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="miw76KJz"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net BCC2840AED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1762212933; bh=8q5djkQgi9ATG594fdKrpiHqqoFLfmBs6o2tSOJKmrA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=miw76KJzANTlPp/FaYCIpqdzrI47P7DUX12kPe1mVu021fJ/HVl6sF2HWuLdjma/T
	 HoqLRME5MfKP6jGWHeqcsX4EA2v+TBSfCveylOmdaCEREvsp1Ihu8162McjfQpZcd+
	 u8k74vTn8FGpX+TuYLAs+us1an7KP2PVysmcbJO1qzGjrgCmvELslJzK6JWDkhAYll
	 GOCyxHa3U4y8QZiowrwh3Kkg2MGIjEaeZ56GyGxZvHo93G7cbft4M8Tla1lsYzPRvY
	 5xDHzWjXvxipLfO+9UD9Ba1gWKdgxAR7mJz9/BZAif8ycLHPpht/GmnF8b78JyR9RL
	 MV+FJXNq6niCQ==
Received: from localhost (unknown [IPv6:2601:280:4600:2da9::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id BCC2840AED;
	Mon,  3 Nov 2025 23:35:33 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Tomas Glozar <tglozar@redhat.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, John Kacur <jkacur@redhat.com>, Luis
 Goncalves <lgoncalv@redhat.com>, Costa Shulyupin <costa.shul@redhat.com>,
 Crystal Wood <crwood@redhat.com>, Attila Fazekas <afazekas@redhat.com>,
 Tomas Glozar <tglozar@redhat.com>
Subject: Re: [PATCH 0/9] Documentation/rtla: Cover default options
In-Reply-To: <20251010083338.478961-1-tglozar@redhat.com>
References: <20251010083338.478961-1-tglozar@redhat.com>
Date: Mon, 03 Nov 2025 16:35:32 -0700
Message-ID: <87fraubsfv.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tomas Glozar <tglozar@redhat.com> writes:

> RTLA has many options that have a default value that is used when
> the option is not set associated with them. Those are not covered in
> the documentation for the options, which creates confusion among users.
>
> Document the default behavior for all relevant options: -H, -P, -C,
> --trace-buffer-size. Some of these are covered in general
> descriptions, only missing from the option documentation.
>
> Also, fix a few typos and incorrect naming of tracers.

So I see that this series is still unapplied...should I take it through
docs?

Thanks,

jon
