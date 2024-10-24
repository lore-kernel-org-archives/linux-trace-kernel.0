Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5777012CD96;
	Thu, 24 Oct 2024 04:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729745189; cv=none; b=qdkPPi10R/5mMvzoHT9uRA2jzrpAQZMb8/tJoB+SAGKRmI5gkeHP8HF8QR3FGroF/z1eEGS2LSHh2dkse9RZH1c4Zb+4gCCjzSCkkPkpPwWX2ea5bKtq75cb23p4jc0P1R7iDVC9hVtxVmzqJAmWPPJW+DsWdqU5ZxNKHB8sJK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729745189; c=relaxed/simple;
	bh=WatqNneF6hi9L3fF4EmkhGUgnoeTAD/Ss50OZY2lTF0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IRfoGvvhuep+MhyiBQ2KShXf5nUN2NWlX1669xly/1+12liAlaJ7xsgzQMl3cViHxMcB0CZO7bJ+ByLs7uuHyw03lbRQtUH87+QwdiDMJ1pYRmdVeitTOP7BYdbnm4u0q1nK3XnRhZiDvOt8W+U5Y829IEuhn5DJDfVnLq4RQcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB4BAC4CEC7;
	Thu, 24 Oct 2024 04:46:27 +0000 (UTC)
Date: Thu, 24 Oct 2024 00:46:24 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Li Huafei <lihuafei1@huawei.com>
Cc: <dan.carpenter@linaro.org>, <mhiramat@kernel.org>,
 <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 <oe-kbuild@lists.linux.dev>, <lkp@intel.com>
Subject: Re: [PATCH] fgraph: Fix missing unlock in register_ftrace_graph()
Message-ID: <20241024004624.3b574af2@rorschach.local.home>
In-Reply-To: <49d1672e-71e2-dc87-1fb3-cde430e0339f@huawei.com>
References: <20241023170448.808512-1-lihuafei1@huawei.com>
	<20241023052948.0285eb2c@rorschach.local.home>
	<49d1672e-71e2-dc87-1fb3-cde430e0339f@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 24 Oct 2024 10:45:46 +0800
Li Huafei <lihuafei1@huawei.com> wrote:

> Agreed, this will make the code simpler and avoid mistakes. If we need
> to replace all mutex(&ftrace_lock), would it be better to submit another
> cleanup patch? We can fix the issue here first.

This case is a bug fix, just add it here.

We can do a clean up separately for the other locations.

-- Steve
