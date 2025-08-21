Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76F92E1F09;
	Thu, 21 Aug 2025 15:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791646; cv=none; b=FcvD4O4QXZ66nRBkzYpec7EkWFDeBslzLdQIbEiNftWsKhwHUn4fugvo3lj7k/z0e5OPcBAzIALxa4I26TcOCv3Lg/zVB9pIeNrCxvmuwDvlWWbyf71MQUWfNE2yKuyHioIiKLAaIwLjjXQdfwoo05ZXsNVWgjYOE6ywWdTpvro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791646; c=relaxed/simple;
	bh=+VbijyK98dQ+nsU3IpUmiOqYN2zb0XP3vzjHCJp8w5E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gnAxGS2oLo6Mvf6wf7vj9RyeBSemdyva3hqvRSwUkxNmPWMUmJEWDVT4fLwFUfpcccuOAyUM1Jw4CumJGDc32RqCiKb+CmtGOTR8K54Fy+/ACw7CQads4qjediq+bqp05NN6uI1hNx6Z1+XkjfU26CYNC1oEVy4xzuIGTyEirlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf08.hostedemail.com (a10.router.float.18 [10.200.18.1])
	by unirelay10.hostedemail.com (Postfix) with ESMTP id B1847C0476;
	Thu, 21 Aug 2025 15:53:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf08.hostedemail.com (Postfix) with ESMTPA id F20D520026;
	Thu, 21 Aug 2025 15:53:54 +0000 (UTC)
Date: Thu, 21 Aug 2025 11:53:59 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Elijah Wright <git@elijahs.space>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: move buffer in trace_seq to end of struct
Message-ID: <20250821115359.3988b807@gandalf.local.home>
In-Reply-To: <20250821114355.6ee546b0@gandalf.local.home>
References: <20250821053917.23301-1-git@elijahs.space>
	<20250821114355.6ee546b0@gandalf.local.home>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: F20D520026
X-Stat-Signature: 155a91e5mjiod7r6aaxbdepgz99mcg5j
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/JD5vCf4f8A+Zgjsi/n7RAnh9dFt/D058=
X-HE-Tag: 1755791634-421658
X-HE-Meta: U2FsdGVkX1+zes+VSyAus5A/l8OOwOMCDbXuM4wdv/+tvvY6U6iyz+0IqK+KkL3Eb4tJFjc4YqRgVKi88pwywTeyi5hFPxIjPQw7UavKq5uiDSjs0UOZyMUPM2Vq4UU9Qc+0b1lZPfvBP4ylxtNLPd8ZEOwSguP9IvX07fmE71NxDWyrnAzQQkfk4JhLmF4sHc6nIthdAogafJQzZgEn1zhGkD1x5Edg9r9bRcALYw6i5STgDde+PX229RsWUuwMMV6Yb0ERbpisdwwDEl7W3tipOPjKP6KROJlNgpnIzxLYAFnzofmFngeZ/y/37b7FU20mJVFkjZ/OoCH6ZE/05eJF3xQ0wTAeuR9yeRVo6mURi+aBdkP64OsgLdrJ0Ca9

On Thu, 21 Aug 2025 11:43:55 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> diff --git a/include/linux/trace_seq.h b/include/linux/trace_seq.h
> index a93ed5ac3226..92364deb39a5 100644
> --- a/include/linux/trace_seq.h
> +++ b/include/linux/trace_seq.h
> @@ -24,14 +24,12 @@ struct trace_seq {
>  	char			buffer[TRACE_SEQ_BUFFER_SIZE];
>  	struct seq_buf		seq;
>  	size_t			readpos;
> -	int			full;
>  };
>  

I should have tried compiling it before posting. But trace.c has this:

		ret = print_trace_line(iter);
		if (ret == TRACE_TYPE_PARTIAL_LINE) {
			iter->seq.full = 0;
			trace_seq_puts(&iter->seq, "[LINE TOO BIG]\n");
		}

I need to figure out a clean way to fix that too :-p

-- Steve
