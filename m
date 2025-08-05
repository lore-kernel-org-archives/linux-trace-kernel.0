Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C40E41400C;
	Tue,  5 Aug 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754401043; cv=none; b=FvRJcc+rMArQf7CFWcmpR+btQYvko+a9fmZNOvpO6u11+emmqb6wPFlfolKP9Xp2slOVM5YDHRe4Kf471TC0cIwqBRIvbs8MGFdQ8Z5sDctqIGF2libPhmryKMGZpoSulq8w1yRTdb6wJ5jXh0TFCwwrhIRibXk1NAniZkp8/Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754401043; c=relaxed/simple;
	bh=t8B62mkvDKxAydyLsM0PN7LNkkbjXn0sroLAgb7rOnA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=szuxY7SE05xtpg+nO5ylldXTreq2dCCe6Dzi4TWpcuk8/ncx7U7QZ2dkwmGr8vhP93nRmtxSZYrC7tbS31Ti7lRTvaMo++TsRyzNClNElX2UBQ5fZs5LayakqOnRBVOQN3rbVSPXnZf7czf3weKyvVGf5N22Y4rv4ybiAvJfrH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf12.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id C80D6814E9;
	Tue,  5 Aug 2025 13:37:13 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf12.hostedemail.com (Postfix) with ESMTPA id EBB011A;
	Tue,  5 Aug 2025 13:37:11 +0000 (UTC)
Date: Tue, 5 Aug 2025 09:37:41 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Qianfeng Rong <rongqianfeng@vivo.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, willy@infradead.org
Subject: Re: [PATCH] trace: Remove redundant __GFP_NOWARN
Message-ID: <20250805093741.0a8ed16a@gandalf.local.home>
In-Reply-To: <20250805023630.335719-1-rongqianfeng@vivo.com>
References: <20250805023630.335719-1-rongqianfeng@vivo.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j5edjuoapcjc9qwjh44emm1kn9s1g3uh
X-Rspamd-Server: rspamout05
X-Rspamd-Queue-Id: EBB011A
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+xPzhdDVPxXBgePBycPgPrV27rmxtrLJg=
X-HE-Tag: 1754401031-42219
X-HE-Meta: U2FsdGVkX1/kJmEUEQzhoLIfpnWU5hfZYvvua1LGWRFb83PLuO3/zkBFsqbFcxdyCcbfl+bbwpBY98KRbOeA5fPYvZOF4A+ScpREzzj8Qb/h19UlzaJFcTEpbvWNz+tD2wA0/xqVrM0TSv68xzXqn8FRyEI8hUOYbtenjnXJlV41x/tx5Mv1YstwMq/H+FAbCtgADdJ+IvSqAB9acWKVm5sdwHllUWdsQt9fol+4HAQM7yEDUCGCOAbJ4bi1/K11N1p+SWU7t5x7lZFJoc2gHECF5a+F+WUumI6Xk74y+KnSMT8ToiSOJ0z6Ua5SiWvGnvKBnAUJR/R4Djhlr25IgQU1ynM34sfwXnwLHZlwneiOFPVE0tV/7tdw/uLRzJkRr5lqWp6P0vhNCO7+9S+6bA==

On Tue,  5 Aug 2025 10:36:29 +0800
Qianfeng Rong <rongqianfeng@vivo.com> wrote:

> Commit 16f5dfbc851b ("gfp: include __GFP_NOWARN in GFP_NOWAIT")
> made GFP_NOWAIT implicitly include __GFP_NOWARN.
> 
> Therefore, explicit __GFP_NOWARN combined with GFP_NOWAIT
> (e.g., `GFP_NOWAIT | __GFP_NOWARN`) is now redundant. Let's clean
> up these redundant flags across subsystems.
> 
> No functional changes.
> 
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Acked-by: Steven Rostedt (Google) <rostedt@goodmis.org>

-- Steve
