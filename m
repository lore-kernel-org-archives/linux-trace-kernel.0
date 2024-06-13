Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9458A130AC8;
	Thu, 13 Jun 2024 18:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718304173; cv=none; b=H6DGQErRnwjcFMgTB0PWvbPef2Nn8f3dv5+XIDEKg/hVJXfEDc8yDv9elfZFK8u/bsfJolD1itGKKDgrIG6Gdnx86gnW1fYeD4IT+dNTBbz/qydMXPrTTpmtQL6Ag8Paek865xNloWCAAdfiKv5K/RB7F36UX9+SMlhWfLUyFdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718304173; c=relaxed/simple;
	bh=B9X+plNiBVhQ/1yH74OFHxsxyAUQZhS7oAwqTbB7euM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pzFUxJI2B3PNTMnQxJ2A1cbd+GA9LfSUuVyLVHr9f8Qn7bmqIDyzyHc5mMzbtyvd3wT/e9xftlW94XMewMexrMNsOHOwf6KMDumBEZqvNDuwlgos7KPBiCBObLQ/LeqCen4XVgkOWhOtbf58CUJMI37yff1I+kmSI4tprzoZQZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE21C2BBFC;
	Thu, 13 Jun 2024 18:42:50 +0000 (UTC)
Date: Thu, 13 Jun 2024 14:42:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: Mike Rapoport <rppt@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, Mark
 Rutland <mark.rutland@arm.com>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Vincent Donnefort <vdonnefort@google.com>,
 Joel Fernandes <joel@joelfernandes.org>, Daniel Bristot de Oliveira
 <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, suleiman@google.com, Thomas Gleixner
 <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>, Youssef
 Esmat <youssefesmat@google.com>, Beau Belgrave <beaub@linux.microsoft.com>,
 Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David
 Howells <dhowells@redhat.com>
Subject: Re: [PATCH v6 2/2] pstore/ramoops: Add ramoops.mem_name= command
 line option
Message-ID: <20240613144248.2251b189@rorschach.local.home>
In-Reply-To: <6a6bd674-48ca-f7fc-d572-51e52e6899d9@igalia.com>
References: <20240613155506.811013916@goodmis.org>
	<20240613155527.591647061@goodmis.org>
	<6a6bd674-48ca-f7fc-d572-51e52e6899d9@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 15:19:50 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> > +
> > +	reserver_mem=2M:4096:oops  ramoops.mem_name=oops
> > +  
> 
> Likely this could be fixed on merge, to avoid another version, but...
> 
> s/reserver_mem/reserve_mem

That 'r' is my nemesis! Almost every time I type "reserve" I write it
as "reserver" and have to go back and delete it. :-p

Just to make patchwork work nicely, I'll send a v7. But I'll wait for
other comments or acks and reviews.

-- Steve
