Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 724C41A073F
	for <linux-trace-kernel@vger.kernel.org>; Tue, 25 Mar 2025 12:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742904910; cv=none; b=MUKYYm6JvXrfEj4KMzzOq5WZU8J9ujeLBqTJbtFtMc5b5uBXkfEBsb4zp/qYD3C8LS3bEvg8aPPLaAbg7k8/wvEnqUC3P+ahDVlqooWYPTHuEYEt58axrRW3WYsEE6Jxvvbz7nbCAQJ80ueQt3MC6IF4N09rfr8enNGPZ+hMEsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742904910; c=relaxed/simple;
	bh=kWwfob6CuPnxTeNMMAgznJAZgIwxNwBV9o3bb4OWbok=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rJNg5KIYJ+Q6L/dWjugFMullCvRgGN9wNqAfnSo/aRO30km4V34pYo5nCdt9gZHUrFvKtfy0p6ntz2itWDiwRhEpEE3u5/bEO3G6+mGLdiqtzghGGd1k2AIHxBjbIBI1Hzj/Nd5IpjqJZOR1Wch8BURRgrGJNcYZryL5mb9tY3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57D3BC4CEE4;
	Tue, 25 Mar 2025 12:15:08 +0000 (UTC)
Date: Tue, 25 Mar 2025 08:15:51 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Greg KH <gregkh@linuxfoundation.org>, Sahil Gupta <s.gupta@arista.com>
Cc: linux-trace-kernel@vger.kernel.org, Kevin Mitchell
 <kevmitch@arista.com>, Dmitry Safonov <dima@arista.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
Message-ID: <20250325081551.270947fe@gandalf.local.home>
In-Reply-To: <2025032548-happily-saxophone-4079@gregkh>
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
	<20250324133619.6c3babf7@gandalf.local.home>
	<CABEuK15jWHSU8LaRXc1EzvhiLdBHeM9E+sKs7VyP47RRSxG6cg@mail.gmail.com>
	<2025032424-custard-volley-bbb6@gregkh>
	<20250324150703.69665622@gandalf.local.home>
	<2025032548-happily-saxophone-4079@gregkh>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Mar 2025 07:58:36 -0400
Greg KH <gregkh@linuxfoundation.org> wrote:

> It's up to the maintainer of the subsytem as to what they wish to see
> happen.  I will always defer to them as they are the ones that have to
> deal with emails from users :)

Thanks Greg for the reply.

Now bringing the question to Sahil.

This looks to be broken in 5.17 (when the mcount sorting was added). And
you are now using 6.12. How important is it for you to build 64 bit kernels
on 32 bit machines?

Nobody noticed this for a long time. One solution may be to simply disable
mcount sorting at build time when it is detected that the host is 32 bit
and the target is 64 bit. I don't know how easy it is to detect that at
build time, as it needs to unset a kernel CONFIG option. Perhaps Kconfig
can detect that?

-- Steve
