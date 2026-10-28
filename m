Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=216.40.44.11
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793205057;
	b=evvRGinyG3JQyQre7BmeorVmN5CaCDN0Kadv7f6sW/szRFm0L5u4z82jMeEBXOnLxAxK
	 z6nGQaa9J6LUS/6ShAqLcmXiD2l/OWN5aKVegeI3xypvpaHZy1uIX6pfkQb/p9X92cnrT
	 N77TR9p/dS9//OryJpUYPnURWYZzeigCNGB61r+sRpRgyGQUdlprb0iw9WNARHCxfwv5t
	 Pj55BRvY24HBzasGkeqE6OQwWSYl6XfKpDY7YLVvQIreseZi6uGZnE4ea+5eDSweAOH2O
	 /k8SfcfYE08QCUMTAsTBulKvL5oTBWYxXyRrY2G9vi9PUXi5xNOpnWcAYJxNHXy6DBw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793205057;
	h=DMARC-Filter:Received:Received:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:X-Stat-Signature:X-Rspamd-Server:
	 X-Rspamd-Queue-Id:X-Spam-Status:X-Session-Marker:X-Session-ID:
	 DKIM-Signature:X-HE-Tag:X-HE-Meta;
	bh=hNMH20UxlTLKtx2w8JK0igQhygr0c2opzIkwVuCodCE=;
	b=AJYA4MU/zPTuBIM752CBz1GM28mdtX/EOeIV8OUW0FY70eUg9Z7IEA715cP7PnypICWl
	 SkAWh6Cj4F5QSu5DCPuDGNpbA5GLikErATjmEQWLAlXP2P+k4c1xgeqx7mnv+BTz/t3Yy
	 BS3BrvAgNli4ZnX9SIHeiAvDctY1JLEFRkJ0eV04/xAwE8IVtHADRK8xi6y3E25BUsqKh
	 j6Z0C6DC9DVBaF24Tx10NaSiIRY9lqn3eE2gl9JcjEoZKY67J1VjtSNzoJcSCNLh9N+qr
	 XwcP5WxVXCjBtfAKmEETtYzfzuEJtXnqsgV2Df/eGvgxgMSwlD0pGoUCpkOJk8TcSFQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=goodmis.org;
	spf=pass smtp.mailfrom=goodmis.org;
	dkim=pass header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yrjCyv1p;
	arc=none smtp.remote-ip=216.40.44.11
Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25C05606A31F;
	Wed, 28 Oct 2026 16:30:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 25C05606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=goodmis.org header.i=@goodmis.org header.a=rsa-sha256 header.s=dkim1 header.b=yrjCyv1p
Received: from omf14.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay02.hostedemail.com (Postfix) with ESMTP id 6E3A112015E;
	Wed, 28 Oct 2026 16:30:54 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf14.hostedemail.com (Postfix) with ESMTPA id 919F62F;
	Wed, 28 Oct 2026 16:30:52 +0000 (UTC)
Date: Wed, 28 Oct 2026 12:30:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Yury Norov <ynorov@nvidia.com>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Masami Hiramatsu <mhiramat@kernel.org>, Yury Norov
 <yury.norov@gmail.com>
Subject: Re: [PATCH] lockdep: Add #include <linux/instruction_pointer.h> to
 lockdep.h
Message-ID: <20261028123051.0c65e19f@gandalf.local.home>
In-Reply-To: <auIZQDojrrv43MrA@yury>
References: <20261028110558.623a92d1@gandalf.local.home>
	<auIRtQjGjb0yeYCX@yury>
	<20261028114528.137acd81@gandalf.local.home>
	<auIZQDojrrv43MrA@yury>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zjwdpqaui9tzif6o5ku6q47r3edfwjmn
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 919F62F
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+EaWfig7TWSU0HuK/DKFjRR2aY4trQpqk=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=hNMH20UxlTLKtx2w8JK0igQhygr0c2opzIkwVuCodCE=; b=yrjCyv1pOhRGaxalJO+lehXPGKx2inxYkzVPP/F93E6M6jO8KrPzaoLHcA+/S1Iy0x/oqfw9n2HOA6AS6rxqshhpcMZreyYzPK3Vm112wfpsb54nIVBB+SyK/8C/sYOH9lC501R59Xgc57nxv+apwf/+5vrhZGFgyigP6YmWNRo=
X-HE-Tag: 1793205052-708848
X-HE-Meta: U2FsdGVkX192w1Z+UlGfnSX3sGOJmcvBaWTShSNsM3XaiK0rGWlRHYHpMjKrUaZMHyZjH322HpooMWlKYCfR0lhTx1RcD0ibnIavKdZn2iQ2YRJJpVNNWpfo+62IgyYaEPVm5IrVL5KxDMeF6pF6KZ45+uOuTs3OpJQENSMCsJB8URIymHPNNaMWMDNcLBQLkVgXc4Z93aYJefu/PYvOXNUfraNdvF9eFgj46/fJGc10UpGhaKn4EWGqtUBwyghChgWAPZ4JlT7b/iwW3HWWFc80SO1c3Fi/Iwk3KubtwYZEmMJxvwWeKb7F1MhfZO7LeexQDne/t0EBtKlijUxFwToTra+bZ1pz6LTbFeiaiaCTxhtSnOjOAA==

On Wed, 28 Oct 2026 11:48:16 -0400
Yury Norov <ynorov@nvidia.com> wrote:

> > Peter, can you give me an Acked-by on this patch and then I can add it to
> > my series to remove trace_printk.h from kernel.h as that depends on this
> > patch.  
> 
> Steven, can you share a link to the series?

I just applied my last series:

  https://lore.kernel.org/linux-trace-kernel/20260625104007.041432666@kernel.org/

-- Steve
