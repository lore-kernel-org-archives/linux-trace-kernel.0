Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF74E3491FB;
	Mon, 22 Dec 2025 22:25:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.79.88.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766442312; cv=none; b=YQKjpRQsKd98emU5CaW1ZhzmPbIJuS1rDVM092e8xiKChN1LDhlzT2IzdR1UtzW+3YJInkRgvOYSSJHQ4SnUleuwB6mji2ht1sJhNnLr9uXatEMwk8h6vfhR81eb+tWkIg0gWUDPxfwn16NdXe10YtsNw9PtnAZnsKgsF3qlIWs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766442312; c=relaxed/simple;
	bh=UTE3e3zRqag9whWqOByHRu2cmId+V2NVcCFEvxb8Pwc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2An6uYdwR0MJ8yLgv8kR5ciCWKkqQDa7rpZ5SVWLcQTeH6GNLvd/Zmkq5DjLDV+aBbgRDD43HAv3cpoLAyil8Cxokl4rWwq/30ZBXeiSZ2dQ4v7DgieqBaHofRAkmNBU1AmMuzOZsUNaq6NVuAdbG/Qz0qkc9s/hhScnEDo+B8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net; spf=pass smtp.mailfrom=lwn.net; dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b=nOIe/MqV; arc=none smtp.client-ip=45.79.88.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="nOIe/MqV"
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net EB9374040B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1766442310; bh=H6dkgP5nDXtUY2fgbr9pLhBkMHgH1gFtdMcuO2qFves=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=nOIe/MqVOXG8sSpS7Nhg1Vg9qTrnZcIn6lRCysA8sOU7noG7oOuhWJznFlKKj685L
	 ge78hG/BNeud7+BRNwcKL1xS66LFc/Y7fmswL/BCf1MEjDuYCRJazYTL0MtgjTXUQT
	 Y1v63S3Zn0d4Cq8nFPhFnPrDjHoo0E2/szdeALIzIKT3t1dUCxOAfoAiv2VxGfF7Go
	 hXhD7dADEwbFM/l3kLB8ZwDGY5yreyaTRUvSa+gXVCxgJ/I9wZIntLpm2FjarJHE4c
	 TUgXHFF8uLUVJB7Fs9RPmwuV/N+eGyNbwyY6SFMc8cvNdSvT1QzQBUWyoPMe/MB+2P
	 yQKE552y6uH7w==
Received: from localhost (unknown [IPv6:2601:280:4600:27b::1fe])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id EB9374040B;
	Mon, 22 Dec 2025 22:25:09 +0000 (UTC)
From: Jonathan Corbet <corbet@lwn.net>
To: Steven Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Soham Metha <sohammetha01@gmail.com>,
 linux-kernel-mentees@lists.linuxfoundation.org, shuah@kernel.org,
 skhan@linuxfoundation.org, namcao@linutronix.de,
 mathieu.desnoyers@efficios.com, mhiramat@kernel.org, bagasdotme@gmail.com,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-doc@vger.kernel.org
Subject: Re: [PATCH v3] Documentation/rv: Fix dead link to
 monitor_synthesis.rst
In-Reply-To: <20251204101415.284a7a96@gandalf.local.home>
References: <20251204032452.9523-1-sohammetha01@gmail.com>
 <a34546391cc59f9f880ec271292ac201292bac61.camel@redhat.com>
 <20251204101415.284a7a96@gandalf.local.home>
Date: Mon, 22 Dec 2025 15:25:09 -0700
Message-ID: <87h5tiyx16.fsf@trenco.lwn.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steven Rostedt <rostedt@goodmis.org> writes:

> On Thu, 04 Dec 2025 07:36:57 +0100
> Gabriele Monaco <gmonaco@redhat.com> wrote:
>
>> Anyway looks good to me.
>> 
>> Acked-by: Gabriele Monaco <gmonaco@redhat.com>
>
> Jon,
>
> Care to take this through your tree? Gabriele is the maintainer of this
> code.

Done (finally).

Thanks,

jon
