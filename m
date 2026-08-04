Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62BC5436BC6;
	Tue,  4 Aug 2026 14:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852132; cv=none; b=cdxJUpV0I3RpabzgjyG8pzPstAaUCpcAhAOdGWbgJL4xxMdRevlucrmcYQ0s1DC3hMjDUp8gUZmt0qLYEZfZn6stPM7MExKyq8dF8s0XFMXKXeHI1PpH4TpxIQgqpGvz1dJXvrT98n5e1Ji604Y17V8lwR1/fsHmw9f3eruiqzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852132; c=relaxed/simple;
	bh=XS4lbeEXosHPgGQdiuKfR89zqi4/b7wKpbA0eGpUS38=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oq7AK8j0aDnWiy3v4Lavwc5xBHnDVvz818M4HxvVWkaIh4NH7cef7bE4s2dVymn/5VuCzTEIz1LTZLUbWFwHKyHVFbpN7MXiy/UaIudUxZ1GQvNTfHX+vK0syhxyd1a/VCq0B16zwLEoiHNgMw3ST8WAFg2v0gtyAc001Z/cbIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G6XugZjy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9rcjMRZE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G6XugZjy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9rcjMRZE"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1785852127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS4lbeEXosHPgGQdiuKfR89zqi4/b7wKpbA0eGpUS38=;
	b=G6XugZjy0d4+3AS4Zhk4LjgeKk9Am/Vn+eKerWwRS18RH1T5Xx1yEq9v0xZKE2oK/fdIcd
	THWf0PcYCAUGXRQa6VA4GOKugdALyz/sTH09BmZwaGiQxSxsCCDyGW/qjVOX5lOr9i+S++
	hsywrlQw1ou4G/AXtFJE9mzsLUMcECnW2XHlJf1DLvkZuTWk2cgWcoA2loSP2Ta0loeGa6
	uYYIbqlM66kheNCBrw82qhDCNe6+5aWrYEvYLf+lWy5Ewy8cznE9EXH6ymvRAiE2vnioie
	bOmzQw67jO2TbNlfrLeaI8MHzTeQRx55GXA8hSRmcQF8eLLlGD5RWn+a/g84cQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1785852127;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XS4lbeEXosHPgGQdiuKfR89zqi4/b7wKpbA0eGpUS38=;
	b=9rcjMRZEmAi2sowexyuYiPJLFzYoWYHoO1HyuzE4K76iGlySBMSpjipeLd0AAGlKx03DVa
	J+gtbguPVgBChxAg==
To: Gabriele Monaco <gmonaco@redhat.com>, Chao Liu
 <chao.liu@processmission.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Jonathan Corbet <corbet@lwn.net>,
 zhouzhouyi@gmail.com, lianux.mm@gmail.com, lianux.wang@processmission.com,
 Shuah Khan <skhan@linuxfoundation.org>,
 linux-trace-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2] Documentation/rv: Explain epoll and aborted sleeps
In-Reply-To: <c9fbfea2eeb6603f275365e61bef0bbfb355d963.camel@redhat.com>
References: <20260729081102.73138-1-chao.liu@processmission.com>
 <c9fbfea2eeb6603f275365e61bef0bbfb355d963.camel@redhat.com>
Date: Tue, 04 Aug 2026 16:02:06 +0200
Message-ID: <87jyq63rxd.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> I'd appreciate an ack from Nam, then I might be able to squeeze this before the
> merge window together with the last fixes.

Reviewed-by: Nam Cao <namcao@linutronix.de>
