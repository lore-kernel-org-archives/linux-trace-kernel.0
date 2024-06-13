Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32762145B26;
	Thu, 13 Jun 2024 14:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718289721; cv=none; b=WPItQTcsefozsmppPXm1+A51YnmR+3upOfNzDXonAc2ZeGZTKF1qBsOeLR87dJY34HtTQK1lOHuUH97XazF74KFEai+LYaahMgxPtfEZ+K2CBGPYNBf1qBaFP8c7A8pvzoTnwXaojhzHlACy7rqHMfeD/Q3atAsVeMbRtCS1nb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718289721; c=relaxed/simple;
	bh=ACFVvNaX3G/ox9xG1Uy/w4Xl9pAIQHV/YBQ2KPd9Jns=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=KuehQkfDZA8PNICrLqurR6xlDgkz3Y1d08iFE61AN9Yc8+1+rpxGe3FhvlvLVUunTzlEFC3sUxg54//S1+4/LxiQ4BMzUdnrzscI8Ar/+HQUyB+gkxwNTiSfIBPfiWsQerS1VYBfrpMEBNqGKvmgmFwKpfvUx4eTxuxD+0K/jeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l0X+9SQa; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l0X+9SQa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F4A3C32786;
	Thu, 13 Jun 2024 14:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718289720;
	bh=ACFVvNaX3G/ox9xG1Uy/w4Xl9pAIQHV/YBQ2KPd9Jns=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=l0X+9SQaNpGCWmkkBAZ7shYcXdgSpZu+aUMz3+S/S19z58NSYHB5fqogcVlIrXPet
	 WlubJrnF8ClOA7jaWL3zQ9OAxLH8++4VoUIZ3ouolUs5m1E/L+TzoJT8QMSFN5EmQ9
	 eaI0eMJadaFrHZqdg+SLaTtWMfIp5AJWQw/5B4ZIqJjrEymXnCQiP5bUM9i0DF5m/B
	 cY/evic6wzEPCMo2sdfL2a+3ivOq0E0j9yukC4zcmOt3XEkuEIGBIlt+8Nqt/lR772
	 pw7T3tQKFL99jOjFFPPFcylBn2TJuWCEv3ROa9MuLsOEtsgeAcFwZBjkJ+ZMMAUR0n
	 bUsVZjtsXkLVA==
Date: Thu, 13 Jun 2024 07:42:01 -0700
From: Kees Cook <kees@kernel.org>
To: Ard Biesheuvel <ardb@kernel.org>, Steven Rostedt <rostedt@goodmis.org>
CC: Mike Rapoport <rppt@kernel.org>, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>,
 linux-mm@kvack.org, Thomas Gleixner <tglx@linutronix.de>,
 Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
 Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>,
 Tony Luck <tony.luck@intel.com>,
 "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
 linux-hardening@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
 Ross Zwisler <zwisler@google.com>, wklin@google.com,
 Vineeth Remanan Pillai <vineeth@bitbyteword.org>,
 Joel Fernandes <joel@joelfernandes.org>,
 Suleiman Souhlal <suleiman@google.com>,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v3_2/2=5D_pstore/ramoops=3A_Add?=
 =?US-ASCII?Q?_ramoops=2Emem=5Fname=3D_command_line_option?=
User-Agent: K-9 Mail for Android
In-Reply-To: <CAMj1kXFGnk4vYpTk4PwUg8iYHcbXdrPaYP+OBxHrD5+=jvow+g@mail.gmail.com>
References: <20240611144911.327227285@goodmis.org> <20240611144949.703297941@goodmis.org> <202406121145.8860502D7@keescook> <20240612145228.5bf426e0@rorschach.local.home> <ZmqLejL1mblOikLp@kernel.org> <CAMj1kXHLSROujjc_OifzVmuAd7BpA+b4D2JrPGLJJYj2au7SfQ@mail.gmail.com> <20240613092642.385461d5@rorschach.local.home> <CAMj1kXFGnk4vYpTk4PwUg8iYHcbXdrPaYP+OBxHrD5+=jvow+g@mail.gmail.com>
Message-ID: <CB84A272-24F0-4526-8474-0D0CD5C5E27C@kernel.org>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



On June 13, 2024 7:06:47 AM PDT, Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>On Thu, 13 Jun 2024 at 15:26, Steven Rostedt <rostedt@goodmis=2Eorg> wrot=
e:
>>
>> On Thu, 13 Jun 2024 08:11:48 +0200
>> Ard Biesheuvel <ardb@kernel=2Eorg> wrote:
>> > >
>> > > I've added one more comment to v5, with that fixed I can take this=
=2E
>> > >
>> >
>> > So how is this supposed to work wrt to the rigid 'no user visible
>> > regressions' rule, given that this whole thing is a best effort thing
>>
>> This has nothing to do with user space=2E The kernel command line has
>> broken in the past=2E If you update the kernel, you can update the
>> command line=2E There's no "no user visible regressions" rule=2E It's
>> "Don't break user space"=2E This has nothing to do with user space=2E
>>
>> > to begin with=2E This needs at least a huge disclaimer that this rule
>> > does not apply, and if this works today, there is no guarantee that i=
t
>> > will keep working on newer kernels=2E Otherwise, you will be making t=
he
>> > job of the people who work on the boot code significantly more
>> > difficult=2E And even then, I wonder whether Linus and #regzcop are
>> > going to honour such a disclaimer=2E
>>
>> Again, this has nothing to do with user space=2E The rule Linus talks
>> about is breaking user space=2E This is about kernel debugging=2E Somet=
hing
>> *completely different*!
>>
>> >
>> > So this belongs downstream, unless some guarantees can be provided
>> > that this functionality is exempt from the usual regression policies=
=2E
>>
>> I disagree=2E kexec/kdump also has the same issues=2E
>>
>
>Fair enough=2E As long as it is documented that there is no guarantee
>that this will keep working over a kernel upgrade, then I have no
>objections=2E

Yeah, I should better document this for pstore as a whole, but I've alread=
y made the call that cross-kernel-versison operation is best effort=2E

-Kees

--=20
Kees Cook
