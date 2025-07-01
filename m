Received: from relay.hostedemail.com (smtprelay0010.hostedemail.com [216.40.44.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCAFC1CA81;
	Tue,  1 Jul 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751404643; cv=none; b=guBoP7zLwo2WrsiPihsmeHIN0HIch1NCETPDu7uvBLCFTKEaW5mf1t9dp47j8ZSGPzQCWk1TndXxIODYwKOGMWrAtYjGXZKELMakUOWmkzbg4HOEDSJpTPlzTEnYytf0EOgdqcU7RrmpmpirY620YXUcJKnbA1Pw7GjdYLxC00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751404643; c=relaxed/simple;
	bh=/cV6d1pkH2bVeRauPTOQ+IrbBObh9kcPyt+2bvoTv8U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c2QcGeZXWaD1HDbByJeVUN98x5dGc6PafBbFHxRW6Mr8RIjTyM998xAhqITzsWLZJkC59CiNuE9jwDuFnf7N9OXti7Ga9zGGUfByqNQjBWBtlgk1ZBffEDDU2dPjcbykfXg0UkQMkIknt5xDmT+qudLBPlL2qOzdxTsOpqk46z8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay07.hostedemail.com (Postfix) with ESMTP id 74F7016066C;
	Tue,  1 Jul 2025 21:17:18 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id AB1E01B;
	Tue,  1 Jul 2025 21:17:16 +0000 (UTC)
Date: Tue, 1 Jul 2025 17:17:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Gabriele Monaco <gmonaco@redhat.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
 john.ogness@linutronix.de
Subject: Re: [PATCH v10 17/19] rv: Add rtapp_sleep monitor
Message-ID: <20250701171715.5a1a99a0@batman.local.home>
In-Reply-To: <20250701210338.BooVbo54@linutronix.de>
References: <cover.1749547399.git.namcao@linutronix.de>
	<d3cf55d3bf42a0f70a58c394b5cf6d603ca8a9f7.1749547399.git.namcao@linutronix.de>
	<20250630203401.1a11e58f@gandalf.local.home>
	<20250701051757.mBjQVdoo@linutronix.de>
	<20250701110218.5e742850@batman.local.home>
	<20250701110551.5c2dc2ee@batman.local.home>
	<20250701151114.OJQTlRCY@linutronix.de>
	<20250701111704.00456667@batman.local.home>
	<20250701210338.BooVbo54@linutronix.de>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: AB1E01B
X-Rspamd-Server: rspamout02
X-Stat-Signature: k1t1f6axigc9joo1kyg33sgiubod17fz
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX19Ok8LG1r6ryiL8bKaDIIsgZlORN5GmR1w=
X-HE-Tag: 1751404636-345848
X-HE-Meta: U2FsdGVkX1/64e4LZmiVpmpJXNn76gLDZ+XGrCIibaOiBdbiV5il0QIPUo0+WAKmrFyWTeCBwcAtoaSzjS7xlOL5fz2n2HeFx6syQ7HFJOixYpaSFCO/aT+wl5/HBU09h3leOZst51ChlUA+QHSCdLqM4TcvZJf+ym90w93zVr7fVivjksu7iQZ3+cQInLWP0o7NQ7n3a3Eou+XY0nFye1UPhJvIVfiw11fgaGAi7rqcdzGOjtF6ifUp3j8Bi87rtCyzACez8K3NkYEG1VFHIwVZ1kgKsUhAci4BGvrPrrVOhW2nC3B2fRZAvbJ+Vxrt

On Tue, 1 Jul 2025 23:03:38 +0200
Nam Cao <namcao@linutronix.de> wrote:
> 
> > Bonus points if it shows how it was generated so that people will know
> > how to regenerate it.  
> 
> If it's okay, not in this series. It requires changes to the RV core
> script, and I prefer not touching things which are not LTL-specific for
> now, unless necessary. The DA monitors and the containers do not have it as
> well.

Yeah, just update this set to state that this code was generated.

> 
> Let me stash it into my TODO list of RV cleanups. I will add this for LTL,
> deterministic automaton and container in one go.

Thanks,

-- Steve
