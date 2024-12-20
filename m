Received: from smtp-out3.simply.com (smtp-out3.simply.com [94.231.106.210])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B3B7215F42
	for <linux-trace-kernel@vger.kernel.org>; Fri, 20 Dec 2024 13:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=94.231.106.210
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734702942; cv=none; b=mvggVSxalj+xbN5W7nDPOpn/z8rLD17yxSltP4nr8yutqfBKLzMA643nSgo1nTqV57Bb4m6r61ImlLveD5VBUdSdQ31wSS0xe9t/SNZ2bsHHpTUrGku8FFuLGbT4imSB73qSOVcO+ZY5Vtb63+VxX4PfHb9pdkDXuRTZNZ+YTHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734702942; c=relaxed/simple;
	bh=LGXo5LAsQBrggDSqvN/VxkeWdltuZ7vNgMxZ9qgV+k8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=JHvmIpYxzNQd4YnXe0kzJg6n95pQWNOdaQflp0wFldx5K4S0wB+kiCxJ/rVUmWazW9SH3gzaMI/ofWYVvxNOImMECboP8QDkWuQDyzFklh3uPoKtxMQaU3xVwApeweePw643nUYPhJcTJTo1fFr4CKTHDrGuGI/a07bsjcfP/Ro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com; spf=pass smtp.mailfrom=gaisler.com; dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b=NsqYHn0R; arc=none smtp.client-ip=94.231.106.210
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gaisler.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gaisler.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=gaisler.com header.i=@gaisler.com header.b="NsqYHn0R"
Received: from localhost (localhost [127.0.0.1])
	by smtp.simply.com (Simply.com) with ESMTP id 4YF87h03Yvz1DHVT;
	Fri, 20 Dec 2024 14:55:28 +0100 (CET)
Received: from [10.10.15.30] (h-98-128-223-123.NA.cust.bahnhof.se [98.128.223.123])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by smtp.simply.com (Simply.com) with ESMTPSA id 4YF87g500jz1DHYm;
	Fri, 20 Dec 2024 14:55:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gaisler.com;
	s=unoeuro; t=1734702927;
	bh=At7yS73dQnSyi/YDRnrNDJcKLCjQUYLRFT0wXnyLMng=;
	h=Date:From:Subject:To:Cc:References:In-Reply-To;
	b=NsqYHn0R0pqQgJcljhqtRERna7pTZzmtw4P1CrhtELXBtL4O/Q9yIExHpdGP2aHC/
	 V9BkwAPuwRoQO9LG5qgkatI/f+WsMg53OryeDNXc3xaUGH1ewx0bPw47K9BDlQQ1o+
	 kTQU3SAZTnPh9C2nNeUBeZUI7ZGyX47KYCQaFcsY=
Message-ID: <2d634c54-d8d9-4f33-bfda-9236b6a2ea06@gaisler.com>
Date: Fri, 20 Dec 2024 14:55:27 +0100
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ludwig Rydberg <ludwig.rydberg@gaisler.com>
Subject: Re: [BUG] spinlock recursion when enabling function tracer on 32-bit
To: Steven Rostedt <rostedt@goodmis.org>
Cc: linux-trace-kernel@vger.kernel.org, mhiramat@kernel.org,
 mathieu.desnoyers@efficios.com, Andreas Larsson <andreas@gaisler.com>
References: <86fb4f86-a0e4-45a2-a2df-3154acc4f086@gaisler.com>
 <20241218110115.29d4cc77@gandalf.local.home>
 <bb8485bf-d720-4803-aa3c-037ea1169f8a@gaisler.com>
 <20241218163526.2569917f@gandalf.local.home>
Content-Language: en-US
In-Reply-To: <20241218163526.2569917f@gandalf.local.home>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2024-12-18 22:35, Steven Rostedt wrote:

> 
> Can you test this patch?
> 

I have tested the patch on both riscv32 (qemu) & sparc32 (leon) and it seems
to be working fine.

But I can mention that I ran into a deadlock situation on sparc32.
I had to remove CC_FLAGS_FTRACE for the code that is responsible for
flushing TLBs (SMP). It uses an NMI to signal other CPUs which triggered
the deadlock if tracing was enabled on that path.

Best regards,
// Ludwig

 


      
