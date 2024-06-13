Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C77143C40;
	Thu, 13 Jun 2024 13:26:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718285208; cv=none; b=OTTCrOwwOzxYJw05aRnQIp8sIx97NSPUacBrW1id2NoggJpp0tpdq4Y3sJfBPP/+zJG/eYH8ctyf92XK5VVz4XyHXT6QkGLhZ+U87cxSW9AJ1A35eb+QkNcHn7MmmfY/HC9nYoD6OY1NMWG2bHv6xxLUqq3vi7IVag6HwDjLh8s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718285208; c=relaxed/simple;
	bh=/4UAOu8OPxB6jQeNkyxjOzmqUKJUuZRRJHc/NOgQCGA=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VUUuw8sIkm//gPo1CE2Rkj1zuzZ3QZ88tIC/rfa3K5UtUmWjTdP9wbN1kXP63M6ovUPpZ+X2CIyzVO3JnZ7+1RDIOcVJYe+2jGLY/tBxLlaSEezJVcJDluFkaaX0stCW2YVLhoiJmcHSI2hVaP96NA1IA2dbSd7++05rBlsQEYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C307C32786;
	Thu, 13 Jun 2024 13:26:44 +0000 (UTC)
Date: Thu, 13 Jun 2024 09:26:42 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Ard Biesheuvel <ardb@kernel.org>
Cc: Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>,
 linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck
 <tony.luck@intel.com>, "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>
Subject: Re: [PATCH v3 2/2] pstore/ramoops: Add ramoops.mem_name= command
 line option
Message-ID: <20240613092642.385461d5@rorschach.local.home>
In-Reply-To: <CAMj1kXHLSROujjc_OifzVmuAd7BpA+b4D2JrPGLJJYj2au7SfQ@mail.gmail.com>
References: <20240611144911.327227285@goodmis.org>
	<20240611144949.703297941@goodmis.org>
	<202406121145.8860502D7@keescook>
	<20240612145228.5bf426e0@rorschach.local.home>
	<ZmqLejL1mblOikLp@kernel.org>
	<CAMj1kXHLSROujjc_OifzVmuAd7BpA+b4D2JrPGLJJYj2au7SfQ@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 08:11:48 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > I've added one more comment to v5, with that fixed I can take this.
> >  
> 
> So how is this supposed to work wrt to the rigid 'no user visible
> regressions' rule, given that this whole thing is a best effort thing

This has nothing to do with user space. The kernel command line has
broken in the past. If you update the kernel, you can update the
command line. There's no "no user visible regressions" rule. It's
"Don't break user space". This has nothing to do with user space.

> to begin with. This needs at least a huge disclaimer that this rule
> does not apply, and if this works today, there is no guarantee that it
> will keep working on newer kernels. Otherwise, you will be making the
> job of the people who work on the boot code significantly more
> difficult. And even then, I wonder whether Linus and #regzcop are
> going to honour such a disclaimer.

Again, this has nothing to do with user space. The rule Linus talks
about is breaking user space. This is about kernel debugging. Something
*completely different*!

> 
> So this belongs downstream, unless some guarantees can be provided
> that this functionality is exempt from the usual regression policies.

I disagree. kexec/kdump also has the same issues.


-- Steve
