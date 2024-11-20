Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EAFEA939;
	Wed, 20 Nov 2024 15:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732116676; cv=none; b=VrslXH3z7rKIQGxaPm/rJnsNas1JVY5JGE9ZYdZSIKnC5deSt+SwcQkP9MoxaAdc69SLajCfdqPGWuMe6Nt3T9miuZHV6+mHr4oVA2sf9STLf/BltYLgHaAk1uPhD0Cy1fADtQ1LAJ1fFTkDFOmW8s7SbwxBtYShrIyc5Ii+SJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732116676; c=relaxed/simple;
	bh=LAIUGaDGpx0bD1QEhD+EB3pleLk83mjLnaRqurNbXSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UGWFfA5zM/OrREzUk7XkRDZiH+jGx/mwvcHU2mM6ex0n8MyTCofBJ4KZETMX2J0h5vBPaa6GEthtNtqz3btaOWmFsWgMdUN8xhcHT/jH5FUgFXwfMPSoJi7bNXh9boViarthl8HRZqg8kNSxnQ+GpXrrGX2AlWl9Jml7rq821uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10BB4C4CECD;
	Wed, 20 Nov 2024 15:31:14 +0000 (UTC)
Date: Wed, 20 Nov 2024 10:31:50 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org>
Cc: linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Geert Uytterhoeven
 <geert@linux-m68k.org>, Greg Ungerer <gerg@linux-m68k.org>, Tomas Glozar
 <tglozar@redhat.com>
Subject: Re: [PATCH RFC 0/2] Add basic tracing support for m68k
Message-ID: <20241120103150.3442d658@gandalf.local.home>
In-Reply-To: <66e2b7cd-4a4f-4f60-9846-a14c476bd050@yoseli.org>
References: <20241021-add-m68k-tracing-support-v1-0-0883d704525b@yoseli.org>
	<3a8f6faa-62c6-4d32-b544-3fb7c00730d7@yoseli.org>
	<20241115102554.29232d34@gandalf.local.home>
	<cbb67ee2-8b37-4a4d-b542-f89ddae90e94@yoseli.org>
	<20241115145502.631c9a2c@gandalf.local.home>
	<2c43288a-517d-4220-ad31-f84dda8c1805@yoseli.org>
	<20241118152057.13042840@gandalf.local.home>
	<22856ed6-b9d0-4206-b88d-4226534c8675@yoseli.org>
	<20241119102631.76363f2a@gandalf.local.home>
	<20241119112850.219834f5@gandalf.local.home>
	<e4456cb1-b1bc-453b-b3b5-3ee4f03995be@yoseli.org>
	<20241119131035.3c42a533@gandalf.local.home>
	<66e2b7cd-4a4f-4f60-9846-a14c476bd050@yoseli.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Nov 2024 12:47:19 +0100
Jean-Michel Hautbois <jeanmichel.hautbois@yoseli.org> wrote:

> Long story short: it fails at kbuffer_load_subbuffer() call in
> read_cpu_pages().
> 
> I added printf in the kbuffer helpers in libevent, and it finishes at:
> __read_long_4: call read_4 at 0x600230c2
> __read_4_sw: ptr=0x8044e2ac
> 
> static unsigned int __read_4_sw(void *ptr)
> {
> 	printf("%s: ptr=%p, value: %08x\n", __func__, ptr, *(unsigned int *)ptr);
> 	unsigned int data = *(unsigned int *)ptr;
> 	printf("%s: data=%08x\n", __func__, data);
> 
> 	return swap_4(data);
> }
> 
> As soon as ptr is dereferenced, the segfault appears.
> ptr should be ok though, as the address is valid afaik...

But you don't know what ptr it failed on, right?

If dereferencing a pointer will crash, the below line:

 	printf("%s: ptr=%p, value: %08x\n", __func__, ptr, *(unsigned int *)ptr);

Will crash before printing, because you are dereferencing ptr. Perhaps you
should change this to:

 	printf("%s: ptr=%p\n" value: %08x\n", __func__, ptr);
	printf("    value: %08x\n", *(unsigned int *)ptr);

And that way you will see what 'ptr' is before the crash. Or did you do
that already?

-- Steve


> 
> I must say that now I am stuck :-(.

