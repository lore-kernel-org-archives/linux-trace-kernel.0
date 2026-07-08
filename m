Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA2E3CD8C5;
	Wed,  8 Jul 2026 06:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492296; cv=none; b=VMTB2RE9OMQyYDH4gHfjfH/OftgJEr64/15cpDmqAcy6ZxEV6V9vd3CCib+ahRN5RwiUK2KjdGBx03AP3SkCN9NUENiQf8aQnubLRHqqUD6j38ZWJfTNPx0cSlqBnmIMQgyDQJyYVpif8Nguu5+XpCbjib4Vot3fPbRhdmd0QQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492296; c=relaxed/simple;
	bh=xM1dsWTcIqK1MdR34/5fhLdYmoxFtzkQpj3WiRKtshs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b4DkAtCJp3Ih3VifHFSj0ojrDnoUz91LAkB2UDzWctWtytbAEJ3Ya7dShvEotXEqxilTxnb9wSNcTBmQNwL9dn12cWUgFyjj/psEOuhv47ZoDgbtAzjhmAUscCIwydCKZ5WwW0iWZ68uYNvyu4Ft1wiR8c2mUwT3SQuqcXIVy+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMBpqUXc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMBpqUXc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA33B1F000E9;
	Wed,  8 Jul 2026 06:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783492292;
	bh=IdgAJHMGRJTpfsfF+AYasgFlGXIoomItdq4jFM8o5mA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=FMBpqUXcx1rEMTajpDAMv6rywRMlwmMyOccijI1R/LaMEARbJW4BU2vPsEM16GZ3w
	 C6OSsjIMkOGc/kaMV3u5QLJfXv9sX4z8gmmz20zVgxW2/9uz2/iWaD5rhqR2+xIIkJ
	 kxMMksBnbV5y4F4dehkhT6QGP3MQsPVfWf5IfDUdLjIwCF5W9yuD+fhsr2ikpLaDbf
	 LJ8ZqfLC0pDgnKbxRUdlH23b3D4isas2eAoxs16Oj4XhDPsI4a5lO5rg1lIY7LXYSA
	 ou++MqG63MBLoNaRzzrtzkcGyuuuFSyTVxZvdaFe8QSylmgXFMU3uXogsqti8rg2np
	 uyWq1EFX08FOQ==
Date: Wed, 8 Jul 2026 07:31:18 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: Wandun Chen <chenwandun1@gmail.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux-rt-devel@lists.linux.dev, akpm@linux-foundation.org, 
	vbabka@kernel.org, surenb@google.com, mhocko@suse.com, jackmanb@google.com, 
	hannes@cmpxchg.org, ziy@nvidia.com, rostedt@goodmis.org, mhiramat@kernel.org, 
	mathieu.desnoyers@efficios.com, david@kernel.org, liam@infradead.org, rppt@kernel.org, 
	bigeasy@linutronix.de, clrkwllms@kernel.org, Alexander.Krabler@kuka.com
Subject: Re: [RFC PATCH 0/3] mm/compaction: honour
 compact_unevictable_allowed in mlock race and alloc_contig path
Message-ID: <ak3uV7L5EEi3aKyD@lucifer>
References: <20260604023812.3700316-1-chenwandun1@gmail.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260604023812.3700316-1-chenwandun1@gmail.com>

Errr... how does this relate to your other, non-RFC patch series [0] "mm: honour
compact_unevictable_allowed in mlock and CMA paths"?

Why did you send this separately and why do you not mention the other series
here or there?

And why is one RFC and the other not?

You really need to add more context like this, I spent quite a bit of time
reviewing [0] and don't want to find out that actually you are abandoning that
for this or something?...

On Thu, Jun 04, 2026 at 10:38:09AM +0800, Wandun Chen wrote:
> From: Wandun Chen <chenwandun@lixiang.com>
>
> vm.compact_unevictable_allowed=0 is meant to keep compaction from
> touching unevictable folios. In practice there are still two paths
> where it does not take effect. This series fixes them and adds a
> tracepoint to make such issues easier to diagnose in the future.
>
> Wandun Chen (3):
>   mm/compaction: skip isolate mlocked folios when
>     compact_unevictable_allowed=0
>   mm/compaction: add per-folio isolation tracepoint
>   mm/compaction: respect compact_unevictable_allowed in alloc_contig
>     path
>
>  include/linux/compaction.h        |  6 ++++++
>  include/trace/events/compaction.h | 26 ++++++++++++++++++++++++++
>  mm/compaction.c                   | 14 +++++++++++---
>  mm/internal.h                     |  1 +
>  mm/page_alloc.c                   |  2 ++
>  5 files changed, 46 insertions(+), 3 deletions(-)
>
> --
> 2.43.0
>

Thanks, Lorenzo

[0]:https://lore.kernel.org/all/20260707125925.3725177-1-chenwandun1@gmail.com/
