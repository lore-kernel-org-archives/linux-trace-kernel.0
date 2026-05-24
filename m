Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F53F1DDC38;
	Sun, 24 May 2026 01:44:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779587084; cv=none; b=Z94riM8F+LPS5pijWsPOy9Kv4IAe1wtlemT09eBkZMmxKCBBs2klcBShQaMkYGAYSwGYJJoG8lU02T0cUmR/BK9WrUj+zhGBk2va8kHBDCwiuU676dy0E3+kUjttMmZ2/ufFRtCMuhMaxbuE1hkRUpdonIEimEiTeu1HDIik8R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779587084; c=relaxed/simple;
	bh=pASKiUhngDJqJtSseIMPQGmPi1FoocQ5F9U2lCmnwSk=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=r2EHB1rX9LwD9VpLQlq/XL0OH65VyBPbs6IZKfDbvxBTZ+pYqMz2oru2ox9K29CvKchqOUfcZ6Ntw9rO8t7bSWZySz0ObPvSd23GIDLJb7D6Nxq98MT24oDMh2vo/ULurdJe2F8AAYvUo/12FJvucjFHHd4f7PRZybNWyctnsQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nGYZ8pVN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nGYZ8pVN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 421521F000E9;
	Sun, 24 May 2026 01:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779587083;
	bh=SZeLFne5zONtUyedQld9JbP+mKovlG1YltZn9Usop30=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=nGYZ8pVNiq+nIsDyLYJVMennKi+iDJTU1vQv9gFiHMMWxw/upOyseuZ0PZreK6Miu
	 np8untuxHjKw/kMYTLJByOva1KSTtGDQzGqizKLXAwBtQ2Mf9EfFgZrsVEpyX4gaox
	 WvQV1/vV/r2XlkmRF8Oonm0FyCRCLUQ4gs8hLlwfWqkdpGSKcQr/xGVenDM/bZgs9r
	 cDKW/hj1TQSx2g5MCkeb99cc/ynEpFgPxENkMIewTDJPhPynkiRfl5exqF8hpRBxOe
	 ozHsN7xDcva48+XyGjqdqg/fiQr8YcZsXe3kFzWGghE0k0UYAelUErmkxuxCWp4o/+
	 X7wg+3urtOMoA==
Date: Sun, 24 May 2026 10:44:39 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Theodore Ts'o <tytso@mit.edu>, "Jason A . Donenfeld" <Jason@zx2c4.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 2/2] tracing: Record and show boot ID in
 last_boot_info
Message-Id: <20260524104439.ec01284998cae6d4a5053e61@kernel.org>
In-Reply-To: <20260521111630.1f558754@gandalf.local.home>
References: <177937541909.2596845.17729857441826694760.stgit@mhiramat.tok.corp.google.com>
	<177937543666.2596845.9748178606108139386.stgit@mhiramat.tok.corp.google.com>
	<20260521111630.1f558754@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 21 May 2026 11:16:30 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Thu, 21 May 2026 23:57:16 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > @@ -4804,6 +4806,7 @@ struct trace_mod_entry {
> >  struct trace_scratch {
> >  	unsigned int		clock_id;
> >  	unsigned long		text_addr;
> > +	u8			boot_id[UUID_SIZE];
> >  	unsigned long		nr_entries;
> >  	struct trace_mod_entry	entries[];
> >  };
> 
> I just don't like wasting scratch space if boot_id isn't defined. But I
> can't figure out a way to optionally have it there without wasting space
> anyway.

Yeah, it needs to be placed in the scratch area or ring-buffer meta page.
In most cases the boot_id is enabled (random subsystem seems to provide
this UUID always), so it will be rarely waste of memory except
CONFIG_SYSCTL=n.

> 
> If the get_boot_id() is accepted by the random folks, then I'm fine with
> this change.

Yeah, BTW, Sashiko found this can be initialized before we get enough
entropy for random seed. Maybe we need one more delay.

Thank you,


> 
> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
