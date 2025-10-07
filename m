Received: from relay.hostedemail.com (smtprelay0011.hostedemail.com [216.40.44.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82B212036E9;
	Tue,  7 Oct 2025 23:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759878754; cv=none; b=nr60TvwZRA/zsg4LjZcOq7c0rV+8tyPuMR3eHJ44s5NwIMYGGN8GuJ+axEAnjfx2WyOxSLUqo4HHIby7Su30sIqrOUHeLV8PT1PiaLrgbt4fWObRZ66QjXVWU77AkmUPFt7sjdaXsxjU3j7n7ab4CX2vrQ6t/ec1ZiOBXVDfjyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759878754; c=relaxed/simple;
	bh=L0OR/eEgE1BGptpL89EyN6LrGzo0DI3u5c2FvV3B8R4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPTXImsxi0aAqPInh3gyolnkYS5+p/uGljJ68y4/geP3h/DnxvEZH5AjMk9UkkdNuAdHPOQwGk8bA5MhOUbBcDOyNYiO/D3Lhw9pCTJc83c8qpKH+6hbJfgOr01HlEiUuW0eTbxHnkhfVNBtf5FW3t/5kOpzUJf5C/8QSNGRktc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id D0801B89BC;
	Tue,  7 Oct 2025 23:12:24 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id 035DD34;
	Tue,  7 Oct 2025 23:12:22 +0000 (UTC)
Date: Tue, 7 Oct 2025 19:14:15 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Thorsten Blum <thorsten.blum@linux.dev>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: Replace strcpy() with memcpy() in
 __trace_probe_log_err()
Message-ID: <20251007191415.01f9005e@gandalf.local.home>
In-Reply-To: <20250909085308.15a7f4379b5d324051bbd383@kernel.org>
References: <20250820214717.778243-3-thorsten.blum@linux.dev>
	<20250825160540.9a5272a8a93a789eb36a7098@kernel.org>
	<635528D7-9B5F-4B7C-9568-87375BA866C3@linux.dev>
	<20250909085308.15a7f4379b5d324051bbd383@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: u6ai4tgjtg8rgtdjtykmh8q3ph8ymy4z
X-Rspamd-Server: rspamout01
X-Rspamd-Queue-Id: 035DD34
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+Ff9b1DNCLepTkZDt5aQMiGOVgvqB0+GY=
X-HE-Tag: 1759878742-952239
X-HE-Meta: U2FsdGVkX1+aONDPtlaQVv3ANLbOF2BQ27Z0Ll+Qvnp74koU4CrrC28SQzKRb4Kj2hJDb/vsUwOAfzR0q/Zapb8QE1UuxBuLdbbqEmT/oakUgvbKjgTwcM+pOEk0/aKeLhY4JnZitjCTJ4z+6E04TL6V+uJY+MpIQDwFbTNEXb9PfvuXaLNxLm8zKTw4bjWXNX/PdDm6ntP5EQlrOc6m3TtldTFzvuyqow1lbu9klgyinQwX6AuMFVh+RVd9KeTmQFfMC8sNQX04nbx+Ncf3BnGEBrr49WYidYDHcu1E3J5ynpI1jzAyQYzmxD3NL2vvWvLXTNaHydgeo7xc3AZ2yTpEqsvrapo5wC+8C9k2egAcwWgpfAcx+g==

On Tue, 9 Sep 2025 08:53:08 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> On Mon, 8 Sep 2025 12:13:23 +0200
> Thorsten Blum <thorsten.blum@linux.dev> wrote:
> 
> > Hi Masami,
> > 
> > On 25. Aug 2025, at 09:05, Masami Hiramatsu (Google) wrote:  
> > > On Wed, 20 Aug 2025 23:47:18 +0200
> > > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > >   
> > >> strcpy() is deprecated; use memcpy() instead.
> > >> 
> > >> Link: https://github.com/KSPP/linux/issues/88
> > >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>  
> > > 
> > > OK, looks good to me.  
> > 
> > Did you forget to add a Reviewed-by: tag and/or to add it to your tree?  
> 
> Thanks for ping me. No problem, I will add my Signed-by when
> picking this to probes/for-next.
> Since I will be responsible for applying this patch and sending
> it to Linus, this includes the "Reviewed-by" as well.
> 

Was this ever sent to Linus?

-- Steve
