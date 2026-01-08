Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4172022576E;
	Thu,  8 Jan 2026 16:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767888558; cv=none; b=gTIP125XkWBW+VkK7/OXMVULXQjlwILh+LUrndlVp2viaw5bU8MJiXK5g0aUF2XiqES7In7UCzbU6v5uj+GB3G70QNF7O5q6d/UVccodgUoXyPdjOrMFWx85yJXI+GhkYNNZDUh5//FfsZN2SSS5M8lGEMm2nywwKncuzKU0pBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767888558; c=relaxed/simple;
	bh=msr2t2l+9ukvH2irNjs7HLbeF+vRgO7y/8MyvMPNwpY=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=WOW7CnFsrqVdzwE+We/sLf2fEQdc5Bd0fOsAU6RoehyZsldHKBQstI76X3Fxbi4fSz9tBzyGjiq75CdQXTQ41GS07mqr3EVxaQzD0jgzrzqClZJEC4hMqUPkdwUga4/6XnKW9a2P1g8ILl1DGc/hLGwI+yMVluhIeiJ09Qxi8NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUWYeBTN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUWYeBTN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AC1EC116C6;
	Thu,  8 Jan 2026 16:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767888557;
	bh=msr2t2l+9ukvH2irNjs7HLbeF+vRgO7y/8MyvMPNwpY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=QUWYeBTNVDC1jxwAiSgYz6+1MqvirRKKz5fSaEsO/IyguhYasjurmQxQn7s0iLLhs
	 KB6CigfuoK1xPsOf2/f64a5JzCveCl3Cm6UZNWr7Y3Dly9AOgAByza2UoVne55iYdy
	 0j7lAObVMetJ7L7zvtmut983VOaSOFvEPgibIByshnmWQL7v2ml20xllGIRje221hh
	 t8U/86/0krhwdRjL/TPxsMUEWZ8MEkgxA3OK7uzgfz61jbgI/oB3ERv0Vi6YlVVTFo
	 9njK/fd3yBozGBxNDVjk1ZRVnis8n0ocPm8saI14vZiWJkw9x08NdVXwLYeA1yZuJu
	 6WtUT9dWM5WbQ==
Date: Thu, 8 Jan 2026 10:09:16 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Documentation <linux-doc@vger.kernel.org>,
	Linux Kernel Tracing <linux-trace-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuai Xue <xueshuai@linux.alibaba.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>,
	Swaraj Gaikwad <swarajgaikwad1925@gmail.com>
Subject: Re: [PATCH 0/2] PCI tracepoint documentation fixes
Message-ID: <20260108160916.GA485396@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260108013956.14351-1-bagasdotme@gmail.com>

On Thu, Jan 08, 2026 at 08:39:54AM +0700, Bagas Sanjaya wrote:
> Hi,
> 
> Here are two fixes for htmldocs warnings on PCI tracepoint docs as reported in
> linux-next [1]. The shortlog below should be self-explanatory.
> 
> Enjoy!
> 
> [1]: https://lore.kernel.org/linux-next/20260105160000.0368ec8d@canb.auug.org.au/
> 
> Bagas Sanjaya (2):
>   Documentation: tracing: Add toctree entry for PCI tracepoint
>   Documentation: tracing: Wrap PCI tracepoint examples
> 
>  Documentation/trace/events-pci.rst | 4 ++--
>  Documentation/trace/index.rst      | 1 +
>  2 files changed, 3 insertions(+), 2 deletions(-)

These are for the pci/trace branch, which has not been merged into
mainline yet, so I squashed these fixes into the "Documentation:
tracing: Add PCI tracepoint documentation" patch on that branch.

Thanks!

Bjorn
