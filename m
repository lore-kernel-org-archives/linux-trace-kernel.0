Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A7404AF16E;
	Wed,  2 Sep 2026 21:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788384340; cv=none; b=YDlnnXEPX8XGdQ879hIMOEUK1Nk+73VkaQvrqaFW1bSbErgWzEelUsuC0wtAoVaCKWFdK0OPjv4rKHcgVvi/xgbP7+qi7F/lnWgKBxJ2Y2THXSnKyFKOy78foodVw9x1kUL9/1uzn/9z/R6Y8XmRmNBxLWq3T4nAk1veyRXINhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788384340; c=relaxed/simple;
	bh=ObyOwT/+De+TSl4KajnJiayVbDynd4MjXNjU4DZbiB4=;
	h=Message-ID:Date:From:To:Cc:Subject; b=FjCDRCwXDxyh+qOuubC0ha0HKnQFSe6f8nF8hrfBaBMFNNdsmT2R44fxdShrVmCTDPk4vqV4eCaEniXNqPd4LwOOuxKR5F1qb72QLsaG50EatrqkGA5fEmOgrwZSNw7i1PJVbWY7MqYP7upZp0PAWoA79eqIU0pPVBr4gnU0PU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fETyvuPj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fETyvuPj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2741F000E9;
	Wed,  2 Sep 2026 21:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788384336;
	bh=d1eze1vj6yNiR6lmq95MdvKNrozGwzW99HeZgLb5r8w=;
	h=Date:From:To:Cc:Subject;
	b=fETyvuPjwajuVEsd8DAzEr0SxwVbw1V7hljUm3mDOUoruMCnzP3Fr0XDTu14qE4bg
	 U6wl5PDyc0rWDR20T30LWe2KxvdSrTEDMjyiz1svV3RTFU0PE1oCm+bFyfo6T1nLdz
	 OU9Xh2DoFJM1Lx4GMi+Upou2YvWEw127dDfou1FRt7nFpSYFFpckdYDAHiMfMl1D1S
	 yp4alyLby0KFuAbWYLFQR9xy3W7fBNJwIoL4eITpY21JeYFxuGb0v/s9MegBXqo4pB
	 kfIG4Cne16w7Z+FZE3qHAnf4F4uXA3DT48Keaouo1I6d5TM247yMZER1pSFpcyIZZB
	 GtyUKAggeyHDw==
Received: from rostedt by gandalf with local (Exim 4.99.4)
	(envelope-from <rostedt@kernel.org>)
	id 1x1sTd-0000000ECcc-3h2G;
	Wed, 02 Sep 2026 17:26:37 -0400
Message-ID: <20260902212609.542937225@kernel.org>
User-Agent: quilt/0.69
Date: Wed, 02 Sep 2026 17:26:09 -0400
From: Steven Rostedt <rostedt@kernel.org>
To: linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 0/2] tracing: Fix how the tracer options file ups the trace_array ref count
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>


Sashiko reported that the tracer option files pass a descriptor to
the file system operations that points to the trace_array it is apart
of as well as information on the tracer option. It uses the trace_array
to up its reference counter so that it can not be deleted when the option
is open. The issue is that this descriptor sent to the open call itself
can be removed by the removal of the instance the trace_array represents.
There's nothing protecting it for going away and dereferencing it after
it has been freed.

Another issue is that the tracer options are an array on an array for
each tracer in the trace_array descriptor. The first patch converts
that to a single array. This is need for the second patch.

The second patch changes the open function to search all the existing
trace_arrays under lock and compare their topts array with the topt
passed to the open function. If the topt is within the range of
a trace_array topts array then that trace_array is considered a match
and its reference is updated.

Steven Rostedt (2):
      tracing: Use a single array to represent tracer options files
      tracing: Take trace_array reference when opening a tracer options file

----
 kernel/trace/trace.c | 81 +++++++++++++++++++++++++++++++++-------------------
 kernel/trace/trace.h | 21 ++++++--------
 2 files changed, 60 insertions(+), 42 deletions(-)
