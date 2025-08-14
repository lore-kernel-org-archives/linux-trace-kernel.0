Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEDBB2FF658;
	Thu, 14 Aug 2025 02:45:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755139540; cv=none; b=Xb5kAchMt/QQ1+pyxWBrbQ0tvvZR/liRzoPi61CQX1Z2PbaAis3WcXtKHWWK38EMuLmDPFDnTGsPJ9S1Yb5r0TMa83yrHglWX4M4nm7iCmuYvs8zPtAoLl1fPdLXIobDAgeRYvqLmzbQWJYJK8EQtsq5ORAxjoRkm+MMob8cjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755139540; c=relaxed/simple;
	bh=cylJVHW+1KjnMWOmh5ZJFJida/FE88+MrKIpEFEGbEI=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=CajRonJPiPZkRiwQEojr/a84TPbdgNj4Yd2/3+5Xt9DjDInNQJnGUgwpKUf8n1pANpUhed8u2Fh+ZfVHT254WlIB1tqdbysrAwpgSw4i6Kvy0J6gyHjMsWSjTusT3I4PF+k7EnnLc1yq5JbvwljN0jCcERKRaeJ3cenqh/bjHsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ffEMm01r; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ffEMm01r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A309C4CEEB;
	Thu, 14 Aug 2025 02:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1755139539;
	bh=cylJVHW+1KjnMWOmh5ZJFJida/FE88+MrKIpEFEGbEI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=ffEMm01rmKNRK6ijpitPRdPaS4ips9kTQq3QzPVhMxPkpwWrKRvGACn/mApqZRX/v
	 PpAL+EqqkxO3JTBluvBbpn7j/UtqpZs8Uucyx3Y1MEI+wNzXPXK7N5hISDYYAs3JvK
	 4V2JetbfkBOTkUDIohRULfm53XS/BddYvzQdSi4o+ePBsFpt5FenvQpzFaitxm4Zqx
	 4TbSUMsPWLUFTFpr+aOiCpYHDakUIJMH+/L2UmyyPVTfD7Mmlv6U7CjCG2rGySWMFh
	 AQkG/5ilwOHUUg0tn4LwnNhFwFnxd7wCHK0zvxvbquKhTfGe5wqP/ERI/YaoQKCHO2
	 /yigrAt/c0HMw==
Date: Thu, 14 Aug 2025 11:45:35 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, linux-kernel@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 linux-trace-kernel@vger.kernel.org, Naveen N Rao <naveen@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Remove bouncing kprobes maintainer
Message-Id: <20250814114535.a9ee927aa232731d4b9c63d5@kernel.org>
In-Reply-To: <4f2f7e26-561e-483a-bc67-0cc29549b866@intel.com>
References: <20250808180124.7DDE2ECD@davehans-spike.ostc.intel.com>
	<20250811155352.45ee7061226f3e85aeda54b7@kernel.org>
	<4f2f7e26-561e-483a-bc67-0cc29549b866@intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Aug 2025 06:49:38 -0700
Dave Hansen <dave.hansen@intel.com> wrote:

> On 8/10/25 23:53, Masami Hiramatsu (Google) wrote:
> >> The kprobes MAINTAINERS entry includes anil.s.keshavamurthy@intel.com.
> >> That address is bouncing. Remove it.
> >>
> >> This still leaves three other listed maintainers.
> > OK, should this be an urgent commit?
> 
> It's not urgent in that it's obviously not breaking anything.
> 
> But if it was in code I maintain, I'd probably send it up to Linus to
> apply in the next -rc kernel instead of waiting for the next merge window.

OK, let's send it to Linus, thanks!

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
