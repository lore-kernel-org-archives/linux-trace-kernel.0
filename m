Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEDC120CCE6;
	Fri, 11 Oct 2024 13:28:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728653324; cv=none; b=GsxM8XD1Iqjc1y8/ufxeRgYq45VPvKwAwJRtyJ2KXF+VZxrTOJR1tx5Lndnf3S4L6VufNCVa6wGAJx6T9+nhiz5tXKzO/jvo7B0oZJpyEsMAxlBDXO/1ervX8fVpbHc2LkqUFBCZAzjdwm4YFUDqvESXP45mWOwd8RxOtVAeIvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728653324; c=relaxed/simple;
	bh=0KN4PAuarD15cBjtwViE6vOds69mPESC9M3ECcMXUwU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=T3BoT5Ph2C8Yr912gh9pXqXTwEdf/3pE1Oddo7I1HUpo0Jfbqwt5JAs53ScPf5hSLnjzStyGWZb+ibjq9QyxO8XmswOXiKnAfXogL1d987LSm9wHe63iGUEAN2XHlJDsUwAuj682uribxv2uTkiWynXuZeKgwwnVK+HXth9BE48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=mfK7qYWO; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="mfK7qYWO"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net B041E418B6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1728653321; bh=lHvB7mQigSlwaSn/vOH3/OOzW0hyZvIFE2loiiES9og=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=mfK7qYWOLpuITnbZcMdT3SYp5n/tBuxmwq/p85oL1znYqUmgEBvfrOZ8TZUy6NtID
	 770CkerjGdweTHQCZMMKb3GTx8/jcVyY/dNKT8u7O+eHcdWaHfvD+11+gGWZcb99w4
	 pYkqwaKuUUzie2mXe0tlvkDVMdZoNQpoK8TB4GOZJMpequs1/7R60dxQFoUuQXIYdh
	 YhNRyI8UweCuX0fHgU6SPgvlq7MtOJ3YG32+bS8rVXXcrw+175BxvV1oGy0aN/E2cU
	 U8iKIhLDiasZdzuVGcPVPmBy7Z8UzKJCKHvpEckZZnXe8rk/HUDauMQ7+oFfAjJmvP
	 xBfIWj5xgt9rw==
Received: from localhost (unknown [IPv6:2601:280:5e00:625::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id B041E418B6;
	Fri, 11 Oct 2024 13:28:41 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Suraj Sonawane <surajsonawane0215@gmail.com>, Steven Rostedt
 <rostedt@goodmis.org>
Cc: mhiramat@kernel.org, mathieu.desnoyers@efficios.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH] docs: fix WARNING document not included in any toctree
In-Reply-To: <e7851def-91ce-43e7-880a-22dc5752c4ad@gmail.com>
References: <20241002195817.22972-1-surajsonawane0215@gmail.com>
 <20241010154708.0bf658a3@gandalf.local.home>
 <87y12vzqg0.fsf@trenco.lwn.net>
 <e7851def-91ce-43e7-880a-22dc5752c4ad@gmail.com>
Date: Fri, 11 Oct 2024 07:28:40 -0600
Message-ID: <87h69izs3b.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Suraj Sonawane <surajsonawane0215@gmail.com> writes:

> Can I send an updated patch with this change (moving debugging section 
> to the top)?

The patch is already applied, so no.  You can send a new patch against
docs-next if that sort of movement is warranted.

Honestly, though, just shuffling one file around only seems so useful.
What would be nice would be to turn index.rst into a good starting point
for people wanting to learn about tracing, rather than just a jumble of
files.  It needs organization into sections and some connecting text; as
an example, see the (minimal) organizational work that I did for
Documentation/process/index.rst. 

It's more work, but would certainly pay off.

Thanks,

jon
