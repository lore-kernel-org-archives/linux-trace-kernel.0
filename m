Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90D5F1E00BF;
	Fri, 13 Dec 2024 15:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734104557; cv=none; b=SC3KOV5fgP5v/IyeB0jTITaQxBJZRAG+QQ4g9A5kUbWD9DKgvGLjz7gznO0eVDtO5JZIKbr8qi1ZyaHDfwYNoSrnTRLSAf2okwzWDgU831dKB225Rxu2P4pwJZGJQcmFoVCw4CXwVFUaJ01uRpw+6FEpRkBIwP8BX2RgVW3dXTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734104557; c=relaxed/simple;
	bh=mHPjmC7P4em87lEeFXsGwkdx50OfzTIj2tWZhcbmIOM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wt/R88f1I3TAzky2TMlOtjwCkqj7Hkez2126J2JmOp9Exg3xghSCBoo980mBad+precnKfj/HAut9sYH/YlPpfQdaKUdzz/jzdDI5piEZqERE5UvZ6C8kbKRLfWnpfPfhLwGKpwIPDI2iR/A85NY1emJWcDkcL+S/OkiqYEddF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=Jic/8Vx7; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="Jic/8Vx7"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net D28C8403FA
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1734104556; bh=OOLljGu0Oy3XVE2q4ev/95uAqhKdgd1eLTSa/WzIIa0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=Jic/8Vx79k1lz4YOF+N9sQURrEB6Rhd9+AvKkC9CQ1H4wTzjBYUJhuu8eWjLewDeP
	 ryG0cs5Eaaba5FJu5wYV0V0ng/tUVI8BycMVd9y+pvgqPoUeA7Oip9DwmI4mbdp1em
	 VrRYJiyEAhzURtZogPQiZoRaueoLGp7G4qaL4kQoCYF1fs7t3m40hkHvGLUG/BPkaE
	 Nj+VX5Q+YvwhN8Z9/HsLQfh/aHXZiqXpI1KTzJQ4PXTXeP/fhQNn3nOgIc8SksnBiE
	 PW+x2vjMq1fwuq0/f4JFrwdM2121IfVT8YuWKLfM9ibUl8iy885ZqzIBMrCD1HGJbw
	 OifD96PsCPFmQ==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id D28C8403FA;
	Fri, 13 Dec 2024 15:42:35 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Andrew Kreimer <algonell@gmail.com>, Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Andrew
 Kreimer <algonell@gmail.com>
Subject: Re: [PATCH] Documentation/rv: Fix typos
In-Reply-To: <20241209130640.10954-1-algonell@gmail.com>
References: <20241209130640.10954-1-algonell@gmail.com>
Date: Fri, 13 Dec 2024 08:42:35 -0700
Message-ID: <878qsjy4gk.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Kreimer <algonell@gmail.com> writes:

> There are some typos in the documentation: 'a' -> 'at', missing 'to'.
> Fix them.
>
> Signed-off-by: Andrew Kreimer <algonell@gmail.com>
> ---
>  Documentation/trace/rv/runtime-verification.rst | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Applied, thanks.

jon
