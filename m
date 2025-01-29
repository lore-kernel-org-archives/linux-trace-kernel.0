Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B37343166;
	Wed, 29 Jan 2025 00:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738109867; cv=none; b=exjFChbRxrLgifCJ0Bf/QsR1UOBnAM6GLHSVeKhPTBd8sLy3WJPBmzCG/mXetoYh2X+IcbKpOVA/QD6Tzgk48OJHcsK6uALGp37/01yghUd03v3P8+UMD9lP47hv1tWvAOd4MrGkpifB1o5Xurwr0Etj5AKhYsJrb/qQJVDrd8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738109867; c=relaxed/simple;
	bh=dtkq18ew0t3tsU3vlUB55imQTJ3VwahDXYwzbAnghN4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=VqXLnQetCAIqNl1BIcnUp1GoA4F1GLnBSe/XU2hvhx57wujrbk+EDnxI9t5rvxRXC9GgOY6YFAiOXbhVRZpmkR0Rrw4a9bto9Gbhsrr4SIGwyjCVkW34jYd+eIJ7QLf1DPWUcTrN3IaP5CAZyvjC339/igHiePz4Sh/gYFomdto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kgKf/1j6; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kgKf/1j6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28A17C4CED3;
	Wed, 29 Jan 2025 00:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738109866;
	bh=dtkq18ew0t3tsU3vlUB55imQTJ3VwahDXYwzbAnghN4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kgKf/1j6vrJIIh0goZRfsbMF9a5k+lXlpsmIiHmpeo/GMH+VNJndflII+hfucy7k4
	 +2mHu2y18ui/WAxyUB+QozzPnI4xvnNgmYp6SWvy9isLV34fjHRvbvzE4LK1clsUfB
	 GQhl/lgA5UmFNZCV+R4ov7zs2X+Hp3OfBE75ODheCyFN1spiAyedG/potSAJJ1Llt3
	 8mKjKw3RW18s8wPBMBQZ3MYDFkjGgglwgcUO8WsFYZ+G/g3dDz34V3YNSLF2IWA+Qg
	 i+UzqoRIWHu+8zrZKLGBQv0W91YiWH6VJdBaxxpuMXQcqjOY1rpryLqBjdojE4e0Sg
	 XR7SCkAkktrFw==
Date: Wed, 29 Jan 2025 09:17:41 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Masami Hiramatsu (Google)" <mhiramat@kernel.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Petr Pavlu <petr.pavlu@suse.com>, Sami Tolvanen
 <samitolvanen@google.com>, Daniel Gomez <da.gomez@samsung.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-modules@vger.kernel.org
Subject: Re: [RFC PATCH 0/3] tracing: Introduce relative stacktrace
Message-Id: <20250129091741.15f0b3238b67d7f55696de12@kernel.org>
In-Reply-To: <20250128112733.37d7c771@gandalf.local.home>
References: <173807861687.1525539.15082309716909038251.stgit@mhiramat.roam.corp.google.com>
	<a7a171c4-7feb-4f26-a832-18d38a3ee973@efficios.com>
	<20250128112733.37d7c771@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 28 Jan 2025 11:27:33 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Tue, 28 Jan 2025 10:46:21 -0500
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
> > This does not handle the situation where a module is already loaded
> > before tracing starts. In LTTng we have a statedump facility for this,
> > where we can iterate on all modules at trace start and dump the relevant
> > information.
> > 
> > You may want to consider a similar approach for other tracers.
> 
> Last night Masami and I were talking about this. The idea I was thinking of
> was to simply have a module load notifier that would add modules to an
> array. It would only keep track of loaded modules, and when the trace hit,
> if the address was outside of core text, it would search the array for the
> module, and use that. When a module is removed, it would also be removed
> from the array. We currently do not support tracing module removal (if the
> module is traced, the buffers are cleared when the module is removed).

Actually, we already have similar info in /proc/modules. Of course it is
not persistent.

> If it is a module address, set the MSB, and for 32 bit machines use the
> next 7 bits as an index into the module array, and for 64 bit machines, use
> the next 10 bits as an index.

I thought 7 bits were not enough because some stacktrace were kept after
the module was unloaded. Of course we can ignore such case (anyway current
"live" stacktrace does not care such case too).


> This would be exposed in the format file for
> the kernel_stack_rel event, so if these numbers change, user space can cope
> with it. In fact, it would need to use the format file to distinguish the
> 32 bit and 64 bit values.

Yeah, that can simplify the userspace. But the problem of using relative
address from the module .text is that it has bigger overhead to find the
module for each stacktrace entry.

Thank you,

> 
> That is, a stack trace will contain addresses that are core kernel simply
> subtracted from ".text", and the modules address would have the MSB set,
> the next bits would be an index into that array that holds the module
> information, and the address would be the address minus the module address
> where it was loaded.
> 
> This way we do not need to save the information from any events. Also, for
> the persistent ring buffer, this array could live in that memory, so that
> it will be available on the next boot.
> 
> -- Steve
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
