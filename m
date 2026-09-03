Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC90E363C53;
	Thu,  3 Sep 2026 18:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788459394; cv=none; b=Foa1dnWnAHjQvMo9s6rp4xvKZ3aiR95Dk/nf95C0U4tfL0Bmjsw2cAmVBF5epfWDn2d4iBt7bDVO5gSnLSEz4xKqxT4iNfYAl+Cal+7yZh4V8enPdwXskD6P/T5Jh4+ps7+poYrTxTaN8U3C3gjgmmDo59iG6Y7iPPYxkhoKk/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788459394; c=relaxed/simple;
	bh=DH3J54lcWr35d6543pM5Gq2JMIeBP1K1WRJtkcGAGuI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LjsrjeAAwiEnziZXNX3dSQA96qqTXhjeqRUC/KDWtpaeBh7eg2DSoSqcV1QbtobwedWChzGahPk+jEHN9OSyJUt4EQTxj2OBxXmq6mW0E+B1kVroYvXbSkAHSPa/eaH2n669S6xZwQrZofrV8JF4MDM+XBhJXqHvs9Bzt5hQA4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=W+ePGUPt; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="W+ePGUPt"
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id ECE84A462A;
	Thu,  3 Sep 2026 18:16:30 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id 1B4022002D;
	Thu,  3 Sep 2026 18:16:29 +0000 (UTC)
Date: Thu, 3 Sep 2026 14:17:32 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 4/4] ring-buffer: Prevent truncation of nr_pages /
 nr_subbufs
Message-ID: <20260903141732.77fb9a73@gandalf.local.home>
In-Reply-To: <apmwYLVIxX-C21aB@google.com>
References: <20260901155445.1475405-1-vdonnefort@google.com>
	<20260901155445.1475405-5-vdonnefort@google.com>
	<20260903131601.4e4caa0d@gandalf.local.home>
	<apmwYLVIxX-C21aB@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: j5nuj9xjsp4qhxcb5skzrro81fqsjyfc
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 1B4022002D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+uQfprVFwdiN9BxXhn6vEHypy/JHs6TIE=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=RlL4RqDryfzUcoxzk6JaTiavl4Q2NneHSI2QDGgl1BQ=; b=W+ePGUPtCF25JbE2he6yqI+k81ER376O0psZk21GtFn+b3aqrq807D53SHULzdfOiy/vaJILIzQ3J2xxRY3uc8VrS7MJkDRLw3kp3EH7s/HtHKsZJelU75NVdH/L4M/MNOXdmFWggUyiB937+4eYOGl1iGwUyVoza18NqHx3lA4=
X-HE-Tag: 1788459389-604394
X-HE-Meta: U2FsdGVkX1+b/9I3NIlJVdjmj5hpOxgI0EvcdA5An+jj/Yn/fuuBZDBI+Y/nY9DxZQ3AXBFGV4fi5Fnefay0/YMs/YGbrXULcSnjZqSARt1WDWwo/kQcfAOmgLC+Um3K7jiKYsbPahn2iPhWdMhxH7sxoVSLDnyk5dFRT7P+zQftB7e1jZUZkxU1/IJv7sAeYaEvOezb8kdm/5qrDyjxJQsDaVO+xA2sCAszLOf+XdB33qj9Exyq22eVOjotWg4DEmS1P77tqOeFHWlzeeHxms0zqEHUIJu69zd5qylCpmVzc3jjbqPEpuODZacE3/jcGHeREX8ZQNKF2FN6PTlLU2uZUUc27ihd

On Thu, 3 Sep 2026 18:37:36 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> > >  static bool rb_cpu_meta_valid(struct ring_buffer_cpu_meta *meta, int cpu,
> > > -			      struct trace_buffer *buffer, int nr_pages,
> > > +			      struct trace_buffer *buffer, unsigned long nr_pages,
> > >  			      unsigned long *subbuf_mask)
> > >  {
> > > -	int subbuf_size = PAGE_SIZE;
> > > +	unsigned long subbuf_size = PAGE_SIZE;  
> > 
> > Why the long? Shouldn't it be unsigned int?  
> 
> That is to cheat to not have to add a cast in
> 
>   buffers_end = meta->first_buffer + (subbuf_size * meta->nr_subbufs);

Hmm, it's only reference once in that function. We could just replace it
with using PAGE_SIZE directly.

	buffers_end = meta->first_buffer + (meta->nr_subbufs * PAGE_SIZE);

-- Steve
