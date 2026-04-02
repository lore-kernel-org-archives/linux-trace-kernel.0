Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B914C3DEAD0;
	Thu,  2 Apr 2026 14:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775141462; cv=none; b=jnCOVhLAcat6IDsWKoKcRxfm1RtUB8Vn0C/Gi9/KImjnaG3yuQKTSGM+eXYgn/79BVCUnS+0EWSPooV3Wge/y8TKuoGANr/mM2kkVk+LvkB5PQbIoKOH6dZ3FlrX8u9yOK+peUv/XNYKR6qYlnC4YQ/LsHc9+CVXFvqNKWIkHHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775141462; c=relaxed/simple;
	bh=HpxrQYFAPpHAbAdtgGXCznl16VT8i1ccVXd/sQ/9/BA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gdlj1Foz6DS1JhSgs6lY2CHq7KEf5X7eEl3jtwSM0+/p68JLgR1eAxueDHIRoRq9O2ysbdZOc/pZ4c7IX8LY9CCGkFrZoMq1DfLgZSCRhSqKqQkCukYb1tnkHE46pwbRCKXIOuBEZq8Yk0ELixA2GgRXnlrIwpu8UCXiBNOpqC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay09.hostedemail.com (Postfix) with ESMTP id A06E18C3F7;
	Thu,  2 Apr 2026 14:51:00 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id D4D5D2000D;
	Thu,  2 Apr 2026 14:50:58 +0000 (UTC)
Date: Thu, 2 Apr 2026 10:52:01 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v9 2/3] tracing: Remove the backup instance
 automatically after read
Message-ID: <20260402105201.7ed836be@gandalf.local.home>
In-Reply-To: <20260402221943.e0ba663a6a223f7f857adaf1@kernel.org>
References: <177497473558.569199.6527680985537865638.stgit@mhiramat.tok.corp.google.com>
	<177497475349.569199.11513916633426967730.stgit@mhiramat.tok.corp.google.com>
	<20260331171936.6f84e357@gandalf.local.home>
	<20260401121957.2665d454390aff97593bb996@kernel.org>
	<20260401104001.5461c5f0@gandalf.local.home>
	<20260402221943.e0ba663a6a223f7f857adaf1@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: siu11nctsfcmbegno9t9odtfsh5u41wa
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: D4D5D2000D
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/MeGoGD8rHi/JPUAbRtNFsz3og8fJmw/Y=
X-HE-Tag: 1775141458-826021
X-HE-Meta: U2FsdGVkX18MD4NoU7hqCWje8U/9zhg+x7fyqQ9wLiP9t7g+WznJMvAr0x3Y8Ju2YYubekqq0sC3z2mmJLI+ytKUi6kMLu7oQA2Uo6v0B65vIObH3IVDgVHxyA5JnqhHuJDdacmW7JTUbxcK6GAVbeLpM9fqT4bSV9DNaI/Ltzt0FzRwhcFYkxwgbT7FimdD1/KTnf7IJ/4kQCMabfY/l6gU3vQwTb81iYARzBtUlhb5ISp+9GUnYW1NMxSAKEUo7X76OfN5Nkm48NM5a9Bao3TTznN6Hb/w402yVutRpcT6ljXF1sgNkKfyBWNNMfpU2pCzdhdet2zq986R6dXnTvCs3E1XeqAq

On Thu, 2 Apr 2026 22:19:43 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:
> > 
> > rmdir() doesn't use __trace_array_get(), it uses trace_array_find() which
> > we shouldn't need to modify.
> > 


> Oops, OK it must be updated too.

No it doesn't. Use trace_array_destroy() (as mentioned below) and all will
be fine.

-- Steve

> > > > 
> > > > What would prevent this is this is to use trace_array_destroy() that checks
> > > > this and also adds the proper locking:
> > > > 
> > > > static void trace_array_autoremove(struct work_struct *work)
> > > > {
> > > > 	struct trace_array *tr = container_of(work, struct trace_array, autoremove_work);
> > > > 
> > > > 	trace_array_destroy(tr);
> > > > }    
> > > 
> > > OK, let's use it.  
> > 
> > Yes, by using trace_array_destroy(), it will fix this.
> > 
