Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D25E1EEA28
	for <linux-trace-kernel@vger.kernel.org>; Thu, 13 Mar 2025 11:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741864542; cv=none; b=iO77t7JNIfkHSEeMnXtm5G5yzLhYqYivysLCGhas1NJ4RWDdm0V+LLi2RrtLeABwZ9oa1mgEzSNtYxc3OOLJgdzL4DIOzhAFuvRvq883lL7jxtrFYSLj8PgawknbVagnvyOjDxJ9oJnhfzwfcn+xjqqpAqroqB/jKrT3Ejw9dM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741864542; c=relaxed/simple;
	bh=GNpYchAuYwmMYYAakf+KN/D2MypHj81WxObaMRuBASs=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gUInFaSuF0yoFNI64Nf3nULuz/ck7Q/HfgFgiLmknyfSrgLwby8LNDfVDKKVjQcMCXAHKemMgwg16Itmch83dBSV1CmLUmY9tEUZYEFNGCgo7mAz3xlJWCwaszCE2ErZLuh/VAuORh1AjxvPxqWmbtLtorzAjbBKXIMZO/Yw0fM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5127C4CEDD;
	Thu, 13 Mar 2025 11:15:40 +0000 (UTC)
Date: Thu, 13 Mar 2025 07:15:37 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-trace-kernel@vger.kernel.org
Subject: Re: [bug report] tracing: Have persistent trace instances save
 module addresses
Message-ID: <20250313071537.19ad59df@batman.local.home>
In-Reply-To: <44c5deaa-b094-4852-90f9-52f3fb10e67a@stanley.mountain>
References: <44c5deaa-b094-4852-90f9-52f3fb10e67a@stanley.mountain>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Mar 2025 11:50:12 +0300
Dan Carpenter <dan.carpenter@linaro.org> wrote:

>     9421                 tscratch = ring_buffer_meta_scratch(buf->buffer, &scratch_size);
> --> 9422                 setup_trace_scratch(tr, tscratch, scratch_size);  
> 
> If ring_buffer_alloc_range() fails then scratch_size is uninitialized.
> This is "harmless".  According to the C standard, it's undefined but in
> the kernel we would allow it if setup_trace_scratch() is inlined.  Which
> it probably will be.  The other thing is that if it's not inline the
> UBSan detector will complain about these.
> 
> The compiler basically always initializes stack variables to zero these
> days so adding an "= 0;" doesn't change runtime at all.

Sure.

-- Steve
