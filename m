Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 887DB1CAB3;
	Mon,  8 Sep 2025 23:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757375593; cv=none; b=kWT2xfkV15IGrH4ppsMwoPPHOO1N0nf3q7msCezRVzTKUdy1xl9TOMBpx96eXeUXCouQaQnK6eq8vWl5/DjYg8/+wDeu7lgYgTz3Urk0WNlp6u1gPMkWlUCfSzSVStBxer4QOqhTMXMi4d8QqmO45MeEWfyi3iRWwTq0BTDgVRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757375593; c=relaxed/simple;
	bh=Z6lCT2gqD0jDDMHc3VKxAWbTg7jDCGmhF/8kLGUdgEg=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=c5DOdCA8So/mBBK28Gd/XbVil0tE96lZ/Kur3E2IaBa32/BD5pzp1Z1ASZUb2Cs9OhFRLA8PiN1W7zsanrrdA7OrgYtVT39Yz+EqIfI0mfLzOJKBC+5Q+/vIBeCtTwbIZwFMkLiVvChTim0yrBLCGYej+EVayPVASnHY6zn/+U8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kFfn3VkA; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kFfn3VkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C548BC4CEF1;
	Mon,  8 Sep 2025 23:53:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757375592;
	bh=Z6lCT2gqD0jDDMHc3VKxAWbTg7jDCGmhF/8kLGUdgEg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=kFfn3VkAtZ91wza+2pr3+Ooq8uZPREvsKfiUCs3sRRFBJ83E7VygIcMPT/Abw6pml
	 dKNykhAfyfY7Jg09n4//XUfxm8oqoT31BdfElbSmTbO5Kd2Yrv/V2rjFq7FGebez+s
	 RmVfz8B3dFkbpQkFRHZicqpqCopiCLfSxZVRHMKyLxfT8br3xHUqzUMsdO0SjuLHTj
	 1agnNR3qk5+/qk9rp7lY8eXPVBTem+f4H3/ROd+Dt0bFch6glBsbRSVc2OEvvGCWIT
	 7V3xHde/XFe0OtuzwiA4aQTPtXhUXSXQkn0M6g1WSlllNixOMdytvUL6PJaK7FfnF+
	 M1PAc4FeQESyw==
Date: Tue, 9 Sep 2025 08:53:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: Replace strcpy() with memcpy() in
 __trace_probe_log_err()
Message-Id: <20250909085308.15a7f4379b5d324051bbd383@kernel.org>
In-Reply-To: <635528D7-9B5F-4B7C-9568-87375BA866C3@linux.dev>
References: <20250820214717.778243-3-thorsten.blum@linux.dev>
	<20250825160540.9a5272a8a93a789eb36a7098@kernel.org>
	<635528D7-9B5F-4B7C-9568-87375BA866C3@linux.dev>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 8 Sep 2025 12:13:23 +0200
Thorsten Blum <thorsten.blum@linux.dev> wrote:

> Hi Masami,
> 
> On 25. Aug 2025, at 09:05, Masami Hiramatsu (Google) wrote:
> > On Wed, 20 Aug 2025 23:47:18 +0200
> > Thorsten Blum <thorsten.blum@linux.dev> wrote:
> > 
> >> strcpy() is deprecated; use memcpy() instead.
> >> 
> >> Link: https://github.com/KSPP/linux/issues/88
> >> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > 
> > OK, looks good to me.
> 
> Did you forget to add a Reviewed-by: tag and/or to add it to your tree?

Thanks for ping me. No problem, I will add my Signed-by when
picking this to probes/for-next.
Since I will be responsible for applying this patch and sending
it to Linus, this includes the "Reviewed-by" as well.

Thank you,

> 
> Thanks,
> Thorsten
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
