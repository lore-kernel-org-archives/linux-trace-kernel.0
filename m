Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A91EA59;
	Mon,  9 Mar 2026 02:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773022764; cv=none; b=MOvxeegpERKjo5lfjIqc7HVJ+oT/loREGpT60slwmfx981VzqdA/auwbpxkI8hH/cni7QCV1q3DKdx3b5C4YWkaZEb5KlCfmoaJNRmeRkh2FAspXCL3xH45LF7M1MeuBc2LXdHWEun5v6SF/ODPmSQdShDoguSTdPTGy4GYSf00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773022764; c=relaxed/simple;
	bh=Z0idPxSWsp5YkYO2mb7Q/ZdUq7JoIzaOd55dIdEcPQk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YwWfgqGLGtRTLjCuY+1/mLVfT24Z9/9Z+LelaECBkIz46SUcRXzAJzRKH54B3O+TcltVNaDHSHPq8j1pui5O6g522Ok6uqfuEJgIk5PSQZ7ugjJOpmgeb0kAjgRtSWLNCNFerPmQuOFLWStwOOhbU9S/hFIUSHeoj76WKspjBq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf02.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay08.hostedemail.com (Postfix) with ESMTP id 2AD53140C98;
	Mon,  9 Mar 2026 02:19:22 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf02.hostedemail.com (Postfix) with ESMTPA id 732C380014;
	Mon,  9 Mar 2026 02:19:20 +0000 (UTC)
Date: Sun, 8 Mar 2026 22:19:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v7 2/2] ring-buffer: Skip invalid sub-buffers when
 validating persistent ring buffer
Message-ID: <20260308221919.0ca52de6@robin>
In-Reply-To: <20260309095307.19a504c6880407bbf36b2cca@kernel.org>
References: <177289358078.248514.14947007976699929481.stgit@devnote2>
	<177289359843.248514.164858607457269337.stgit@devnote2>
	<20260307102711.50932648@robin>
	<20260309085317.6679cf91151767eff7130cc4@kernel.org>
	<20260309095307.19a504c6880407bbf36b2cca@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 732C380014
X-Rspamd-Server: rspamout06
X-Stat-Signature: pqpxsx7n3mx9pmjiq9371qdoqztsuu4b
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+cDp4ioUlFkxnXOLEHJiMfqIiD09ztqm0=
X-HE-Tag: 1773022760-381430
X-HE-Meta: U2FsdGVkX1/0J4RJrFeS1hyHQGiscP6Z4mMMBFe/DrLH0bsdJynjxEt6LReaoCGnnCeLK0OE0yJZybyZ5S2AlaPCW9QrIql3pB2ETjXfSm453ReJeN5ohTRr5B2Rfos+WYx1SiuZzZwn50LIg+RKuGhIh8DHwEg14yUbwJDsl9lUUvUFRXR8kBxInxwNGL0lRMDmIFlQclGzNI/NpWDDWcvP98XjVcthGCbqotVR9V6kvj4ofN9WrIf1GCzRDnKqeW+VVTRXJBIewEE6k0P8Q7IJr2lW21FMVqcpH3aKKSN2XI3GXieojNvO7m6fsEKUzStOj39dg1pc0FsVXzAd1u1ZC2Ssi4KrXkakFuj+IrUMcPKaz+C5bw==

On Mon, 9 Mar 2026 09:53:07 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> > > 
> > > I just realized that the origin didn't have correct grammar. But we
> > > still check the subbufs, why remove that comment?
> > > 
> > > The original should have said:
> > > 
> > > 	/* Do the meta buffers and subbufs have correct data? */  
> > 
> > I just removed the data check from this loop, so I think this should
> > focus on checking metadata itself. The data is checked later.  
> 
> Other checks in the loop are;
> 
> - the entries in meta::buffers[] are inside correct range.
> - the duplicated entries in the meta::buffers[].
> 
> So this only checks the meta::buffers[] (index array) now.
> 
> /*
>  * Ensure the meta::buffers have correct data. The data in each subbufs are
>  * checked later in rb_meta_validate_events().
>  */
> 
> This will be more clear.

Sure.

-- Steve
