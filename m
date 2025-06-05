Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7900423741;
	Thu,  5 Jun 2025 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749156552; cv=none; b=NH1SUgqZ5zVYdFdLUx4XCt9RrlALMiOykT/lgo300O4AvlYPdtIpbXCHNCZ0OqS0WS2T1c9quOJZM8EuvvoOdVOt/NUFEpMu94UfjVq8otOv/Rkj70xvaUKUn5Q+sMmGk+U3uopFEHmV58BnP1cFQXdu9jNlbpCM2W861I0Dqv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749156552; c=relaxed/simple;
	bh=na6+J3huuYSAjtWrSmAnA0hpSIevnjpDLOmo6ukBtn4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=Pxk1ju1UhoNo57tnDCcWum2Nujx8kWSwLb2rjskMMLA5PZR4yOIba0jBIjFvQdf0MZ5vKPXE+8sAf39DY/CXq+c958OPu9bLl3PXoZ8N9gX6C5Fv9w0pLp+Uyr8VZMB/0eSv6XxKYb8nreZU4gdtZMWT5g+aeeA9+m10+R8aXGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=aCaITe7D; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="aCaITe7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88359C4CEE7;
	Thu,  5 Jun 2025 20:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1749156551;
	bh=na6+J3huuYSAjtWrSmAnA0hpSIevnjpDLOmo6ukBtn4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=aCaITe7DGLShB/sLmfY1yTEwEeytvAh8ogG+WwGyxY/OPjkQsPTcbOKa8Q0ApCh7Y
	 giuJLbc6B6LIUDSfTrlCsRNeKYgCuTDyERkTerOsOkf/na2ReH+XB3Ml4SnNVQmpH6
	 tQaESrweheZTJ37c4tiOV8bl9k8if0Ok4U+V2m9A=
Date: Thu, 5 Jun 2025 13:49:10 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux Trace Kernel
 <linux-trace-kernel@vger.kernel.org>, linux-mm@kvack.org, Masami Hiramatsu
 <mhiramat@kernel.org>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes
 <lorenzo.stoakes@oracle.com>, Vlastimil Babka <vbabka@suse.cz>, Jann Horn
 <jannh@google.com>
Subject: Re: [PATCH] mmap: Remove unused events vma_mas_szero and vma_store
Message-Id: <20250605134910.fa50aabe5b0c13c11f6c9178@linux-foundation.org>
In-Reply-To: <20250605161959.328ed2a7@gandalf.local.home>
References: <20250605161959.328ed2a7@gandalf.local.home>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 5 Jun 2025 16:19:59 -0400 Steven Rostedt <rostedt@goodmis.org> wrote:

> When the __vma_adjust() was converted to use the vma iterator it removed
> the functions vma_mas_store() and vma_mas_remove(). These functions called
> the tracepoints trace_vma_mas_store() and trace_vma_mas_szero()
> respectively. The calls to these tracepoints were removed but the trace
> events that created the tracepoints were not removed. Each trace event can
> take up to 5K of memory, and it is allocated regardless of if they are
> called or not.

Thanks.  mm.git has an identical patch from Caleb Mateos
(https://lkml.kernel.org/r/20250411161746.1043239-1-csander@purestorage.com)
