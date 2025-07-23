Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42AA020330;
	Wed, 23 Jul 2025 00:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753230412; cv=none; b=QqnOZDktkWMnsGrCrn3PRGfFhvPaX4YfEeQVM1SLmVC0iPNg3DcuTjyP9yidq7ezMrGnAp7xdgA7533hqNXcCRjAWgXzk34xkD2RjEuuya9F8RIl/Pyz7Com+sT22K0IUDxapkS3JgZOiGwyQV3jgIKtD+i/yTAHajvKITAl72A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753230412; c=relaxed/simple;
	bh=HiG4PsMd0p3VKGxcSovcFMSoChgLqudbvvn83BAfWhQ=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=MTrxUb7DQNlGmMtNnj3gG4OwRgsgiQFTzbNIRl6w2fKi8PY6SCxL+RECSAksh2GJN6YtbahZCdnw6KZq0wCxLBf0vh85V6o2zq8MRGARXozhVxtw5oKCM3kPVict8tq/LLZW3B/COLurOqfR6V3BhkzRxa578zjGf0vke4tsG0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jgi1K7Vx; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jgi1K7Vx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94D86C4CEEB;
	Wed, 23 Jul 2025 00:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753230411;
	bh=HiG4PsMd0p3VKGxcSovcFMSoChgLqudbvvn83BAfWhQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Jgi1K7VxGHYRB8OmlHrvq/87uWECj1POUqeMqd8PVUcB3khMRKhCFWOWP6wWNsMS/
	 fkRAkxCrjsn025ps/qVdrdDk/yY5e2/YNZ7RY9Vfb7Jlx6rDGVdF8mW/9yvUDKkMX1
	 nTOBC/xG308IAc2mh6ESxbH47Bee5rTqQZnZXxz0/GIbvOAa+pCchv5xNOLYK/88Xa
	 zry0xjttMPVseQ1tUI/59QaGkPcioZbiyNDcMd2290JCNoUq5BO3xv/RDmfQ2m4dtc
	 AVU/xO2z8T6qodyqYqis7rApTaMtwDrFJ4uXvmqGbN2sqG+DxnD8JYqDvVhHHEo4ca
	 t81ezXnIc0jHQ==
Date: Wed, 23 Jul 2025 09:26:48 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/7] tracing: probe: Allocate
 traceprobe_parse_context from heap
Message-Id: <20250723092648.3fc87e0fff6abb04a7234a15@kernel.org>
In-Reply-To: <20250722183813.74dd1386@gandalf.local.home>
References: <175322168606.44400.9155291012158349647.stgit@devnote2>
	<175322170601.44400.16839124706616607558.stgit@devnote2>
	<20250722183813.74dd1386@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 22 Jul 2025 18:38:13 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Wed, 23 Jul 2025 07:01:46 +0900
> "Masami Hiramatsu (Google)" <mhiramat@kernel.org> wrote:
> 
> > From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> > 
> > Instead of allocating traceprobe_parse_context on stack, allocate it
> > dynamically from heap (slab).
> > 
> > This change is likely intended to prevent potential stack overflow
> > issues, which can be a concern in the kernel environment where stack
> > space is limited.
> > 
> > Reported-by: kernel test robot <lkp@intel.com>
> > Closes: https://lore.kernel.org/oe-kbuild-all/202506240416.nZIhDXoO-lkp@intel.com/
> > Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
> 
> Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> 

Thanks!

> -- Steve


-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
