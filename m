Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793323271;
	b=XB/GZ+2HrE5Puveg9toYEqqbZfXl/w4M3OuTEZ41/bGWsoB3yv6EMqhLGs9gTJYh0i2V
	 1MqAH/6eEuO4EH6+6y81UckNygiEav4qyLbMJfTUysDEfLEDQVB3oUl5ZmJ8Ux7lJh7QK
	 C3XpuOTkcHMhO8J3W3t3ZjgXWOTSrf6HSvcSpuU0lRXWiOgvmDD0q9vp1rRu/NwhL+EOX
	 eijOEytpysWaJcAKX237Q54KWK26z4Kl8OEX8QtYRJE4tHHzlACKxK6p/IubaSSZ1Jatz
	 GUhw6hGh6RVf0ogczwMfKuq0Jppl5IK8pw3nsnYhKpurMolpyRmt7lhYGtLB+ZAN2uQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793323271;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 In-Reply-To:References:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=KFQrcaSDTNv8E13IBteawzqm+5tXdy4e+ERYsBvWvE8=;
	b=d1ff5sUzbg3ClKm+MIB06tqJtz4t5oQAd3aoK6aqo+daRwXpk63zoFGllNoMyXhWL4/w
	 +pJFRzX8z+qKcLvel24rn7W7XfiTwfMVokWs9FUfnr7X1E4PRClPp/cmq39WoIr+rWlsD
	 jaa3BitYxJPYq/PaQgn6WQ837QAGo0woTCp4A6Ev6LUTO03Er51HRH2VMJGNp81Yg7dM1
	 hWuwXRXmt6yGAPCVHhQ0vcvFNurfTKC8G+rCp5E/uPXnyjJZoVDnz6MF40cuj5Q1M+1Hl
	 j31hChgyi3U1JWN8sIqn19uWco+valVebFFlraLPu0w9ASDPf09bwgPgZ7FoHE4XI9g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRl0mZ4o;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68808606A31A;
	Fri, 30 Oct 2026 01:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CRl0mZ4o
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 151721F000C1;
	Fri, 30 Oct 2026 01:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793323271;
	bh=KFQrcaSDTNv8E13IBteawzqm+5tXdy4e+ERYsBvWvE8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=CRl0mZ4oiS+fC0LvCLRmL8cQ2p39/6O9pTGImPcQ2+DOJFCmtLzzG+4AZ9J/4MT7g
	 8mZgBrBJQG3nVogg8ntjLXZErd2DIRc56lmtg89224Rzk5a5tre9LbCgwiMRNqJMi3
	 g5XYbeSq8xa0ScYT9sK827R0xrvpjypsch8cNECgDWT7AiL9CbSpAZx8/iok8Cdzm7
	 vcUiHo5L3yEWFLVFcpxq9kBDywCG/KmVCM6ZDoT3gzmh4zP4bhiBMYYG7c5p3BzANQ
	 c7M71M5thB/1T2GmMi4xvsbUcUP/RdkKf2H+5ZeQO8B9LCudtLGQjGM6iThyvrUbQy
	 4VxbY85POXd6A==
Date: Thu, 29 Oct 2026 21:20:55 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-kselftest@vger.kernel.org, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, Shuah Khan <skhan@linuxfoundation.org>
Subject: Re: [PATCH 1/2] tracing/selftests: Fix instance test to actually
 test races
Message-ID: <20261029212055.41a6141f@fedora>
In-Reply-To: <undine-1793322079170721165-fee1052e7bb8c899@undined.local>
References: <20261029202849.245864353@kernel.org>
	<20261029203205.757392992@kernel.org>
	<undine-1793322079170721165-fee1052e7bb8c899@undined.local>
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 30 Oct 2026 10:01:19 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> >  instance_slam() {
> > -        while :; do
> > -                mkdir foo 2> /dev/null
> > -                rmdir foo 2> /dev/null
> > -        done
> > +	mkdir foo 2> /dev/null
> > +	while ! rmdir foo; do
> > +		echo could not rmdir foo  
> 
> nit: If we retry this, do we need to warn it?
> (maybe we can add a limitation of continuous failure and make the
> test fail if the failure exceeds it.)

Retrying is actually quite normal. The rmdir *should* fail if one of
the instance files is open.

Now perhaps we can add a counter to make it fail if it exceeds a large
threshold?

	let x=0
	while ! rmdir  foo; do
		let x=$x+1
		if [ $x -gt 10000 ]; then
			exit_fail
		fi
	done

?

-- Steve
