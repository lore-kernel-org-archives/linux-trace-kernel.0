Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31463226D18;
	Thu, 28 Aug 2025 14:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756391659; cv=none; b=GCPbNhsIqsVKX5uNm+QDBrFTnnJINV4oiSMyAG1+MT4eHbm5RsdynGmrmikVyYavIXoM4YsTV8NtMzN/SrjJetemC9/ZWTUpV4bjE0JrVyKnAEMDsHCm5CslHVfivmMiMU4p7tauvNlMqwpTZR7Nyjcg3e1wCfJT/Yg1LkFzlRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756391659; c=relaxed/simple;
	bh=AugeI6+ziOCwr9Df6fzxmSacZoIPicP3QCTXwXZuWAM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oDJ+Ifrh1DIAgSIKpDIHNOP0+QJfJekLhUj7Tuk5+pWRFXJRhLAW7Rk+EwBLgcqGkOuBKjuWxI4GKi7gJ1uejLtD0E71fBcocre1G+eFwRdafZcdg1c5XyxgE2FGq/akgHF9Vg+rBdbmLdHLsM3uHvRybAtnEMDllZZPBQL/rMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 9D38357855;
	Thu, 28 Aug 2025 14:34:15 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id 944D32000E;
	Thu, 28 Aug 2025 14:34:13 +0000 (UTC)
Date: Thu, 28 Aug 2025 10:34:33 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Menglong Dong <menglong8.dong@gmail.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, oe-lkp@lists.linux.dev, kernel
 test robot <oliver.sang@intel.com>, lkp@intel.com, Menglong Dong
 <dongml2@chinatelecom.cn>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [linux-next:master] [tracing] dfe0d675df:
 WARNING:suspicious_RCU_usage
Message-ID: <20250828103433.1498f8a7@gandalf.local.home>
In-Reply-To: <CADxym3aHUDGahE1S2LzaDZA4vZP637txcMzQR3_r1U00GikEUA@mail.gmail.com>
References: <202508281655.54c87330-lkp@intel.com>
	<CADxym3aHUDGahE1S2LzaDZA4vZP637txcMzQR3_r1U00GikEUA@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: ahbtabrr5y9y7eoyyyxjjhgzdeie95as
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: 944D32000E
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18M9Z1qc+/JGkwBdv/P8HI02lfqXlwoh3o=
X-HE-Tag: 1756391653-237669
X-HE-Meta: U2FsdGVkX18Z08jeiwfzhl9wzzBjpYaCscixD6Ujj0Usn5sSYw8XS70FdLMq/6cqP198xPLmk3tsGA4BKBs8VmoOHnOXB4N2/82x7B7bRzRMINtPVXeZdcNhtRVdT8kRmMq3Dl95Qe7e7g/Z+eQ58E8w+HnzH1utgUzrtZXj0D6m+T0WV1mDVrjEYH4b/+CoE7LdLpT4IofYPI1kKOazQgwMPTLRIVuNl++kQ6/qH8ja6xzHxNpq5qQDKJLmcQvkRsaxfjEI8b9ZFTzLFsGCYMgO9//ac2sPG/AHsk316xr0HQ0ogAb8RW4Hg8AIIk/KzoW0QB78cglbHgnqD2oQQdkY8xXOCebV

On Thu, 28 Aug 2025 17:09:35 +0800
Menglong Dong <menglong8.dong@gmail.com> wrote:

> > [  354.955971][ T4652]  dump_stack_lvl+0x7c/0x90
> > [  354.955978][ T4652]  lockdep_rcu_suspicious+0x14f/0x1c0
> > [  354.955987][ T4652]  __rhashtable_lookup+0x1e0/0x260  
> 
> rcu_read_lock() is not needed in fprobe_entry, but
> rcu_dereference_check() is used in rhltable_lookup(), which
> causes this warning.

Why is rcu_read_lock() not needed in fprobe_entry()?

-- Steve

> 
> Adding rcu_read_lock() here is able to suppress this warning.
> Maybe we need only rcu_lock_acquire(&rcu_lock_map) here,
> but it's not a common usage. What do you think, Masami?

