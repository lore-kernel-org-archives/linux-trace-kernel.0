Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24A9A140E3C;
	Tue, 25 Feb 2025 18:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740508474; cv=none; b=X1lJzsyH2gQ654z8MtkjpwaI8JvXxFFhVuJug/BQNtNUgq72IKCbmBmDajjDkAzR9PItEyp4c1MpjNYU9Sa8kgQqRwnPoJ6gQoQTLasuhDRRPppF7Iv3hBuVO/2p+TbMO1HhOdC/xR9dn6CMOcnqc9WzQ/5zdRC/mlV8w8VkLjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740508474; c=relaxed/simple;
	bh=9+1ARJ3Bpij66Ghr0jqpHuwim2x1Ohnkdqg8Cbi+FK8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aMFna3mHlsiEt/LMvHYAcbTgAvEQaX3VJ5xcsxO+8w4GeLDFBSg73C67ha6GWpXcb3Kj1RCzSkSApTL40Vv5cFCBIyAP3Gq0r8CzYNNzfNDuLXqg6Jb0jz1ag+RD+z6oYx0hyZ5qrPbq3X2h23koTyl/0cbwZeMM4oU6Hwcnrco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE67C4CEDD;
	Tue, 25 Feb 2025 18:34:31 +0000 (UTC)
Date: Tue, 25 Feb 2025 13:35:10 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Masahiro Yamada
 <masahiroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Nathan Chancellor <nathan@kernel.org>, "Arnd
 Bergmann" <arnd@arndb.de>, Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 0/4] scripts/sorttable: ftrace: Fix some bugs with
 sorttable and ARM 64
Message-ID: <20250225133510.34d13366@gandalf.local.home>
In-Reply-To: <20250225182004.473875894@goodmis.org>
References: <20250225182004.473875894@goodmis.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 25 Feb 2025 13:20:04 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> Steven Rostedt (4):
>       ftrace: Test mcount_loc addr before calling ftrace_call_addr()
>       ftrace: Check against is_kernel_text() instead of kaslr_offset()
>       scripts/sorttable: Use normal sort if there's no relocs in the mcount section
>       scripts/sorttable: Allow matches to functions before function entry

I just kicked off my test suite to test these patches. If they all pass,
I'll push them to linux-next tonight, so hopefully this doesn't cause
issues for others testing linux-next.

-- Steve
