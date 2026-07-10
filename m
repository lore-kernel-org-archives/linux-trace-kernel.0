Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FF5224F3;
	Fri, 10 Jul 2026 06:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783664294; cv=none; b=FSx/h2tx70TO6wZZe65q9264Kox7w/Uvo9BtMeBz8cKzrDOwu22euND9TsFsjs8taMj9YuU8ffhIM5zV05RsgbW4ci6fZK5waq/jVWnPUzFymjfEw5wSF8cN1Osz4AqF36wtm0W3cZp7hC2ODTtswx0Ex2B6F2/zzK94G98qv00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783664294; c=relaxed/simple;
	bh=lSgl7KLTveBr4KMNUqTgGon5ax5Nku79Jsbz9J9X5MU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vDdknRhjbzMJGwPEVxEAZ383JHkGnHcCbJ85G+UDAp0KL07dE6z8THo6AGg0u77vmgF5Sj/5XZZQyZ0fQvvERDu5DfbBhlCpL5DnSPrrMQ1WbTca3elkSAfK4AYAaOLx+weNYtb2eazHKgLpcFeafzkDnhSIQYKnLfStCBNvciA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PgLxp37j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gmgJ1bmC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PgLxp37j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gmgJ1bmC"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783664291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lSgl7KLTveBr4KMNUqTgGon5ax5Nku79Jsbz9J9X5MU=;
	b=PgLxp37jilN/jQ36SANb2IAc+pgriconJd9uhaqJWxjLT2RmUoA4NWDDUiJLdoq7eUkjGN
	Fgsx0hzS5cNgflqt07pyhiPgTnSEaPTb4is8FHUx2Aq1v4TbQjDOxd70O49/ZetnRaR5Ks
	T9h689A6h01YB1XRc6U4lplg4T24cD4NpSu+N8eU6Pw22W+1nSPjxN2XSLE3GL1EILYp9X
	EGOmSmc81RIX3Rolg1iFrmJ2XaF6jaoL/LklfhjBgd2WHRLVeh+IUqVYFqfWTOsXG/cuss
	U2cU/HmJrPdCMXHMSd1i2iDOt1lFqpn9hDN/nVAdI3aA+0YAr07J6dIlLTt/yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783664291;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=lSgl7KLTveBr4KMNUqTgGon5ax5Nku79Jsbz9J9X5MU=;
	b=gmgJ1bmCPKknMfkz/4a13bMZIz/EzkdnY/5kwf9itcJUmzr4hCtbgs9UKStR3ADxdt+7ZH
	E0QeJ/mDbYV0pBCg==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>, Shuah
 Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 16/17] selftests/verification: Rearrange the
 wwnr_printk test
In-Reply-To: <20260625121440.116317-17-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-17-gmonaco@redhat.com>
Date: Fri, 10 Jul 2026 08:18:09 +0200
Message-ID: <87zezzxt9a.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Simplify the test and run the steps expecting no reaction before the one
> expecting reactions.

This requirement is not clear from the code. I fear a new developer who
wants to introduce a new test case will easily trip over this, or even
us a few months from now.

Instead of this, how about each test case discards or ignores all
previous reactions?

Nam
