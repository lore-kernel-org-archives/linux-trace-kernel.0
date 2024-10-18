Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B8011FCF64;
	Fri, 18 Oct 2024 15:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729265028; cv=none; b=kUayo7XVaSHRTPOPr6nG5TXXu2g95VgOwvy6ZTobDVq9aSdErrgl/DBYP97mGI1jbV02fNdI0k7eXIrTqA5uEdf/75z8gvp64A6xE3KDqMxT+0ZdgUcecTSj5FqWu/xFVge+Jgco8tKAcFKFA3UN9pVhq6Px7mUm08qm7g35pw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729265028; c=relaxed/simple;
	bh=Os3fOGHzGf2lhRrkOLq1nhLtoZPdS+KM+F/lwBPpE+8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WTxpWqKTQNSCrnOBwlVrHv81bOYcSshWb0n3/OajE3xkWax91fT0fJT+aLAJZ20N4LTK/KD3rnyZKV/GjrNUHoyt1GG3J80OGdjr/BDr0QPnHwiIg2NVEIOQgfJc+kmpZZJtLbdpJMOMXMx8iyGjYhTFfRlbdWgBPUQ3f20UkwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04D35C4CEC5;
	Fri, 18 Oct 2024 15:23:45 +0000 (UTC)
Date: Fri, 18 Oct 2024 11:24:11 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ryan Roberts <ryan.roberts@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Anshuman Khandual
 <anshuman.khandual@arm.com>, Ard Biesheuvel <ardb@kernel.org>, Catalin
 Marinas <catalin.marinas@arm.com>, David Hildenbrand <david@redhat.com>,
 Greg Marsden <greg.marsden@oracle.com>, Ivan Ivanov <ivan.ivanov@suse.com>,
 Kalesh Singh <kaleshsingh@google.com>, Marc Zyngier <maz@kernel.org>, Mark
 Rutland <mark.rutland@arm.com>, Masami Hiramatsu <mhiramat@kernel.org>,
 Matthias Brugger <mbrugger@suse.com>, Miroslav Benes <mbenes@suse.cz>, Will
 Deacon <will@kernel.org>, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-trace-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v1 18/57] trace: Remove PAGE_SIZE compile-time
 constant assumption
Message-ID: <20241018112411.6311a9e9@gandalf.local.home>
In-Reply-To: <e5067bb8-0fcd-4739-9bca-0e872037d5a1@arm.com>
References: <20241014105514.3206191-1-ryan.roberts@arm.com>
	<20241014105912.3207374-1-ryan.roberts@arm.com>
	<20241014105912.3207374-18-ryan.roberts@arm.com>
	<20241014124656.3ffb0f65@gandalf.local.home>
	<e5067bb8-0fcd-4739-9bca-0e872037d5a1@arm.com>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 15 Oct 2024 12:09:38 +0100
Ryan Roberts <ryan.roberts@arm.com> wrote:

> > 
> > Not to mention, when function graph tracing is enabled, this gets triggered
> > for *every* function call! So I do not want any runtime test done. Every
> > nanosecond counts in this code path.
> > 
> > If anything, this needs to be moved to initialization and checked once, if
> > it fails, gives a WARN_ON() and disables function graph tracing.  
> 
> I'm hoping my suggestion above to decouple SHADOW_STACK_SIZE from PAGE_SIZE is
> acceptable and simpler? If not, happy to do as you suggest here.

Yeah, I think we can do that. In fact, I'm thinking it should turn into a
kmem_cache item that doesn't have to be a power of two (but must be evenly
divisible by the size of long).

I'll write up a patch.

-- Steve
