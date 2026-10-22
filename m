Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792678258;
	b=uhIlm63ICvxbf4DFoNF1t1gvdHrA4SSf70LTRCIG6R2sdT8QYBfpYv5l+K2RP4H+4FO9
	 H3zEaou+ca3PZbIIoHA1XH3mY0YqC2HFw9qt7zTxbR4CGZep3QKKIwulNs9YjmGMfluL2
	 ZwbQfJIXL8SM1uhpjp4Ybo5B5MFjCraS9a0diMXTfK9+z7KKKiR/wZL/+wdrt65Ildlvr
	 7VnJSvhDkd2un7MHSolJLZ+KaC04JIt9Z+pWj7DT+wZMx5fNqcdVpPG8S51OZc+KtEHDZ
	 h2pOOBXUiGNIh1dMu4AHCWmRhCJZFruHWQsEWR00NvbRzAyW9axxiw3F6jMSTmCriCw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792678258;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Date:From:To:Cc:
	 Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To;
	bh=eL+nmcMxRsS6AOTK0SPbTkyP49rPp8BnJtqvGgJcLa0=;
	b=NpSHIMQyuV/hDx4ZLg/o5j4lQARFF336psEVihwcspuGN+GguMw2gdgAIB/fpfIredo5
	 gJPSKmhs1oVWAIWAWMYFPl2pbjbEuKpr9gHRQFE7IZvn2VgTYu1Hj9x4zjE21lPPbEYTC
	 g7OjVAIbIJqExmRuwDUO3IEsEpvrDKrHEFhNge4ysDCM0Asl8mIj5IgsUgbMjHrgq837f
	 +lAWmwXQBM1b2as8w/fq1x/bmjKtpb9KpiQcCo5tqBuZjgJCIdvCgn3h8vkFKbaPCY7HF
	 dJyW3xeNoXaTJEUNBUf0OWpuWrNxa5Zyp2SVSWcVlWL6HQkV17I3Gj+OSboQo6HWUmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=urBJj69Y;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B9E5606A320
	for <linux-trace-kernel@vger.kernel.org>; Thu, 22 Oct 2026 14:10:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9B9E5606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=urBJj69Y
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6D5F8176C;
	Thu, 22 Oct 2026 07:10:53 -0700 (PDT)
Received: from arm.com (usa-sjc-mx-foss1.foss.arm.com [172.31.20.19])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A7DBD3F7B4;
	Thu, 22 Oct 2026 07:10:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1792678256; bh=wH9gw2k9UvooAv1wu0799nglVjPFLWmkWBHuhQO9Jec=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=urBJj69Yp6lGnxGKB4Hi6ilePzOgR9izKCqmgwdF8rg7LC2OXSKrNZ0Lxi3Jmqry7
	 ywHq87whWabaMU4wqmcZQZEJPPhEAolUJugsWFN3whQQ5sLl9f+u24WNLkM5WPb93U
	 ea6KZMfRVIsNVYD8bK0mgx4qAR0Z9eZMQH5E/Fd0=
Date: Thu, 22 Oct 2026 15:10:52 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: 3791971891 <3791971891@qq.com>,
	linux-trace-kernel <linux-trace-kernel@vger.kernel.org>,
	chenhuacai <chenhuacai@kernel.org>, will <will@kernel.org>,
	"paul.walmsley" <paul.walmsley@sifive.com>,
	palmer <palmer@dabbelt.com>
Subject: Re: [PATCH v1] rethook: Fix percpu base register corruption across
 CPU migration in trampoline
Message-ID: <atoZbA-4rQqShHwH@arm.com>
References: <tencent_ECF9EB2561DF6C83A6A037AB5A4EF02B0107@qq.com>
 <undine-1792677817434077051-0a900721b6323094@undined.local>
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Post: <mailto:linux-trace-kernel@vger.kernel.org>
List-Help: <mailto:linux-trace-kernel+help@vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-trace-kernel+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <undine-1792677817434077051-0a900721b6323094@undined.local>

On Thu, Oct 22, 2026 at 11:03:37PM +0900, Masami Hiramatsu wrote:
> At least, you must use your real name for sending a patch.
> Please read Documentation/process/submitting-patches.rst.

Likely some bot attempting random fixes from memory (not actual tree)
and sending html.

-- 
Catalin
