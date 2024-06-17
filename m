Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53972190660;
	Mon, 17 Jun 2024 21:18:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718659099; cv=none; b=XlCjkNDNyQ1oqUWN6trsqCjdhNUORuNM0y5mP5uTmxLIXpcGItkgVIyUNDamBpE7e4TMv8itB2bzIWsDCCgEToPoX+ea4ALhL+P1K/b3r9BYLS3H1qaGBdBXoauszPKBCfcDr99nt7JXQUJbwXUqVfHWnyub7TFpAIk28wRfd/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718659099; c=relaxed/simple;
	bh=SjPeVg5BPYAREzGhmavD6TtF0Z8TCmUWWX/bA2YYR1I=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tqMc/P4yDiMl7DNweCBOMQcKYm1VhSkiRNyZ8D5Nh83+hEluIUBcr2b+WO3JnEIZ7xbcRIiXt8ZvDzn5UQcifX49S+SGyHjW3t9UFhi9R/bZe0CoG4NyVMMTinzph3gM80OMDYHx99MezB2elg08gex0BipunWQUXOfGNVw0yUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79451C2BD10;
	Mon, 17 Jun 2024 21:18:15 +0000 (UTC)
Date: Mon, 17 Jun 2024 17:18:13 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Alexander Graf <graf@amazon.com>
Cc: <linux-kernel@vger.kernel.org>, <linux-trace-kernel@vger.kernel.org>,
 Masami Hiramatsu <mhiramat@kernel.org>, Mark Rutland
 <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>, Vincent Donnefort
 <vdonnefort@google.com>, "Joel Fernandes" <joel@joelfernandes.org>, Daniel
 Bristot de Oliveira <bristot@redhat.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, <suleiman@google.com>, Thomas
 Gleixner <tglx@linutronix.de>, Vineeth Pillai <vineeth@bitbyteword.org>,
 Youssef Esmat <youssefesmat@google.com>, Beau Belgrave
 <beaub@linux.microsoft.com>, "Baoquan He" <bhe@redhat.com>, Borislav Petkov
 <bp@alien8.de>, "Paul E. McKenney" <paulmck@kernel.org>, David Howells
 <dhowells@redhat.com>, Mike Rapoport <rppt@kernel.org>, Ard Biesheuvel
 <ardb@kernel.org>
Subject: Re: [PATCH v6 0/2] mm/memblock: Add "reserve_mem" to reserved named
 memory at boot up
Message-ID: <20240617171813.77bae9b2@rorschach.local.home>
In-Reply-To: <049b2e0f-00b2-4704-8868-1569a006a134@amazon.com>
References: <20240613155506.811013916@goodmis.org>
	<b0ed328f-c4e5-4e9b-ae4e-5c60703ab376@amazon.com>
	<20240613131212.7d1a7ffa@rorschach.local.home>
	<7c90c574-5cfa-40cf-bd4c-1188136cd886@amazon.com>
	<20240617164006.198b9ba3@rorschach.local.home>
	<049b2e0f-00b2-4704-8868-1569a006a134@amazon.com>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Mon, 17 Jun 2024 23:01:12 +0200
Alexander Graf <graf@amazon.com> wrote:
> > This could be an added feature, but it is very architecture specific,
> > and would likely need architecture specific updates. =20
>=20
>=20
> It definitely would be an added feature, yes. But one that allows you to=
=20
> ensure persistence a lot more safely :).

Sure.

>=20
> Thinking about it again: What if you run the allocation super early (see=
=20
> arch/x86/boot/compressed/kaslr.c:handle_mem_options())? If you stick to=20
> allocating only from top, you're effectively kernel version independent=20
> for your allocations because none of the kernel code ran yet and=20
> definitely KASLR independent because you're running deterministically=20
> before KASLR even gets allocated.
>=20
> > As this code relies on memblock_phys_alloc() being consistent, if
> > something gets allocated before it differently depending on where the
> > kernel is, it can also move the location. A plugin to UEFI would mean
> > that it would need to reserve the memory, and the code here will need
> > to know where it is. We could always make the function reserve_mem()
> > global and weak so that architectures can override it. =20
>=20
>=20
> Yes, the in-kernel UEFI loader (efi-stub) could simply populate a new=20
> type of memblock with the respective reservations and you later call=20
> memblock_find_in_range_node() instead of memblock_phys_alloc() to pass=20
> in flags that you want to allocate only from the new=20
> MEMBLOCK_RESERVE_MEM type. The same model would work for BIOS boots=20
> through the=C2=A0handle_mem_options() path above. In fact, if the BIOS wa=
y=20
> works fine, we don't even need UEFI variables: The same way allocations=20
> will be identical during BIOS execution, they should stay identical=20
> across UEFI launches.
>=20
> As cherry on top, kexec also works seamlessly with the special memblock=20
> approach because kexec (at least on x86) hands memblocks as is to the=20
> next kernel. So the new kernel will also automatically use the same=20
> ranges for its allocations.

I'm all for expanding this. But I would just want to get this in for
now as is. It theoretically works on all architectures. If someone
wants to make in more robust and accurate on a specific architecture,
I'm all for it. Like I said, we could make the reserver_mem() function
global and weak, and then if an architecture has a better way to handle
this, it could use that.

Hmm, x86 could do this with the e820 code like I did in my first
versions. Like I said, it didn't fail at all with that.

And we can have an UEFI version as well.

-- Steve
