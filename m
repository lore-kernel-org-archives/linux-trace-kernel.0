Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D4CC3D6B;
	Sun, 16 Jun 2024 07:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718522257; cv=none; b=P1ouuGFheFNMcc9NOaJfmfUWymJwHbHrcNKyMctmvwwebqXQfikpb5Eaki38uvsLWo5vJ8YzEq11ZlEIIY6wKb1N0cRrgmzMOgGe2WhHciA2FlkFhEBQD5WO9ROfIFf+5utcxtRuC2/9N7NkXn5MIll71R3fJW5JMwxzOGjZ37o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718522257; c=relaxed/simple;
	bh=fgLA2l2MSISlEz2pCSwaBnaseRMVySUwoInzsdYsHFY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u/MTiHnpjxnU16P+kP5Qhjfrz4UjE5P3bSlE+FWMyfGkmamYaY79ByMc36OOP9JX34ym217UvZkUCqJLuLr0gzcN0lD0QoZcz1nYmzttPHS9vATWzskPwR2kflS22lutXc/59fwoHWdLjWUAl/GKoPT8yIF8UWHLGLVgy6784EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q8aF7Cfz; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q8aF7Cfz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED70DC2BBFC;
	Sun, 16 Jun 2024 07:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718522256;
	bh=fgLA2l2MSISlEz2pCSwaBnaseRMVySUwoInzsdYsHFY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q8aF7CfzdmcxZtvLDKI1rY0OJosKHfvkqTDumNUcyybPGFXvcdEs4Uq31YdSgoVea
	 4E3rugIQK5KA6dvgP2klj4GalJSBsMmOd5J+DAQpjBsEeNWRrWkTobCgER2noYJtuW
	 wR4lq2lQ+wAk/by55X+3cOvi5efZeRYrU/UFstq5qm7k7obU8IsES/krYmTbML+qoh
	 9KLM3xisTLFub3w5egcD/Le1DQpn4qk0q7vP6iOEDxfvnB4S1o5smuQQsSqkkAu0rN
	 SPYOtbzgc/f2QkspodBsXEaXqLKQvaGKQXQi83zOSdydkdLE/6eryOp4cE+L1RrWeT
	 9Hp0cNQm782nQ==
Date: Sun, 16 Jun 2024 10:15:16 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Kees Cook <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>,
	linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
	Ross Zwisler <zwisler@google.com>, wklin@google.com,
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
	Joel Fernandes <joel@joelfernandes.org>,
	Suleiman Souhlal <suleiman@google.com>,
	Linus Torvalds <torvalds@linuxfoundation.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v5 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <Zm6RBIkE0WMZWboK@kernel.org>
References: <20240613003435.401549779@goodmis.org>
 <20240616012333.c6ddobbv6aq4jlyn@master>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240616012333.c6ddobbv6aq4jlyn@master>

On Sun, Jun 16, 2024 at 01:23:33AM +0000, Wei Yang wrote:
> Hi, Steven 
> 
> Would you mind cc me in the following version?

v7: https://lore.kernel.org/all/20240613233415.734483785@goodmis.org 
 
> -- 
> Wei Yang
> Help you, Help me

-- 
Sincerely yours,
Mike.
