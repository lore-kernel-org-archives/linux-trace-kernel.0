Received: from relay.hostedemail.com (smtprelay0016.hostedemail.com [216.40.44.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8303C229B2A;
	Tue, 30 Sep 2025 23:07:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759273682; cv=none; b=dAkGCqCGFSV9HtstOUZL5hG2W3acEHUMuEhIxQn7wADkpVotU5gsGKbe7Ou41/BlXIFzMntZCd5U8d63odZuRPzmO0Lo7GrCc1mVDFnpgOQCXHzz5zSltvXIa1l2Ks2V6B/fLTh+8uQdRylqrSEzU+Z5UH/5uFkF62cPTnYuo7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759273682; c=relaxed/simple;
	bh=GPyR/faQ7v2wifXfyMDpd37USlERsku05eq4/WCmNAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fx/+ZiefBXbIir38JeY2aTMGcZL8a4JfMvTEvLLmFGcZWMSWmGs7oOisluNztu56+K1isEOPUsNwKnpGoEp5UY0oostE5wkgWeg7pPpT8FuTQbycFJhjsAXlq7IzOhRpe2jCZZQnyNarnVl4tgR9aMxpBZaV5PyERJ8an2AtMG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id 12B6D87E66;
	Tue, 30 Sep 2025 23:07:58 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 521482000F;
	Tue, 30 Sep 2025 23:07:56 +0000 (UTC)
Date: Tue, 30 Sep 2025 19:09:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/osnoise: Replace kmalloc + copy_from_user
 with memdup_user
Message-ID: <20250930190932.26b49afe@gandalf.local.home>
In-Reply-To: <76B6CC10-1C0A-42D0-83E8-8CA8A7790BF0@linux.dev>
References: <20250925211736.81737-1-thorsten.blum@linux.dev>
	<20250930172841.63dc86b5@gandalf.local.home>
	<76B6CC10-1C0A-42D0-83E8-8CA8A7790BF0@linux.dev>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 521482000F
X-Stat-Signature: r9rddzz8a7h64pkn6wc8hidzeacinb5a
X-Rspamd-Server: rspamout06
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/Ihx5ztjhsEo426xsYQDrOedXPBA+8QVk=
X-HE-Tag: 1759273676-790425
X-HE-Meta: U2FsdGVkX18XlEqa9q6Z6CzTtsFsMhPUjse2U3fQ1gxRWonSowFR8jfIXU8dCB5qgqICIKLLoo5VsfmqeSPI2B+nl0BirxLn9GEkK2D/R9d8PuWo/RbDn2qpCRPL8oy98UVgFgajs1H24+DHScy4YyQvP4M6hCSJxa+OCGReXhKkSFb7KK2G/dioaLemrUW970Mqq0Jn5wCuDEb5M1OWKegKLFxRUKnnPSyroQD6kwn9fAeemChfWLTKhCS5m9dpIVpBS8QGXrvtniI29BTdkuTeHl6/E9WRDhZVXjchaIbZRle7VYvjXONDZvR41utU

On Wed, 1 Oct 2025 01:03:29 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> On 30. Sep 2025, at 23:28, Steven Rostedt wrote:
> > Which makes your change not quite compatible.
> > 
> > I'm going to rebase and remove your change for now.  
> 
> No worries, I'll send a v3 tomorrow using memdup_user_nul() instead.

Thanks, you can base it off of my for-next branch.

-- Steve
