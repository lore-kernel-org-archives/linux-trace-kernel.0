Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF863D567E;
	Thu,  9 Jul 2026 08:11:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783584666; cv=none; b=B/ucWocImSuXrNVDoaGndlKJzTVEsVyHuUk7bXSBI8ozW1cs2/4eUJrkLqyKiCdPcG1MveHTRdZv9LdwZWtLwh2qqx/3w0xc5WH9e/kFun3n1LtNIIxQ6f/fWjpIe8MEZCUbY68hDzwOx6d7MrWDLGSyfNqWcm3/dVVc6u5KIJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783584666; c=relaxed/simple;
	bh=0HSjuQi/+nlGL92stctZOw9z5eGJ9T15uvENrthWJQA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H8IXrc0fssoC5Rkvhcd7PBJ4RdPjYzs47MmNMNaaofgISIr8vOHZwOH34b0XcrEOB0ZJUGw8UqGKs0+uo1H31b1umfHTwIdJ1M5eY8injCae9dP875OQ3opPCiB82L8MN0wYTcB0oPhyD5WGUI3m7UNE5ehN8SW6CShnCuAg+Y4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PFgPKpdR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6RmP4Gb/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PFgPKpdR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6RmP4Gb/"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1783584663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0HSjuQi/+nlGL92stctZOw9z5eGJ9T15uvENrthWJQA=;
	b=PFgPKpdRk9pZkSkULt+2QHx/hCDaZbaGidJEpNdV8XBdWX/ybOIDwv/gJzhe+PVDnaDgwU
	V1hL2igJn+yMeYHGh+MFVnqzCc4wfuEf0StMB/VltxwUQ1Jc8CTzWY3tZSk+LgBsZVZCUE
	Wf47beKjFfaswFygxii+aVB4jN5zL684fiNy09UiN/ec0tl2i4nsmImWi2EUY50TDdN5Gf
	cGgIBcxZjIHTWBEji6+uXAtspr0JR7J4x/s82kCMXjT2zVfNYWEztVYEG+j47Fbg6nTksZ
	LhevaMPpf1R8SIZKrOzG0XGr6a1+n9iCpWcweVmVyTsa2E9C2o+veJX1useYxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1783584663;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=0HSjuQi/+nlGL92stctZOw9z5eGJ9T15uvENrthWJQA=;
	b=6RmP4Gb/UpU4b17vJOe50URhD/a35OsAAlq+I15rAIzIIybUEftqaTBs2vpVj2eeu+gZBq
	+1amIjTjZBUMVjBQ==
To: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Steven
 Rostedt <rostedt@goodmis.org>, Gabriele Monaco <gmonaco@redhat.com>
Cc: Thomas Weissschuh <thomas.weissschuh@linutronix.de>, Tomas Glozar
 <tglozar@redhat.com>, John Kacur <jkacur@redhat.com>, Wen Yang
 <wen.yang@linux.dev>
Subject: Re: [PATCH v3 14/17] verification/rvgen: Add selftests for rvgen kunit
In-Reply-To: <20260625121440.116317-15-gmonaco@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-15-gmonaco@redhat.com>
Date: Thu, 09 Jul 2026 10:11:02 +0200
Message-ID: <87a4s0fuqx.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> The rvgen kunit command patches monitor files and adds necessary
> definitions for kunit tests.
>
> Add a test case validating its behaviour on dummy generated files and
> comparing it against reference files, like it's done for rvgen monitor.
>
> Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>

I am not entirely sure about this. In the future, when the generation
output is changed, all the references files also need to be updated. So
it's not clear to me if this really saves future development effort.

But well, we will see. For now:

Reviewed-by: Nam Cao <namcao@linutronix.de>
