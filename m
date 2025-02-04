Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E91620C47D;
	Tue,  4 Feb 2025 11:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668981; cv=none; b=OogNBhJfGms6NwlwzdnfFtUchBCF7sc4uA57+HKpqxYzoLrw7G5IGGjvpUzhKuaBMxWUZNJWYsdStjdJnrxLiy2CEROkLb7zrpcIrnGjofT0/Y3UEa8OwfAWcRq4HszGZNfYnADeCFP7TFRmlWS9fJFsahuTylhdKCIfYjzcCQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668981; c=relaxed/simple;
	bh=9X+tis0IwLqTIYnFzk4iTIu76qprOrfcQ9DCye4RlTA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NpFLYv/BGQJrwa7mbWfxhg05dWFj2R3N063TR1I6x7hz1YFAkUM8U6TTy55tW4IuRXROm1Me3kVh5HBY1DBB65zK8FPyAFZZSwXu82+Fj+zww/pTAlGFreHAsWD4dq+b1PbcbIAyM1Km2tK8V7kdpV6HzM2kFwthio8pO0oIJ40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mDFnnhgZ; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mDFnnhgZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BE6C4CEDF;
	Tue,  4 Feb 2025 11:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738668980;
	bh=9X+tis0IwLqTIYnFzk4iTIu76qprOrfcQ9DCye4RlTA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mDFnnhgZRME/U/EMXm/1x66WeaCmeSdJnJ6v/b7LyiLQffZ9w3y+huilybV2nktIY
	 dZ5kyDcHFThD5AYT171tSX/hcrIK2jcHGX4+YNmpu5e1MGV7wc9VFG3zo/aMxKTE5E
	 g8LeZvnFa7hcSOpd9S56sIw6FYD/y2d/4Ppas6SVD69JfrWn+HsF0km8nCz35aYrFW
	 GZ+niiNCBje6ffC9/SU/gNR8g3DUFj/MJ9hV1Wmp7jk4WDCshab49oEvR0u57Egi2x
	 PfpyeVuWy1I+J3xKZsdEUEHEseRvKPYJdZT8fb1VYweOn6eE5eriNkZ642woM0pgHM
	 kA5ptUCOzGx+g==
Date: Tue, 4 Feb 2025 11:36:15 +0000
From: Will Deacon <will@kernel.org>
To: Lukas Bulwahn <lbulwahn@redhat.com>
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	linux-trace-kernel@vger.kernel.org,
	Catalin Marinas <catalin.marinas@arm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	linux-arm-kernel@lists.infradead.org,
	kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
	Lukas Bulwahn <lukas.bulwahn@redhat.com>
Subject: Re: [PATCH] arm64: Kconfig: Remove selecting replaced
 HAVE_FUNCTION_GRAPH_RETVAL
Message-ID: <20250204113614.GD893@willie-the-truck>
References: <20250117125522.99071-1-lukas.bulwahn@redhat.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250117125522.99071-1-lukas.bulwahn@redhat.com>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Fri, Jan 17, 2025 at 07:55:22AM -0500, Lukas Bulwahn wrote:
> From: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> 
> Commit a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
> replaces the config HAVE_FUNCTION_GRAPH_RETVAL with the config
> HAVE_FUNCTION_GRAPH_FREGS, and it replaces all the select commands in the
> various architecture Kconfig files. In the arm64 architecture, the commit
> adds the 'select HAVE_FUNCTION_GRAPH_FREGS', but misses to remove the
> 'select HAVE_FUNCTION_GRAPH_RETVAL', i.e., the select on the replaced
> config.
> 
> Remove selecting the replaced config. No functional change, just cleanup.
> 
> Fixes: a3ed4157b7d8 ("fgraph: Replace fgraph_ret_regs with ftrace_regs")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@redhat.com>
> ---
>  arch/arm64/Kconfig | 1 -
>  1 file changed, 1 deletion(-)

Hmm. There are still a couple of CONFIG_HAVE_FUNCTION_GRAPH_RETVAL guards
kicking around:

include/linux/ftrace.h:#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL
kernel/trace/fgraph.c:#ifdef CONFIG_HAVE_FUNCTION_GRAPH_RETVAL

so it's not clear we can just remove the option from arm64 without
breaking ftrace_return_to_handler(). What am I missing?

Will
