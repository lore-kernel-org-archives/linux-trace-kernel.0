Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E025F22FF22;
	Fri, 28 Nov 2025 17:19:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764350367; cv=none; b=F3uR1oRYhvtWaWpK6ZhVGzqm2gVMDBzA+dfD2nWQyy6l+50TID0+AonWSZAQrcq5npVhuzbINKTI0yLLZt0pFNxnsyhea+J6pgtR1ZT0DgOQN46Eyl7EvfmbVkPfTifmPOpNCjeyIF8UWpG+eG1NyEXnTjS0jtEiFb8OLz0ep7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764350367; c=relaxed/simple;
	bh=K2E1U3epY0iQxOIKwuNQPGRgZrhTX5b8hjszIeNOJxk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ujFcAv5oHI88ZPFM86gPBofJTY9Gz7G8l2A5Q4yWa8LUxIlXiaZ/8pvgsTSJfEyuH/xH28XYIeC5njLpBEMdBlDAltRApzQht1fBMsMyBcvA3s4ycifcPVh2AuZUjlNdlfhudlu2cwLUZYSLr7SyEY7bivUazte8zV5hg63B2I8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 533055A20D;
	Fri, 28 Nov 2025 17:19:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id 3F48D20026;
	Fri, 28 Nov 2025 17:19:21 +0000 (UTC)
Date: Fri, 28 Nov 2025 12:19:19 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <kees@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
 linux-hardening@vger.kernel.org, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: Re: [PATCH] overflow: Introduce struct_offset() to get offset of
 member
Message-ID: <20251128121919.521ec9bf@robin>
In-Reply-To: <CAHk-=wiF9-vf3zW8vXoFGk+bo0=dSoJMm_nmVzsTDCerZzhGaw@mail.gmail.com>
References: <20251126145249.05b1770a@gandalf.local.home>
	<202511262356.6FE5084CB0@keescook>
	<20251127204342.05fc985e@robin>
	<6219BF5A-0EC3-4111-A329-D35244C9714A@kernel.org>
	<20251127222710.324357cf@robin>
	<CAHk-=wiF9-vf3zW8vXoFGk+bo0=dSoJMm_nmVzsTDCerZzhGaw@mail.gmail.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: zr11k9aw3mznh5purmm9fcfxsooxro5g
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: 3F48D20026
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18tjifUlLmG56VnQe7OD5sNSWWDhKiQIQc=
X-HE-Tag: 1764350361-388986
X-HE-Meta: U2FsdGVkX19/MRDt2aaRwVbFj3c/tHqEG/UidBr5SeT/sX726m9pde2gZ1c+57IxFnDKYbsqfDsFM9NO0tvwevygsqtRRVgsoffB1dcYvs0r2qAtGjMIB8xyhIUEvvGtCyN7aY44oQO10r6GyS6cuPxjxCpX9Ov/2+mi0IL1eFzQIxQKoNlMRmn2UJRBwVMfCpZ8JiVFb+cQ/81RFcHq6MCLwLf/mvzcP28ydKfETU29Gcn/GCUjlpZadEaWozqOC/LiV2DfhRDzxyeZsA8eWQxgd3QjMQQttaZAKGKP5d1olsGpfJfNklK2jNVuIK7YzZH2shyCEeNmzcXI1WwbhH5HZxEdZ51CUkeCR1quOr97FOu4D2YQ0d7iJ0GYlj8G

On Thu, 27 Nov 2025 21:35:35 -0800
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> So that 'xyz_t()' version then gets used for things where you
> explicitly state the type, and it all looks fairly obvious, eg:
> 
>         len = struct_size_t(struct pid, numbers, level + 1);
> 
> doesn't get that "WHAA?!??!" kind of reaction.
> 
> [ And so I actually think it's good that it only takes an explicit
> type - if you really have an instance, I think it's better to use just
> "struct_size(&instance, ...)" even if we _could_ easily make syntax
> like "struct_size_t(instance, ...)" work. ]

I was thinking about adding a struct_offset_t() but then I noticed that
struct_size_t() requires adding the type as it is for just getting the
size of the struct without using a variable. Whereas, I would have
preferred the struct_offset_t() to use a variable that's not a pointer
where typeof() is used.

But for my use cases, I can just add a '&' to struct_offset(), as if
struct_offset_t() were to take a type, it is no different than
offsetof().

-- Steve


