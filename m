Received: from relay.hostedemail.com (smtprelay0013.hostedemail.com [216.40.44.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7B39E167;
	Mon,  1 Jun 2026 13:52:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780321925; cv=none; b=Vwt5I8Mgn0jevHCIT2a78wYt0dQh8XcdjE0pfEaV7vfXxdHpjk7X0zhF6NiwBoleJgBWs7kX7sHfBxv+qY7FLOQh14tRJHr3rmFcZFx5CL4qnNvQUCGDW7bFPDfRjhtUCdHJk5DFP9XtOUk5HnQX1WCczqTlquQ0iXwbqbcC+zs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780321925; c=relaxed/simple;
	bh=3NtkPf9g7MoGwvdqULvbOE6zbppgRSQFX4b4QjXgQCo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Uvsy/+WH559t6oSdX+9dJr7ZofXq4EvtQWFd8tgQQhf48JwEXNM7VtvVwiLkdlcuhxWc8Sxit4hMwkPD7COF7UW/H1IS8k1pv7QgQgzgdb+ZtHDjbhhKL/Q8Kp89wrpVmaoXcW36yFOSRlhBuCBolNESSTLXZwRFguerBGYEA6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf18.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay05.hostedemail.com (Postfix) with ESMTP id 0B28F406EF;
	Mon,  1 Jun 2026 13:51:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf18.hostedemail.com (Postfix) with ESMTPA id D9C9F2E;
	Mon,  1 Jun 2026 13:51:54 +0000 (UTC)
Date: Mon, 1 Jun 2026 09:51:50 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>, Shuah Khan
 <skhan@linuxfoundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v3] selftests/ftrace: Fix trace_marker_raw test on 64K
 page kernels
Message-ID: <20260601095150.69180421@fedora>
In-Reply-To: <20260601023251.1916483-1-dtcccc@linux.alibaba.com>
References: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
	<20260601023251.1916483-1-dtcccc@linux.alibaba.com>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: D9C9F2E
X-Rspamd-Server: rspamout06
X-Stat-Signature: ku6u3owx95dpwudofx8ghmdsbszmxd7q
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX1/HdjgiG9QsfDGB9ExZ8pcHTtJ9mcWEua4=
X-HE-Tag: 1780321914-852841
X-HE-Meta: U2FsdGVkX187yB1fYE20b3PIrcqyRzzUTeNDs73E/NkxPT0SzL98p+Nc/EEYy5tJR5sXysUtlO4+o0mKLoADHCetxwzgOivLUWUY4ZPfoktaVidGM5s4fgg7MQolSgRjz+bAydvzUeGPKBFIuXCpG/HZ02syNbfKE3yjoK8tg0YsXhwVAnOE2cA1Bl11co+NCa4hzp9a3fY/6rcL66zRwBIy5EUNGTTRMTCQc6fIb0Hb3A2W/xhwj5Bm5vVw99jELyN3YTqFfhTe7h2jeMOXEFrijB3At3bqouLqUEflHqfi9roY89Jlf70CHpjw0hbhiax+KWCH1siwhiNhcH3kjyHDXHJY+2H/XO7zkerkXCDIzxOfhkyy7r3nBzpZpI9siciPr0I7416QCNHe+fTUHQ==


Shuah,

can you take this?

Reviewed-by: Steven Rostedt <rostedt@goodmis.org.

Tianchen,

for future patches, please send new versions as a separate thread and
not a reply to the thread of the previous version.

Thanks,

-- Steve


On Mon,  1 Jun 2026 10:32:51 +0800
Tianchen Ding <dtcccc@linux.alibaba.com> wrote:

> On ARM64 kernels with 64K pages, the trace_marker_raw test fails because
> bash's printf builtin uses stdio buffering which splits output into
> multiple small write() calls to the tracefs file. Since each individual
> write is within TRACE_MARKER_MAX_SIZE (4096), they all succeed, causing
> the "too big" write test to incorrectly pass.
> 
> Fix by writing through dd with iflag=fullblock to guarantee a single
> atomic write() syscall to trace_marker_raw.
> 
> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
> v3:
> Measure the binary length via wc -c instead of hard-coding "size + 4".
> 
> v2:
> Update comment about 64K pages.
> ---
>  .../ftrace/test.d/00basic/trace_marker_raw.tc      | 14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> index 8e905d4fe6dd..f985ff391463 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> @@ -36,15 +36,23 @@ make_str() {
>  
>  	data=`printf -- 'X%.0s' $(seq $cnt)`
>  
> -	printf "${val}${data}"
> +	# Return escape-sequence text (e.g. "\003\000..."); the caller
> +	# converts to binary. Shell command substitution strips NUL bytes,
> +	# so the binary form cannot survive being captured into a variable.
> +	printf '%s' "${val}${data}"
>  }
>  
>  write_buffer() {
>  	id=$1
>  	size=$2
>  
> -	# write the string into the raw marker
> -	make_str $id $size > trace_marker_raw
> +	str=`make_str $id $size`
> +	len=`printf "$str" | wc -c`
> +	# Pipe through dd to ensure a single atomic write() syscall
> +	# on architectures with 64K pages, where shell's printf builtin
> +	# uses stdio buffering which may split the output into multiple
> +	# writes.
> +	printf "$str" | dd of=trace_marker_raw bs=$len iflag=fullblock
>  }
>  
>  

