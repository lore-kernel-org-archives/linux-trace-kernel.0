Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC499476;
	Thu, 13 Jun 2024 14:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718287621; cv=none; b=WtpfHOGibS9jz0Vcrj8Kmdl9pgV+1Gd8ZabC+CPOtKfZsDAB69p3e+G8FnTohrv3u7GmqBLX3oDiIyMpjXgA9YLcmJIZwYY1kjCf+AL9Orfmoe0jwntbX1dO3i4J9n3Oz+4raPQDd87jlpiwzRu9aLxS+p9RE4TKaDmEyv3EgCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718287621; c=relaxed/simple;
	bh=aZq6PN49zE6/crz+f03BWODsiATPJSnT/GYXKHLLVW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZG/d0x4jx5rkC9xAmj6jWQz0o6GrUPb3LEf/PYAnL3+a6BYi0TCO04CjaLmexQkwqCg8aLzxyD1PgFm8TqQYAWLe/5XD9/ONOv8ukXVc1FGlGV1bwEqW9fPuyC7pjQ++CpD5ko7tvgj+RQJ8B8fXyLl0360tE7DgPqwyR4dz/54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgUp09eo; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgUp09eo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FBDDC4AF55;
	Thu, 13 Jun 2024 14:07:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718287620;
	bh=aZq6PN49zE6/crz+f03BWODsiATPJSnT/GYXKHLLVW8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=mgUp09eoHFNiC+e40Sdlx+wV86u6mq28RsjWv5yqW22xAYuD2V4ef6X2PqBlt5Pjx
	 TAzzT6h4NAeWiW/TE4Gkt11NQs6odaT0AY0/uvykvzEV31/hGUMlnXaoknHbYWvVle
	 zgBAtmbLLg6iuO+MBqgMmcg9akpbcF2BjvAWNq9y/RbUYe0PsoabxSlI1/xzP7sdpM
	 D6AQ6C37jNSgmrBzdLlgGcsv8HpLmo2VC5zNv30Sh4hojY8tRvzdDehAFWbIJUNB1m
	 muhNxpK/NW3yGnVd2dz7sV4/7fLicjxg01bzfKeyuV4LgnQTKFys5rgLjUDGNokCaM
	 UmKr9iYpm+zIw==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-52c8342af5eso1217145e87.3;
        Thu, 13 Jun 2024 07:07:00 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVZDSxBs8cpr9vIV/+LxVwCgZdYNMH+ouZKaMY0oANjs/RRbQD/Ss/rt7FbkasCq85gx0CTj8lNKX06ZopWVIMK/gM4Yjr1xOr1Vhb9rTiHHJc3fJB8uuRqaT8Fa/7+hlh5IqOt+pJk9inFJh3o+CZbeAc7RZ/klNsst+qUhspb/z7vyT+Kg/mqO5x7GyJ8XCI/
X-Gm-Message-State: AOJu0YxPlHytryftSagwZnxuazqW9sst3omR87cTtu1U2DqsdCOqYVxe
	HV4zNvIVi/ino2PFwsx65XePNcL4EdqHtnPE6+N78Cy8YhXTE3Bb24k+AcOmnzvygXIPcti3x77
	ok47daMhAOZK9ikv2fwReBV95Np4=
X-Google-Smtp-Source: AGHT+IF9eAs9Xa9DMTH+FguZcJhTpSg8shwf78TXAXIjRoDacPdfR5OXqtb6KahPz38tlgl4i+ur9hrZoV4xDfDGqZ4=
X-Received: by 2002:a05:6512:3f10:b0:529:b632:ae4e with SMTP id
 2adb3069b0e04-52c9a3b7b34mr3721460e87.2.1718287618656; Thu, 13 Jun 2024
 07:06:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240611144911.327227285@goodmis.org> <20240611144949.703297941@goodmis.org>
 <202406121145.8860502D7@keescook> <20240612145228.5bf426e0@rorschach.local.home>
 <ZmqLejL1mblOikLp@kernel.org> <CAMj1kXHLSROujjc_OifzVmuAd7BpA+b4D2JrPGLJJYj2au7SfQ@mail.gmail.com>
 <20240613092642.385461d5@rorschach.local.home>
In-Reply-To: <20240613092642.385461d5@rorschach.local.home>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Jun 2024 16:06:47 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFGnk4vYpTk4PwUg8iYHcbXdrPaYP+OBxHrD5+=jvow+g@mail.gmail.com>
Message-ID: <CAMj1kXFGnk4vYpTk4PwUg8iYHcbXdrPaYP+OBxHrD5+=jvow+g@mail.gmail.com>
Subject: Re: [PATCH v3 2/2] pstore/ramoops: Add ramoops.mem_name= command line option
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Mike Rapoport <rppt@kernel.org>, Kees Cook <kees@kernel.org>, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, Masami Hiramatsu <mhiramat@kernel.org>, 
	Mark Rutland <mark.rutland@arm.com>, Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
	Andrew Morton <akpm@linux-foundation.org>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org, 
	Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Tony Luck <tony.luck@intel.com>, 
	"Guilherme G. Piccoli" <gpiccoli@igalia.com>, linux-hardening@vger.kernel.org, 
	Guenter Roeck <linux@roeck-us.net>, Ross Zwisler <zwisler@google.com>, wklin@google.com, 
	Vineeth Remanan Pillai <vineeth@bitbyteword.org>, Joel Fernandes <joel@joelfernandes.org>, 
	Suleiman Souhlal <suleiman@google.com>, Linus Torvalds <torvalds@linuxfoundation.org>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 13 Jun 2024 at 15:26, Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Thu, 13 Jun 2024 08:11:48 +0200
> Ard Biesheuvel <ardb@kernel.org> wrote:
> > >
> > > I've added one more comment to v5, with that fixed I can take this.
> > >
> >
> > So how is this supposed to work wrt to the rigid 'no user visible
> > regressions' rule, given that this whole thing is a best effort thing
>
> This has nothing to do with user space. The kernel command line has
> broken in the past. If you update the kernel, you can update the
> command line. There's no "no user visible regressions" rule. It's
> "Don't break user space". This has nothing to do with user space.
>
> > to begin with. This needs at least a huge disclaimer that this rule
> > does not apply, and if this works today, there is no guarantee that it
> > will keep working on newer kernels. Otherwise, you will be making the
> > job of the people who work on the boot code significantly more
> > difficult. And even then, I wonder whether Linus and #regzcop are
> > going to honour such a disclaimer.
>
> Again, this has nothing to do with user space. The rule Linus talks
> about is breaking user space. This is about kernel debugging. Something
> *completely different*!
>
> >
> > So this belongs downstream, unless some guarantees can be provided
> > that this functionality is exempt from the usual regression policies.
>
> I disagree. kexec/kdump also has the same issues.
>

Fair enough. As long as it is documented that there is no guarantee
that this will keep working over a kernel upgrade, then I have no
objections.
