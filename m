Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9689F8060A;
	Wed, 19 Jun 2024 21:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718834020; cv=none; b=iGwank3jPUkGleq+tFIdFnpOCSldaAu4vbkAR5gsaf8ncVORbEM9D5A2c2vEv/ObLwgHk4nKV3YJfOyJxukTZv9xqLaI12sQwksyerxvgzp4L4btcVdGDugSn9ak62ch8RWLr1zWALSe/zS2FGxSMxwzUd6iD1jH9EN+/yw968Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718834020; c=relaxed/simple;
	bh=inZbt1nVexn63pcw2IW6HgYBOpd8gjz887xkIhcbefo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hiMbNzwdNCHzzil+6ssg1yALeofJDdx0xDhyF1c7g1lc4RN/F/ZmnRIguVqmAwpx97QhwYMOP8j6BfXwiOaeLHjUUaBC/PhJb+4IYST7msxoypM40XTQ9APw+ct+hzYe/GKt+m08Nooy0VuUuohxqEwUsNB6Gj9HEY/Dhf1jISo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QCCsF8iV; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QCCsF8iV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68AD1C4AF0C;
	Wed, 19 Jun 2024 21:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718834020;
	bh=inZbt1nVexn63pcw2IW6HgYBOpd8gjz887xkIhcbefo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QCCsF8iVAZECTdrJjgzblysTiFCG2OPLbU4sAbXzSJG9bj2Yt+5/EZI9jHkdl31Mb
	 5HNxfTBaWzk99NWzzYe07xxEiscpWyG70wmCtul/X3EZ+WBlSo/TITuzLzQuQafo68
	 qJ/rUI+aVkF95/KXDfr1X7lMa0nI0GIWs3iGcuaH18wVHUKWEpljs2LdjbAoI029Mm
	 Gyzr0JRhj+o22s6FZkQPwhz2ZfHWgX7RaaDOlrkn/ZxBdnKwVyfIvb8A9Scs0CTTa7
	 f1TQanzeNMni7nRVgwYLbC+b0GiIKt+Ca4Dk9KKsIK3bzEYev1OGlCCAHKv4glNgKw
	 x1Q+DaxTswRFg==
From: Mike Rapoport <rppt@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@kernel.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Vincent Donnefort <vdonnefort@google.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Daniel Bristot de Oliveira <bristot@redhat.com>,
	Ingo Molnar <mingo@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	suleiman@google.com,
	Thomas Gleixner <tglx@linutronix.de>,
	Vineeth Pillai <vineeth@bitbyteword.org>,
	Youssef Esmat <youssefesmat@google.com>,
	Beau Belgrave <beaub@linux.microsoft.com>,
	Alexander Graf <graf@amazon.com>,
	Baoquan He <bhe@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named memory at boot up
Date: Thu, 20 Jun 2024 00:53:07 +0300
Message-ID: <171883398191.3581885.18182692527308586957.b4-ty@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240613155506.811013916@goodmis.org>
References: <20240613155506.811013916@goodmis.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

From: Mike Rapoport (IBM) <rppt@kernel.org>

On Thu, 13 Jun 2024 11:55:06 -0400, Steven Rostedt wrote:
> Reserve unspecified location of physical memory from kernel command line
> 
> Background:
> 
> In ChromeOS, we have 1 MB of pstore ramoops reserved so that we can extract
> dmesg output and some other information when a crash happens in the field.
> (This is only done when the user selects "Allow Google to collect data for
>  improving the system"). But there are cases when there's a bug that
> requires more data to be retrieved to figure out what is happening. We would
> like to increase the pstore size, either temporarily, or maybe even
> permanently. The pstore on these devices are at a fixed location in RAM (as
> the RAM is not cleared on soft reboots nor crashes). The location is chosen
> by the BIOS (coreboot) and passed to the kernel via ACPI tables on x86.
> There's a driver that queries for this to initialize the pstore for
> ChromeOS:
> 
> [...]

Applied to for-next branch of memblock.git tree, thanks!

[0/2] mm/memblock: Add "reserve_mem" to reserved named memory at boot up
      commit: 1e4c64b71c9bf230b25fde12cbcceacfdc8b3332
[1/2] mm/memblock: Add "reserve_mem" to reserved named memory at boot up
      commit: 1e4c64b71c9bf230b25fde12cbcceacfdc8b3332
[2/2] pstore/ramoops: Add ramoops.mem_name= command line option
      commit: d9d814eebb1ae9742e7fd7f39730653b16326bd4

tree: https://git.kernel.org/pub/scm/linux/kernel/git/rppt/memblock
branch: for-next

--
Sincerely yours,
Mike.

