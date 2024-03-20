Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA1239AF4
	for <linux-trace-kernel@vger.kernel.org>; Wed, 20 Mar 2024 13:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710941125; cv=none; b=JvdMW8RU5TN1R7iEf2cVWU2Oxe+1n/xt5/CbCoCTwSwIu6mboyhxxWhU4ZzjBWu+u/xi2U3YPIQuLZLVgjikE2xY3atO4RKxZecrVHJExhreRqixBS8+aXQo4rjHWc8zZ2Z5YhKSEcTkFC0TypPYsp7KIedKhr2I/HNLX9Pou1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710941125; c=relaxed/simple;
	bh=YxN8jJyUaSRiib14DJDP1DaCrMUjkGHwBnml+IUdXiw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Dejm7YrPblMPpfy4WIaaUlMmH8Yj2Fkffj7CSkshbgfwlVPj835y14rJk2sV+IQiqdVDasHcVImHdJRI+9xwCqcYD1nmrjlp/ycrnxo35BKkZjgZhqLROkQbjI/HN6FOIxC1khoSxMjaI8bIvPg1laiURzjt57EQpNZAt86iKFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CE51C433C7;
	Wed, 20 Mar 2024 13:25:24 +0000 (UTC)
Date: Wed, 20 Mar 2024 09:27:49 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing: probes: Fix to zero initialize a local
 variable
Message-ID: <20240320092749.58997fea@gandalf.local.home>
In-Reply-To: <171092223833.237219.17304490075697026697.stgit@devnote2>
References: <b010488e-68aa-407c-add0-3e059254aaa0@moroto.mountain>
	<171092223833.237219.17304490075697026697.stgit@devnote2>
X-Mailer: Claws Mail 3.19.1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 20 Mar 2024 17:10:38 +0900
"Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:

> From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Fix to initialize 'val' local variable with zero.
> Dan reported that Smatch static code checker reports an error that a local
> 'val' variable needs to be initialized. Actually, the 'val' is expected to
> be initialized by FETCH_OP_ARG in the same loop, but it is not obvious. So
> initialize it with zero.

BTW, that loop should really have a comment stating that FETCH_OP_ARG is
expected to happen before FETCH_OP_ST_EDATA.

-- Steve
