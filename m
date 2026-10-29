Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793232669;
	b=kGrY0E6VLug5XgTu5xmDz0n8qHFvT7INNDFpDNRLlnVujfzZQKTdnvatM0YkkTEWrSe0
	 XfVNIJoZ83pyQuTYPC3UskhyZvegPLGXMnVclwe5fqrq7l60Dst4eqImCQKNTpeMyub5b
	 GhEMeZBuA62iR++zItdfo8ktlUhEu5IMaXXd5ZgOhOl+JjwWEv8MSX/AIOIMMrNrSXt7E
	 CHfpTpAI0OByUesJO6GxUU/OMpvxRTUn99qN9swRqMKvUgJ3ZMbD4y+YJDWFvMduzIyWH
	 fqj7FiOqxmVGKxvAu0mm0r7KEchr/3I9+E1N4CTmn9Bod/T38ZTVK8ELsZXorNwqI+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793232669;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=Bj9NjgouKwDuEYr3QVcM5yN+7mpe5oQosQgQsNpRmoM=;
	b=i/5W+FojdApTDowlS95zXR3SqmBZdhqYPjuuD4ZSTb8bdWFXmGSHSez0D47vbhqpg/Kv
	 kZcVO98x1/WCGGC1CfKTpGCJ3TTsV7hLFd4PQ7b2hoc/3bL4TwgfdSO217egqNbr2ynq+
	 +8mdfSGOnKjyvHqt06hNNLzZ2XOOUq7bGdPq9NpG0ID79Z4QaiDKZTFhwGqL807bLVDn6
	 sphXCFCPobJUAfHjpWL5wWkN0/lTvn46sg/V8PQab40UQHUP8/vOnuX0URxJsNdYNleoP
	 V7VWLJHk2jXgVMAroFc3mgV11ItJqyUy0rtCp2Sv2ttfXXcvSu63YjJgW8wrUfDTAIg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzZZb87N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1BE4606A31A;
	Thu, 29 Oct 2026 00:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hzZZb87N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21F9A1F01825;
	Thu, 29 Oct 2026 00:11:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793232668;
	bh=Bj9NjgouKwDuEYr3QVcM5yN+7mpe5oQosQgQsNpRmoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hzZZb87NFyEVT5KIU/jmaS2dLm0QTiVkZvT0/byuI5faBx7BgYRV+GBj4kc0fC6a2
	 gvJ31v/fEgtD+IixqVLfURQV9OxdEZj6vd8Bv3OnLCm59tGTICwiixmPdUZYQRPzBR
	 QkTpQk78iPAjvHzUNxLdCtdNyJrGZBswfdCtspsW6k4t0eeI1mC7IjXR2Mgjdy1Xl1
	 zhyhK5yXdCLQK9T++xadCO6TIWwt6Ur6QyKDRtC9P/7tkMEYYT3r+RWrewVO1IgP0R
	 SeT26BdBHZmiL1it2db/Kgbd7N/B2AlXUoWdEGIob66r4SzhZ9nq/Lzyv9ezjOqKWB
	 EOKC5ydIocZSA==
From: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To: Shuah Khan <skhan@linuxfoundation.org>
Cc: Jaewon Jung <jaewon8868@gmail.com>, Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Shuah Khan <shuah@kernel.org>, linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
Subject: Re: [PATCH v2] selftests/ftrace: Add missing spaces after ! in probe syntax tests
Date: Thu, 29 Oct 2026 09:11:05 +0900
Message-ID: <undine-1793232665820252245-7a2a265d21895a9f@undined.local>
X-Mailer: UndineD 0.1
In-Reply-To: <9c65a285-9144-494b-b4d8-e3d0deb671c7@linuxfoundation.org>
References: <20261025075044.1750113-1-jaewon8868@gmail.com> <20261028011923.2050009-1-jaewon8868@gmail.com> <9c65a285-9144-494b-b4d8-e3d0deb671c7@linuxfoundation.org>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

On Wed, 28 Oct 2026 15:06:26 -0600, Shuah Khan <skhan@linuxfoundation.org> wrote:
> On 10/27/26 19:18, Jaewon Jung wrote:
> > Add the missing space between ! and grep. Otherwise, the shell tries
> > to run !grep and reports "!grep: not found". This always skips the
> > conditional checks without checking for kernel return probe argument
> > support.
> > 
> > Fixes: 25f00e40ce79 ("tracing/probes: Support $argN in return probe (kprobe and fprobe)")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Jaewon Jung <jaewon8868@gmail.com>
> > Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > ---
> > Changes in v2:
> > - Add Fixes, Cc stable and Acked-by tags as suggested by Masami.
> > 
> 
> Thank you. I will take this for 7.4-rc2.

Thank you!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
