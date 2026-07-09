Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EAE399887;
	Thu,  9 Jul 2026 18:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783620479; cv=none; b=cOwJ8WdQnlWyyZjjYwPZ90GPZyQfogCbcTL1oz0xil52APJQW+XmGUUsh1+xbDBETrMZKGSPbRM8nEnI+HdOpY0P7GTxPGAbWeN7gQQj8eU7RAVNPNfMYcAqyL35eSYX8w+E85fdv+5Nvslp1m/s8bAACufm55AQ2LywAWsYdcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783620479; c=relaxed/simple;
	bh=+iXuT+QE/igWEvg/w4bOLbDlAcJfolVVx+Ti6i+b5cI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=XpGChy1ZCdEHmvKQ4cJ4eAhlvtenPFrJQnmBwKqWpBU22dDkRWS7fi/f2NYFD5ov5cjaof5yL0XBRG/MIGIeQOym092LbbVCK1f72yAXa9E3AHwGFYyqEPw/Tq6wl2YPkSRjHVCcvOY4DHtmnaEOKXuFj3Lp/E74frYqRMtQ1pI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p0hpFXS8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uK5f/z52; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p0hpFXS8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uK5f/z52"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783620475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2gfkAh5be+qkyDwUQtIfdUPwnqDL8OlwgFX3HXbZ+I=;
	b=p0hpFXS8sV50rUKs7BFn2RW8+iZo/pB49axdxwM7Xvyoqjz9acEJ2DmZQ+PaC+tJBLWHtc
	cdgujXMFa/KzJyPz3TJ0PwtRZ10R/d8gYYn35WhFpj1F/350tqDELD9Njmr3qLeeD4jUeB
	ezymLpctBsTmUiAWnmb2I7BNsJl9MZkWe3LzdmGZJeGLwp8I2tB9srW2+DIqqEM3X7tIjn
	fyPHrRE4PxtcmvXD0rlN0Vbsoka8DSsuLNS0kCI82n9ZmakIqbuOD2KRj/0P4QX2CX6DoK
	PU9wDaBBlz/hnAuQdeZYv7/SPzu1Q59APsvXqqMnDJqY0mFiAJI/JfNvJvUgQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783620475;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w2gfkAh5be+qkyDwUQtIfdUPwnqDL8OlwgFX3HXbZ+I=;
	b=uK5f/z52fFr3vxDqQ2EYS7gjzMKQm2pDr+iarr1BdJOZgfRY/UYw7xweuzT4Eq4r0dIQ80
	+wf1ynA8BV/rc4BQ==
To: Wen Yang <wen.yang@linux.dev>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Gabriele Monaco <gmonaco@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] rv/reactors: fix lockdep "Invalid wait context" in
 rv_react()
In-Reply-To: <397cea12-e0ba-4cf5-a411-26f44bc17d01@linux.dev>
References: <cover.1781541556.git.wen.yang@linux.dev>
 <bc01343ae74acf6bdf142434aeaa4e6b40aa72a9.1781541556.git.wen.yang@linux.dev>
 <20260623112942-4943fc6a-c1d5-4eed-a91f-66b3a034caa7@linutronix.de>
 <3c53f741559f834986e976b524c5ded90bbd5627.camel@redhat.com>
 <20260708174123-e5f98837-3d81-43ca-8ede-bb5f09e8ffba@linutronix.de>
 <397cea12-e0ba-4cf5-a411-26f44bc17d01@linux.dev>
Date: Thu, 09 Jul 2026 20:07:54 +0200
Message-ID: <87y0fkdojp.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Wen Yang <wen.yang@linux.dev> writes:
> How about a context-sensitive approach, eg:
>
>    NMI/hardirq (interrupts masked, scheduler cannot run):
>      Keep LD_WAIT_FREE.  The false positive cannot arise in this path,
>      and the original constraint against raw spinlocks is preserved where
>      it is meaningful.
>
>    task/softirq/PREEMPT_RT irq thread (preemptible):
>      Raise to LD_WAIT_SPIN.  Raw spinlocks become permitted =E2=80=94 as =
Gabriele
>      note, this is a necessary consequence of any fix in this path.

I don't get the point. Unless the lock's type is also context-sensitive,
the reactors still cannot use raw spin locks.

Nam
