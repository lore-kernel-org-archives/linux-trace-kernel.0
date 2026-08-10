Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAA83515F7;
	Mon, 10 Aug 2026 08:31:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786350702; cv=none; b=RUrH2yH/vPyCviF7OX0xZ24IBy4Qql4hd45MyhCs92jzkQmMM0p0Z5p+UZj7SNp/r+noLRmJxhl0ThQ39C36RRNCN2wTzG2bEoccFTZpx/e6gVyMKnE6hOOIQca3FwiHJaQNnFkRXHVnJxj2x5H1bF+EKfp5VIwx3pAemklMZq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786350702; c=relaxed/simple;
	bh=sQFi3aNyIa677Fa5k/VfJOnO4f3SpBY3JV9ygrlRlQY=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=twN8QXi8d1Pws4MIW81x0tVE+Y2D+3DFWQJIWiMChCFe2VYgbmf0iyROgPHsDxTugVFLlywV63lB1DxtXOOI8Owcq1rAd5yiHi8s3wnlcBpf8ZyVLTAniBcR+3d3x/I4oG962As+MzaPWOj2gk913lH4dqkRX1wE0iPYp+63708=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fr/KwB92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fr/KwB92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43EFE1F000E9;
	Mon, 10 Aug 2026 08:31:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786350701;
	bh=ggRHchz+0hOEvcihaA+KMXde6cZq1/XqA3sVwTGdRcY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=fr/KwB92u2KNoP5lLC1wkfetWY6WbOZ1fWisOSipOGaFduhMoAJ1Gw/WOKgKPpzwR
	 koYWAFxfheZ6GLH6FO1Z+5BTF17DhBDXHt5aMUvdSbca7+CZwhd6NjMLFBolqi7Ox6
	 rW1IGV/oqzUgd8MyKNMF2KwkXnyOnQY16WHjffRbVrS4ERV+yHX99cbgKhPw0ATWTq
	 DrJuKsv58M0XWRyJxatfd9SVwwNjbSYZpz5wH1xSyFLkehd0ZFgPexoiaE1NENvsav
	 oInV8s8Rg/9F2km7NVd772pm+yXl+pCbwxfD62O1bqm3LXYm0ib1n6o7bY0Gwa5HFv
	 7nD81oFZqulSQ==
Date: Mon, 10 Aug 2026 17:31:37 +0900
From: Masami Hiramatsu (Google) <mhiramat@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Vincent Donnefort <vdonnefort@google.com>, Masami Hiramatsu
 <mhiramat@kernel.org>, linux-trace-kernel@vger.kernel.org,
 mathieu.desnoyers@efficios.com, kernel-team@android.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/6] ring-buffer: Prevent resizing of persistent ring
 buffer
Message-Id: <20260810173137.e8c5337fef0f989faed995e4@kernel.org>
In-Reply-To: <20260807152641.4b9deff0@gandalf.local.home>
References: <20260806211306.3704194-1-vdonnefort@google.com>
	<20260806211306.3704194-2-vdonnefort@google.com>
	<20260807111808.d5dc1a48b080d241100f4a57@kernel.org>
	<anWT4heM5Z--A1Mo@google.com>
	<anWosNi-U8lVqBZP@google.com>
	<20260807104526.38430aa2@gandalf.local.home>
	<anX47awNHC9caDN_@google.com>
	<anX9k8x67m4Cdw5n@google.com>
	<20260807152641.4b9deff0@gandalf.local.home>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Aug 2026 15:26:41 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Fri, 7 Aug 2026 16:45:23 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > free_reserved_page() would do actually. But then it is definitive. 
> 
> It's not always a reserved page.
> 
> > 
> > Happy to implement something like that. That also means that the instance can be
> > actually freed?
> 
> They can be freed now. Try a rmdir on one.
> 
> Note implementing this is not straight forward. What I would suggest is
> that because the persistent ring buffers are contiguous, to resize, you
> basically need to remap to the new size. That means each of the buffers
> will still be attached to each other.
> 
> What would need to be done is:
> 
>   1. calculate the new size needed to accommodate all the CPU buffers.
>   2. Split them up within the new size region.
>   3. Then free the remaining pages.
> 
> Obviously, access to the buffer from readers and writers will need to be
> prohibited while this is happening.

Hmm, I think we also need to record the size of persistent ring buffer at
initialization. The buffer size (number of pages are calculated by the
size of reserved memory, which is defined in the kernel cmdline.

So if we have `reserve_mem=12M:4096:trace trace_instance=boot_map@trace` on
the kernel cmdline, and we write the buffer_size = 1024(KB) on 2CPU machine,
it can be shrinked down to ~2MB on the reserved memory. However, when we
reboot the machine, the kernel calculates the size as 12MB again, and may
get a validation failure.

So we also need to add nr_pages and nr_cpus (maybe) on ring_buffer_meta and
calculate the ring buffer size from it, instead of using the reserved memory
size (we also need to check the calculated size is smaller than that.)

Thank you,

-- 
Masami Hiramatsu (Google) <mhiramat@kernel.org>
