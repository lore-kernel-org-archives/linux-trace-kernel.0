Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED433C1981;
	Wed, 21 Jan 2026 21:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769030758; cv=none; b=kb8ImIpBa0oV1ijfcDpopy3DlU8/E7trr7i1DOcwIdCaUv5yAlYhZSA+QS0RV+2rvqfKoXzehsWQjEIFtSKc3cIJG3f0auoyuUl4l0cPNmmeVaesJ7eoFvo9g0VltrNqY7EMnQpESMWcZa07teXbqkZKm95czc6ccfLaL1ZCbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769030758; c=relaxed/simple;
	bh=97rK05wCnto94Yd8gZVizLtP1pOIhKhhbzqhrFHazks=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CPtNXEsnrZm9Ig79l6aFHPmOYyfZY40+klr8NQw0fIwzb0Zp9fNTiPebVol5fyKT/kHVvcDUu8Wc14M/HBrblmpN1khgNbVPgmxQ2HA6JQOgK3dFw2IxWDbCCeKdPNCt4DvZxjTlaXovYpEoc5sj8HgndRwkei1GoQAm9Fjfnt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id E8EEE140EF3;
	Wed, 21 Jan 2026 21:25:49 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf01.hostedemail.com (Postfix) with ESMTPA id D49596000C;
	Wed, 21 Jan 2026 21:25:47 +0000 (UTC)
Date: Wed, 21 Jan 2026 16:26:12 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Daniel Thompson <daniel@riscstar.com>
Cc: Markus Elfring <Markus.Elfring@web.de>,
 linux-trace-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, LKML <linux-kernel@vger.kernel.org>,
 Robin Murphy <robin.murphy@arm.com>, Will Deacon <will@kernel.org>
Subject: Re: iommu: Fix NULL pointer deref when io_page_fault tracepoint
 fires
Message-ID: <20260121162612.3e0fd03f@gandalf.local.home>
In-Reply-To: <aW5YnTnOJ2dJNuhq@aspen.lan>
References: <20260116-iommu-io_page_fault_null_fix-v1-1-6c20c2e62987@riscstar.com>
	<fca8f2cd-c3e5-40b0-a793-bded109e37bc@web.de>
	<aW5CIA1aCC8FVyFl@aspen.lan>
	<a2aa3091-4a93-48be-970a-8bc506fb0cd3@web.de>
	<aW5YnTnOJ2dJNuhq@aspen.lan>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: s5arapdzgk1tddoiu6s7j7sgtddh7rnm
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: D49596000C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+qYpolyQ0nxcIiCgW3JrPU4QjD8DMW0ao=
X-HE-Tag: 1769030747-404029
X-HE-Meta: U2FsdGVkX18mMhNCVX6b+tW5GGOQMGF0uRdwyeG86P2+f76iRCx3ok9l4PkXPP1axNXtnOf0xzoxreKqpInVOcvO3nZjevmzeF9ew5/fxz8qbSHd7KslLkLJWepqS9CiSlh+azoSxGj+PG+lT48kupd7DRvYMC40aYQ/d93uyFvKMi0Kc8cLb5mSRb0p3GvONDtP+MNtl+afsYOzx2fpDfp95XDMr3iobre6VuGQGXmd8xIvNxH0RX5cyZ+Hy1nKwYNDD4xL3qHIF1cP3w8BgB8t9ApZP210Rn1ZJ++xJX8i/jT6mtgVHj7tKojhJJchTb4MZr3a1SvOxEgN+zR28pB9efNIuAT6smjNz11I4PxULuDWLjh+gEh3gyghm9jaKGv6s2mn6BtsunkHsYFTIwc/UhrS6LxEDk4ehWE4gScI9XUn391R9DhK3AzgsoWY

On Mon, 19 Jan 2026 16:15:25 +0000
Daniel Thompson <daniel@riscstar.com> wrote:

> I dislike the proposed new summary. I think keeping "io_page_fault"
> in the summary is a much better use of characters than spelling
> dereference in full.

Agreed. You may safely ignore the comments outside of adding a "Fixes" tag.
That probably should be done.

As for your patch:

  Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
