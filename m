Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 747CA2C80;
	Fri, 17 Jan 2025 01:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737076684; cv=none; b=A5L/YXaf3f0xf6N/lNJbjZRoW+n9wv234zNXWlBdRA4yPWaHDcTosAiIVBiiDqUFNHHJXfKVakxZawgJpPjJrR1+8oGtECFhcljHbsuois7BNH5nSZGAnhs4JoN1RIIsX8sikTJuFcIAHy/HuyUCTsrHjOy6MMqPMsv+VYT9+MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737076684; c=relaxed/simple;
	bh=QOP2MhXmE6eiwtJDCGtvALdoxQ4y6vVqW7wg+bg6vtw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gTsYBq2E7zkzCp8w9DYyHcMAwrYa9XNHyVNDCgnIW8fkqZCt3A5+OG1W6iMgNmwdKv724LYZRMVE1KRzbhho5/RZuUiBf+/GvOiuCvkyCgE/YoIre0a5gcxjK+M+XW9s/ysubfKk2XJ+q0pSZJQiT6+dwYNBUwBRK91/DrRDIzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18FF0C4CED6;
	Fri, 17 Jan 2025 01:18:02 +0000 (UTC)
Date: Thu, 16 Jan 2025 20:18:08 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: Tomas Glozar <tglozar@redhat.com>
Cc: linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org, John
 Kacur <jkacur@redhat.com>, Luis Goncalves <lgoncalv@redhat.com>, Chang Yin
 <cyin@redhat.com>, Qiao Zhao <qzhao@redhat.com>
Subject: Re: [PATCH] tools/rtla: Add basic test suite
Message-ID: <20250116201808.3c8721c1@gandalf.local.home>
In-Reply-To: <20250109133852.360122-1-tglozar@redhat.com>
References: <20250109133852.360122-1-tglozar@redhat.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  9 Jan 2025 14:38:52 +0100
Tomas Glozar <tglozar@redhat.com> wrote:

> Implement a simple TAP-based test engine in bash and a few basic tests
> using it, to be used to check for bugs and regressions.
> 
> A new "check" target is added to the rtla Makefile that runs the test suite
> using the "prove" command implemented by Test::Harness.
> 
> The only test format currently supported is running rtla with defined
> command arguments per test, checking its exit code. In case the exit
> code is non-zero, the output of rtla is displayed.
> 
> The test cases are adopted from rtla tests in the Continuous Kernel
> Integration (CKI) project [1] with the authors' approval.
> 
> [1] https://gitlab.com/redhat/centos-stream/tests/kernel/kernel-tests/-/blob/main/rt-tests/us/rtla/
> 
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>

I tested this out, and it failed the last test:

make[1]: Leaving directory '/work/git/linux.git/tools/tracing/rtla'
RTLA=/work/git/linux.git/tools/tracing/rtla/rtla prove -o -f tests/
tests/hwnoise.t ... ok      
tests/osnoise.t ... ok   
tests/timerlat.t .. 9/9 
not ok 9 - hist test in nanoseconds
# 
tests/timerlat.t .. Failed 1/9 subtests 

Test Summary Report
-------------------
tests/timerlat.t (Wstat: 0 Tests: 9 Failed: 1)
  Failed test:  9
Files=3, Tests=20, 451 wallclock secs ( 0.07 usr  0.11 sys + 10.57 cusr 74.09 csys = 84.84 CPU)
Result: FAIL
make: *** [Makefile:89: check] Error 1

-- Steve
