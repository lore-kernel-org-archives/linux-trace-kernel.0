Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793305927;
	b=sFErB1scg2H3oMW6xIgs1CC0LsH+Dm4Yrx5J/Tneh+3iT1dsHnyrVBcwqXtOv08SYv/r
	 euQwrJbytv+rbV1F39MrAzHpe0RqNYdrPpwJsuIul0U4B5PZnOu8R744R6iKgFpj8IPD/
	 eXZSTeaR3/xy5NQ6ll6Si92S21pB9xVKWgzMOrFy5xuOSgo/3rqqvBIAMhdoNTxTSkOrV
	 nCBQY9ACWA2YuJbv4BlNd8N0NzDjaERoF5xwbnaYbhFVmlhmWX/DsPw//ucYVq4LaApsP
	 HacahjAqg71AZMDJab5Zib/WEyZlfvv5nsFU7hJ/rpZLF+2f3xSUKy3i4ieyxQ3zieQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793305927;
	h=Received:DKIM-Signature:Received:Message-ID:User-Agent:Date:From:To:
	 Cc:Subject;
	bh=PJy7HHOX8MQmoX+CFz+zee9Y0lAM6VKlGOkcxSg+ELM=;
	b=si6qv1NEnnJobGNdhr9nRgxhR/8fkOFAIMyPc0CAZtoP8dyDC1Zygd+lojNPNCMXFyRj
	 n3Us4MuHaD16pqb9o2b1oNeq+eCIS+QOc8j8rUj+lrs1uI6Gs0l+onMPhO0JUYd3te1FI
	 qSLjnxbtR7eQJKwEp3WiIRKh4AF0W7rUhZFFO6HIo+p1hADXpcZ7c3VO2Im6k+///z5fa
	 Gzxmt1WTKkepYZJuzpn5d8zB56bBD4aWFiQ40M76337U/xmasyl5/aGkBx36k2hAnwROv
	 vhMaFb1ThHb6Bqyr2qgZHhsmio18h9v1ocros3p89yKmT/x9m7xwrOHKecKGKdXvYLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOiKM0ku;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1AF9606A322;
	Thu, 29 Oct 2026 20:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dOiKM0ku
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999771F01826;
	Thu, 29 Oct 2026 20:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793305926;
	bh=PJy7HHOX8MQmoX+CFz+zee9Y0lAM6VKlGOkcxSg+ELM=;
	h=Date:From:To:Cc:Subject;
	b=dOiKM0kuQeIC8DzYTN7wAgpO3TH1rFrCmVvQKRIvQYdOMsXhDz3mrk4CUSiSNNKWi
	 ubTmaKp4eWQngOTpfmvtnWLDWSkOKPhJP1kp5TMQGbHFphi9KcwldCU5J5ApHZ4Anr
	 hAFnRkfXT6s9CwbQ+ZBEreUzWVBn1gQ1WUnA39v1uKTggfffPUHpX6n6AwRM4pz+9z
	 ZO5b7q2GdzJxwkztBnvHw25r1ioszcrUXnkXn8o/tY67QQ/sQo21QWi9BdQaQcq/3n
	 iX9RftWXEApkbV65pkojJSraejfoCwUs3E0SZdQ2TLM2lc50+cF7eSPH/l6eIwC7J+
	 ZgnhX/Rx5mRdw==
Received: from rostedt by gandalf with local (Exim 4.100.1)
	(envelope-from <rostedt@kernel.org>)
	id 1xMWn7-00000008yb3-344e;
	Thu, 29 Oct 2026 16:32:05 -0400
Message-ID: <20261029202849.245864353@kernel.org>
User-Agent: quilt/0.69
Date: Thu, 29 Oct 2026 16:28:49 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Shuah Khan <skhan@linuxfoundation.org>
Subject: [PATCH 0/2] testing/selftests: Have instance test stress instances more
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list

I found that the instance test doesn't actually stress the creation
and deletion of instances while reading them as I thought it did.
This was due to the rmdir failing to remove the instance because it
was busy (by the reads that were happening).

Make the tests do 10 creations and removals while reading the instance
and mkae sure the removal succeeds.

Also add reading of more files that were not tested before.

Steven Rostedt (2):
      tracing/selftests: Fix instance test actually test races
      tracing/selftests: Add reading all instance files to instance test

----
 .../ftrace/test.d/instances/instance-event.tc      | 34 ++++++++++++++++------
 1 file changed, 25 insertions(+), 9 deletions(-)
