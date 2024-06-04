Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B67D38B;
	Tue,  4 Jun 2024 10:57:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717498653; cv=none; b=JtvbER1DByY38H9VxeHEtkHi25T7fBbKv+nmCQ2jAOFnm7TwOMP7RjEsF+/P0+/iocFE4+rqAPl3CIQJlfivCEKkggETl2o+mEwZTKbHSU8FSZwANV0c6IIVRhg/0d37M3oo9fnnfuSY/a3jvNlJkgVWsqfQf5RSNasG0l1RxdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717498653; c=relaxed/simple;
	bh=pDzZuelRd9zkUjP+3rv7hlwEiVL1Kt7S4rapZBl5Ko0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C0nBRLr8I/Ulzman+lXZoQplMz6K909UCxWGkCmhGt6yoT5YQQDrHFdtS/ynnH8DZShy1c3RZ8QsWciVEggVuu5Wlbejuw12IIklp99LsrN29k2lr0c4IGz+BYNnsnAM3S12GUFrv5SvljltHgMxTucl6R3oUDnbO0QtfmL1WjE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17DD4C2BBFC;
	Tue,  4 Jun 2024 10:57:27 +0000 (UTC)
Date: Tue, 4 Jun 2024 06:57:27 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Kees Cook <kees@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org, Masami
 Hiramatsu <mhiramat@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, Andrew Morton
 <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin"
 <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Kees Cook
 <keescook@chromium.org>, Tony Luck <tony.luck@intel.com>, "Guilherme G.
 Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, Guenter
 Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>,
 wklin@google.com, Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel
 Fernandes <joel@joelfernandes.org>, Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Mike Rapoport
 <rppt@kernel.org>, ardb@kernel.org
Subject: Re: [PATCH 1/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240604065727.4deefc04@gandalf.local.home>
In-Reply-To: <5DAB46F6-F415-4C2B-AA6A-E0049CF6270C@kernel.org>
References: <20240603233330.801075898@goodmis.org>
	<20240603233631.452433539@goodmis.org>
	<5DAB46F6-F415-4C2B-AA6A-E0049CF6270C@kernel.org>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 03 Jun 2024 22:52:37 -0700
Kees Cook <kees@kernel.org> wrote:

> On June 3, 2024 4:33:31 PM PDT, Steven Rostedt <rostedt@goodmis.org> wrot=
e:
> >From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
> >
> >In order to allow for requesting a memory region that can be used for
> >things like pstore on multiple machines where the memory layout is not t=
he
> >same, add a new option to the kernel command line called "reserve_mem".
> >
> >The format is:  reserve_mem=3Dnn:align:name
> >
> >Where it will find nn amount of memory at the given alignment of align.
> >The name field is to allow another subsystem to retrieve where the memory
> >was found. For example:
> >
> >  reserve_mem=3D12M:4096:oops ramoops.mem_name=3Doops =20
>=20
> How does this interact with KASLR? It has chosen its physical location
> before this parsing happens, so I'd expect this to fail once in a while,
> unless the size/alignment is lucky enough that KASLR never uses that
> portion of the physical memory...
>=20

=46rom looking at the KASLR code, it looks to me that it picks from 100
different locations. I could be wrong, but if you have sufficient memory,
I'm thinking that it should not conflict. But if it does, yes, it will fail
to pick the same location.

-- Steve
