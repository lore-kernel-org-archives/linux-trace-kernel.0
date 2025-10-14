Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411C01E47CC;
	Tue, 14 Oct 2025 07:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760426021; cv=none; b=Tr5ACWmsUoa7dRKmhPSKF0og8AqyuIcyMDo82Zcr9DPeD9saCqYlylknfp2G0WbG+OxBKxXTIcS0YFkhGr5cRkWy5+d/fNrs17kVm1TW2avlUjXLdyvL/rZC455SNRCG65UWFs+5B7G+MrXAKdSU+rNnOW4ePIAx2/ASFcAo9O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760426021; c=relaxed/simple;
	bh=aCFRQ2uXFCWX8qcAcovmc+WThMu+KsEfxKioJXrl2kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DybhZJZGN4NMK9As1acOIB703V+j1NxOnV2DWz2vDu3y5cDHTtw9nETfEYriRBHAElr2J5Chxwg9m2Bty3RzIPEdfoEPbfg5L3on2QzlfzJMN0d7mz1V+IdTSkUA2jp8UesODxSyH2wTI1Kv7a+RrETuOLCVJnFAFRpj9E1cq9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rjqkNCmN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dxs24Z2R; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rjqkNCmN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dxs24Z2R"
Date: Tue, 14 Oct 2025 09:13:35 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760426017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iu4oVZPri1i6HI/Yl4ijceB1lmcQihIYwMZtjTrm+ZE=;
	b=rjqkNCmNjv+DJJuWVDIxJPA7aXV+oo+TrFeZkVMgYlPBPdfTJpZEbblDuGUkXY0MjkdLOG
	az8/GWmIE7QyT5zCaz1VZObSc3RDJqdHtusreOZKMNJSuZQPkQla9dJKhmnWlod92Zyupp
	WKuC/7mObCkF0izw0Sz868ZMEwQ7nT3gmT5xHYZzJFXL1FRdEtJTQF6GCVRHXfENAjn9eN
	Dzgx5yK3hq5xr0vjR4d0/6oHzyEvZVQNSbtl/WrZABU56dvqofgzkMIGd0QRwI/sObmhBw
	DDhYFEBr3ZWrGoL249ACO88Bs9qGdxQF/IKNfvBpv4U6smINmsSo4u3ddvOMNg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760426017;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iu4oVZPri1i6HI/Yl4ijceB1lmcQihIYwMZtjTrm+ZE=;
	b=dxs24Z2RrO1hSCIbUQgkm5fZUHc9IcZSal7CGI0mNlXcHZpFZCuflGaWKGGgNie9SThmQ5
	CmJf1lphKVc+DoAw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Gabriele Monaco <gmonaco@redhat.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Nam Cao <namcao@linutronix.de>, linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] rv: Add explicit lockdep context for reactors
Message-ID: <20251014090745-6dea5b0a-0b4a-4666-98f4-475a7fad475a@linutronix.de>
References: <20251014-rv-lockdep-v1-0-0b9e51919ea8@linutronix.de>
 <20251014-rv-lockdep-v1-3-0b9e51919ea8@linutronix.de>
 <1a0d9a427b36d4bcff992dfb8694436cd24d6af3.camel@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1a0d9a427b36d4bcff992dfb8694436cd24d6af3.camel@redhat.com>

On Tue, Oct 14, 2025 at 08:55:44AM +0200, Gabriele Monaco wrote:
> On Tue, 2025-10-14 at 07:51 +0200, Thomas Weißschuh wrote:
> > Reactors can be called from any context through tracepoints.
> > When developing reactors care needs to be taken to only call APIs which
> > are safe. As the tracepoints used during testing may not actually be
> > called from restrictive contexts lockdep may not be helpful.
> > 
> > Add explicit overrides to help lockdep find invalid code patterns.
> > 
> > The usage of LD_WAIT_FREE will trigger lockdep warnings in the panic
> > reactor. These are indeed valid warnings but they are out of scope for
> > RV and will instead be fixed by the printk subsystem.
> 
> Looks like a nice addition!

Thanks!

> If I get it correctly, this patch does trigger a lockdep warning with the
> current state of the kernel. Is there a plan of fixing the warning in printk?

This will be fixed as soon as the console drivers are converted to the
nonblocking APIs. And there are a few other lockdep warnings that will pop up
after that in other kernel subsystems which are currently hidden by the printk
one. None of which should be the responsibility of RV to fix.

> I assume this series would need to wait for that or did you have other ideas?

I think this series can go in as-is. Only the panic reactor is affected and the
panic will still go through anyways. *After* the panic will be a lockdep splat.


Thomas
