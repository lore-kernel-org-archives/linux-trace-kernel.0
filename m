Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784ED282E1;
	Fri, 16 May 2025 08:21:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383704; cv=none; b=hW5Hg8ZB7vUYuf7lrZo4n7ZqaKJZy9g8lgQNQ7HzNgOznFDszIOpWjoap0AFB+YlVkw7r/U4yc+qkoWB6ggSzrOwpCx+Bh4v42UKMbmTtiv1EOPVDmK01nAjKv+5+c4MtKyacZnB+nfZHv/sVT+caai+cHJMYei33t4u9mnGs5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383704; c=relaxed/simple;
	bh=rSp1lfbQL3HqFGs8Qxo+9gIOoVGubU2xru7Z0ayuSa8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lF/zl/vifvDtVuDtb7PsNi/PmVrOjZNvtHMXl/wTU4oymoGBU03EWq2sZlYzLIHw7fgpspZQ8TR/BkYDVmzF359FEHQjNBBctPLZDkLvc8Fk8Sta+E6oXRisw/8fAL5cSeLtEP8lr5c7qTT0fC2Dorll/SaA0Bxo+bucsnQcfVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=khjJJ4Y9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="khjJJ4Y9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CA9CC4CEE4;
	Fri, 16 May 2025 08:21:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747383703;
	bh=rSp1lfbQL3HqFGs8Qxo+9gIOoVGubU2xru7Z0ayuSa8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=khjJJ4Y9oh6fHJXx5oXsnkK/z+Bp0SEf0wsA33MAPawNxml0laU5uzOmMoWVpY7Ln
	 Gj3Tl2iBJJVkNddWg5xRz73uzR1vSwWG4F7zjN7TVXXx0U88dj3I//4vJV2Keeya8b
	 NnCjnxILnaIikCCPvaUJYjQNYE3RUNtG1yf3W4yTeMhbcnVe8u4qKQ+5VFCxZvNGmy
	 l1hPm/Vgtim5RdnJXDS+rgS3ZWBbEDJ6i1l7pLe6Ie0t1y4iKtG6B4B14Ir3AUViOH
	 F5LQeF7RNHt/8g7ZAb5Xe5cHwO+8ba2zzrlDsweh632bqVboRtrgeDnyy/lRrplA02
	 vObKzuweIWSsg==
Date: Fri, 16 May 2025 10:21:36 +0200
From: Ingo Molnar <mingo@kernel.org>
To: Nam Cao <namcao@linutronix.de>
Cc: Steven Rostedt <rostedt@goodmis.org>,
	Gabriele Monaco <gmonaco@redhat.com>,
	linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org,
	john.ogness@linutronix.de, Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ingo Molnar <mingo@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H . Peter Anvin" <hpa@zytor.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	linux-riscv@lists.infradead.org
Subject: Re: [PATCH v8 00/22] RV: Linear temporal logic monitors for RT
 application
Message-ID: <aCb1kBEkiriPbMo4@gmail.com>
References: <cover.1747046848.git.namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1747046848.git.namcao@linutronix.de>


* Nam Cao <namcao@linutronix.de> wrote:

> Nam Cao (22):
>   x86/tracing: Remove redundant trace_pagefault_key
>   x86/tracing: Move page fault trace points to generic

Does the renaming of the tracepoint class from 'x86_exceptions' to 
'exceptions' have any negative effects on tooling?

Thanks,

	Ingo
