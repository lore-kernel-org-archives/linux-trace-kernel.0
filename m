Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=efficios.com header.i=@efficios.com header.b="f4RYCi4g"
Received: from smtpout.efficios.com (smtpout.efficios.com [167.114.26.122])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F82FA;
	Sun, 10 Dec 2023 06:11:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
	s=smtpout1; t=1702217500;
	bh=Sx8TXHQnq0Bu4P1ud22ViTYxLo53aYEoyv0Qmlg6phk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=f4RYCi4gN3RvYVZWFmIodncah0uu2r/Q+Iu4iGV9zbpu/LA9DVgKSUvy1OGTJoZXS
	 bJPPzFFTMj9XtzU+Jqke8xCt29nfo4P8CeA07vNgxzQ1qE5jU1CsGDKBNLq+VlB5LK
	 s3nuRn4DSvw7hPVx2fh6i9YQ6aPTNXgd3Lf8LoF/uH8hXO8RB21b2jUlIgmWhN0Boo
	 3vyqglorUXcqgwFZaXa9uBgVbm8oOq3BBLfAQlAjXuU/AVF+ki6f5064uThfOIxOmJ
	 Jy6gi7yBSAOvS4eSYcpyAr6WyjYVg42XEMJhxSHqUF+qZVSgWD35gRXeC1pj7bZZtQ
	 ha+sqDTEOO58g==
Received: from [IPV6:2606:6d00:100:4000:cacb:9855:de1f:ded2] (unknown [IPv6:2606:6d00:100:4000:cacb:9855:de1f:ded2])
	by smtpout.efficios.com (Postfix) with ESMTPSA id 4Sp6Hw2zm6z1hZ5;
	Sun, 10 Dec 2023 09:11:40 -0500 (EST)
Message-ID: <18d6a5e5-f7a5-4a86-aa0b-eec38652c0d5@efficios.com>
Date: Sun, 10 Dec 2023 09:11:40 -0500
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tracing: Have large events show up as '[LINE TOO BIG]'
 instead of nothing
Content-Language: en-US
To: Steven Rostedt <rostedt@goodmis.org>, LKML
 <linux-kernel@vger.kernel.org>,
 Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>
References: <20231209171058.78c1a026@gandalf.local.home>
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
In-Reply-To: <20231209171058.78c1a026@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2023-12-09 17:10, Steven Rostedt wrote:
[...]
>              <...>-852     [001] .....   121.550551: tracing_mark_write[LINE TOO BIG]
>              <...>-852     [001] .....   121.550581: tracing_mark_write: 78901234

Failing to print an entire message because it does not fit in the
buffer size is rather inconvenient.

It would be better to print the partial line, and end the line with
a <TRUNCATED LINE> tag.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
https://www.efficios.com

