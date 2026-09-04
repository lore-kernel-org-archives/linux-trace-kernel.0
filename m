Received: from relay.hostedemail.com (smtprelay0017.hostedemail.com [216.40.44.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0F6F51E435;
	Fri,  4 Sep 2026 18:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788546882; cv=none; b=uIDu8UTODjfi8Kz4zvafLMJtOAanuOr19tQIWCgVkQKlrGJTaF5C418YM19QlZUsioUP/v6HjB+gVctHi/SfthRY1MlMRjl2XUIdn7fv+Fz4o/U4kXNcQFHFI7GY0+8rJMYYDyP9tedvl1tdq7gT3TsY2l6gjRIlmyTJ1WmJAK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788546882; c=relaxed/simple;
	bh=5m3wMCU1AJd5q6WrHI3GkFqXq8h9NqIW2Wy4+pU3BBE=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oUJmnXTRVnF8M4UyTehYBXDjgwaYC87wXjix+ylbyLwit+mnYv50h3cS5Snr+f0jAVS3TDJexhaVyFUi4j0F0mNgYlqxdJzMVyNHwCFsCLFJZNaazvNiltkCbuggKfrsmMUa5JR08+STSVWXVRK1yCwNc9E4EySwCMryH9lj4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b=WpyvQE9r; arc=none smtp.client-ip=216.40.44.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=goodmis.org header.i=@goodmis.org header.b="WpyvQE9r"
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay06.hostedemail.com (Postfix) with ESMTP id 0F4ECA2D9E;
	Fri,  4 Sep 2026 18:34:23 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id 2743F30;
	Fri,  4 Sep 2026 18:34:22 +0000 (UTC)
Date: Fri, 4 Sep 2026 14:35:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Vincent Donnefort <vdonnefort@google.com>
Cc: mhiramat@kernel.org, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v10 2/4] tracing: Fix subbuf resize races with
 trace_pipe_raw readers
Message-ID: <20260904143527.40e73d36@gandalf.local.home>
In-Reply-To: <20260904164450.1345852-3-vdonnefort@google.com>
References: <20260904164450.1345852-1-vdonnefort@google.com>
	<20260904164450.1345852-3-vdonnefort@google.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: hwwnj8p4hbowsuprhpszwe718aw4u8ut
X-Rspamd-Server: rspamout04
X-Rspamd-Queue-Id: 2743F30
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18FSR5EA53aYPjptzNCeVA1n0JRdeGNdec=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=goodmis.org; h=date:from:to:cc:subject:message-id:in-reply-to:references:mime-version:content-type:content-transfer-encoding; s=dkim1; bh=Ku5LYoL7PvOLqayMNOglNE2RaUJlMb2qSapB2xO3a90=; b=WpyvQE9rEfv9i6q7WW8P2h5Px+TfVfCt6JjiEvXfrFdNvzbcOL3TKk5bBPOEAH7YTgRMj0MW4VCVVG/5o1zD9+tVAby+4mOVVFcBt+piH4wKlLj+HpPI4z+eSCW2w9C9lLBEBXqd6kSx0bpwTyjtTPmIhayvxUPuETgH2mB2Pb4=
X-HE-Tag: 1788546862-248759
X-HE-Meta: U2FsdGVkX19iMqgLf7Ez23LZKcDPQng/ZCEJ0SuEDVNGCCqP+f9iIkft91rpFZsgjtEJbUYtqpubN51UAIlAmUf2RV7mwYp9eX0bd9nsp1y5nqOUHfIbJP0f6WU0znpK0FaKX8YtLNLtfTJefSkjVrIt2EEFICPkYCNJGSJ1xwARKgnIiWIwfN2dlqKIT9yvabQx5q5EgEezyA+/OI6p2+8og/CC0y9GVU3UINrKOrAgQeB9MuWVttDRRKsp9VCArQefJdDnFqhlx07OWe1yLPS6hYVBZogbsl04CLcK6AlnfZpzphMo6yO3ZCOOOfxobZH4aBlM0srRDQbgL5kuetGqNzh2cyeR

On Fri,  4 Sep 2026 17:44:48 +0100
Vincent Donnefort <vdonnefort@google.com> wrote:

> @@ -7306,25 +7281,37 @@ ssize_t tracing_buffers_splice_read(struct file *file, loff_t *ppos,
>  
>  		refcount_set(&ref->refcount, 1);
>  		ref->buffer = iter->array_buffer->buffer;
> -		ref->page = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file);
> -		if (IS_ERR(ref->page)) {
> -			ret = PTR_ERR(ref->page);
> -			ref->page = NULL;
> +
> +		ret = ring_buffer_alloc_read_page(ref->buffer, iter->cpu_file, &ref->rpage);
> +		if (ret) {
>  			kfree(ref);
>  			break;
>  		}
>  		ref->cpu = iter->cpu_file;
>  
> -		r = ring_buffer_read_page(ref->buffer, ref->page,
> -					  len, iter->cpu_file, 1);
> +		page_size = ring_buffer_read_page_size(ref->rpage);
> +
> +		r = -EINVAL;
> +		if (IS_ALIGNED(*ppos, page_size) && len >= page_size) {
> +			r = ring_buffer_read_page(ref->buffer, ref->rpage, len, iter->cpu_file, 1);
> +		} else if (!i) {
> +			/*
> +			 * We failed to read because the length is too small
> +			 * or unaligned. If this is the first iteration, it's
> +			 * an invalid userspace input. Otherwise, this is due
> +			 * to a subbuf order change. Do not report an error
> +			 * and just finish the read.

This isn't quite true. It can be an invalid length and not the first
iteration. If you ask for a length that isn't subbuffer aligned but greater
than one subbuffer in size it will work the first iteration but fail at the
end where it couldn't get a full page.

That is valid but would also trigger this path.

This is the only issue I have with this patch set. I'll just take it as is
now. We can fix the comment later. I want to start testing it and get it to
Linus before the next RC release is out. If it fails the tests, then we can
fix the comment as it will not make the next release.

-- Steve


> +			 */
> +			ret = -EINVAL;
> +		}
> +
>  		if (r < 0) {
> -			ring_buffer_free_read_page(ref->buffer, ref->cpu,
> -						   ref->page);
> +			ring_buffer_free_read_page(ref->buffer, ref->cpu, ref->rpage);
>  			kfree(ref);
>  			break;
>  		}
>  
> -		page = virt_to_page(ring_buffer_read_page_data(ref->page));
> +		page = virt_to_page(ring_buffer_read_page_data(ref->rpage));
>  
>  		spd.pages[i] = page;
>  		spd.partial[i].len = page_size;
