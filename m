Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436CE1EABC4;
	Mon, 21 Oct 2024 14:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729519286; cv=none; b=SpzLJPoZggwM9RIm3rGmjtJ/jkfXP2zTSeFhe2ShV9/UaXaIdbk47RjYLcBV3wLhkj6Avu2xjGYFUzfps/QHQILZ2kC3BwnjVK4URlLy+ZV73EXpq6NKSYZONxSxaNp/D8Q0cNIt3+PxBRUDP45FTUCmifJHotXKcpzOkAMF1g8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729519286; c=relaxed/simple;
	bh=FnatMlsWR8HNVRvD27PQukDVaOYbEhYZxP9yRQAEeiM=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=iYKUlWpXMBbUTUq4IhOqqemYVgX0Df7OIkWd8aeFgtNEjjz4rs3QnC+08KTlEZakvhYE7LaWVW3sczzliPReYmtE5ypY+hB1COddAwnaXhl3aF18vblWYJzsuqEkohJFahxh09W8i9hdElPm8B5/Twfh/rqi55LPVVmD1Y05qFY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L/qUsyH2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L/qUsyH2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70FC7C4CEC3;
	Mon, 21 Oct 2024 14:01:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729519285;
	bh=FnatMlsWR8HNVRvD27PQukDVaOYbEhYZxP9yRQAEeiM=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=L/qUsyH2EJpc48hNSUv+N7ygmzYckvdEGROuSPAxfADw7yTg1u0AKLcHMMlR6hSP6
	 Yyomk7CL+L7aSFMn49J7hm5OHTg74PO0NHzx32auKXbGoao8znEsCkQaTT4xN2d3py
	 QD7H2nabyDkPFzFlN9WcPc3ZHj92e/uE5ES0HqpDNwNg4Kzy2R/XXDinBnZiZORHsq
	 sn2qNOwEYWbk0KbGIBroq0itVylb2MYYyTUkgTsloBGe8EEhYvnRHK+LjHXzMLcRWU
	 +R7ccjtN1SLKGUR0aKFf08NAe8L5+stP6jWsixcbdh8DH/3Yee0cY+ICdqMnz3enY+
	 us7m9vfVwfg+w==
Date: Mon, 21 Oct 2024 23:01:21 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: <naveen@kernel.org>, <anil.s.keshavamurthy@intel.com>,
 <davem@davemloft.net>, <kees@kernel.org>, <gustavoars@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <linux-hardening@vger.kernel.org>
Subject: Re: [PATCH 0/3] kprobes: Annotate structs with __counted_by()
Message-Id: <20241021230121.a5a6c2f746d3141d9640c483@kernel.org>
In-Reply-To: <20240813115334.3922580-1-ruanjinjie@huawei.com>
References: <20240813115334.3922580-1-ruanjinjie@huawei.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 13 Aug 2024 19:53:31 +0800
Jinjie Ruan <ruanjinjie@huawei.com> wrote:

> Annotate structs with __counted_by() for kprobe and do some cleanup.
> 
> Jinjie Ruan (3):
>   kprobes: Annotate structs with __counted_by()
>   kprobes: Cleanup the config comment
>   kprobes: Cleanup collect_one_slot() and __disable_kprobe()
> 
>  kernel/kprobes.c | 87 ++++++++++++++++++++++++------------------------
>  1 file changed, 44 insertions(+), 43 deletions(-)

This series looks good to me.

Thanks for cleaning up!

> 
> -- 
> 2.34.1
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
