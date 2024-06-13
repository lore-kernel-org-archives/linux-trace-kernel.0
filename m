Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83B88D535;
	Thu, 13 Jun 2024 14:31:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289109; cv=none; b=Dmbp0SJL6UFqZDKnMENqXGJKzRpzCdHwGtwPhKWcw5n9NqYTOCkjIhMGH4iqSlLohm/Pl5zP4m2/X8erzpGQgYjJ9QmWA4po2pr+X1Qg3bi+86AlYcDsUjjF22/0uap7IwxiTXQTNO5JOeiMhLdVxi6rEDCDQi1Rz1fVs2rJFZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289109; c=relaxed/simple;
	bh=9PsPQmeESTeyLm7KAtQ8IYUYp2oYTDZnLsGETxZ4WU4=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jrRejHo22PLV9CUFrNV+Cmpga9ihcYa9OdlxxAVfCs5MoA9rXymFEuCg6eFdhCE+kkE+8t4AJQPyWhsCsN4Oqja6qotnc5CojxVQqZfx52uiuvCx5yPyM2qnbkL4cGwhjF/gH09PQZGTBCSmLj81EvN5yzPVi6CGBpcLxKJEYME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CB8C2BBFC;
	Thu, 13 Jun 2024 14:31:45 +0000 (UTC)
Date: Thu, 13 Jun 2024 10:31:44 -0400
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
Message-ID: <20240613103144.2a78f663@rorschach.local.home>
In-Reply-To: <CAMj1kXFGnk4vYpTk4PwUg8iYHcbXdrPaYP+OBxHrD5+=jvow+g@mail.gmail.com>
References: <20240611144911.327227285@goodmis.org>
	<20240611144949.703297941@goodmis.org>
	<202406121145.8860502D7@keescook>
	<20240612145228.5bf426e0@rorschach.local.home>
	<ZmqLejL1mblOikLp@kernel.org>
	<CAMj1kXHLSROujjc_OifzVmuAd7BpA+b4D2JrPGLJJYj2au7SfQ@mail.gmail.com>
	<20240613092642.385461d5@rorschach.local.home>
	<CAMj1kXFGnk4vYpTk4PwUg8iYHcbXdrPaYP+OBxHrD5+=jvow+g@mail.gmail.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 13 Jun 2024 16:06:47 +0200
Ard Biesheuvel <ardb@kernel.org> wrote:

> Fair enough. As long as it is documented that there is no guarantee
> that this will keep working over a kernel upgrade, then I have no
> objections.

Thanks,

I'll send out v6 and even stress that this may not work for all kernel
versions.

-- Steve

