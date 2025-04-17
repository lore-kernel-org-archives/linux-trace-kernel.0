Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE741C63;
	Thu, 17 Apr 2025 20:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744921978; cv=none; b=YMHV/b+rbq4ZxZY2lPtBLl3dHIBYvHetTDqb1ndwInWUWx+h6wk0YLvUC45ZNMcx0lR+1ajbJv6XkDODuAoi5PU1OOTqXjBGFpNXAYFQ8ys5K37pVQmaATz7kiqF+lLVnrDSUt3f1aAWf9hhzUizjbC/C0gtf/JY5DI7m2yFdPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744921978; c=relaxed/simple;
	bh=m23KjCoPEHiG9Nh0xssttmwcgzej8sTFwc5KLi6yrMo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cwDC6rlH/i+z/kQLOVaas+I+hQqZaVAJ4HEkbwJNEhj/1YPvA5Uo456mVRR41kqomMwfNq/sHK4Pcj3Nt6fa+FCHShXzCRz22GZ4EMJ10pPCxm3Iy3F/Y704rVTG3u9waoiOTFbt5FI65WRfNlYXtm6D+CCrs2ocg2WgoyKhtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A90AC4CEE4;
	Thu, 17 Apr 2025 20:32:57 +0000 (UTC)
Date: Thu, 17 Apr 2025 16:34:36 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Junxuan Liao <ljx@cs.wisc.edu>
Cc: Frederic Weisbecker <frederic@kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Subject: Re: Interface for enabling context tracking
Message-ID: <20250417163436.599e50a1@gandalf.local.home>
In-Reply-To: <3ce02a98-0ac2-4d34-b6f7-ba85088399d7@cs.wisc.edu>
References: <9e2ac1e3-d07d-4f17-970e-6b7a5248a5bb@cs.wisc.edu>
	<20250410150555.7797d195@gandalf.local.home>
	<3ce02a98-0ac2-4d34-b6f7-ba85088399d7@cs.wisc.edu>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 17 Apr 2025 14:10:53 -0500
Junxuan Liao <ljx@cs.wisc.edu> wrote:

> Just found out that the exit tracepoints for syscalls aren't always
> exactly preceding the exit to userspace. The kernel can still spend
> quite some time in task_work_run after the tracepoints are triggered.
> Has that bothered you before?

It's been a while, but what I usually do when I want to see entry into the
kernel is also to run:

  trace-cmd set -p function_graph --max-graph-depth 1

Which tracks the first function call into the kernel. It obviously now
misses entry and exit from user mode due to noinstr, but if a task_work
function is called, it will usually catch that too.

-- Steve
