Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C25123FBED0;
	Mon, 20 Jul 2026 11:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784547893; cv=none; b=Iw5tdYWb7aXZC8zi7vkt+d3awBWdsLZxypitexOIMoSbikHg89GeGTp24FPZN22FFG5CkjQU6QHoVPY1HD6Y9DOft7QgNW0claiU31zHx5DaXpFVCquPWa4BOi5FIAFqaPEbRnmGUrsZOB+Iw1X1uQ60ilvYDsSCWkVDtbH4VSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784547893; c=relaxed/simple;
	bh=5J1xWRf6WBWIcj614Jlfjjtd7xk6l7OWNsK1cyb57c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o/IfnLvvYk6dL2mLNUpIyfzormRNG/or4BAxjQouTPG9ZDCffo2G7xacp4ILIDdZX704qB7WiXj+KpV+PlWs+0Gk57Joeqkj3t4e8liaf0IqahtwcqyaXD1QLEQGDfxvBf99vW5AXjVLYSsE/Fj8AC2FluTIQf7g48ll+bGWfeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L9TaIf0K; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ALJP2XZY; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L9TaIf0K";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ALJP2XZY"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784547888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5J1xWRf6WBWIcj614Jlfjjtd7xk6l7OWNsK1cyb57c0=;
	b=L9TaIf0KMQ4K4h9Stff7vM3uqICYOOi8X+JH0YRIDHgHzI5CsQIw8/ET/PuYdxe4RWnO9K
	nx+yJh8GJikxE08Jkw+pLLCX4R/y59YaZXP3jmhf4dDhtkoCZsQagMFF049gzIykQdY7of
	mZtWhRqmCO8KyWfIswyAcKkRqkOPZNyfcSiSgYHueDsvtIreVxIlgUZp5z4QJ8OtYm0eed
	PZ/4YjeghXdbp9TOwzSuIn1BUecVvx2jfSb5CBt2bzJ+ZyxuIFWm0EGriOkCtPBxhzSIZC
	Dx6nvxVPHJ7+axNFAdiA4uD6dilk6gT7r0H/pd/IgLiOspagTygJZFIZnF3DMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784547888;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5J1xWRf6WBWIcj614Jlfjjtd7xk6l7OWNsK1cyb57c0=;
	b=ALJP2XZY5otq8+BM9mNBQ/uQR+yByboHLaWZ59V5wkvV3h+QoKo2XfFg3qjn3VQ1oesZKq
	xz1BjVBlP53RkcCA==
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Wander Lairson Costa
 <wander@redhat.com>, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/13] verification/rvgen: Delete __parse_constraint()
In-Reply-To: <5bd5c857c5130dd7b122112c69baf793bcf45090.camel@redhat.com>
References: <cover.1781847583.git.namcao@linutronix.de>
 <b22a5a3822fe53afb8e2cf1df623a0e4c9ed5f49.1781847583.git.namcao@linutronix.de>
 <5bd5c857c5130dd7b122112c69baf793bcf45090.camel@redhat.com>
Date: Mon, 20 Jul 2026 13:44:45 +0200
Message-ID: <87ik69evgy.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Gabriele,

Gabriele Monaco <gmonaco@redhat.com> writes:
> The series looks ready for inclusion to me, thanks!

For patches that you have applied, can you push them to your tree? I
think that is
https://git.kernel.org/pub/scm/linux/kernel/git/gmonaco/linux.git/ ?

I would like to have a base for my other patches, to identify conflicts.

It is also useful to include them in linux-next to get some more
testing.

Thanks,
Nam
