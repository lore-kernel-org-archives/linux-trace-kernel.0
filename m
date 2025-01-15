Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B01C116DECB
	for <linux-trace-kernel@vger.kernel.org>; Wed, 15 Jan 2025 16:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736960156; cv=none; b=SLbtZl6Mw1MNTcrE0VDHGOodtv42yOGa3b0br/xmZgA/Kd3/sFA9bLFV4eXYIW7RDcDyBhqH0xYJoLWcMymt0TUGzqNsAa9Yfqm5m8waJStcaI9ulwDCsFvMsIv5UMjUOoDCJ1rtHS3wvVGERBz1A1QNMPmJgX9G4uo8tBCuaFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736960156; c=relaxed/simple;
	bh=EkZMOS8lXQVrePsY1zs/c2ht67Jf2ytlmPkCyb7euc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=VfXtBpo1aJWRKPl+YhS39qV/BUv7rZ/fCPXEpqVgN9T+2YaOb7h1S3twWiKjucQ+cqiH6eVogeMSWA+hVzqx2pT8oISN8cajT9OmgDUuEEclgxtu0XWtnay7gCGGA+XmYA6Hlklp+lyW4Yg75PeWQqfJwEPNpuM1rbdj8rqZPCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ITtO8J33; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ITtO8J33"
Message-ID: <34f1132b-43de-44d2-9bc0-e25b49598711@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1736960137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EkZMOS8lXQVrePsY1zs/c2ht67Jf2ytlmPkCyb7euc0=;
	b=ITtO8J33ygW8Kz9rurcxjs5IexSyB/zqDcA0ccHS/S0Z+Cwx1rHHF9NWRsecqO5fX8srTA
	SX+ZGRwXhwPCJ3spPUj9F4iJdn1pQbHQjEZO6STmr4mRWpecapLhxzsSt1knKFtINieJsy
	0D38IQYBa9tHb/GMWruYpkwqVtMvvHc=
Date: Wed, 15 Jan 2025 08:55:30 -0800
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH bpf] bpf: trace: send signals asynchronously if
 !preemptible
Content-Language: en-GB
To: Puranjay Mohan <puranjay@kernel.org>, Song Liu <song@kernel.org>,
 Jiri Olsa <jolsa@kernel.org>, KP Singh <kpsingh@kernel.org>,
 Matt Bobrowski <mattbobrowski@google.com>,
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>,
 Andrii Nakryiko <andrii@kernel.org>, Martin KaFai Lau
 <martin.lau@linux.dev>, Eduard Zingerman <eddyz87@gmail.com>,
 John Fastabend <john.fastabend@gmail.com>,
 Stanislav Fomichev <sdf@fomichev.me>, Hao Luo <haoluo@google.com>,
 Steven Rostedt <rostedt@goodmis.org>, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, puranjay12@gmail.com
References: <20250115103647.38487-1-puranjay@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Yonghong Song <yonghong.song@linux.dev>
In-Reply-To: <20250115103647.38487-1-puranjay@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT




On 1/15/25 2:36 AM, Puranjay Mohan wrote:
> BPF programs can execute in all kinds of contexts and when a program
> running in a non-preemptible context uses the bpf_send_signal() kfunc,
> it will cause issues because this kfunc can sleep.
>
> So change `irqs_disabled()` to `!preemptible()` that covers all edge
> cases: preempt_count() == 0 and irqs_disabled()
>
> Reported-by: syzbot+97da3d7e0112d59971de@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/all/67486b09.050a0220.253251.0084.GAE@google.com/
> Fixes: 1bc7896e9ef4 ("bpf: Fix deadlock with rq_lock in bpf_send_signal()")
> Signed-off-by: Puranjay Mohan <puranjay@kernel.org>

Acked-by: Yonghong Song <yonghong.song@linux.dev>

