Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03663EC2EF;
	Wed, 15 Jul 2026 11:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784114597; cv=none; b=J4X8z212/M2Uygz35ZSxd04GRvlvAC+fyk2ZsRsikn7s2ZjWg1Lh7WJlrAr3BQR0EpugU4Z9uxds1mlNFgZ9tn6cMQIXLHfiN9h4jb5gPhX7T8ulIMzi9lXPaPyy39adQIBjeLlwKN1WcAM1sHDoGYs3usvYnda5fKYyMNkg4HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784114597; c=relaxed/simple;
	bh=1LqqoBRVGlwsuA13hBPyB6NdE0scIoZuzNgBGoFgVto=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=vD2FM69KN3b27w0alGWTmDS8vKCWgp6x62NCaE7hZjYkTvQJeOVjg9A3DHPmIFvoUeU7FU92zCejNfaIUTFgPPZFf0f+QepnyxbuMsH2jsAvSRiaIFguhef9z0Y3yoiIqQDyqKKawKnDqwGTGY1oXheOnVqUvhjoL1E0jOPNfco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sM+u6lE9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zZVb5MPB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sM+u6lE9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zZVb5MPB"
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1784114592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LqqoBRVGlwsuA13hBPyB6NdE0scIoZuzNgBGoFgVto=;
	b=sM+u6lE9NHMCX1iABSETMInpDxcWbshriCWOzNsK7kN8OrvF5lxQmrv4iqeKdvtCwxsArr
	KwheoGSaMR9OaIEOGJvP6Z+5EDlay7tsaAEyPB7JCdqQBh/uf8l7OhC4wcpqBCW77IOSgW
	ReAaKY4Gr8bXDE6eVZunUkNfABV1Fs8IYf+rHgUse6n8Z/zub4AV3hpV+Md/lrZyZmglRa
	wgYIwRg+D6k3sCqY29KfPbFGKGQ/SMrC2K7OcAj282qLY5TaTyxqKarcySntlX2slIdsWC
	rz5L7MPrt9ZO8Tpz1ajLDrjuU21Pb+zLdhGqoLkXBF+TBe78LPGtfaVlLOMybQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1784114592;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1LqqoBRVGlwsuA13hBPyB6NdE0scIoZuzNgBGoFgVto=;
	b=zZVb5MPB4nEHhjfGRdH97ZwlVUt+K2xrwE6MAcxm/Dn8n6zmSldnCsY1IS2hkvdmvjlS0r
	exVY3D9UVKx2sjDg==
To: Gabriele Monaco <gmonaco@redhat.com>, Wen Yang <wen.yang@linux.dev>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, Thomas Weissschuh
 <thomas.weissschuh@linutronix.de>, Tomas Glozar <tglozar@redhat.com>, John
 Kacur <jkacur@redhat.com>
Subject: Re: [PATCH v3 14/17] verification/rvgen: Add selftests for rvgen kunit
In-Reply-To: <4885b2132ca1e8ed0fd6010ef9506d6e99e58fdb.camel@redhat.com>
References: <20260625121440.116317-1-gmonaco@redhat.com>
 <20260625121440.116317-15-gmonaco@redhat.com>
 <53f2d13c-cc1d-48fd-95f0-2c1ff1edfc88@linux.dev>
 <ed538f5f3a0976ea8a0be66b20a446442f7260c1.camel@redhat.com>
 <a20ddbab-aebe-4f2c-9d07-ec8dee588eab@linux.dev>
 <4885b2132ca1e8ed0fd6010ef9506d6e99e58fdb.camel@redhat.com>
Date: Wed, 15 Jul 2026 13:23:11 +0200
Message-ID: <87v7aglco0.fsf@yellow.woof>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Gabriele Monaco <gmonaco@redhat.com> writes:
> Well, I believe a compiler failure was indeed the original intent (that's kinda
> what we do in rv_attach_trace_probe), to avoid unauthored monitors.
>
> Anyway an unauthored monitor isn't as bad as a missing tracepoint, so probably I
> could make the LTL template consistent with the others.
>
> Unless Nam has concerns with that.

No. Go for it.

Nam
