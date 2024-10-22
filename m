Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 190CB152160;
	Tue, 22 Oct 2024 07:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729583712; cv=none; b=hcvWZhqUY2zvMNRPL9Ny5Cn4e5nlOH2TNZ5xdwNHieRmw2Y3rixohgC6TJl/pzgRywr+eAHauaqitGlA9hCMyAZof0ZIfufhaQMFj4YP3JxR54v1W24f/GGU0AhRvh0GTI+HoztY9bIGqEhDUE2VzaeD/wolN5vtJfOJZweILnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729583712; c=relaxed/simple;
	bh=BjsPA+aQ5BMIz8Adp0aSjoD8Vf5MfZ+sGFj9AOlim0Y=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=ML87sRtjYlWOayRW/FErsurR6EC05kD1uOmwS11WQm0ZTep8bquzwdwLX9BKD11CSLtNO6NZSemRrHMzPz2xawJr8qNE+UEIo8EGHYrf0nOhsbejUIX2kJhk5BbiufuUOxN+ywrrvtpT5h6t7ORQPsY+rAiyDGEdqFabOf+iCG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gtoTJ1u4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gtoTJ1u4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D48C4CEC3;
	Tue, 22 Oct 2024 07:55:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729583712;
	bh=BjsPA+aQ5BMIz8Adp0aSjoD8Vf5MfZ+sGFj9AOlim0Y=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=gtoTJ1u4lits1ls+5xFOWRkkGVHSswmKyV72U5KqKU6LU+l2Vz/xVD1BRzAFgWxtA
	 Zu4VAyp40P2Wswl3jt/VlfTcpD1GHwZZbEaQOYBTdwTaXols+Fu2gTWEpDjDEQmAzM
	 jt5qs9XXr78tEzYaW+KFzqed5a124l3wURgoNyhSCiojtouIsaHQImq/zRoHiJItqe
	 DmUC6pAjvOSsRFhlUOiSrphxpRZ+YXZOAftuzCIFeHbcqygte6FFkz9xy8nYsjBK0G
	 6lbHt3I/3okJWO/lwyh6LLqRkYu6xN2vSUd8FNn+FAYXCYFHr+mMgVewzgz1TXX6zy
	 Lyg1QvxdvrQMg==
Date: Tue, 22 Oct 2024 16:55:08 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Mikel Rychliski <mikel@mikelr.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, Mathieu Desnoyers
 <mathieu.desnoyers@efficios.com>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v2] tracing/probes: Fix MAX_TRACE_ARGS limit handling
Message-Id: <20241022165508.7d23d7f0f557a43127962c91@kernel.org>
In-Reply-To: <5391163.OV4Wx5bFTl@basin>
References: <20241001004050.972e999c644d0e45fd2a94f8@kernel.org>
	<20240930202656.292869-1-mikel@mikelr.com>
	<5391163.OV4Wx5bFTl@basin>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi Mikel,

On Mon, 21 Oct 2024 23:14:54 -0400
Mikel Rychliski <mikel@mikelr.com> wrote:

> On Monday, September 30, 2024 4:26:54 P.M. EDT Mikel Rychliski wrote:
> > V1 -> V2: Return error instead of dropping excessive arguments
> 
> Hi Masami,
> 
> Thanks for the feedback so far. Was wondering if you had a chance to look at 
> the updated patch?

 Yes, let me check it.

Thank you,

> 
> Thanks,
> Mikel
> 
> 


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
