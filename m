Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E80983A0EA5;
	Wed, 17 Jun 2026 15:52:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781711556; cv=none; b=MjnINkoML5E77LKzmRzq66xHOUhyrt5MslIKEU0x1Z+1Wa7z95qlLgiVoQknP5/XZoocvZtIm02Qi2swqdtfQ41zRfNf6xdN75bkORgkIYcEnE0k8KnJiBOXYmPWcRxSnFqrERzm2nmucJFy+PWG8EDkJO44wTWLSspcB/jrEsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781711556; c=relaxed/simple;
	bh=8H6jTezRYlahM+EC8EqS9xSO+iDGpVr/2i+ykPKX3MA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dKSU3irhEoCL5oZc6hTTuL7WjSRBxRKqGKIYy5zzTiIvdYxjvHn5Z4GU67P1JVpnxWoGYoznjjATeA10IJbUUwUMbYyAJVoAtuTlRa495yx8/Ovf7PyGivdyZQYbbRjLZS0esMESsDP4T3faQGvWsJX/xR8I1cuQ8Gaf0SLy4/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sc1Uikh5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GQHZfEnO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sc1Uikh5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GQHZfEnO"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1781711542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8H6jTezRYlahM+EC8EqS9xSO+iDGpVr/2i+ykPKX3MA=;
	b=sc1Uikh5sig9oigeaHxIi5BhPO0Y7g8LxlS+n1Xr8JJkeMkzZDZr+f9325RwzefZF+HoDl
	+BrWuGGcFye/KproL2iFdtg+MUwsTbDoc84JAiwXjVpQQx3bk3gMQzWyR9mEHcBS6r+dkk
	4O5n9BvpBcJ6QEfvotk6GlbApZse7IzKMAgVhKFI9sx/fDC1KXQsNv5ugfCh3Y+La8kbJ6
	jVVaAgwJTMHXySGGxzMAUkQ6uXcvsXxnQRBoGbTmScwQZCqsxqvymp2WOiKSeAncBDw80+
	EjX1jiBwx6QLVAIdnTwQunnpWA8Y3GKIje8DdhCypblPPFYT5r9KXhKSXWH1mA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1781711542;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8H6jTezRYlahM+EC8EqS9xSO+iDGpVr/2i+ykPKX3MA=;
	b=GQHZfEnOz0pWzyKDWlLfvxUNt/4WFKVXCuaskRcCYCeZZNm705smfKxcsAaPKfT4aHaTS6
	ngwyLT6xAaQLZUCQ==
To: Gabriele Monaco <gmonaco@redhat.com>, wen.yang@linux.dev
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] rv/reactors: fix lockdep warning and add KUnit tests
In-Reply-To: <2bcfa0bda551c0e1ba137b728dbe7886ff5c2579.camel@redhat.com>
References: <cover.1781541556.git.wen.yang@linux.dev>
 <2bcfa0bda551c0e1ba137b728dbe7886ff5c2579.camel@redhat.com>
Date: Wed, 17 Jun 2026 17:52:21 +0200
Message-ID: <874ij16u6i.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Are those tests supposed to trigger this issue though? Under what
> configuration?
>
> I reverted the lockdep fix and run the tests in vng on both x86_64 and
> arm64, both preempt_rt and not but I see no splat.
> Repeating the tests multiple times from debugfs also didn't seem to
> help. Both machines were relatively large (128 and 48 CPUs).
>
> The config was the bare vng one with kunit built-in, lockdep and the
> reactors tests.
>
> What am I missing?

I haven't tried to reproduce it, but seems quite rare. From the look of
it, adding some delay into the reactor function should make the issue
more easily reproducible.

Nam
