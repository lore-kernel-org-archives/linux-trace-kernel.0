Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22B3A126F0A;
	Mon, 24 Feb 2025 19:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740424566; cv=none; b=CTf0WsihUdCwMNO3IAXTYYI3rPcCzbDZx5c32Lw886Peu5qtIPbnJi9cbuNHJOhdjz9T9hakF+7nGVryp6DCD3Ghk/97euPXxbgSZ8vRrpInoHQG43WJo13o3cya37/dTiWfV/VX8TxrcQE0LArPGTKCLx+iQSJyB7Jj6siORoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740424566; c=relaxed/simple;
	bh=o0zV8DH2b915PxW+XO057vqWp/Z4dhVTZcSuK1elOLc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Xz/w+kTKfuhzSb3wXYeBfmb0f+bzabwYXb95C7CI27evYXuoA3ydpJXqBht9VW222bGEQX4xY1UDt8pYR3PPyDI3sf4X/vlL1pFFRnIunOkyfJpKRnMqH3dgwLsOkdVjcTo7lQJ0ZUSCKOea6xPYDPBt1XfITK5bKmuHWjZtbYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=km2eVt6W; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="km2eVt6W"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F27BFC4CED6;
	Mon, 24 Feb 2025 19:16:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740424565;
	bh=o0zV8DH2b915PxW+XO057vqWp/Z4dhVTZcSuK1elOLc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=km2eVt6Wv0nBwUeqlUcJvsLx8jY/zvb5EISGbWJIb/M1AcymmNpq8JhvarpioIe8S
	 czse3BjjR3JOloRnQ5J70QpG+2fswVyp5H2CFDo4RXcLWFyU9CCiz5TD1AGI3pjBKi
	 SIkVgrcgPCW57+C5y55qz5bZImc4GJEPKr88PD7YrvWz3lE2skw1IFQGjvTqwTDDc9
	 XhAkrvf8I+g/SD8qi+tcZv6M+cnC30Qysh0eScuQd6mKTEK5JazvpKj9I6X1NdCONk
	 LrvHnOszYeXgMXg88YcoTvPcXzkzZ54dlGjZ8KarGMl4qdvcLhDEhtCqFhsq4lN+mO
	 +iwRu43xD52hA==
Message-ID: <559f3da9-4b3d-41c2-bf44-18329f76e937@kernel.org>
Date: Mon, 24 Feb 2025 12:16:04 -0700
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next] trace: tcp: Add tracepoint for tcp_sendmsg()
Content-Language: en-US
To: Eric Dumazet <edumazet@google.com>, Breno Leitao <leitao@debian.org>
Cc: Neal Cardwell <ncardwell@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>, Steven Rostedt <rostedt@goodmis.org>,
 Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, kernel-team@meta.com,
 yonghong.song@linux.dev
References: <20250224-tcpsendmsg-v1-1-bac043c59cc8@debian.org>
 <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <CANn89iLybqJ22LVy00KUOVscRr8GQ88AcJ3Oy9MjBUgN=or0jA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 2/24/25 12:03 PM, Eric Dumazet wrote:
> On Mon, Feb 24, 2025 at 7:24 PM Breno Leitao <leitao@debian.org> wrote:
>>
>> Add a lightweight tracepoint to monitor TCP sendmsg operations, enabling
>> the tracing of TCP messages being sent.
>>
>> Meta has been using BPF programs to monitor this function for years,
>> indicating significant interest in observing this important
>> functionality. Adding a proper tracepoint provides a stable API for all
>> users who need visibility into TCP message transmission.
>>
>> The implementation uses DECLARE_TRACE instead of TRACE_EVENT to avoid
>> creating unnecessary trace event infrastructure and tracefs exports,
>> keeping the implementation minimal while stabilizing the API.
>>
>> Given that this patch creates a rawtracepoint, you could hook into it
>> using regular tooling, like bpftrace, using regular rawtracepoint
>> infrastructure, such as:
>>
>>         rawtracepoint:tcp_sendmsg_tp {
>>                 ....
>>         }
> 
> I would expect tcp_sendmsg() being stable enough ?
> 
> kprobe:tcp_sendmsg {
> }

Also, if a tracepoint is added, inside of tcp_sendmsg_locked would cover
more use cases (see kernel references to it).

We have a patch for a couple years now with a tracepoint inside the

while (msg_data_left(msg)) {
}

loop which is more useful than just entry to sendmsg.
