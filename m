Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94E2E286294;
	Tue, 18 Feb 2025 21:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739913682; cv=none; b=R6BZgjnpGer/ILjTEc52srkdGo58lbosjeAVO4C4AAW8tZlkqVa/qb6MZdNUbE/NAX0eDHPmhNFdEGZph2pqYuY4p0Ou1iJPl8m3LFz3M292QK9Y7Fr10ijZzbPYgO+Pj8UAzW0x5+bWqLaXwig9LTsr5h6du2qGUmtHCSkeDJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739913682; c=relaxed/simple;
	bh=H97NOaITxO0txt0Xyc0RqlV6PqN91lQG7cGzJqI9UGs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XkMQ+HVw9NWeB12xDYKiG5rSmXCv5w2kzXWz7kCoHMIdpXl/Fu0TGGYkUSdV/GLCaLiCaTe4dbi+simf/w9eH6u7U7xghrt9An9RuUbWnjXSitCH97cG59rS5aAuqbONntFh0FB3EJVR37z2dipx+s6eQI5KIMJKhYJFOEYRQYU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESL3MmvY; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESL3MmvY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9F8DC4CEE2;
	Tue, 18 Feb 2025 21:21:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739913682;
	bh=H97NOaITxO0txt0Xyc0RqlV6PqN91lQG7cGzJqI9UGs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ESL3MmvYejhFG0p7DiQf5UDyM672YT6+AaKwUOc+zTdVNMVU1CIdvn69zl2+T7Vl8
	 M7TUZmEhAWevPIe+IU+ARpqRHN4rc/39+TR87K2/w+kz2jm46QshdYdnqDokdauKAH
	 GFpTPNNvqqFsYdOcAT/47w9PlautlNrYhjKVwuBrXIBVhTAKzOD3puR1XdjtO+/Jma
	 CXyoIghl7CKnRQ+Sm0OTJpvhTAbFG7aow33ZZMty6Pa5x4RBpyDDNii+/Om+Bq8xlm
	 s2g55SdwjFfFqVmiFTi/EiJB+Kn6Nc6m2xTvby1+Vmk2jvCsoD2qlrMiWnGpubjaAd
	 8NhB07wQ+JsMg==
Date: Tue, 18 Feb 2025 13:21:20 -0800
From: Luis Chamberlain <mcgrof@kernel.org>
To: Steven Rostedt <rostedt@goodmis.org>
Cc: "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
	linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
	Mark Rutland <mark.rutland@arm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Petr Pavlu <petr.pavlu@suse.com>,
	Sami Tolvanen <samitolvanen@google.com>,
	Daniel Gomez <da.gomez@samsung.com>, linux-modules@vger.kernel.org
Subject: Re: [PATCH 5/8] module: Add module_for_each_mod() function
Message-ID: <Z7T50DxEL7NYkr8H@bombadil.infradead.org>
References: <20250205225031.799739376@goodmis.org>
 <20250205225103.760856859@goodmis.org>
 <20250206142817.91853f475c681bc2ef7ca962@kernel.org>
 <20250206102720.0fd57129@gandalf.local.home>
 <20250214173017.07b0b250@gandalf.local.home>
Precedence: bulk
X-Mailing-List: linux-trace-kernel@vger.kernel.org
List-Id: <linux-trace-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-trace-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-trace-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250214173017.07b0b250@gandalf.local.home>

On Fri, Feb 14, 2025 at 05:30:17PM -0500, Steven Rostedt wrote:
> On Thu, 6 Feb 2025 10:27:20 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > > BTW, do we really need to disable preempt or is it enough to call
> > > rcu_read_lock()?  
> > 
> > Bah, as I expected this function to be changed, I didn't spend too much
> > time on looking at its implementation. I just cut and pasted how the other
> > loops worked. But yes, it should not be disabling preemption. In fact, I
> > think the module code itself should not be disabling preemption!
> > 
> > I'll have to go and look into that.
> 
> It really looks like it requires preempt_disable(), as the code in
> kernel/module/main.c has in several places:
> 
> 	preempt_disable();
> 
> 	list_for_each_entry_rcu(mod, &modules, list) {
> 		[..]
> 	}
> 
> 	preempt_enable();
> 
> Or
> 
> 	module_assert_mutex_or_preempt();
> 
> 	[..]
> 
> 	list_for_each_entry_rcu(mod, &modules, list,
> 				lockdep_is_held(&module_mutex)) {
> 
> 
> So it looks like it either requires preempt_disable or holding the
> module_mutex.
> 
> As I need to call this with trace_types_lock held, and there's a place
> where trace_types_lock is within a module callback, I don't think it's safe
> to take that lock in that loop, otherwise we have the ABBA deadlock.
> 
> Luis,
> 
> Is this patch OK, and also is there any plan to move the module code to
> using just rcu_read_lock instead of preempt_disable?

The patch is not OK, you're looking at old code, look at
modules-next and as Petr suggested look at Sebastian's recently
merged work.

git remote add korg-modules git://git.kernel.org/pub/scm/linux/kernel/git/modules/linux.git

  Luis
