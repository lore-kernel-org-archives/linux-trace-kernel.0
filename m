Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1A632641E9
	for <linux-trace-kernel@vger.kernel.org>; Mon, 24 Mar 2025 17:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742837738; cv=none; b=nugBlbLquSiBDiJ2P4/PrOHK+KK5A3Uhgr1JNnTcRxxUZX4xVABckkvwW6hxBPqRTrdWPkRora0++ziBcsp6dUHnBUu0Azq+vEqHN7fkOhA73NaWrNjGXUapLBlOEZfor8FXxkxqhzVgyKgcA0/ovBtiaQuXYTqrET6fxqZfPQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742837738; c=relaxed/simple;
	bh=RpBLtOXKiH1p5B3iug5omfQIiNraZHTtcByyp1or7Zk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F629DwB++stBXhjEuikdIj3oyIPUu5qgc9kxIHrtAfplMKi64GvKEdQ7P1IxnbGNdIU12td56zjXkXjth+ypBNa1t2d6PQ5YbVqU82hfA5FVXANhG7X9HWNjTG3TKuCZjxLX9jW49Tp/2KOgOjg/YJya7I8bM/lip+BhU8EZaXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9588C4CEDD;
	Mon, 24 Mar 2025 17:35:37 +0000 (UTC)
Date: Mon, 24 Mar 2025 13:36:19 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Sahil Gupta <s.gupta@arista.com>
Cc: linux-trace-kernel@vger.kernel.org, Kevin Mitchell
 <kevmitch@arista.com>, Dmitry Safonov <dima@arista.com>
Subject: Re: ftrace: sorttable unable to sort ELF64 on 32-bit host
Message-ID: <20250324133619.6c3babf7@gandalf.local.home>
In-Reply-To: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
References: <CABEuK15=+Bo7xkBn5ufytVowt0j3fVEsdGVsryn1zH8KxfoCyQ@mail.gmail.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 20 Mar 2025 16:54:58 -0500
Sahil Gupta <s.gupta@arista.com> wrote:

> Hi Steven,
> 
> On 6.12.0, sorttable is unable to sort 64-bit ELFs on 32-bit hosts because
> of the parsing of the start_mcount_loc and stop_mcount_loc values in
> get_mcount_loc():
> 
>   *_start = strtoul(start_buff, NULL, 16);
> 
> and
> 
>  *_stop = strtoul(stop_buff, NULL, 16);
> 
> This code makes the (often correct) assumption that the host and the target
> have the same architecture, however it runs into issues when compiling for
> a 64-bit target on a 32-bit host, as unsigned long is shorter than the
> pointer width. As a result, I've noticed that both start and stop max out
> at 2^32 - 1.

So this has been broken for some time?

> 
> It seems that commit 4acda8ed fixes this issue inadvertently by directly
> extracting them from the ELF using the correct width. I'm wondering if it
> is possible to backport this as well as the other sorttable refactors to
> 6.12.0 since they fix this issue.

You should ask Greg KH on this.

-- Steve

