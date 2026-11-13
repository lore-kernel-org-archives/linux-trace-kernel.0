Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794565124;
	b=G1l6oUDvAdDm6FQewmQH5Ec5JR0j+KnM/5FdNlWAcDiHOEi/jFA4L6ggUEyUpcGm515a
	 8QiXvpswUjZIIKMbfup6GnaGt22iqPSwHW5vbEnJyE1aSyqhc8RAEsraoOpUR11v3lnE+
	 y+//ahOsixezW/TCRPljz2AV4ss04LEqked0wWtoQduv9dlUEQSb57GOOfTMJwO2X5vd+
	 ddZIwwJ18qPQmxq+MeXCVzDGCP0ZwoQ25y7fF2HRymXXkO2qxVnliaODzznfWlv/Av2EH
	 hK7hD6+7LMp4mCv6ir4JRknjftsA26XzZJTYCxxEL7wGUag+OYlzAv59oR+EJ3fRYdg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794565124;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:To:Cc:Subject:
	 Message-ID:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To;
	bh=GDqKLySI9xov4G2CrkoKgL3wsghKRx2H516sy7kfjC0=;
	b=1puuGT2un+Dyz2w4jquyi5kDmqy54Lsy9WCnIcOs3cYqZoKO1zFAaPH42/ERZ7/TeQqX
	 El1AjsIytb0hqXEywF8PtX99kVCODwDF1GA2HOknwOL7xq1xUoPErhKKDIs9ZxoSrjLRU
	 NYHcDRuTa6KLfWG5ih69uaJ7AmvEgF4kd3Ci5icWG7BmATlg84+JMgulYROxBoIgCpHs1
	 qesP0KIrDvWdB0UYbdlPIDItJL7yo6M4kFsOICc0txKn9KmSdaFd7Lqe0oiCRf3DDW1dY
	 XM2AyyyKgEerkxohzadQfhbzUJLbKLO5iZOmTwBaxKk/iD6FfmYqEDjrdcDkxuWEDig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="AhH/5FHn";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RR0xxxl7;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BF4606A327
	for <linux-trace-kernel@vger.kernel.org>; Fri, 13 Nov 2026 10:18:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E1BF4606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=AhH/5FHn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=RR0xxxl7
Date: Fri, 13 Nov 2026 11:18:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794565121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDqKLySI9xov4G2CrkoKgL3wsghKRx2H516sy7kfjC0=;
	b=AhH/5FHn0hpsvtbMWUtAzPXUo76KMllKJqFucagbH1xo3LX6MHr4sydVx/SK1VhsdMGNsz
	Vg3/hKoLSTYSfWIFWmCmEpYv2Ch4a4tRNuvwtBoJPe3g0oF+dyZPdc7nS/LkdNkoOuooqy
	nsuE/E0VYtdKVjmATk/PHWU0QoRau6J+ecw0wYbnNS53NuX40+tLUc74kZr7c/TWaga61o
	3EUz/68ZObjCRAUotxfL+AbweiV1Wydjf7A0UMndq6S2w8hfQTX9gJdIl1+cc/ZHyNEt1m
	VFoXDh9SZyzfhccI56pbioyT518HvV/uX61xyHHeTfSevFvRZ0YiVTTJYYyZwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794565121;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GDqKLySI9xov4G2CrkoKgL3wsghKRx2H516sy7kfjC0=;
	b=RR0xxxl73/fRzzCMqAWNaGZk+qQQPoDluyYWFe1WR+xwHbN7Ynz+jKoYI3S+cUaE7IsvET
	SChbGaNukG1StyBQ==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Tomas Glozar <tglozar@redhat.com>
Cc: Daniel Wagner <wagi@monom.org>, Steven Rostedt <rostedt@goodmis.org>,
	Clark Williams <clrkwllms@kernel.org>,
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev
Subject: Re: [PATCH] rtla/timerlat: Lock the memory of the user-space threads
Message-ID: <20261113101840.26aMfOtJ@linutronix.de>
References: <20261112-rtla-mlock-v1-1-418986711b20@monom.org>
 <CAP4=nvRQE+GKPT1-KgZ4OgcVV7eKqnkURaELutSMgK4T8YAZMg@mail.gmail.com>
 <20261113094423.xgAx5Goo@linutronix.de>
 <CAP4=nvSEfWgR1GQxVCctBVL_9HrAgkET--UhZ-mdx_uCpk_1_w@mail.gmail.com>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP4=nvSEfWgR1GQxVCctBVL_9HrAgkET--UhZ-mdx_uCpk_1_w@mail.gmail.com>

On 2026-11-13 11:07:15 [+0100], Tomas Glozar wrote:
> I agree, you are right. I was thinking about rtla setting
> /dev/cpu_dma_latency to 0 as an option rather than by default (unlike
> cyclictest, in that case). If rtla's idea is to measure the system in

Oh, yes. cpu_dma_latency is tricky because of all that happens to a
system setup and might not be expected and then people wonder why the
system behaves differently if a certain application runs.
mlock on the other hand is something clearly defined and explained why
it is important.

> its current configuration, it makes sense not to tune it by default.
> But the rtla user thread not having mlockall is a misconfiguration of
> the rtla thread (i,e. the measurement tool), not of the system.
> 
> Plus, cyclictest can run as a non-root user that might not have
> permissions to mlockall. That is not an issue with rtla, which always
> runs as root.

I don't think mlock is restricted to a root user. It might be that "huge"
application might exceed their memory limit during mlock and "usually"
their memory is just virtual and never faulted in.

> So I take that back. mlockall by default is fine.
Oki.

> Tomas

Sebastian
