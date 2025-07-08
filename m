Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF9D223DC6;
	Tue,  8 Jul 2025 08:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751962967; cv=none; b=ZFHdi8BM+3xqL0FrFemib3fOyjNeW/MD1YACCes4JDz+WFzBaHmdIoOslrf9pLXkSdTOK/Vs5sIXbcHzty7wplm8uEDwfmcEODclL2mtYoRZyCzsUc9BhbtOPKHFIWaWZ8rYGu4+AY4HXborhQ5A7DXTV13sUzp+xTDFeKlGjEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751962967; c=relaxed/simple;
	bh=oRwqOe1brAYvYekojKVNvxAmK4Lubg+YWxdejVSPic8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OXl7plU1n/u675mmJt/PKMDv805jR03S5DFTcjfk72pD/T/stXmCSiRv328NKiuq33XybvxNfURrQoXVTjobpKYCqQ25q/uGY3zpVlsQ5WHKCQ8zUslppZodi+UpS82Tp4JPk/WsnhdN2YGagqPPwxmM2jDa7goL2/rXTgV5+8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u5arvs8f; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u5arvs8f"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9065C4CEF0;
	Tue,  8 Jul 2025 08:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751962966;
	bh=oRwqOe1brAYvYekojKVNvxAmK4Lubg+YWxdejVSPic8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u5arvs8fUGa2VSSCCCZx+qpZf75PEDkfi/z0yr7IfzJRPNZ+Dv8qZa9/AmQiF15xA
	 VZFsERmwXeI2iXyxDcdvbS5uM7Mb1rHNs2UyVpQJgTLP6Xmb/VmNlFhACZuYJZxvx5
	 xgnJpeI4vR1D2QlyjmJGtqPkXK4hfZwAQt+ekDYlz2OQaawYMFKxwqtDOKabBE/E1C
	 TbjFUsJsSMLvgtMr2mXGwb2UrjFB6SnEd2jYHgM+qmNivLYnOktUUB+JgCSeAsCVYn
	 /E/v4Qjo+poQCiUa01PnM53uioAU2+QpmJAOfHjsCmyG+Pkub7MQeuBuuQ+hdVk6fz
	 a8dQTTNzqW/dg==
Date: Tue, 8 Jul 2025 11:22:37 +0300
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
Message-ID: <aGzVTdfBU_SO7ss9@kernel.org>
References: <20250704134943.3524829-1-rppt@kernel.org>
 <20250704134943.3524829-2-rppt@kernel.org>
 <7e52f721-1d8e-4c50-af33-bee3f0d2ac6e@csgroup.eu>
 <aGu0Yj08EZvpL5Xv@kernel.org>
 <2ea9c28f-c3d1-4837-b000-10eccaa2775b@csgroup.eu>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2ea9c28f-c3d1-4837-b000-10eccaa2775b@csgroup.eu>

On Mon, Jul 07, 2025 at 03:02:15PM +0200, Christophe Leroy wrote:
> 
> 
> Le 07/07/2025 à 13:49, Mike Rapoport a écrit :
> > On Mon, Jul 07, 2025 at 12:10:43PM +0200, Christophe Leroy wrote:
> > > 
> > > Le 04/07/2025 à 15:49, Mike Rapoport a écrit :
> > > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > > 
> > > > The execmem_update_copy() that used text poking was required when memory
> > > > allocated from ROX cache was always read-only. Since now its permissions
> > > > can be switched to read-write there is no need in a function that updates
> > > > memory with text poking.
> > > 
> > > Erm. Looks like I missed the patch that introduced this change.
> > > 
> > > On some variant of powerpc, namely book3s/32, this is not feasible.
> > 
> > The only user of EXECMEM_ROX_CACHE for now is x86-64, we can always revisit
> > when powerpc book3s/32 would want to opt in to cache usage.
> > 
> > And it seems that [MODULES_VADDR, MODULES_END] is already mapped with
> > "large pages", isn't it?
> 
> I don't think so. It uses execmem_alloc() which sets VM_ALLOW_HUGE_VMAP only
> when using EXECMEM_ROX_CACHE. And book3s/32 doesn't have large pages.
> 
> Only 8xx has large pages but they are not PMD aligned (PMD_SIZE is 4M while
> large pages are 512k and 8M) so it wouldn't work well with existing
> execmem_vmalloc().
 
The PMD_SIZE can be replaced with one of arch_vmap size helpers if needed. 
Or even parametrized in execmem_info.
 
> > > The granularity for setting the NX (non exec) bit is 256 Mbytes sections.
> > > So the area dedicated to execmem [MODULES_VADDR; MODULES_END[ always have
> > > the NX bit unset.
> > > 
> > > You can change any page within this area from ROX to RWX but you can't make
> > > it RW without X. If you want RW without X you must map it in the VMALLOC
> > > area, as VMALLOC area have NX bit always set.
> > 
> > So what will happen when one callse
> > 
> > 	set_memory_nx()
> > 	set_memory_rw()
> > 
> > in such areas?
> 
> Nothing will happen. It will successfully unset the X bit on the PTE but
> that will be ignored by the HW which only relies on the segment's NX bit
> which is set for the entire VMALLOC area and unset for the entire MODULE
> area.

And set_memory_rw() will essentially make the mapping RWX if it's in MODULE
area?
 
> Christophe
> 

-- 
Sincerely yours,
Mike.
