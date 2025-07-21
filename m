Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E03BE25760;
	Mon, 21 Jul 2025 14:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106670; cv=none; b=FV8pajR2A45ioZjfuBIWkmLTmggTEqorFjr5cIKPgLIjpBTKNY1Ou3EVTqqPndOjBGUIB1E7259DkOwlPGndC4DpQ6dd46oZ10nRypFgmf2+xQQNbB1eLM/71jHPC7b1BLoMrSPYJHDk6w9Twi7LE5eZ07IHjOVp4p6MVZdeo9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106670; c=relaxed/simple;
	bh=Bb9NdE0r8eglpW35emb984Wyuq/QD3HMTal5YQtSUMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uiHtdqZNFDDa8FBz2jFT33MsHHw39a23FxQnzDx1pycNWKz7JsyeqAdzbbSviNlm9QsrkbI1C4wwZK+FLIXE6jBJa7IUfPFXsYkazSW73kMmP2K/S61hu/72+1JXYhD0Op/HNpMGkyACFkPLKLofxUnsG82xXBMpcfqXZ3CnqE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v0VrMFtb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wpGL+B61; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v0VrMFtb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wpGL+B61"
Date: Mon, 21 Jul 2025 16:04:25 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753106666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9atouwKJiTcwQJic35rzDybT90GnqB7oVE//fxkKSc=;
	b=v0VrMFtbYmxlVJhZuSWolwNNp6dYi3HJvfWo4kjSAGb6SPwVX1aIgcNhhKkcQiYB2hyRrw
	fUeEhG06vCUgZs0oYkWtBv2xeZv9Ry95dVSXYMmTEPA4kYV/tk6w9lb47U7uN7WM4v1MC3
	J5fI1SKJorj7zSLyAW1xTWNYF3K+1vamtEtT9cf6BIcpmIAIDkaY2bZq8getNLwvnCDgqb
	VZkjUPYl0NCh//k/4nHTWRgs9lbV8dMh0KofEDNxHyZ2ccrefBv+DZ4PNU6EdE26jP7txt
	UJ1enG/EmKgJNw6wYvJOMmwX6sO75mWLfhGhrdJ1T0etslK8evxJGTZs6uefxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753106666;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l9atouwKJiTcwQJic35rzDybT90GnqB7oVE//fxkKSc=;
	b=wpGL+B61eXH9DMdK2JrKRicUe6NNwwZUqXhqdLVNa8H54A7t60abeRXqYZiWlucuyxAuQx
	l7TVRES8XcHjXVBQ==
From: Nam Cao <namcao@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] rv: Remove rv_reactor's reference counter
Message-ID: <20250721140425.OeD16I4D@linutronix.de>
References: <cover.1753091084.git.namcao@linutronix.de>
 <4ebe4d49e07890eadae41da233e111f8723fba12.1753091084.git.namcao@linutronix.de>
 <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2de814842fbbeee888e076db2f80bf2028fdbb0d.camel@redhat.com>

On Mon, Jul 21, 2025 at 03:20:44PM +0200, Gabriele Monaco wrote:
> Mmh, I'm not understanding how, let's assume I create a custom reactor
> as a kernel module and I want to use it on existing models (built in or
> modules themselves), I'd do.
> 
>  insmod myreactor
>  echo myreactor > mymodel/reactors
>  rmmod myreactor
>  ## I want this one to fail because the reactor is in use
> 
>  echo nop > mymodel/reactors
>  rmmod myreactor
>  # now it can succeed
> 
> How is MODULE_SOFTDEP helping in this scenario?
> Am I missing something here?

You are right, MODULE_SOFTDEP does not help this use case.

I did a quick search, it seems try_module_get() and module_put() are what
we need for this. Let me amend the commit message.

But my essential point in this patch is that, the current ref count
implementation does not work. Furthermore, we should use the centralized
kernel module's facilities, not implementing our own custom logic.

Best regards,
Nam
