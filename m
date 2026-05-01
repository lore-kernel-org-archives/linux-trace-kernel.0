Received: from relay.hostedemail.com (smtprelay0012.hostedemail.com [216.40.44.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18566286419;
	Fri,  1 May 2026 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777656413; cv=none; b=uriahGFm4hPhqQEm5uYdSD78y+oUyTBbw6ZT94zzoO9vTRQ7YE4G6Rn6zhRNe+wIlAE3+yTjW+aTST+BTqep3wOOJGTAExAjL21jOoNSf9/X9QQRK23/ouz8d3uCDGi64EORSxZpfIbRF4qJ65Jy/fyOeAdaSyg59Yfx/7y1U2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777656413; c=relaxed/simple;
	bh=0pGfY6uHDNaOfVrKt407BsbuYI56+rTAMHNNxtSGDKw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ot3FieGybYIZwaQt9L9ttNutWRnlyZA5VvKpmbnVxGpjBB7+4HUkFBdswPC+b/IoEx3Gps9f0BV/u9hUt5TYDzkk2YrY/DL539lBQhLYMX4/FgvuRcaoeFwVpFGnFl4VhQkIIJD9mwPhwXjZPTHP6MCO7ysQVrWtkiHhseEYtVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf13.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id AE5521A00E9;
	Fri,  1 May 2026 17:26:44 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf13.hostedemail.com (Postfix) with ESMTPA id F03242000E;
	Fri,  1 May 2026 17:26:42 +0000 (UTC)
Date: Fri, 1 May 2026 13:26:44 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tom Zanussi <zanussi@kernel.org>
Cc: Pengpeng Hou <pengpeng@iscas.ac.cn>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tracing: Bound synthetic-field strings with seq_buf
Message-ID: <20260501132644.6d8424fa@gandalf.local.home>
In-Reply-To: <097ea2386bfea803f7c33d915f6990b6338e7821.camel@kernel.org>
References: <20260430043350.57928-1-pengpeng@iscas.ac.cn>
	<097ea2386bfea803f7c33d915f6990b6338e7821.camel@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: F03242000E
X-Rspamd-Server: rspamout06
X-Stat-Signature: fq65oszeyxyudqixz6n19icaa97bcayu
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1+SDDe8rp0fzejQDAFduorGtuq+F5FXZ+E=
X-HE-Tag: 1777656402-357005
X-HE-Meta: U2FsdGVkX1+xNK+dtyanGWUnuPiO7IQ2/C2YNQntF98RjvXpyXXR9/LSQcc6Sgv3Cm/wjB7rBcAn7LO7ap3EfSBNkj+a1p954apu8vp2zC9ezikln9WaDi9vQq7J9q33LRiiop3IEKYQLM4T9lj5jQsXfdopZ+2xHPwfteZgdag2nXu5zQHR3qkcdwh77W2HJMhYfphYA0ygJ5mojpqIbCvlEyZjjsUKpWsBmF6aWhwt+8b73YwtFhkPDdhvXrUvzQoldpOM60bBR1WUu4oTVKlASlPZhRzjAVquPS0tzvKw9Vg5UGVhUOUBP9WeDwo7p60smPBP+Pz4Ijxkpcw3dBlXq7mI5MMJ

On Fri, 01 May 2026 12:10:39 -0500
Tom Zanussi <zanussi@kernel.org> wrote:

> > +	/* Terminate synthetic_name with a NUL. */
> > +	seq_buf_str(&s);
> > +  
> 
> This doesn't hurt, but is it really needed? I think seq_buf_printf()
> already null-terminates.

Technically it does, but it's not guaranteed to do so. That is, only
seq_buf_str() defines terminating the string in the API.

-- Steve
