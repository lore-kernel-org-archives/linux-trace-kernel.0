Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 706102E6CA8;
	Thu, 19 Feb 2026 18:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771526703; cv=none; b=TB1QvRbdvaG8uIIcCd4Zcu9CD38a+5Sv2LV7Axq9OfrnLPHFt5dHfZVZur6TBtISCJikq8eIKM2LCdbxTqECi9UpEmuD6NTPW8InYIYjQFCGrwNgBJm7lw9rM8cof9dQMaiWH+Npy2L3h5+r2b5jcqUuGcxEDTrMHlYapzF93W8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771526703; c=relaxed/simple;
	bh=1R8lbLSCOatiPuEN/qf0w4tw6ht2YTutQWzQMSFN9gU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lqwv/MVFNC5LWcYtGQO5nHnxtR6/OgTjdsz7ecRL8jHDw1vrdjuI2L+drjA6C6RF0xpdZzoh/dqFz3YIXCeVd2DUWElfmWqh+lp/apeBG9KkuLpEEMRSeQh9fy0xBczHai4bMA0wtsRQzcngUe95IoErrDNPlFRC3QAPfn+XU8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ExjfXhuF; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ExjfXhuF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC3E5C2BCB0;
	Thu, 19 Feb 2026 18:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771526703;
	bh=1R8lbLSCOatiPuEN/qf0w4tw6ht2YTutQWzQMSFN9gU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ExjfXhuFWoHI7QM2AfW+f+YRaTO7Wr+j1OM1uMSeoqWNj8gY0r4xnWCaS7ZU0sxCG
	 zRbDxldW8ji1Ay1gZeGpAdNcPCOgy2uaXbSANC8PObncTo+xg3awAq+f+6Q85hu4Yi
	 wNJiNg8AHKMIkBWDnCgzHXnCViwJu6s56aXJzTBqVp18gFZHh/vkExfWTcc0uE45r/
	 h91cXYfEpjbgYvzKcqLVBVeVgbHw6krZvM7ycZ2/HQmeutkrAo9NBTe3Seop1Nt0ea
	 oqU7PnoDQqlMIryTUGpB/eMdZD7dQWOVnlVTLKULs80xgNOHF+8NQm9lMWAQF3wv2U
	 hbc7kazo9F9bw==
Date: Thu, 19 Feb 2026 10:45:02 -0800
From: Kees Cook <kees@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Dave Hansen <dave.hansen@intel.com>,
	"Elly I. Esparza" <ellyesparza8@gmail.com>,
	linux-kernel@vger.kernel.org, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, Naveen N Rao <naveen@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] x86: Prevent syscall hooking
Message-ID: <202602191041.4CB9C4AAFD@keescook>
References: <20260218144735.24307-1-ellyesparza8@gmail.com>
 <0c5396b5-f084-4ade-adc9-029037031eea@intel.com>
 <20260218105204.3af7251e@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260218105204.3af7251e@gandalf.local.home>

On Wed, Feb 18, 2026 at 10:52:04AM -0500, Steven Rostedt wrote:
> Honesty, if you are worried about this, just run LOCKDOWN on tracing, and
> prevent *ALL* kprobes. Because yes, there's a 1000 ways to get this
> information once you have kprobes enabled and have root access. This patch
> is hurting legitimate debugging of running systems more than it is limiting
> rootkits from hacking the kernel.

Yeah, I agree. If kprobes is available, there is a lot of harm an
attacker can already do. If a bright line between root/ring-0 is
desired, a system needs to be configured to be using lockdown or similar
things to turn off the interfaces that let root write to kernel state.

-- 
Kees Cook
