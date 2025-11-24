Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8B3299AB4;
	Mon, 24 Nov 2025 05:59:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763963954; cv=none; b=UjY9/wUHX5HsWv6Xa0ghWWeeg3I/4VuBTDb4ODfHC5pjcrqTorJMDNoPCHl9idxDMvDKuYp4yw9dY8Lsyh0y2poZBIgmFdRYvAx1jOjCyBqrC1vieZ75mS8GUfRhkjZD8DZpusdBBIcxXa3nhhlTH/+7r8Fxep41RR0xWgK9xLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763963954; c=relaxed/simple;
	bh=9Kp2XSAO7hnwd2eaJfptvyOOHPe26HdjZ6qO1Ax435Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ny+lknu1oCdKr0UndanvSENm4c/nJSatzew1tmMBubeWHxeBCusS1231W6IxTPHtU7jx3nmE3aLKZgHGfPe3vR66WVxrtiELrNTWHkJYda5faknMgSFSKmkWeIy4A4L6QYbSpOjg9hLA/UsRiEXMDTe4c+NgGLlr87n1XQQlvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S3CKN0uz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S3CKN0uz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56E03C4CEF1;
	Mon, 24 Nov 2025 05:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763963954;
	bh=9Kp2XSAO7hnwd2eaJfptvyOOHPe26HdjZ6qO1Ax435Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=S3CKN0uzZV6J6u0UpKVPBeM3gWS6VhVTR+wqE86peb2K2KDfkWCh3eVLDj1HT9cFW
	 V3rVAEL+ADV/SE8/f0p/TP9t1E4fI9fHRIHmKj0OrPqrctO7Lyyvud8n17Q6rOh6o5
	 yKZxTlxPAVMp5PIESXwekNuZYNIY7R5KHbSIIj18Xy05syoa8QThvgMhcKs0765XPL
	 3MSBGGMTzIlZYixBASmWU+vXr8stLuouAXY2l/aTQucFCu9NS++cTZjsgbBj36e4P7
	 EsJx2UJuWl81Efu+PJ5tU9b6selvp2NRvBpQPyD2bn46LsyANb3ekTqsIknnPzDHTP
	 918sxkORS9FXg==
Date: Mon, 24 Nov 2025 11:25:32 +0530
From: Naveen N Rao <naveen@kernel.org>
To: Hari Bathini <hbathini@linux.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, 
	Michael Ellerman <mpe@ellerman.id.au>, linux-trace-kernel@vger.kernel.org, 
	Mark Rutland <mark.rutland@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Masami Hiramatsu <mhiramat@kernel.org>, llvm@lists.linux.dev, Maryam Moghadas <maryammo@ca.ibm.com>
Subject: Re: [PATCH 3/3] powerpc64/ftrace: workaround clang recording GEP in
 __patchable_function_entries
Message-ID: <sjheprnafkraauotmi2fwjz6l6fha5te7jdp74t4zfh3jvs2if@vjpey276fsti>
References: <20251108210405.2375472-1-hbathini@linux.ibm.com>
 <20251108210405.2375472-4-hbathini@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251108210405.2375472-4-hbathini@linux.ibm.com>

On Sun, Nov 09, 2025 at 02:34:05AM +0530, Hari Bathini wrote:
> Support for -fpatchable-function-entry on ppc64le was added in Clang
> with [1]. However, when no prefix NOPs are specified - as is the case
> with CONFIG_PPC_FTRACE_OUT_OF_LINE - the first NOP is emitted at LEP,
> but Clang records the Global Entry Point (GEP) unlike GCC which does
> record the Local Entry Point (LEP). Issue [2] has been raised to align
> Clang's behavior with GCC. As a temporary workaround to ensure ftrace

Any reason to put in a "temporary" workaround rather than waiting for 
this to be fixed?

- Naveen

