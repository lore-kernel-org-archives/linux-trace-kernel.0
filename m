Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B9429CDD;
	Thu, 16 Jul 2026 13:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784208262; cv=none; b=ONq29bZ5WRpQFnRfBVXBjCAaJoJpkeeeBg0fzbEz7uxZBN6yClXWVIVv8cM9wPw4FmtHZs9Qypqa5VWtwDchHeSjefRKeXGGcqi1nN7tmXtFxjnXluC+9bIoiLxlO/J7PLDlJuSME4l2sGvJRm46LAqsAWOxuzWFzdLjxEC8w4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784208262; c=relaxed/simple;
	bh=W9EsE9F2BjLh9oxv08i2aA5THwluUzeMtjMrevk0Rj8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ndn4t7vNz2hrq0j4BGge+nF0T1qDaXUstVzNdHfy9YrNZaTba8rwWnzndMp96DrXq3HQnuRfQZA96KIdqrkwY45OUx0SH9SOvGGc9TvopLLOTY0y1T8K740iMHRAAITfuKDbnBcdy6xr4kNJji6hve8DyEhbFpxPRC3pHCC7Un8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H76DTIww; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H76DTIww"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1AE41F00A3E;
	Thu, 16 Jul 2026 13:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784208261;
	bh=pviMfnX/HUaOmx/ovGW50P9j3K4uudlc7YTeokSyPvE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=H76DTIwwU8Z72uPRHja7ie2zD8snRxH7/gCNKaWMv6sk/6GsfZoYKdczqoJhsLPGt
	 pwV03mBycS61lRZn9ovWs8wXMGJs55CECUzKcSeRqdPaALEVbn7LLXluCitQeQcNPb
	 zywiB/k0km18wCd1EW6LUYZpjOo26guc22ctDzakcYhztOQr6BjaHmch6x4bc7/aad
	 7Qvtdyewx4crUQqOHjjgqCw6DMYPJLC8jcxFpw8knR20bh+fsHunXCBvLANptTrLuS
	 M5bn65A8Jm1JHboMxIKZo3r37oAxYXi4WpnsnDHmVCdcRQL2gCNwmlS4xdcjBo35eY
	 tz8YLt8kD4U3A==
Date: Thu, 16 Jul 2026 14:24:15 +0100
From: Will Deacon <will@kernel.org>
To: Pu Hu <hupu@transsion.com>
Cc: "mhiramat@kernel.org" <mhiramat@kernel.org>,
	"ada.coupriediaz@arm.com" <ada.coupriediaz@arm.com>,
	"catalin.marinas@arm.com" <catalin.marinas@arm.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	Hongyan Xia <hongyan.xia@transsion.com>,
	Jiazi Li <jiazi.li@transsion.com>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-trace-kernel@vger.kernel.org" <linux-trace-kernel@vger.kernel.org>,
	"naveen@kernel.org" <naveen@kernel.org>,
	"yang@os.amperecomputing.com" <yang@os.amperecomputing.com>
Subject: Re: [RFC v3 2/2] arm64: kprobes: Allow reentering kprobes while
 single-stepping
Message-ID: <aljbf_RmOd9U2KDT@willie-the-truck>
References: <20260710063242.228714-1-hupu@transsion.com>
 <20260710063242.228714-3-hupu@transsion.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710063242.228714-3-hupu@transsion.com>

On Fri, Jul 10, 2026 at 06:32:55AM +0000, Pu Hu wrote:
> From: Pu Hu <hupu@transsion.com>
> 
> A kprobe can be hit while another kprobe is in KPROBE_HIT_SS state. This
> can happen when tracing or perf code runs from the debug exception path
> while the first kprobe is preparing or executing its out-of-line
> single-step instruction.

I don't understand this part. The single-step runs with debug exceptions
disabled (kprobes_save_local_irqflag() sets PSTATE.D) so how do we end
up taking one?

Will
