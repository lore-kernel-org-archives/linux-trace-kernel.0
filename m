Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6359D307492
	for <linux-trace-kernel@vger.kernel.org>; Fri, 10 Jul 2026 14:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783692449; cv=none; b=ZRDrn0ILvnEDhHNZPznfpY8tr9ZWvtlA8+1MJv/QB1gNNr01vwV7t4vJr0gN6kirJfeqDqMu7trD5H/2q6rhsbCk+9odbwzST639tGKo9NQbxaFd/smbnPDBk1gzPC0Pm8UkmuiMaG9c2vZxu2F72NaXpTrMPZvTWjQ0SePTnqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783692449; c=relaxed/simple;
	bh=9d6Zjt5w5C2CNQYkhidrtw/dAxt22triOgxrmsVLcQY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=t2u7DzSM0zSU8tGDBzP2C+8vK0rAXjLVu+PD01mj5zAUUTULflWPViwVo1AlpXxcfzs/vl8mvC/MNwX43aGyoN9Q837XPhbilUjzbVsbsHe+sazBnabnjEYr0Ra1HWoTWoPPyz9BuexCa+I1QFeTgL5ZfnwNCUtwuK3TXFb2A40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aIOb/cXr; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aIOb/cXr"
Date: Fri, 10 Jul 2026 14:07:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1783692436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=9d6Zjt5w5C2CNQYkhidrtw/dAxt22triOgxrmsVLcQY=;
	b=aIOb/cXr5hIM9ODlojpy30vTWNZVMRgLwlvEBiEEG0TBXmAiEd4kKMu+ReoeGUbqh+k/pA
	eqLpT6X1h+pwoGgPkcGBRJTa1SMttpZHWHtf4bGGdpJS+Zsdh3yjyQDxsW+6WOoybHNXlS
	UrHSTfIkWGrozAzPLX7gbuE5FGzLmGQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: "Jose Fernandez (Anthropic)" <jose.fernandez@linux.dev>
To: Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, 
	Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>, 
	Puranjay Mohan <puranjay@kernel.org>, Clayton Craft <clayton@craftyguy.net>, 
	Xu Kuohai <xukuohai@huaweicloud.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, llvm@lists.linux.dev, bpf@vger.kernel.org, 
	Florent Revest <revest@chromium.org>, Xu Kuohai <xukuohai@huawei.com>, Ben Cressey <ben@cressey.dev>
Subject: Re: [PATCH 0/2] arm64: ftrace: support DIRECT_CALLS without CALL_OPS
Message-ID: <alD7Rr659mGVznQp@linux.dev>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260609-arm64-ftrace-direct-calls-v1-0-4a46f266697f@linux.dev>
X-Migadu-Flow: FLOW_OUT

Hi all,

Just a gentle ping on this series. It has Reviewed-by from Puranjay
Mohan, Acked-by from Xu Kuohai on both patches, and Tested-by from
Clayton Craft and Nathan Chancellor, with no outstanding comments since
Jun 11.

Could you please consider picking this up for the next cycle?

Thanks,
Jose
