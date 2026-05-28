Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85AB3F0AAD;
	Thu, 28 May 2026 13:13:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779974040; cv=none; b=FNlnmr9yMj/WHG46x8qGwdxPrUjjcVy/tutiAaGrbSr94zB5m/go/7ZGcSz0FkN36vlLY+2/qPpamBxpHkWIpNJcrn1feSqM3fWtnJfYua9FjqNOCOXWTitCc6784Ha/xVjSZqPQVdpWNq3ySpOu6GjK7IuCnZo/MF2IjIxL40U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779974040; c=relaxed/simple;
	bh=TNt4FZNUVXbUONxH6eLUa6thNygoQjXrmnVZ2euxCQM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+QPJKO69UytJxkZ4ZAGbthKPuye8Qa4ChhmDASirmZ2F2Ag58NSlJB86VvddPFyLk2Ut7qcRf+3hdNMw+6WiyudBWHkWtwRtaL9nALKc24rRh4QgV2Pf2ZvuVREtuYP8EERQY47JeofTWT11hejsKs9abQrLW5O9FhPRzopzXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf11.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id BB1214080E;
	Thu, 28 May 2026 13:13:51 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf11.hostedemail.com (Postfix) with ESMTPA id B74EC2002C;
	Thu, 28 May 2026 13:13:49 +0000 (UTC)
Date: Thu, 28 May 2026 09:13:48 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: Fix trace_marker_raw test on 64K
 page kernels
Message-ID: <20260528091348.71ae3aa3@fedora>
In-Reply-To: <20260528022417.1813745-1-dtcccc@linux.alibaba.com>
References: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
	<20260528022417.1813745-1-dtcccc@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Stat-Signature: 19hf81xh8jp4zxqph9uo3gmz4r1aocgx
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: B74EC2002C
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/8mrO9fiLpeHdufBy60toekVMt5AHvoU0=
X-HE-Tag: 1779974029-622999
X-HE-Meta: U2FsdGVkX1+Wg9S6O66C7CEc8TiWRZ8DoImmg1Lf/RKCwYpsua4qiXpH5wKR9UprqgDNDtLcCAC54zlDkaa1vSoKiJfdYzn5Z35xW5rK85gW9Rvgv2c4ENjgZ+xhSR3iY4lHTv1VHI0w33gAAhYke/SOs38DRvGQOl5z+8b6/ckrdjG3bWNdwSafXDiPRUT4a5gP5QZwkhPzVuDueCQA+JUBbMK/s4YQyE1u6AFs/zK85VdKgStIfyohin84zTPhNYbSjXzkl3mB/lIjrlxTsM1baRG2lyO05i6YJiA8/m3fmd6gZZRXZXN5Eh7+IXIgoH4D/Yqk4h+gWmn5rl0LDJfQ65glQfkX

On Thu, 28 May 2026 10:24:17 +0800
Tianchen Ding <dtcccc@linux.alibaba.com> wrote:

> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> index 8e905d4fe6dd..f68f1901f65f 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> @@ -43,8 +43,11 @@ write_buffer() {
>  	id=$1
>  	size=$2
>  
> -	# write the string into the raw marker
> -	make_str $id $size > trace_marker_raw
> +	# Pipe through dd to ensure a single atomic write() syscall
> +	# on architectures with 64K pages, where shell's printf builtin
> +	# uses stdio buffering which may split the output into multiple
> +	# writes.
> +	make_str $id $size | dd of=trace_marker_raw bs=`expr $size + 4` iflag=fullblock

I was looking at this more, and I'm not comfortable with the hard coded
4 above. I rather use the length of the string. Something like:

	str=`make_str $id $size`
	len=${#str}
	echo "$str" | dd of=trace_marker_raw bs=$len iflag=fullblock

-- Steve

>  }
>  
>  

