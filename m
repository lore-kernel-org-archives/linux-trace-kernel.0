Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62431946C;
	Mon,  7 Jul 2025 11:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751889006; cv=none; b=fOlQS4JEpcG+vQGLP1MkRQNZVfq68hGChAxfitidX4F+4yAr/CgXNL7k/D0aHJBdL+1GJIeTn79Zrv545K8wLv+6eNoAMt0lnOzCl3sBY0w+/f0S87Vh2dHmDuK4aUeLV9WTJujMoh8IYRzyKpdNDFjUnaD+/LmnLfKdH5lz23A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751889006; c=relaxed/simple;
	bh=gMlTu9+xpafBOmuhtK1ioviaKSGzsyQjs0ZPKAH3vHE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5VfhY8Shz/IzToIiT/7RwC1eqGFju9DztskRAlps0pX1V+Ezifkl+SPpRGTki0vXTGMLFBQZrvOEJ+R7Tmg/2m/JAhYxGT0WClssxXTQ2vUVfbairtwtKRBDuSDidvYWk1/UAiEIzK0LAHwBT37Qs97QvCEd/rtu8KDukl2hXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AQnc7yKN; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AQnc7yKN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 727DEC4CEE3;
	Mon,  7 Jul 2025 11:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751889005;
	bh=gMlTu9+xpafBOmuhtK1ioviaKSGzsyQjs0ZPKAH3vHE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AQnc7yKNW3i8pmak2bYHKx2Cz85ciohsohKN9pxII2y9lEWftE7WydnybBVfZbIad
	 INSkrf1uXq4CXyCWssKQEyW4K+HeEfwpUu059CUl4epfcb3RFELY+9g4TI5J/iEoyq
	 lGMwEGBfUidqbLh87sxYEXp/waMNBs7XCaeR0yghvuco4KQDF2WUUJlRpNFWYphEhV
	 Vc3DBNvJSS1XcyK7n8TnqH8X0zTcrsnvH3/9mg8H3LeOcaO1Xavw1t9xSzgGQ27jeS
	 FLirz73cArp1zZ9eEA5vf6TRtDA2vz59Muxcjjpd8+OGLRVB/EHazahnfmDhH6n98h
	 aLX0DWT5F92ug==
Date: Mon, 7 Jul 2025 14:49:54 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
	Daniel Gomez <da.gomez@samsung.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Ingo Molnar <mingo@redhat.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-modules@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org, x86@kernel.org
Subject: Re: [PATCH 1/8] execmem: drop unused execmem_update_copy()
Message-ID: <aGu0Yj08EZvpL5Xv@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-2-rppt@kernel.org>
 <7e52f721-1d8e-4c50-af33-bee3f0d2ac6e@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7e52f721-1d8e-4c50-af33-bee3f0d2ac6e@csgroup.eu>

On Mon, Jul 07, 2025 at 12:10:43PM +0200, Christophe Leroy wrote:
> 
> Le 04/07/2025 à 15:49, Mike Rapoport a écrit :
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > The execmem_update_copy() that used text poking was required when memory
> > allocated from ROX cache was always read-only. Since now its permissions
> > can be switched to read-write there is no need in a function that updates
> > memory with text poking.
> 
> Erm. Looks like I missed the patch that introduced this change.
> 
> On some variant of powerpc, namely book3s/32, this is not feasible.

The only user of EXECMEM_ROX_CACHE for now is x86-64, we can always revisit
when powerpc book3s/32 would want to opt in to cache usage.

And it seems that [MODULES_VADDR, MODULES_END] is already mapped with
"large pages", isn't it?

> The granularity for setting the NX (non exec) bit is 256 Mbytes sections.
> So the area dedicated to execmem [MODULES_VADDR; MODULES_END[ always have
> the NX bit unset.
> 
> You can change any page within this area from ROX to RWX but you can't make
> it RW without X. If you want RW without X you must map it in the VMALLOC
> area, as VMALLOC area have NX bit always set.

So what will happen when one callse

	set_memory_nx()
	set_memory_rw()

in such areas?

> Christophe

-- 
Sincerely yours,
Mike.
