Received: from relay.hostedemail.com (smtprelay0015.hostedemail.com [216.40.44.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D28CA32AABD;
	Wed, 27 May 2026 14:09:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=216.40.44.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890954; cv=none; b=Z/GFQAXsdlJSmWa9LZ6B4Yty1QmaOadMSjguHUM8rLyU6LQ00l2g1HL7OmOnLB7T75yn7f9gVKlrAmUSzVF1UW1vZsPM9qCXq2UjjO1h5K4OOHeDUFUqOMs1hsaTryM7oruiUB9VMK0T6yCZOAxY39hoZMXM0yUbqtlgkEC5Sug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890954; c=relaxed/simple;
	bh=egE/FR7FtF3e6TePrTXmKyquQDlPQ42QENNvH1KRxHk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ludLjeebhNB3wkJnRKe6RrqjzrwY/gs5XdmUgiGS/+ErZkDfnkpV/NnQZaF9OW4zmIh5TZiHpa5pjeY5feknkvn7+E7GtX4H1HIZIPEiv1eO7L7SeY5R5vZVhOH9GXQBj0T/+syEE2lKa7A5KvrEpoiEpMLpjVQkEKSwPjhDM/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org; spf=pass smtp.mailfrom=goodmis.org; arc=none smtp.client-ip=216.40.44.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=goodmis.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=goodmis.org
Received: from omf17.hostedemail.com (lb01a-stub [10.200.18.249])
	by unirelay04.hostedemail.com (Postfix) with ESMTP id 50A601A05FF;
	Wed, 27 May 2026 14:09:11 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: rostedt@goodmis.org) by omf17.hostedemail.com (Postfix) with ESMTPA id 552DE1A;
	Wed, 27 May 2026 14:09:09 +0000 (UTC)
Date: Wed, 27 May 2026 10:09:43 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Tianchen Ding <dtcccc@linux.alibaba.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] selftests/ftrace: Fix trace_marker_raw test on 64K page
 kernels
Message-ID: <20260527100943.3dc655e7@gandalf.local.home>
In-Reply-To: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
References: <20260527095438.1794905-1-dtcccc@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 552DE1A
X-Stat-Signature: niiposcd159apm94mo5kon7r1bd37pna
X-Rspamd-Server: rspamout01
X-Session-Marker: 726F737465647440676F6F646D69732E6F7267
X-Session-ID: U2FsdGVkX18SNwaJvgtgS4C1EQsi1h4WlrF/aldSKIw=
X-HE-Tag: 1779890949-52684
X-HE-Meta: U2FsdGVkX1/n2VcyE+G/FPk0VpyqjwlXOyn+jcZuBJORpt0xsus61i8F0uBNg7KB2rxYJ1lyg4noBDZ8X18DdPAXCq32G9Meyp6VGh1TyQXiuU0+HYnYNKpUE5gjQgckQuGT14L+X5piLckBV6pheQXPVxampRxoLSNOSgKDfCD3y3MYzdJUiuvxZSTy0V7NDRsW+FcgDomXEW7v9AgEwfDRaYbwMuocfPfCBWLI+hnjKDCzWWpXjR+00Cqh+GT4C/cO/QJivSQLpj8vlaBE48zRyctHT3R9lJFVEew3PFtHxYtH19exyKuU7xZEpmIj3OwIBnqt60IQHlvbNKg59uvUL+iVRFqI

On Wed, 27 May 2026 17:54:37 +0800
Tianchen Ding <dtcccc@linux.alibaba.com> wrote:

> On ARM64 kernels with 64K pages, the trace_marker_raw test fails because
> bash's printf builtin uses stdio buffering which splits output into
> multiple small write() calls to the tracefs file. Since each individual
> write is within TRACE_MARKER_MAX_SIZE (4096), they all succeed, causing
> the "too big" write test to incorrectly pass.
> 
> Fix by piping make_str output through dd with iflag=fullblock to
> guarantee a single atomic write() syscall to trace_marker_raw.
> 
> Fixes: 37f46601383a ("selftests/tracing: Add basic test for trace_marker_raw file")
> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
> ---
>  .../selftests/ftrace/test.d/00basic/trace_marker_raw.tc     | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> index 8e905d4fe6dd..efd8263e6087 100644
> --- a/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> +++ b/tools/testing/selftests/ftrace/test.d/00basic/trace_marker_raw.tc
> @@ -43,8 +43,10 @@ write_buffer() {
>  	id=$1
>  	size=$2
>  
> -	# write the string into the raw marker
> -	make_str $id $size > trace_marker_raw
> +	# Pipe through dd to ensure a single atomic write() syscall.
> +	# Shell's printf builtin uses stdio buffering which may split the
> +	# output into multiple writes.

Could you comment that this is for architectures with 64K pages too.

Thanks for fixing this,

-- Steve

> +	make_str $id $size | dd of=trace_marker_raw bs=`expr $size + 4` iflag=fullblock
>  }
>  
>  

