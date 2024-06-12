Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64A1A34;
	Wed, 12 Jun 2024 01:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157444; cv=none; b=q1WhhjWxMa5Myrwt1RsaDucarh8GWP2s+yHlPAx0RGc6qy8MKAYJqqFzJvbC0nqETo1sQ5hc6jw6t89Ulakfowvc2UgZqYGj1ngRZV5957+4eqxpxicOIlW9AvODYxLX7zLQskVTVF7M8TRL/zW0ZwYlRrn1rqzbjjk27QAGQQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157444; c=relaxed/simple;
	bh=nqtVS0YOHFw+plikSyA0GPU+Oh9i+6nEHh2WeQDmHrA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kN94/yQONOkHGuUFibfKSclzlxWLXNEuR7ipUnrIZFPg95Z23ffcsxOXnvjQ7H/RYkRRGAh0amMbeQlZPieyDRhCMuDe8hEZVkYZ37YqeCsUF7sGopzD/MfPCUI9N/kbymYToEqOy3Z1Sv7XNsBps698EOUVDXtAVLWpfsDb/mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39D80C2BD10;
	Wed, 12 Jun 2024 01:57:20 +0000 (UTC)
Date: Tue, 11 Jun 2024 21:57:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, suleiman@google.com, Thomas Gleixner
 <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef
 Esmat <youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Howells <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>, Dave Hansen
 <dave.hansen@linux.intel.com>, Tony Luck <tony.luck@intel.com>, Ross
 Zwisler <zwisler@google.com>, Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH v4 01/13] ring-buffer: Allow mapped field to be set
 without mapping
Message-ID: <20240611215718.03eb9fc0@rorschach.local.home>
In-Reply-To: <20240611213937.408770fa@rorschach.local.home>
References: <20240611192828.691638177@goodmis.org>
	<20240611192907.402447387@goodmis.org>
	<5178e22b-0c00-48d2-8a6e-85510706f145@roeck-us.net>
	<20240611185319.58a52a1b@gandalf.local.home>
	<1e74c6d8-ae74-49c2-bdc4-d9880110ab57@roeck-us.net>
	<20240611213937.408770fa@rorschach.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Jun 2024 21:39:37 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > 
> > Maybe explain why sometimes __rb_inc_dec_mapped() is called to
> > increment or decrement ->mapped, and sometimes it id done directly ?
> > I can see that the function also acquires the buffer mutex, which
> > isn't needed at the places where mapped is incremented/decremented
> > directly, but common code would still be nice, and it is odd to see
> > over/underflows handled sometimes but not always.  
> 
> Sure. I'll add comments explaining more.

And I found a bug with this code. It assumes that mapped will be equal
to 1 if it's the last mapping. That will no longer be the case.

-- Steve
