Received: from relay.hostedemail.com (smtprelay0014.hostedemail.com [216.40.44.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D269735D60B;
	Tue, 27 Jan 2026 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527671; cv=none; b=FHHbiSC0qKsZGgYGkqhKB9lj0VySt53oIyajCZ45ZFcdbeEJr2fm1tXiPBdB7Nx0vEQPVvU27p16sTI8mPIjKXfhDaPUqk3JJj7ypQOG45XrN4ywLzPileYGsEJibsii+bdRgtNr5jF9HD3OB4d0xML2vK8a5NVYfwC7dfcqDbQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527671; c=relaxed/simple;
	bh=Dj14eSLFEAqtkPYJPBfeRPH3HVklFyctdqJlRkXnykg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EKKqxSUKgX1Smecfm1C1IjXW+cTR2akbATjiufZHyZmsnj5jhtX45lD4BsjB5Rek4ugm9OB4W+XbMvaZhqO3EZvQRC9T30ZKysiuKk6rkcR760rLdKiP35XXI6cxey12zq9nYQjigKzBIv7TS5K4JzoQrbE/2y8nuzoyvuddofE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf06.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay03.hostedemail.com (Postfix) with ESMTP id 3CCEDB6976;
	Tue, 27 Jan 2026 15:27:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf06.hostedemail.com (Postfix) with ESMTPA id ED7982000F;
	Tue, 27 Jan 2026 15:27:45 +0000 (UTC)
Date: Tue, 27 Jan 2026 10:27:51 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Alice Ryhl <aliceryhl@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Josh Poimboeuf <jpoimboe@kernel.org>, Jason Baron <jbaron@akamai.com>, Ard
 Biesheuvel <ardb@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2] MAINTAINERS: add Rust files to STATIC BRANCH/CALL
 and TRACING
Message-ID: <20260127102751.2adddb78@gandalf.local.home>
In-Reply-To: <20260127083543.GU171111@noisy.programming.kicks-ass.net>
References: <20260127-jump-label-rust-maintainers-v2-1-11b7c30b11d9@google.com>
	<20260127083543.GU171111@noisy.programming.kicks-ass.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: ED7982000F
X-Stat-Signature: dtr5wem6ywbgb6oq37pwdqhok84xnjok
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+5UmyLrVsY/t2e5fVfgyXkeZRgoSPiXEw=
X-HE-Tag: 1769527665-839052
X-HE-Meta: U2FsdGVkX1+EE09NCzMO+wrlpauhC+lUweIqlUdF4nuMH9yW4/bO6cLH8dDd/Cj3GXm1n7ce7/yNyeKFKixW9PiRpcKO5WRD1xXcGnnE28lfLa8hFt9S2J58p11KPWHdS3QBbMTqmI3J+6o0nqJmZU4FlHpkdS9cnuB5g2nN/8Eewq4D/ZG/IRI0hprlYaBr+zJSaiMmbuKf1Sot9fwRHbiZviWgSG4lx/wrls/Ihdak5/8m9EX/Xv6gneA3vIvMe5Ju1E/4xvnUvyXbFpuapmYZC6FjxOuwNeU8eIoIRpTMKaih6PuhVb10D2xM7JdmkbKNwH6pcx6YwiYaoaWoNqCP7+Gpf4d/EnYhMdxuAkfPbhfwalc4S3TESwfXbHy4JANzbMnmqT4JUqLmK2UEoA==

On Tue, 27 Jan 2026 09:35:43 +0100
Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, Jan 27, 2026 at 08:30:01AM +0000, Alice Ryhl wrote:
> > I realized that these files were never listed in MAINTAINERS when they
> > were added in commit ad37bcd965fd ("rust: add tracepoint support").
> > 
> > Signed-off-by: Alice Ryhl <aliceryhl@google.com>  
> 
> Works for me; Steve were you taking this or should I?
> 
> In case Steve wants to route this:
> 
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

I can add it to my tree.

Thanks!

-- Steve
