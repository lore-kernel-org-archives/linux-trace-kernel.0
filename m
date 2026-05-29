Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24E0F32BF4B;
	Fri, 29 May 2026 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780060541; cv=none; b=uFnjBwjr/HR6Xm9xRHXgQT1eytxgDVZQoOgD3eY6yLw9mN5+dc7/YavkyNcMEeyJf0iVvowfVdJr7wETjaEJCCdBQKDXJBIRqXwe7k7WnyvUoxcWtTwH2fO/0CZvzmWc1Neh0dmSFcE7R9peW7vCP9VLl9oomDcNiOtVM+7V0WI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780060541; c=relaxed/simple;
	bh=HH2rJ5qllUzP8pAoqWEKQ/RjyBC2yL6YRSiw4Q3sPx8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BEdXwODByitw1IBUdm53Wvm4QsT38OP/sJD18LUY7XtUFlTPeoGgkEJiDeLEBM+djC7yHWRs2x7InvBk4MoJCIIwoF67wsR2/E4x0SI2lAVRrvayo8xwK9NGS623OQRfZ4e5SBR5HAsNCXWPMDHt47gI3qJT2EPjMotITCcN3BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf10.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id B58041A0154;
	Fri, 29 May 2026 13:15:32 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf10.hostedemail.com (Postfix) with ESMTPA id AD82435;
	Fri, 29 May 2026 13:15:30 +0000 (UTC)
Date: Fri, 29 May 2026 09:15:29 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: Fix trace_marker_raw test on 64K
 page kernels
Message-ID: <20260529091529.3ec09629@fedora>
In-Reply-To: <bcb52d91-0440-4e73-86af-997e8b723711@linux.alibaba.com>
References: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
	<20260528022417.1813745-1-dtcccc@linux.alibaba.com>
	<20260528091348.71ae3aa3@fedora>
	<bcb52d91-0440-4e73-86af-997e8b723711@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: a7szaudfjcres7mtxyhd7uwntpgabi9b
X-Rspamd-Server: rspamout02
X-Rspamd-Queue-Id: AD82435
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/SjJYwOQ/NJ9e4mxfpLyESZmKP83WdIms=
X-HE-Tag: 1780060530-202397
X-HE-Meta: U2FsdGVkX1/WsKqhtEaaedBKFpC2yTEPmpTEGn3xNx0H79zmD/OGmlRYkPnvTcXCGQRsEXtUsazjEctBsmU4ZocXACVSwCzViAI3ZNaIt0dPKnSjiq8jXczmfyF0taQLE483THTwHKeceSwZBNuPQjMMloC5ISNGyCoQllvLvdcpp4QBOAEYYCPCqr9pq3d5t3Xyc7uoZqbgStRy80d7Tnmvsg1zB2sN1udH/L1Ybum8lBCOTL/MvxWTenwJWwrDDCsuI9RUs/HEwElpGxyPzzLNtZTvM+wOjuijjFl2NXVQyNokGpXnnqVaVm6KjpRxksHzTs7ahrZZZMl8VtmRj0StKYF8NL8p

On Fri, 29 May 2026 10:59:34 +0800
Tianchen Ding <dtcccc@linux.alibaba.com> wrote:

> We can take advantage of this by having make_str return the escape-sequence text 
> instead of binary, and letting write_buffer handle the conversion:
> 
>    make_str() {
>          ...
>          printf '%s' "${val}${data}"
>    }
> 
>    write_buffer() {
>          id=$1
>          size=$2
> 
>          str=`make_str $id $size`
>          len=$(printf "$str" | wc -c)
>          printf "$str" | dd of=trace_marker_raw bs=$len iflag=fullblock
>    }
> 
> This way str holds only printable escape-sequence text (no NUL), printf "$str" 
> converts it to real binary through the pipe, and wc -c measures the true binary 
> length.

This is quite hacky, but at least it removes the hardcoded assumptions.

OK, you can send a v3 that does that.

Thanks,

-- Steve
