Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 504671F4C8C;
	Fri, 11 Jul 2025 12:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752235565; cv=none; b=XAurSeFOXuMF0s4prmXiWDy+nQ3SDPPjbWyuo2Vms+XkLwolLxOhS3eZi2eiNI8zxgT1CwBmKWmFsfwi6RajV3NWhPe5tp14W6jpQJNv7d2x6wetw3ShAEifa9cuDZtkCWC/TGqN/spu29/8Kpyh17IHhNcA+JTtMQOLvvyXTO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752235565; c=relaxed/simple;
	bh=w+C2sUjQwouIsFCsNgntt7YUSEbg7ZM2AJSFbZgLf/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RLdWZz8va+07zGSp+vnLV/Gq8Jgizd4dKJ5yeg7vgUWqjd2UZVI3wy1rUx7pVB9LJg5QEz0uHUculDEgZYGpMEyd11rAVtXihwpkOyBWg1PQ8MoXAa5V0mzlOhOF9r1lFSW3EXw6azlxKKfaCMAHZ8UxMw8QjLBLkw3Q6Fmwydo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gHeh1jlB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AKJZmfcb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gHeh1jlB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AKJZmfcb"
Date: Fri, 11 Jul 2025 14:06:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752235561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvc+RvZAMi5L4w+1ft+c4pN/XBlm8iNMT/0QmnTIUFE=;
	b=gHeh1jlBff4kNzcrsOcqJqZ3SiBpyWAcDrvMZsk+jj+yeWIBYmehvGrYcgyDzISIyN3Ufd
	IR5ifz0JlwrGj7xUcMc3EMxo3km7ZT9taFr+/Sv7AnM+/5E+0xgF0G4KZ9N942vAhq38ZY
	xlwplTL8oVnw87angdq8SIIQ/emP8kz1PgGYHs1g9A5avxBQv4eLOrtlE59q3Kib8PRBfg
	zlnY2+6lZLL8WxaMMnF4TJ13kisdOUsgk2F+vkPt6l3zDXH8nS36c5JTb+Czol3vV656lg
	DKAkZbOLpoHuggs/xb7/IsqODKzHSinXTW7D4bhp6atAFt2hwlszmeMTjiOIQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752235561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=kvc+RvZAMi5L4w+1ft+c4pN/XBlm8iNMT/0QmnTIUFE=;
	b=AKJZmfcb8nY1cV+rE1kKcc0kFq1uy6tI7obvkMLjs0eBDnvOJWbGTCiBFBLB7vi7mPpw2O
	6J9f4yHeAWjBTZBA==
From: Nam Cao <namcao@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	John Ogness <john.ogness@linutronix.de>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org,
	Josh Poimboeuf <jpoimboe@kernel.org>,
	Petr Mladek <pmladek@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Fix up build issues with vpanic
Message-ID: <20250711120600.fIZo17WG@linutronix.de>
References: <cover.1752232374.git.namcao@linutronix.de>
 <20250711112844.GG1099709@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250711112844.GG1099709@noisy.programming.kicks-ass.net>

On Fri, Jul 11, 2025 at 01:28:44PM +0200, Peter Zijlstra wrote:
> On Fri, Jul 11, 2025 at 01:20:41PM +0200, Nam Cao wrote:
> > Hi,
> > 
> > The newly introduced vpanic() has some build issues. This series fix them
> > up.
> > 
> > As the vpanic() is only in ftrace tree for now, it is probably best to let
> > this series goes to ftrace tree, if everyone is okay with that.
> 
> Does it make sense to make panic a static inline?

I think no, code size increases by a few K:

text      data     bss     dec       hex      filename
12222627  6097658  479669  18799954  11edd52  vmlinux.before
12226703  6098618  479669  18804990  11ef0fe  vmlinux.after

(it's riscv64, I had issue converting on x86 because there's another
definition of panic())

Maybe faster? But panic() doesn't need to be fast, it's not called in
normal circumstances anyway.

Best regards,
Nam
