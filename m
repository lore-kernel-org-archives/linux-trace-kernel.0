Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43443595D;
	Thu,  6 Feb 2025 00:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738803142; cv=none; b=W3Lvfp1FQkH8xfpilxNwiHV9nftAf4jfY4hAdrqXDAdS9oiGN8inDNs9WZ5rVPH2oBbCNAxQAbEbfQC1USpOqJ0hfhVuXixTVI3c1IrftZWmj/AED8dZJqY4iI8W/5DsbccgczcXdLnqielmLNtbSqFjbW1lj2TMGrMgdwhuvzQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738803142; c=relaxed/simple;
	bh=adPdUdbT9MYEC2UsKzqDbxdmFeyBFvzW9mTOOVHpSUo=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a2PchuNOIFQDg20gnu5/BFF+H+62t8DMBJBdfH/c1Wa8ZEd2BwdrVsvKERlMs1vzbd3XJvM8R4lSNbe9iOI+YclxDyRgZbdp25lkv211xkOgU+IjXcqMWdNiC8gU29CPcjMUgw/S/lY2tkQmvk63IzsfUiFilqmv2YDCgtMcXqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3FDC4CED1;
	Thu,  6 Feb 2025 00:52:20 +0000 (UTC)
Date: Wed, 5 Feb 2025 19:53:00 -0500
From: Steven Rostedt <rostedt@goodmis.org>
To: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
Cc: Haiyue Wang <haiyuewa@163.com>, x86@kernel.org,
 linux-trace-kernel@vger.kernel.org, samitolvanen@google.com, Mark Rutland
 <mark.rutland@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 linux-kernel@vger.kernel.org (open list:FUNCTION HOOKS (FTRACE))
Subject: Re: [PATCH v1] ftrace: Fix compile error when CONFIG_GENDWARFKSYMS
 is enabled
Message-ID: <20250205195300.42d3e3b0@gandalf.local.home>
In-Reply-To: <20250206093853.4e55405ccfcba7111705f395@kernel.org>
References: <20250205180116.88644-1-haiyuewa@163.com>
	<20250206093853.4e55405ccfcba7111705f395@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 6 Feb 2025 09:38:53 +0900
Masami Hiramatsu (Google) <mhiramat@kernel.org> wrote:

> Thanks for the fix. And this fixes one of problems.
> Another one is that `is_endbr()` is defined in <asm/ibt.h> but that also depend
> on CONFIG_HAVE_FENTRY.
> 
> Let's pick this and fix above issue.

OK, I'll pull this into my urgent tree and start testing it.

-- Steve
