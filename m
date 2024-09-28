Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2FBDF9E8;
	Sat, 28 Sep 2024 00:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727482679; cv=none; b=cEAzH/FwYyA/2HiZlMwwhBiqq0Em7ZrjVXKMAOL6M5WuJo7Bx6QhhBt2ji4J/6BcKVCtsnU+savuz8KMCdbEKEimiBnMJgWjM9YrVNvfTC9veZSGQZ+mQUtQpuRsvDh1YZQdDvHjEzItEvquAgPCnk4V+wCw+N9an434XOouHV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727482679; c=relaxed/simple;
	bh=zurLLRn4Ari54Wawnuv0F4Oi02USadk8lwG5rf57RYc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=m/YY070HOpk2wpu1jiyAb2YNJgwGMJyKlUt6nYL5YhqgNxRCHNlKEs1oV1xsYeYN6OMl4TJAGv70q3O3MXXyJwCMOYyMByIA1vPBgyuL+wLyfr2lxpKKHIBs6hBVw4WH6eh9MvW+VDHeawvfpIzqDOUsFrqVYJayUoLhPJgzstQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E260AC4CEC4;
	Sat, 28 Sep 2024 00:17:57 +0000 (UTC)
Date: Fri, 27 Sep 2024 20:17:55 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Liao Chang <liaochang1@huawei.com>
Cc: <mhiramat@kernel.org>, <mark.rutland@arm.com>,
 <mathieu.desnoyers@efficios.com>, <linux-kernel@vger.kernel.org>,
 <linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH] function_graph: Simplify the initialization of fgraph
 LRU data
Message-ID: <20240927201755.6402ed04@rorschach.local.home>
In-Reply-To: <20240912111550.1752115-1-liaochang1@huawei.com>
References: <20240912111550.1752115-1-liaochang1@huawei.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 12 Sep 2024 11:15:50 +0000
Liao Chang <liaochang1@huawei.com> wrote:

> This patch uses [first ... last] = value to initialize fgraph_array[].
> And it declares all the callbacks in fgraph_stub as static, as they are
> not called from external code.

This patch doesn't look like a simplification, and it is incorrect
about the "not called from external code" as the kernel test robot
pointed out!

-- Steve
