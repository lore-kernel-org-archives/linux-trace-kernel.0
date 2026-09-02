Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993D44A5EB4;
	Wed,  2 Sep 2026 14:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788360942; cv=none; b=bhyN9Fyb3pSfoXzsCU9IAVbEQ5qu6Vak4mvfV/23yPBI3v/x3XIRBbBLZsxvEsZOlwpVJzegIizJSb7EIp1mfw3lCPNAfEmYs0IND9DjQSEwzPwD7t2hG3odNxR41XQA5FyrcXSwgAJWPxtItFoWHHHdNytP9PrO4psZ0L4hJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788360942; c=relaxed/simple;
	bh=OgD0qGPB5f+MJB13UFV92iCXE2XY2AgqTqZKVf2ib7U=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=pgE4xVNDGjk0b2fzYcLO0i+ecKVZoqBs8sc5nXgICVT2YnM0ESp9sFOiu5IV83K/dZuIuheGDEHsCboNAZ0pdyITXnuleBb/c1JmUB5OXV/Iq5qkqgRnk/A8LaJRn1Wt5DQ81vTDExYJp8lnoclz0fzj+jeCc1u68AS9jXu+syg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=elfU7kO/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="elfU7kO/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 100221F000E9;
	Wed,  2 Sep 2026 14:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788360938;
	bh=4VkIc8pjkpY1oFoTfyYo3gvdAh5Yf+vjfAn89/ZsDGM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=elfU7kO/7Y0JO3xq65MZpi2xurdnDenwPNo1FjzKUbil7EKy1r1A4a5IdW27RfdXF
	 6tz8XM85yXqGcn/0N5TR2eCZvNMi5A/k5YdEvfJQoqt7l6FDJZZyOVbGE+NQbWKwfB
	 4DVVoZ/N+IEril7xQY3nWFHTNTJjZHkfEWCEuCJQ2Rl+Diad5twnqhjtG5oHm46QG5
	 G26MfD/XoymgRsOBZOyF282TJYNSkR4aOUDXiexPp9+0Wg6TcWnujaZXCAm8bu9Y4b
	 kRgaHn4UEOG7dEkT/MOJBtIEoBTKqZj+Z37x1BmnhrQG/5ZUS7zxDETlqiYiyh6Ad8
	 egdRe/a23z+Lw==
Date: Wed, 2 Sep 2026 23:55:33 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Peng Donglin <dolinux.peng@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, mhiramat@kernel.org,
 dolinux.peng@gmai.com, linux-trace-kernel@vger.kernel.org,
 linux-kernel@vger.kernel.org, pengdonglin <pengdonglin@xiaomi.com>
Subject: Re: [PATCH v5 0/3] Use BTF to trim return values
Message-Id: <20260902235533.ea387f764b51b1b2a8ce8224@kernel.org>
In-Reply-To: <f18beeb4-f3df-41eb-9990-5be295a2729b@gmail.com>
References: <20260901134604.4052265-1-dolinux.peng@gmail.com>
	<20260901135715.4812fde9@gandalf.local.home>
	<f18beeb4-f3df-41eb-9990-5be295a2729b@gmail.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 2 Sep 2026 11:25:29 +0800
Peng Donglin <dolinux.peng@gmail.com> wrote:

> >>    - Do not print a return value for functions with a void return type.
> >>    - Trim integer, enum, struct, and union values to the available return
> >>      value width when the BTF type provides suitable size information.
> >>    - Format integer, enum, and boolean values according to their BTF
> >>      encoding.
> >>    - Mark values as "(trunc)" when the return type is wider than the
> >>      value captured by the function graph tracer.
> > 
> > Hmm, I really don't like the "(trunc)" If it's the real return type, then
> > it should just print what the real size is. No need to state it was truncated.
> 
> Thanks, I agree. We can remove the "(trunc)" suffix and print the actual 
> type information instead, for example:
> 
>      ret=0x5[struct:0x10]
> 
> This would indicate that the return type is a struct with a size of 0x10 
> bytes.

Hmm, shouldn't both the actually applied size and the true size be displayed?
e.g.

ret=0x5 (in 8 bytes, true size: 16 bytes)

Thank you,

> 
> Would this be acceptable?
> 
> > 

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
