Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786491373;
	Thu,  6 Jun 2024 02:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717640222; cv=none; b=Ay8n25dJRvE5KWR65xkQ+5jlYeM0E73KWTPkUs4M/aPn/c8XYV/3qAVUuLN1zOfePi3YrGSPaLh8qLs19UxDL/DFEdG+HL4pRwOQ72radkYVURmDuu5+lOjiZxNC79/rDqIqtwXeqqzeAAeGBbmkB07+CDG3EO2zlMfK8um7uRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717640222; c=relaxed/simple;
	bh=GhFX5sAFqS91Z0nJhCa8ZmNvN3UWYucQ57knZtq6lzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hWwvMZDl6c7nmkEeT0Hivi+OPiEaUv2qdTBJJf6E+x13G+UczOeWhMG1h6VI/Euk9+0vMb6kLXGWGjzziBePyBiASJ8ViYm6DUZfwdPEfdyzpWjuB4bbOTZ30uAajI/C52yFmIa2q47J78ZkmbJXM+p1iHmM8FSF9mER9bJFP9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 285D5C2BD11;
	Thu,  6 Jun 2024 02:17:01 +0000 (UTC)
Date: Wed, 5 Jun 2024 22:17:04 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Cc: mhiramat@kernel.org, mark.rutland@arm.com,
 mathieu.desnoyers@efficios.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] fgraph: Remove some unused functions
Message-ID: <20240605221704.2e0c8ec8@gandalf.local.home>
In-Reply-To: <20240606021053.27783-1-jiapeng.chong@linux.alibaba.com>
References: <20240606021053.27783-1-jiapeng.chong@linux.alibaba.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  6 Jun 2024 10:10:53 +0800
Jiapeng Chong <jiapeng.chong@linux.alibaba.com> wrote:

> These functions are defined in the fgraph.c file, but not
> called elsewhere, so delete these unused functions.
> 
> kernel/trace/fgraph.c:273:1: warning: unused function 'set_bitmap_bits'.
> kernel/trace/fgraph.c:259:19: warning: unused function 'get_fgraph_type'.
> 

Thanks, these are leftovers from the rewrite.

-- Steve
