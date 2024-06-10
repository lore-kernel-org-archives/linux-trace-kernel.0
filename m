Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9D61E4B0;
	Mon, 10 Jun 2024 17:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718039303; cv=none; b=PmywisyMXkJW4cl+I/2DYXYeI3q9rHVreds1sfRSSQNgSLYWSs83yqLglaTefIk763+1lTIkypGKAJX5tJtJ3nadB8DuWVRrShYEtJ5FIQ0b4DpwIpDKlvjnWPdks7vkKbLinKllvPtDyCZYZWJerLFKc1NpHruCqHyCbeqJu3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718039303; c=relaxed/simple;
	bh=n6IBKtowTYVwvEUkB4cUqJdMY5z4SkmJ78NxUR1jeEk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ky8++roDuenXsILD+9XOqIqTLBjn7pAOpQR/N9lkEuAK3u0xXeLlRGJloREmuQv08JT0hHlT1iJLOBMmHvONMGZs4paFerDcDkJ0Qi0x8Nx4YMgDkWtELKOABr1js3jEWLqhRGDBiU6A/wjKbzEmQzudauWM+4fuSDArwQ9EJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8940EC2BBFC;
	Mon, 10 Jun 2024 17:08:19 +0000 (UTC)
Date: Mon, 10 Jun 2024 13:08:18 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: "Guilherme G. Piccoli" <gpiccoli@igalia.com>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>, Ross
 Zwisler <zwisler@google.com>, wklin@google.com, Vineeth Remanan Pillai
 <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>, Linus Torvalds
 <torvalds@linuxfoundation.org>, Catalin Marinas <catalin.marinas@arm.com>,
 Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v2 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240610130818.3b97b208@rorschach.local.home>
In-Reply-To: <aa8c49d5-1a51-9256-6327-d47036b343fe@igalia.com>
References: <20240606150143.876469296@goodmis.org>
	<aa8c49d5-1a51-9256-6327-d47036b343fe@igalia.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri, 7 Jun 2024 16:54:41 -0300
"Guilherme G. Piccoli" <gpiccoli@igalia.com> wrote:

> Some code review in the patches themselves (like a missing
> EXPORT_SYMBOL_GPL), but all in all, that's a great addition! Feel free
> to add my:
> 
> Tested-by: Guilherme G. Piccoli <gpiccoli@igalia.com>

Thanks a lot Guilherme! Much appreciated.

I'll send out a v3 with your comments addressed. And may even add parts
of this email in the change logs on how it does work in various cases.

-- Steve
